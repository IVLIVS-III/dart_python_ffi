part of interface_gen;

/// TODO: Document.
final class Method extends Function_ {
  /// TODO: Document.
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

  /// TODO: Document.
  Parameter? get selfParameter => super.parameters.firstWhereOrNull(
        (Parameter element) =>
            element.kind == ParameterKind.positional_only ||
            element.kind == ParameterKind.positional_or_keyword,
      );
}
