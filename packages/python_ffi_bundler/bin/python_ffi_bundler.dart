import "package:args/command_runner.dart";
import "package:python_ffi_bundler/python_ffi_bundler.dart";

Future<void> main(List<String> arguments) async {
  final CommandRunner<void> runner = CommandRunner<void>(
    "python_ffi_bundler",
    "The command line application for bundling Python modules into Dart applications.",
  )
    ..addCommand(BundleModuleCommand())
    ..addCommand(BundleCommand());

  await runner.run(arguments);
}
