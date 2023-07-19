// ignore_for_file: camel_case_types, non_constant_identifier_names

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## basic_cli_adder
///
/// ### python source
/// ```py
/// num = int | float
///
/// def add(x: num, y: num) -> num:
///     return x + y
/// ```
final class basic_cli_adder extends PythonModule {
  basic_cli_adder.from(super.pythonModule) : super.from();

  static basic_cli_adder import() => PythonFfiDart.instance.importModule(
        "basic_cli_adder",
        basic_cli_adder.from,
      );

  /// ## add
  Object? add({
    required Object? x,
    required Object? y,
  }) =>
      getFunction("add").call(<Object?>[
        x,
        y,
      ]);
}
