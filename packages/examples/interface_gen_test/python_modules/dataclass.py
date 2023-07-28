from dataclasses import dataclass, field

@dataclass
class DataClass:
    field0: int
    field1: int = 1
    field2: int = field(init=False, default=2)
