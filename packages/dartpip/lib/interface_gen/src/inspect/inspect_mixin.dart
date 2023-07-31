part of interface_gen;

base mixin InspectMixin on PythonObjectInterface implements InspectEntry {
  final Map<String, InspectEntry> _children = <String, InspectEntry>{};

  void _setChild(String name, InspectEntry child) {
    _children[name] = child;
  }

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

  /*
  String sanitizedName({Set<String> extraKeywords = const <String>{}}) =>
      sanitizeName(name, extraKeywords: extraKeywords);
  */

  Object? get parentModule => inspectModule.getmodule(value);

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
      } on PythonExceptionInterface catch (_) {
        // ignore
      }
      try {
        if (inspectModule.ismethodwrapper(value)) {
          continue;
        }
      } on PythonExceptionInterface catch (_) {
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
        PythonModuleInterface() when inspectModule.ismodule(value) =>
          Module.from(name, sanitizedName, value),
        PythonModuleInterface() =>
          throw Exception("'$name' is not a module: $value"),
        PythonClassDefinitionInterface() when inspectModule.isclass(value) =>
          ClassDefinition.from(name, sanitizedName, value),
        PythonClassInterface() =>
          ClassInstance.from(name, sanitizedName, value),
        PythonFunctionInterface() when inspectModule.isfunction(value) =>
          Function_.from(name, sanitizedName, value),
        PythonFunctionInterface() =>
          throw Exception("'$name' is not a function: $value"),
        PythonObjectInterface() => Object_.from(name, sanitizedName, value),
        _ => Primitive(name, sanitizedName, value),
      } as InspectEntry;
      if (child is Module && _isStdlibModule(child, stdlibPath: stdlibPath)) {
        continue;
      }
      cache[value] = child;
      _setChild(name, child);
      child.collectChildren(cache, stdlibPath: stdlibPath);
    }
  }

  bool _isStdlibModule(Module module, {required String stdlibPath}) {
    if (inspectModule.isbuiltin(module.value)) {
      return true;
    }
    try {
      final String? filename = inspectModule.getfile(module.value);
      if (filename == null) {
        return false;
      }
      return filename.startsWith(stdlibPath);
    } on PythonExceptionInterface catch (_) {
      // ignore
    }
    return false;
  }

  @override
  void emit(StringBuffer buffer) {
    throw UnimplementedError("$runtimeType.emit");
  }

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
    } on PythonExceptionInterface catch (_) {
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
