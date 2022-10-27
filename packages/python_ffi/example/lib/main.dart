import "package:flutter/material.dart";
import "package:python_ffi/python_ffi.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final PythonFfi _pythonFfiPlugin = PythonFfi.instance;

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Plugin example app"),
          ),
          body: ButtonBar(
            children: <Widget>[
              ElevatedButton(
                onPressed: _pythonFfiPlugin.helloWorld,
                child: const Text("Run Python 'hello_world'"),
              ),
            ],
          ),
        ),
      );
}
