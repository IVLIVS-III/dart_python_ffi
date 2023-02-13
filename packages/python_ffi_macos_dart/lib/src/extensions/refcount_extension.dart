part of python_ffi_macos_dart;

extension RefCountExtension on Pointer<PyObject> {
  void incRef(PythonFfiMacOSBase platform) {
    platform.bindings.Py_IncRef(this);
  }

  void decRef(PythonFfiMacOSBase platform) {
    platform.bindings.Py_DecRef(this);
  }
}
