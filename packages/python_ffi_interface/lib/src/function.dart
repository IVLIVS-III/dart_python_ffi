part of python_ffi_interface;

typedef PythonFunctionType = Object? Function(
  List<Object?> args, {
  Map<String, Object?>? kwargs,
});
typedef TypedFunctionConverter<T extends Function> = T Function(
  PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?>,
);

abstract class PythonFunctionInterface<P extends PythonFfiDelegate<R>,
    R extends Object?> extends PythonObjectInterface<P, R> {
  PythonFunctionInterface(
    super.delegate,
    super.reference, {
    required super.initializer,
    required super.finalizer,
  });

  T call<T extends Object?>(List<Object?> args, {Map<String, Object?>? kwargs});

  R rawCall({List<R>? args, Map<String, R>? kwargs});

  T asFunction<T extends Function>(TypedFunctionConverter<T> converter);
}
