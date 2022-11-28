import "dart:ffi";

import "package:ffi/ffi.dart";
import "package:python_ffi_macos/python_ffi_macos.dart";
import "package:python_ffi_macos/src/class.dart";
import "package:python_ffi_macos/src/extensions/malloc_extension.dart";
import "package:python_ffi_macos/src/ffi/generated_bindings.g.dart";
import "package:python_ffi_macos/src/object.dart";
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
    if (value is int) {
      object = platform.bindings.PyLong_FromLong(value);
    }
    if (value is double) {
      object = platform.bindings.PyFloat_FromDouble(value);
    }
    if (value is String) {
      object = value.toNativeUtf8().useAndFree(
            (Pointer<Utf8> pointer) =>
                platform.bindings.PyUnicode_FromString(pointer.cast<Char>()),
          );
    }
    if (value is PythonObjectPlatform) {
      final Pointer<PyObject> rawObject = value.reference! as Pointer<PyObject>;
      platform.bindings.Py_IncRef(rawObject);
      object = rawObject;
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
    if (object == platform.bindings.Py_True) {
      platform.bindings.Py_DecRef(object);
      return true;
    }
    if (object == platform.bindings.Py_False) {
      platform.bindings.Py_DecRef(object);
      return false;
    }

    final Pointer<PyObject> typeName =
        platform.bindings.PyType_GetName(object.ref.ob_type);

    final a = object.ref;
    final b = a.ob_type;
    final c = b.ref;
    final d = c.tp_name;
    final e = d.cast<Utf8>();
    final String nameString = e.toDartString();

    switch (nameString) {
      case "int":
        return asInt(platform);
      case "float":
        return asDouble(platform);
      case "str":
        return asUnicodeString(platform);
      case "bytes":
        return asString(platform);
    }

    if (platform.classNames.contains(nameString)) {
      return PythonClassMacos(platform, object);
    }

    throw PythonFfiException("Unsupported type: $nameString($runtimeType)");
  }

  int asInt(PythonFfiMacOS platform) {
    final int result = platform.bindings.PyLong_AsLong(this);
    if (result == -1 && platform.bindings.PyErr_Occurred() != nullptr) {
      throw PythonFfiException("Failed to convert to int");
    }
    return result;
  }

  double asDouble(PythonFfiMacOS platform) {
    final double result = platform.bindings.PyFloat_AsDouble(this);
    if (result == -1.0 && platform.bindings.PyErr_Occurred() != nullptr) {
      throw PythonFfiException("Failed to convert to double");
    }
    return result;
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
