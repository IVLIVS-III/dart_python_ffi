// ignore_for_file: camel_case_types, non_constant_identifier_names

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## Person
///
/// ### python docstring
///
/// Person(name: str, x: int = 0, y: int = 0)
///
/// ### python source
/// ```py
/// @dataclass
/// class Person:
///     name: str
///     x: int = 0
///     y: int = 0
///
///     def move(self, dx: int, dy: int) -> None:
///         self.x += dx
///         self.y += dy
///
///     def __str__(self) -> str:
///         return f"{self.name} @ ({self.x}, {self.y})"
/// ```
final class Person extends PythonClass {
  factory Person({
    required Object? name,
    Object? x = 0,
    Object? y = 0,
  }) =>
      PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "Person",
        Person.from,
        <Object?>[
          name,
          x,
          y,
        ],
        <String, Object?>{},
      );

  Person.from(super.pythonClass) : super.from();

  /// ## __eq__
  Object? __eq__({
    required Object? other,
  }) =>
      getFunction("__eq__").call(
        <Object?>[
          other,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## __init__
  Object? __init__({
    required Object? name,
    Object? x = 0,
    Object? y = 0,
  }) =>
      getFunction("__init__").call(
        <Object?>[
          name,
          x,
          y,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## __repr__
  Object? __repr__() => getFunction("__repr__").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## __str__
  ///
  /// ### python source
  /// ```py
  /// def __str__(self) -> str:
  ///         return f"{self.name} @ ({self.x}, {self.y})"
  /// ```
  Object? __str__() => getFunction("__str__").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## move
  ///
  /// ### python source
  /// ```py
  /// def move(self, dx: int, dy: int) -> None:
  ///         self.x += dx
  ///         self.y += dy
  /// ```
  Object? move({
    required Object? dx,
    required Object? dy,
  }) =>
      getFunction("move").call(
        <Object?>[
          dx,
          dy,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## __class__
final class __class__ extends PythonClass {
  factory __class__() => PythonFfiDart.instance.importClass(
        "builtins",
        "__class__",
        __class__.from,
        <Object?>[],
      );

  __class__.from(super.pythonClass) : super.from();
}

/// ## __objclass__
final class __objclass__ extends PythonClass {
  factory __objclass__() => PythonFfiDart.instance.importClass(
        "builtins",
        "__objclass__",
        __objclass__.from,
        <Object?>[],
      );

  __objclass__.from(super.pythonClass) : super.from();
}

/// ## basic_dataclass
///
/// ### python source
/// ```py
/// from dataclasses import dataclass
///
/// @dataclass
/// class Person:
///     name: str
///     x: int = 0
///     y: int = 0
///
///     def move(self, dx: int, dy: int) -> None:
///         self.x += dx
///         self.y += dy
///
///     def __str__(self) -> str:
///         return f"{self.name} @ ({self.x}, {self.y})"
/// ```
final class basic_dataclass extends PythonModule {
  basic_dataclass.from(super.pythonModule) : super.from();

  static basic_dataclass import() => PythonFfiDart.instance.importModule(
        "basic_dataclass",
        basic_dataclass.from,
      );
}
