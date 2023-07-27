part of interface_gen;

final class Module extends PythonModule
    with InspectMixin
    implements InspectEntry {
  Module.from(this.name, super.moduleDelegate)
      : value = moduleDelegate,
        super.from();

  final String name;

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
    }
    return false;
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
    final Set<String> memberNames = <String>{};
    for (final Function_ child
        in _children.values.whereType<Function_>().where(_isMyChild)) {
      final String functionName = child.sanitizedName;
      if (memberNames.contains(functionName)) {
        continue;
      }
      if (functionName == name) {
        continue;
      }
      memberNames.add(functionName);
      child.emit(buffer);
    }
    for (final Module child
        in _children.values.whereType<Module>().where(_isMyChild)) {
      final String moduleName = child.sanitizedName;
      if (memberNames.contains(moduleName)) {
        continue;
      }
      memberNames.add(moduleName);
      buffer.writeln(
        "PythonModule get $moduleName => $moduleName.import();",
      );
    }
    for (final ClassInstance child
        in _children.values.whereType<ClassInstance>()) {
      if (types.isType(child)) {
        continue;
      }
      final String className = child.sanitizedName;
      if (memberNames.contains(className)) {
        continue;
      }
      memberNames.add(className);
      buffer.writeln("""
Object? get $className => getAttribute("${child.name}");

set $className(Object? $className)
  => setAttribute("${child.name}", $className);
""");
    }
    for (final Object_ child
        in _children.values.whereType<Object_>().where(_isMyChild)) {
      final String objectName = child.sanitizedName;
      if (memberNames.contains(objectName)) {
        continue;
      }
      memberNames.add(objectName);
      buffer.writeln("""
Object? get $objectName => getAttribute("${child.name}");

set $objectName(Object? $objectName)
  => setAttribute("${child.name}", $objectName);
""");
    }
    for (final Primitive child
        in _children.values.whereType<Primitive>().where(_isMyChild)) {
      final String primitiveName = child.sanitizedName;
      if (memberNames.contains(primitiveName)) {
        continue;
      }
      memberNames.add(primitiveName);
      buffer.writeln("""
Object? get $primitiveName => getAttribute("${child.name}");

set $primitiveName(Object? $primitiveName)
  => setAttribute("${child.name}", $primitiveName);
""");
    }
    buffer.writeln("}");
  }
}
