import "dart:async";
import "dart:io";
import "dart:typed_data";

import "package:python_ffi_bundler/python_ffi_bundler.dart";

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
      await _exportMultiFile(pythonModule.data.mapValues(_transformSourceData));
      await _postExport(pythonModule.data.keys.toList());
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

    bool insertAssetsKey = false;
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

  String _filePathsToYaml(List<List<String>> filePaths, int indent) {
    final String prefix = " " * indent;
    return filePaths
        .map((List<String> filePath) => "$prefix$prefix- ${filePath.join("/")}")
        .join("\n");
  }

  String insertIntoPubspec(List<List<String>> filePaths) {
    final StringBuffer buffer = StringBuffer();
    if (insertFlutterKey) {
      buffer.write("\nflutter:");
    }
    if (insertAssetsKey) {
      buffer.write("\n${" " * indentation}assets:");
    }
    buffer.write("\n${_filePathsToYaml(filePaths, indentation)}");
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

  @override
  ByteData _transformSourceData(ByteData data) {
    const String prefix = """
import "dart:typed_data";

final Uint8List kBytes = Uint8List.fromList(<int>[""";
    const String suffix = """
]);
""";

    final String bytes = super
        ._transformSourceData(data)
        .buffer
        .asUint8List()
        .map((int byte) => "$byte")
        .join(", ");

    final String content = prefix + bytes + suffix;
    return ByteData.view(
      Uint8List.fromList(content.codeUnits).buffer,
    );
  }

  @override
  String _transformSourceFileName(String fileName) =>
      "${super._transformSourceFileName(fileName)}.dart";
}
