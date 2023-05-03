part of dartpip;

/// Abstract command with utility methods to parse pubspec.yaml.
abstract class _PubspecCommand<T> extends Command<T> {
  _PubspecCommand() {
    argParser.addOption(_kAppRootOption, abbr: "r", mandatory: false);
  }

  String _getAppType(Map<dynamic, dynamic> pubspecYaml) {
    final dynamic dependencies = pubspecYaml["dependencies"];

    if (dependencies is! Map) {
      throw StateError(
        "pubspec.yaml does not contain a valid dependencies map.",
      );
    }

    if (dependencies.containsKey("flutter")) {
      return _kAppTypeFlutter;
    } else {
      return _kAppTypeConsole;
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

  String get _appRoot => argResults?[_kAppRootOption] as String? ?? ".";
}
