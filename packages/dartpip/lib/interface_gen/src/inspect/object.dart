// ignore_for_file: camel_case_types

part of interface_gen;

/// Representation of a Python object.
final class Object_ extends PythonObject
    with InspectMixin
    implements InspectEntry {
  /// Wraps a Python object in a [Object_].
  Object_.from(super.objectDelegate)
      : value = objectDelegate,
        super.from();

  @override
  Set<String> get _sanitizationExtraKeywords => sanitizationExtraKeywords;

  /// Returns all identifiers that must be renamed when appearing as fields
  /// inside an object. Most of them are used by Dart PythonFFI internals.
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

/// Instantiated version of [Object_].
final class InstantiatedObject_ extends PythonObject
    with InstantiatedInspectMixin, GetterSetterMixin
    implements InstantiatedInspectEntry {
  /// Creates a new instance of [InstantiatedObject_].
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
  void emit(
    StringBuffer buffer, {
    required InspectionCache cache,
    required AppType appType,
  }) =>
      _emitGetterSetter(buffer, entry: this, cache: cache);
}
