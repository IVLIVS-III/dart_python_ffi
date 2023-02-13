// TODO: Put public facing types in this file.
part of python_ffi_macos_dart;

abstract class PythonFfiMacOSBase extends PythonFfiDelegate<Pointer<PyObject>> {
  DartPythonCBindings get bindings;

  UnmodifiableSetView<String> get classNames;

  void disposeModule(PythonModuleMacos module);

  FutureOr<Directory> getApplicationSupportDirectory();

  FutureOr<ByteData> loadPythonFile(PythonSourceFileEntity sourceFile);
}

/// The macOS implementation of [PythonFfiPlatform].
class PythonFfiMacOSDart extends PythonFfiMacOSBase with PythonFfiMacOSMixin {
  @override
  Directory getApplicationSupportDirectory() => Directory.systemTemp;

  @override
  ByteData loadPythonFile(PythonSourceFileEntity sourceFile) {
    if (sourceFile is SourceBytes) {
      return ByteData.view(sourceFile.bytes.buffer);
    } else if (sourceFile is SourceBase64) {
      return ByteData.view(base64Decode(sourceFile.base64).buffer);
    }
    throw Exception("Unsupported source file type: $sourceFile");
  }
}

mixin PythonFfiMacOSMixin on PythonFfiMacOSBase {
  /// A handle to the Python C-bindings.
  DartPythonCBindings? _bindings;

  @override
  DartPythonCBindings get bindings {
    final DartPythonCBindings? bindings = _bindings;
    if (bindings == null) {
      throw Exception("PythonFfiMacOS not initialized");
    }
    return bindings;
  }

  final Map<String, PythonModuleMacos> _modules = <String, PythonModuleMacos>{};

  Directory? _supportDir;

  /// Directory for application support files
  FutureOr<Directory> get supportDir async =>
      _supportDir ??= await getApplicationSupportDirectory();

  Directory? _packagesDir;

  /// Directory for all bundled Python packages
  FutureOr<Directory> get packagesDir async => _packagesDir ??= Directory(
        "${(await supportDir).path}/python_ffi/packages",
      );

  final Set<String> _classNames = <String>{};

  @override
  UnmodifiableSetView<String> get classNames =>
      UnmodifiableSetView<String>(_classNames);

  /// Checks whether the Python C-bindings are available
  bool get areBindingsInitialized => _bindings != null;

  /// Checks whether the Python runtime was initialized
  @override
  bool get isInitialized =>
      areBindingsInitialized && bindings.Py_IsInitialized() != 0;

  // TODO: resolve this
  // Attempt to bundle the python library with the app via flutter assets.
/*
  Future<String> _copyDylib() async {
    final File dylibFile =
        File("${(await supportDir).path}/python_ffi/$_libName.dylib");
    if (!dylibFile.existsSync()) {
      dylibFile.createSync(recursive: true);
    }

    final ByteData dylibAsset = await PlatformAssetBundle()
        .load("packages/python_ffi_macos/assets/$_libName.dylib");
    await dylibFile.writeAsBytes(dylibAsset.buffer.asUint8List());

    debugPrint("Copied dylib $_libName to ${dylibFile.path}");

    return dylibFile.path;
  }
  */

  Future<void> _openDylib() async {
// final String dylibPath = await _copyDylib();
    final DynamicLibrary dylib = DynamicLibrary.open(_libPath);
    _bindings = DartPythonCBindings(dylib);
  }

  @override
  Future<void> initialize() async {
    if (!areBindingsInitialized) {
      await _openDylib();
    }

    bindings.Py_Initialize();

    appendToPath((await packagesDir).path);
  }

  Future<void> _copyModuleFile(PythonSourceFileEntity sourceFile) async {
    final String filePath = sourceFile.name;
    final File moduleFile = File("${(await packagesDir).path}/$filePath");
    if (!moduleFile.existsSync()) {
      moduleFile.createSync(recursive: true);
    }

    final ByteData moduleAsset = await loadPythonFile(sourceFile);
    await moduleFile.writeAsBytes(moduleAsset.buffer.asUint8List());

    print("Copied module file $filePath to ${moduleFile.path}");
  }

  @override
  FutureOr<void> prepareModule(PythonModuleDefinition moduleDefinition) async {
    final List<Future<void>> copyTasks = <Future<void>>[];

    for (final PythonSourceFileEntity sourceFile
        in moduleDefinition.sourceFiles) {
      copyTasks.add(_copyModuleFile(sourceFile));
    }

    await Future.wait(copyTasks);

    print("==> Copied module ${moduleDefinition.name}");
  }

  @override
  void disposeModule(PythonModuleMacos module) {
    _modules.removeWhere((_, PythonModuleMacos value) => value == module);
  }

  @override
  void addClassName(String className) {
    _classNames.add(className);
  }

  @override
  void removeClassName(String className) {
    _classNames.remove(className);
  }

  @override
  bool pythonErrorOccurred() => bindings.PyErr_Occurred() != nullptr;

  @override
  void pythonErrorPrint() => bindings.PyErr_Print();

  @override
  void ensureNoPythonError() {
    if (pythonErrorOccurred()) {
      throw _PythonExceptionMacos.fetch(this);
    }
  }

  @override
  PythonModuleMacos importModule(String moduleName) {
    final PythonModuleMacos? cachedModule = _modules[moduleName];
    if (cachedModule != null) {
      bindings.Py_IncRef(cachedModule.reference);
      return cachedModule;
    }

    // convert the module name to a Python string
    final Pointer<PyObject> pythonModuleName =
        moduleName.toNativeUtf8().useAndFree((Pointer<Utf8> pointer) {
      final Pointer<Char> charPointer = pointer.cast<Char>();
      final Pointer<PyObject> result =
          bindings.PyUnicode_DecodeFSDefault(charPointer);
      return result;
    });
    if (pythonModuleName == nullptr) {
      throw PythonFfiException("Failed to convert module name $moduleName");
    }

    // import the module
    final Pointer<PyObject> pyImport =
        bindings.PyImport_Import(pythonModuleName);

    // decrease the reference count of the module name,
    // since we no longer need access to this string
    bindings.Py_DecRef(pythonModuleName);

    if (pyImport == nullptr) {
      throw PythonFfiException("Failed to import module $moduleName");
    }

    final PythonModuleMacos module = PythonModuleMacos(this, pyImport);
    _modules[moduleName] = module;

    if (pythonErrorOccurred()) {
      pythonErrorPrint();
      throw PythonFfiException("Failed to import module $moduleName");
    }

    return module;
  }

  @override
  PythonClassInterface<PythonFfiDelegate<Pointer<PyObject>>, Pointer<PyObject>>
      importClass(
    String moduleName,
    String className,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) {
    final PythonModuleMacos module = importModule(moduleName);
    final PythonClassMacos classInstance =
        module.getClass(className, args, kwargs);
    return classInstance;
  }

  @override
  void appendToPath(String path) {
    final PythonModuleMacos sys = importModule("sys");
    final _PythonObjectMacos sysPath = sys.getAttributeRaw("path");

    final _PythonObjectMacos pathObject = path._toPythonObject(this);

    final int result =
        bindings.PyList_Append(sysPath.reference, pathObject.reference);

    // decrease the reference count of sys.path,
    // since we no longer need access to this attribute
    sysPath.dispose();

    // unload the sys module again
    sys.dispose();

    if (result != 0) {
      pathObject.dispose();

      if (pythonErrorOccurred()) {
        pythonErrorPrint();
      }

      throw PythonFfiException("Failed to append $path to sys.path");
    }
  }
}
