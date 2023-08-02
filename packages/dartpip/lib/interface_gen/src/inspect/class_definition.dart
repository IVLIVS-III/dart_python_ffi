part of interface_gen;

final class ClassDefinition extends PythonClassDefinition
    with
        InspectMixin,
        FunctionFieldMixin,
        GetterSetterMixin,
        GettersSettersMixin
    implements InspectEntry {
  ClassDefinition.from(
    this.name,
    this.sanitizedName,
    super.classDefinitionDelegate,
  )   : value = classDefinitionDelegate,
        super.from();

  final String name;

  final String sanitizedName;

  @override
  Set<String> get _sanitizationExtraKeywords => const <String>{
        "newInstance",
        "call",
        "rawCall",
        ...Object_.sanitizationExtraKeywords,
      };

  final PythonClassDefinitionInterface value;

  @override
  InspectEntryType get type => InspectEntryType.classDefinition;

  @override
  void _setChild(String name, InspectEntry child) {
    if (child is Function_) {
      child = Method.from(child.name, child.sanitizedName, child.value);
    }
    super._setChild(name, child);
  }

  Method? get __init__ {
    final InspectEntry? init = _children["__init__"];
    return init is Method ? init : null;
  }

  Set<String> get __dataclass_fields__ {
    const String attributeName = "__dataclass_fields__";
    if (!value.hasAttribute(attributeName)) {
      return const <String>{};
    }
    return value
        .getAttribute<Map<Object?, Object?>>(attributeName)
        .keys
        .whereType<String>()
        .toSet();
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
      final InspectEntry child = AnyTypePrimitive(
        field,
        sanitizeName(field, extraKeywords: _sanitizationExtraKeywords),
      );
      _setChild(field, child);
    }
  }

  void _extractFieldsFromDataclassFields() {
    final Set<String> dataclassFields = __dataclass_fields__;
    for (final String field in dataclassFields) {
      final InspectEntry child = AnyTypePrimitive(
        field,
        sanitizeName(field, extraKeywords: _sanitizationExtraKeywords),
      );
      _setChild(field, child);
    }
  }

  @override
  void collectChildren(InspectionCache cache, {required String stdlibPath}) {
    super.collectChildren(cache, stdlibPath: stdlibPath);
    _extractFieldsFromInit();
    _extractFieldsFromDataclassFields();
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
    final List<_ReturnTransform> argumentsTransforms =
        initMethod?.emitArguments(buffer).toList() ?? <_ReturnTransform>[];
    buffer.writeln("""
    ) =>
      PythonFfiDart.instance.importClass(
        "$moduleName",
        "$name",
        $sanitizedName.from,""");
    if (initMethod != null) {
      initMethod._emitCallArgs(buffer, transforms: argumentsTransforms);
    } else {
      buffer.writeln("<Object?>[],");
    }
    initMethod?._emitCallKwargs(buffer, transforms: argumentsTransforms);
    buffer.writeln("""
      );

  $sanitizedName.from(super.pythonClass) : super.from();
""");
    final Set<String> memberNames = <String>{name, "__init__"};
    _emitFunctionFields(buffer, memberNames: memberNames);
    _emitGettersSetters(buffer, memberNames: memberNames);
    buffer.writeln("}");
  }
}
