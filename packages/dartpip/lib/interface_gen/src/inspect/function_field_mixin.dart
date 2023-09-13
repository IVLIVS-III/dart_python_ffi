part of interface_gen;

/// TODO: Document.
base mixin FunctionFieldMixin on InstantiatedInspectMixin {
  /// Emits all member functions of a class or module.
  void _emitFunctionFields(
    StringBuffer buffer, {
    required Set<String> memberNames,
    required InspectionCache cache,
    required AppType appType,
    bool Function(InstantiatedInspectEntry child)? filter,
    InstantiatedInspectEntry? parentEntry,
  }) {
    for (final InstantiatedFunction_ field
        in _children.whereType<InstantiatedFunction_>()) {
      if (filter != null && !filter(field)) {
        continue;
      }
      final String functionName = field.sanitizedName;
      if (memberNames.contains(functionName)) {
        continue;
      }
      if (functionName == name) {
        continue;
      }
      memberNames.add(functionName);
      field.emit(
        buffer,
        cache: cache,
        appType: appType,
        extraKeywords: _sanitizationExtraKeywords,
        parentEntry: parentEntry,
      );
    }
  }
}
