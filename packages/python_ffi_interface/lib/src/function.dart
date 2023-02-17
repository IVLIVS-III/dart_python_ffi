part of python_ffi_interface;

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
}
