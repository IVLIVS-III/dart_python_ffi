// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library structs;

import "package:python_ffi/python_ffi.dart";

/// ## Coordinate
///
/// ### python source
/// ```py
/// class Coordinate:
///     def __init__(self, latitude: float, longitude: float) -> 'Coordinate':
///         self.latitude = latitude
///         self.longitude = longitude
///
///     def __str__(self) -> str:
///         return f"({self.latitude}, {self.longitude})"
/// ```
final class Coordinate extends PythonClass {
  factory Coordinate({
    required double latitude,
    required double longitude,
  }) =>
      PythonFfi.instance.importClass(
        "structs",
        "Coordinate",
        Coordinate.from,
        <Object?>[
          latitude,
          longitude,
        ],
        <String, Object?>{},
      );

  Coordinate.from(super.pythonClass) : super.from();

  /// ## latitude (getter)
  Object? get latitude => getAttribute("latitude");

  /// ## latitude (setter)
  set latitude(Object? latitude) => setAttribute("latitude", latitude);

  /// ## longitude (getter)
  Object? get longitude => getAttribute("longitude");

  /// ## longitude (setter)
  set longitude(Object? longitude) => setAttribute("longitude", longitude);
}

/// ## Place
///
/// ### python source
/// ```py
/// class Place:
///     def __init__(self, name: str, coordinate: Coordinate) -> 'Place':
///         self.name = name
///         self.coordinate = coordinate
///
///     def __str__(self) -> str:
///         return f"{self.name} {self.coordinate}"
/// ```
final class Place extends PythonClass {
  factory Place({
    required String name,
    required Coordinate coordinate,
  }) =>
      PythonFfi.instance.importClass(
        "structs",
        "Place",
        Place.from,
        <Object?>[
          name,
          coordinate,
        ],
        <String, Object?>{},
      );

  Place.from(super.pythonClass) : super.from();

  /// ## name (getter)
  Object? get name => getAttribute("name");

  /// ## name (setter)
  set name(Object? name) => setAttribute("name", name);

  /// ## coordinate (getter)
  Object? get coordinate => getAttribute("coordinate");

  /// ## coordinate (setter)
  set coordinate(Object? coordinate) => setAttribute("coordinate", coordinate);
}

/// ## structs
///
/// ### python source
/// ```py
/// class Coordinate:
///     def __init__(self, latitude: float, longitude: float) -> 'Coordinate':
///         self.latitude = latitude
///         self.longitude = longitude
///
///     def __str__(self) -> str:
///         return f"({self.latitude}, {self.longitude})"
///
///
/// class Place:
///     def __init__(self, name: str, coordinate: Coordinate) -> 'Place':
///         self.name = name
///         self.coordinate = coordinate
///
///     def __str__(self) -> str:
///         return f"{self.name} {self.coordinate}"
///
///
/// def hello_world() -> str:
///     return "Hello World"
///
///
/// def reverse(str: str, length: int) -> str:
///     return str[::-1]
///
///
/// def create_coordinate(latitude: float, longitude: float) -> Coordinate:
///     return Coordinate(latitude, longitude)
///
///
/// def create_place(name: str, latitude: float, longitude: float) -> Place:
///     coordinate: Coordinate = Coordinate(latitude, longitude)
///     return Place(name, coordinate)
///
///
/// def distance(c1: Coordinate, c2: Coordinate) -> float:
///     xd: float = c2.latitude - c1.latitude
///     yd: float = c2.longitude - c1.longitude
///     return (xd * xd + yd * yd) ** 0.5
/// ```
final class structs extends PythonModule {
  structs.from(super.pythonModule) : super.from();

  static structs import() => PythonFfi.instance.importModule(
        "structs",
        structs.from,
      );

  /// ## create_coordinate
  ///
  /// ### python source
  /// ```py
  /// def create_coordinate(latitude: float, longitude: float) -> Coordinate:
  ///     return Coordinate(latitude, longitude)
  /// ```
  Coordinate create_coordinate({
    required double latitude,
    required double longitude,
  }) =>
      Coordinate.from(
        getFunction("create_coordinate").call(
          <Object?>[
            latitude,
            longitude,
          ],
          kwargs: <String, Object?>{},
        ),
      );

  /// ## create_place
  ///
  /// ### python source
  /// ```py
  /// def create_place(name: str, latitude: float, longitude: float) -> Place:
  ///     coordinate: Coordinate = Coordinate(latitude, longitude)
  ///     return Place(name, coordinate)
  /// ```
  Place create_place({
    required String name,
    required double latitude,
    required double longitude,
  }) =>
      Place.from(
        getFunction("create_place").call(
          <Object?>[
            name,
            latitude,
            longitude,
          ],
          kwargs: <String, Object?>{},
        ),
      );

  /// ## distance
  ///
  /// ### python source
  /// ```py
  /// def distance(c1: Coordinate, c2: Coordinate) -> float:
  ///     xd: float = c2.latitude - c1.latitude
  ///     yd: float = c2.longitude - c1.longitude
  ///     return (xd * xd + yd * yd) ** 0.5
  /// ```
  double distance({
    required Coordinate c1,
    required Coordinate c2,
  }) =>
      getFunction("distance").call(
        <Object?>[
          c1,
          c2,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## hello_world
  ///
  /// ### python source
  /// ```py
  /// def hello_world() -> str:
  ///     return "Hello World"
  /// ```
  String hello_world() => getFunction("hello_world").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## reverse
  ///
  /// ### python source
  /// ```py
  /// def reverse(str: str, length: int) -> str:
  ///     return str[::-1]
  /// ```
  String reverse({
    required String str,
    required int length,
  }) =>
      getFunction("reverse").call(
        <Object?>[
          str,
          length,
        ],
        kwargs: <String, Object?>{},
      );
}
