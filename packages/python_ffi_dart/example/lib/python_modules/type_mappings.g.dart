// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library type_mappings;

import "dart:typed_data";

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## CustomIterable
///
/// ### python docstring
///
/// CustomIterable(_CustomIterable__iterable: Iterable[~T])
final class CustomIterable extends PythonClass {
  factory CustomIterable({
    required Iterable<Object?> $_CustomIterable__iterable,
  }) =>
      PythonFfiDart.instance.importClass(
        "type_mappings",
        "CustomIterable",
        CustomIterable.from,
        <Object?>[
          $_CustomIterable__iterable,
        ],
        <String, Object?>{},
      );

  CustomIterable.from(super.pythonClass) : super.from();

  /// ## _CustomIterable__iterable (getter)
  ///
  /// ### python docstring
  ///
  /// CustomIterable(_CustomIterable__iterable: Iterable[~T])
  Object? get _CustomIterable__iterable =>
      getAttribute("_CustomIterable__iterable");

  /// ## _CustomIterable__iterable (setter)
  ///
  /// ### python docstring
  ///
  /// CustomIterable(_CustomIterable__iterable: Iterable[~T])
  set _CustomIterable__iterable(Object? _CustomIterable__iterable) =>
      setAttribute("_CustomIterable__iterable", _CustomIterable__iterable);
}

/// ## CustomIterator
///
/// ### python docstring
///
/// CustomIterator(_CustomIterator__iterator: Iterator[~T])
final class CustomIterator extends PythonClass {
  factory CustomIterator({
    required Iterator<Object?> $_CustomIterator__iterator,
  }) =>
      PythonFfiDart.instance.importClass(
        "type_mappings",
        "CustomIterator",
        CustomIterator.from,
        <Object?>[
          $_CustomIterator__iterator,
        ],
        <String, Object?>{},
      );

  CustomIterator.from(super.pythonClass) : super.from();

  /// ## _CustomIterator__iterator (getter)
  ///
  /// ### python docstring
  ///
  /// CustomIterator(_CustomIterator__iterator: Iterator[~T])
  Object? get _CustomIterator__iterator =>
      getAttribute("_CustomIterator__iterator");

  /// ## _CustomIterator__iterator (setter)
  ///
  /// ### python docstring
  ///
  /// CustomIterator(_CustomIterator__iterator: Iterator[~T])
  set _CustomIterator__iterator(Object? _CustomIterator__iterator) =>
      setAttribute("_CustomIterator__iterator", _CustomIterator__iterator);
}

/// ## type_mappings
///
/// ### python source
/// ```py
/// from dataclasses import dataclass
/// from typing import Any, Callable, Generator, Iterable, Iterator, Self, TypeVar, Generic
///
///
/// T = TypeVar("T")
///
///
/// @dataclass
/// class CustomIterator(Generic[T]):
///     __iterator: Iterator[T]
///
///     def __iter__(self: Self) -> Self:
///         return self
///
///     def __next__(self: Self) -> T:
///         return next(self.__iterator)
///
///
/// @dataclass
/// class CustomIterable(Generic[T]):
///     __iterable: Iterable[T]
///
///     def __iter__(self: Self) -> CustomIterator[T]:
///         return CustomIterator(iter(self.__iterable))
///
///
/// kInt: int = 42
/// kFloat: float = 3.14
/// kStr: str = "Hello World"
/// kBytes: bytes = b"Hello World"
/// kDict: dict[str, int] = {"one": 1, "two": 2, "three": 3}
/// kList: list[int] = [1, 2, 3]
/// kTuple: tuple[int, ...] = (1, 2, 3)
/// kSet: set[int] = set([1, 2, 3])
/// kIteratorElements: list[int] = [1, 2, 3]
/// kIterableElements: list[int] = [1, 2, 3]
/// kCallableArg: int = 1
/// kCallableResult: int = 2
///
///
/// def __assert_type(value: Any, t: type):
///     assert isinstance(value, t), f"expected {t}, but got {type(value)}"
///
///
/// def receive_none(value: None):
///     assert value is None
///
///
/// def request_none() -> None:
///     return None
///
///
/// def receive_bool_true(value: bool):
///     __assert_type(value, bool)
///     assert value is True
///
///
/// def request_bool_true() -> bool:
///     return True
///
///
/// def receive_bool_false(value: bool):
///     __assert_type(value, bool)
///     assert value is False
///
///
/// def request_bool_false() -> bool:
///     return False
///
///
/// def receive_int(value: int):
///     __assert_type(value, int)
///     assert value == kInt
///
///
/// def request_int() -> int:
///     return kInt
///
///
/// def receive_float(value: float):
///     __assert_type(value, float)
///     assert value == kFloat
///
///
/// def request_float() -> float:
///     return kFloat
///
///
/// def receive_str(value: str):
///     __assert_type(value, str)
///     assert value == kStr
///
///
/// def request_str() -> str:
///     return kStr
///
///
/// def receive_bytes(value: bytes):
///     __assert_type(value, bytes)
///     assert value == kBytes
///
///
/// def request_bytes() -> bytes:
///     return kBytes
///
///
/// def receive_dict(value: dict[str, int]):
///     __assert_type(value, dict)
///     assert value == kDict
///
///
/// def request_dict() -> dict[str, int]:
///     return kDict
///
///
/// def receive_list(value: list[int]):
///     __assert_type(value, list)
///     assert value == kList
///
///
/// def request_list() -> list[int]:
///     return kList
///
///
/// def receive_tuple(value: tuple[int, ...]):
///     __assert_type(value, tuple)
///     assert value == kTuple
///
///
/// def request_tuple() -> tuple[int, ...]:
///     return kTuple
///
///
/// def receive_set(value: set[int]):
///     __assert_type(value, set)
///     assert value == kSet
///
///
/// def request_set() -> set[int]:
///     return set(kSet)
///
///
/// def receive_iterator(value: Iterator[int]):
///     __assert_type(value, Iterator)
///     assert list(value) == kIteratorElements
///
///
/// def request_iterator() -> Iterator[int]:
///     return CustomIterator(kIterableElements)
///
///
/// def request_generator() -> Generator[int, None, None]:
///     yield from kIteratorElements
///
///
/// def receive_iterable(value: Iterable[int]):
///     __assert_type(value, Iterable)
///     assert list(iter(value)) == kIterableElements
///
///
/// def request_iterable() -> Iterable[int]:
///     return CustomIterable(kIterableElements)
///
///
/// def receive_callable(value: Callable[[int], int]):
///     __assert_type(value, Callable)
///     assert value(kCallableArg) == kCallableResult
///
///
/// def request_callable() -> Callable[[int], int]:
///     def inner(x: int) -> int:
///         assert x == kCallableArg
///         return kCallableResult
///     return inner
/// ```
final class type_mappings extends PythonModule {
  type_mappings.from(super.pythonModule) : super.from();

  static type_mappings import() => PythonFfiDart.instance.importModule(
        "type_mappings",
        type_mappings.from,
      );

  /// ## receive_bool_false
  ///
  /// ### python source
  /// ```py
  /// def receive_bool_false(value: bool):
  ///     __assert_type(value, bool)
  ///     assert value is False
  /// ```
  Object? receive_bool_false({
    required bool value,
  }) =>
      getFunction("receive_bool_false").call(
        <Object?>[
          value,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## receive_bool_true
  ///
  /// ### python source
  /// ```py
  /// def receive_bool_true(value: bool):
  ///     __assert_type(value, bool)
  ///     assert value is True
  /// ```
  Object? receive_bool_true({
    required bool value,
  }) =>
      getFunction("receive_bool_true").call(
        <Object?>[
          value,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## receive_bytes
  ///
  /// ### python source
  /// ```py
  /// def receive_bytes(value: bytes):
  ///     __assert_type(value, bytes)
  ///     assert value == kBytes
  /// ```
  Object? receive_bytes({
    required Uint8List value,
  }) =>
      getFunction("receive_bytes").call(
        <Object?>[
          value,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## receive_callable
  ///
  /// ### python source
  /// ```py
  /// def receive_callable(value: Callable[[int], int]):
  ///     __assert_type(value, Callable)
  ///     assert value(kCallableArg) == kCallableResult
  /// ```
  Object? receive_callable({
    required int Function(int) value,
  }) =>
      getFunction("receive_callable").call(
        <Object?>[
          value.generic1,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## receive_dict
  ///
  /// ### python source
  /// ```py
  /// def receive_dict(value: dict[str, int]):
  ///     __assert_type(value, dict)
  ///     assert value == kDict
  /// ```
  Object? receive_dict({
    required Map<String, int> value,
  }) =>
      getFunction("receive_dict").call(
        <Object?>[
          value,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## receive_float
  ///
  /// ### python source
  /// ```py
  /// def receive_float(value: float):
  ///     __assert_type(value, float)
  ///     assert value == kFloat
  /// ```
  Object? receive_float({
    required double value,
  }) =>
      getFunction("receive_float").call(
        <Object?>[
          value,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## receive_int
  ///
  /// ### python source
  /// ```py
  /// def receive_int(value: int):
  ///     __assert_type(value, int)
  ///     assert value == kInt
  /// ```
  Object? receive_int({
    required int value,
  }) =>
      getFunction("receive_int").call(
        <Object?>[
          value,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## receive_iterable
  ///
  /// ### python source
  /// ```py
  /// def receive_iterable(value: Iterable[int]):
  ///     __assert_type(value, Iterable)
  ///     assert list(iter(value)) == kIterableElements
  /// ```
  Object? receive_iterable({
    required Iterable<int> value,
  }) =>
      getFunction("receive_iterable").call(
        <Object?>[
          value,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## receive_iterator
  ///
  /// ### python source
  /// ```py
  /// def receive_iterator(value: Iterator[int]):
  ///     __assert_type(value, Iterator)
  ///     assert list(value) == kIteratorElements
  /// ```
  Object? receive_iterator({
    required Iterator<int> value,
  }) =>
      getFunction("receive_iterator").call(
        <Object?>[
          value,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## receive_list
  ///
  /// ### python source
  /// ```py
  /// def receive_list(value: list[int]):
  ///     __assert_type(value, list)
  ///     assert value == kList
  /// ```
  Object? receive_list({
    required List<int> value,
  }) =>
      getFunction("receive_list").call(
        <Object?>[
          value,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## receive_none
  ///
  /// ### python source
  /// ```py
  /// def receive_none(value: None):
  ///     assert value is None
  /// ```
  Object? receive_none({
    required Null value,
  }) =>
      getFunction("receive_none").call(
        <Object?>[
          value,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## receive_set
  ///
  /// ### python source
  /// ```py
  /// def receive_set(value: set[int]):
  ///     __assert_type(value, set)
  ///     assert value == kSet
  /// ```
  Object? receive_set({
    required Set<int> value,
  }) =>
      getFunction("receive_set").call(
        <Object?>[
          value,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## receive_str
  ///
  /// ### python source
  /// ```py
  /// def receive_str(value: str):
  ///     __assert_type(value, str)
  ///     assert value == kStr
  /// ```
  Object? receive_str({
    required String value,
  }) =>
      getFunction("receive_str").call(
        <Object?>[
          value,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## receive_tuple
  ///
  /// ### python source
  /// ```py
  /// def receive_tuple(value: tuple[int, ...]):
  ///     __assert_type(value, tuple)
  ///     assert value == kTuple
  /// ```
  Object? receive_tuple({
    required PythonTuple<int> value,
  }) =>
      getFunction("receive_tuple").call(
        <Object?>[
          value,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## request_bool_false
  ///
  /// ### python source
  /// ```py
  /// def request_bool_false() -> bool:
  ///     return False
  /// ```
  bool request_bool_false() => getFunction("request_bool_false").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## request_bool_true
  ///
  /// ### python source
  /// ```py
  /// def request_bool_true() -> bool:
  ///     return True
  /// ```
  bool request_bool_true() => getFunction("request_bool_true").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## request_bytes
  ///
  /// ### python source
  /// ```py
  /// def request_bytes() -> bytes:
  ///     return kBytes
  /// ```
  Uint8List request_bytes() => getFunction("request_bytes").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## request_callable
  ///
  /// ### python source
  /// ```py
  /// def request_callable() -> Callable[[int], int]:
  ///     def inner(x: int) -> int:
  ///         assert x == kCallableArg
  ///         return kCallableResult
  ///     return inner
  /// ```
  int Function(int) request_callable() => PythonFunction.from(
        getFunction("request_callable").call(
          <Object?>[],
          kwargs: <String, Object?>{},
        ),
      ).asFunction(
        (PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?> f) =>
            (int x0) => f.call(<Object?>[x0]),
      );

  /// ## request_dict
  ///
  /// ### python source
  /// ```py
  /// def request_dict() -> dict[str, int]:
  ///     return kDict
  /// ```
  Map<String, int> request_dict() => Map<String, int>.from(
        Map.from(
          getFunction("request_dict").call(
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

  /// ## request_float
  ///
  /// ### python source
  /// ```py
  /// def request_float() -> float:
  ///     return kFloat
  /// ```
  double request_float() => getFunction("request_float").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## request_generator
  ///
  /// ### python source
  /// ```py
  /// def request_generator() -> Generator[int, None, None]:
  ///     yield from kIteratorElements
  /// ```
  Iterator<int> request_generator() => TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("request_generator").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ),
      ).transform((e) => e).cast<int>();

  /// ## request_int
  ///
  /// ### python source
  /// ```py
  /// def request_int() -> int:
  ///     return kInt
  /// ```
  int request_int() => getFunction("request_int").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## request_iterable
  ///
  /// ### python source
  /// ```py
  /// def request_iterable() -> Iterable[int]:
  ///     return CustomIterable(kIterableElements)
  /// ```
  Iterable<int> request_iterable() => TypedIterable.from(
        PythonIterable.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("request_iterable").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ),
      ).transform((e) => e).cast<int>();

  /// ## request_iterator
  ///
  /// ### python source
  /// ```py
  /// def request_iterator() -> Iterator[int]:
  ///     return CustomIterator(kIterableElements)
  /// ```
  Iterator<int> request_iterator() => TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("request_iterator").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ),
      ).transform((e) => e).cast<int>();

  /// ## request_list
  ///
  /// ### python source
  /// ```py
  /// def request_list() -> list[int]:
  ///     return kList
  /// ```
  List<int> request_list() => List<int>.from(
        List.from(
          getFunction("request_list").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ).map(
          (e) => e,
        ),
      );

  /// ## request_none
  ///
  /// ### python source
  /// ```py
  /// def request_none() -> None:
  ///     return None
  /// ```
  Null request_none() => getFunction("request_none").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## request_set
  ///
  /// ### python source
  /// ```py
  /// def request_set() -> set[int]:
  ///     return set(kSet)
  /// ```
  Set<int> request_set() => Set<int>.from(
        Set.from(
          getFunction("request_set").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ).map(
          (e) => e,
        ),
      );

  /// ## request_str
  ///
  /// ### python source
  /// ```py
  /// def request_str() -> str:
  ///     return kStr
  /// ```
  String request_str() => getFunction("request_str").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## request_tuple
  ///
  /// ### python source
  /// ```py
  /// def request_tuple() -> tuple[int, ...]:
  ///     return kTuple
  /// ```
  List<int> request_tuple() => List<int>.from(
        List.from(
          getFunction("request_tuple").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ).map(
          (e) => e,
        ),
      );

  /// ## T (getter)
  Object? get T => getAttribute("T");

  /// ## T (setter)
  set T(Object? T) => setAttribute("T", T);

  /// ## Callable (getter)
  Object? get Callable => getAttribute("Callable");

  /// ## Callable (setter)
  set Callable(Object? Callable) => setAttribute("Callable", Callable);

  /// ## Generator (getter)
  Object? get Generator => getAttribute("Generator");

  /// ## Generator (setter)
  set Generator(Object? Generator) => setAttribute("Generator", Generator);

  /// ## Iterable (getter)
  Object? get $Iterable => getAttribute("Iterable");

  /// ## Iterable (setter)
  set $Iterable(Object? $Iterable) => setAttribute("Iterable", $Iterable);

  /// ## Iterator (getter)
  Object? get $Iterator => getAttribute("Iterator");

  /// ## Iterator (setter)
  set $Iterator(Object? $Iterator) => setAttribute("Iterator", $Iterator);

  /// ## Self (getter)
  Object? get Self => getAttribute("Self");

  /// ## Self (setter)
  set Self(Object? Self) => setAttribute("Self", Self);

  /// ## kBytes (getter)
  Object? get kBytes => getAttribute("kBytes");

  /// ## kBytes (setter)
  set kBytes(Object? kBytes) => setAttribute("kBytes", kBytes);

  /// ## kCallableArg (getter)
  Object? get kCallableArg => getAttribute("kCallableArg");

  /// ## kCallableArg (setter)
  set kCallableArg(Object? kCallableArg) =>
      setAttribute("kCallableArg", kCallableArg);

  /// ## kCallableResult (getter)
  Object? get kCallableResult => getAttribute("kCallableResult");

  /// ## kCallableResult (setter)
  set kCallableResult(Object? kCallableResult) =>
      setAttribute("kCallableResult", kCallableResult);

  /// ## kDict (getter)
  Object? get kDict => getAttribute("kDict");

  /// ## kDict (setter)
  set kDict(Object? kDict) => setAttribute("kDict", kDict);

  /// ## kFloat (getter)
  Object? get kFloat => getAttribute("kFloat");

  /// ## kFloat (setter)
  set kFloat(Object? kFloat) => setAttribute("kFloat", kFloat);

  /// ## kInt (getter)
  Object? get kInt => getAttribute("kInt");

  /// ## kInt (setter)
  set kInt(Object? kInt) => setAttribute("kInt", kInt);

  /// ## kIterableElements (getter)
  Object? get kIterableElements => getAttribute("kIterableElements");

  /// ## kIterableElements (setter)
  set kIterableElements(Object? kIterableElements) =>
      setAttribute("kIterableElements", kIterableElements);

  /// ## kIteratorElements (getter)
  Object? get kIteratorElements => getAttribute("kIteratorElements");

  /// ## kIteratorElements (setter)
  set kIteratorElements(Object? kIteratorElements) =>
      setAttribute("kIteratorElements", kIteratorElements);

  /// ## kList (getter)
  Object? get kList => getAttribute("kList");

  /// ## kList (setter)
  set kList(Object? kList) => setAttribute("kList", kList);

  /// ## kSet (getter)
  Object? get kSet => getAttribute("kSet");

  /// ## kSet (setter)
  set kSet(Object? kSet) => setAttribute("kSet", kSet);

  /// ## kStr (getter)
  Object? get kStr => getAttribute("kStr");

  /// ## kStr (setter)
  set kStr(Object? kStr) => setAttribute("kStr", kStr);

  /// ## kTuple (getter)
  Object? get kTuple => getAttribute("kTuple");

  /// ## kTuple (setter)
  set kTuple(Object? kTuple) => setAttribute("kTuple", kTuple);
}
