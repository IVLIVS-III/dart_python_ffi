// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library basic_dataclass;

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
    required String name,
    int x = 0,
    int y = 0,
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
  Null move({
    required int dx,
    required int dy,
  }) =>
      getFunction("move").call(
        <Object?>[
          dx,
          dy,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## x (getter)
  ///
  /// ### python docstring
  ///
  /// Person(name: str, x: int = 0, y: int = 0)
  Object? get x => getAttribute("x");

  /// ## x (setter)
  ///
  /// ### python docstring
  ///
  /// Person(name: str, x: int = 0, y: int = 0)
  set x(Object? x) => setAttribute("x", x);

  /// ## y (getter)
  ///
  /// ### python docstring
  ///
  /// Person(name: str, x: int = 0, y: int = 0)
  Object? get y => getAttribute("y");

  /// ## y (setter)
  ///
  /// ### python docstring
  ///
  /// Person(name: str, x: int = 0, y: int = 0)
  set y(Object? y) => setAttribute("y", y);

  /// ## name (getter)
  ///
  /// ### python docstring
  ///
  /// Person(name: str, x: int = 0, y: int = 0)
  Object? get name => getAttribute("name");

  /// ## name (setter)
  ///
  /// ### python docstring
  ///
  /// Person(name: str, x: int = 0, y: int = 0)
  set name(Object? name) => setAttribute("name", name);
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
