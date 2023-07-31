part of interface_gen;

final class Primitive implements InspectEntry {
  const Primitive(this.name, this.sanitizedName, this.value);

  final String name;

  final String sanitizedName;

  final Object? value;

  @override
  InspectEntryType get type => InspectEntryType.primitive;

  @override
  Iterable<(String, InspectEntry)> get children =>
      const <(String, InspectEntry)>[];

  @override
  void collectChildren(InspectionCache cache, {required String stdlibPath}) {}

  @override
  void emit(StringBuffer buffer) {
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

final class AnyTypePrimitive extends Primitive {
  const AnyTypePrimitive(String name, String sanitizedName)
      : super(name, sanitizedName, null);
}
