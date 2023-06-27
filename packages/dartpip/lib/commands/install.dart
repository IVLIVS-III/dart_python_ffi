part of dartpip;

/// Implements the `install` command.
class InstallCommand extends Command<void> {
  /// Creates a new instance of the [InstallCommand] class.
  InstallCommand();

  @override
  final String name = "install";

  @override
  final List<String> aliases = <String>["add"];

  @override
  final String description =
      "Adds Python modules to the current Dart / Flutter project. They will be specified in pubspec.yaml and bundled for a Dart application.";

  String _getAppType(Map<dynamic, dynamic> pubspecYaml) {
    final dynamic dependencies = pubspecYaml["dependencies"];

    if (dependencies is! Map) {
      return _kAppTypeConsole;
    }

    if (dependencies.containsKey("flutter")) {
      return _kAppTypeFlutter;
    } else {
      return _kAppTypeConsole;
    }
  }

  void _removeGeneratedAssetDeclarations(String appType, String appRoot) {
    if (appType != _kAppTypeFlutter) {
      return;
    }
    final File pubspecYamlFile = File(
      <String>[appRoot, "pubspec.yaml"].join(Platform.pathSeparator),
    );
    String pubspecString = pubspecYamlFile.readAsStringSync();
    final _AssetsInsertionConfig assetsInsertionConfig =
        _AssetsInsertionConfig.fromPubspec(pubspecString);

    final List<MapEntry<int, int>> deletionSpans = <MapEntry<int, int>>[];
    for (final String asset in assetsInsertionConfig.assets) {
      if (!asset.startsWith("python-modules/")) {
        print("skipping $asset");
        continue;
      }
      if (asset == "python-modules/modules.json") {
        continue;
      }
      final int assetIndex = pubspecString.indexOf(
        RegExp("\\n\\s*-\\s*$asset"),
        deletionSpans.lastOrNull?.value ?? assetsInsertionConfig.insertionPoint,
      );
      if (assetIndex == -1) {
        throw StateError("Invalid pubspec.yaml: asset $asset not found.");
      }
      final int assetStringIndex = pubspecString.indexOf(
        asset,
        assetIndex,
      );
      deletionSpans.add(
        MapEntry<int, int>(
          assetIndex,
          (assetStringIndex - assetIndex) + asset.length,
        ),
      );
    }
    deletionSpans.sort(
      (MapEntry<int, int> a, MapEntry<int, int> b) => b.key.compareTo(a.key),
    );

    for (final MapEntry<int, int> deletionSpan in deletionSpans) {
      pubspecString = pubspecString.replaceRange(
        deletionSpan.key,
        deletionSpan.key + deletionSpan.value,
        "",
      );
    }
    pubspecYamlFile.writeAsStringSync(pubspecString);
  }

  @override
  Future<void>? run() async {
    final ArgResults? argResults = this.argResults;
    if (argResults == null) {
      throw StateError("Options must be provided.");
    }

    await PythonFfiDart.instance.initialize(base64.encode(utf8.encode("{}")));

    final String appRoot = Directory.current.path;
    final PubspecEditor pubspecEditor = PubspecEditor("$appRoot/pubspec.yaml");
    final List<PythonDependency> existingPythonModules =
        pubspecEditor.dependencies.toList();
    final List<String> existingPythonModulesNames =
        existingPythonModules.map((PythonDependency e) => e.name).toList();
    final List<PythonDependency> pythonModules = argResults.rest
        .whereNot(existingPythonModulesNames.contains)
        .map((String e) => PyPiDependency(name: e, version: "any"))
        .toList();
    print(
      "Found python modules in pubspec.yaml: ${existingPythonModules.join(", ")}",
    );
    print(
      "Adding python modules to pubspec.yaml: ${pythonModules.join(", ")}",
    );

    final Map<String, String> projects = <String, String>{};

    final List<Future<void>> downloadTasks = <Future<void>>[];
    for (final PythonDependency pythonModule in <PythonDependency>[
      ...existingPythonModules,
      ...pythonModules
    ]) {
      switch (pythonModule) {
        case PyPiDependency(
            name: final String moduleName,
            version: final String specifiedVersion,
          ):
          downloadTasks.add(
            PyPIService().fetch(projectName: moduleName).then(
              (String version) {
                pubspecEditor.addDependency(moduleName, version: "^$version");
                projects[moduleName] = version;
              },
            ),
          );
        case GitDependency():
          throw UnimplementedError("Git dependencies are not yet supported.");
        case PathDependency(
            name: final String moduleName,
            path: final String path,
          ):
          throw UnimplementedError("Path dependencies are not yet supported.");
      }
    }
    await Future.wait(downloadTasks);
    pubspecEditor
      ..save()
      ..close();

    final Map<dynamic, dynamic> pubspecYaml = _parsePubspec(appRoot);
    final String appType = _getAppType(pubspecYaml);

    if (projects.isEmpty) {
      print("No Python modules specified in pubspec.yaml.");
      return;
    }

    // Remove modules.json file if it exists.
    // This is necessary because the file is not overwritten. Otherwise old and
    // no longer used modules would still be listed in the file.
    final File modulesJsonFile = File(
      <String>[appRoot, "python-modules", "modules.json"]
          .join(Platform.pathSeparator),
    );
    if (modulesJsonFile.existsSync()) {
      modulesJsonFile.deleteSync();
    }

    // resets the pubspec.yaml generated assets
    _removeGeneratedAssetDeclarations(appType, appRoot);

    final List<Future<void>> futures = <Future<void>>[
      _bundleModule(
        appRoot: appRoot,
        pythonModulePath: _kBuiltinPythonFfiModuleName,
        appType: appType,
      ),
    ];
    for (final MapEntry<String, String> project in projects.entries) {
      final String pythonModuleName = project.key;
      final String version = project.value;
      print("Bundling Python module '$pythonModuleName'...");
      futures.add(
        _bundleCacheModule(
          projectName: pythonModuleName,
          projectVersion: version,
          appRoot: appRoot,
          appType: appType,
        ).then(
          (_ModuleBundle<_PythonModule<Object>> moduleBundle) =>
              _generateTypeDefs(moduleBundle.definition),
        ),
      );
    }

    await Future.wait(futures);
  }
}
