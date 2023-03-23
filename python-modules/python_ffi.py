import asyncio
from dataclasses import dataclass
from typing import Callable, Generator, Iterator, Self, TypeVar, Generic


T = TypeVar("T")


@dataclass
class PythonFfiIterator(Generic[T]):
    dart_move_next: Callable[[], bool]
    dart_current: Callable[[], T]

    def __iter__(self: Self) -> Self:
        return self

    def __next__(self: Self) -> T:
        if self.dart_move_next():
            return self.dart_current()
        raise StopIteration


@dataclass
class PythonFfiIterable(Generic[T]):
    dart_iter: Callable[[], Iterator[T]]

    def __iter__(self: Self) -> Iterator[T]:
        return self.dart_iter()


@dataclass()
class PythonFfiAwaitable(Generic[T]):
    dart_is_done: Callable[[], bool]
    dart_result: Callable[[], T]

    def __await__(self: Self) -> Generator[T, None, None]:
        async def inner():
            while not self.dart_is_done():
                await asyncio.sleep(0.01)
            return self.dart_result()
        return inner().__await__()
