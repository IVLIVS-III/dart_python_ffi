// ignore_for_file: camel_case_types

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## Person
///
/// ### python docstring
/// Person(name: str, x: int = 0, y: int = 0)
final class Person extends PythonClass {
  factory Person(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "Person",
        Person.from,
        <Object?>[name],
      );

  Person.from(super.pythonClass) : super.from();

  /// ## move
  Object? move(Object? self, Object? dx, Object? dy) =>
      getFunction("move").call(<Object?>[self, dx, dy]);
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

  static basic_dataclass import() => PythonFfiDart.instance
      .importModule("basic_dataclass", basic_dataclass.from);

  /// ## dataclass
  ///
  /// ### python docstring
  /// Add dunder methods based on the fields defined in the class.
  ///
  ///     Examines PEP 526 __annotations__ to determine fields.
  ///
  ///     If init is true, an __init__() method is added to the class. If repr
  ///     is true, a __repr__() method is added. If order is true, rich
  ///     comparison dunder methods are added. If unsafe_hash is true, a
  ///     __hash__() method is added. If frozen is true, fields may not be
  ///     assigned to after instance creation. If match_args is true, the
  ///     __match_args__ tuple is added. If kw_only is true, then by default
  ///     all fields are keyword-only. If slots is true, a new class with a
  ///     __slots__ attribute is returned.
  Object? dataclass(
          Object? cls,
          Object? init,
          Object? repr,
          Object? eq,
          Object? order,
          Object? unsafe_hash,
          Object? frozen,
          Object? match_args,
          Object? kw_only,
          Object? slots,
          Object? weakref_slot,
          Object? wrap) =>
      getFunction("dataclass").call(<Object?>[
        cls,
        init,
        repr,
        eq,
        order,
        unsafe_hash,
        frozen,
        match_args,
        kw_only,
        slots,
        weakref_slot,
        wrap
      ]);
}
