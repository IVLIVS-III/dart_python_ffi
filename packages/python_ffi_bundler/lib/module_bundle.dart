import "dart:io";
import "dart:typed_data";

import "package:python_ffi_bundler/python_module.dart";

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

  Future<void> _postExport(List<List<String>> filePaths) async {}

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

class FlutterModuleBundle<T extends Object>
    extends ModuleBundle<PythonModule<T>> {
  FlutterModuleBundle({
    required super.pythonModule,
    required super.appRoot,
  });

  @override
  Directory get _pythonModuleDestinationDirectory => Directory(
        <String>[_appRootDirectory.path, "lib", "python-modules"]
            .join(Platform.pathSeparator),
      );

  @override
  Future<void> _postExport(List<List<String>> filePaths) {
    // TODO: implement _postExport
    //       - Add an asset entry to pubspec.yaml
    return super._postExport(filePaths);
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
