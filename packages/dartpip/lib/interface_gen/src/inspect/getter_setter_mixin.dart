part of interface_gen;

/// TODO: Document.
base mixin GetterSetterMixin on InstantiatedInspectMixin {
  void _emitGetterSetter(
    StringBuffer buffer, {
    required InstantiatedInspectEntry entry,
    required InspectionCache cache,
  }) {
    final String name = entry.name;
    final String sanitizedName = entry.sanitizedName;
    buffer.writeln("/// ## $name (getter)");
    emitDoc(buffer);
    final (String returnType, Transform transform) =
        _getTypeStringWithTransform(entry, cache: cache, isReturnString: true);
    buffer.writeln("""
$returnType get $sanitizedName => 
${transform("getAttribute(\"$name\")")};

/// ## $name (setter)""");
    emitDoc(buffer);
    buffer.writeln("""
set $sanitizedName(${_getTypeString(entry, cache: cache)} $sanitizedName)
  => setAttribute("$name", $sanitizedName);
""");
  }
}

/// TODO: Document.
base mixin GettersSettersMixin on GetterSetterMixin {
  void _emitGettersSetters(
    StringBuffer buffer, {
    required Set<String> memberNames,
    required InspectionCache cache,
    bool Function(InstantiatedInspectEntry child)? filter,
    InstantiatedInspectEntry? parentEntry,
  }) {
    final Iterable<InstantiatedInspectEntry> fields = _children
        .whereType<InstantiatedClassInstance>()
        .whereNot(types.isInstantiatedType)
        .cast<InstantiatedInspectEntry>()
        .followedBy(_children.whereType<InstantiatedObject_>())
        .followedBy(_children.whereType<Primitive>());
    for (final InstantiatedInspectEntry field in fields) {
      if (filter != null && !filter(field)) {
        continue;
      }
      final String sanitizedName = field.sanitizedName;
      if (memberNames.contains(sanitizedName)) {
        continue;
      }
      memberNames.add(sanitizedName);
      // TODO: use parentEntry
      _emitGetterSetter(buffer, entry: field, cache: cache);
    }
  }
}
