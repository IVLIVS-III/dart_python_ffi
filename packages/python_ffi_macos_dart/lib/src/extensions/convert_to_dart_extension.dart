part of python_ffi_macos_dart;

extension ConvertToDartExtension on Pointer<PyObject> {
  Object? toDartObject(PythonFfiMacOSBase platform) {
    final Pointer<PyObject> object = this;

    if (object == nullptr) {
      return null;
    }
    if (isNone(platform)) {
      object.decRef(platform);
      return null;
    }
    if (isTrue(platform)) {
      object.decRef(platform);
      return true;
    }
    if (isFalse(platform)) {
      object.decRef(platform);
      return false;
    }
    if (isInt(platform)) {
      return asInt(platform);
    }
    if (isFloat(platform)) {
      return asDouble(platform);
    }
    if (isString(platform)) {
      return asUnicodeString(platform);
    }
    if (isBytes(platform)) {
      return asBytes(platform);
    }
    if (isList(platform)) {
      return asList(platform);
    }
    if (isTuple(platform)) {
      return asTuple(platform);
    }
    if (isDict(platform)) {
      return asMap(platform);
    }
    if (isSet(platform)) {
      return asSet(platform);
    }
    if (isAwaitable(platform)) {
      return asFuture(platform);
    }
    if (isIterator(platform)) {
      return asIterator(platform);
    }
    if (isIterable(platform)) {
      return asIterable(platform);
    }
    if (isClass(platform)) {
      return PythonClassMacos(platform, object);
    }

    final String nameString = typeName;
    // backup conversions matching the name as string
    print(
      "ℹ️   Info: falling back to conversion via name as string for '$nameString'",
    );
    switch (nameString) {
      case "int":
        return asInt(platform);
      case "float":
        return asDouble(platform);
      case "str":
        return asUnicodeString(platform);
      case "bytes":
        return asBytes(platform);
      case "dict":
        return asMap(platform);
      case "list":
        return asList(platform);
      case "tuple":
        return List<Object?>.from(asList(platform), growable: false);
      case "set":
        return asSet(platform);
      case "generator":
        return asIterator(platform);
      case "function":
        return asFunction(platform);
      case "module":
        return asModule(platform);
    }

    print(
      "⚠️   Warning: falling back to conversion to generic python object for '$nameString'",
    );
    return _PythonObjectMacos(platform, object);
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

  Uint8List asBytes(PythonFfiMacOSBase platform) {
    final Pointer<PyObject> bytes = platform.bindings.PyBytes_FromObject(this);
    if (bytes == nullptr) {
      throw PythonFfiException("Failed to convert to bytes");
    }
    final int size = platform.bindings.PyBytes_Size(bytes);
    final Uint8List result = Uint8List(size);
    for (int i = 0; i < size; i++) {
      result[i] =
          platform.bindings.PySequence_GetItem(bytes, i).asInt(platform);
    }
    bytes.decRef(platform);
    return result;
  }

  String _bytesAsString(PythonFfiMacOSBase platform) {
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
        platform.bindings.PyUnicode_AsUTF8String(this)._bytesAsString(platform);
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

  List<Object?> asTuple(PythonFfiMacOSBase platform) {
    final List<Object?> result = <Object?>[];

    final int len = platform.bindings.PyTuple_Size(this);
    platform.ensureNoPythonError();

    for (int i = 0; i < len; i++) {
      final Pointer<PyObject> value = platform.bindings.PyTuple_GetItem(this, i)
        ..incRef(platform);
      final Object? valueObject = value.toDartObject(platform);
      result.add(valueObject);
      platform.ensureNoPythonError();
    }

    return List<Object?>.from(result, growable: false);
  }

  List<Object?> asList(PythonFfiMacOSBase platform) {
    final List<Object?> result = <Object?>[];

    final int len = platform.bindings.PyList_Size(this);
    platform.ensureNoPythonError();

    for (int i = 0; i < len; i++) {
      final Pointer<PyObject> value = platform.bindings.PyList_GetItem(this, i)
        ..incRef(platform);
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

  Iterable<Object?> asIterable(PythonFfiMacOSBase platform) =>
      PythonIterable<Object?, PythonFfiMacOSBase, Pointer<PyObject>>(
        _PythonObjectMacos(platform, this),
      );

  Future<Object?> asFuture(PythonFfiMacOSBase platform) =>
      PythonFutureMacos<Object?>(platform, this);

  Iterator<Object?> asIterator(PythonFfiMacOSBase platform) =>
      PythonIterator<Object?, PythonFfiMacOSBase, Pointer<PyObject>>(
        _PythonObjectMacos(platform, this),
      );

  PythonFunctionMacos asFunction(PythonFfiMacOSBase platform) {
    // Note: We need to access the __code__.__str__ attribute to ensure that the
    //       code object is not garbage collected before the function object.
    //       If __code__.__str__ is not available, we use __code__.__repr__.
    final PythonFunctionMacos result = PythonFunctionMacos(platform, this);
    const String kCodeAttributeName = "__code__";
    if (result.hasAttribute(kCodeAttributeName)) {
      final Object? codeAttribute = result.getAttribute(kCodeAttributeName);
      const String kStrAttributeName = "__str__";
      const String kReprAttributeName = "__repr__";
      if (codeAttribute is _PythonObjectMacos) {
        if (codeAttribute.hasAttribute(kStrAttributeName)) {
          codeAttribute
              .getFunction(kStrAttributeName)
              .call<String>(<Object?>[]);
        } else if (codeAttribute.hasAttribute(kReprAttributeName)) {
          codeAttribute
              .getFunction(kReprAttributeName)
              .call<String>(<Object?>[]);
        }
      }
    }
    return result;
  }

  PythonModuleMacos asModule(PythonFfiMacOSBase platform) =>
      PythonModuleMacos(platform, this);
}
