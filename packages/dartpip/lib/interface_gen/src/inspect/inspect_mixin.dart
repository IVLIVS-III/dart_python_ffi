part of interface_gen;

/// TODO: Document.
base mixin InspectMixin
    on PythonObjectInterface<PythonFfiDelegate<Object?>, Object?>
    implements InspectEntry {
  final Map<String, InspectEntry> _children = <String, InspectEntry>{};

  void _setChild(String name, InspectEntry child) {
    _children[name] = child;
  }

  /// TODO: Document.
  final inspect inspectModule = inspect.import();

  Iterable<(String, Object?)> get _members {
    final InspectMixin object = this;
    final Iterable<(String, Object?)> dynamicMembers =
        inspectModule.getmembers(object);
    final Iterable<(String, Object?)> staticMembers =
        inspectModule.getmembers_static(object);
    return dynamicMembers.sortedMerge(
      staticMembers,
      ((String, Object?) a, (String, Object?) b) => a.$1.compareTo(b.$1),
    );
  }

  Set<String> get _sanitizationExtraKeywords => const <String>{};

  /// TODO: Document.
  Object? get parentModule => inspectModule.getmodule(value);

  @override
  Iterable<(String, InspectEntry)> get children => _children.entries
      .map((MapEntry<String, InspectEntry> e) => (e.key, e.value));

  static const Set<String> _explicitlyAllowedChildNames = <String>{"__init__"};

  @override
  void collectChildren(InspectionCache cache, {required String stdlibPath}) {
    final inspect inspectModule = inspect.import();
    final InspectEntry? selfCached = cache[value];
    if (selfCached == null) {
      cache[value] = this;
    }
    for (final (String name, Object? value) in _members) {
      if (name.startsWith("_") &&
          !_explicitlyAllowedChildNames.contains(name)) {
        continue;
      }
      try {
        if (inspectModule.isbuiltin(value)) {
          continue;
        }
      } on PythonExceptionInterface<PythonFfiDelegate<Object?>,
          Object?> catch (_) {
        // ignore
      }
      try {
        if (inspectModule.ismethodwrapper(value)) {
          continue;
        }
      } on PythonExceptionInterface<PythonFfiDelegate<Object?>,
          Object?> catch (_) {
        // ignore
      }
      final InspectEntry? cached = cache[value];
      if (cached != null) {
        _setChild(name, cached);
        continue;
      }
      final String sanitizedName =
          sanitizeName(name, extraKeywords: _sanitizationExtraKeywords);
      final InspectEntry child = switch (value) {
        PythonModuleInterface<PythonFfiDelegate<Object?>, Object?>()
            when inspectModule.ismodule(value) =>
          Module.from(name, sanitizedName, value),
        PythonModuleInterface<PythonFfiDelegate<Object?>, Object?>() =>
          throw Exception("'$name' is not a module: $value"),
        PythonClassDefinitionInterface<PythonFfiDelegate<Object?>, Object?>()
            when inspectModule.isclass(value) =>
          ClassDefinition.from(name, sanitizedName, value),
        PythonClassInterface<PythonFfiDelegate<Object?>, Object?>() =>
          ClassInstance.from(name, sanitizedName, value),
        PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?>()
            when inspectModule.isfunction(value) =>
          Function_.from(name, sanitizedName, value),
        PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?>() =>
          throw Exception("'$name' is not a function: $value"),
        PythonObjectInterface<PythonFfiDelegate<Object?>, Object?>() =>
          Object_.from(name, sanitizedName, value),
        _ => Primitive(name, sanitizedName, value),
      };
      if (!_isTypedef(child) && _isStdlibEntry(child, stdlibPath: stdlibPath)) {
        continue;
      }
      cache[value] = child;
      _setChild(name, child);
      child.collectChildren(cache, stdlibPath: stdlibPath);
    }
  }

  bool _isTypedef(InspectEntry entry) {
    if (entry is ClassInstance) {
      // TODO: check if it's a typedef
      return true;
    }
    return false;
  }

  bool _isStdlibEntry(InspectEntry entry, {required String stdlibPath}) {
    try {
      if (inspectModule.isbuiltin(entry.value)) {
        return true;
      }
      final String? filename = inspectModule.getfile(entry.value);
      if (filename == null) {
        return false;
      }
      return filename.startsWith(stdlibPath);
    } on PythonExceptionInterface<PythonFfiDelegate<Object?>,
        Object?> catch (_) {
      // ignore
    }
    return false;
  }

  @override
  void emit(StringBuffer buffer, {required InspectionCache cache}) {
    throw UnimplementedError("$runtimeType.emit");
  }

  @override
  void emitDoc(StringBuffer buffer) {
    final String? doc = inspectModule.getdoc(value)?.trim();
    if (doc == null) {
      return;
    }
    if (doc.isEmpty) {
      return;
    }
    buffer.writeln("""
///
/// ### python docstring
///""");
    for (final String line in doc.split("\n")) {
      buffer.writeln("/// $line");
    }
  }

  @override
  void emitSource(StringBuffer buffer) {
    try {
      final String? source = inspectModule.getsource(value)?.trim();
      if (source == null) {
        return;
      }
      buffer.writeln("""
///
/// ### python source
/// ```py""");
      for (final String line in source.split("\n")) {
        buffer.writeln("/// $line");
      }
      buffer.writeln("""
/// ```""");
    } on PythonExceptionInterface<PythonFfiDelegate<Object?>,
        Object?> catch (_) {
      // ignore
    }
  }

  @override
  Map<String, Object?> debugDump({
    InspectionCache? cache,
    bool expandChildren = true,
  }) {
    final int? id = cache?.id(value);
    return <String, Object?>{
      if (id != null) "_id": id,
      "name": name,
      "sanitizedName": sanitizedName,
      "value": value,
      "type": type.displayName,
      "parentModule": parentModule,
      "doc": inspectModule.getdoc(value),
      if (expandChildren)
        "children": Map<String, Map<String, Object?>>.fromEntries(
          children.map(
            ((String, InspectEntry) e) =>
                MapEntry<String, Map<String, Object?>>(
              e.$1,
              e.$2.debugDump(cache: cache, expandChildren: id == null),
            ),
          ),
        ),
    };
  }
}
