part of python_ffi_interface;

abstract class PythonModuleInterface<P extends PythonFfiDelegate<R>,
    R extends Object?> extends PythonObjectInterface<P, R> {
  PythonModuleInterface(
    super.delegate,
    super.reference, {
    required super.initializer,
    required super.finalizer,
  });

  PythonClassInterface<P, R> getClass(
    String name,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]);

  PythonModuleInterface<P, R> getModule(String name);
}
