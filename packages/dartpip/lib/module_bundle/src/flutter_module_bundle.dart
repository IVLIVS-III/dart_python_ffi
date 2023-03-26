part of dartpip;

class _AssetsInsertionConfig {
  _AssetsInsertionConfig._({
    required this.pubspecString,
    required this.assets,
    required this.insertFlutterKey,
    required this.insertAssetsKey,
    required this.indentation,
    required this.insertionPoint,
  });

  factory _AssetsInsertionConfig.fromPubspec(String pubspecString) {
    final Map<dynamic, dynamic> pubspecYaml = _parsePubspec("", pubspecString);
    final int indentation = _detectIndentation(pubspecString);

    final bool insertFlutterKey = !pubspecYaml.containsKey("flutter");

    final List<String> assets = <String>[];

    bool insertAssetsKey = insertFlutterKey;
    if (!insertFlutterKey) {
      final dynamic flutter = pubspecYaml["flutter"];
      if (flutter is! Map) {
        throw StateError("Invalid pubspec.yaml: flutter is not a map.");
      }
      insertAssetsKey = !flutter.containsKey("assets");

      if (!insertAssetsKey) {
        final dynamic assetsValue = flutter["assets"];
        if (assetsValue is! List) {
          throw StateError("Invalid pubspec.yaml: assets is not a list.");
        }
        assets.addAll(assetsValue.cast<String>());
      }
    }

    late int insertionPoint;
    if (insertFlutterKey) {
      insertionPoint = pubspecString.length;
    } else if (insertAssetsKey) {
      final int flutterIndex = pubspecString.indexOf("\nflutter:");
      insertionPoint = pubspecString.indexOf("\n", flutterIndex + 1);
    } else {
      final int flutterIndex = pubspecString.indexOf("\nflutter:");
      final int assetsIndex =
          pubspecString.indexOf("\n${" " * indentation}assets:", flutterIndex);
      insertionPoint = pubspecString.indexOf("\n", assetsIndex + 1);
    }

    return _AssetsInsertionConfig._(
      pubspecString: pubspecString,
      assets: assets,
      insertFlutterKey: insertFlutterKey,
      insertAssetsKey: insertAssetsKey,
      indentation: indentation,
      insertionPoint: insertionPoint,
    );
  }

  final String pubspecString;
  final List<String> assets;
  final bool insertFlutterKey;
  final bool insertAssetsKey;
  final int indentation;
  final int insertionPoint;

  String _filePathsToYaml(
    List<List<String>> filePaths,
    int indent, {
    String prefix = "",
  }) {
    final String linePrefix = " " * indent;
    final String yaml = filePaths
        .map((List<String> filePath) => filePath.join("/"))
        .where((String filePath) => !assets.contains(filePath))
        .map((String filePath) => "$linePrefix$linePrefix- $filePath")
        .join("\n");
    if (yaml.isEmpty) {
      return "";
    }
    return "$prefix$yaml";
  }

  String insertIntoPubspec(List<List<String>> filePaths) {
    if (filePaths.isEmpty) {
      return pubspecString;
    }

    final StringBuffer buffer = StringBuffer();
    if (insertFlutterKey) {
      buffer.write("\nflutter:");
    }
    if (insertAssetsKey) {
      buffer.write("\n${" " * indentation}assets:");
    }
    buffer.write(_filePathsToYaml(filePaths, indentation, prefix: "\n"));
    final String insertString = buffer.toString();
    return pubspecString.replaceRange(
      insertionPoint,
      insertionPoint,
      insertString,
    );
  }
}

class _FlutterModuleBundle<T extends Object>
    extends _ModuleBundle<_PythonModule<T>> {
  _FlutterModuleBundle({
    required super.pythonModule,
    required super.appRoot,
  });

  @override
  Directory get _pythonModuleDestinationDirectory => Directory(
        <String>[_appRootDirectory.path, "python-modules"]
            .join(Platform.pathSeparator),
      );

  File get _modulesJsonFile => File(
        <String>[_pythonModuleDestinationDirectory.path, "modules.json"]
            .join(Platform.pathSeparator),
      );

  @override
  Map<String, dynamic> get moduleInfo {
    if (!_modulesJsonFile.existsSync()) {
      return <String, dynamic>{};
    }
    final String content = _modulesJsonFile.readAsStringSync();
    if (content.trim().isEmpty) {
      return <String, dynamic>{};
    }
    return jsonDecode(content) as Map<String, dynamic>;
  }

  @override
  set moduleInfo(Map<String, dynamic> moduleInfo) {
    if (!_modulesJsonFile.existsSync()) {
      _modulesJsonFile.createSync(recursive: true);
    }
    final String newContent = jsonEncode(moduleInfo);
    _modulesJsonFile.writeAsStringSync(newContent);
  }

  @override
  Future<void> _exportSingleFile(String fileName, ByteData data) async {
    _sourceFile(fileName).writeBytes(data);
  }

  @override
  FutureOr<void> _postExport(List<List<String>> filePaths) {
    filePaths.add(<String>["modules.json"]);

    final String pubspecString = _readPubspec(_appRootDirectory.path);

    final _AssetsInsertionConfig config =
        _AssetsInsertionConfig.fromPubspec(pubspecString);

    final File pubspecFile = File(
      <String>[_appRootDirectory.path, "pubspec.yaml"]
          .join(Platform.pathSeparator),
    );
    final String newPubspecString = config.insertIntoPubspec(
      filePaths
          .map((List<String> e) => <String>["python-modules", ...e])
          .toList(),
    );
    pubspecFile.writeAsStringSync(newPubspecString);

    return super._postExport(filePaths);
  }
}
