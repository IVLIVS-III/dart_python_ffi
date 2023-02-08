part of python_ffi_interface;

abstract class PythonFfiDelegate<R extends Object?> {
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
    _verify(instance, _token);
    _instance = instance;
  }

  /// Expando mapping instances of PlatformInterface to their associated tokens.
  /// The reason this is not simply a private field of type `Object?` is because
  /// as of the implementation of field promotion in Dart
  /// (https://github.com/dart-lang/language/issues/2020), it is a runtime error
  /// to invoke a private member that is mocked in another library.  The expando
  /// approach prevents [_verify] from triggering this runtime exception when
  /// encountering an implementation that uses `implements` rather than
  /// `extends`.  This in turn allows [_verify] to throw an [AssertionError] (as
  /// documented).
  static final Expando<Object> _instanceTokens = Expando<Object>();

  /// Ensures that the platform instance was constructed with a non-`const` token
  /// that matches the provided token and throws [AssertionError] if not.
  ///
  /// This is used to ensure that implementers are using `extends` rather than
  /// `implements`.
  static void _verify(PythonFfiDelegate<Object?> instance, Object token) {
    if (identical(_instanceTokens[instance], const Object())) {
      throw AssertionError("`const Object()` cannot be used as the token.");
    }
    if (!identical(token, _instanceTokens[instance])) {
      throw AssertionError(
        "Platform interfaces must not be implemented with `implements`",
      );
    }
  }

  /// Checks whether the Python runtime was initialized
  bool get isInitialized;

  /// Initializes the native platform Python runtime
  FutureOr<void> initialize();

  FutureOr<void> prepareModule(PythonModuleDefinition moduleDefinition);

  /// Register a Python class name for type marshalling.
  void addClassName(String className);

  void removeClassName(String className);

  /// Checks whether an exception occurred in python
  // TODO: return a proper python exception object
  bool pythonErrorOccurred();

  /// Prints the current python exception
  void pythonErrorPrint();

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
  void addClassName(String className) {
    // TODO: implement addClassName
  }

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
  void removeClassName(String className) {
    // TODO: implement removeClassName
  }
}
