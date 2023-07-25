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

  Object? get x => getAttribute("x");

  set x(Object? x) => setAttribute("x", x);

  Object? get y => getAttribute("y");

  set y(Object? y) => setAttribute("y", y);
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
