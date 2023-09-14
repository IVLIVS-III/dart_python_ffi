part of python_ffi_interface;

/// Abstract base class for all platform implementations of the Python FFI.
abstract base class PythonFfiDelegate<R extends Object?> extends BaseInterface {
  /// Creates a new Python FFI delegate.
  PythonFfiDelegate() : super(token: _token);

  static final Object _token = Object();

  static late PythonFfiDelegate<Object?> _instance;

  /// The default instance of [PythonFfiDelegate] to use.
  ///
  /// No default exists, so this must be set before using the plugin.
  /// This is set by the Flutter engine when it's available.
  /// In Dart-only apps, this is set by the app-facing `python_ffi_dart`
  /// package.
  static PythonFfiDelegate<Object?> get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PythonFfiDelegate] when
  /// they register themselves.
  static set instance(PythonFfiDelegate<Object?> instance) {
    BaseInterface.verify(instance, _token);
    _instance = instance;
  }

  static Logger? _logger;

  /// Gets the logger for for all Python FFI sub-features.
  static Logger get logger => _logger ??= Logger.standard();

  /// Checks whether the Python runtime was initialized.
  bool get isInitialized;

  /// Initializes the native platform Python runtime.
  FutureOr<void> initialize({
    required String? package,
    bool? verboseLogging,
  }) async {
    initializeLogger(verboseLogging: verboseLogging);

    final Set<PythonModuleDefinition> modules =
        await discoverPythonModules(package: package);
    await FutureOrExtension.wait<void>(modules.map(prepareModule));
  }

  /// Initializes the logger for the Python FFI.
  void initializeLogger({bool? verboseLogging}) {
    if (_logger != null && verboseLogging == null) {
      return;
    }
    final bool verbose = verboseLogging ?? _logger?.isVerbose ?? false;
    _logger = verbose ? Logger.verbose() : Logger.standard();
  }

  /// Directory for the Python standard library.
  FutureOr<Directory> get stdlibDir;

  /// Discovers all Python modules bundled with the app by dartpip.
  FutureOr<Set<PythonModuleDefinition>> discoverPythonModules({
    required String? package,
  });

  /// Prepares a Python module for use.
  FutureOr<void> prepareModule(PythonModuleDefinition moduleDefinition);

  /// Checks whether an exception occurred in python.
  // TODO: return a proper python exception object
  bool pythonErrorOccurred();

  /// Prints the current python exception.
  void pythonErrorPrint();

  /// Clears the current python exception.
  void pythonErrorClear();

  /// Throws a dart exception if an exception occurred in python.
  void ensureNoPythonError();

  /// Imports a Python module.
  ///
  /// The module must be builtin or bundled with the app via Flutter assets or
  /// embedded in Dart.
  PythonModuleInterface<PythonFfiDelegate<R>, R> importModule(
    String moduleName,
  );

  /// Imports a Python class from the specified module.
  PythonClassInterface<PythonFfiDelegate<R>, R> importClass(
    String moduleName,
    String className,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]);

  /// Appends a path to the Python sys.path.
  FutureOr<void> appendToPath(String path);
}
