from dataclasses import dataclass
from typing import Self


@dataclass
class A:
    def get(self: Self) -> 'A':
        return A()
    
    def set(self: Self, _: 'A') -> bool:
        return _ == A()


def get_A() -> A: return A()
def get_list_A() -> list[A]: return [A()]
def get_map_A() -> dict[str, A]: return {"a": A()}


def set_A(_: A) -> bool: return _ == get_A()
def set_list_A(_: list[A]) -> bool: return _ == get_list_A()
def set_map_A(_: dict[str, A]) -> bool: return _ == get_map_A()
