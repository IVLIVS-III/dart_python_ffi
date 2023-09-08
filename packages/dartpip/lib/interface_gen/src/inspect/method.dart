part of interface_gen;

/// TODO: Document.
final class Method extends Function_ {
  /// TODO: Document.
  Method.from(super.functionDelegate) : super.from();

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

  @override
  InstantiatedInspectEntry _instantiateFrom({
    required String name,
    required String sanitizedName,
    required InstantiatedModule instantiatingModule,
  }) =>
      InstantiatedMethod.from(
        this,
        name: name,
        sanitizedName: sanitizedName,
        instantiatingModule: instantiatingModule,
      );
}

/// TODO: Document.
final class InstantiatedMethod extends InstantiatedFunction_ {
  /// TODO: Document.
  InstantiatedMethod.from(
    super.source, {
    required super.name,
    required super.sanitizedName,
    required super.instantiatingModule,
  }) : super.from();
}
