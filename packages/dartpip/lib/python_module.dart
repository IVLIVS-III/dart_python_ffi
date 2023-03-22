import "dart:io";
import "dart:typed_data";

import "package:collection/collection.dart";

extension FileSystemEntityNameExtension on FileSystemEntity {
  String get name =>
      path.substring(path.lastIndexOf(Platform.pathSeparator) + 1);
}

abstract class PythonModule<T extends Object> {
  PythonModule._(this.path);

  static PythonModule<Object> fromPath(String path) {
    if (path.endsWith(".py")) {
      return SingleFilePythonModule(path);
    }

    final String maybeFilePath = "$path.py";
    final File file = File(maybeFilePath);
    if (file.existsSync()) {
      return SingleFilePythonModule(maybeFilePath);
    }

    return MultiFilePythonModule(path);
  }

  final String path;
  T? _data;

  bool get isLoaded => _data != null;

  T get data {
    final T? data = _data;
    if (data == null) {
      throw StateError("Module is not loaded.");
    }

    return data;
  }

  Future<ByteData?> _loadFile(String filePath) async {
    final File file = File(filePath);

    if (!file.existsSync()) {
      return null;
    }

    return file.readAsBytes().then(
          (List<int> bytes) => ByteData.view(
            Uint8List.fromList(bytes).buffer,
          ),
        );
  }

  Future<T?> _load();

  /// Loads the module and returns whether the module was loaded successfully.
  Future<bool> load() async {
    if (isLoaded) {
      return true;
    }
    _data = await _load();
    return _data != null;
  }

  String get moduleName;

  Map<String, dynamic> get moduleInfo;
}

class SingleFilePythonModule extends PythonModule<ByteData> {
  SingleFilePythonModule(super.path) : super._();

  String get fileName => File(path).name;

  @override
  Future<ByteData?> _load() => _loadFile(path);

  @override
  String get moduleName => fileName.endsWith(".py")
      ? fileName.substring(0, fileName.length - 3)
      : fileName;

  @override
  Map<String, dynamic> get moduleInfo => <String, dynamic>{
        "root": <String>[fileName]
      };
}

class FileNode {
  FileNode({required this.name}) : children = <FileNode>[];

  final String name;
  final List<FileNode> children;

  void insert(List<String> pathElements) {
    if (pathElements.isEmpty) {
      return;
    }
    final String name = pathElements.first;
    FileNode? child =
        children.firstWhereOrNull((FileNode node) => node.name == name);
    if (child == null) {
      child = FileNode(name: name);
      children.add(child);
    }
    child.insert(pathElements.sublist(1));
  }

  Object? get info => children.isEmpty
      ? name
      : <String, Object>{
          "name": name,
          "children": children.map((FileNode node) => node.info).toList(),
        };
}

class MultiFilePythonModule extends PythonModule<Map<List<String>, ByteData>> {
  MultiFilePythonModule(super.path) : super._();

  @override
  String get moduleName => Directory(path).name;

  late final FileNode _fileTree = FileNode(name: moduleName);

  Future<Map<List<String>, ByteData>?> _loadDirectory(
    Directory directory,
  ) async {
    final Map<List<String>, ByteData> result = <List<String>, ByteData>{};
    await for (final FileSystemEntity entity in directory.list()) {
      if (entity is File) {
        final ByteData? fileData = await _loadFile(entity.path);
        if (fileData != null) {
          result[<String>[entity.name]] = fileData;
        }
      } else if (entity is Directory) {
        final Map<List<String>, ByteData>? subResult =
            await _loadDirectory(directory);
        if (subResult == null) {
          continue;
        }
        for (final MapEntry<List<String>, ByteData> entry
            in subResult.entries) {
          result[<String>[entity.name, ...entry.key]] = entry.value;
        }
      }
    }
    for (final List<String> key in result.keys) {
      _fileTree.insert(key);
    }
    return result;
  }

  @override
  Future<Map<List<String>, ByteData>?> _load() async {
    final Directory directory = Directory(path);
    if (!directory.existsSync()) {
      return null;
    }
    return _loadDirectory(directory);
  }

  @override
  Map<String, dynamic> get moduleInfo =>
      <String, dynamic>{"root": _fileTree.info};
}
