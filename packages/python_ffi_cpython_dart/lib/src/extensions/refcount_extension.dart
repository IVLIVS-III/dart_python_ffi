part of python_ffi_cpython_dart;

extension _RefCountExtension on Pointer<PyObject> {
  void incRef(PythonFfiCPythonBase platform) {
    if (this == nullptr) {
      return;
    }

    platform.bindings.Py_IncRef(this);
  }

  void decRef(PythonFfiCPythonBase platform) {
    if (this == nullptr) {
      return;
    }

    platform.bindings.Py_DecRef(this);
  }
}
