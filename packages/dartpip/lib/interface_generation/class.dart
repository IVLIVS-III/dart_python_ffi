part of interface_generation;

final class ClassInterface extends PythonClass
    with InterfaceImpl
    implements Interface {
  ClassInterface.from(super.delegate, this.name)
      : _source = delegate,
        super.from();

  Object _source;

  final String name;

  @override
  Interface? collectChild(String childName) => _collectAttribute(childName);

  @override
  String emit() {
    final StringBuffer buffer = StringBuffer()
      ..writeln("/// ## $name");
    emitDocstring(buffer);
    buffer.writeln("""
typedef $name = Object?;
""");
    return buffer.toString();
  }
}
