part of dartpip;

/// Implements the `bundle` command.
class BundleCommand extends _PubspecCommand<void> {
  /// Creates a new instance of the [BundleCommand] class.
  BundleCommand() {
    argParser.addOption(_kPythonModulesRootOption, abbr: "m", mandatory: true);
  }

  @override
  final String name = "bundle";

  @override
  final String description =
      "Bundles all Python modules specified in pubspec.yaml for a Dart application.";

  String get _pythonModuleRoot {
    final ArgResults? argResults = this.argResults;
    if (argResults == null) {
      throw StateError("Options must be provided.");
    }
    return argResults[_kPythonModulesRootOption] as String;
  }

  @override
  Future<void>? run() async {
    final Map<dynamic, dynamic> pubspecYaml = _parsePubspec(_appRoot);
    final String appType = _getAppType(pubspecYaml);
    final Iterable<String> pythonModuleNames =
        _getPythonModuleNames(_getPythonFfiMap(pubspecYaml));

    if (pythonModuleNames.isEmpty) {
      print("No Python modules specified in pubspec.yaml.");
      return;
    }

    // Remove modules.json file if it exists.
    // This is necessary because the file is not overwritten. Otherwise old and
    // no longer used modules would still be listed in the file.
    final File modulesJsonFile = File(
      <String>[_appRoot, "python-modules", "modules.json"]
          .join(Platform.pathSeparator),
    );
    if (modulesJsonFile.existsSync()) {
      modulesJsonFile.deleteSync();
    }

    // resets the pubspec.yaml generated assets
    _removeGeneratedAssetDeclarations(appType, _appRoot);

    final List<Future<void>> futures = <Future<void>>[
      _bundleModule(
        appRoot: _appRoot,
        pythonModulePath: _kBuiltinPythonFfiModuleName,
        appType: appType,
      ),
    ];
    for (final String pythonModuleName in pythonModuleNames) {
      print("Bundling Python module '$pythonModuleName'...");
      futures.add(
        _bundleModule(
          appRoot: _appRoot,
          pythonModulePath: <String>[_pythonModuleRoot, pythonModuleName]
              .join(Platform.pathSeparator),
          appType: appType,
        ),
      );
    }

    await Future.wait(futures);
  }
}
