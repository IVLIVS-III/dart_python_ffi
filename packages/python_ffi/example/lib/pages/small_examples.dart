import "package:flutter/material.dart";
import "package:python_ffi_example/python_modules/data_class.g.dart";
import "package:python_ffi_example/python_modules/json_parser.g.dart";
import "package:python_ffi_example/python_modules/primitives.g.dart";
import "package:python_ffi_example/python_modules/structs.g.dart";

class SmallExamplesPage extends StatelessWidget {
  const SmallExamplesPage({Key? key}) : super(key: key);

  void primitivesSum() {
    final primitives primitivesModule = primitives.import();

    final int sum = primitivesModule.sum(a: 2, b: 3);

    debugPrint("Sum: $sum");
  }

  void primitivesSqrt() {
    final primitives primitivesModule = primitives.import();

    final int sqrt = primitivesModule.sqrt(a: 9);

    debugPrint("Sqrt: $sqrt");
  }

  void structsHelloWorld() {
    final structs structsModule = structs.import();

    final String helloWorld = structsModule.hello_world();

    debugPrint("Hello World: $helloWorld");
  }

  void structsReverse() {
    final structs structsModule = structs.import();

    const String str = "Hello World";
    final String reversed = structsModule.reverse(str: str, length: str.length);

    debugPrint("Reversed: $reversed");
  }

  void structsCreateCoordinate() {
    final structs structsModule = structs.import();

    final Coordinate coordinate =
        structsModule.create_coordinate(latitude: 1, longitude: 2);

    debugPrint("Coordinate: $coordinate");
  }

  void structsCreatePlace() {
    final structs structsModule = structs.import();

    final Place place =
        structsModule.create_place(name: "Home", latitude: 5, longitude: -8.3);

    debugPrint("Place: $place");
  }

  void structsDistance() {
    final structs structsModule = structs.import();

    final Coordinate c1 =
        structsModule.create_coordinate(latitude: 2, longitude: 2);
    final Coordinate c2 =
        structsModule.create_coordinate(latitude: 5, longitude: 6);
    final double distance = structsModule.distance(c1: c1, c2: c2);

    debugPrint("Distance: $distance");
  }

  void structsCreateCoordinateDart() {
    final Coordinate coordinate = Coordinate(latitude: 1, longitude: 2);

    debugPrint("Coordinate: $coordinate");
  }

  void structsDistanceDart() {
    final structs structsModule = structs.import();

    final Coordinate c1 = Coordinate(latitude: 2, longitude: 2);
    final Coordinate c2 = Coordinate(latitude: 5, longitude: 6);
    final double distance = structsModule.distance(c1: c1, c2: c2);

    debugPrint("Distance: $distance");
  }

  void dataClass() {
    final DataClass dataClass = DataClass(a: 1, b: "Hello World");

    debugPrint("DataClass: $dataClass");
  }

  void dataClassGetSet() {
    final DataClass dataClass = DataClass(a: 1, b: "Hello World")..a = 2;

    debugPrint("DataClass: $dataClass");
  }

  void dataClassUndefinedMethod() {
    final dynamic dataclass = DataClass(a: 1, b: "Hello World");
    // ignore: avoid_dynamic_calls
    final Object? result = dataclass.__repr__();

    debugPrint("DataClass.__repr__(): $result");
  }

  void dataClassUndefinedGetter() {
    final dynamic dataclass = DataClass(a: 1, b: "Hello World");
    // ignore: avoid_dynamic_calls
    final Object? result = dataclass.__dict__;

    debugPrint("DataClass.__dict__: $result");
  }

  void dataClassUndefinedSetter() {
    final dynamic dataclass = DataClass(a: 1, b: "Hello World");
    // ignore: avoid_dynamic_calls
    final Object? result1 = dataclass.__dict__;
    debugPrint("before DataClass.__dict__: $result1");

    // ignore: avoid_dynamic_calls
    dataclass.__dict__ = <String, dynamic>{};

    debugPrint("executed DataClass.__dict__ = {}");

    // ignore: avoid_dynamic_calls
    final Object? result2 = dataclass.__dict__;
    debugPrint("after DataClass.__dict__: $result2");
  }

  void jsonParserParse() {
    final json_parser jsonParserModule = json_parser.import();

    const String json = '{"name": "John", "age": 30, "city": "New York"}';
    final Object? parsed = jsonParserModule.parse(json_string: json);

    debugPrint("Parsed json: $parsed");
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Small Examples"),
        ),
        body: ButtonBar(
          children: <Widget>[
            ElevatedButton(
              onPressed: primitivesSum,
              child: const Text("Run Python 'primitives.sum(2, 3)'"),
            ),
            ElevatedButton(
              onPressed: primitivesSqrt,
              child: const Text("Run Python 'primitives.sqrt(9)'"),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: structsHelloWorld,
              child: const Text("Run Python 'structs.hello_world()'"),
            ),
            ElevatedButton(
              onPressed: structsReverse,
              child:
                  const Text("Run Python 'structs.reverse(\"Hello World\")'"),
            ),
            ElevatedButton(
              onPressed: structsCreateCoordinate,
              child: const Text("Run Python 'structs.create_coordinate(1, 2)'"),
            ),
            ElevatedButton(
              onPressed: structsCreatePlace,
              child: const Text(
                "Run Python 'structs.create_place(\"Home\", 5, -8.3)'",
              ),
            ),
            ElevatedButton(
              onPressed: structsDistance,
              child: const Text(
                "Run Python 'structs.distance(structs.create_coordinate(2, 2), structs.create_coordinate(5, 6))'",
              ),
            ),
            ElevatedButton(
              onPressed: structsCreateCoordinateDart,
              child: const Text(
                "Run Dart 'Coordinate(1, 2)'",
              ),
            ),
            ElevatedButton(
              onPressed: structsDistanceDart,
              child: const Text(
                "Run Python 'structs.distance(Coordinate(2, 2), Coordinate(5, 6))'",
              ),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: dataClass,
              child: const Text(
                "Run Dart 'DataClass(1, \"Hello World\")'",
              ),
            ),
            ElevatedButton(
              onPressed: dataClassGetSet,
              child: const Text(
                "Run Dart 'DataClass(1, \"Hello World\")..a = 2'",
              ),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: dataClassUndefinedMethod,
              child: const Text(
                "Run Dart 'DataClass(1, \"Hello World\").__repr__()'",
              ),
            ),
            ElevatedButton(
              onPressed: dataClassUndefinedGetter,
              child: const Text(
                "Run Dart 'DataClass(1, \"Hello World\").__dict__'",
              ),
            ),
            ElevatedButton(
              onPressed: dataClassUndefinedSetter,
              child: const Text(
                "Run Dart 'DataClass(1, \"Hello World\").__dict__ = {}'",
              ),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: jsonParserParse,
              child: const Text(
                "Run Python 'json_parser.parse(\"{\\\"name\\\": \\\"John\\\", \\\"age\\\": 30, \\\"city\\\": \\\"New York\\\"}\")'",
              ),
            ),
          ],
        ),
      );
}
