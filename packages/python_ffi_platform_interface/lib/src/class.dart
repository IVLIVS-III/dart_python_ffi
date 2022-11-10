import "package:python_ffi_platform_interface/src/function.dart";
import "package:python_ffi_platform_interface/src/module.dart";
import "package:python_ffi_platform_interface/src/object.dart";
import "package:python_ffi_platform_interface/src/python_ffi_platform.dart";

abstract class PythonClassPlatform<P extends PythonFfiPlatform<R>,
    R extends Object?> extends PythonObjectPlatform<P, R> {
  PythonClassPlatform(super.platform, super.reference);

  PythonModulePlatform<P, R> get module;

  PythonFunctionPlatform<P, R> getFunction(String functionName);

  void init(List<Object?> args, [Map<String, Object?>? kwargs]) {
    getFunction("__init__").call(args, kwargs: kwargs);
  }
}
