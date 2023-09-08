part of dartpip;

sealed class _PythonModule<T extends Object> {
  _PythonModule._(this.path);

  static _PythonModule<Object>? fromPath(String path) {
    switch (path) {
      case _kBuiltinPythonFfiModuleName:
        return _BuiltinPythonModule(path);
    }

    if (path.endsWith(".py")) {
      return _SingleFilePythonModule(path);
    }

    final String maybeFilePath = "$path.py";
    final File file = File(maybeFilePath);
    if (file.existsSync()) {
      return _SingleFilePythonModule(maybeFilePath);
    }

    final FileSystemEntityType type = FileSystemEntity.typeSync(
      path,
      followLinks: true,
    );
    if (type == FileSystemEntityType.directory) {
      return _MultiFilePythonModule(path);
    }

    return null;
  }

  static Future<Iterable<_PythonModule<Object>>> fromCache({
    required String projectName,
    required String version,
  }) async {
    final String cachePath =
        "${(await PyPIService().cacheDir).path}/$projectName-$version";
    return _MultiFileCachePythonModule._findPath(
      projectName: projectName,
      projectVersion: version,
      projectCacheDirectory: Directory(cachePath),
    );
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

  Object get moduleInfo;
}

final class _BuiltinPythonModule extends _PythonModule<ByteData> {
  _BuiltinPythonModule(super.path) : super._();

  @override
  Future<ByteData> _load() {
    switch (path) {
      case _kBuiltinPythonFfiModuleName:
        return Future<ByteData>.value(
          ByteData.view(base64Decode(_kPythonFfiBase64).buffer),
        );
      default:
        throw ArgumentError.value(path, "path", "Unknown builtin module.");
    }
  }

  @override
  String get moduleName => path;

  @override
  Map<String, Object> get moduleInfo {
    switch (path) {
      case _kBuiltinPythonFfiModuleName:
        return Map<String, Object>.from(_kPythonFfiModuleInfo);
      default:
        throw ArgumentError.value(path, "path", "Unknown builtin module.");
    }
  }
}

final class _SingleFilePythonModule extends _PythonModule<ByteData> {
  _SingleFilePythonModule(super.path) : super._();

  String get fileName => File(path).name;

  @override
  Future<ByteData?> _load() => _loadFile(path);

  @override
  String get moduleName => fileName.endsWith(".py")
      ? fileName.substring(0, fileName.length - 3)
      : fileName;

  @override
  Object get moduleInfo {
    final ByteData? data = _data;
    if (data == null) {
      return fileName;
    }
    return <String, Object>{
      "name": fileName,
      "base64": base64Encode(data.buffer.asUint8List()),
    };
  }
}

final class _FileNode {
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

  Object get info => children.isEmpty
      ? name
      : <String, Object>{
          "name": name,
          "children": children.map((_FileNode node) => node.info).toList(),
        };

  @override
  String toString() => info.toString();
}

final class _MultiFilePythonModule
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
  Object get moduleInfo => _fileTree.info;
}

final class _MultiFileCachePythonModule extends _MultiFilePythonModule {
  _MultiFileCachePythonModule._({
    required this.projectName,
    required this.projectVersion,
    required this.projectCacheDirectory,
    required String path,
  }) : super(path);

  /// Discovers python modules in a project cache directory.
  ///
  /// The following locations are searched in order:
  /// 1. A single file with the same name as the project.
  /// 2. A directory with the same name as the project.
  /// 3. Modules in the src directory.
  /// 4. Modules in the root directory.
  /// 5. The root directory.
  ///
  /// Steps 4 and 5 are only searched if no modules were found in steps 1-3.
  static Iterable<_PythonModule<Object>> _findPath({
    required String projectName,
    required String projectVersion,
    required Directory projectCacheDirectory,
  }) sync* {
    _SingleFilePythonModule fileModule(String path) =>
        _SingleFilePythonModule(path);

    _MultiFileCachePythonModule dirModule(String path) =>
        _MultiFileCachePythonModule._(
          projectName: path.split(Platform.pathSeparator).last,
          projectVersion: projectVersion,
          projectCacheDirectory: projectCacheDirectory,
          path: path,
        );

    Iterable<_PythonModule<Object>> yieldFromDirectory(
      Directory dir, {
      bool Function(FileSystemEntity e)? filter,
    }) =>
        dir
            .listSync()
            .where(filter ?? (_) => true)
            .map<_PythonModule<Object>?>(
              (FileSystemEntity e) => switch (e) {
                File() when e.name.endsWith(".py") => fileModule(e.path),
                Directory()
                    when e
                        .listSync(recursive: true)
                        .whereType<File>()
                        .any((File element) => element.name.endsWith(".py")) =>
                  // This cast is needed to teach the analyzer that both branches of the
                  // switch return subtypes of _PythonModule<Object>.
                  // It is safe to do this cast because _MultiFileCachePythonModule
                  // extends _PythonModule<Object>, thus also the unnecessary cast
                  // warning.
                  // ignore: unnecessary_cast
                  dirModule(e.path) as _PythonModule<Object>,
                _ => null,
              },
            )
            .whereNotNull();

    bool didYield = false;

    // Look for a single file with the same name as the project.
    final String defaultFilePath =
        "${projectCacheDirectory.path}/$projectName.py";
    if (File(defaultFilePath).existsSync()) {
      yield fileModule(defaultFilePath);
      didYield = true;
    }

    // Look for a directory with the same name as the project.
    final String defaultDirPath = "${projectCacheDirectory.path}/$projectName";
    if (Directory(defaultDirPath).existsSync()) {
      yield dirModule(defaultDirPath);
      didYield = true;
    }

    // Look for modules in the src directory.
    final String defaultSrcPath = "${projectCacheDirectory.path}/src";
    if (Directory(defaultSrcPath).existsSync()) {
      yield* yieldFromDirectory(Directory(defaultSrcPath));
      didYield = true;
    }

    // Look for modules in the root directory.
    if (!didYield) {
      yield* yieldFromDirectory(
        projectCacheDirectory,
        filter: (FileSystemEntity e) => e.name != "setup.py",
      );
      didYield = true;
    }

    // Yield the root directory if nothing else was found.
    if (!didYield) {
      yield dirModule(projectCacheDirectory.path);
    }
  }

  final String projectName;
  final String projectVersion;
  final Directory projectCacheDirectory;

  File? get findLicense {
    for (final FileSystemEntity entity in projectCacheDirectory.listSync()) {
      if (entity is File) {
        if (entity.name.toLowerCase().contains("license")) {
          return entity;
        }
      }
    }
    return null;
  }

  @override
  Future<Map<List<String>, ByteData>?> _load() async {
    final Map<List<String>, ByteData> result =
        await super._load() ?? <List<String>, ByteData>{};
    final File? licenseFile = findLicense;
    final String licenseFileName = licenseFile?.name ?? "LICENSE";
    final ByteData? licenseData =
        licenseFile != null ? await _loadFile(licenseFile.path) : null;
    if (licenseData != null) {
      result[<String>[licenseFileName]] = licenseData;
      _fileTree.insert(<String>[licenseFileName]);
    }
    print(
      "Loaded $projectName-$projectVersion from cache at '$path' with file tree: $_fileTree.",
    );
    if (result.isEmpty) {
      return null;
    }
    return result;
  }

  @override
  String get moduleName => projectName;
}
