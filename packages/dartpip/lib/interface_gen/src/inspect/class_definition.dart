// ignore_for_file: non_constant_identifier_names

part of interface_gen;

/// TODO: Document.
final class ClassDefinition extends PythonClassDefinition
    with InspectMixin
    implements InspectEntry {
  /// TODO: Document.
  ClassDefinition.from(super.classDefinitionDelegate)
      : value = classDefinitionDelegate,
        super.from();

  /// TODO: Document.
  static const Set<String> sanitizationExtraKeywords = <String>{
    "newInstance",
    "call",
    "rawCall",
    ...Object_.sanitizationExtraKeywords,
  };

  @override
  Set<String> get _sanitizationExtraKeywords => sanitizationExtraKeywords;

  @override
  final PythonClassDefinitionInterface<PythonFfiDelegate<Object?>, Object?>
      value;

  @override
  InspectEntryType get type => InspectEntryType.classDefinition;

  @override
  void _setChild(String name, InspectEntry child) {
    if (child is Function_) {
      final Function_ function = child;
      child = Method.from(child.value);
      for (final InspectEntryModuleConnection connection
          in function.moduleConnections) {
        child.addModuleConnection(connection);
      }
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

    try {
      final FunctionDef init = ast
          .import()
          .parse(dedentedSourceCode)
          .functionDefs
          .singleWhere((FunctionDef element) => element.name == "__init__");

      // TODO: make more robust
      final Iterable<AssignBase> assigns = init.allAssigns;

      final Set<String> assignments = <String>{};
      for (final AssignBase assign in assigns) {
        for (final Attribute attribute in assign.attributes.where(
          (Attribute element) =>
              // ignore: avoid_dynamic_calls
              (element.value as dynamic).__class__.__name__ == "Name",
        )) {
          // ignore: avoid_dynamic_calls
          if ((attribute.value as dynamic).id == selfParameterName) {
            // ignore: avoid_dynamic_calls
            assignments.add((attribute as dynamic).attr as String);
          }
        }
      }
      return assignments;
      // ignore: always_specify_types
    } on PythonExceptionInterface catch (e) {
      // Skip [SyntaxError]s during interface generation for fields from init.
      // Worst case, we miss some fields. But at least we don't crash.
      DartpipCommandRunner.logger.trace(e.toString());
      return const <String>{};
    }
  }

  Set<String> _getNamesFromInit({
    required Method initMethod,
  }) {
    // ignore: avoid_dynamic_calls
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

  void _extractFieldsFromInit(Module parentModule) {
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

  void _extractFieldsFromDataclassFields(Module parentModule) {
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
  void collectChildren(
    InspectionCache cache, {
    required String stdlibPath,
    required Module parentModule,
  }) {
    super.collectChildren(
      cache,
      stdlibPath: stdlibPath,
      parentModule: parentModule,
    );
    _extractFieldsFromInit(parentModule);
    _extractFieldsFromDataclassFields(parentModule);
  }

  @override
  InstantiatedInspectEntry _instantiateFrom({
    required String name,
    required String sanitizedName,
    required InstantiatedModule instantiatingModule,
  }) =>
      InstantiatedClassDefinition.from(
        this,
        name: name,
        sanitizedName: sanitizedName,
        instantiatingModule: instantiatingModule,
      );
}

/// TODO: Document.
final class InstantiatedClassDefinition extends PythonClassDefinition
    with
        InstantiatedInspectMixin,
        FunctionFieldMixin,
        GetterSetterMixin,
        GettersSettersMixin
    implements InstantiatedInspectEntry {
  /// TODO: Document.
  InstantiatedClassDefinition.from(
    this.source, {
    required this.name,
    required this.sanitizedName,
    required this.instantiatingModule,
  }) : super.from(source.value);

  @override
  final ClassDefinition source;

  @override
  final String name;

  @override
  final String sanitizedName;

  @override
  final InstantiatedModule instantiatingModule;

  @override
  Set<String> get _sanitizationExtraKeywords =>
      ClassDefinition.sanitizationExtraKeywords;

  InstantiatedMethod? get __init__ {
    final Method? sourceInit = source.__init__;
    if (sourceInit == null) {
      return null;
    }
    final InspectEntryModuleConnection connection =
        InspectEntryModuleConnection(
      name: "__init__",
      sanitizedName: "__init__",
      parentModule: instantiatingModule.source,
    );
    sourceInit.addModuleConnection(connection);
    final InstantiatedInspectEntry? candidate =
        source.__init__?.instantiate(instantiatingModule);
    return candidate is InstantiatedMethod ? candidate : null;
  }

  @override
  void emit(
    StringBuffer buffer, {
    required InspectionCache cache,
    required AppType appType,
    String moduleParentPrefix = "",
  }) {
    final String moduleName = instantiatingModule.name;
    final InstantiatedMethod? initMethod = __init__;
    buffer.writeln("/// ## $name");
    emitDoc(buffer);
    emitSource(buffer);
    final String pythonFfiInstanceName = switch (appType) {
      AppType.console => "PythonFfiDart.instance",
      AppType.flutter => "PythonFfi.instance",
    };
    buffer.writeln("""
final class $sanitizedName extends PythonClass {
  factory $sanitizedName(""");
    final List<Transform> argumentsTransforms =
        initMethod?.emitArguments(buffer, cache: cache).toList() ??
            <Transform>[];
    buffer.writeln("""
    ) =>
      $pythonFfiInstanceName.importClass(
        "$moduleParentPrefix$moduleName",
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
    _emitFunctionFields(
      buffer,
      memberNames: memberNames,
      cache: cache,
      appType: appType,
      parentEntry: this,
    );
    _emitGettersSetters(
      buffer,
      memberNames: memberNames,
      cache: cache,
      parentEntry: this,
    );
    buffer.writeln("}");
  }
}
