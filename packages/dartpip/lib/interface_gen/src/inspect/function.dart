part of interface_gen;

final class Function_ extends PythonFunction
    with InspectMixin
    implements InspectEntry {
  Function_.from(this.name, super.functionDelegate)
      : value = functionDelegate,
        super.from();

  final String name;

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

  void emitArguments(StringBuffer buffer) {
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.positional_only)) {
      buffer.writeln("Object? ${parameter.sanitizedName},");
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
        buffer.writeln(
          "${parameter.requiredString} Object? ${parameter.sanitizedName} ${parameter.defaultString},",
        );
      }
      for (final Parameter parameter
          in _parametersOfKind(ParameterKind.keyword_only)) {
        buffer.writeln(
          "${parameter.requiredString} Object? ${parameter.sanitizedName} ${parameter.defaultString},",
        );
      }
      for (final Parameter parameter
          in _parametersOfKind(ParameterKind.var_keyword)) {
        buffer.writeln(
          "Map<String, Object?> ${parameter.sanitizedName} ${parameter.defaultString},",
        );
      }
      buffer.write("}");
    }
  }

  void emitCallArgs(StringBuffer buffer) {
    buffer.writeln("<Object?>[");
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.positional_only)) {
      buffer.writeln("${parameter.sanitizedName},");
    }
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.positional_or_keyword)) {
      buffer.writeln("${parameter.sanitizedName},");
    }
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.var_positional)) {
      buffer.writeln("...${parameter.sanitizedName},");
    }
    buffer.writeln("],");
  }

  void emitCallKwargs(StringBuffer buffer) {
    buffer.writeln("<String, Object?>{");
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.keyword_only)) {
      buffer.writeln("\"${parameter.name}\": ${parameter.sanitizedName},");
    }
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.var_keyword)) {
      buffer.writeln("...${parameter.sanitizedName},");
    }
    buffer.writeln("},");
  }

  void emitCall(StringBuffer buffer) {
    emitCallArgs(buffer);
    buffer.write("kwargs: ");
    emitCallKwargs(buffer);
  }

  @override
  void emit(StringBuffer buffer) {
    buffer.writeln("/// ## $name");
    emitDoc(buffer);
    emitSource(buffer);
    buffer.writeln("Object? $sanitizedName(");
    emitArguments(buffer);
    buffer.writeln(") => getFunction(\"$name\").call(");
    emitCall(buffer);
    buffer.writeln(");");
  }

  @override
  debugDump({bool expandChildren = true}) => <String, Object?>{
        ...super.debugDump(expandChildren: expandChildren),
        "signature": signature.debugDump(),
      };
}
