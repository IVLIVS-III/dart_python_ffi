// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library class_types;

import "dart:typed_data";

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## A
///
/// ### python docstring
///
/// A()
///
/// ### python source
/// ```py
/// @dataclass
/// class A:
///     def get(self: Self) -> 'A':
///         return A()
///
///     def set(self: Self, _: 'A') -> bool:
///         return _ == A()
/// ```
final class A extends PythonClass {
  factory A() => PythonFfiDart.instance.importClass(
        "class_types",
        "A",
        A.from,
        <Object?>[],
        <String, Object?>{},
      );

  A.from(super.pythonClass) : super.from();

  /// ## get
  ///
  /// ### python source
  /// ```py
  /// def get(self: Self) -> 'A':
  ///         return A()
  /// ```
  A $get() => A.from(
        getFunction("get").call(
          <Object?>[],
          kwargs: <String, Object?>{},
        ),
      );

  /// ## set
  ///
  /// ### python source
  /// ```py
  /// def set(self: Self, _: 'A') -> bool:
  ///         return _ == A()
  /// ```
  bool $set({
    required A $_,
  }) =>
      getFunction("set").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## class_types
///
/// ### python source
/// ```py
/// from dataclasses import dataclass
/// from typing import Self
///
///
/// @dataclass
/// class A:
///     def get(self: Self) -> 'A':
///         return A()
///
///     def set(self: Self, _: 'A') -> bool:
///         return _ == A()
///
///
/// def get_A() -> A: return A()
/// def get_list_A() -> list[A]: return [A()]
/// def get_map_A() -> dict[str, A]: return {"a": A()}
///
///
/// def set_A(_: A) -> bool: return _ == get_A()
/// def set_list_A(_: list[A]) -> bool: return _ == get_list_A()
/// def set_map_A(_: dict[str, A]) -> bool: return _ == get_map_A()
/// ```
final class class_types extends PythonModule {
  class_types.from(super.pythonModule) : super.from();

  static class_types import() => PythonFfiDart.instance.importModule(
        "class_types",
        class_types.from,
      );

  /// ## get_A
  ///
  /// ### python source
  /// ```py
  /// def get_A() -> A: return A()
  /// ```
  A get_A() => A.from(
        getFunction("get_A").call(
          <Object?>[],
          kwargs: <String, Object?>{},
        ),
      );

  /// ## get_list_A
  ///
  /// ### python source
  /// ```py
  /// def get_list_A() -> list[A]: return [A()]
  /// ```
  List<A> get_list_A() => List<A>.from(
        List.from(
          getFunction("get_list_A").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ).map(
          (e) => A.from(
            e,
          ),
        ),
      );

  /// ## get_map_A
  ///
  /// ### python source
  /// ```py
  /// def get_map_A() -> dict[str, A]: return {"a": A()}
  /// ```
  Map<String, A> get_map_A() => Map<String, A>.from(
        Map.from(
          getFunction("get_map_A").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ).map(
          (k, v) => MapEntry(
            k,
            A.from(
              v,
            ),
          ),
        ),
      );

  /// ## set_A
  ///
  /// ### python source
  /// ```py
  /// def set_A(_: A) -> bool: return _ == get_A()
  /// ```
  bool set_A({
    required A $_,
  }) =>
      getFunction("set_A").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_list_A
  ///
  /// ### python source
  /// ```py
  /// def set_list_A(_: list[A]) -> bool: return _ == get_list_A()
  /// ```
  bool set_list_A({
    required List<A> $_,
  }) =>
      getFunction("set_list_A").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_map_A
  ///
  /// ### python source
  /// ```py
  /// def set_map_A(_: dict[str, A]) -> bool: return _ == get_map_A()
  /// ```
  bool set_map_A({
    required Map<String, A> $_,
  }) =>
      getFunction("set_map_A").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );
}
