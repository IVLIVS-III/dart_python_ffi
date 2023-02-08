part of python_ffi_macos_dart;

extension ConvertToPythonExtension on Object? {
  _PythonObjectMacos _toPythonObject(PythonFfiMacOSBase platform) {
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
      platform.bindings.Py_IncRef(object);
    }
    if (value is double) {
      object = platform.bindings.PyFloat_FromDouble(value);
      platform.bindings.Py_IncRef(object);
    }
    if (value is String) {
      object = value.toNativeUtf8().useAndFree<Pointer<PyObject>>(
            (Pointer<Utf8> pointer) =>
                platform.bindings.PyUnicode_FromString(pointer.cast<Char>()),
          );
      platform.bindings.Py_IncRef(object);
    }
    if (value is Map) {
      object = platform.bindings.PyDict_New();
      platform.bindings.Py_IncRef(object);
      for (final Object? key in value.keys) {
        final Object? val = value[key];

        final Pointer<PyObject> keyObject =
            key._toPythonObject(platform).reference;
        platform.bindings.Py_IncRef(keyObject);

        final Pointer<PyObject> valueObject =
            val._toPythonObject(platform).reference;
        platform.bindings.Py_IncRef(valueObject);

        platform.bindings.PyDict_SetItem(object, keyObject, valueObject);
      }
    }
    if (value is List) {
      object = platform.bindings.PyList_New(value.length);
      platform.bindings.Py_IncRef(object);
      for (int i = 0; i < value.length; i++) {
        final Object? val = value[i];

        final Pointer<PyObject> valueObject =
            val._toPythonObject(platform).reference;
        platform.bindings.Py_IncRef(valueObject);

        platform.bindings.PyList_SetItem(object, i, valueObject);
      }
    }
    if (value is Set) {
      final List<Object?> elements = value.toList();
      final _PythonObjectMacos elementsObject =
          elements._toPythonObject(platform);
      platform.bindings.Py_IncRef(elementsObject.reference);

      object = platform.bindings.PySet_New(elementsObject.reference);
      platform.bindings.Py_IncRef(object);
    }
    if (value is PythonObjectInterface) {
      final Object? reference = value.reference;
      if (reference is Pointer<PyObject>) {
        platform.bindings.Py_IncRef(reference);
        object = reference;
      }
    }

    if (object != null) {
      return _PythonObjectMacos(platform, object);
    }

    throw Exception("Unsupported type: $runtimeType");
  }
}

extension ConvertToDartExtension on Pointer<PyObject> {
  Object? toDartObject(PythonFfiMacOSBase platform) {
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

    final String nameString = typeName;

    switch (nameString) {
      case "int":
        return asInt(platform);
      case "float":
        return asDouble(platform);
      case "str":
        return asUnicodeString(platform);
      case "bytes":
        return asString(platform);
      case "dict":
        return asMap(platform);
      case "list":
        return asList(platform);
      case "set":
        return asSet(platform);
    }

    if (platform.classNames.contains(nameString)) {
      return _PythonClassMacos(platform, object);
    }

    throw PythonFfiException("Unsupported type: $nameString($runtimeType)");
  }

  int asInt(PythonFfiMacOSBase platform) {
    final int result = platform.bindings.PyLong_AsLong(this);
    if (result == -1 && platform.bindings.PyErr_Occurred() != nullptr) {
      throw PythonFfiException("Failed to convert to int");
    }
    return result;
  }

  double asDouble(PythonFfiMacOSBase platform) {
    final double result = platform.bindings.PyFloat_AsDouble(this);
    if (result == -1.0 && platform.bindings.PyErr_Occurred() != nullptr) {
      throw PythonFfiException("Failed to convert to double");
    }
    return result;
  }

  String asString(PythonFfiMacOSBase platform) {
    /*
    print(
      "trying to convert detected string @$hexAddress from type name: $typeName",
    );
    */
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

  String asUnicodeString(PythonFfiMacOSBase platform) {
    final String result =
        platform.bindings.PyUnicode_AsUTF8String(this).asString(platform);
    // TODO: correctly handle refcount
    //       disabling this prevents random crashes converting constant strings,
    //       but probably leaks memory
    // platform.bindings.Py_DecRef(this);
    return result;
  }

  Map<Object?, Object?> asMap(PythonFfiMacOSBase platform) {
    final Pointer<PyObject> keys = platform.bindings.PyDict_Keys(this);
    platform.bindings.Py_IncRef(keys);
    platform.ensureNoPythonError();

    if (keys == nullptr) {
      throw PythonFfiException("Failed to convert to Map");
    }

    final Map<Object?, Object?> result = <Object?, Object?>{};

    final int len = platform.bindings.PyList_Size(keys);
    platform.ensureNoPythonError();

    for (int i = 0; i < len; i++) {
      final Pointer<PyObject> key = platform.bindings.PyList_GetItem(keys, i);
      platform.bindings.Py_IncRef(key);

      final Pointer<PyObject> value =
          platform.bindings.PyDict_GetItem(this, key);
      platform.bindings.Py_IncRef(value);

      final Object? keyObject = key.toDartObject(platform);
      final Object? valueObject = value.toDartObject(platform);

      result[keyObject] = valueObject;
    }

    return result;
  }

  List<Object?> asList(PythonFfiMacOSBase platform) {
    final List<Object?> result = <Object?>[];

    final int len = platform.bindings.PyList_Size(this);
    platform.ensureNoPythonError();

    for (int i = 0; i < len; i++) {
      final Pointer<PyObject> value = platform.bindings.PyList_GetItem(this, i);
      platform.bindings.Py_IncRef(value);
      final Object? valueObject = value.toDartObject(platform);
      result.add(valueObject);
      platform.ensureNoPythonError();
    }

    return result;
  }

  Set<Object?> asSet(PythonFfiMacOSBase platform) {
    final Set<Object?> result = <Object?>{};

    while (platform.bindings.PySet_Size(this) > 0) {
      platform.ensureNoPythonError();

      final Pointer<PyObject> element = platform.bindings.PySet_Pop(this);
      platform.bindings.Py_IncRef(element);
      platform.ensureNoPythonError();

      result.add(element.toDartObject(platform));
    }

    return result;
  }
}
