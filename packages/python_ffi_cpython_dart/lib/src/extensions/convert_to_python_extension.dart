part of python_ffi_cpython_dart;

extension _ConvertToPythonExtension on Object? {
  _PythonObjectCPython _toPythonObject(PythonFfiCPythonBase platform) {
    final Object? value = this;
    Pointer<PyObject>? object;

    if (value == null || value is Pointer<Never>) {
      object = platform.bindings.Py_None;
    } else if (value is bool) {
      object = fromBool(platform, value);
    } else if (value is int) {
      object = fromInt(platform, value);
    } else if (value is double) {
      object = fromFloat(platform, value);
    } else if (value is String) {
      object = fromString(platform, value);
    } else if (value is Map) {
      object = fromMap(platform, value);
    } else if (value is Uint8List) {
      object = fromUint8List(platform, value);
    } else if (value is PythonTuple) {
      object = fromTuple(platform, value);
    } else if (value is List) {
      object = fromList(platform, value);
    } else if (value is Set) {
      object = fromSet(platform, value);
    } else if (value is Iterable) {
      object = fromIterable(platform, value);
    } else if (value is Iterator) {
      object = fromIterator(platform, value);
    } else if (value is DartCFunctionSignature) {
      object = fromFunction(platform, value);
    } else if (value is Function) {
      throw Exception(
        "Unsupported type converting dart -> python: $runtimeType, did you mean to use `DartCFunctionSignature`? If so, convert your function with the `genericX` extension getter.",
      );
    } else if (value is PythonObjectInterface) {
      final Object? reference = value.reference;
      if (reference is Pointer<PyObject>) {
        reference.incRef(platform);
        object = reference;
      }
    }

    platform.ensureNoPythonError();
    if (object != null) {
      return _PythonObjectCPython(platform, object);
    }

    throw Exception("Unsupported type converting dart -> python: $runtimeType");
  }

  static Pointer<PyObject> fromBool(
    PythonFfiCPythonBase platform,
    // ignore: avoid_positional_boolean_parameters
    bool value,
  ) =>
      value ? platform.bindings.Py_True : platform.bindings.Py_False;

  static Pointer<PyObject> fromInt(PythonFfiCPythonBase platform, int value) =>
      platform.bindings.PyLong_FromLong(value)..incRef(platform);

  static Pointer<PyObject> fromFloat(
    PythonFfiCPythonBase platform,
    double value,
  ) =>
      platform.bindings.PyFloat_FromDouble(value)..incRef(platform);

  static Pointer<PyObject> fromString(
    PythonFfiCPythonBase platform,
    String value,
  ) =>
      value.toNativeUtf8().useAndFree<Pointer<PyObject>>(
            (Pointer<Utf8> pointer) =>
                platform.bindings.PyUnicode_FromString(pointer.cast<Char>()),
          )..incRef(platform);

  static Pointer<PyObject> fromMap(
    PythonFfiCPythonBase platform,
    Map<dynamic, dynamic> value,
  ) {
    final Pointer<PyObject> object = platform.bindings.PyDict_New()
      ..incRef(platform);
    for (final Object? key in value.keys) {
      final Object? val = value[key];

      final Pointer<PyObject> keyObject =
          key._toPythonObject(platform).reference..incRef(platform);

      final Pointer<PyObject> valueObject =
          val._toPythonObject(platform).reference..incRef(platform);

      platform.bindings.PyDict_SetItem(object, keyObject, valueObject);
    }
    return object;
  }

  static Pointer<PyObject> fromUint8List(
    PythonFfiCPythonBase platform,
    Uint8List value,
  ) {
    final List<int> elements = List<int>.from(value);
    final _PythonObjectCPython elementsObject =
        elements._toPythonObject(platform); // list[int]
    return platform.bindings.PyBytes_FromObject(elementsObject.reference)
      ..incRef(platform);
  }

  static Pointer<PyObject> fromTuple(
    PythonFfiCPythonBase platform,
    PythonTuple<Object?> value,
  ) {
    final Pointer<PyObject> pythonTuple =
        platform.bindings.PyTuple_New(value.length);
    if (pythonTuple == nullptr) {
      throw PythonFfiException(
        "Failed to create python tuple during type conversion.",
      );
    }

    for (int i = 0; i < value.length; i++) {
      final Object? element = value[i];

      final Pointer<PyObject> elementObject =
          element._toPythonObject(platform).reference;

      platform.bindings.PyTuple_SetItem(pythonTuple, i, elementObject);
    }

    return pythonTuple;
  }

  static Pointer<PyObject> fromList(
    PythonFfiCPythonBase platform,
    List<Object?> value,
  ) {
    final Pointer<PyObject> object = platform.bindings.PyList_New(value.length)
      ..incRef(platform);
    for (int i = 0; i < value.length; i++) {
      final Object? val = value[i];

      final Pointer<PyObject> valueObject =
          val._toPythonObject(platform).reference..incRef(platform);

      platform.bindings.PyList_SetItem(object, i, valueObject);
    }
    return object;
  }

  static Pointer<PyObject> fromSet(
    PythonFfiCPythonBase platform,
    Set<Object?> value,
  ) {
    final List<Object?> elements = value.toList();
    final _PythonObjectCPython elementsObject =
        elements._toPythonObject(platform);

    return platform.bindings.PySet_New(elementsObject.reference)
      ..incRef(platform);
  }

  static Pointer<PyObject> fromIterable(
    PythonFfiCPythonBase platform,
    Iterable<Object?> value,
  ) =>
      platform.importClass(
        "python_ffi",
        "PythonFfiIterable",
        <Object?>[(() => value.iterator).generic0],
      ).reference;

  static Pointer<PyObject> fromIterator(
    PythonFfiCPythonBase platform,
    Iterator<Object?> value,
  ) =>
      platform.importClass(
        "python_ffi",
        "PythonFfiIterator",
        <Object?>[
          value.moveNext.generic0,
          (() => value.current).generic0,
        ],
      ).reference;

  static Pointer<PyObject> fromFunction(
    PythonFfiCPythonBase platform,
    DartCFunctionSignature value,
  ) {
    final Object? key =
        _FunctionConversionUtils._addStaticEntry(platform, value);
    final Pointer<NativeFunction<PyCFunctionSignature>> p =
        Pointer.fromFunction<PyCFunctionSignature>(
      _FunctionConversionUtils._pythonFunction,
    );
    return _FunctionConversionUtils._toPyCFunction(platform, p, self: key);
  }
}
