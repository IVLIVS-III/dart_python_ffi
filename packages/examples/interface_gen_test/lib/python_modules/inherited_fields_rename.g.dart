// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library inherited_fields_rename;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## Class
///
/// ### python docstring
///
/// Class()
///
/// ### python source
/// ```py
/// @dataclass
/// class Class:
///     initializer: int = field(init=False, default=1)
///
///     def newInstance(self: Self) -> int:
///         return 1
/// ```
final class Class extends PythonClass {
  factory Class() => PythonFfiDart.instance.importClass(
        "inherited_fields_rename",
        "Class",
        Class.from,
        <Object?>[],
        <String, Object?>{},
      );

  Class.from(super.pythonClass) : super.from();

  /// ## newInstance
  ///
  /// ### python source
  /// ```py
  /// def newInstance(self: Self) -> int:
  ///         return 1
  /// ```
  int $newInstance() => getFunction("newInstance").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## initializer (getter)
  ///
  /// ### python docstring
  ///
  /// Class()
  Object? get $initializer => getAttribute("initializer");

  /// ## initializer (setter)
  ///
  /// ### python docstring
  ///
  /// Class()
  set $initializer(Object? $initializer) =>
      setAttribute("initializer", $initializer);
}

/// ## inherited_fields_rename
///
/// ### python source
/// ```py
/// from dataclasses import dataclass, field
/// from typing import Self
///
///
/// @dataclass
/// class Class:
///     initializer: int = field(init=False, default=1)
///
///     def newInstance(self: Self) -> int:
///         return 1
///
///
/// def noSuchMethod():
///     return 1
///
///
/// getClass: int = 1
/// ```
final class inherited_fields_rename extends PythonModule {
  inherited_fields_rename.from(super.pythonModule) : super.from();

  static inherited_fields_rename import() =>
      PythonFfiDart.instance.importModule(
        "inherited_fields_rename",
        inherited_fields_rename.from,
      );

  /// ## noSuchMethod
  ///
  /// ### python source
  /// ```py
  /// def noSuchMethod():
  ///     return 1
  /// ```
  Object? $noSuchMethod() => getFunction("noSuchMethod").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## getClass (getter)
  Object? get $getClass => getAttribute("getClass");

  /// ## getClass (setter)
  set $getClass(Object? $getClass) => setAttribute("getClass", $getClass);
}
