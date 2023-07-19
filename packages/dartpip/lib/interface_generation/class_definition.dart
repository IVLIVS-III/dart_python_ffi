part of interface_generation;

final class ClassDefinitionInterface extends PythonClassDefinition
    with InterfaceImpl
    implements Interface {
  ClassDefinitionInterface.from(super.delegate)
      : _source = delegate,
        super.from();

  PythonClassDefinitionInterface _source;

  @override
  void collectChild(String childName) => _collectAttribute(childName);

  @override
  String emit() {
    dynamic classDefinition = _source;
    final String className = classDefinition.__name__ as String;
    final StringBuffer buffer = StringBuffer()
      ..writeln("/// ## $className")
      ..writeln("/// ### debug info")
      ..writeln("/// ```")
      ..writeln("/// ${_source.reference}")
      ..writeln("/// ```");
    emitDocstring(buffer);
    buffer.writeln("""
final class $className extends PythonClass {
  factory $className(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "$className",
        $className.from,
        <Object?>[name],
      );

  $className.from(super.pythonClass) : super.from();

  ${_children.values.whereType<FunctionInterface>().map((Interface child) => child.emit()).join("\n")}
}
""");
    return buffer.toString();
  }
}
