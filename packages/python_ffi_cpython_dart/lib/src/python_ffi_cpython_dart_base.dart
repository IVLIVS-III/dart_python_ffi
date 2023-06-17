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

  /// Extracts the Python stdlib files from the app bundle.
  Future<void> extractPythonStdLibZip(File zipFile);

  /// Fetches and extracts the Python stdlib files from the app bundle.
  ///
  /// Note: Any implementation should call [extractPythonStdLibZip] to extract
  ///       the Python stdlib files.
  Future<void> copyPythonStdLib();

  /// Opens the Python dylib.
  ///
  /// This is called by [PythonFfiDelegate.initialize].
  Future<void> openDylib();
}

// ignore: comment_references
/// The macOS, Windows and Linux implementation of [PythonFfiDelegate].
final class PythonFfiCPythonDart extends PythonFfiCPythonBase
    with PythonFfiCPythonMixin {
  /// Creates a new [PythonFfiCPythonDart] instance.
  ///
  /// Note: On Windows and Linux the path to the dynamic Python library must be
  ///       provided via the [libPath] parameter.
  PythonFfiCPythonDart(
    String pythonModulesBase64, {
    this.libPath,
  }) {
    _pythonModules.addAll(_decodePythonModules(pythonModulesBase64));
  }

  static const String _majorVersion = "3";
  static const String _minorVersion = "11";
  static const String _patchVersion = "3";

  /// The version of the Python C API bundled with this package.
  static const String version = "$_majorVersion.$_minorVersion";

  static const String _fullVersion = "$version.$_patchVersion";

  Directory? _cacheDir;

  /// Directory for cached Python runtimes
  FutureOr<Directory> get cacheDir async => _cacheDir ??= Directory(
        "${(await pythonFfiDir).path}/cache",
      );

  FutureOr<String> get _defaultLibPath {
    if (Platform.isWindows || Platform.isLinux) {
      throw PythonFfiException(
        "libPath must be provided on ${Platform.operatingSystem}",
      );
    }
    if (Platform.isMacOS) {
      return cacheDir
          .then((Directory dir) => "${dir.path}/libpython$version.dylib");
    }
    /*
    if (Platform.isLinux) {
      return cacheDir
          .then((Directory dir) => "${dir.path}/libpython$version.so");
    }
    if (Platform.isWindows) {
      return cacheDir.then(
        (Directory dir) =>
            "${dir.path}/python${version.replaceAll(".", "")}.dll",
      );
    }
    */
    throw Exception("Unsupported platform: ${Platform.operatingSystem}");
  }

  /// The path to the Python dynamic library.
  ///
  /// If this is null, then a default library will be used, which might need to
  /// be (automatically) downloaded first.
  final String? libPath;

  @override
  Future<void> copyPythonStdLib() async {
    await _ensurePythonStdlib();
    final File zipFile = File("${(await cacheDir).path}/python$version.zip");
    await extractPythonStdLibZip(zipFile);
  }

  @override
  Future<void> openDylib() async {
    final String? libPath = this.libPath;
    if (libPath == null) {
      await _ensurePythonRuntime();
    }
    final DynamicLibrary dylib =
        DynamicLibrary.open(libPath ?? await _defaultLibPath);
    bindings = DartPythonCBindings(dylib);
  }

  Future<void> _ensurePythonStdlib() async {
    final Directory cacheDir = await this.cacheDir;
    final _StdLibCache cache = _StdLibCache(
      version: version,
      cacheDir: cacheDir,
    );
    final bool cached = await cache.ensure();
    if (!cached) {
      throw PythonFfiException(
        "Failed to cache Python stdlib for version $version on ${Platform.operatingSystem}",
      );
    }
  }

  Future<void> _ensurePythonRuntime() async {
    final Directory cacheDir = await this.cacheDir;
    final _DylibCache cache = _DylibCache(
      version: _fullVersion,
      cacheDir: cacheDir,
    );
    final bool cached = await cache.ensure();
    if (!cached) {
      throw PythonFfiException(
        "Failed to cache Python runtime for version $_fullVersion on ${Platform.operatingSystem}",
      );
    }
  }

  static (PythonSourceEntity, PythonSourceFileEntity?)
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
        // ignore: always_specify_types
        final (pythonSourceEntity, pythonSourceFileEntity) =
            _decodePythonSourceEntity(child);
        licenseFile ??= pythonSourceFileEntity;
        entity.add(pythonSourceEntity);
      }
      return (entity, licenseFile);
    } else {
      return (
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
      // ignore: always_specify_types
      final (decodedRoot, license) = _decodePythonSourceEntity(root);
      yield PythonModuleDefinition(
        name: moduleName,
        root: decodedRoot,
        license: license,
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

  Directory? _pythonFfiDir;

  /// Directory for all Python ffi related files
  FutureOr<Directory> get pythonFfiDir async => _pythonFfiDir ??= Directory(
        "${(await supportDir).path}/python_ffi",
      );

  Directory? _packagesDir;

  /// Directory for all bundled Python packages
  FutureOr<Directory> get packagesDir async => _packagesDir ??= Directory(
        "${(await pythonFfiDir).path}/packages",
      );

  /// Checks whether the Python C-bindings are available
  bool get areBindingsInitialized => _bindings != null;

  /// Checks whether the Python runtime was initialized
  @override
  bool get isInitialized =>
      areBindingsInitialized && bindings.Py_IsInitialized() != 0;

  @override
  Future<void> extractPythonStdLibZip(File zipFile) async {
    final Directory libDir = Directory("${(await pythonFfiDir).path}/lib");
    final InputFileStream inputStream = InputFileStream(zipFile.path);
    final Archive archive = ZipDecoder().decodeBuffer(inputStream);
    extractArchiveToDisk(archive, libDir.path);
  }

  void _pyStatusGuarded(
    PyStatus Function() callback, {
    void Function()? onError,
  }) {
    final PyStatus status = callback();
    if (bindings.PyStatus_Exception(status) != 0) {
      onError?.call();
      // Let Dart handle the exception. Uncomment below to handle it in Python.
      // bindings.Py_ExitStatusException(status);
      final StringBuffer buffer =
          StringBuffer("Python runtime exited with status ${status.exitcode}");
      if (status.func != nullptr) {
        buffer.write(" in function ${status.func.cast<Utf8>().toDartString()}");
      }
      buffer.write(": ${status.err_msg.cast<Utf8>().toDartString()}");
      throw PythonFfiException(buffer.toString());
    }
  }

  T? _injectPyWChar<T>(
    String wchar,
    T Function(Pointer<WChar> wchar) callback,
  ) {
    final Pointer<WChar> wcharPointer = bindings.Py_DecodeLocale(
      wchar.toNativeUtf8().cast(),
      nullptr,
    );
    if (wcharPointer == nullptr) {
      return null;
    }
    return callback(wcharPointer);
  }

  T _updateWCharPointer<T>({
    required T Function(Pointer<Pointer<WChar>> wcharPointer) callback,
    required void Function(Pointer<WChar> wchar) updateCallback,
  }) {
    final Pointer<Pointer<WChar>> tmpPointer = malloc<Pointer<WChar>>();
    final T result = callback(tmpPointer);
    updateCallback(tmpPointer.value);
    malloc.free(tmpPointer);
    return result;
  }

  @override
  Future<void> initialize() async {
    await copyPythonStdLib();

    if (!areBindingsInitialized) {
      await openDylib();
    }

    final Pointer<PyPreConfig> preConfig = malloc<PyPreConfig>();
    // https://docs.python.org/3/c-api/init_config.html#init-isolated-conf
    bindings.PyPreConfig_InitIsolatedConfig(preConfig);
    // enable UTF-8 mode (https://docs.python.org/3/library/os.html#utf8-mode)
    preConfig.ref.utf8_mode = 1;
    // enable locale configuration (https://docs.python.org/3/c-api/init_config.html#c.PyPreConfig.configure_locale)
    preConfig.ref.configure_locale = 1;
    preConfig.ref.coerce_c_locale = 2;
    _pyStatusGuarded(() => bindings.Py_PreInitialize(preConfig));

    final Pointer<PyConfig> config = malloc<PyConfig>();
    bindings.PyConfig_InitIsolatedConfig(config);

    void clearConfig() {
      bindings.PyConfig_Clear(config);
      malloc.free(config);
    }

    // https://docs.python.org/3/c-api/init_config.html#c.PyConfig.filesystem_encoding
    _injectPyWChar(
      "utf-8",
      (Pointer<WChar> wchar) => _pyStatusGuarded(
        () => _updateWCharPointer(
          callback: (Pointer<Pointer<WChar>> wcharPointer) =>
              bindings.PyConfig_SetString(config, wcharPointer, wchar),
          updateCallback: (Pointer<WChar> wchar) =>
              config.ref.filesystem_encoding = wchar,
        ),
        onError: clearConfig,
      ),
    );

    // https://docs.python.org/3/c-api/init_config.html#c.PyConfig.filesystem_errors
    _injectPyWChar(
      "surrogateescape",
      (Pointer<WChar> wchar) => _pyStatusGuarded(
        () => _updateWCharPointer(
          callback: (Pointer<Pointer<WChar>> wcharPointer) =>
              bindings.PyConfig_SetString(config, wcharPointer, wchar),
          updateCallback: (Pointer<WChar> wchar) =>
              config.ref.filesystem_errors = wchar,
        ),
        onError: clearConfig,
      ),
    );

    final String pythonFfiPath = (await pythonFfiDir).path;
    _injectPyWChar(
      pythonFfiPath,
      (Pointer<WChar> wchar) => _pyStatusGuarded(
        () => _updateWCharPointer(
          callback: (Pointer<Pointer<WChar>> wcharPointer) =>
              bindings.PyConfig_SetString(config, wcharPointer, wchar),
          updateCallback: (Pointer<WChar> wchar) => config.ref.home = wchar,
        ),
        onError: clearConfig,
      ),
    );

    _pyStatusGuarded(
      () => bindings.Py_InitializeFromConfig(config),
      onError: clearConfig,
    );

    bindings.PyConfig_Clear(config);

    final Directory packagesDir = await this.packagesDir;
    appendToPath(packagesDir.path);

    // clear modules cache
    if (packagesDir.existsSync()) {
      packagesDir.deleteSync(recursive: true);
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
