part of python_ffi_cpython_dart;

// ignore: avoid_classes_with_only_static_members
class _PythonObjectCPythonRefcountUtil {
  static void _initializerCallback(
    PythonFfiCPythonBase platform,
    Pointer<PyObject> reference,
  ) =>
      reference.incRef(platform);

  static const Initializer<PythonFfiCPythonBase, Pointer<PyObject>>
      initializer = Initializer<PythonFfiCPythonBase, Pointer<PyObject>>(
    _initializerCallback,
  );

  static void _finalizerCallback(
    (PythonFfiDelegate<Object?>, Object?) value,
  ) {
    // ignore: always_specify_types
    final (platform, reference) = value;
    if (platform is PythonFfiCPythonBase && reference is Pointer<PyObject>) {
      reference.decRef(platform);
    }
  }

  static final Finalizer<(PythonFfiDelegate<Object?>, Object?)> finalizer =
      Finalizer<(PythonFfiDelegate<Object?>, Object?)>(
    _finalizerCallback,
  );
}

final class _PythonObjectCPython
    extends PythonObjectInterface<PythonFfiCPythonBase, Pointer<PyObject>>
    with _PythonObjectCPythonMixin {
  _PythonObjectCPython(super.platform, super.reference)
      : super(
          initializer: _PythonObjectCPythonRefcountUtil.initializer,
          finalizer: _PythonObjectCPythonRefcountUtil.finalizer,
        );
}

base mixin _PythonObjectCPythonMixin
    on PythonObjectInterface<PythonFfiCPythonBase, Pointer<PyObject>> {
  static T staticCall<T extends Object?>(
    PythonFfiCPythonBase platform,
    Pointer<PyObject> reference,
    List<Object?> args, {
    Map<String, Object?>? kwargs,
  }) {
    final List<Pointer<PyObject>> mappedArgs = <Pointer<PyObject>>[];
    for (final Object? arg in args) {
      final _PythonObjectCPython a = arg._toPythonObject(platform);
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

    final _PythonObjectCPython result =
        _PythonObjectCPython(platform, rawResult);

    final Object? mappedResult = result.toDartObject();

    return mappedResult as T;
  }

  /// Calls the python function with raw pyObject args and kwargs
  static Pointer<PyObject> staticRawCall(
    PythonFfiCPythonBase platform,
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
    final List<_PythonObjectCPython> kwargsKeys = <_PythonObjectCPython>[];
    if (kwargs == null) {
      pKwargs = nullptr;
    } else {
      pKwargs = platform.bindings.PyDict_New();
      if (pKwargs == nullptr) {
        throw PythonFfiException("Creating keyword argument dict failed");
      }
      for (final MapEntry<String, Pointer<PyObject>> kwarg in kwargs.entries) {
        final _PythonObjectCPython kwargKey =
            kwarg.key._toPythonObject(platform);
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
    if (pKwargs != nullptr) {
      platform.bindings.Py_DecRef(pKwargs);
    }

    // check for errors
    platform.ensureNoPythonError();

    return result;
  }

  @override
  bool hasAttribute(String attributeName) {
    final int result = attributeName.toNativeUtf8().useAndFree(
          (Pointer<Utf8> pointer) => platform.bindings.PyObject_HasAttrString(
            reference,
            pointer.cast<Char>(),
          ),
        );
    return result == 1;
  }

  @override
  T getAttributeRaw<
      T extends PythonObjectInterface<PythonFfiCPythonBase, Pointer<PyObject>>>(
    String attributeName,
  ) {
    final Pointer<PyObject> attribute = attributeName.toNativeUtf8().useAndFree(
          (Pointer<Utf8> pointer) => platform.bindings.PyObject_GetAttrString(
            reference,
            pointer.cast<Char>(),
          ),
        );

    if (attribute == nullptr) {
      if (platform.pythonErrorOccurred()) {
        platform.pythonErrorClear();
      }
      throw UnknownAttributeException(attributeName);
    }

    return _PythonObjectCPython(platform, attribute) as T;
  }

  @override
  T getAttribute<T extends Object?>(String attributeName) {
    final _PythonObjectCPython attribute = getAttributeRaw(attributeName);

    return attribute.reference.toDartObject(platform) as T;
  }

  @override
  void setAttributeRaw<
      T extends PythonObjectInterface<PythonFfiCPythonBase, Pointer<PyObject>>>(
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
  _PythonFunctionCPython getFunction(String name) {
    final PythonObjectInterface<PythonFfiCPythonBase, Pointer<PyObject>>
        functionAttribute = getAttributeRaw(name);
    return _PythonFunctionCPython(platform, functionAttribute.reference);
  }

  @override
  bool operator ==(Object? other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! PythonObjectInterface<PythonFfiDelegate<Pointer<PyObject>>,
        Pointer<PyObject>>) {
      return false;
    }
    final String kEqAttributeName = "__eq__";
    try {
      if (hasAttribute(kEqAttributeName)) {
        final _PythonFunctionCPython eqFunction = getFunction(kEqAttributeName);
        final Object? result = eqFunction.call(<Object?>[other]);
        if (result is bool) {
          return result;
        }
      }
    } on PythonExceptionInterface<PythonFfiDelegate<Object?>, Object?> {
      // ignore
    }
    return reference == other.reference;
  }

  @override
  int get hashCode {
    try {
      return BuiltinsModule.import().hash(<Object?>[this]);
    } on PythonExceptionInterface<PythonFfiDelegate<Object?>, Object?> {
      // ignore
    }
    try {
      const String kHashAttributeName = "__hash__";
      if (hasAttribute(kHashAttributeName)) {
        final Object? hashAttribute = getAttribute(kHashAttributeName);
        if (hashAttribute != null) {
          return getFunction(kHashAttributeName).call(<Object?>[]);
        }
      }
    } on PythonExceptionInterface<PythonFfiDelegate<Object?>, Object?> {
      // ignore
    }
    return super.hashCode;
  }

  @override
  String toString() {
    final BuiltinsModule builtins = BuiltinsModule.import();
    try {
      return builtins.str(<Object?>[this]);
    } on PythonExceptionInterface<PythonFfiDelegate<Object?>, Object?> {
      // ignore
    }
    try {
      return builtins.repr(<Object?>[this]);
    } on PythonExceptionInterface<PythonFfiDelegate<Object?>, Object?> {
      // ignore
    }
    try {
      const String kStrAttributeName = "__str__";
      const String kReprAttributeName = "__repr__";
      if (hasAttribute(kStrAttributeName)) {
        return getFunction(kStrAttributeName).call(<Object?>[]);
      } else if (hasAttribute(kReprAttributeName)) {
        return getFunction(kReprAttributeName).call(<Object?>[]);
      }
    } on PythonExceptionInterface<PythonFfiDelegate<Object?>, Object?> {
      // ignore
    }
    return super.toString();
  }

  @override
  Object? toDartObject() => reference.toDartObject(platform);

  @override
  void debugDump() {
    // ignore: avoid_print
    print("========================================");
    // ignore: avoid_print
    print("PythonObjectCPython: @0x${reference.hexAddress}");
    try {
      try {
        // ignore: avoid_print
        print("converted: ${reference.toDartObject(platform)}");
      } on PythonFfiException catch (e) {
        // ignore: avoid_print
        print("converted: @0x${reference.hexAddress} w/ error: $e");
      }

      final PythonObjectInterface<PythonFfiCPythonBase, Pointer<PyObject>>
          dict = getAttributeRaw("__dict__");
      // ignore: avoid_print
      print("dict: @0x${dict.reference.hexAddress}");
      platform.ensureNoPythonError();

      final Pointer<PyObject> keys =
          platform.bindings.PyDict_Keys(dict.reference);
      platform.bindings.Py_IncRef(keys);
      // ignore: avoid_print
      print("dict-keys: @0x${keys.hexAddress}");
      platform.ensureNoPythonError();

      if (keys == nullptr) {
        // ignore: avoid_print
        print("dict-keys is null");
      } else {
        final int len = platform.bindings.PyList_Size(keys);
        // ignore: avoid_print
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
          // ignore: avoid_print
          print("$keyString: $valueObject");
        }
      }
    } on _PythonExceptionCPython catch (e) {
      // ignore: avoid_print
      print("Error(_PythonExceptionCPython): $e");
    } on PythonFfiException catch (e) {
      // ignore: avoid_print
      print("Error(PythonFfiException): $e");
    } finally {
      // ignore: avoid_print
      print("========================================");
    }
  }
}
