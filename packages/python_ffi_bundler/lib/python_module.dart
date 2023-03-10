import "dart:io";
import "dart:typed_data";

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

  String get moduleName;

  bool get isLoaded => _data != null;

  T get data {
    final T? data = _data;
    if (data == null) {
      throw StateError("Module is not loaded.");
    }

    return data;
  }

  FileSystemEntity get source;

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

  MapEntry<String, dynamic> toJson() => MapEntry<String, dynamic>(
        moduleName,
        <String, dynamic>{
          "root": source.structure,
        },
      );
}

class SingleFilePythonModule extends PythonModule<ByteData> {
  SingleFilePythonModule(super.path) : super._();

  @override
  FileSystemEntity get source => File(path);

  String get fileName => source.name;

  @override
  String get moduleName => fileName.endsWith(".py")
      ? fileName.substring(0, fileName.length - 3)
      : fileName;

  @override
  Future<ByteData?> _load() => _loadFile(path);
}

class MultiFilePythonModule extends PythonModule<Map<List<String>, ByteData>> {
  MultiFilePythonModule(super.path) : super._();

  @override
  FileSystemEntity get source => Directory(path);

  @override
  String get moduleName => source.name;

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
          result[<String>[directory.name, ...entry.key]] = entry.value;
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
    return _loadDirectory(directory);
  }
}

extension FileSystemEntityExtension on FileSystemEntity {
  Object get structure {
    if (this is File) {
      return name;
    } else if (this is Directory) {
      final List<Object> result = <Object>[];
      for (final FileSystemEntity child in (this as Directory).listSync()) {
        result.add(child.structure);
      }
      return result;
    } else {
      throw StateError("Unknown FileSystemEntity type.");
    }
  }
}
