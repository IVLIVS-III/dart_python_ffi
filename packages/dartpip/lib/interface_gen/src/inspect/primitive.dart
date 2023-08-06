part of interface_gen;

/// TODO: Document.
final class Primitive implements InspectEntry {
  /// TODO: Document.
  const Primitive(this.name, this.sanitizedName, this.value);

  @override
  final String name;

  @override
  final String sanitizedName;

  @override
  final Object? value;

  @override
  InspectEntryType get type => InspectEntryType.primitive;

  @override
  Iterable<(String, InspectEntry)> get children =>
      const <(String, InspectEntry)>[];

  @override
  void collectChildren(InspectionCache cache, {required String stdlibPath}) {}

  @override
  void emit(StringBuffer buffer, {required InspectionCache cache}) {
    throw UnimplementedError("$runtimeType.emit");
  }

  @override
  void emitDoc(StringBuffer buffer) {}

  @override
  void emitSource(StringBuffer buffer) {}

  @override
  Map<String, Object?> debugDump({
    InspectionCache? cache,
    bool expandChildren = true,
  }) =>
      <String, Object?>{
        "name": name,
        "sanitizedName": sanitizedName,
        "value": value,
        "type": type.displayName,
      };
}

/// TODO: Document.
final class AnyTypePrimitive extends Primitive {
  /// TODO: Document.
  const AnyTypePrimitive(String name, String sanitizedName)
      : super(name, sanitizedName, null);
}
