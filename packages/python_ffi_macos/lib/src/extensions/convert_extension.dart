import "dart:ffi";

import "package:ffi/ffi.dart";
import "package:python_ffi_macos/python_ffi_macos.dart";
import "package:python_ffi_macos/src/extensions/malloc_extension.dart";
import "package:python_ffi_macos/src/ffi/generated_bindings.g.dart";
import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";

extension ConvertToPythonExtension on Object? {
  PythonObjectMacos toPythonObject(PythonFfiMacOS platform) {
    final Object? value = this;
    Pointer<PyObject>? object;

    if (value == null) {
      object = platform.bindings.Py_None;
    }
    if (value is bool) {
      object = value ? platform.bindings.Py_True : platform.bindings.Py_False;
    }
    if (value is String) {
      object = value.toNativeUtf8().useAndFree(
            (Pointer<Utf8> pointer) =>
                platform.bindings.PyUnicode_FromString(pointer.cast<Char>()),
          );
    }

    if (object != null) {
      return PythonObjectMacos(platform, object);
    }

    throw Exception("Unsupported type: $runtimeType");
  }
}

extension ConvertToDartExtension on Pointer<PyObject> {
  Object? toDartObject(PythonFfiMacOS platform) {
    final Pointer<PyObject> object = this;

    if (object == nullptr) {
      return null;
    }
    if (platform.bindings.Py_IsNone(object) == 1) {
      platform.bindings.Py_DecRef(object);
      return null;
    }

    throw Exception("Unsupported type: $runtimeType");
  }

  String asString(PythonFfiMacOS platform) {
    print(
      "trying to convert detected string from type name: ${ref.ob_type.ref.tp_name.cast<Utf8>().toDartString()}",
    );
    final Pointer<Char> res = platform.bindings.PyBytes_AsString(this);

    // check for errors
    platform.ensureNoPythonError();

    platform.bindings.Py_DecRef(this);
    try {
      final String str = res.cast<Utf8>().toDartString();
      return str;
    } on FormatException catch (e) {
      throw PythonFfiException("Error in converting to a dart String: $e");
    }
  }

  String asUnicodeString(PythonFfiMacOS platform) {
    final String result =
        platform.bindings.PyUnicode_AsUTF8String(this).asString(platform);
    platform.bindings.Py_DecRef(this);
    return result;
  }
}
