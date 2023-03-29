part of dartpip;

extension _FileSystemEntityNameExtension on FileSystemEntity {
  String get name =>
      path.substring(path.lastIndexOf(Platform.pathSeparator) + 1);
}

abstract class _PythonModule<T extends Object> {
  _PythonModule._(this.path);

  static _PythonModule<Object> fromPath(String path) {
    if (path.endsWith(".py")) {
      return _SingleFilePythonModule(path);
    }

    final String maybeFilePath = "$path.py";
    final File file = File(maybeFilePath);
    if (file.existsSync()) {
      return _SingleFilePythonModule(maybeFilePath);
    }

    return _MultiFilePythonModule(path);
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

class _SingleFilePythonModule extends _PythonModule<ByteData> {
  _SingleFilePythonModule(super.path) : super._();

  String get fileName => File(path).name;

  @override
  Future<ByteData?> _load() => _loadFile(path);

  @override
  String get moduleName => fileName.endsWith(".py")
      ? fileName.substring(0, fileName.length - 3)
      : fileName;

  @override
  Map<String, dynamic> get moduleInfo => <String, dynamic>{"root": fileName};
}

class _FileNode {
  _FileNode({required this.name}) : children = <_FileNode>[];

  final String name;
  final List<_FileNode> children;

  void insert(List<String> pathElements) {
    if (pathElements.isEmpty) {
      return;
    }
    final String name = pathElements.first;
    _FileNode? child =
        children.firstWhereOrNull((_FileNode node) => node.name == name);
    if (child == null) {
      child = _FileNode(name: name);
      children.add(child);
    }
    child.insert(pathElements.sublist(1));
  }

  Object? get info => children.isEmpty
      ? name
      : <String, Object>{
          "name": name,
          "children": children.map((_FileNode node) => node.info).toList(),
        };
}

class _MultiFilePythonModule
    extends _PythonModule<Map<List<String>, ByteData>> {
  _MultiFilePythonModule(super.path) : super._();

  @override
  String get moduleName => Directory(path).name;

  late final _FileNode _fileTree = _FileNode(name: moduleName);

  Future<Map<List<String>, ByteData>> _loadDirectory(
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
        final Map<List<String>, ByteData> subResult =
            await _loadDirectory(entity);
        for (final MapEntry<List<String>, ByteData> entry
            in subResult.entries) {
          result[<String>[entity.name, ...entry.key]] = entry.value;
        }
      }
    }
    return result;
  }

  @override
  Future<Map<List<String>, ByteData>?> _load() async {
    final Directory directory = Directory(path);
    if (!directory.existsSync()) {
      return null;
    }
    final Map<List<String>, ByteData> result = await _loadDirectory(directory);
    for (final List<String> key in result.keys) {
      _fileTree.insert(key);
    }
    return result;
  }

  @override
  Map<String, dynamic> get moduleInfo =>
      <String, dynamic>{"root": _fileTree.info};
}
