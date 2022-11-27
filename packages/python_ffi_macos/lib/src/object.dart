import "dart:ffi";

import "package:ffi/ffi.dart";
import "package:python_ffi_macos/python_ffi_macos.dart";
import "package:python_ffi_macos/src/extensions/convert_extension.dart";
import "package:python_ffi_macos/src/extensions/malloc_extension.dart";
import "package:python_ffi_macos/src/ffi/generated_bindings.g.dart";
import "package:python_ffi_macos/src/function.dart";
import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";

class PythonObjectMacos
    extends PythonObjectPlatform<PythonFfiMacOS, Pointer<PyObject>>
    with PythonObjectMacosMixin {
  PythonObjectMacos(super.platform, super.reference);
}

mixin PythonObjectMacosMixin
    on PythonObjectPlatform<PythonFfiMacOS, Pointer<PyObject>> {
  @override
  T getAttribute<T extends Object?>(String attributeName) {
    final Pointer<PyObject> attribute = attributeName.toNativeUtf8().useAndFree(
          (Pointer<Utf8> pointer) => platform.bindings.PyObject_GetAttrString(
            reference,
            pointer.cast<Char>(),
          ),
        );

    if (attribute == nullptr) {
      throw PythonFfiException("Failed to get attribute $attributeName");
    }

    return attribute.toDartObject(platform) as T;
  }

  @override
  void dispose() {
    platform.bindings.Py_DecRef(reference);
  }

  @override
  Object? toDartObject() => reference.toDartObject(platform);

  PythonFunctionMacos getFunction_(
    String functionName,
    Map<String, PythonFunctionMacos> functions,
  ) {
    final PythonFunctionMacos? cachedFunction = functions[functionName];
    if (cachedFunction != null) {
      return cachedFunction;
    }

    final PythonObjectPlatform<PythonFfiMacOS, Pointer<PyObject>>
        functionAttribute = getAttribute(functionName);
    final PythonFunctionMacos function =
        PythonFunctionMacos(platform, functionAttribute.reference);

    functions[functionName] = function;

    return function;
  }
}
