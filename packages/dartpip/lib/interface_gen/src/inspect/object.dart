// ignore_for_file: camel_case_types

part of interface_gen;

/// TODO: Document.
final class Object_ extends PythonObject
    with InspectMixin, GetterSetterMixin
    implements InspectEntry {
  /// TODO: Document.
  Object_.from(this.name, this.sanitizedName, super.objectDelegate)
      : value = objectDelegate,
        super.from();

  @override
  final String name;

  @override
  final String sanitizedName;

  @override
  Set<String> get _sanitizationExtraKeywords => sanitizationExtraKeywords;

  /// TODO: Document.
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

  @override
  final PythonObjectInterface<PythonFfiDelegate<Object?>, Object?> value;

  @override
  InspectEntryType get type => InspectEntryType.object;

  @override
  void emit(StringBuffer buffer, {required InspectionCache cache}) =>
      _emitGetterSetter(buffer, entry: this, cache: cache);
}
