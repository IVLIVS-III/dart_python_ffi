// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library module_function;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## module_function
///
/// ### python source
/// ```py
/// def function() -> int:
///     return 1
/// ```
final class module_function extends PythonModule {
  module_function.from(super.pythonModule) : super.from();

  static module_function import() => PythonFfiDart.instance.importModule(
        "module_function",
        module_function.from,
      );

  /// ## function
  ///
  /// ### python source
  /// ```py
  /// def function() -> int:
  ///     return 1
  /// ```
  int function() => getFunction("function").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );
}
