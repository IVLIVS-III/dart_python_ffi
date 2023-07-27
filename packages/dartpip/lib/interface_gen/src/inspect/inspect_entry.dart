part of interface_gen;

enum InspectEntryType {
  module,
  classDefinition,
  class_,
  function,
  object,
  primitive;

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

sealed class InspectEntry {
  String get name;

  String get sanitizedName;

  Object? get value;

  InspectEntryType get type;

  int? get id;

  Iterable<(String, InspectEntry)> get children;

  void collectChildren();

  void emit(StringBuffer buffer);

  void emitDoc(StringBuffer buffer);

  void emitSource(StringBuffer buffer);

  Map<String, Object?> debugDump({bool expandChildren = true});
}
