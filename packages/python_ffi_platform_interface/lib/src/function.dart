import "package:python_ffi_platform_interface/src/object.dart";
import "package:python_ffi_platform_interface/src/python_ffi_platform.dart";

abstract class PythonFunctionPlatform<P extends PythonFfiPlatform<R>,
    R extends Object?> extends PythonObjectPlatform<P, R> {
  PythonFunctionPlatform(super.platform, super.reference);

  T call<T extends Object?>(List<Object?> args, {Map<String, Object?>? kwargs});
}
