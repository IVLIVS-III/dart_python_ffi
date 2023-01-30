part of python_ffi_platform_interface;

abstract class PythonModulePlatform<P extends PythonFfiPlatform<R>,
    R extends Object?> extends PythonObjectPlatform<P, R> {
  PythonModulePlatform(super.platform, super.reference);

  PythonFunctionPlatform<P, R> getFunction(String functionName);

  PythonClassPlatform<P, R> getClass(
    String className,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]);
}
