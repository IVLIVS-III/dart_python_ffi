// ignore_for_file: non_constant_identifier_names

import "package:python_ffi/python_ffi.dart";

class Coordinate extends PythonClass {
  factory Coordinate(double latitude, double longitude) {
    final Coordinate coordinate = PythonFfi.instance.importClass(
      "structs",
      "Coordinate",
      Coordinate.from,
      <Object?>[latitude, longitude],
    );
    return coordinate;
  }

  Coordinate.from(super.pythonClass) : super.from();

  double get latitude => getAttribute("latitude")! as double;

  double get longitude => getAttribute("longitude")! as double;

  @override
  String toString() => "Coordinate(latitude: $latitude, longitude: $longitude)";
}

class Place extends PythonClass {
  factory Place(String name, Coordinate coordinate) {
    final Place place = PythonFfi.instance.importClass(
      "structs",
      "Place",
      Place.from,
      <Object?>[name, coordinate],
    );
    return place;
  }

  Place.from(super.pythonClass) : super.from();

  String get name => getAttribute("name")! as String;

  Coordinate get coordinate => Coordinate.from(getAttribute("coordinate")!);

  @override
  String toString() => "Place(name: $name, coordinate: $coordinate)";
}

class StructsModule extends PythonModule {
  StructsModule.from(super.pythonModule) : super.from();

  static StructsModule import() => PythonFfi.instance.importModule(
        "structs",
        StructsModule.from,
      );

  String hello_world() => getFunction("hello_world").call(<Object?>[]);

  String reverse(String str, int length) =>
      getFunction("reverse").call(<Object?>[str, length]);

  Coordinate create_coordinate(double latitude, double longitude) =>
      Coordinate.from(
        getFunction("create_coordinate").call(
          <Object?>[latitude, longitude],
        ),
      );

  Place create_place(String name, double latitude, double longitude) =>
      Place.from(
        getFunction("create_place").call(
          <Object?>[name, latitude, longitude],
        ),
      );

  double distance(Coordinate c1, Coordinate c2) =>
      getFunction("distance").call(<Object?>[c1, c2]);

  static PythonModuleDefinition get definition => PythonModuleDefinition(
        name: "structs",
        root: SourceFile("structs.py"),
        classNames: classNames,
      );

  static Iterable<String> get classNames =>
      const <String>["Coordinate", "Place"];
}
