class Coordinate:
    def __init__(self, latitude: float, longitude: float) -> 'Coordinate':
        self.latitude = latitude
        self.longitude = longitude


class Place:
    def __init__(self, name: str, coordinate: Coordinate) -> 'Place':
        self.name = name
        self.coordinate = coordinate


def hello_world() -> str:
    return "Hello World"


def reverse(str: str, length: int) -> str:
    return str[::-1]


def create_coordinate(latitude: float, longitude: float) -> Coordinate:
    return Coordinate(latitude, longitude)


def create_place(name: str, latitude: float, longitude: float) -> Place:
    coordinate: Coordinate = Coordinate(latitude, longitude)
    return Place(name, coordinate)


def distance(c1: Coordinate, c2: Coordinate) -> float:
    xd: float = c2.latitude - c1.latitude
    yd: float = c2.longitude - c1.longitude
    return (xd * xd + yd * yd) ** 0.5
