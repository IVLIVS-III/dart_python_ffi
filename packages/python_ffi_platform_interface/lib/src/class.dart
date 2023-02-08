part of python_ffi_platform_interface;

abstract class PythonClassDefinitionPlatform<P extends PythonFfiPlatform<R>,
        R extends Object?> extends PythonClassDefinitionInterface<P, R>
    implements PythonObjectPlatform<P, R> {
  PythonClassDefinitionPlatform(super.platform, super.reference);

  @override
  PythonClassPlatform<P, R> newInstance(
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]);
}

abstract class PythonClassPlatform<P extends PythonFfiPlatform<R>,
        R extends Object?> extends PythonClassInterface<P, R>
    implements PythonObjectPlatform<P, R> {
  PythonClassPlatform(super.platform, super.reference);

  @override
  PythonFunctionPlatform<P, R> getMethod(String name) => getFunction(name);
}
