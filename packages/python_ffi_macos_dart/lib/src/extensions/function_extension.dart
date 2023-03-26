part of python_ffi_macos_dart;

class _FunctionConversionUtils {
  static int _nextKey = 0;

  static int get nextKey {
    final int key = _nextKey;
    _nextKey++;
    return key;
  }

  static PythonFfiMacOSBase? _staticPlatform;

  static PythonFfiMacOSBase get staticPlatform {
    final PythonFfiMacOSBase? platform = _staticPlatform;
    if (platform == null) {
      throw Exception("staticPlatform not set");
    }
    return platform;
  }

  static final Map<Object?, DartCFunctionSignature> _staticFunctionLookupTable =
      <Object?, DartCFunctionSignature>{};

  static DartCFunctionSignature _getStaticFunction(Object? key) {
    final DartCFunctionSignature? function = _staticFunctionLookupTable[key];
    if (function == null) {
      throw Exception("staticFunction not set for key $key");
    }
    return function;
  }

  static void _setStaticFunction(Object? key, DartCFunctionSignature function) {
    _staticFunctionLookupTable[key] = function;
  }

  static Object? _addStaticEntry(
    PythonFfiMacOSBase platform,
    DartCFunctionSignature function,
  ) {
    final Object key = nextKey;
    _staticPlatform = platform;
    _setStaticFunction(key, function);
    return key;
  }

  static Pointer<PyObject> _pythonFunction(
    Pointer<PyObject> self,
    Pointer<PyObject> args,
  ) {
    final PythonFfiMacOSBase platform = staticPlatform;
    try {
      final Object? dartArgsDynamic = args.toDartObject(platform);
      if (dartArgsDynamic is! List<Object?>) {
        throw Exception("args is not a List<Object?>");
      }
      final List<Object?> dartArgs = dartArgsDynamic;
      final Object? dartSelf = self.toDartObject(platform);
      final DartCFunctionSignature dartFunction = _getStaticFunction(dartSelf);
      final Object? dartResult = dartFunction(dartSelf, dartArgs);
      final _PythonObjectMacos pythonResult =
          dartResult._toPythonObject(platform);
      return pythonResult._toPythonObject(platform).reference;
    } on Exception catch (e) {
      platform.bindings.PyErr_SetString(
        platform.bindings.PyExc_Exception,
        e.toString().toNativeUtf8().cast<Char>(),
      );
      return nullptr;
    }
  }

  /// Wraps a Dart function as a Python C function.
  /// Note: this is a hack, and should be replaced with a proper implementation
  ///       as soon as dart:ffi allows to pass pointers to non-static functions.
  /// We can abuse the `self` parameter to pass a key used to look up the actual
  /// Dart function in a map.
  static Pointer<PyObject> _toPyCFunction<T extends PyCFunctionSignature>(
    PythonFfiMacOSBase platform,
    Pointer<NativeFunction<T>> dartFunction, {
    Object? self,
    String dartFunctionName = "",
    String docString = "",
  }) {
    final Pointer<PyMethodDef> pyMethodDef =
        _createPyMethodDef(dartFunctionName, dartFunction, docString);

    /// [Source: methodobject.h:73]
    /// [PyCFunction_NewEx] is undocumented, but can be used.
    /// - [arg0] is a [PyMethodDef], the callable to be called
    /// - [arg1] is a [PyObject], the class object to which the method will be bound, may be NULL;
    ///          will be passed as [self] to the callable
    /// - [arg2] is a [PyObject], the module containing the class and hence the method, may be NULL
    final Pointer<PyObject> function = platform.bindings.PyCFunction_NewEx(
      pyMethodDef,
      self._toPythonObject(platform).reference,
      nullptr,
    );
    return function;
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
    /// [Source: methodobject.h:55]
    /// The name of the built-in function/method
    final Pointer<PyMethodDef> pyMethodDef = allocator<PyMethodDef>();
    pyMethodDef.ref.ml_name = callableName.isEmpty
        ? nullptr
        : callableName.toNativeUtf8().cast<Char>();

    /// [Source: methodobject.h:56]
    /// The C function that implements it
    pyMethodDef.ref.ml_meth = callable;

    /// [Source: methodobject.h:57-58]
    /// Combination of METH_xxx flags, which mostly describe the args expected by the C func
    pyMethodDef.ref.ml_flags = METH_VARARGS;

    /// [Source: methodobject.h:59]
    /// The __doc__ attribute, or NULL
    pyMethodDef.ref.ml_doc =
        docString.isEmpty ? nullptr : docString.toNativeUtf8().cast<Char>();

    return pyMethodDef;
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
  DartCFunctionSignature get generic0 =>
      // ignore: avoid_dynamic_calls
      (Object? self, List<Object?> args) => this();

  DartCFunctionSignature get generic1 =>
      // ignore: avoid_dynamic_calls
      (Object? self, List<Object?> args) => this(args[0]);

  DartCFunctionSignature get generic2 =>
      // ignore: avoid_dynamic_calls
      (Object? self, List<Object?> args) => this(args[0], args[1]);

  DartCFunctionSignature get generic3 =>
      // ignore: avoid_dynamic_calls
      (Object? self, List<Object?> args) => this(args[0], args[1], args[2]);

  DartCFunctionSignature get generic4 => (Object? self, List<Object?> args) =>
      // ignore: avoid_dynamic_calls
      this(args[0], args[1], args[2], args[3]);

  DartCFunctionSignature get generic5 => (Object? self, List<Object?> args) =>
      // ignore: avoid_dynamic_calls
      this(args[0], args[1], args[2], args[3], args[4]);

  DartCFunctionSignature get generic6 => (Object? self, List<Object?> args) =>
      // ignore: avoid_dynamic_calls
      this(args[0], args[1], args[2], args[3], args[4], args[5]);
}
