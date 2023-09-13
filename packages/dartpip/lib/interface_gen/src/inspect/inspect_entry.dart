part of interface_gen;

/// TODO: Document.
enum InspectEntryType {
  /// TODO: Document.
  module,

  /// TODO: Document.
  classDefinition,

  /// TODO: Document.
  class_,

  /// TODO: Document.
  function,

  /// TODO: Document.
  object,

  /// TODO: Document.
  primitive;

  /// TODO: Document.
  String get displayName {
    switch (this) {
      case InspectEntryType.module:
        return "module";
      case InspectEntryType.classDefinition:
        return "class definition";
      case InspectEntryType.class_:
        return "class instance";
      case InspectEntryType.function:
        return "function";
      case InspectEntryType.object:
        return "object";
      case InspectEntryType.primitive:
        return "primitive";
    }
  }
}

/// TODO: Document.
@immutable
class InspectEntryModuleConnection {
  /// TODO: Document.
  InspectEntryModuleConnection({
    required this.name,
    required this.sanitizedName,
    required this.parentModule,
  });

  /// TODO: Document.
  final String name;

  /// TODO: Document.
  final String sanitizedName;

  /// TODO: Document.
  final Module parentModule;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InspectEntryModuleConnection &&
          name == other.name &&
          sanitizedName == other.sanitizedName &&
          parentModule == other.parentModule;

  @override
  int get hashCode => (name, sanitizedName, parentModule).hashCode;

  /// TODO: Document.
  Map<String, Object?> debugDump({
    InspectionCache? cache,
    bool expandChildren = true,
  }) =>
      <String, Object?>{
        "name": name,
        "sanitizedName": sanitizedName,
        "parentModule":
            parentModule.debugDump(cache: cache, expandChildren: false),
      };
}

/// TODO: Document.
sealed class InspectEntry {
  // Prevents extending this class.
  // We want to use this class like an interface, but we also want to be able
  // to use it in switch statements with static exhaustiveness checking.
  factory InspectEntry._() => throw UnimplementedError();

  /// TODO: Document.
  bool hasModuleConnection(InspectEntryModuleConnection connection);

  /// Connects this entry to a module.
  /// Returns true if the connection was successful, false if the connection
  /// already existed.
  bool addModuleConnection(InspectEntryModuleConnection connection);

  /// TODO: Document.
  List<InspectEntryModuleConnection> get moduleConnections;

  /// TODO: Document.
  Object? get value;

  /// TODO: Document.
  InspectEntryType get type;

  /// TODO: Document.
  String get sanitizedName;

  /// TODO: Document.
  Iterable<(String, InspectEntry)> get children;

  /// TODO: Document.
  Iterable<InstantiatedInspectEntry> get cachedInstantiations;

  /// TODO: Document.
  void collectChildren(
    InspectionCache cache, {
    required String stdlibPath,
    required Module parentModule,
  });

  /// TODO: Document.
  InstantiatedInspectEntry? instantiate(InstantiatedModule instantiatingModule);

  /// TODO: Document.
  Map<String, Object?> debugDump({
    InspectionCache? cache,
    bool expandChildren = true,
  });
}

/// TODO: Document.
sealed class InstantiatedInspectEntry {
  // Prevents extending this class.
  // We want to use this class like an interface, but we also want to be able
  // to use it in switch statements with static exhaustiveness checking.
  factory InstantiatedInspectEntry._() => throw UnimplementedError();

  /// TODO: Document.
  InspectEntry get source;

  /// TODO: Document.
  String get name;

  /// TODO: Document.
  String get sanitizedName;

  /// TODO: Document.
  InstantiatedModule get instantiatingModule;

  /// TODO: Document.
  void emit(StringBuffer buffer, {required InspectionCache cache});

  /// TODO: Document.
  void emitDoc(StringBuffer buffer);

  /// TODO: Document.
  void emitSource(StringBuffer buffer);
}
