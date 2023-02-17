part of python_ffi_platform_interface;

/// A dart exception wrapping a python exception
abstract class PythonExceptionPlatform<P extends PythonFfiPlatform<R>,
        R extends Object?> extends PythonExceptionInterface<P, R>
    implements Exception, PythonObjectPlatform<P, R> {
  PythonExceptionPlatform(
    super.platform,
    super.reference, {
    required super.initializer,
    required super.finalizer,
  });
}
