part of interface_gen;

base mixin FunctionFieldMixin on InspectMixin {
  void _emitFunctionFields(
    StringBuffer buffer, {
    required Set<String> memberNames,
    bool Function(InspectEntry child)? filter,
  }) {
    for (final Function_ field in _children.values.whereType<Function_>()) {
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
      field.emit(buffer);
    }
  }
}
