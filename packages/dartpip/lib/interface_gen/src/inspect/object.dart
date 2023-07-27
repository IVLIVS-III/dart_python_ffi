part of interface_gen;

final class Object_ extends PythonObject
    with InspectMixin
    implements InspectEntry {
  Object_.from(this.name, super.objectDelegate)
      : value = objectDelegate,
        super.from();

  final String name;

  final PythonObjectInterface value;

  @override
  InspectEntryType get type => InspectEntryType.object;

  @override
  void emit(StringBuffer buffer) {
    buffer.writeln("""
    Object? get $name => getAttribute("$name");
    set $name(Object? $name) => setAttribute("$name", $name);
""");
  }
}
