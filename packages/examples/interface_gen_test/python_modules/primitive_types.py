from typing import Any, Callable, Generator, Iterable, Iterator, TypeVar


T = TypeVar("T")
num = int | float


def get_None() -> None: return None
def get_bool() -> bool: return True
def get_int() -> int: return 1
def get_float() -> float: return 3.14
def get_num() -> num: return 3.14
def get_str() -> str: return "lorem ipsum"
def get_bytes() -> bytes: return b"lorem ipsum"
def get_dict() -> dict[str, int]: return {"a": 1, "b": 2}
def get_dict_nested() -> dict[str, dict[str, int]]: return {"a": {"b": 1}}
def get_list() -> list[int]: return [1, 2, 3]
def get_list_implicit() -> list: return [1, "a", False]
def get_list_nested() -> list[list[int]]: return [[1, 2], [3, 4]]
def get_tuple() -> tuple[int, ...]: return (1, 2, 3)
def get_set() -> set[int]: return {1, 2, 3}
def get_container_nested() -> list[list[set[int]]]: return [[{1, 2}, {3, 4}], [{5, 6}, {7, 8}]]
def get_Iterator() -> Iterator[int]: return iter([1, 2, 3])
def get_Iterator_nested() -> Iterator[list[int]]: return iter([[1, 2], [3, 4]])
def get_Generator() -> Generator[int, None, None]: return (i for i in [1, 2, 3])
def get_Iterable() -> Iterable[int]: return [1, 2, 3]
def get_Callable() -> Callable[[int], str]: return lambda x: str(x)
def get_Callable_generic() -> Callable[[T], T]: return lambda x: x
def get_Any() -> Any: return 1
def get_Any_implicit(): return 1

def set_None(_: None) -> bool: return _ == get_None()
def set_bool(_: bool) -> bool: return _ == get_bool()
def set_int(_: int) -> bool: return _ == get_int()
def set_float(_: float) -> bool: return _ == get_float()
def set_num(_: num) -> bool: return _ == get_num() or _ == get_float() or _ == get_int()
def set_str(_: str) -> bool: return _ == get_str()
def set_bytes(_: bytes) -> bool: return _ == get_bytes()
def set_dict(_: dict[str, int]) -> bool: return _ == get_dict()
def set_dict_nested(_: dict[str, dict[str, int]]) -> bool: return _ == get_dict_nested()
def set_list(_: list[int]) -> bool: return _ == get_list()
def set_list_implicit(_: list) -> bool: return _ == get_list_implicit()
def set_list_nested(_: list[list[int]]) -> bool: return _ == get_list_nested()
def set_tuple(_: tuple[int, ...]) -> bool: return _ == get_tuple()
def set_set(_: set[int]) -> bool: return _ == get_set()
def set_container_nested(_: list[list[set[int]]]) -> bool: return _ == get_container_nested()
def set_Iterator(_: Iterator[int]) -> bool: return list(_) == list(get_Iterator())
def set_Iterator_nested(_: Iterator[list[int]]) -> bool: return list(_) == list(get_Iterator_nested())
def set_Generator(_: Generator[int, None, None]) -> bool: return list(_) == list(get_Generator())
def set_Iterable(_: Iterable[int]) -> bool: return list(_) == list(get_Iterable())
def set_Callable(_: Callable[[int], str]) -> bool: return _(1) == get_Callable()(1)
def set_Callable_generic(_: Callable[[T], T]) -> bool: return _(1) == get_Callable_generic()(1)
def set_Any(_: Any) -> bool: return _ == get_Any()
def set_Any_implicit(_) -> bool: return _ == get_Any_implicit()
