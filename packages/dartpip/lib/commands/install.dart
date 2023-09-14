part of dartpip;

// moduleName -> (pythonDependency, version)
typedef _ProjectMap = Map<String, (PythonDependency, String)>;

/// Type of the bundle target application.
/// [AppType.console] is a Dart console application.
/// [AppType.flutter] is a Flutter application.
enum AppType {
  /// A Dart console application.
  console,

  /// A Flutter application.
  flutter;

  /// Converts a string to an [AppType].
  static AppType fromString(String string) {
    switch (string) {
      case _kAppTypeConsole:
        return AppType.console;
      case _kAppTypeFlutter:
        return AppType.flutter;
      default:
        throw ArgumentError.value(string, "string");
    }
  }
}

/// Implements the `install` command.
class InstallCommand extends Command<void> {
  /// Creates a new instance of the [InstallCommand] class.
  InstallCommand() {
    argParser.addFlag(
      _kDumpOption,
      abbr: "d",
      negatable: false,
      help:
          "Dump the collected information about the Python modules as *.g.json files.",
    );
  }

  @override
  final String name = "install";

  @override
  final List<String> aliases = <String>["add"];

  @override
  final String description =
      "Adds Python modules to the current Dart / Flutter project. They will be specified in pubspec.yaml and bundled for a Dart application.";

  AppType _getAppType(Map<dynamic, dynamic> pubspecYaml) {
    final dynamic dependencies = pubspecYaml["dependencies"];

    if (dependencies is! Map) {
      return AppType.console;
    }

    if (dependencies.containsKey("flutter")) {
      return AppType.flutter;
    } else {
      return AppType.console;
    }
  }

  void _removeGeneratedAssetDeclarations(AppType appType, String appRoot) {
    if (appType != AppType.flutter) {
      return;
    }
    final File pubspecYamlFile = File(p.join(appRoot, "pubspec.yaml"));
    String pubspecString = pubspecYamlFile.readAsStringSync();
    final _AssetsInsertionConfig assetsInsertionConfig =
        _AssetsInsertionConfig.fromPubspec(pubspecString);

    final List<MapEntry<int, int>> deletionSpans = <MapEntry<int, int>>[];
    for (final String asset in assetsInsertionConfig.assets) {
      if (!asset.startsWith("python-modules/")) {
        DartpipCommandRunner.logger.trace("skipping $asset");
        continue;
      }
      if (asset == p.join("python-modules", "modules.json")) {
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

  List<PythonDependency> _collectDirectDependencies({
    required ArgResults argResults,
    required PubspecEditor pubspecEditor,
  }) {
    final List<PythonDependency> existingPythonModules =
        pubspecEditor.dependencies.toList();
    final Iterable<String> existingPythonModulesNames =
        existingPythonModules.map((PythonDependency e) => e.name);
    final Iterable<PyPiDependency> pythonModules = argResults.rest
        .whereNot(existingPythonModulesNames.contains)
        .map((String e) => PyPiDependency(name: e, version: "any"));
    if (existingPythonModules.isNotEmpty) {
      DartpipCommandRunner.logger.stdout(
        "Found python modules in pubspec.yaml: ${existingPythonModules.join(", ")}",
      );
    }
    if (pythonModules.isNotEmpty) {
      DartpipCommandRunner.logger.stdout(
        "Adding python modules to pubspec.yaml: ${pythonModules.join(", ")}",
      );
    }
    return <PythonDependency>[
      ...existingPythonModules,
      ...pythonModules,
    ];
  }

  Future<Iterable<PythonDependency>> _collectAllDependencies(
    Iterable<PythonDependency> directDependencies,
  ) async {
    final (
      Iterable<PythonDependency> nonPyPiDependencies,
      Iterable<PyPiDependency> pyPiDependencies
    ) = directDependencies.split();

    final Iterable<PyPiDependency> allPyPiDependencies = await solve(
      pyPiDependencies.map(
        (PyPiDependency e) => Constraint(name: e.name, constraint: e.version),
      ),
    ).then(
      (Set<Dependency> value) => value.map(
        (Dependency e) => PyPiDependency(name: e.name, version: e.version),
      ),
    );

    return nonPyPiDependencies.followedBy(allPyPiDependencies);
  }

  Future<_ProjectMap> _downloadAllDependencies({
    required ArgResults argResults,
    required PubspecEditor pubspecEditor,
  }) async {
    final Iterable<PythonDependency> directDependencies =
        _collectDirectDependencies(
      argResults: argResults,
      pubspecEditor: pubspecEditor,
    );

    final Iterable<PythonDependency> allDependencies =
        await _collectAllDependencies(directDependencies);

    final _ProjectMap projects = <String, (PythonDependency, String)>{};

    final List<Future<void>> downloadTasks = <Future<void>>[];
    for (final PythonDependency pythonModule in allDependencies) {
      final Progress installProgress = DartpipCommandRunner.logger.progress(
        "Installing $pythonModule",
      );
      switch (pythonModule) {
        case PyPiDependency(
            name: final String moduleName,
            version: final String specifiedVersion,
          ):
          downloadTasks.add(
            PyPIService()
                .fetch(projectName: moduleName, version: specifiedVersion)
                .then(
              (String? version) {
                installProgress.finish(showTiming: true);
                if (version == null) {
                  return;
                }
                if (directDependencies.any(
                  (PythonDependency element) => element.name == moduleName,
                )) {
                  pubspecEditor.addDependency(moduleName, version: "^$version");
                }
                projects[moduleName] = (pythonModule, version);
              },
            ),
          );
        case GitDependency():
          throw UnimplementedError("Git dependencies are not yet supported.");
        case PathDependency(
            name: final String moduleName,
            path: final String path,
          ):
          projects[moduleName] = (pythonModule, path);
      }
    }
    await Future.wait(downloadTasks);
    return projects;
  }

  @override
  Future<void>? run() async {
    final ArgResults? argResults = this.argResults;
    if (argResults == null) {
      throw StateError("Options must be provided.");
    }

    final bool dump = argResults[_kDumpOption] as bool;

    final String appRoot = Directory.current.path;
    final PubspecEditor pubspecEditor =
        PubspecEditor(p.join(appRoot, "pubspec.yaml"));

    final _ProjectMap projects = await _downloadAllDependencies(
      argResults: argResults,
      pubspecEditor: pubspecEditor,
    );

    pubspecEditor
      ..save()
      ..close();

    final Map<dynamic, dynamic> pubspecYaml = _parsePubspec(appRoot);
    final AppType appType = _getAppType(pubspecYaml);

    if (projects.isEmpty) {
      DartpipCommandRunner.logger.stdout(
        "No Python modules specified in pubspec.yaml.",
      );
      return;
    }

    // Remove modules.json file if it exists.
    // This is necessary because the file is not overwritten. Otherwise old and
    // no longer used modules would still be listed in the file.
    final File modulesJsonFile =
        File(p.join(appRoot, "python-modules", "modules.json"));
    if (modulesJsonFile.existsSync()) {
      modulesJsonFile.deleteSync();
    }

    // Remove previously generated files.
    final Directory pythonModulesDir =
        Directory(p.join(appRoot, "lib", "python_modules"));
    if (pythonModulesDir.existsSync()) {
      await pythonModulesDir
          .list(recursive: true)
          .where(
            (FileSystemEntity e) =>
                e is File &&
                (e.name.endsWith(".g.dart") || e.name.endsWith(".g.json")),
          )
          .forEach((FileSystemEntity e) async => e.delete());
    }

    // resets the pubspec.yaml generated assets
    _removeGeneratedAssetDeclarations(appType, appRoot);

    final List<Future<Iterable<_ModuleBundle<Object>>>> futures =
        <Future<Iterable<_ModuleBundle<Object>>>>[
      _bundleModule(
        appRoot: appRoot,
        pythonModulePath: _kBuiltinPythonFfiModuleName,
        appType: appType,
      ).toIterable(),
    ];
    for (final MapEntry<String, (PythonDependency, String)> project
        in projects.entries) {
      final String pythonModuleName = project.key;
      final (PythonDependency pythonDependency, String version) = project.value;
      DartpipCommandRunner.logger.stdout(
        "Bundling Python module '$pythonModuleName'...",
      );
      final Future<Iterable<_ModuleBundle<Object>>> bundleTask =
          switch (pythonDependency) {
        PyPiDependency() => _bundleCacheModule(
            projectName: pythonModuleName,
            projectVersion: version,
            appRoot: appRoot,
            appType: appType,
          ),
        GitDependency() =>
          throw UnimplementedError("Git dependencies are not yet supported."),
        PathDependency(path: final String path) => _bundleModule(
            appRoot: appRoot,
            pythonModulePath: path,
            appType: appType,
          ).toIterable(),
      };
      futures.add(
        bundleTask.then(
          (Iterable<_ModuleBundle<Object>> value) async => Future.wait(
            value.map(
              (_ModuleBundle<Object> e) async {
                final _ConsoleModuleBundle<Object> consoleModuleBundle =
                    await _ensureConsoleModuleBundle(e);
                final PythonModuleDefinition definition =
                    consoleModuleBundle.definition;
                await PythonFfiDart.instance.prepareModule(definition);
                DartpipCommandRunner.logger.trace(
                  "prepared '${definition.name}' to be imported",
                );
                return consoleModuleBundle;
              },
            ),
          ),
        ),
      );
    }

    final Iterable<_ModuleBundle<Object>?> bundleTaskResults =
        (await Future.wait(futures)).flattened;

    await Future.wait(
      bundleTaskResults.map(
        (_ModuleBundle<Object>? e) => _bundleAndGenerate(
          moduleBundle: e,
          appType: appType,
          appRoot: appRoot,
          dump: dump,
        ),
      ),
    );
  }
}
