part of interface_gen;

/// Representation of a Python module.
final class Module extends PythonModule
    with InspectMixin
    implements InspectEntry {
  /// Wraps a Python object in a [Module].
  Module.from(
    super.moduleDelegate, {
    required this.name,
    required this.sanitizedName,
  })  : value = moduleDelegate,
        super.from();

  /// The name of this module.
  final String name;

  @override
  final String sanitizedName;

  @override
  Set<String> get _sanitizationExtraKeywords => const <String>{
        "import",
        "getClass",
        ...Object_.sanitizationExtraKeywords,
      };

  @override
  final PythonModuleInterface<PythonFfiDelegate<Object?>, Object?> value;

  @override
  InspectEntryType get type => InspectEntryType.module;

  @override
  InstantiatedInspectEntry _instantiateFrom({
    required String name,
    required String sanitizedName,
    required InstantiatedModule instantiatingModule,
  }) =>
      InstantiatedModule.from(
        this,
        name: name,
        sanitizedName: sanitizedName,
        instantiatingModule: instantiatingModule,
      );
}

/// Instantiated version of [Module].
/// This pins the module to a specific module.
final class InstantiatedModule extends PythonModule
    with
        InstantiatedInspectMixin,
        FunctionFieldMixin,
        GetterSetterMixin,
        GettersSettersMixin
    implements InstantiatedInspectEntry {
  /// Creates a new instance of [InstantiatedModule].
  InstantiatedModule.from(
    this.source, {
    required this.name,
    required this.instantiatingModule,
    String? sanitizedName,
  })  : sanitizedName = sanitizedName ?? sanitizeName(name),
        super.from(source.value);

  /// Creates a new instance of [InstantiatedModule] from a [Module].
  InstantiatedModule.fromModule(this.source)
      : name = source.name,
        sanitizedName = source.sanitizedName,
        super.from(source.value) {
    instantiatingModule = this;
  }

  @override
  final Module source;

  @override
  final String name;

  @override
  final String sanitizedName;

  @override
  late final InstantiatedModule instantiatingModule;

  /// Returns the Python object's `__name__` attribute or [name] if an error
  /// occurs.
  String get qualifiedName {
    try {
      // ignore: avoid_dynamic_calls
      return (source.value as dynamic).__name__ as String;
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      return name;
    }
  }

  bool _isMyChild(InstantiatedInspectEntry child) {
    switch (child) {
      case InstantiatedInspectMixin():
        return source == child.instantiatingModule;
      case Primitive():
        return true;
    }
  }

  @override
  void emit(
    StringBuffer buffer, {
    required InspectionCache cache,
    required AppType appType,
    String moduleParentPrefix = "",
  }) {
    buffer.writeln("/// ## $name");
    emitDoc(buffer);
    emitSource(buffer);
    final String qualifiedName = this.qualifiedName;
    final String fullyQualifiedImportName =
        qualifiedName.startsWith(moduleParentPrefix)
            ? qualifiedName
            : "$moduleParentPrefix$qualifiedName";
    final String pythonFfiInstanceName = switch (appType) {
      AppType.console => "PythonFfiDart.instance",
      AppType.flutter => "PythonFfi.instance",
    };
    buffer.writeln("""
final class $sanitizedName extends PythonModule {
  $sanitizedName.from(super.pythonModule) : super.from();
  
  static $sanitizedName import() => $pythonFfiInstanceName
      .importModule("$fullyQualifiedImportName", $sanitizedName.from,);
""");
    final Set<String> memberNames = <String>{name};
    _emitFunctionFields(
      buffer,
      memberNames: memberNames,
      cache: cache,
      appType: appType,
      filter: _isMyChild,
    );
    for (final InstantiatedModule child
        in _children.whereType<InstantiatedModule>().where(_isMyChild)) {
      final String moduleName = child.sanitizedName;
      final String fieldName = "\$${child.sanitizedName}";
      if (memberNames.contains(fieldName)) {
        continue;
      }
      memberNames.add(fieldName);
      buffer.writeln("/// ## $moduleName");
      child.emitDoc(buffer);
      buffer.writeln("$moduleName get $fieldName => $moduleName.import();");
    }
    _emitGettersSetters(
      buffer,
      memberNames: memberNames,
      cache: cache,
      filter: _isMyChild,
    );
    buffer.writeln("}");
  }
}
