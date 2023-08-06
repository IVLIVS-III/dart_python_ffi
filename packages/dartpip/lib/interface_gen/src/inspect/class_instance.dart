part of interface_gen;

/// TODO: Document.
final class ClassInstance extends PythonClass
    with InspectMixin
    implements InspectEntry {
  /// TODO: Document.
  ClassInstance.from(this.name, this.sanitizedName, super.classDelegate)
      : value = classDelegate,
        super.from();

  @override
  final String name;

  @override
  final String sanitizedName;

  @override
  final PythonClassInterface<PythonFfiDelegate<Object?>, Object?> value;

  @override
  InspectEntryType get type => InspectEntryType.class_;

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
