from typing import Iterator, Self, TypeVar, Generic


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
    def __await__(self: Self) -> Iterator[T]:
        # TODO: implement
        ...
