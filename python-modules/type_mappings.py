kInt: int = 42
kFloat: float = 3.14
kStr: str = "Hello World"
kBytes: bytes = b"Hello World"
kDict: dict[str, int] = {"one": 1, "two": 2, "three": 3}
kList: list[int] = [1, 2, 3]
kSet: set[int] = set([1, 2, 3])


def __assert_type(value, t: type):
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


def receive_set(value: set[int]):
    __assert_type(value, set)
    assert value == kSet


def request_set() -> set[int]:
    return kSet
