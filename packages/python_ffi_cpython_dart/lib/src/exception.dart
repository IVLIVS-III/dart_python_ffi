part of python_ffi_cpython_dart;

base class _PythonExceptionCPython
    extends PythonExceptionInterface<PythonFfiCPythonBase, Pointer<PyObject>>
    with _PythonObjectCPythonMixin {
  _PythonExceptionCPython(
    super.platform,
    super.reference,
    this.pValue,
    this.pTraceback,
  ) : super(
          initializer: _PythonObjectCPythonRefcountUtil.initializer,
          finalizer: _PythonObjectCPythonRefcountUtil.finalizer,
        );

  factory _PythonExceptionCPython.fetch(PythonFfiCPythonBase platform) {
    final Pointer<Pointer<PyObject>> pTypePtr = malloc<Pointer<PyObject>>();
    final Pointer<Pointer<PyObject>> pValuePtr = malloc<Pointer<PyObject>>();
    final Pointer<Pointer<PyObject>> pTracebackPtr =
        malloc<Pointer<PyObject>>();

    platform.bindings.PyErr_Fetch(pTypePtr, pValuePtr, pTracebackPtr);

    final _PythonExceptionCPython pythonException = _PythonExceptionCPython(
      platform,
      pTypePtr.value,
      pValuePtr.value,
      pTracebackPtr.value,
    );

    malloc
      ..free(pTypePtr)
      ..free(pValuePtr)
      ..free(pTracebackPtr);

    return pythonException;
  }

  Pointer<PyObject> get pType => reference;
  final Pointer<PyObject> pValue;
  final Pointer<PyObject> pTraceback;

  @override
  String get type {
    if (reference is Pointer<PyTypeObject>) {
      return (reference as Pointer<PyTypeObject>).name;
    }
    return reference.typeName;
  }

  @override
  Object? get value => pValue._toPythonObject(platform);

  @override
  Object? get traceback => pTraceback._toPythonObject(platform);

  String? _nativelyFormattedTraceback() {
    try {
      if (pTraceback == nullptr) {
        return null;
      }
      final Object? formattedTraceback =
          platform.importModule("traceback").getFunction("format_tb").rawCall(
        args: <Pointer<PyObject>>[pTraceback],
      ).toDartObject(platform);
      if (formattedTraceback is List) {
        return formattedTraceback.join();
      }
      return formattedTraceback?.toString();
    } on Exception {
      return null;
    }
  }

  String? _nativelyFormattedException() {
    try {
      final Object? formattedException = platform
          .importModule("traceback")
          .getFunction("format_exception")
          .rawCall(
        args: <Pointer<PyObject>>[pType, pValue, pTraceback],
      ).toDartObject(platform);
      if (formattedException is List) {
        return formattedException.join();
      }
      return formattedException?.toString();
    } on Exception {
      return null;
    }
  }

  String _fallbackFormattedException([String? nativeTraceback]) {
    final String typeRepr =
        platform.bindings.PyObject_Repr(pType).asUnicodeString(platform);
    final String valueRepr =
        platform.bindings.PyObject_Repr(pValue).asUnicodeString(platform);
    final String tracebackRepr = nativeTraceback ??
        platform.bindings.PyObject_Repr(pTraceback).asUnicodeString(platform);

    return "PythonExceptionCPython($typeRepr): $valueRepr\n$tracebackRepr";
  }

  @override
  String toString() {
    // For some reason any exception of type `TypeError` results in a
    // Segmentation Fault when calling `traceback.format_exception` or
    // `traceback.format_tb`.
    // Just skip the native formatting in this case.
    final String typeRepr = BuiltinsModule.import().repr(
      _PythonObjectCPython(platform, pType),
    );
    if (typeRepr != "<class 'TypeError'>") {
      final String? nativeException = _nativelyFormattedException();
      if (nativeException != null) {
        return "PythonExceptionCPython: $nativeException";
      }
    }

    final String? nativeTraceback = _nativelyFormattedTraceback();
    return _fallbackFormattedException(nativeTraceback);
  }
}
