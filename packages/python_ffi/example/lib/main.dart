import "package:flutter/material.dart";
import "package:python_ffi/python_ffi.dart";
import "package:python_ffi_example/python-modules/data_class.dart";
import "package:python_ffi_example/python-modules/hello_world.dart";
import "package:python_ffi_example/python-modules/json_parser.dart";
import "package:python_ffi_example/python-modules/module_registry.dart";
import "package:python_ffi_example/python-modules/primitives.dart";
import "package:python_ffi_example/python-modules/structs.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PythonFfi.instance.initialize();
  await registerPythonModules();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void helloWorld() {
    HelloWorldModule.import()
      ..hello_world()
      ..dispose();
  }

  void primitivesSum() {
    final PrimitivesModule primitivesModule = PrimitivesModule.import();

    final int sum = primitivesModule.sum(2, 3);

    primitivesModule.dispose();

    debugPrint("Sum: $sum");
  }

  void primitivesSqrt() {
    final PrimitivesModule primitivesModule = PrimitivesModule.import();

    final int sqrt = primitivesModule.sqrt(9);

    primitivesModule.dispose();

    debugPrint("Sqrt: $sqrt");
  }

  void structsHelloWorld() {
    final StructsModule structsModule = StructsModule.import();

    final String helloWorld = structsModule.hello_world();

    structsModule.dispose();

    debugPrint("Hello World: $helloWorld");
  }

  void structsReverse() {
    final StructsModule structsModule = StructsModule.import();

    const String str = "Hello World";
    final String reversed = structsModule.reverse(str, str.length);

    structsModule.dispose();

    debugPrint("Reversed: $reversed");
  }

  void structsCreateCoordinate() {
    final StructsModule structsModule = StructsModule.import();

    final Coordinate coordinate = structsModule.create_coordinate(1, 2);

    structsModule.dispose();

    debugPrint("Coordinate: $coordinate");
  }

  void structsCreatePlace() {
    final StructsModule structsModule = StructsModule.import();

    final Place place = structsModule.create_place("Home", 5, -8.3);

    structsModule.dispose();

    debugPrint("Place: $place");
  }

  void structsDistance() {
    final StructsModule structsModule = StructsModule.import();

    final Coordinate c1 = structsModule.create_coordinate(2, 2);
    final Coordinate c2 = structsModule.create_coordinate(5, 6);
    final double distance = structsModule.distance(c1, c2);

    structsModule.dispose();

    debugPrint("Distance: $distance");
  }

  void structsCreateCoordinateDart() {
    final Coordinate coordinate = Coordinate(1, 2);

    debugPrint("Coordinate: $coordinate");
  }

  void structsDistanceDart() {
    final StructsModule structsModule = StructsModule.import();

    final Coordinate c1 = Coordinate(2, 2);
    final Coordinate c2 = Coordinate(5, 6);
    final double distance = structsModule.distance(c1, c2);

    structsModule.dispose();

    debugPrint("Distance: $distance");
  }

  void dataClass() {
    final DataClass dataClass = DataClass(1, "Hello World");

    debugPrint("DataClass: $dataClass");
  }

  void jsonParserParse() {
    final JsonParserModule jsonParserModule = JsonParserModule.import();

    const String json = '{"name": "John", "age": 30, "city": "New York"}';
    final Object? parsed = jsonParserModule.parse(json);

    jsonParserModule.dispose();

    debugPrint("Parsed json: $parsed");
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Plugin example app"),
          ),
          body: ButtonBar(
            children: <Widget>[
              ElevatedButton(
                onPressed: helloWorld,
                child: const Text("Run Python 'hello_world.hello_world()'"),
              ),
              const Divider(),
              ElevatedButton(
                onPressed: primitivesSum,
                child: const Text("Run Python 'primitives.sum(2, 3)'"),
              ),
              ElevatedButton(
                onPressed: primitivesSqrt,
                child: const Text("Run Python 'primitives.sqrt(3)'"),
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
                child:
                    const Text("Run Python 'structs.create_coordinate(1, 2)'"),
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
              const Divider(),
              ElevatedButton(
                onPressed: jsonParserParse,
                child: const Text(
                  "Run Python 'json_parser.parse(\"{\\\"name\\\": \\\"John\\\", \\\"age\\\": 30, \\\"city\\\": \\\"New York\\\"}\")'",
                ),
              ),
            ],
          ),
        ),
      );
}
