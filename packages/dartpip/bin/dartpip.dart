import "package:args/command_runner.dart";
import "package:dartpip/dartpip.dart";

Future<void> main(List<String> arguments) async {
  final CommandRunner<void> runner = CommandRunner<void>(
    "dartpip",
    "The command line application for bundling Python modules into Dart applications.",
  )
    ..addCommand(InstallCommand())
    ..addCommand(BundleModuleCommand())
    ..addCommand(BundleCommand())
    ..addCommand(DownloadCommand());

  await runner.run(arguments);
}
