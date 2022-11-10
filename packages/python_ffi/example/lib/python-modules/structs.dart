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

  double get latitude => getAttribute("latitude")! as double;

  double get longitude => getAttribute("longitude")! as double;
}

class StructsModule extends PythonModule {
  StructsModule.from(super.pythonModule) : super.from();

  static StructsModule import() => PythonFfi.instance.importModule(
        "structs",
        StructsModule.from,
      );

  String hello_world() => getFunction("hello_world").call(<Object?>[]);

  String reverse(String str) => getFunction("reverse").call(<Object?>[str]);

  int create_coordinate(int a, int b) =>
      getFunction("subtract").call(<Object?>[a, b]);
}
