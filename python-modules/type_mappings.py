kInt: int = 42
kFloat: float = 3.14
kStr: str = "Hello World"
kBytes: bytes = b"Hello World"
kDict: dict[str, int] = {"one": 1, "two": 2, "three": 3}
kList: list[int] = [1, 2, 3]
kSet: set[int] = set([1, 2, 3])


def receive_none(value: None):
    assert value is None


def request_none() -> None:
    return None


def receive_bool_true(value: bool):
    assert isinstance(value, bool)
    assert value is True


def request_bool_true() -> bool:
    return True


def receive_bool_false(value: bool):
    assert isinstance(value, bool)
    assert value is False


def request_bool_false() -> bool:
    return False



def receive_int(value: int):
    assert isinstance(value, int)
    assert value == kInt


def request_int() -> int:
    return kInt


def receive_float(value: float):
    assert isinstance(value, float)
    assert value == kFloat


def request_float() -> float:
    return kFloat


def receive_str(value: str):
    assert isinstance(value, str)
    assert value == kStr


def request_str() -> str:
    return kStr


# TODO: implement on Dart side
def receive_bytes(value: bytes):
    assert isinstance(value, bytes)
    assert value == kBytes


def request_bytes() -> bytes:
    return kBytes


def receive_dict(value: dict[str, int]):
    assert isinstance(value, dict)
    assert value == kDict


def request_dict() -> dict[str, int]:
    return kDict


def receive_list(value: list[int]):
    assert isinstance(value, list)
    assert value == kList


def request_list() -> list[int]:
    return kList


def receive_set(value: set[int]):
    assert isinstance(value, set)
    assert value == kSet


def request_set() -> set[int]:
    return kSet
