part of interface_gen;

base mixin GetterSetterMixin on InspectMixin {
  void _emitGetterSetter(
    StringBuffer buffer, {
    required InspectEntry entry,
  }) {
    final String name = entry.name;
    final String sanitizedName = entry.sanitizedName;
    buffer.writeln("/// ## $name (getter)");
    emitDoc(buffer);
    final (String returnType, _ReturnTransform transform) =
        _getTypeStringWithTransform(entry, isReturnString: true);
    buffer.writeln("""
$returnType get $sanitizedName => 
${transform("getAttribute(\"$name\")")};

/// ## $name (setter)""");
    emitDoc(buffer);
    buffer.writeln("""
set $sanitizedName(${_getTypeString(entry)} $sanitizedName)
  => setAttribute("$name", $sanitizedName);
""");
  }
}

base mixin GettersSettersMixin on GetterSetterMixin {
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
      _emitGetterSetter(buffer, entry: field);
    }
  }
}
