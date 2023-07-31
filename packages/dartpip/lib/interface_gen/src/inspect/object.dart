part of interface_gen;

final class Object_ extends PythonObject
    with InspectMixin, GetterSetterMixin
    implements InspectEntry {
  Object_.from(this.name, this.sanitizedName, super.objectDelegate)
      : value = objectDelegate,
        super.from();

  final String name;

  final String sanitizedName;

  @override
  Set<String> get _sanitizationExtraKeywords => sanitizationExtraKeywords;

  static const Set<String> sanitizationExtraKeywords = <String>{
    "from",
    "getFunction",
    "toDartObject",
    "hasAttribute",
    "getAttributeRaw",
    "getAttribute",
    "setAttributeRaw",
    "setAttribute",
    "toString",
    "hashCode",
    "noSuchMethod",
    "verify",
    "initializer",
    "finalizer",
    "platform",
    "reference",
    "debugDump",
  };

  final PythonObjectInterface value;

  @override
  InspectEntryType get type => InspectEntryType.object;

  @override
  void emit(StringBuffer buffer) => _emitGetterSetter(buffer, entry: this);
}
