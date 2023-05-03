part of dartpip;

/// Implements the `install` command.
class InstallCommand extends _PubspecCommand<void> {
  @override
  final String name = "install";

  @override
  final String description =
      "Installs and bundles all Python modules specified in pubspec.yaml for a Dart application.";

  Directory get _pythonModuleRoot {
    final AppData appData = AppData.findOrCreate(".dartpip");
    final Directory cacheDir =
        Directory(<String>[appData.path, "cache"].join(Platform.pathSeparator));
    return cacheDir;
  }

  @override
  Future<void>? run() async {
    final ArgResults? argResults = this.argResults;
    if (argResults == null) {
      throw StateError("Options must be provided.");
    }

    final Map<dynamic, dynamic> pubspecYaml = _parsePubspec(_appRoot);
    final Set<String> pythonModuleNames = argResults.rest.toSet()
      ..addAll(_getPythonModuleNames(_getPythonFfiMap(pubspecYaml)));

    if (pythonModuleNames.isEmpty) {
      print(
        "No Python modules specified. Add them to pubspec.yaml or via 'dartpip install <module>.",
      );
      return;
    }

    // TODO: download modules if they don't exist in the cache

    return;

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

    final String appType = _getAppType(pubspecYaml);
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
          pythonModulePath: <String>[_pythonModuleRoot.path, pythonModuleName]
              .join(Platform.pathSeparator),
          appType: appType,
        ),
      );
    }

    await Future.wait(futures);
  }
}
