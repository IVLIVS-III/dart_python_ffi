part of interface_gen;

/// TODO: Document.
final class Module extends PythonModule
    with InspectMixin
    implements InspectEntry {
  /// TODO: Document.
  Module.from(
    super.moduleDelegate, {
    required this.name,
    required this.sanitizedName,
  })  : value = moduleDelegate,
        super.from();

  /// TODO: Document.
  final String name;

  /// TODO: Document.
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

/// TODO: Document.
final class InstantiatedModule extends PythonModule
    with
        InstantiatedInspectMixin,
        FunctionFieldMixin,
        GetterSetterMixin,
        GettersSettersMixin
    implements InstantiatedInspectEntry {
  /// TODO: Document.
  InstantiatedModule.from(
    this.source, {
    required this.name,
    required this.instantiatingModule,
    String? sanitizedName,
  })  : sanitizedName = sanitizedName ?? sanitizeName(name),
        super.from(source.value);

  /// TODO: Document.
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

  /// TODO: Document.
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
    String moduleParentPrefix = "",
  }) {
    buffer.writeln("/// ## $name");
    emitDoc(buffer);
    emitSource(buffer);
    buffer.writeln("""
final class $sanitizedName extends PythonModule {
  $sanitizedName.from(super.pythonModule) : super.from();
  
  static $sanitizedName import() => PythonFfiDart.instance
      .importModule("$moduleParentPrefix$qualifiedName", $sanitizedName.from,);
""");
    final Set<String> memberNames = <String>{name};
    _emitFunctionFields(
      buffer,
      memberNames: memberNames,
      cache: cache,
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
