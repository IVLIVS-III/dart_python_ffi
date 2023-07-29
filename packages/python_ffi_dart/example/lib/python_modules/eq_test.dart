import "package:python_ffi_dart/python_ffi_dart.dart";

final class HasEq extends PythonClass {
  factory HasEq({required int a}) => PythonFfiDart.instance.importClass(
        "eq_test",
        "HasEq",
        HasEq.from,
        <Object?>[a],
        <String, Object?>{},
      );

  HasEq.from(super.classDelegate) : super.from();
}

final class NoEq extends PythonClass {
  factory NoEq({required int a}) => PythonFfiDart.instance.importClass(
        "eq_test",
        "NoEq",
        NoEq.from,
        <Object?>[a],
        <String, Object?>{},
      );

  NoEq.from(super.classDelegate) : super.from();
}
