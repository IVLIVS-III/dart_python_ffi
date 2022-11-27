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

  @override
  StructsModule get module => StructsModule.import();

  double get latitude => (getAttribute("latitude")! as num).toDouble();

  double get longitude => (getAttribute("longitude")! as num).toDouble();

  @override
  String toString() => "Coordinate(latitude: $latitude, longitude: $longitude)";
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

  Coordinate create_coordinate(int a, int b) => Coordinate.from(
        getFunction("create_coordinate").call(
          <Object?>[a, b],
        ),
      );
}
