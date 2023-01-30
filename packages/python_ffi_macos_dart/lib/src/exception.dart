part of python_ffi_macos_dart;

class PythonExceptionMacos
    extends PythonExceptionPlatform<PythonFfiMacOSBase, Pointer<PyObject>>
    with _PythonObjectMacosMixin {
  PythonExceptionMacos(
    super.platform,
    super.reference,
    this.pValue,
    this.pTraceback,
  );

  factory PythonExceptionMacos.fetch(PythonFfiMacOSBase platform) {
    final Pointer<Pointer<PyObject>> pTypePtr = malloc<Pointer<PyObject>>();
    final Pointer<Pointer<PyObject>> pValuePtr = malloc<Pointer<PyObject>>();
    final Pointer<Pointer<PyObject>> pTracebackPtr =
        malloc<Pointer<PyObject>>();

    platform.bindings.PyErr_Fetch(pTypePtr, pValuePtr, pTracebackPtr);

    final PythonExceptionMacos pythonException = PythonExceptionMacos(
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
  String toString() {
    final String typeRepr =
        platform.bindings.PyObject_Repr(pType).asUnicodeString(platform);
    final String valueRepr =
        platform.bindings.PyObject_Repr(pValue).asUnicodeString(platform);
    final String tracebackRepr =
        platform.bindings.PyObject_Repr(pTraceback).asUnicodeString(platform);
    return "PythonExceptionMacos($typeRepr): $valueRepr\n$tracebackRepr";
  }
}
