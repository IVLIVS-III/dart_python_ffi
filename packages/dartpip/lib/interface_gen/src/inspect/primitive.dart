part of interface_gen;

final class Primitive implements InspectEntry {
  const Primitive(this.name, this.value);

  final String name;

  String get sanitizedName => sanitizeName(name);

  final Object? value;

  @override
  InspectEntryType get type => InspectEntryType.primitive;

  @override
  int? get id => InspectionCache.instance.id(value);

  @override
  Iterable<(String, InspectEntry)> get children =>
      const <(String, InspectEntry)>[];

  @override
  void collectChildren() {}

  @override
  void emit(StringBuffer buffer) {
    throw UnimplementedError("$runtimeType.emit");
  }

  @override
  void emitDoc(StringBuffer buffer) {}

  @override
  void emitSource(StringBuffer buffer) {}

  @override
  Map<String, Object?> debugDump({bool expandChildren = true}) =>
      <String, Object?>{
        "name": name,
        "sanitizedName": sanitizedName,
        "value": value,
        "type": type.displayName,
      };
}
