part of dartpip;

/// Implements the `bundle` command.
class BundleCommand extends Command<void> {
  /// Creates a new instance of the [BundleCommand] class.
  BundleCommand() {
    argParser
      ..addOption(_kAppRootOption, abbr: "r", mandatory: true)
      ..addOption(
        _kPythonModulesRootOption,
        abbr: "m",
        mandatory: true,
      );
  }

  @override
  final String name = "bundle";

  @override
  final String description =
      "Bundles all Python modules specified in pubspec.yaml for a Dart application.";

  AppType _getAppType(Map<dynamic, dynamic> pubspecYaml) {
    final dynamic dependencies = pubspecYaml["dependencies"];

    if (dependencies is! Map) {
      throw StateError(
        "pubspec.yaml does not contain a valid dependencies map.",
      );
    }

    if (dependencies.containsKey("flutter")) {
      return AppType.flutter;
    } else {
      return AppType.console;
    }
  }

  Map<dynamic, dynamic> _getPythonFfiMap(Map<dynamic, dynamic> pubspecYaml) {
    final dynamic pythonFfi = pubspecYaml["python_ffi"];
    if (pythonFfi is! Map) {
      throw StateError(
        "pubspec.yaml does not contain a valid python_ffi map.",
      );
    }

    return pythonFfi;
  }

  Iterable<String> _getPythonModuleNames(Map<dynamic, dynamic> pythonFfiMap) {
    final dynamic pythonModules = pythonFfiMap["modules"];
    if (pythonModules is! Map) {
      return <String>[];
    }

    return pythonModules.keys.cast<String>();
  }

  void _removeGeneratedAssetDeclarations(AppType appType, String appRoot) {
    if (appType != AppType.flutter) {
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

    final String appRoot = argResults[_kAppRootOption] as String;
    final String pythonModuleRoot =
        argResults[_kPythonModulesRootOption] as String;

    final Map<dynamic, dynamic> pubspecYaml = _parsePubspec(appRoot);
    final AppType appType = _getAppType(pubspecYaml);
    final Iterable<String> pythonModuleNames =
        _getPythonModuleNames(_getPythonFfiMap(pubspecYaml));

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
    for (final String pythonModuleName in pythonModuleNames) {
      print("Bundling Python module '$pythonModuleName'...");
      futures.add(
        _bundleModule(
          appRoot: appRoot,
          pythonModulePath: <String>[pythonModuleRoot, pythonModuleName]
              .join(Platform.pathSeparator),
          appType: appType,
        ),
      );
    }

    await Future.wait(futures);
  }
}
