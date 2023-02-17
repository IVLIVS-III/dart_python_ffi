part of python_ffi_interface;

abstract class PythonClassDefinitionInterface<P extends PythonFfiDelegate<R>,
    R extends Object?> extends PythonObjectInterface<P, R> {
  PythonClassDefinitionInterface(
    super.delegate,
    super.reference, {
    required super.initializer,
    required super.finalizer,
  });

  PythonClassInterface<P, R> newInstance(
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]);

  T call<T extends Object?>(List<Object?> args, {Map<String, Object?>? kwargs});

  R rawCall({List<R>? args, Map<String, R>? kwargs});
}

abstract class PythonClassInterface<P extends PythonFfiDelegate<R>,
    R extends Object?> extends PythonObjectInterface<P, R> {
  PythonClassInterface(
    super.delegate,
    super.reference, {
    required super.initializer,
    required super.finalizer,
  });

  PythonFunctionInterface<P, R> getMethod(String name) => getFunction(name);
}
