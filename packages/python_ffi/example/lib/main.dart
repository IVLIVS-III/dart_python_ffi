import "package:flutter/material.dart";
import "package:python_ffi/python_ffi.dart";
import "package:python_ffi_example/python-modules/hello_world.dart";
import "package:python_ffi_example/python-modules/primitives.dart";

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
  Future<void> helloWorld() async {
    final HelloWorldModule helloWorldModule = await HelloWorldModule.import();

    helloWorldModule
      ..hello_world()
      ..dispose();
  }

  Future<void> primitivesSum() async {
    final PrimitivesModule primitivesModule = await PrimitivesModule.import();

    final int sum = primitivesModule.sum(2, 3);

    primitivesModule.dispose();

    print("Sum: $sum");
  }

  Future<void> primitivesSqrt() async {
    final PrimitivesModule primitivesModule = await PrimitivesModule.import();

    final int sqrt = primitivesModule.sqrt(9);

    primitivesModule.dispose();

    print("Sqrt: $sqrt");
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
            ],
          ),
        ),
      );
}
