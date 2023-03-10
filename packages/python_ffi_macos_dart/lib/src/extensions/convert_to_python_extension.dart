part of python_ffi_macos_dart;

extension ConvertToPythonExtension on Object? {
  _PythonObjectMacos _toPythonObject(PythonFfiMacOSBase platform) {
    final Object? value = this;
    Pointer<PyObject>? object;

    if (value == null) {
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
      object = fromTuple(
        platform,
        PythonTuple<Object?, PythonFfiMacOSBase, Pointer<PyObject>>.from(
          value.toList(growable: false),
        ),
      );
    } else if (value is List) {
      object = fromList(platform, value);
    } else if (value is Set) {
      object = fromSet(platform, value);
    } else if (value is Iterable) {
      object = fromIterable(platform, value);
    } else if (value is Iterator) {
      object = fromIterator(platform, value);
    } else if (value is Future) {
      object = fromFuture(platform, value);
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
      return _PythonObjectMacos(platform, object);
    }

    throw Exception("Unsupported type converting dart -> python: $runtimeType");
  }

  // ignore: avoid_positional_boolean_parameters
  static Pointer<PyObject> fromBool(PythonFfiMacOSBase platform, bool value) =>
      value ? platform.bindings.Py_True : platform.bindings.Py_False;

  static Pointer<PyObject> fromInt(PythonFfiMacOSBase platform, int value) =>
      platform.bindings.PyLong_FromLong(value)..incRef(platform);

  static Pointer<PyObject> fromFloat(
    PythonFfiMacOSBase platform,
    double value,
  ) =>
      platform.bindings.PyFloat_FromDouble(value)..incRef(platform);

  static Pointer<PyObject> fromString(
    PythonFfiMacOSBase platform,
    String value,
  ) =>
      value.toNativeUtf8().useAndFree<Pointer<PyObject>>(
            (Pointer<Utf8> pointer) =>
                platform.bindings.PyUnicode_FromString(pointer.cast<Char>()),
          )..incRef(platform);

  static Pointer<PyObject> fromMap(
    PythonFfiMacOSBase platform,
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
    PythonFfiMacOSBase platform,
    Uint8List value,
  ) {
    final List<int> elements = List<int>.from(value);
    final _PythonObjectMacos elementsObject =
        elements._toPythonObject(platform); // list[int]
    return platform.bindings.PyBytes_FromObject(elementsObject.reference)
      ..incRef(platform);
  }

  static Pointer<PyObject> fromTuple(
    PythonFfiMacOSBase platform,
    PythonTuple<Object?, PythonFfiMacOSBase, Pointer<PyObject>> value,
  ) {
    throw UnimplementedError();
  }

  static Pointer<PyObject> fromList(
    PythonFfiMacOSBase platform,
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
    PythonFfiMacOSBase platform,
    Set<Object?> value,
  ) {
    final List<Object?> elements = value.toList();
    final _PythonObjectMacos elementsObject =
        elements._toPythonObject(platform);

    return platform.bindings.PySet_New(elementsObject.reference)
      ..incRef(platform);
  }

  static Pointer<PyObject> fromIterable(
    PythonFfiMacOSBase platform,
    Iterable<Object?> value,
  ) {
    // TODO: implement
    throw UnimplementedError();
  }

  static Pointer<PyObject> fromIterator(
    PythonFfiMacOSBase platform,
    Iterator<Object?> value,
  ) {
    // TODO: implement
    throw UnimplementedError();
  }

  static Pointer<PyObject> fromFuture(
    PythonFfiMacOSBase platform,
    Future<Object?> value,
  ) {
    Object? dunderAwait() {
      final PythonModuleInterface<PythonFfiDelegate<Pointer<PyObject>>,
          Pointer<PyObject>> asyncio = platform.importModule("asyncio");
      final Object? eventLoop =
          asyncio.getFunction("get_event_loop").call(<Object?>[]);
      if (eventLoop is _PythonObjectMacos) {
        final Object? future =
            eventLoop.getFunction("create_future").call(<Object?>[]);

        if (future is PythonFutureMacos) {
          value.then((Object? result) {
            future.getFunction("set_result").call(<Object?>[result]);
          }).catchError((dynamic err) {
            future.getFunction("set_exception").call(<Object?>[err]);
          });
          return future.reference;
        }

        throw PythonFfiException("Unable to create asyncio future");
      }
      throw PythonFfiException("Unable to fetch asyncio event loop");
    }

    /// PyEval_EvalCode(PyObject* source, PyObject* globals, PyObject* locals)
    // final coro = platform.bindings.PyEval_EvalCode(arg0, arg1, arg2);
    // Idea: create a python object with `__await__` = `dunderAwait`
    // var foo = _PythonObjectMacos(platform, dunderAwait());
    return dunderAwait() as Pointer<PyObject>;
  }

  static Pointer<PyObject> fromFunction(
    PythonFfiMacOSBase platform,
    DartCFunctionSignature value,
  ) {
    final Object? key =
        _FunctionConversionUtils._addStaticEntry(platform, value);
    final Pointer<NativeFunction<PyCFunctionSignature>> p =
        Pointer.fromFunction<PyCFunctionSignature>(
            _FunctionConversionUtils._pythonFunction);
    return _FunctionConversionUtils._toPyCFunction(platform, p, self: key);
  }
}
