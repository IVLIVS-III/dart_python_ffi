from dataclasses import dataclass

@dataclass
class Person:
    name: str
    x: int = 0
    y: int = 0

    def move(self, dx: int, dy: int):
        self.x += dx
        self.y += dy

    def __str__(self):
        return f"{self.name} @ ({self.x}, {self.y})"
