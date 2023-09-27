part of interface_gen;

/// Representation of a Python class instance.
final class ClassInstance extends PythonClass
    with InspectMixin
    implements InspectEntry {
  /// Wraps a Python object in a [ClassInstance].
  ClassInstance.from(super.classDelegate)
      : value = classDelegate,
        super.from();

  @override
  final PythonClassInterface<PythonFfiDelegate<Object?>, Object?> value;

  @override
  InspectEntryType get type => InspectEntryType.class_;

  @override
  InstantiatedInspectEntry _instantiateFrom({
    required String name,
    required String sanitizedName,
    required InstantiatedModule instantiatingModule,
  }) =>
      InstantiatedClassInstance.from(
        this,
        name: name,
        sanitizedName: sanitizedName,
        instantiatingModule: instantiatingModule,
      );
}

/// Instantiated version of [ClassInstance].
/// This pins the class to a specific module.
final class InstantiatedClassInstance extends PythonClass
    with InstantiatedInspectMixin
    implements InstantiatedInspectEntry {
  /// Creates a new instance of [InstantiatedClassInstance].
  InstantiatedClassInstance.from(
    this.source, {
    required this.name,
    required this.sanitizedName,
    required this.instantiatingModule,
  }) : super.from(source.value);

  @override
  final ClassInstance source;

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
  }) {
    buffer.writeln("/// ## $name");
    emitDoc(buffer);
    emitSource(buffer);
    buffer.writeln(
      "typedef $sanitizedName = ${_getTypeString(this, cache: cache)};",
    );
  }
}
