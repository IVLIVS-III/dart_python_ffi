part of interface_gen;

final class Function_ extends PythonFunction
    with InspectMixin
    implements InspectEntry {
  Function_.from(this.name, this.sanitizedName, super.functionDelegate)
      : value = functionDelegate,
        super.from();

  final String name;

  final String sanitizedName;

  @override
  Set<String> get _sanitizationExtraKeywords => const <String>{
        "call",
        "asFunction",
        ...Object_.sanitizationExtraKeywords,
      };

  final PythonFunctionInterface value;

  @override
  InspectEntryType get type => InspectEntryType.function;

  Signature get signature => inspectModule.signature(value);

  Iterable<Parameter> get parameters => signature.parameters.values;

  Iterable<Parameter> _parametersOfKind(ParameterKind kind) =>
      parameters.where((Parameter parameter) => parameter.kind == kind);

  bool _hasKeywordParameters() =>
      _parametersOfKind(ParameterKind.var_positional).isNotEmpty ||
      _parametersOfKind(ParameterKind.positional_or_keyword).isNotEmpty ||
      _parametersOfKind(ParameterKind.keyword_only).isNotEmpty ||
      _parametersOfKind(ParameterKind.var_keyword).isNotEmpty;

  Iterable<_ReturnTransform> emitArguments(
    StringBuffer buffer, {
    required InspectionCache cache,
    InspectEntry? parentEntry,
  }) {
    final List<_ReturnTransform> transforms = <_ReturnTransform>[];
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.positional_only)) {
      final (String typeString, _ReturnTransform transform) =
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
        final (String typeString, _ReturnTransform transform) =
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
        final (String typeString, _ReturnTransform transform) =
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
    required List<_ReturnTransform> transforms,
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
    required List<_ReturnTransform> transforms,
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
    required List<_ReturnTransform> transforms,
  }) {
    _emitCallArgs(buffer, transforms: transforms);
    buffer.write("kwargs: ");
    _emitCallKwargs(buffer, transforms: transforms);
  }

  @override
  void emit(
    StringBuffer buffer, {
    required InspectionCache cache,
    Set<String> extraKeywords = const <String>{},
    InspectEntry? parentEntry,
  }) {
    buffer.writeln("/// ## $name");
    emitDoc(buffer);
    emitSource(buffer);
    final (String returnType, _ReturnTransform transform) =
        _getTypeStringWithTransform(
      signature.return_annotation,
      cache: cache,
      isReturnString: true,
      parentEntry: parentEntry,
    );
    buffer.writeln("$returnType $sanitizedName(");
    final Iterable<_ReturnTransform> argumentsTransforms =
        emitArguments(buffer, cache: cache, parentEntry: parentEntry);
    buffer.writeln(") => ");
    final StringBuffer callBuffer = StringBuffer()
      ..writeln("getFunction(\"$name\").call(");
    _emitCall(callBuffer, transforms: argumentsTransforms.toList());
    callBuffer.writeln(")");
    buffer.write("${transform(callBuffer.toString())};");
  }

  @override
  debugDump({
    InspectionCache? cache,
    bool expandChildren = true,
  }) =>
      <String, Object?>{
        ...super.debugDump(cache: cache, expandChildren: expandChildren),
        "signature": signature.debugDump(cache: cache),
      };
}
