part of python_ffi_macos_dart;

class _PythonExceptionMacos
    extends PythonExceptionInterface<PythonFfiMacOSBase, Pointer<PyObject>>
    with _PythonObjectMacosMixin {
  _PythonExceptionMacos(
    super.platform,
    super.reference,
    this.pValue,
    this.pTraceback,
  ) : super(
          initializer: _PythonObjectMacosRefcountUtil.initializer,
          finalizer: _PythonObjectMacosRefcountUtil.finalizer,
        );

  factory _PythonExceptionMacos.fetch(PythonFfiMacOSBase platform) {
    final Pointer<Pointer<PyObject>> pTypePtr = malloc<Pointer<PyObject>>();
    final Pointer<Pointer<PyObject>> pValuePtr = malloc<Pointer<PyObject>>();
    final Pointer<Pointer<PyObject>> pTracebackPtr =
        malloc<Pointer<PyObject>>();

    platform.bindings.PyErr_Fetch(pTypePtr, pValuePtr, pTracebackPtr);

    final _PythonExceptionMacos pythonException = _PythonExceptionMacos(
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

    return "PythonExceptionMacos($typeRepr): $valueRepr\n$tracebackRepr";
  }

  @override
  String toString([bool verbose = true]) {
    final String? nativeException = _nativelyFormattedException();
    if (nativeException != null) {
      return "PythonExceptionMacos: $nativeException";
    }

    final String? nativeTraceback = _nativelyFormattedTraceback();
    return _fallbackFormattedException(nativeTraceback);
  }
}
