part of python_ffi_platform_interface;

abstract class PythonModulePlatform<P extends PythonFfiPlatform<R>,
        R extends Object?> extends PythonModuleInterface<P, R>
    implements PythonObjectPlatform<P, R> {
  PythonModulePlatform(super.platform, super.reference);

  @override
  PythonClassPlatform<P, R> getClass(
    String name,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]);

  @override
  PythonModulePlatform<P, R> getModule(String name);
}
