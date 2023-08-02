// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library primitive_types;

import "dart:typed_data";

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## num
typedef $num = Object?;

/// ## primitive_types
///
/// ### python source
/// ```py
/// from typing import Any, Callable, Generator, Iterable, Iterator
///
///
/// num = int | float
///
///
/// def get_None() -> None: return None
/// def get_bool() -> bool: return True
/// def get_int() -> int: return 1
/// def get_float() -> float: return 3.14
/// def get_num() -> num: return 3.14
/// def get_str() -> str: return "lorem ipsum"
/// def get_bytes() -> bytes: return b"lorem ipsum"
/// def get_dict() -> dict[str, int]: return {"a": 1, "b": 2}
/// def get_dict_nested() -> dict[str, dict[str, int]]: return {"a": {"b": 1}}
/// def get_list() -> list[int]: return [1, 2, 3]
/// def get_list_implicit() -> list: return [1, "a", False]
/// def get_list_nested() -> list[list[int]]: return [[1, 2], [3, 4]]
/// def get_tuple() -> tuple[int, ...]: return (1, 2, 3)
/// def get_set() -> set[int]: return {1, 2, 3}
/// def get_container_nested() -> list[list[set[int]]]: return [[{1, 2}, {3, 4}], [{5, 6}, {7, 8}]]
/// def get_Iterator() -> Iterator[int]: return iter([1, 2, 3])
/// def get_Iterator_nested() -> Iterator[list[int]]: return iter([[1, 2], [3, 4]])
/// def get_Generator() -> Generator[int, None, None]: return (i for i in [1, 2, 3])
/// def get_Iterable() -> Iterable[int]: return [1, 2, 3]
/// def get_Callable() -> Callable[[int], str]: return lambda x: str(x)
/// def get_Any() -> Any: return 1
/// def get_Any_implicit(): return 1
///
/// def set_None(_: None) -> bool: return _ == get_None()
/// def set_bool(_: bool) -> bool: return _ == get_bool()
/// def set_int(_: int) -> bool: return _ == get_int()
/// def set_float(_: float) -> bool: return _ == get_float()
/// def set_num(_: num) -> bool: return _ == get_num() or _ == get_float() or _ == get_int()
/// def set_str(_: str) -> bool: return _ == get_str()
/// def set_bytes(_: bytes) -> bool: return _ == get_bytes()
/// def set_dict(_: dict[str, int]) -> bool: return _ == get_dict()
/// def set_dict_nested(_: dict[str, dict[str, int]]) -> bool: return _ == get_dict_nested()
/// def set_list(_: list[int]) -> bool: return _ == get_list()
/// def set_list_implicit(_: list) -> bool: return _ == get_list_implicit()
/// def set_list_nested(_: list[list[int]]) -> bool: return _ == get_list_nested()
/// def set_tuple(_: tuple[int, ...]) -> bool: return _ == get_tuple()
/// def set_set(_: set[int]) -> bool: return _ == get_set()
/// def set_container_nested(_: list[list[set[int]]]) -> bool: return _ == get_container_nested()
/// def set_Iterator(_: Iterator[int]) -> bool: return list(_) == list(get_Iterator())
/// def set_Iterator_nested(_: Iterator[list[int]]) -> bool: return list(_) == list(get_Iterator_nested())
/// def set_Generator(_: Generator[int, None, None]) -> bool: return list(_) == list(get_Generator())
/// def set_Iterable(_: Iterable[int]) -> bool: return list(_) == list(get_Iterable())
/// def set_Callable(_: Callable[[int], str]) -> bool: return _(1) == get_Callable()(1)
/// def set_Any(_: Any) -> bool: return _ == get_Any()
/// def set_Any_implicit(_) -> bool: return _ == get_Any_implicit()
/// ```
final class primitive_types extends PythonModule {
  primitive_types.from(super.pythonModule) : super.from();

  static primitive_types import() => PythonFfiDart.instance.importModule(
        "primitive_types",
        primitive_types.from,
      );

  /// ## get_Any
  ///
  /// ### python source
  /// ```py
  /// def get_Any() -> Any: return 1
  /// ```
  Object? get_Any() => getFunction("get_Any").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## get_Any_implicit
  ///
  /// ### python source
  /// ```py
  /// def get_Any_implicit(): return 1
  /// ```
  Object? get_Any_implicit() => getFunction("get_Any_implicit").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## get_Callable
  ///
  /// ### python source
  /// ```py
  /// def get_Callable() -> Callable[[int], str]: return lambda x: str(x)
  /// ```
  String Function(int) get_Callable() => PythonFunction.from(
        getFunction("get_Callable").call(
          <Object?>[],
          kwargs: <String, Object?>{},
        ),
      ).asFunction(
        (PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?> f) =>
            (int x0) => f.call(<Object?>[x0]),
      );

  /// ## get_Generator
  ///
  /// ### python source
  /// ```py
  /// def get_Generator() -> Generator[int, None, None]: return (i for i in [1, 2, 3])
  /// ```
  Iterator<int> get_Generator() => TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("get_Generator").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ),
      ).transform((e) => e).cast<int>();

  /// ## get_Iterable
  ///
  /// ### python source
  /// ```py
  /// def get_Iterable() -> Iterable[int]: return [1, 2, 3]
  /// ```
  Iterable<int> get_Iterable() => TypedIterable.from(
        PythonIterable.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("get_Iterable").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ),
      ).transform((e) => e).cast<int>();

  /// ## get_Iterator
  ///
  /// ### python source
  /// ```py
  /// def get_Iterator() -> Iterator[int]: return iter([1, 2, 3])
  /// ```
  Iterator<int> get_Iterator() => TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("get_Iterator").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ),
      ).transform((e) => e).cast<int>();

  /// ## get_Iterator_nested
  ///
  /// ### python source
  /// ```py
  /// def get_Iterator_nested() -> Iterator[list[int]]: return iter([[1, 2], [3, 4]])
  /// ```
  Iterator<List<int>> get_Iterator_nested() => TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("get_Iterator_nested").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ),
      )
          .transform((e) => List<int>.from(
                List.from(
                  e,
                ).map(
                  (e) => e,
                ),
              ))
          .cast<List<int>>();

  /// ## get_None
  ///
  /// ### python source
  /// ```py
  /// def get_None() -> None: return None
  /// ```
  Null get_None() => getFunction("get_None").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## get_bool
  ///
  /// ### python source
  /// ```py
  /// def get_bool() -> bool: return True
  /// ```
  bool get_bool() => getFunction("get_bool").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## get_bytes
  ///
  /// ### python source
  /// ```py
  /// def get_bytes() -> bytes: return b"lorem ipsum"
  /// ```
  Uint8List get_bytes() => getFunction("get_bytes").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## get_container_nested
  ///
  /// ### python source
  /// ```py
  /// def get_container_nested() -> list[list[set[int]]]: return [[{1, 2}, {3, 4}], [{5, 6}, {7, 8}]]
  /// ```
  List<List<Set<int>>> get_container_nested() => List<List<Set<int>>>.from(
        List.from(
          getFunction("get_container_nested").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ).map(
          (e) => List<Set<int>>.from(
            List.from(
              e,
            ).map(
              (e) => Set<int>.from(
                Set.from(
                  e,
                ).map(
                  (e) => e,
                ),
              ),
            ),
          ),
        ),
      );

  /// ## get_dict
  ///
  /// ### python source
  /// ```py
  /// def get_dict() -> dict[str, int]: return {"a": 1, "b": 2}
  /// ```
  Map<String, int> get_dict() => Map<String, int>.from(
        Map.from(
          getFunction("get_dict").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ).map(
          (k, v) => MapEntry(
            k,
            v,
          ),
        ),
      );

  /// ## get_dict_nested
  ///
  /// ### python source
  /// ```py
  /// def get_dict_nested() -> dict[str, dict[str, int]]: return {"a": {"b": 1}}
  /// ```
  Map<String, Map<String, int>> get_dict_nested() =>
      Map<String, Map<String, int>>.from(
        Map.from(
          getFunction("get_dict_nested").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ).map(
          (k, v) => MapEntry(
            k,
            Map<String, int>.from(
              Map.from(
                v,
              ).map(
                (k, v) => MapEntry(
                  k,
                  v,
                ),
              ),
            ),
          ),
        ),
      );

  /// ## get_float
  ///
  /// ### python source
  /// ```py
  /// def get_float() -> float: return 3.14
  /// ```
  double get_float() => getFunction("get_float").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## get_int
  ///
  /// ### python source
  /// ```py
  /// def get_int() -> int: return 1
  /// ```
  int get_int() => getFunction("get_int").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## get_list
  ///
  /// ### python source
  /// ```py
  /// def get_list() -> list[int]: return [1, 2, 3]
  /// ```
  List<int> get_list() => List<int>.from(
        List.from(
          getFunction("get_list").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ).map(
          (e) => e,
        ),
      );

  /// ## get_list_implicit
  ///
  /// ### python source
  /// ```py
  /// def get_list_implicit() -> list: return [1, "a", False]
  /// ```
  List get_list_implicit() => getFunction("get_list_implicit").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## get_list_nested
  ///
  /// ### python source
  /// ```py
  /// def get_list_nested() -> list[list[int]]: return [[1, 2], [3, 4]]
  /// ```
  List<List<int>> get_list_nested() => List<List<int>>.from(
        List.from(
          getFunction("get_list_nested").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ).map(
          (e) => List<int>.from(
            List.from(
              e,
            ).map(
              (e) => e,
            ),
          ),
        ),
      );

  /// ## get_num
  ///
  /// ### python source
  /// ```py
  /// def get_num() -> num: return 3.14
  /// ```
  Object? get_num() => getFunction("get_num").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## get_set
  ///
  /// ### python source
  /// ```py
  /// def get_set() -> set[int]: return {1, 2, 3}
  /// ```
  Set<int> get_set() => Set<int>.from(
        Set.from(
          getFunction("get_set").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ).map(
          (e) => e,
        ),
      );

  /// ## get_str
  ///
  /// ### python source
  /// ```py
  /// def get_str() -> str: return "lorem ipsum"
  /// ```
  String get_str() => getFunction("get_str").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## get_tuple
  ///
  /// ### python source
  /// ```py
  /// def get_tuple() -> tuple[int, ...]: return (1, 2, 3)
  /// ```
  List<int> get_tuple() => List<int>.from(
        List.from(
          getFunction("get_tuple").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ).map(
          (e) => e,
        ),
      );

  /// ## set_Any
  ///
  /// ### python source
  /// ```py
  /// def set_Any(_: Any) -> bool: return _ == get_Any()
  /// ```
  bool set_Any({
    required Object? $_,
  }) =>
      getFunction("set_Any").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_Any_implicit
  ///
  /// ### python source
  /// ```py
  /// def set_Any_implicit(_) -> bool: return _ == get_Any_implicit()
  /// ```
  bool set_Any_implicit({
    required Object? $_,
  }) =>
      getFunction("set_Any_implicit").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_Callable
  ///
  /// ### python source
  /// ```py
  /// def set_Callable(_: Callable[[int], str]) -> bool: return _(1) == get_Callable()(1)
  /// ```
  bool set_Callable({
    required String Function(int) $_,
  }) =>
      getFunction("set_Callable").call(
        <Object?>[
          $_.generic1,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_Generator
  ///
  /// ### python source
  /// ```py
  /// def set_Generator(_: Generator[int, None, None]) -> bool: return list(_) == list(get_Generator())
  /// ```
  bool set_Generator({
    required Iterator<int> $_,
  }) =>
      getFunction("set_Generator").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_Iterable
  ///
  /// ### python source
  /// ```py
  /// def set_Iterable(_: Iterable[int]) -> bool: return list(_) == list(get_Iterable())
  /// ```
  bool set_Iterable({
    required Iterable<int> $_,
  }) =>
      getFunction("set_Iterable").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_Iterator
  ///
  /// ### python source
  /// ```py
  /// def set_Iterator(_: Iterator[int]) -> bool: return list(_) == list(get_Iterator())
  /// ```
  bool set_Iterator({
    required Iterator<int> $_,
  }) =>
      getFunction("set_Iterator").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_Iterator_nested
  ///
  /// ### python source
  /// ```py
  /// def set_Iterator_nested(_: Iterator[list[int]]) -> bool: return list(_) == list(get_Iterator_nested())
  /// ```
  bool set_Iterator_nested({
    required Iterator<List<int>> $_,
  }) =>
      getFunction("set_Iterator_nested").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_None
  ///
  /// ### python source
  /// ```py
  /// def set_None(_: None) -> bool: return _ == get_None()
  /// ```
  bool set_None({
    required Null $_,
  }) =>
      getFunction("set_None").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_bool
  ///
  /// ### python source
  /// ```py
  /// def set_bool(_: bool) -> bool: return _ == get_bool()
  /// ```
  bool set_bool({
    required bool $_,
  }) =>
      getFunction("set_bool").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_bytes
  ///
  /// ### python source
  /// ```py
  /// def set_bytes(_: bytes) -> bool: return _ == get_bytes()
  /// ```
  bool set_bytes({
    required Uint8List $_,
  }) =>
      getFunction("set_bytes").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_container_nested
  ///
  /// ### python source
  /// ```py
  /// def set_container_nested(_: list[list[set[int]]]) -> bool: return _ == get_container_nested()
  /// ```
  bool set_container_nested({
    required List<List<Set<int>>> $_,
  }) =>
      getFunction("set_container_nested").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_dict
  ///
  /// ### python source
  /// ```py
  /// def set_dict(_: dict[str, int]) -> bool: return _ == get_dict()
  /// ```
  bool set_dict({
    required Map<String, int> $_,
  }) =>
      getFunction("set_dict").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_dict_nested
  ///
  /// ### python source
  /// ```py
  /// def set_dict_nested(_: dict[str, dict[str, int]]) -> bool: return _ == get_dict_nested()
  /// ```
  bool set_dict_nested({
    required Map<String, Map<String, int>> $_,
  }) =>
      getFunction("set_dict_nested").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_float
  ///
  /// ### python source
  /// ```py
  /// def set_float(_: float) -> bool: return _ == get_float()
  /// ```
  bool set_float({
    required double $_,
  }) =>
      getFunction("set_float").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_int
  ///
  /// ### python source
  /// ```py
  /// def set_int(_: int) -> bool: return _ == get_int()
  /// ```
  bool set_int({
    required int $_,
  }) =>
      getFunction("set_int").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_list
  ///
  /// ### python source
  /// ```py
  /// def set_list(_: list[int]) -> bool: return _ == get_list()
  /// ```
  bool set_list({
    required List<int> $_,
  }) =>
      getFunction("set_list").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_list_implicit
  ///
  /// ### python source
  /// ```py
  /// def set_list_implicit(_: list) -> bool: return _ == get_list_implicit()
  /// ```
  bool set_list_implicit({
    required List $_,
  }) =>
      getFunction("set_list_implicit").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_list_nested
  ///
  /// ### python source
  /// ```py
  /// def set_list_nested(_: list[list[int]]) -> bool: return _ == get_list_nested()
  /// ```
  bool set_list_nested({
    required List<List<int>> $_,
  }) =>
      getFunction("set_list_nested").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_num
  ///
  /// ### python source
  /// ```py
  /// def set_num(_: num) -> bool: return _ == get_num() or _ == get_float() or _ == get_int()
  /// ```
  bool set_num({
    required Object? $_,
  }) =>
      getFunction("set_num").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_set
  ///
  /// ### python source
  /// ```py
  /// def set_set(_: set[int]) -> bool: return _ == get_set()
  /// ```
  bool set_set({
    required Set<int> $_,
  }) =>
      getFunction("set_set").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_str
  ///
  /// ### python source
  /// ```py
  /// def set_str(_: str) -> bool: return _ == get_str()
  /// ```
  bool set_str({
    required String $_,
  }) =>
      getFunction("set_str").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_tuple
  ///
  /// ### python source
  /// ```py
  /// def set_tuple(_: tuple[int, ...]) -> bool: return _ == get_tuple()
  /// ```
  bool set_tuple({
    required PythonTuple<int> $_,
  }) =>
      getFunction("set_tuple").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );
}
