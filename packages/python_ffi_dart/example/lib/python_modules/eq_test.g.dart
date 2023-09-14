// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library eq_test;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## HasEq
///
/// ### python docstring
///
/// HasEq(a: int)
///
/// ### python source
/// ```py
/// @dataclass()
/// class HasEq:
///     a: int
/// ```
final class HasEq extends PythonClass {
  factory HasEq({
    required int a,
  }) =>
      PythonFfiDart.instance.importClass(
        "eq_test",
        "HasEq",
        HasEq.from,
        <Object?>[
          a,
        ],
        <String, Object?>{},
      );

  HasEq.from(super.pythonClass) : super.from();

  /// ## a (getter)
  ///
  /// ### python docstring
  ///
  /// HasEq(a: int)
  Object? get a => getAttribute("a");

  /// ## a (setter)
  ///
  /// ### python docstring
  ///
  /// HasEq(a: int)
  set a(Object? a) => setAttribute("a", a);
}

/// ## NoEq
///
/// ### python source
/// ```py
/// class NoEq:
///     def __init__(self, a: int):
///         self.a = a
/// ```
final class NoEq extends PythonClass {
  factory NoEq({
    required int a,
  }) =>
      PythonFfiDart.instance.importClass(
        "eq_test",
        "NoEq",
        NoEq.from,
        <Object?>[
          a,
        ],
        <String, Object?>{},
      );

  NoEq.from(super.pythonClass) : super.from();

  /// ## a (getter)
  Object? get a => getAttribute("a");

  /// ## a (setter)
  set a(Object? a) => setAttribute("a", a);
}

/// ## eq_test
///
/// ### python source
/// ```py
/// from dataclasses import dataclass
///
/// @dataclass()
/// class HasEq:
///     a: int
///
/// class NoEq:
///     def __init__(self, a: int):
///         self.a = a
/// ```
final class eq_test extends PythonModule {
  eq_test.from(super.pythonModule) : super.from();

  static eq_test import() => PythonFfiDart.instance.importModule(
        "eq_test",
        eq_test.from,
      );
}
