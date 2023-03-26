part of python_ffi_macos_dart;

extension _RefCountExtension on Pointer<PyObject> {
  void incRef(PythonFfiMacOSBase platform) {
    if (this == nullptr) {
      return;
    }

    platform.bindings.Py_IncRef(this);
  }

  void decRef(PythonFfiMacOSBase platform) {
    if (this == nullptr) {
      return;
    }

    platform.bindings.Py_DecRef(this);
  }
}
