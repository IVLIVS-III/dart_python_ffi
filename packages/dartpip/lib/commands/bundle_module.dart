part of dartpip;

/// Implements the `bundle-module` command.
///
/// This command is legacy and may be removed in a future version.
class BundleModuleCommand extends Command<void> {
  /// Creates a new instance of the [BundleModuleCommand] class.
  BundleModuleCommand() {
    argParser
      ..addOption(_kAppRootOption, abbr: "r", mandatory: true)
      ..addOption(
        _kPythonModuleOption,
        abbr: "m",
        mandatory: true,
      )
      ..addOption(
        _kAppTypeOption,
        abbr: "t",
        allowed: <String>[_kAppTypeFlutter, _kAppTypeConsole],
        defaultsTo: _kAppTypeFlutter,
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

    final String appRoot = argResults[_kAppRootOption] as String;
    final String pythonModulePath = argResults[_kPythonModuleOption] as String;
    final String appType = argResults[_kAppTypeOption] as String;

    await _bundleModule(
      appRoot: appRoot,
      pythonModulePath: pythonModulePath,
      appType: appType,
    );
  }
}
