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

  YamlMap _flowMap() =>
      YamlMap.wrap(<String, Object?>{}, style: CollectionStyle.FLOW);

  T _constructViaPath<T extends YamlNode>(
    Iterable<Object?> path,
    T leaf, {
    int depth = 0,
  }) {
    _ensureOpen();
    final String padding = "  " * depth;
    print("${padding}trying to construct via path $path");
    final List<Object?> pathList = path.toList();
    final YamlNode node = _yamlEditor.parseAt(
      pathList,
      orElse: () => _specialMissingMarker,
    );
    if (node is T && node != _specialMissingMarker) {
      print("${padding}found node $node");
      return node;
    }
    _isDirty = true;
    if (path.isEmpty) {
      _yamlEditor.update(pathList, leaf);
      print("${padding}returning leaf $leaf");
      return leaf;
    }
    final Object? last = pathList.last;
    final List<Object?> parentPath = pathList.sublist(0, pathList.length - 1);
    print("${padding}parent path $parentPath");
    if (last is! String && last is! int) {
      throw ArgumentError.value(
        last,
        "path",
        "Must only contain String and int.",
      );
    }
    if (last is! String) {
      throw UnimplementedError("list construction not implemented yet");
    }
    if (node is! T) {
      print("$padding$node is not a $T");
      _insertIntoMap(parentPath, last, leaf, depth: depth);
      return leaf;
    }
    return _ensureNode(pathList);
  }

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

  void _insertIntoMap(
    Iterable<Object?> path,
    String key,
    YamlNode node, {
    int depth = 0,
  }) {
    _ensureOpen();
    _constructViaPath<YamlNode>(path, YamlScalar.wrap(null), depth: depth + 1);
    _yamlEditor.update(<Object?>[...path, key], node);
    _isDirty = true;
  }

  /// TODO: Document.
  Iterable<String> get dependencies {
    _ensureOpen();
    final YamlMap node = _ensureNode(
      <Object?>["python_ffi", "modules"],
      orElse: _flowMap(),
    );
    return node.nodes.keys
        .whereType<YamlScalar>()
        .map((YamlScalar e) => e.value)
        .whereType<String>();
  }

  /// TODO: Document.
  void addDependency(String dependency, {String? version}) {
    _ensureOpen();
    if (dependencies.contains(dependency)) {
      return;
    }
    final List<Object?> parentPath = <Object?>["python_ffi", "modules"];
    _constructViaPath(
      parentPath,
      YamlMap.wrap(
        <String, String>{dependency: version ?? "any"},
        style: CollectionStyle.FLOW,
      ),
    );
    _ensureNode(parentPath, orElse: _flowMap());
    _yamlEditor.update(
      <Object?>[...parentPath, dependency],
      version ?? "any",
    );
    _isDirty = true;
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
    _yamlEditor.appendToList(<Object?>["flutter", "assets"], asset);
    _isDirty = true;
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
