import "package:flutter/material.dart";
import "package:python_ffi/python_ffi.dart";
import "package:python_ffi_example/python-modules/hello_world.dart";
import "package:python_ffi_example/python-modules/primitives.dart";
import "package:python_ffi_example/python-modules/structs.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PythonFfi.instance.initialize();

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

    print("Sum: $sum");
  }

  void primitivesSqrt() {
    final PrimitivesModule primitivesModule = PrimitivesModule.import();

    final int sqrt = primitivesModule.sqrt(9);

    primitivesModule.dispose();

    print("Sqrt: $sqrt");
  }

  void structsHelloWorld() {
    final StructsModule structsModule = StructsModule.import();

    final String helloWorld = structsModule.hello_world();

    structsModule.dispose();

    print("Hello World: $helloWorld");
  }

  void structsReverse() {
    final StructsModule structsModule = StructsModule.import();

    const String str = "Hello World";
    final String reversed = structsModule.reverse(str, str.length);

    structsModule.dispose();

    print("Reversed: $reversed");
  }

  void structsCreateCoordinate() {
    final StructsModule structsModule = StructsModule.import();

    final Coordinate coordinate = structsModule.create_coordinate(1, 2);

    structsModule.dispose();

    print("Coordinate: $coordinate");
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
              ElevatedButton(
                onPressed: primitivesSum,
                child: const Text("Run Python 'primitives.sum(2, 3)'"),
              ),
              ElevatedButton(
                onPressed: primitivesSqrt,
                child: const Text("Run Python 'primitives.sqrt(3)'"),
              ),
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
            ],
          ),
        ),
      );
}
