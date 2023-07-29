from dataclasses import dataclass

@dataclass()
class HasEq:
    a: int

class NoEq:
    def __init__(self, a: int):
        self.a = a
