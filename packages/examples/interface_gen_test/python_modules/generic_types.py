from typing import Callable, TypeVar


T = TypeVar("T")


def get_Callable() -> Callable[[T], T]: return lambda x: x


def set_Callable(_: Callable[[T], T]) -> bool: return _(1) == get_Callable()(1)
