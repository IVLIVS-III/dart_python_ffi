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

  String get name => (_source as dynamic).__name__ as String;

  @override
  String emit() {
    final String? moduleName = _source.hasAttribute("__module__")
        ? _source.getAttribute("__module__")
        : null;
    if (moduleName == null) {
      return "";
    }

    final String className = name;
    final StringBuffer buffer = StringBuffer()..writeln("/// ## $className");
    emitDocstring(buffer);
    buffer.writeln("""
final class $className extends PythonClass {
  factory $className(String name) => PythonFfiDart.instance.importClass(
        "$moduleName",
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
