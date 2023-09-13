part of interface_gen;

/// TODO: Document.
final class Primitive implements InspectEntry, InstantiatedInspectEntry {
  /// TODO: Document.
  const Primitive(this.name, this.sanitizedName, this.value);

  @override
  final Object? value;

  @override
  InspectEntryType get type => InspectEntryType.primitive;

  @override
  InspectEntry get source => this;

  @override
  final String name;

  @override
  final String sanitizedName;

  @override
  InstantiatedModule get instantiatingModule =>
      throw UnimplementedError("$runtimeType.instantiatingModule");

  @override
  List<InspectEntryModuleConnection> get moduleConnections =>
      throw UnimplementedError("$runtimeType.moduleConnections");

  @override
  bool hasModuleConnection(InspectEntryModuleConnection connection) => false;

  @override
  bool addModuleConnection(InspectEntryModuleConnection connection) => false;

  @override
  Iterable<(String, InspectEntry)> get children =>
      const <(String, InspectEntry)>[];

  @override
  InstantiatedInspectEntry instantiate(
    InstantiatedModule instantiatingModule,
  ) =>
      this;

  @override
  void collectChildren(
    InspectionCache cache, {
    required String stdlibPath,
    required Module parentModule,
  }) {}

  @override
  void emit(
    StringBuffer buffer, {
    required InspectionCache cache,
    required AppType appType,
  }) {
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
        "value": value,
        "type": type.displayName,
      };

  @override
  Iterable<InstantiatedInspectEntry> get cachedInstantiations sync* {
    yield this;
  }
}

/// TODO: Document.
final class AnyTypePrimitive extends Primitive {
  /// TODO: Document.
  const AnyTypePrimitive(String name, String sanitizedName)
      : super(name, sanitizedName, null);
}
