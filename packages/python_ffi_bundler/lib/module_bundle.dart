import "dart:async";
import "dart:convert";
import "dart:io";
import "dart:typed_data";

import "package:python_ffi_bundler/python_ffi_bundler.dart";

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

abstract class ModuleBundle<T extends PythonModule<Object>> {
  ModuleBundle({
    required this.pythonModule,
    required this.appRoot,
  });

  final T pythonModule;
  final String appRoot;

  Directory get _appRootDirectory => Directory(appRoot);

  Directory get _pythonModuleDestinationDirectory;

  File get _modulesJsonFile;

  ByteData _transformSourceData(ByteData data) => data;

  String _transformSourceFileName(String fileName) => fileName;

  Future<void> _exportSingleFile(String fileName, ByteData data) async {
    final File file = File(
      <String>[
        _pythonModuleDestinationDirectory.path,
        _transformSourceFileName(fileName)
      ].join(Platform.pathSeparator),
    );

    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    file.writeAsBytesSync(data.buffer.asUint8List());
  }

  Future<void> _exportMultiFile(Map<List<String>, ByteData> data) async {
    for (final MapEntry<List<String>, ByteData> entry in data.entries) {
      await _exportSingleFile(
        entry.key.join(Platform.pathSeparator),
        entry.value,
      );
    }
  }

  FutureOr<void> _postExport(List<List<String>> filePaths) {}

  String? _getModulesJsonSync();

  void _setModulesJsonSync(String data) {
    final ByteData transformedJson = _transformSourceData(
      ByteData.view(Uint8List.fromList(data.codeUnits).buffer),
    );
    final File modulesJsonFile = _modulesJsonFile;
    if (!modulesJsonFile.existsSync()) {
      _modulesJsonFile.createSync(recursive: true);
    }
    modulesJsonFile.writeAsBytesSync(
      transformedJson.buffer.asUint8List(),
    );
  }

  void _updateModulesJson(MapEntry<String, dynamic> entry) {
    final String? rawJson = _getModulesJsonSync();
    final dynamic decodedJson = rawJson == null ? null : jsonDecode(rawJson);
    final Map<String, dynamic> data = <String, dynamic>{};
    if (decodedJson is Map) {
      for (final MapEntry<dynamic, dynamic> e in decodedJson.entries) {
        final dynamic key = e.key;
        if (key is String) {
          data[key] = e.value;
        }
      }
    }
    data[entry.key] = entry.value;
    _setModulesJsonSync(jsonEncode(data));
  }

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

    _updateModulesJson(pythonModule.toJson());
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
          .toList()
        ..add(<String>["python-modules", "modules.json"]),
    );
    pubspecFile.writeAsStringSync(newPubspecString);

    super._postExport(filePaths);
  }

  @override
  File get _modulesJsonFile => File(
        <String>[_appRootDirectory.path, "python-modules", "modules.json"]
            .join(Platform.pathSeparator),
      );

  @override
  String? _getModulesJsonSync() {
    final File modulesJsonFile = _modulesJsonFile;
    if (!modulesJsonFile.existsSync()) {
      return null;
    }
    return modulesJsonFile.readAsStringSync();
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

  @override
  ByteData _transformSourceData(ByteData data) {
    const String bytesPrefix = """
import "dart:typed_data";

final Uint8List kBytes = Uint8List.fromList(<int>[""";
    const String bytesSuffix = """
]);
""";

    const String base64Prefix = """
const String kBase64 = \"""";
    const String base64Suffix = """
";
""";

    final String base64 =
        base64Encode(super._transformSourceData(data).buffer.asUint8List());

    final String bytes = super
        ._transformSourceData(data)
        .buffer
        .asUint8List()
        .map((int byte) => "$byte")
        .join(", ");

    final String bytesContent = bytesPrefix + bytes + bytesSuffix;
    final String base64Content = base64Prefix + base64 + base64Suffix;

    final String content = "$bytesContent\n$base64Content";
    return ByteData.view(Uint8List.fromList(content.codeUnits).buffer);
  }

  @override
  String _transformSourceFileName(String fileName) =>
      "${super._transformSourceFileName(fileName)}.dart";

  @override
  File get _modulesJsonFile => File(
        <String>[
          _appRootDirectory.path,
          "lib",
          "python_modules",
          "modules.json.dart"
        ].join(Platform.pathSeparator),
      );

  @override
  String? _getModulesJsonSync() {
    final File modulesJsonFile = _modulesJsonFile;
    if (!modulesJsonFile.existsSync()) {
      return null;
    }
    final String dartString = modulesJsonFile.readAsStringSync();
    const String startMarker = "const String kBase64 = \"";
    const String endMarker = "\";";
    final int start = dartString.indexOf(startMarker) + startMarker.length;
    if (start == -1) {
      return null;
    }
    final int end = dartString.indexOf(endMarker, start);
    if (end == -1) {
      return null;
    }
    if (end < start) {
      return null;
    }
    final String base64 = dartString.substring(start, end);
    return utf8.decode(base64Decode(base64));
  }
}
