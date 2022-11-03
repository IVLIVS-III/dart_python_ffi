import "package:python_ffi_platform_interface/src/object.dart";
import "package:python_ffi_platform_interface/src/python_ffi_platform.dart";

class PythonFfiException implements Exception {
  PythonFfiException(this.message);

  final String message;

  @override
  String toString() => "PythonFfiException: $message";
}

/// A dart exception wrapping a python exception
class PythonExceptionPlatform<P extends PythonFfiPlatform<R>, R extends Object?>
    extends PythonObjectPlatform<P, R> implements Exception {
  PythonExceptionPlatform(super.platform, super.reference);

  @override
  String toString() => "PythonExceptionPlatform";
}
