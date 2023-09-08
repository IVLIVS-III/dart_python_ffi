// ignore_for_file: camel_case_types

part of interface_gen;

/// TODO: Document.
final class Object_ extends PythonObject
    with InspectMixin
    implements InspectEntry {
  /// TODO: Document.
  Object_.from(super.objectDelegate)
      : value = objectDelegate,
        super.from();

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
  InstantiatedInspectEntry _instantiateFrom({
    required String name,
    required String sanitizedName,
    required InstantiatedModule instantiatingModule,
  }) =>
      InstantiatedObject_.from(
        this,
        name: name,
        sanitizedName: sanitizedName,
        instantiatingModule: instantiatingModule,
      );
}

/// TODO: Document.
final class InstantiatedObject_ extends PythonObject
    with InstantiatedInspectMixin, GetterSetterMixin
    implements InstantiatedInspectEntry {
  /// TODO: Document.
  InstantiatedObject_.from(
    this.source, {
    required this.name,
    required this.sanitizedName,
    required this.instantiatingModule,
  }) : super.from(source.value);

  @override
  final Object_ source;

  @override
  final String name;

  @override
  final String sanitizedName;

  @override
  final InstantiatedModule instantiatingModule;

  @override
  void emit(StringBuffer buffer, {required InspectionCache cache}) =>
      _emitGetterSetter(buffer, entry: this, cache: cache);
}
