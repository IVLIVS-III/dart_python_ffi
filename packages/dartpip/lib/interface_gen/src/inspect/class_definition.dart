part of interface_gen;

final class ClassDefinition extends PythonClassDefinition
    with InspectMixin
    implements InspectEntry {
  ClassDefinition.from(this.name, super.classDefinitionDelegate)
      : value = classDefinitionDelegate,
        super.from();

  final String name;

  final PythonClassDefinitionInterface value;

  @override
  InspectEntryType get type => InspectEntryType.classDefinition;

  @override
  void _setChild(String name, InspectEntry child) {
    if (child is Function_) {
      child = Method.from(child.name, child.value);
    }
    super._setChild(name, child);
  }

  Method? get __init__ {
    final InspectEntry? init = _children["__init__"];
    return init is Method ? init : null;
  }

  Set<String> _getAssignmentsFromInit({
    required String sourceCode,
    required String selfParameterName,
  }) {
    // dedent source code
    final List<String> lines = sourceCode.split("\n");
    final int indent = lines
        .firstWhere((String line) => line.trim().isNotEmpty)
        .indexOf(RegExp(r"\S"));
    final String dedentedSourceCode = lines
        .where((String line) => line.length >= indent)
        .map((String line) => line.substring(indent).trimRight())
        .join("\n");

    // TODO: make more robust
    final Iterable<Assign> assigns = ast
        .import()
        .parse(dedentedSourceCode)
        .functionDefs
        .singleWhere((FunctionDef element) => element.name == "__init__")
        .assigns;

    final Set<String> assignments = <String>{};
    for (final Assign assign in assigns) {
      for (final Attribute attribute in assign.attributes.where(
        (Attribute element) =>
            (element.value as dynamic).__class__.__name__ == "Name",
      )) {
        if ((attribute.value as dynamic).id == selfParameterName) {
          assignments.add((attribute as dynamic).attr as String);
        }
      }
    }
    return assignments;
  }

  Set<String> _getNamesFromInit({
    required Method initMethod,
  }) {
    final Object? codeObject = (initMethod.value as dynamic).__code__;
    if (codeObject == null) {
      return const <String>{};
    }
    if (codeObject is! PythonObjectInterface) {
      return const <String>{};
    }
    final List<String> names =
        codeObject.getAttribute<List<dynamic>>("co_names").cast();
    return names.toSet();
  }

  void _extractFieldsFromInit() {
    final Method? initMethod = __init__;
    if (initMethod == null) {
      return;
    }

    final String? sourceCode = inspectModule.getsource(initMethod.value);
    if (sourceCode == null) {
      return;
    }

    // get name of first positional argument
    final Parameter? selfParameter = initMethod.selfParameter;
    if (selfParameter == null) {
      return;
    }
    final String selfParameterName = selfParameter.name;

    final Set<String> names = _getNamesFromInit(initMethod: initMethod);
    final Set<String> assignments = _getAssignmentsFromInit(
      sourceCode: sourceCode,
      selfParameterName: selfParameterName,
    );

    for (final String field in names
        .intersection(assignments)
        .whereNot((String element) => element.startsWith("_"))) {
      final InspectEntry child = Primitive(field, null);
      _setChild(field, child);
    }
  }

  @override
  void collectChildren() {
    super.collectChildren();
    _extractFieldsFromInit();
  }

  @override
  void emit(StringBuffer buffer) {
    final Object? parentModule = this.parentModule;
    final String moduleName = switch (parentModule) {
      PythonModuleInterface() => (parentModule as dynamic).__name__ as String,
      _ => throw Exception("parentModule is not a module: $parentModule"),
    };
    final Method? initMethod = __init__;
    buffer.writeln("/// ## $name");
    emitDoc(buffer);
    emitSource(buffer);
    buffer.writeln("""
final class $sanitizedName extends PythonClass {
  factory $sanitizedName(""");
    initMethod?.emitArguments(buffer);
    buffer.writeln("""
    ) =>
      PythonFfiDart.instance.importClass(
        "$moduleName",
        "$name",
        $sanitizedName.from,""");
    if (initMethod != null) {
      initMethod.emitCallArgs(buffer);
    } else {
      buffer.writeln("<Object?>[],");
    }
    initMethod?.emitCallKwargs(buffer);
    buffer.writeln("""
      );

  $sanitizedName.from(super.pythonClass) : super.from();
""");
    final Set<String> memberNames = <String>{"__init__"};
    for (final Function_ child in _children.values.whereType<Function_>()) {
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
    for (final Object_ child in _children.values.whereType<Object_>()) {
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
    for (final Primitive child in _children.values.whereType<Primitive>()) {
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
