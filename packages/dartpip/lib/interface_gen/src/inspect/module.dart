part of interface_gen;

/// TODO: Document.
final class Module extends PythonModule
    with
        InspectMixin,
        FunctionFieldMixin,
        GetterSetterMixin,
        GettersSettersMixin
    implements InspectEntry {
  /// TODO: Document.
  Module.from(this.name, this.sanitizedName, super.moduleDelegate)
      : value = moduleDelegate,
        super.from();

  @override
  final String name;

  @override
  final String sanitizedName;

  @override
  Set<String> get _sanitizationExtraKeywords => const <String>{
        "import",
        "getClass",
        ...Object_.sanitizationExtraKeywords,
      };

  /// TODO: Document.
  String get qualifiedName {
    try {
      // ignore: avoid_dynamic_calls
      return (value as dynamic).__name__ as String;
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      return name;
    }
  }

  @override
  final PythonModuleInterface<PythonFfiDelegate<Object?>, Object?> value;

  @override
  InspectEntryType get type => InspectEntryType.module;

  bool _isMyChild(InspectEntry child) {
    switch (child) {
      case InspectMixin():
        final Object? parentModule = child.parentModule;
        if (parentModule is PythonModuleInterface) {
          return ReferenceEqualityWrapper(parentModule) ==
              ReferenceEqualityWrapper(value);
        }
        return false;
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
    for (final Module child
        in _children.values.whereType<Module>().where(_isMyChild)) {
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
