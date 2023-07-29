part of interface_gen;

final class Module extends PythonModule
    with InspectMixin, FunctionFieldMixin, GetterSetterMixin
    implements InspectEntry {
  Module.from(this.name, this.sanitizedName, super.moduleDelegate)
      : value = moduleDelegate,
        super.from();

  final String name;

  final String sanitizedName;

  @override
  Set<String> get _sanitizationExtraKeywords => const <String>{
        "import",
        "getClass",
        ...Object_.sanitizationExtraKeywords,
      };

  String get qualifiedName {
    try {
      return (value as dynamic).__name__ as String;
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      return name;
    }
  }

  final PythonModuleInterface value;

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
  void emit(StringBuffer buffer) {
    buffer.writeln("/// ## $name");
    emitDoc(buffer);
    emitSource(buffer);
    buffer.writeln("""
final class $sanitizedName extends PythonModule {
  $sanitizedName.from(super.pythonModule) : super.from();
  
  static $sanitizedName import() => PythonFfiDart.instance
      .importModule("$qualifiedName", $sanitizedName.from,);
""");
    final Set<String> memberNames = <String>{name};
    _emitFunctionFields(buffer, memberNames: memberNames, filter: _isMyChild);
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
    _emitGettersSetters(buffer, memberNames: memberNames, filter: _isMyChild);
    buffer.writeln("}");
  }
}
