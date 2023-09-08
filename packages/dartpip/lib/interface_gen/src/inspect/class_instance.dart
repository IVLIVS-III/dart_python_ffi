part of interface_gen;

/// TODO: Document.
final class ClassInstance extends PythonClass
    with InspectMixin
    implements InspectEntry {
  /// TODO: Document.
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

/// TODO: Document.
final class InstantiatedClassInstance extends PythonClass
    with InstantiatedInspectMixin
    implements InstantiatedInspectEntry {
  /// TODO: Document.
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
  void emit(StringBuffer buffer, {required InspectionCache cache}) {
    buffer.writeln("/// ## $name");
    emitDoc(buffer);
    emitSource(buffer);
    buffer.writeln(
      "typedef $sanitizedName = ${_getTypeString(this, cache: cache)};",
    );
  }
}
