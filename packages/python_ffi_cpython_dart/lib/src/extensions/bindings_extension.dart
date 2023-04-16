// ignore_for_file: non_constant_identifier_names

part of "../ffi/generated_bindings.g.dart";

/// Extension methods for [DartPythonCBindings].
///
/// These are mostly utility shorthands for common singleton objects.
extension DartPythonCBindingsExtension on DartPythonCBindings {
  /// The Python `None` object.
  ffi.Pointer<PyObject> get Py_None => _Py_NoneStruct;

  /// The Python `True` object.
  ffi.Pointer<PyObject> get Py_True =>
      PyBool_FromLong(Py_TrueStruct.ob_digit[0]);

  /// The Python `False` object.
  ffi.Pointer<PyObject> get Py_False =>
      PyBool_FromLong(Py_FalseStruct.ob_digit[0]);
}
