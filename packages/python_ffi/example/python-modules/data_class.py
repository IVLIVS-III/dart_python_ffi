from dataclasses import dataclass


@dataclass
class DataClass:
    a: int
    b: str

    def __post_init__(self):
        assert self.a > 0

    def __str__(self):
        return f"{self.a} {self.b}"
