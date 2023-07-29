from dataclasses import dataclass, field
from typing import Self


@dataclass
class Class:
    initializer: int = field(init=False, default=1)

    def newInstance(self: Self) -> int:
        return 1
    

def noSuchMethod():
    return 1


getClass: int = 1
