part of interface_gen;

final class ClassInstance extends PythonClass
    with InspectMixin
    implements InspectEntry {
  ClassInstance.from(this.name, this.sanitizedName, super.classDelegate)
      : value = classDelegate,
        super.from();

  final String name;

  final String sanitizedName;

  final PythonClassInterface value;

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
