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
    } else if (value is Function) {
      object = fromFunction(platform, value.generic);
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

  static PythonFfiMacOSBase? _staticPlatform;
  static DartCFunctionSignature? _staticFunction;

  static PythonFfiMacOSBase get staticPlatform {
    final PythonFfiMacOSBase? platform = _staticPlatform;
    if (platform == null) {
      throw Exception("staticPlatform not set");
    }
    return platform;
  }

  static DartCFunctionSignature get staticFunction {
    final DartCFunctionSignature? function = _staticFunction;
    if (function == null) {
      throw Exception("staticFunction not set");
    }
    return function;
  }

  static Pointer<PyObject> _pythonFunction(
    Pointer<PyObject> self,
    Pointer<PyObject> args,
  ) {
    final List<Object?> dartArgs = args.asList(staticPlatform);
    final Object? result =
        staticFunction(self.toDartObject(staticPlatform), dartArgs);
    return result._toPythonObject(staticPlatform).reference;
  }

  static Pointer<PyObject> fromFunction(
    PythonFfiMacOSBase platform,
    DartCFunctionSignature value,
  ) {
    // TODO: implement
    _staticPlatform = platform;
    _staticFunction = value;
    final Pointer<NativeFunction<PyCFunctionSignature>> p =
        Pointer.fromFunction<PyCFunctionSignature>(_pythonFunction);
    // TODO: get function name
    return _toPyCFunction(platform, "someFunc", p);
  }

  static Pointer<PyMethodDef> _createPyMethodDef(
    String callableName,
    PyCFunction callable,
    String docString, {
    Allocator allocator = malloc,
  }) {
    // 64b <= sizeof(Pointer<Int8>)
    // 64b <= sizeof(Pointer<NativeFunction<PyCFunction>>)
    // 32b <= sizeof(Int32)
    // 64b <= sizeof(Pointer<Int8>)
    // ==> 224b = 28B
    // const int size = 28;
    // ==> allocator takes care of allocation size, thankfully ;)
    final Pointer<PyMethodDef> pyMethodDef = allocator<PyMethodDef>();
    pyMethodDef.ref.ml_name = callableName.toNativeUtf8().cast<Char>();
    pyMethodDef.ref.ml_meth = callable;
    pyMethodDef.ref.ml_flags = METH_VARARGS | METH_KEYWORDS;
    pyMethodDef.ref.ml_doc =
        docString.isEmpty ? nullptr : docString.toNativeUtf8().cast<Char>();

    print(
        "[_createPyMethodDef] pyMethodDef@${pyMethodDef.address.toRadixString(16)}");
    print(
      "[_createPyMethodDef] ml_name@${pyMethodDef.ref.ml_name.address.toRadixString(16)}: ${pyMethodDef.ref.ml_name.cast<Utf8>().toDartString()}",
    );
    print(
      "[_createPyMethodDef] ml_meth@${pyMethodDef.ref.ml_meth.address.toRadixString(16)}: ${pyMethodDef.ref.ml_meth.runtimeType}::${pyMethodDef.ref.ml_meth.toString()}",
    );
    print(
      "[_createPyMethodDef] ml_flags: ${pyMethodDef.ref.ml_flags}",
    );
    print(
      "[_createPyMethodDef] ml_doc@${pyMethodDef.ref.ml_doc.address.toRadixString(16)}: ${pyMethodDef.ref.ml_doc != nullptr ? pyMethodDef.ref.ml_doc.cast<Utf8>().toDartString() : "null"}",
    );

    // TODO: look into the PyMethodDef struct. What values does it have?
    // A misconfiguration here might also be the root cause of the segfault.

    return pyMethodDef;
  }

  static Pointer<PyObject> _toPyCFunction<T extends PyCFunctionSignature>(
    PythonFfiMacOSBase platform,
    String dartFunctionName,
    Pointer<NativeFunction<T>> dartFunction, {
    String docString = "",
  }) {
    print("[_toPyCFunction] calling _createPyMethodDef");
    final Pointer<PyMethodDef> pyMethodDef =
        _createPyMethodDef(dartFunctionName, dartFunction, docString);
    print("[_toPyCFunction] called _createPyMethodDef");

    // TODO: we might not need this name
    print("[_toPyCFunction] creating module name");
    final Pointer<PyObject> name =
        "audible"._toPythonObject(platform).reference;
    print("[_toPyCFunction] created module name");

    print("[_toPyCFunction] constructing PyCFunction via PyCFunction_NewEx");

    /// [PyCFunction_NewEx] is undocumented, but can be used.
    /// - [arg0] is a [PyMethodDef], the callable to be called
    /// - [arg1] probably is a class object, to which the method will be bound, may be NULL
    /// - [arg2] probably is a string object containing the module name, may be NULL
    final Pointer<PyObject> function =
        platform.bindings.PyCFunction_NewEx(pyMethodDef, nullptr, nullptr);
    print("[_toPyCFunction] constructed PyCFunction via PyCFunction_NewEx");

    return function;
  }
}

typedef DartCFunctionSignature = Object? Function(
  Object? self,
  List<Object?> args,
);

/// https://docs.python.org/3/c-api/structures.html#c.PyMethodDef
typedef PyCFunctionSignature = Pointer<PyObject> Function(
  Pointer<PyObject> self,
  Pointer<PyObject> args,
);

extension GenericExtension on Function {
  DartCFunctionSignature get generic {
    if (this is DartCFunctionSignature) {
      return this as DartCFunctionSignature;
    }
    if (this is int Function(int)) {
      return (Object? self, List<Object?> args) {
        final int arg = args[0] as int;
        print("calling int Function(int) with $arg");
        final int result = this(arg) as int;
        print("called int Function(int) with $arg, result: $result");
        return result;
      };
    }
    throw UnimplementedError();
  }
}
