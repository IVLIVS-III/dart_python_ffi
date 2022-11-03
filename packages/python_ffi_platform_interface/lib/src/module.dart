import 'package:python_ffi_platform_interface/src/function.dart';
import "package:python_ffi_platform_interface/src/object.dart";
import "package:python_ffi_platform_interface/src/python_ffi_platform.dart";

abstract class PythonModulePlatform<P extends PythonFfiPlatform<R>,
    R extends Object?> extends PythonObjectPlatform<P, R> {
  PythonModulePlatform(super.platform, super.reference);

  PythonFunctionPlatform<P, R> getFunction(String functionName);
}
