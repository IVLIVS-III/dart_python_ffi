import "dart:async";
import "dart:convert";
import "dart:io";
import "dart:typed_data";

import "package:dartpip/dartpip.dart";

extension KeyMappingExtension<K, V> on Map<K, V> {
  Map<T, V> mapKeys<T>(
    T Function(K key) f,
  ) =>
      map((K key, V value) => MapEntry<T, V>(f(key), value));
}

extension ValueMappingExtension<K, V> on Map<K, V> {
  Map<K, T> mapValues<T>(
    T Function(V value) f,
  ) =>
      map((K key, V value) => MapEntry<K, T>(key, f(value)));
}

extension CamelCaseExtension on String {
  String get camelCase {
    final List<String> parts = split("_");
    final String firstPart = parts.first;
    final List<String> restParts = parts.sublist(1);

    return <String>[
      firstPart,
      ...restParts.map((String part) => part.capitalize()),
    ].join();
  }

  String capitalize() =>
      isEmpty ? this : "${this[0].toUpperCase()}${substring(1)}";
}

abstract class ModuleBundle<T extends PythonModule<Object>> {
  ModuleBundle({
    required this.pythonModule,
    required this.appRoot,
  });

  final T pythonModule;
  final String appRoot;

  Directory get _appRootDirectory => Directory(appRoot);

  Directory get _pythonModuleDestinationDirectory;

  ByteData _transformSourceData(ByteData data) => data;

  String _transformSourceFileName(String fileName) => fileName;

  SourceFile _sourceFile(String fileName) => SourceFile(
        <String>[
          _pythonModuleDestinationDirectory.path,
          _transformSourceFileName(fileName)
        ].join(Platform.pathSeparator),
      );

  Future<void> _exportSingleFile(String fileName, ByteData data);

  Future<void> _exportMultiFile(Map<List<String>, ByteData> data) async {
    for (final MapEntry<List<String>, ByteData> entry in data.entries) {
      await _exportSingleFile(
        entry.key.join(Platform.pathSeparator),
        entry.value,
      );
    }
  }

  FutureOr<void> _postExport(List<List<String>> filePaths) {
    moduleInfo = _updateModuleInfo(moduleInfo);
  }

  Map<String, dynamic> get moduleInfo;

  set moduleInfo(Map<String, dynamic> moduleInfo);

  Map<String, dynamic> _updateModuleInfo(Map<String, dynamic> moduleInfo) =>
      moduleInfo
        ..update(
          pythonModule.moduleName,
          (dynamic _) => pythonModule.moduleInfo,
          ifAbsent: () => pythonModule.moduleInfo,
        );

  Future<void> export() async {
    final T pythonModule = this.pythonModule;
    if (!(await pythonModule.load())) {
      throw StateError("Failed to load Python module.");
    }

    if (pythonModule is SingleFilePythonModule) {
      await _exportSingleFile(
        pythonModule.fileName,
        _transformSourceData(pythonModule.data),
      );
      await _postExport(<List<String>>[
        <String>[pythonModule.fileName]
      ]);
    } else if (pythonModule is MultiFilePythonModule) {
      await _exportMultiFile(
        pythonModule.data
            .mapKeys(
              (List<String> key) => <String>[pythonModule.moduleName, ...key],
            )
            .mapValues(_transformSourceData),
      );
      await _postExport(
        pythonModule.data.keys
            .map((List<String> e) => <String>[pythonModule.moduleName, ...e])
            .toList(),
      );
    }
  }
}

class AssetsInsertionConfig {
  AssetsInsertionConfig._({
    required this.pubspecString,
    required this.assets,
    required this.insertFlutterKey,
    required this.insertAssetsKey,
    required this.indentation,
    required this.insertionPoint,
  });

  factory AssetsInsertionConfig.fromPubspec(String pubspecString) {
    final Map<dynamic, dynamic> pubspecYaml = parsePubspec("", pubspecString);
    final int indentation = detectIndentation(pubspecString);

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

    return AssetsInsertionConfig._(
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

class FlutterModuleBundle<T extends Object>
    extends ModuleBundle<PythonModule<T>> {
  FlutterModuleBundle({
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
  void _postExport(List<List<String>> filePaths) {
    final String pubspecString = readPubspec(_appRootDirectory.path);

    final AssetsInsertionConfig config =
        AssetsInsertionConfig.fromPubspec(pubspecString);

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

    super._postExport(filePaths);
  }
}

class ConsoleModuleBundle<T extends Object>
    extends ModuleBundle<PythonModule<T>> {
  ConsoleModuleBundle({
    required super.pythonModule,
    required super.appRoot,
  });

  @override
  Directory get _pythonModuleDestinationDirectory => Directory(
        <String>[_appRootDirectory.path, "lib", "python_modules", "src"].join(
          Platform.pathSeparator,
        ),
      );

  static const String _pythonModulesDartFileName = "python_modules.g.dart";

  SourceFile get _pythonModulesDartFile => SourceFile(
        <String>[
          _pythonModuleDestinationDirectory.path,
          _pythonModulesDartFileName
        ].join(Platform.pathSeparator),
      );

  @override
  ByteData _transformSourceData(ByteData data) {
    final String base64 =
        base64Encode(super._transformSourceData(data).buffer.asUint8List());
    return ByteData.view(Uint8List.fromList(base64.codeUnits).buffer);
  }

  @override
  String _transformSourceFileName(String fileName) =>
      _pythonModulesDartFileName;

  String _varName(String fileName) {
    const String prefix = "k";
    const String suffix = "Base64";
    final String fileModuleName = fileName.endsWith(".py")
        ? fileName.substring(0, fileName.length - 3)
        : fileName;
    if (fileModuleName == pythonModule.moduleName) {
      return "$prefix${pythonModule.moduleName.camelCase.capitalize()}$suffix";
    }
    return "$prefix${pythonModule.moduleName.camelCase.capitalize()}${fileModuleName.camelCase.capitalize()}$suffix";
  }

  @override
  Future<void> _exportSingleFile(String fileName, ByteData data) async {
    final String replacement = String.fromCharCodes(data.buffer.asUint8List());
    final String varName = _varName(fileName);
    final String base64Prefix = """
const String $varName = \"""";
    const String base64Suffix = """
";
""";
    _sourceFile(fileName)
      ..replace(
        RegExp(
          "^${base64Prefix.replaceAll(RegExp(r"\s+"), r"\s+")}$kBase64RegexSource$base64Suffix",
          multiLine: true,
        ),
        base64Prefix + replacement + base64Suffix,
      )
      ..ensureHeader(kPythonModulesGeneratedHeader)
      ..ensureFooter("\n");
  }

  @override
  Map<String, dynamic> get moduleInfo {
    if (!_pythonModulesDartFile.existsSync()) {
      return <String, dynamic>{};
    }
    final String content = _pythonModulesDartFile.readAsStringSync();
    final RegExpMatch? match = kPythonModulesDartRegex.firstMatch(content);
    if (match == null) {
      return <String, dynamic>{};
    }
    final String? rawBase64 = match.group(1);
    if (rawBase64 == null) {
      return <String, dynamic>{};
    }
    final String rawJson = utf8.decode(base64Decode(rawBase64));
    return jsonDecode(rawJson) as Map<String, dynamic>;
  }

  @override
  set moduleInfo(Map<String, dynamic> moduleInfo) {
    final String newJson = jsonEncode(moduleInfo);
    final String base64 = base64Encode(utf8.encode(newJson));
    _pythonModulesDartFile
      ..replace(
        kPythonModulesDartRegex,
        "$kPythonModulesPrefix$base64$kPythonModulesSuffix",
      )
      ..ensureHeader(kPythonModulesGeneratedHeader)
      ..ensureFooter("\n");
  }
}
