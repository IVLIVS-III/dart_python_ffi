part of python_ffi_interface;

abstract class PythonFfiDelegate<R extends Object?> extends BaseInterface {
  PythonFfiDelegate() : super(token: _token);

  static final Object _token = Object();

  static PythonFfiDelegate<Object?> _instance = _DummyDelegate();

  /// The default instance of [PythonFfiPlatform] to use.
  ///
  /// Defaults to [MethodChannelPythonFfi].
  static PythonFfiDelegate<Object?> get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PythonFfiPlatform] when
  /// they register themselves.
  static set instance(PythonFfiDelegate<Object?> instance) {
    BaseInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Checks whether the Python runtime was initialized
  bool get isInitialized;

  /// Initializes the native platform Python runtime
  FutureOr<void> initialize() async {
    final Set<PythonModuleDefinition> modules = await discoverPythonModules();
    await FutureOrExtension.wait<void>(modules.map(prepareModule));
  }

  /// Discovers all Python modules bundled with the app by dartpip
  FutureOr<Set<PythonModuleDefinition>> discoverPythonModules();

  FutureOr<void> prepareModule(PythonModuleDefinition moduleDefinition);

  /// Checks whether an exception occurred in python
  // TODO: return a proper python exception object
  bool pythonErrorOccurred();

  /// Prints the current python exception
  void pythonErrorPrint();

  /// Clears the current python exception
  void pythonErrorClear();

  /// Throws a dart exception if an exception occurred in python
  void ensureNoPythonError();

  /// Imports a Python module.
  /// The module must be builtin or bundled with the app via flutter assets.
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

  /// Appends a path to the Python sys.path
  FutureOr<void> appendToPath(String path);
}

class _DummyDelegate extends PythonFfiDelegate<Object?> {
  @override
  FutureOr<void> appendToPath(String path) {
    // TODO: implement appendToPath
    throw UnimplementedError();
  }

  @override
  void ensureNoPythonError() {
    // TODO: implement ensureNoPythonError
  }

  @override
  PythonClassInterface<PythonFfiDelegate<Object?>, Object?> importClass(
    String moduleName,
    String className,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) {
    // TODO: implement importClass
    throw UnimplementedError();
  }

  @override
  PythonModuleInterface<PythonFfiDelegate<Object?>, Object?> importModule(
    String moduleName,
  ) {
    // TODO: implement importModule
    throw UnimplementedError();
  }

  @override
  FutureOr<void> initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  // TODO: implement isInitialized
  bool get isInitialized => throw UnimplementedError();

  @override
  FutureOr<Set<PythonModuleDefinition>> discoverPythonModules() {
    // TODO: implement discoverPythonModules
    throw UnimplementedError();
  }

  @override
  FutureOr<void> prepareModule(PythonModuleDefinition moduleDefinition) {
    // TODO: implement prepareModule
    throw UnimplementedError();
  }

  @override
  bool pythonErrorOccurred() {
    // TODO: implement pythonErrorOccurred
    throw UnimplementedError();
  }

  @override
  void pythonErrorPrint() {
    // TODO: implement pythonErrorPrint
  }

  @override
  void pythonErrorClear() {
    // TODO: implement pythonErrorClear
  }
}
