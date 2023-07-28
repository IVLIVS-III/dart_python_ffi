part of interface_gen;

base mixin GetterSetterMixin on InspectMixin {
  void _emitGettersSetters(
    StringBuffer buffer, {
    required Set<String> memberNames,
    bool Function(InspectEntry child)? filter,
  }) {
    final Iterable<InspectEntry> fields = _children.values
        .whereType<ClassInstance>()
        .whereNot(types.isType)
        .cast<InspectEntry>()
        .followedBy(_children.values.whereType<Object_>())
        .followedBy(_children.values.whereType<Primitive>());
    for (final InspectEntry field in fields) {
      if (filter != null && !filter(field)) {
        continue;
      }
      final String sanitizedName = field.sanitizedName;
      if (memberNames.contains(sanitizedName)) {
        continue;
      }
      memberNames.add(sanitizedName);
      final String fieldName = field.name;
      buffer.writeln("/// ## $fieldName (getter)");
      field.emitDoc(buffer);
      buffer.writeln("""
Object? get $sanitizedName => getAttribute("$fieldName");

/// ## $fieldName (setter)""");
      field.emitDoc(buffer);
      buffer.writeln("""
set $sanitizedName(Object? $sanitizedName)
  => setAttribute("$fieldName", $sanitizedName);
""");
    }
  }
}
