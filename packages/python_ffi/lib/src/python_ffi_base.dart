part of python_ffi;

class PythonFfi extends PythonFfiBase with PythonFfiMixin {
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

  FutureOr<void> initialize() async =>
      await PythonFfiDelegate.instance.initialize();
}
