part of python_ffi_platform_interface;

class PythonFfiException implements Exception {
  PythonFfiException(this.message);

  final String message;

  @override
  String toString() => "PythonFfiException: $message";
}

/// A dart exception wrapping a python exception
abstract class PythonExceptionPlatform<P extends PythonFfiPlatform<R>,
    R extends Object?> extends PythonObjectPlatform<P, R> implements Exception {
  PythonExceptionPlatform(super.platform, super.reference);

  @override
  String toString() => "PythonExceptionPlatform";
}
