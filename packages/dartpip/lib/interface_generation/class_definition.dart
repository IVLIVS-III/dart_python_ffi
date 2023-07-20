part of interface_generation;

final class ClassDefinitionInterface extends PythonClassDefinition
    with InterfaceImpl
    implements Interface {
  ClassDefinitionInterface.from(super.delegate)
      : _source = delegate,
        super.from();

  PythonClassDefinitionInterface _source;

  static const String _k__init__ = "__init__";

  FunctionInterface? _init;

  @override
  Interface? collectChild(String childName) => _collectAttribute(childName);

  @override
  void collectChildren() {
    super.collectChildren();
    if (name == _k__init__) {
      return;
    }
    if (_init == null) {
      final Interface? child = collectChild(_k__init__);
      if (child is FunctionInterface) {
        _init = child;
      }
    }
    _children.remove(_k__init__);
  }

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
  factory $className(${_init?.parameterList(isMethod: true) ?? ""}) => PythonFfiDart.instance.importClass(
        "$moduleName",
        "$className",
        $className.from,
        <Object?>[${_init?.argumentList(isMethod: true) ?? ""}],
      );

  $className.from(super.pythonClass) : super.from();
""");
    for (final (String, Interface) property in _children.entries
        .map((MapEntry<String, Interface> e) => (e.key, e.value))
        .whereNot(
          ((String, Interface) e) =>
              e.$2 is FunctionInterface || e.$2 is ClassDefinitionInterface,
        )) {
      buffer.writeln(
        """
Object? get ${property.$1} => getAttribute("${property.$1}");
set ${property.$1}(Object? ${property.$1}) => setAttribute("${property.$1}", ${property.$1});
""",
      );
    }
    buffer.writeln("""
  ${_children.values.whereType<FunctionInterface>().map((FunctionInterface child) => child.emit(isMethod: true)).join("\n")}
}
""");
    return buffer.toString();
  }
}
