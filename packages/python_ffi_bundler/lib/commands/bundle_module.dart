import "package:args/args.dart";
import "package:args/command_runner.dart";
import "package:python_ffi_bundler/python_ffi_bundler.dart";

class BundleModuleCommand extends Command<void> {
  BundleModuleCommand() {
    argParser
      ..addOption(kAppRootOption, abbr: "r", mandatory: true)
      ..addOption(
        kPythonModuleOption,
        abbr: "m",
        mandatory: true,
      )
      ..addOption(
        kAppTypeOption,
        abbr: "t",
        allowed: <String>[kAppTypeFlutter, kAppTypeConsole],
        defaultsTo: kAppTypeFlutter,
      );
  }

  @override
  final String name = "bundle-module";

  @override
  final String description = "Bundles a Python module into a Dart application.";

  @override
  Future<void> run() async {
    final ArgResults? argResults = this.argResults;
    if (argResults == null) {
      throw StateError("Options must be provided.");
    }

    final String appRoot = argResults[kAppRootOption] as String;
    final String pythonModulePath = argResults[kPythonModuleOption] as String;
    final String appType = argResults[kAppTypeOption] as String;

    await bundleModule(
      appRoot: appRoot,
      pythonModulePath: pythonModulePath,
      appType: appType,
    );
  }
}
