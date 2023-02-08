part of python_ffi_platform_interface;

abstract class PythonModulePlatform<P extends PythonFfiPlatform<R>,
    R extends Object?> extends PythonModuleInterface<P, R> {
  PythonModulePlatform(super.platform, super.reference);
}
