// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library module_field;

import "dart:typed_data";

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## module_field
///
/// ### python source
/// ```py
/// field: int = 1
/// ```
final class module_field extends PythonModule {
  module_field.from(super.pythonModule) : super.from();

  static module_field import() => PythonFfiDart.instance.importModule(
        "module_field",
        module_field.from,
      );

  /// ## field (getter)
  Object? get field => getAttribute("field");

  /// ## field (setter)
  set field(Object? field) => setAttribute("field", field);
}
