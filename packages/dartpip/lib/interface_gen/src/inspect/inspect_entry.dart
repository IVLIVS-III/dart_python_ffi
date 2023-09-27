part of interface_gen;

/// Represents the inspection entries' type.
enum InspectEntryType {
  /// The entry is a module.
  module,

  /// The entry is a class definition.
  classDefinition,

  /// The entry is a class instance.
  class_,

  /// The entry is a function.
  function,

  /// The entry is an object.
  object,

  /// The entry is a primitive.
  primitive;

  /// Returns a human-readable name for this type.
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

/// Connects an inspect entry to a module in which it is defined or imported.
@immutable
class InspectEntryModuleConnection {
  /// Creates a new instance of [InspectEntryModuleConnection].
  InspectEntryModuleConnection({
    required this.name,
    required this.sanitizedName,
    required this.parentModule,
  });

  /// The mane of this entry in the parent module.
  final String name;

  /// The sanitized name of this entry in the parent module.
  final String sanitizedName;

  /// The parent module.
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

  /// Emits a JSON representation of this connection.
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

/// Base class for inspect entries.
sealed class InspectEntry {
  // Prevents extending this class.
  // We want to use this class like an interface, but we also want to be able
  // to use it in switch statements with static exhaustiveness checking.
  factory InspectEntry._() => throw UnimplementedError();

  /// Helper to check if this entry has a connection to a module.
  bool hasModuleConnection(InspectEntryModuleConnection connection);

  /// Connects this entry to a module.
  /// Returns true if the connection was successful, false if the connection
  /// already existed.
  bool addModuleConnection(InspectEntryModuleConnection connection);

  /// Returns all modules to which this entry is connected.
  List<InspectEntryModuleConnection> get moduleConnections;

  /// Returns the value of this entry.
  Object? get value;

  /// Returns the type of this entry.
  InspectEntryType get type;

  /// Returns the sanitized name of this entry.
  String get sanitizedName;

  /// Returns all children of this entry.
  Iterable<(String, InspectEntry)> get children;

  /// Returns all instantiations of this entry already created.
  Iterable<InstantiatedInspectEntry> get cachedInstantiations;

  /// Collects all children of this entry during the inspection process.
  void collectChildren(
    InspectionCache cache, {
    required String stdlibPath,
    required Module parentModule,
  });

  /// Creates an instantiation of this entry to the given module.
  /// Returns null if this entry cannot be instantiated because it is not
  /// connected to this module.
  InstantiatedInspectEntry? instantiate(InstantiatedModule instantiatingModule);

  /// Emits a JSON representation of this entry.
  Map<String, Object?> debugDump({
    InspectionCache? cache,
    bool expandChildren = true,
  });
}

/// Base class for instantiated inspect entries.
sealed class InstantiatedInspectEntry {
  // Prevents extending this class.
  // We want to use this class like an interface, but we also want to be able
  // to use it in switch statements with static exhaustiveness checking.
  factory InstantiatedInspectEntry._() => throw UnimplementedError();

  /// Returns the source entry of this instantiation.
  InspectEntry get source;

  /// Returns the name of this entry in the instantiating module.
  String get name;

  /// Returns the sanitized name of this entry in the instantiating module.
  String get sanitizedName;

  /// Returns the instantiating module.
  InstantiatedModule get instantiatingModule;

  /// Emits a Dart source for this entry during interface generation.
  void emit(
    StringBuffer buffer, {
    required InspectionCache cache,
    required AppType appType,
  });

  /// Emits the Python documentation for this entry.
  void emitDoc(StringBuffer buffer);

  /// Emits the Python source for this entry.
  void emitSource(StringBuffer buffer);
}
