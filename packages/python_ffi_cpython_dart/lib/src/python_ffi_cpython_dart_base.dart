part of python_ffi_cpython_dart;

/// Base class for the macOS and Windows implementation of [PythonFfiDelegate].
///
/// This is shared between the pure Dart and Flutter implementations.
abstract base class PythonFfiCPythonBase
    extends PythonFfiDelegate<Pointer<PyObject>> {
  final Set<PythonModuleDefinition> _pythonModules = <PythonModuleDefinition>{};

  /// The [DartPythonCBindings] used to call into the Python C API.
  DartPythonCBindings get bindings;

  set bindings(DartPythonCBindings bindings);

  /// Used to find a suitable location for the Python source files.
  FutureOr<Directory> getApplicationSupportDirectory();

  /// Loads a Python module from either the embedded Python source files (in
  /// pure Dart apps) or from Flutter assets.
  FutureOr<ByteData> loadPythonFile(PythonSourceFileEntity sourceFile);

  /// Opens the Python dylib.
  ///
  /// This is called by [PythonFfiDelegate.initialize].
  Future<void> openDylib();
}

// ignore: comment_references
/// The macOS and Windows implementation of [PythonFfiDelegate].
final class PythonFfiCPythonDart extends PythonFfiCPythonBase
    with PythonFfiCPythonMixin {
  /// Creates a new [PythonFfiCPythonDart] instance.
  PythonFfiCPythonDart(
    String pythonModulesBase64, {
    String? libPath,
  }) : _libPath = libPath ?? _defaultLibPath {
    _pythonModules.addAll(_decodePythonModules(pythonModulesBase64));
  }

  static String get _defaultLibPath {
    final String version = "3.11";
    if (Platform.isMacOS) {
      return "/Library/Frameworks/Python.framework/Versions/$version/Python";
    }
    if (Platform.isWindows) {
      return "python311.dll";
    }
    if (Platform.isLinux) {
      return "libpython$version.so";
    }
    throw Exception("Unsupported platform: ${Platform.operatingSystem}");
  }

  final String _libPath;

  @override
  Future<void> openDylib() async {
    String effectiveLibPath = _libPath;
    if ((Platform.isWindows || Platform.isLinux) &&
        _libPath == _defaultLibPath) {
      final Directory supportDir = getApplicationSupportDirectory();
      final File dllFile = File("${supportDir.path}/$_defaultLibPath");
      late final String dllSource;
      if (Platform.isWindows) {
        dllSource = _kPython311Dll;
      } else if (Platform.isLinux) {
        dllSource = _kLibPython311SO;
      }
      if (!dllFile.existsSync()) {
        final Uint8List dllBytes = base64Decode(dllSource);
        await dllFile.writeAsBytes(dllBytes, flush: true);
      }
      effectiveLibPath = dllFile.path;
    }
    final DynamicLibrary dylib = DynamicLibrary.open(effectiveLibPath);
    bindings = DartPythonCBindings(dylib);
  }

  static Pair<PythonSourceEntity, PythonSourceFileEntity?>
      _decodePythonSourceEntity(
    Map<String, dynamic> data,
  ) {
    if (data.keys.contains("children")) {
      final SourceDirectory entity = SourceDirectory(data["name"] as String);
      PythonSourceFileEntity? licenseFile;
      for (final Object? child in data["children"] as List<Object?>) {
        if (child is! Map<String, dynamic>) {
          print("Unexpected child type: $child");
          continue;
        }
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
    if (sourceFile is SourceBase64) {
      return ByteData.view(base64Decode(sourceFile.base64).buffer);
    }
    throw Exception("Unsupported source file type: $sourceFile");
  }

  @override
  Set<PythonModuleDefinition> discoverPythonModules() => _pythonModules;
}

/// Mixin for the macOS and Windows implementation of [PythonFfiDelegate].
///
/// This is shared between the pure Dart and Flutter implementations.
base mixin PythonFfiCPythonMixin on PythonFfiCPythonBase {
  /// A handle to the Python C-bindings.
  DartPythonCBindings? _bindings;

  @override
  DartPythonCBindings get bindings {
    final DartPythonCBindings? bindings = _bindings;
    if (bindings == null) {
      throw Exception("PythonFfiCPython not initialized");
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

  @override
  Future<void> initialize() async {
    if (!areBindingsInitialized) {
      await openDylib();
    }

    bindings.Py_Initialize();

    appendToPath((await packagesDir).path);

    // clear modules cache
    if ((await packagesDir).existsSync()) {
      (await packagesDir).deleteSync(recursive: true);
    }

    // load modules
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
      throw _PythonExceptionCPython.fetch(this);
    }
  }

  @override
  PythonModuleInterface<PythonFfiDelegate<Pointer<PyObject>>, Pointer<PyObject>>
      importModule(String moduleName) {
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
      if (pythonErrorOccurred()) {
        pythonErrorPrint();
      }
      throw PythonFfiException("Failed to import module $moduleName");
    }

    final _PythonModuleCPython module = _PythonModuleCPython(this, pyImport);

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
  ]) =>
          importModule(moduleName).getClass(className, args, kwargs);

  @override
  void appendToPath(String path) {
    final _PythonObjectCPython sysPath =
        importModule("sys").getAttributeRaw("path");

    final _PythonObjectCPython pathObject = path._toPythonObject(this);

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
