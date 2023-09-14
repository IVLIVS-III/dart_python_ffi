// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library data_class;

import "package:python_ffi/python_ffi.dart";

/// ## DataClass
///
/// ### python docstring
///
/// DataClass(a: int, b: str)
///
/// ### python source
/// ```py
/// @dataclass
/// class DataClass:
///     a: int
///     b: str
///
///     def __post_init__(self):
///         assert self.a > 0
///
///     def __str__(self):
///         return f"{self.a} {self.b}"
/// ```
final class DataClass extends PythonClass {
  factory DataClass({
    required int a,
    required String b,
  }) =>
      PythonFfi.instance.importClass(
        "data_class",
        "DataClass",
        DataClass.from,
        <Object?>[
          a,
          b,
        ],
        <String, Object?>{},
      );

  DataClass.from(super.pythonClass) : super.from();

  /// ## a (getter)
  ///
  /// ### python docstring
  ///
  /// DataClass(a: int, b: str)
  Object? get a => getAttribute("a");

  /// ## a (setter)
  ///
  /// ### python docstring
  ///
  /// DataClass(a: int, b: str)
  set a(Object? a) => setAttribute("a", a);

  /// ## b (getter)
  ///
  /// ### python docstring
  ///
  /// DataClass(a: int, b: str)
  Object? get b => getAttribute("b");

  /// ## b (setter)
  ///
  /// ### python docstring
  ///
  /// DataClass(a: int, b: str)
  set b(Object? b) => setAttribute("b", b);
}

/// ## data_class
///
/// ### python source
/// ```py
/// from dataclasses import dataclass
///
///
/// @dataclass
/// class DataClass:
///     a: int
///     b: str
///
///     def __post_init__(self):
///         assert self.a > 0
///
///     def __str__(self):
///         return f"{self.a} {self.b}"
/// ```
final class data_class extends PythonModule {
  data_class.from(super.pythonModule) : super.from();

  static data_class import() => PythonFfi.instance.importModule(
        "data_class",
        data_class.from,
      );
}
