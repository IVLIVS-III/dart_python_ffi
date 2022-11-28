import "dart:ffi";

import "package:python_ffi_macos/python_ffi_macos.dart";
import "package:python_ffi_macos/src/ffi/generated_bindings.g.dart";
import "package:python_ffi_macos/src/object.dart";
import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";

class PythonFunctionMacos
    extends PythonFunctionPlatform<PythonFfiMacOS, Pointer<PyObject>>
    with PythonObjectMacosMixin {
  PythonFunctionMacos(super.platform, super.reference);

  @override
  T call<T extends Object?>(
    List<Object?> args, {
    Map<String, Object?>? kwargs,
  }) =>
      PythonObjectMacosMixin.staticCall<T>(
        platform,
        reference,
        args,
        kwargs: kwargs,
      );

  @override
  Pointer<PyObject> rawCall({
    List<Pointer<PyObject>>? args,
    Map<String, Pointer<PyObject>>? kwargs,
  }) =>
      PythonObjectMacosMixin.staticRawCall(
        platform,
        reference,
        args: args,
        kwargs: kwargs,
      );
}
