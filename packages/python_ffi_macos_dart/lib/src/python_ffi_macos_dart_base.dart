// TODO: Put public facing types in this file.
part of python_ffi_macos_dart;

abstract class PythonFfiMacOSBase extends PythonFfiDelegate<Pointer<PyObject>> {
  final Set<PythonModuleDefinition> _pythonModules = <PythonModuleDefinition>{};

  DartPythonCBindings get bindings;

  set bindings(DartPythonCBindings bindings);

  FutureOr<Directory> getApplicationSupportDirectory();

  FutureOr<ByteData> loadPythonFile(PythonSourceFileEntity sourceFile);

  Future<void> openDylib();
}

// ignore: comment_references
/// The macOS implementation of [PythonFfiDelegate].
class PythonFfiMacOSDart extends PythonFfiMacOSBase with PythonFfiMacOSMixin {
  PythonFfiMacOSDart(
    String pythonModulesBase64, {
    String? libPath,
  }) : _libPath = libPath ??
            "/Library/Frameworks/Python.framework/Versions/3.11/Python" {
    _pythonModules.addAll(_decodePythonModules(pythonModulesBase64));
  }

  final String _libPath;

  @override
  Future<void> openDylib() async {
    final DynamicLibrary dylib = DynamicLibrary.open(_libPath);
    bindings = DartPythonCBindings(dylib);
  }

  static Pair<PythonSourceEntity, PythonSourceFileEntity?>
      _decodePythonSourceEntity(
    Map<String, dynamic> data,
  ) {
    if (data.keys.contains("children")) {
      final SourceDirectory entity = SourceDirectory(data["name"] as String);
      PythonSourceFileEntity? licenseFile;
      for (final Map<String, dynamic> child
          in data["children"] as List<Map<String, dynamic>>) {
        if (child["name"] == "LICENSE.txt") {
          licenseFile =
              SourceBase64(child["name"] as String, child["base64"] as String);
          continue;
        }
        final Pair<PythonSourceEntity, PythonSourceFileEntity?> result =
            _decodePythonSourceEntity(child);
        licenseFile ??= result.second;
        entity.add(result.first);
      }
      return Pair<PythonSourceEntity, PythonSourceFileEntity?>(
        entity,
        licenseFile,
      );
    } else {
      return Pair<PythonSourceEntity, PythonSourceFileEntity?>(
        SourceBase64(data["name"] as String, data["base64"] as String),
        null,
      );
    }
  }

  static Iterable<PythonModuleDefinition> _decodePythonModules(
    String pythonModulesBase64,
  ) sync* {
    final String pythonModulesRaw =
        utf8.decode(base64Decode(pythonModulesBase64));
    final Map<String, dynamic> pythonModulesJson =
        jsonDecode(pythonModulesRaw) as Map<String, dynamic>;
    for (final MapEntry<String, dynamic> entry in pythonModulesJson.entries) {
      final String moduleName = entry.key;
      final Map<String, dynamic> moduleJson =
          entry.value as Map<String, dynamic>;
      final Map<String, dynamic> root =
          moduleJson["root"] as Map<String, dynamic>;
      final Pair<PythonSourceEntity, PythonSourceFileEntity?> result =
          _decodePythonSourceEntity(root);
      yield PythonModuleDefinition(
        name: moduleName,
        root: result.first,
        license: result.second,
      );
    }
  }

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

  @override
  Set<PythonModuleDefinition> discoverPythonModules() => _pythonModules;
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

  @override
  set bindings(DartPythonCBindings bindings) => _bindings = bindings;

  Directory? _supportDir;

  /// Directory for application support files
  FutureOr<Directory> get supportDir async =>
      _supportDir ??= await getApplicationSupportDirectory();

  Directory? _packagesDir;

  /// Directory for all bundled Python packages
  FutureOr<Directory> get packagesDir async => _packagesDir ??= Directory(
        "${(await supportDir).path}/python_ffi/packages",
      );

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

  @override
  Future<void> initialize() async {
    if (!areBindingsInitialized) {
      await openDylib();
    }

    bindings.Py_Initialize();

    appendToPath((await packagesDir).path);

    final Set<PythonModuleDefinition> modules = await discoverPythonModules();
    await FutureOrExtension.wait<void>(modules.map(prepareModule));
  }

  Future<void> _copyModuleFile(PythonSourceFileEntity sourceFile) async {
    final String filePath = sourceFile.name;
    final File moduleFile = File("${(await packagesDir).path}/$filePath");
    if (!moduleFile.existsSync()) {
      moduleFile.createSync(recursive: true);
    }

    final ByteData moduleAsset = await loadPythonFile(sourceFile);
    await moduleFile.writeAsBytes(moduleAsset.buffer.asUint8List());
  }

  @override
  FutureOr<void> prepareModule(PythonModuleDefinition moduleDefinition) async {
    final List<Future<void>> copyTasks = <Future<void>>[];

    for (final PythonSourceFileEntity sourceFile
        in moduleDefinition.sourceFiles) {
      copyTasks.add(_copyModuleFile(sourceFile));
    }

    await Future.wait(copyTasks);
  }

  @override
  bool pythonErrorOccurred() => bindings.PyErr_Occurred() != nullptr;

  @override
  void pythonErrorPrint() => bindings.PyErr_Print();

  @override
  void pythonErrorClear() => bindings.PyErr_Clear();

  @override
  void ensureNoPythonError() {
    if (pythonErrorOccurred()) {
      throw _PythonExceptionMacos.fetch(this);
    }
  }

  @override
  PythonModuleMacos importModule(String moduleName) {
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

    if (result != 0) {
      if (pythonErrorOccurred()) {
        pythonErrorPrint();
      }

      throw PythonFfiException("Failed to append $path to sys.path");
    }
  }
}
