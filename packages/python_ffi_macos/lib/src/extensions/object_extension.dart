import "dart:ffi";

import "package:ffi/ffi.dart";
import "package:python_ffi_macos/src/ffi/generated_bindings.g.dart";

extension ObjectExtension on Pointer<PyObject> {
  bool get isClass {
    // TODO: this does not seem right, it matches function-types as well
    final String baseType = ref.ob_type.ref.ob_base.ob_base.ob_type.ref.tp_name
        .cast<Utf8>()
        .toDartString();
    return baseType == "type";
  }
}
