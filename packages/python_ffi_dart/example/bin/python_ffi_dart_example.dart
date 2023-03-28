import "package:args/command_runner.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:python_ffi_dart_example/python_ffi_dart_example.dart"
    as python_ffi_dart_example;
import "package:python_ffi_dart_example/python_modules/src/python_modules.g.dart";

class TypeMappingsCommand extends Command<void> {
  @override
  final String name = "type-mappings";

  @override
  final String description = "Tests the type mappings.";

  @override
  Future<void> run() async {
    await python_ffi_dart_example.typeMappings();
  }
}

Future<void> main(List<String> arguments) async {
  final CommandRunner<void> runner = CommandRunner<void>(
    "python_ffi_dart_example",
    "The example command line application showcasing the python_ffi_dart package, a Python-FFI for Dart.",
  )..addCommand(TypeMappingsCommand());

  await PythonFfiDart.instance.initialize(kPythonModules);

  await runner.run(arguments);
}
