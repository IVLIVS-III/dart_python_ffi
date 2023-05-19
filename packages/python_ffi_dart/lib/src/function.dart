part of python_ffi_dart;

/// The Dart representation of a Python function.
base class PythonFunction extends PythonObject {
  /// Creates a new [PythonFunction] from a [PythonFfiDelegate].
  PythonFunction.from(this._functionDelegate) : super.from(_functionDelegate);

  final PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?>
      _functionDelegate;

  /// Calls the function.
  T call<T extends Object?>(
    List<Object?> args, {
    Map<String, Object?>? kwargs,
  }) =>
      _functionDelegate.call<T>(args, kwargs: kwargs);

  /// Converts the Python function object to a Dart function.
  T asFunction<T extends Function>(TypedFunctionConverter<T> converter) =>
      _functionDelegate.asFunction<T>(converter);
}
