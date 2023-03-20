from typing import Callable, Generator, Iterator, Self, TypeVar, Generic


T = TypeVar("T")


class PythonFfiIterator(Generic[T]):
    def __iter__(self: Self) -> Self:
        return self

    def __next__(self: Self) -> T:
        # TODO: implement
        ...


class PythonFfiIterable(Generic[T]):
    def __iter__(self: Self) -> Iterator[T]:
        # TODO: implement
        ...


class PythonFfiAwaitable(Generic[T]):
    __isDone: Callable[[], bool]
    __result: Callable[[], T]

    def __await__(self: Self) -> Generator[T, None, None]:
        while not self.__isDone():
            yield None
        return self.__result()
