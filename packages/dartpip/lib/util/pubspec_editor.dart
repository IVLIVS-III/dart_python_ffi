part of dartpip;

/// TODO: Document.
final class PubspecEditor {
  /// TODO: Document.
  PubspecEditor(this._pubspecPath)
      : _yamlEditor = YamlEditor(File(_pubspecPath).readAsStringSync());

  final String _pubspecPath;
  final YamlEditor _yamlEditor;
  bool _isDirty = false;
  bool _isClosed = false;

  void _ensureOpen() {
    if (_isClosed) {
      throw StateError("PubspecEditor is closed.");
    }
  }

  /// TODO: Document.
  void save() {
    _ensureOpen();
    if (!_isDirty) {
      return;
    }
    File(_pubspecPath).writeAsStringSync(_yamlEditor.toString());
  }

  /// TODO: Document.
  void close() {
    _isClosed = true;
  }

  static final YamlMap _specialMissingMarker =
      YamlMap.wrap(<String, bool>{"_missing": true});

  T _ensureNode<T extends YamlNode>(Iterable<Object?> path, {T? orElse}) {
    _ensureOpen();
    final YamlNode node = _yamlEditor.parseAt(
      path,
      orElse: () => _specialMissingMarker,
    );
    if (node == _specialMissingMarker) {
      if (orElse != null) {
        return orElse;
      }
      throw StateError("Expected node at path $path to exist.");
    }
    if (node is! T) {
      if (orElse != null) {
        return orElse;
      }
      throw StateError(
        "Expected node at path $path to be of type $T, but was ${node.runtimeType}.",
      );
    }
    return node;
  }

  void _insertIntoMap(Iterable<String> path, String key, Object? node) {
    _ensureOpen();
    final List<String> pathList = path.toList();
    final YamlNode parent = _yamlEditor.parseAt(
      pathList,
      orElse: () => _specialMissingMarker,
    );
    if (parent is YamlMap && parent != _specialMissingMarker) {
      _yamlEditor.update(<Object?>[...pathList, key], node);
      _isDirty = true;
      return;
    }
    final YamlMap newNode = YamlMap.wrap(
      <String, Object?>{key: node},
      style: CollectionStyle.BLOCK,
    );
    if (pathList.isEmpty) {
      _yamlEditor.update(pathList, newNode);
      _isDirty = true;
      return;
    }
    final List<String> parentPath = pathList.sublist(0, pathList.length - 1);
    return _insertIntoMap(parentPath, pathList.last, newNode);
  }

  /// TODO: Document.
  Iterable<PythonDependency> get dependencies sync* {
    _ensureOpen();
    final YamlMap node =
        _ensureNode(<Object?>["python_ffi", "modules"], orElse: YamlMap());
    final Iterable<(String, Object?)> entries = node.entries
        .whereType<MapEntry<YamlScalar, Object?>>()
        .map(
          (MapEntry<YamlScalar, Object?> e) =>
              MapEntry<Object?, Object?>(e.key.value, e.value),
        )
        .whereType<MapEntry<String, Object?>>()
        .map((MapEntry<String, Object?> e) => (e.key, e.value));
    for (final (String key, Object? value) in entries) {
      switch (value) {
        case String():
          yield PyPiDependency(name: key, version: value);
        case YamlMap() when value.containsKey("git"):
          final Object? git = value["git"];
          throw UnimplementedError("Git dependencies are not yet supported.");
        case YamlMap() when value.containsKey("path"):
          final Object? path = value["path"];
          final PythonDependency? pythonDpendency = switch (path) {
            YamlScalar(value: final String pathValue) =>
              PathDependency(name: key, path: pathValue),
            _ => null,
          };
          if (pythonDpendency != null) {
            yield pythonDpendency;
          }
      }
    }
  }

  /// TODO: Document.
  void addDependency(String dependency, {String? version}) {
    _ensureOpen();
    if (dependencies.contains(dependency)) {
      return;
    }
    final List<String> parentPath = <String>["python_ffi", "modules"];
    _insertIntoMap(parentPath, dependency, version ?? "any");
  }

  /// TODO: Document.
  void removeDependency(String dependency) {
    _ensureOpen();
    if (!dependencies.contains(dependency)) {
      return;
    }
    _yamlEditor.remove(<Object?>["python_ffi", "modules", dependency]);
    _isDirty = true;
  }

  /// Ensures that the `flutter.assets` node exists.
  /// Returns `true` if the node already existed, `false` if it was created.
  bool _ensureAssetsNode(String initialValue) {
    _ensureOpen();
    final YamlNode node = _yamlEditor.parseAt(
      <Object?>["flutter", "assets"],
      orElse: () => _specialMissingMarker,
    );
    if (node == _specialMissingMarker) {
      _insertIntoMap(
        <String>["flutter"],
        "assets",
        YamlList.wrap(<String>[initialValue], style: CollectionStyle.BLOCK),
      );
      _isDirty = true;
      return false;
    }
    return true;
  }

  /// TODO: Document.
  Iterable<String> get assets {
    _ensureOpen();
    final YamlList node = _ensureNode(
      <Object?>["flutter", "assets"],
      orElse: YamlList(),
    );
    return node.nodes
        .whereType<YamlScalar>()
        .map((YamlScalar e) => e.value)
        .whereType<String>();
  }

  /// TODO: Document.
  void addAsset(String asset) {
    _ensureOpen();
    if (assets.contains(asset)) {
      return;
    }
    if (_ensureAssetsNode(asset)) {
      _yamlEditor.appendToList(<Object?>["flutter", "assets"], asset);
      _isDirty = true;
    }
  }

  /// TODO: Document.
  void removeAsset(String asset) {
    _ensureOpen();
    if (!assets.contains(asset)) {
      return;
    }
    throw UnimplementedError("removeAsset");
  }
}
