// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library basic_adder;

import "package:python_ffi/python_ffi.dart";

/// ## num
typedef $num = Object?;

/// ## basic_adder
///
/// ### python source
/// ```py
/// num = int | float
///
/// def add(x: num, y: num) -> num:
///     """Adds x and y together"""
///     return x + y
/// ```
final class basic_adder extends PythonModule {
  basic_adder.from(super.pythonModule) : super.from();

  static basic_adder import() => PythonFfi.instance.importModule(
        "basic_adder",
        basic_adder.from,
      );

  /// ## add
  ///
  /// ### python docstring
  ///
  /// Adds x and y together
  ///
  /// ### python source
  /// ```py
  /// def add(x: num, y: num) -> num:
  ///     """Adds x and y together"""
  ///     return x + y
  /// ```
  Object? add({
    required Object? x,
    required Object? y,
  }) =>
      getFunction("add").call(
        <Object?>[
          x,
          y,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## num (getter)
  Object? get $num => getAttribute("num");

  /// ## num (setter)
  set $num(Object? $num) => setAttribute("num", $num);
}
