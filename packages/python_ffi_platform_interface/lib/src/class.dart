import "package:python_ffi_platform_interface/src/function.dart";
import "package:python_ffi_platform_interface/src/object.dart";
import "package:python_ffi_platform_interface/src/python_ffi_platform.dart";

abstract class PythonClassPlatform<P extends PythonFfiPlatform<R>,
    R extends Object?> extends PythonObjectPlatform<P, R> {
  PythonClassPlatform(super.platform, super.reference);

  PythonClassPlatform<P, R> newInstance(
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]);

  PythonFunctionPlatform<P, R> getMethod(String functionName);

  void init(List<Object?> args, [Map<String, Object?>? kwargs]) {
    getMethod("__init__").call(args, kwargs: kwargs);
  }
}
