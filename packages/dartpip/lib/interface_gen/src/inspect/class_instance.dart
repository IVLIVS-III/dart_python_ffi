part of interface_gen;

final class ClassInstance extends PythonClass
    with InspectMixin
    implements InspectEntry {
  ClassInstance.from(this.name, super.classDelegate)
      : value = classDelegate,
        super.from();

  final String name;

  final PythonClassInterface value;

  @override
  InspectEntryType get type => InspectEntryType.class_;

  @override
  void emit(StringBuffer buffer) {
    buffer.writeln("/// ## $name");
    emitDoc(buffer);
    emitSource(buffer);
    buffer.writeln("typedef $sanitizedName = Object?;");
  }
}
