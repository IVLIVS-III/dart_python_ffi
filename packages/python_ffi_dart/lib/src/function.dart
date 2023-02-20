part of python_ffi_dart;

class PythonFunction extends PythonObject {
  PythonFunction.from(this._functionDelegate) : super.from(_functionDelegate);

  final PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?>
      _functionDelegate;

  T call<T extends Object?>(
    List<Object?> args, {
    Map<String, Object?>? kwargs,
  }) =>
      _functionDelegate.call<T>(args, kwargs: kwargs);

  T asFunction<T extends Function>(TypedFunctionConverter<T> converter) =>
      _functionDelegate.asFunction<T>(converter);
}
