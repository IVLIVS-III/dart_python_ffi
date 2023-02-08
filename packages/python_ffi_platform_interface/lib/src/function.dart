part of python_ffi_platform_interface;

abstract class PythonFunctionPlatform<P extends PythonFfiPlatform<R>,
    R extends Object?> extends PythonFunctionInterface<P, R> {
  PythonFunctionPlatform(super.platform, super.reference);
}
