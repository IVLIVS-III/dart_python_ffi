// ignore_for_file: non_constant_identifier_names

part of "../ffi/generated_bindings.g.dart";

extension DartPythonCBindingsExtension on DartPythonCBindings {
  ffi.Pointer<PyObject> get Py_None => _Py_NoneStruct;

  ffi.Pointer<PyObject> get Py_True =>
      PyBool_FromLong(Py_TrueStruct.ob_digit[0]);

  ffi.Pointer<PyObject> get Py_False =>
      PyBool_FromLong(Py_FalseStruct.ob_digit[0]);
}
