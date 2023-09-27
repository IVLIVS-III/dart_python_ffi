// ignore_for_file: camel_case_types

part of interface_gen;

/// Representation of a Python function.
final class Function_ extends PythonFunction
    with InspectMixin
    implements InspectEntry {
  /// Wraps a Python object in a [Function_].
  Function_.from(super.functionDelegate)
      : value = functionDelegate,
        super.from();

  @override
  final PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?> value;

  @override
  InspectEntryType get type => InspectEntryType.function;

  /// Returns this function's signature.
  Signature get signature => inspectModule.signature(value);

  /// Returns this function's parameters.
  Iterable<Parameter> get parameters => signature.parameters.values;

  @override
  Map<String, Object?> debugDump({
    InspectionCache? cache,
    bool expandChildren = true,
  }) =>
      <String, Object?>{
        ...super.debugDump(cache: cache, expandChildren: expandChildren),
        "signature": signature.debugDump(cache: cache),
      };

  @override
  InstantiatedInspectEntry _instantiateFrom({
    required String name,
    required String sanitizedName,
    required InstantiatedModule instantiatingModule,
  }) =>
      InstantiatedFunction_.from(
        this,
        name: name,
        sanitizedName: sanitizedName,
        instantiatingModule: instantiatingModule,
      );
}

/// Instantiated version of [Function_].
/// This pins the function to a specific module.
final class InstantiatedFunction_ extends PythonFunction
    with InstantiatedInspectMixin
    implements InstantiatedInspectEntry {
  /// Creates a new instance of [InstantiatedFunction_].
  InstantiatedFunction_.from(
    this.source, {
    required this.name,
    required this.sanitizedName,
    required this.instantiatingModule,
  }) : super.from(source.value);

  @override
  final Function_ source;

  @override
  final String name;

  @override
  final String sanitizedName;
  @override
  final InstantiatedModule instantiatingModule;

  @override
  Set<String> get _sanitizationExtraKeywords => const <String>{
        "call",
        "asFunction",
        ...Object_.sanitizationExtraKeywords,
      };

  Iterable<Parameter> _parametersOfKind(ParameterKind kind) =>
      source.parameters.where((Parameter parameter) => parameter.kind == kind);

  bool _hasKeywordParameters() =>
      _parametersOfKind(ParameterKind.var_positional).isNotEmpty ||
      _parametersOfKind(ParameterKind.positional_or_keyword).isNotEmpty ||
      _parametersOfKind(ParameterKind.keyword_only).isNotEmpty ||
      _parametersOfKind(ParameterKind.var_keyword).isNotEmpty;

  /// Emits the arguments of this function for Dart source generation.
  Iterable<Transform> emitArguments(
    StringBuffer buffer, {
    required InspectionCache cache,
    InstantiatedInspectEntry? parentEntry,
  }) {
    final List<Transform> transforms = <Transform>[];
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.positional_only)) {
      final (String typeString, Transform transform) =
          _getTypeStringWithTransform(
        parameter,
        cache: cache,
        parentEntry: parentEntry,
      );
      buffer.writeln("$typeString ${parameter.sanitizedName},");
      transforms.add(transform);
    }
    if (_hasKeywordParameters()) {
      buffer.write("{");
      for (final Parameter parameter
          in _parametersOfKind(ParameterKind.var_positional)) {
        buffer.writeln(
          "List<Object?> ${parameter.sanitizedName} ${parameter.defaultString},",
        );
      }
      for (final Parameter parameter
          in _parametersOfKind(ParameterKind.positional_or_keyword)) {
        final (String typeString, Transform transform) =
            _getTypeStringWithTransform(
          parameter,
          cache: cache,
          parentEntry: parentEntry,
        );
        buffer.writeln(
          "${parameter.requiredString} $typeString ${parameter.sanitizedName} ${parameter.defaultString},",
        );
        transforms.add(transform);
      }
      for (final Parameter parameter
          in _parametersOfKind(ParameterKind.keyword_only)) {
        final (String typeString, Transform transform) =
            _getTypeStringWithTransform(
          parameter,
          cache: cache,
          parentEntry: parentEntry,
        );
        buffer.writeln(
          "${parameter.requiredString} $typeString ${parameter.sanitizedName} ${parameter.defaultString},",
        );
        transforms.add(transform);
      }
      for (final Parameter parameter
          in _parametersOfKind(ParameterKind.var_keyword)) {
        buffer.writeln(
          "Map<String, Object?> ${parameter.sanitizedName} ${parameter.defaultString},",
        );
      }
      buffer.write("}");
    }
    return transforms;
  }

  void _emitCallArgs(
    StringBuffer buffer, {
    required List<Transform> transforms,
  }) {
    buffer.writeln("<Object?>[");
    int idx = 0;
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.positional_only)) {
      buffer.writeln("${transforms[idx](parameter.sanitizedName)},");
      idx++;
    }
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.positional_or_keyword)) {
      buffer.writeln("${transforms[idx](parameter.sanitizedName)},");
      idx++;
    }
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.var_positional)) {
      buffer.writeln("...${parameter.sanitizedName},");
    }
    buffer.writeln("],");
  }

  void _emitCallKwargs(
    StringBuffer buffer, {
    required List<Transform> transforms,
  }) {
    buffer.writeln("<String, Object?>{");
    int idx = 0;
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.keyword_only)) {
      buffer.writeln(
        "\"${parameter.name}\": ${transforms[idx](parameter.sanitizedName)},",
      );
      idx++;
    }
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.var_keyword)) {
      buffer.writeln("...${parameter.sanitizedName},");
    }
    buffer.writeln("},");
  }

  void _emitCall(
    StringBuffer buffer, {
    required List<Transform> transforms,
  }) {
    _emitCallArgs(buffer, transforms: transforms);
    buffer.write("kwargs: ");
    _emitCallKwargs(buffer, transforms: transforms);
  }

  @override
  void emit(
    StringBuffer buffer, {
    required InspectionCache cache,
    required AppType appType,
    Set<String> extraKeywords = const <String>{},
    InstantiatedInspectEntry? parentEntry,
  }) {
    buffer.writeln("/// ## $name");
    emitDoc(buffer);
    emitSource(buffer);
    final (String returnType, Transform transform) =
        _getTypeStringWithTransform(
      source.signature.return_annotation,
      cache: cache,
      isReturnString: true,
      parentEntry: parentEntry,
    );
    buffer.writeln("$returnType $sanitizedName(");
    final Iterable<Transform> argumentsTransforms =
        emitArguments(buffer, cache: cache, parentEntry: parentEntry);
    buffer.writeln(") => ");
    final StringBuffer callBuffer = StringBuffer()
      ..writeln("getFunction(\"$name\").call(");
    _emitCall(callBuffer, transforms: argumentsTransforms.toList());
    callBuffer.writeln(")");
    buffer.write("${transform(callBuffer.toString())};");
  }
}
