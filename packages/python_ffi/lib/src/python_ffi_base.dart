part of python_ffi;

class PythonFfi extends PythonFfiBase with PythonFfiMixin {
  @visibleForTesting
  PythonFfi();

  PythonFfi._();

  static PythonFfi? _instance;

  // ignore: prefer_constructors_over_static_methods
  static PythonFfi get instance {
    _instance ??= PythonFfi._();
    return _instance!;
  }

  @override
  PythonFfiDelegate<Object?> get delegate => PythonFfiDelegate.instance;

  @override
  set delegate(PythonFfiDelegate<Object?> delegate) {
    PythonFfiDelegate.instance = delegate;
  }

  @override
  String get name => "PythonFfi";

  /// Initializes the Python runtime and prepares bundled Python modules for
  /// import.
  ///
  /// *Note:* Supply [package] if you are implementing a package that uses this
  /// plugin. This will ensure that the Python runtime is initialized with the
  /// correct path to the bundled Python modules when your package is used in a
  /// Flutter app.
  FutureOr<void> initialize({
    String? package,
    bool? verboseLogging,
  }) async =>
      await PythonFfiDelegate.instance.initialize(
        package: package,
        verboseLogging: verboseLogging,
      );
}
