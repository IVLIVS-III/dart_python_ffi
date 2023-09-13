part of interface_gen;

/// TODO: Document.
base mixin InspectMixin
    on PythonObjectInterface<PythonFfiDelegate<Object?>, Object?>
    implements InspectEntry {
  final List<InspectEntryModuleConnection> _moduleConnections =
      <InspectEntryModuleConnection>[];

  @override
  List<InspectEntryModuleConnection> get moduleConnections =>
      List<InspectEntryModuleConnection>.unmodifiable(_moduleConnections);

  @override
  bool hasModuleConnection(InspectEntryModuleConnection connection) =>
      _moduleConnections.contains(connection);

  @override
  bool addModuleConnection(InspectEntryModuleConnection connection) {
    if (hasModuleConnection(connection)) {
      return false;
    }
    _moduleConnections.add(connection);
    return true;
  }

  final Set<InstantiatedInspectEntry> _cachedInstantiations =
      <InstantiatedInspectEntry>{};

  @override
  Iterable<InstantiatedInspectEntry> get cachedInstantiations sync* {
    yield* _cachedInstantiations;
  }

  @override
  String get sanitizedName {
    final String? fromCachedInstantiations = _cachedInstantiations
        .map((InstantiatedInspectEntry e) => e.sanitizedName)
        .firstOrNull;
    if (fromCachedInstantiations != null) {
      return fromCachedInstantiations;
    }
    final String? fromModuleConnections = moduleConnections
        .map((InspectEntryModuleConnection e) => e.sanitizedName)
        .firstOrNull;
    if (fromModuleConnections != null) {
      return fromModuleConnections;
    }
    try {
      final Object? value = this.value;
      if (value is PythonObjectInterface) {
        final String? name = value.getAttributeOrNull("__name__");
        if (name != null) {
          return sanitizeName(name);
        }
      }
    } on PythonExceptionInterface<PythonFfiDelegate<Object?>,
        Object?> catch (_) {
      // ignore
    } on PythonFfiException catch (_) {
      // ignore
    }
    throw UnimplementedError();
  }

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

  /// Returns the module in which this object is defined.
  ///
  /// Example:
  /// ```py
  /// // file: my_module.py
  /// my_object = None
  ///
  /// // file: main.py
  /// from my_module import my_object as my_object_
  /// ```
  ///
  /// In this example, `my_object.definingModule` as well as
  /// `my_object_.definingModule` will return the module object for `my_module`.
  Object? get definingModule => inspectModule.getmodule(value);

  @override
  Iterable<(String, InspectEntry)> get children => _children.entries
      .map((MapEntry<String, InspectEntry> e) => (e.key, e.value));

  static const Set<String> _explicitlyAllowedChildNames = <String>{"__init__"};

  @override
  void collectChildren(
    InspectionCache cache, {
    required String stdlibPath,
    required Module parentModule,
  }) {
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
      final String sanitizedName =
          sanitizeName(name, extraKeywords: _sanitizationExtraKeywords);
      final InspectEntry? cached = cache[value];
      final InspectEntry child = cached ??
          switch (value) {
            PythonModuleInterface<PythonFfiDelegate<Object?>, Object?>()
                when inspectModule.ismodule(value) =>
              Module.from(value, name: name, sanitizedName: sanitizedName),
            PythonModuleInterface<PythonFfiDelegate<Object?>, Object?>() =>
              throw Exception("'$name' is not a module: $value"),
            PythonClassDefinitionInterface<PythonFfiDelegate<Object?>,
                    Object?>()
                when inspectModule.isclass(value) =>
              ClassDefinition.from(value),
            PythonClassInterface<PythonFfiDelegate<Object?>, Object?>() =>
              ClassInstance.from(value),
            PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?>()
                when inspectModule.isfunction(value) =>
              Function_.from(value),
            PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?>() =>
              throw Exception("'$name' is not a function: $value"),
            PythonObjectInterface<PythonFfiDelegate<Object?>, Object?>() =>
              Object_.from(value),
            _ => Primitive(name, sanitizedName, value),
          } as InspectEntry;
      if (!_isTypedef(child) && _isStdlibEntry(child, stdlibPath: stdlibPath)) {
        continue;
      }
      final InspectEntryModuleConnection connection =
          InspectEntryModuleConnection(
        name: name,
        sanitizedName: sanitizedName,
        parentModule: parentModule,
      );
      final bool didAddConnection = child.addModuleConnection(connection);
      _setChild(name, child);
      if (cached == null) {
        cache[value] = child;
      }
      if (didAddConnection) {
        child.collectChildren(
          cache,
          stdlibPath: stdlibPath,
          parentModule: parentModule,
        );
      }
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

  InstantiatedInspectEntry _instantiateFrom({
    required String name,
    required String sanitizedName,
    required InstantiatedModule instantiatingModule,
  });

  @override
  InstantiatedInspectEntry? instantiate(
    InstantiatedModule instantiatingModule,
  ) {
    final InspectEntryModuleConnection? connection =
        moduleConnections.firstWhereOrNull(
      (InspectEntryModuleConnection element) =>
          element.parentModule == instantiatingModule.source,
    );
    if (connection == null) {
      print(
        "⚠️  Warning: found no connection to instantiate for ${instantiatingModule.source.value}",
      );
      return null;
    }
    final InstantiatedInspectEntry instantiation = _instantiateFrom(
      name: connection.name,
      sanitizedName: connection.sanitizedName,
      instantiatingModule: instantiatingModule,
    );
    _cachedInstantiations.add(instantiation);
    return instantiation;
  }

  /// TODO: Document.
  Iterable<InstantiatedInspectEntry> get instantiations sync* {
    for (final InspectEntryModuleConnection connection in moduleConnections) {
      yield _instantiateFrom(
        name: connection.name,
        sanitizedName: connection.sanitizedName,
        instantiatingModule:
            InstantiatedModule.fromModule(connection.parentModule),
      );
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
      if (expandChildren)
        "moduleConnections": moduleConnections
            .map(
              (InspectEntryModuleConnection e) =>
                  e.debugDump(cache: cache, expandChildren: id == null),
            )
            .toList(),
      "value": value,
      "type": type.displayName,
      "parentModule": definingModule,
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

/// TODO: Document.
base mixin InstantiatedInspectMixin
    on PythonObjectInterface<PythonFfiDelegate<Object?>, Object?>
    implements InstantiatedInspectEntry {
  /// TODO: Document.
  final inspect inspectModule = inspect.import();

  Set<String> get _sanitizationExtraKeywords => const <String>{};

  Iterable<InstantiatedInspectEntry> get _children => source.children.map(
        ((String, InspectEntry) e) {
          final InspectEntry child = e.$2;
          final InstantiatedInspectEntry? entry =
              child.instantiate(instantiatingModule);
          return entry;
        },
      ).whereNotNull();

  @override
  void emit(
    StringBuffer buffer, {
    required InspectionCache cache,
    required AppType appType,
  }) {
    throw UnimplementedError("$runtimeType.emit");
  }

  @override
  void emitDoc(StringBuffer buffer) {
    try {
      final String? doc = inspectModule.getdoc(source.value)?.trim();
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
    } on PythonFfiException catch (_) {
      // ignore
    }
  }

  @override
  void emitSource(StringBuffer buffer) {
    try {
      final String? source = inspectModule.getsource(this.source.value)?.trim();
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
}
