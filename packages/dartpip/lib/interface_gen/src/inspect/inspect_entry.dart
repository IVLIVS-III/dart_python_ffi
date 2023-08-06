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
sealed class InspectEntry {
  /// TODO: Document.
  String get name;

  /// TODO: Document.
  String get sanitizedName;

  /// TODO: Document.
  Object? get value;

  /// TODO: Document.
  InspectEntryType get type;

  /// TODO: Document.
  Iterable<(String, InspectEntry)> get children;

  /// TODO: Document.
  void collectChildren(InspectionCache cache, {required String stdlibPath});

  /// TODO: Document.
  void emit(StringBuffer buffer, {required InspectionCache cache});

  /// TODO: Document.
  void emitDoc(StringBuffer buffer);

  /// TODO: Document.
  void emitSource(StringBuffer buffer);

  /// TODO: Document.
  Map<String, Object?> debugDump({
    InspectionCache? cache,
    bool expandChildren = true,
  });
}
