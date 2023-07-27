// ignore_for_file: camel_case_types, non_constant_identifier_names

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## ClassInitAddsField
///
/// ### python source
/// ```py
/// class ClassInitAddsField:
///     def __init__(self):
///         self.field = 1
/// ```
final class ClassInitAddsField extends PythonClass {
  factory ClassInitAddsField() => PythonFfiDart.instance.importClass(
        "class_init_adds_field",
        "ClassInitAddsField",
        ClassInitAddsField.from,
        <Object?>[],
        <String, Object?>{},
      );

  ClassInitAddsField.from(super.pythonClass) : super.from();

  Object? get field => getAttribute("field");

  set field(Object? field) => setAttribute("field", field);
}

/// ## class_init_adds_field
///
/// ### python source
/// ```py
/// class ClassInitAddsField:
///     def __init__(self):
///         self.field = 1
/// ```
final class class_init_adds_field extends PythonModule {
  class_init_adds_field.from(super.pythonModule) : super.from();

  static class_init_adds_field import() => PythonFfiDart.instance.importModule(
        "class_init_adds_field",
        class_init_adds_field.from,
      );
}
