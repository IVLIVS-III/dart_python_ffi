part of python_ffi_macos_dart;

extension SymbolToNameExtension on Symbol {
  String get name =>
      RegExp(r'^Symbol\("(.*)"\)$').firstMatch(toString())?.group(1) ??
      toString();
}

class _PythonObjectMacos
    extends PythonObjectInterface<PythonFfiMacOSBase, Pointer<PyObject>>
    with _PythonObjectMacosMixin {
  _PythonObjectMacos(super.platform, super.reference);
}

mixin _PythonObjectMacosMixin
    on PythonObjectInterface<PythonFfiMacOSBase, Pointer<PyObject>> {
  static T staticCall<T extends Object?>(
    PythonFfiMacOSBase platform,
    Pointer<PyObject> reference,
    List<Object?> args, {
    Map<String, Object?>? kwargs,
  }) {
    final List<Pointer<PyObject>> mappedArgs = <Pointer<PyObject>>[];
    for (final Object? arg in args) {
      final _PythonObjectMacos a = arg._toPythonObject(platform);
      final Pointer<PyObject> b = a.reference;
      mappedArgs.add(b);
    }

    final Map<String, Pointer<PyObject>>? mappedKwargs = kwargs?.map(
      (String key, Object? value) => MapEntry<String, Pointer<PyObject>>(
        key,
        value._toPythonObject(platform).reference,
      ),
    );

    final Pointer<PyObject> rawResult = staticRawCall(
      platform,
      reference,
      args: mappedArgs,
      kwargs: mappedKwargs,
    );

    final _PythonObjectMacos result = _PythonObjectMacos(platform, rawResult);

    final Object? mappedResult = result.toDartObject();
    if (mappedResult is! PythonObjectInterface) {
      result.dispose();
    }

    return mappedResult as T;
  }

  /// Calls the python function with raw pyObject args and kwargs
  static Pointer<PyObject> staticRawCall(
    PythonFfiMacOSBase platform,
    Pointer<PyObject> reference, {
    List<Pointer<PyObject>>? args,
    Map<String, Pointer<PyObject>>? kwargs,
  }) {
    // prepare args
    final int argsLen = args?.length ?? 0;
    final Pointer<PyObject> pArgs = platform.bindings.PyTuple_New(argsLen);
    if (pArgs == nullptr) {
      throw PythonFfiException("Creating argument tuple failed");
    }
    for (int i = 0; i < argsLen; i++) {
      platform.bindings.PyTuple_SetItem(pArgs, i, args![i]);
    }

    // prepare kwargs
    late final Pointer<PyObject> pKwargs;
    final List<_PythonObjectMacos> kwargsKeys = <_PythonObjectMacos>[];
    if (kwargs == null) {
      pKwargs = nullptr;
    } else {
      pKwargs = platform.bindings.PyDict_New();
      if (pKwargs == nullptr) {
        throw PythonFfiException("Creating keyword argument dict failed");
      }
      for (final MapEntry<String, Pointer<PyObject>> kwarg in kwargs.entries) {
        final _PythonObjectMacos kwargKey = kwarg.key._toPythonObject(platform);
        kwargsKeys.add(kwargKey);
        platform.bindings
            .PyDict_SetItem(pKwargs, kwargKey.reference, kwarg.value);
      }
    }

    // call function
    final Pointer<PyObject> result =
        platform.bindings.PyObject_Call(reference, pArgs, pKwargs);

    // deallocate arguments
    platform.bindings.Py_DecRef(pArgs);
    for (final _PythonObjectMacos kwargKey in kwargsKeys) {
      kwargKey.dispose();
    }
    if (pKwargs != nullptr) {
      platform.bindings.Py_DecRef(pKwargs);
    }

    // check for errors
    platform.ensureNoPythonError();

    return result;
  }

  @override
  T getAttributeRaw<
      T extends PythonObjectInterface<PythonFfiMacOSBase, Pointer<PyObject>>>(
    String attributeName,
  ) {
    final Pointer<PyObject> attribute = attributeName.toNativeUtf8().useAndFree(
          (Pointer<Utf8> pointer) => platform.bindings.PyObject_GetAttrString(
            reference,
            pointer.cast<Char>(),
          ),
        );

    if (attribute == nullptr) {
      throw PythonFfiException("Failed to get attribute $attributeName");
    }

    return _PythonObjectMacos(platform, attribute) as T;
  }

  @override
  T getAttribute<T extends Object?>(String attributeName) {
    final _PythonObjectMacos attribute = getAttributeRaw(attributeName);

    return attribute.reference.toDartObject(platform) as T;
  }

  @override
  void setAttributeRaw<
      T extends PythonObjectInterface<PythonFfiMacOSBase, Pointer<PyObject>>>(
    String attributeName,
    T value,
  ) {
    final int result = attributeName.toNativeUtf8().useAndFree(
          (Pointer<Utf8> pointer) => platform.bindings.PyObject_SetAttrString(
            reference,
            pointer.cast<Char>(),
            value.reference,
          ),
        );

    // this call should not be necessary
    // result is -1 on failure, 0 on success
    platform.ensureNoPythonError();

    if (result == -1) {
      throw PythonFfiException("Failed to set attribute $attributeName");
    }
  }

  @override
  void setAttribute<T extends Object?>(String attributeName, T value) {
    setAttributeRaw(attributeName, value._toPythonObject(platform));
  }

  @override
  void dispose() {
    platform.bindings.Py_DecRef(reference);
  }

  @override
  Object? toDartObject() => reference.toDartObject(platform);

  @override
  void debugDump() {
    print("========================================");
    print("PythonObjectMacos: @0x${reference.hexAddress}");
    try {
      try {
        print("converted: ${reference.toDartObject(platform)}");
      } on PythonFfiException catch (e) {
        print("converted: @0x${reference.hexAddress} w/ error: $e");
      }

      final PythonObjectInterface<PythonFfiMacOSBase, Pointer<PyObject>> dict =
          getAttributeRaw("__dict__");
      print("dict: @0x${dict.reference.hexAddress}");
      platform.ensureNoPythonError();

      final Pointer<PyObject> keys =
          platform.bindings.PyDict_Keys(dict.reference);
      platform.bindings.Py_IncRef(keys);
      print("dict-keys: @0x${keys.hexAddress}");
      platform.ensureNoPythonError();

      if (keys == nullptr) {
        print("dict-keys is null");
      } else {
        final int len = platform.bindings.PyList_Size(keys);
        print("dict-keys-len: $len");
        platform.ensureNoPythonError();

        for (int i = 0; i < len; i++) {
          final Pointer<PyObject> key =
              platform.bindings.PyList_GetItem(keys, i);
          platform.bindings.Py_IncRef(key);

          final Pointer<PyObject> value =
              platform.bindings.PyDict_GetItem(dict.reference, key);
          platform.bindings.Py_IncRef(value);

          final String keyString = key.toDartObject(platform)! as String;
          Object? valueObject;
          try {
            valueObject = value.toDartObject(platform);
          } on PythonFfiException catch (e) {
            valueObject = "@0x${value.hexAddress} w/ error: $e";
          }
          print("$keyString: $valueObject");
        }
      }
    } on _PythonExceptionMacos catch (e) {
      print("Error: $e");
    } finally {
      print("========================================");
    }
  }
}
