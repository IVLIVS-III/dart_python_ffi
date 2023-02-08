part of python_ffi_platform_interface;

abstract class PythonClassDefinitionPlatform<P extends PythonFfiPlatform<R>,
    R extends Object?> extends PythonClassDefinitionInterface<P, R> {
  PythonClassDefinitionPlatform(super.platform, super.reference);
}

abstract class PythonClassPlatform<P extends PythonFfiPlatform<R>,
    R extends Object?> extends PythonClassInterface<P, R> {
  PythonClassPlatform(super.platform, super.reference);
}
