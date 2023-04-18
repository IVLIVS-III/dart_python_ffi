part of python_ffi_dart;

/// A base class for all python ffi implementations.
abstract class PythonFfiBase {
  /// Gets the name of the implementation.
  ///
  /// This is used for error messages.
  String get name;

  /// Gets the delegate that is used to interact with the python ffi.
  PythonFfiDelegate<Object?> get delegate;

  set delegate(PythonFfiDelegate<Object?> delegate);
}

/// An implementation of the python ffi for dart apps.
class PythonFfiDart extends PythonFfiBase with PythonFfiMixin {
  PythonFfiDart._();

  static PythonFfiDart? _instance;

  /// Gets the singleton instance of the python ffi.
  // ignore: prefer_constructors_over_static_methods
  static PythonFfiDart get instance {
    _instance ??= PythonFfiDart._();
    return _instance!;
  }

  @override
  PythonFfiDelegate<Object?> get delegate => PythonFfiDelegate.instance;

  @override
  set delegate(PythonFfiDelegate<Object?> delegate) {
    PythonFfiDelegate.instance = delegate;
  }

  @override
  String get name => "PythonFfiDart";

  /// Initializes the native platform Python runtime.
  FutureOr<void> initialize(String pythonModules, {String? libPath}) {
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      delegate = PythonFfiCPythonDart(pythonModules, libPath: libPath);
      return delegate.initialize();
    }

    // TODO: implement for other platforms
    throw UnsupportedError(
      "Python is not supported on ${Platform.operatingSystem}.",
    );
  }
}

/// A shared implementation of the python ffi.
mixin PythonFfiMixin on PythonFfiBase {
  /// Prepares a Python module for use.
  FutureOr<void> prepareModule(PythonModuleDefinition moduleDefinition) async {
    await delegate.prepareModule(moduleDefinition);
  }

  void _ensureInitialized() {
    if (!delegate.isInitialized) {
      throw PythonFfiException(
        "$name is not initialized. Call `$name.instance.initialize()` before using it.",
      );
    }
  }

  /// Imports a Python module.
  ///
  /// The module must be builtin or bundled with the app via Flutter assets or
  /// embedded in Dart.
  T importModule<T extends PythonModule>(
    String name,
    PythonModuleFrom<T> from,
  ) {
    _ensureInitialized();
    return from(delegate.importModule(name));
  }

  /// Imports a Python class from the specified module.
  T importClass<T extends PythonClass>(
    String moduleName,
    String className,
    PythonClassFrom<T> from,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) {
    _ensureInitialized();
    // TODO: integrate pythonClassType properly
    return from(
      delegate.importClass(moduleName, className, args, kwargs),
    );
  }

  /// Appends a path to the Python sys.path.
  Future<void> appendToPath(String path) async {
    _ensureInitialized();
    await delegate.appendToPath(path);
  }
}
