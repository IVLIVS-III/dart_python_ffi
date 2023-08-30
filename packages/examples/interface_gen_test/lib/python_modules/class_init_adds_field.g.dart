// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library class_init_adds_field;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## ClassInitAddsField
///
/// ### python source
/// ```py
/// class ClassInitAddsField:
///     def __init__(self):
///         self.field = 1
///         self.typed_field: int = 2
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

  /// ## field (getter)
  Object? get field => getAttribute("field");

  /// ## field (setter)
  set field(Object? field) => setAttribute("field", field);

  /// ## typed_field (getter)
  Object? get typed_field => getAttribute("typed_field");

  /// ## typed_field (setter)
  set typed_field(Object? typed_field) =>
      setAttribute("typed_field", typed_field);
}

/// ## class_init_adds_field
///
/// ### python source
/// ```py
/// class ClassInitAddsField:
///     def __init__(self):
///         self.field = 1
///         self.typed_field: int = 2
/// ```
final class class_init_adds_field extends PythonModule {
  class_init_adds_field.from(super.pythonModule) : super.from();

  static class_init_adds_field import() => PythonFfiDart.instance.importModule(
        "class_init_adds_field",
        class_init_adds_field.from,
      );
}
