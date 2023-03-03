from dataclasses import dataclass, field
from math import isclose
import time
from typing import Any, Awaitable, Callable, Generator, Iterable, Iterator, Self, TypeVar, Generic
import asyncio


T = TypeVar("T")


@dataclass
class CustomIterator(Generic[T]):
    iterator: Iterator[T]
    __did_call___iter__: bool = field(init=False, default=False)

    def __iter__(self: Self) -> Self:
        self.iterator = iter(self.iterator)
        self.__did_call___iter__ = True
        return self

    def __next__(self: Self) -> T:
        if not self.__did_call___iter__:
            self = self.__iter__()
        return next(self.iterator)


@dataclass
class CustomIterable(Generic[T]):
    iterable: Iterable[T]

    def __iter__(self: Self) -> CustomIterator[T]:
        return CustomIterator(iter(self.iterable))


kInt: int = 42
kFloat: float = 3.14
kStr: str = "Hello World"
kBytes: bytes = b"Hello World"
kDict: dict[str, int] = {"one": 1, "two": 2, "three": 3}
kList: list[int] = [1, 2, 3]
kTuple: tuple[int, ...] = (1, 2, 3)
kSet: set[int] = set([1, 2, 3])
kIteratorElements: list[int] = [1, 2, 3]
kIterableElements: list[int] = [1, 2, 3]
kCallableArg: int = 1
kCallableResult: int = 2
kAwaitableSleep: int = 1
kAwaitableResult: int = 1


def __assert_type(value: Any, t: type):
    assert isinstance(value, t), f"expected {t}, but got {type(value)}"


def receive_none(value: None):
    assert value is None


def request_none() -> None:
    return None


def receive_bool_true(value: bool):
    __assert_type(value, bool)
    assert value is True


def request_bool_true() -> bool:
    return True


def receive_bool_false(value: bool):
    __assert_type(value, bool)
    assert value is False


def request_bool_false() -> bool:
    return False


def receive_int(value: int):
    __assert_type(value, int)
    assert value == kInt


def request_int() -> int:
    return kInt


def receive_float(value: float):
    __assert_type(value, float)
    assert value == kFloat


def request_float() -> float:
    return kFloat


def receive_str(value: str):
    __assert_type(value, str)
    assert value == kStr


def request_str() -> str:
    return kStr


def receive_bytes(value: bytes):
    __assert_type(value, bytes)
    assert value == kBytes


def request_bytes() -> bytes:
    return kBytes


def receive_dict(value: dict[str, int]):
    __assert_type(value, dict)
    assert value == kDict


def request_dict() -> dict[str, int]:
    return kDict


def receive_list(value: list[int]):
    __assert_type(value, list)
    assert value == kList


def request_list() -> list[int]:
    return kList


def receive_tuple(value: tuple[int, ...]):
    __assert_type(value, tuple)
    assert value == kTuple


def request_tuple() -> tuple[int, ...]:
    return kTuple


def receive_set(value: set[int]):
    __assert_type(value, set)
    assert value == kSet


def request_set() -> set[int]:
    return kSet


def receive_iterator(value: Iterator[int]):
    __assert_type(value, Iterator)
    assert list(value) == kIteratorElements


def request_iterator() -> Iterator[int]:
    return CustomIterator(kIterableElements)


def request_generator() -> Generator[int, None, None]:
    yield from kIteratorElements


def receive_iterable(value: Iterable[int]):
    __assert_type(value, Iterable)
    assert list(iter(value)) == kIterableElements


def request_iterable() -> Iterable[int]:
    return CustomIterable(kIterableElements)


def receive_callable(value: Callable[[int], int]):
    __assert_type(value, Callable)
    assert value(kCallableArg) == kCallableResult


def request_callable() -> Callable[[int], int]:
    def inner(x: int) -> int:
        assert x == kCallableArg
        return kCallableResult
    return inner


def receive_awaitable(value: Awaitable[int]):
    __assert_type(value, Awaitable)

    async def wrapper():
        tstart = time.perf_counter()
        result = await value
        tstop = time.perf_counter()
        assert result == kAwaitableResult
        assert isclose(tstop - tstart, kAwaitableSleep)
    asyncio.run(wrapper)


def request_awaitable() -> Awaitable[int]:
    async def inner() -> int:
        await asyncio.sleep(kAwaitableSleep)
        return kAwaitableResult
    return inner()
