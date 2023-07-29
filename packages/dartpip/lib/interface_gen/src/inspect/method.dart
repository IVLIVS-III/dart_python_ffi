part of interface_gen;

final class Method extends Function_ {
  Method.from(super.name, super.sanitizedName, super.functionDelegate)
      : super.from();

  @override
  Iterable<Parameter> get parameters sync* {
    bool didSkipSelf = false;
    for (final Parameter parameter in super.parameters) {
      if (!didSkipSelf) {
        if (parameter.kind == ParameterKind.positional_only ||
            parameter.kind == ParameterKind.positional_or_keyword) {
          didSkipSelf = true;
          continue;
        }
      }
      yield parameter;
    }
  }

  Parameter? get selfParameter => super.parameters.firstWhereOrNull(
        (Parameter element) =>
            element.kind == ParameterKind.positional_only ||
            element.kind == ParameterKind.positional_or_keyword,
      );
}
