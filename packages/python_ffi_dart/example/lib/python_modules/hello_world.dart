// ignore_for_file: non_constant_identifier_names

import "package:python_ffi_dart/python_ffi_dart.dart";

import "./src/hello_world.py.dart" as hello_world_py;

class HelloWorldModule extends PythonModule {
  HelloWorldModule.from(super.pythonModule) : super.from();

  static HelloWorldModule import() => PythonModule.import(
        "hello_world",
        HelloWorldModule.from,
      );

  void hello_world() => getFunction("hello_world").call(<Object?>[]);

  static PythonModuleDefinition get definition => PythonModuleDefinition(
        name: "hello_world",
        root: SourceBytes("hello_world.py", hello_world_py.kBytes),
        classNames: classNames,
      );

  static Iterable<String> get classNames => const <String>[];
}
