import "package:python_ffi_dart/python_ffi_dart.dart";

class PyTimeParse extends PythonModule {
  PyTimeParse.from(super.pythonModule) : super.from();

  static PyTimeParse import() =>
      PythonFfiDart.instance.importModule("pytimeparse", PyTimeParse.from);

  num? parse(String timeStr) => getFunction("parse").call(<Object?>[timeStr]);
}
