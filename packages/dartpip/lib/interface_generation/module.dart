part of interface_generation;

final class ModuleInterface extends PythonModule
    with InterfaceImpl
    implements Interface {
  ModuleInterface.from(super.moduleDelegate)
      : _source = moduleDelegate,
        super.from();

  PythonModuleInterface _source;

  static const String _k__all__ = "__all__";

  List<String>? get __all__ => hasAttribute(_k__all__)
      ? getAttribute<List<Object?>>(_k__all__).cast()
      : null;

  @override
  Iterable<String> get _childrenNames => __all__ ?? super._childrenNames;

  @override
  void collectChild(String childName) => _collectAttribute(childName);

  @override
  String emit() {
    dynamic module = _source;
    final String moduleName = module.__name__ as String;
    final String moduleFilePath = module.__file__ as String;
    final File moduleFile = File(moduleFilePath);
    final StringBuffer buffer = StringBuffer()..writeln("/// ## $moduleName");
    emitDocstring(buffer);
    buffer
      ..writeln("///")
      ..writeln("/// ### python source")
      ..writeln("/// ```py")
      ..writeln(
        moduleFile.readAsStringSync().trim().leftPadLines(1, pad: "/// "),
      )
      ..writeln("/// ```")
      ..writeln("""
final class $moduleName extends PythonModule {
  $moduleName.from(super.pythonModule) : super.from();
  
  static $moduleName import() => PythonFfiDart.instance
      .importModule("$moduleName", $moduleName.from);
  
  ${_children.values.whereType<FunctionInterface>().map((Interface child) => child.emit()).join("\n")}
}
""");
    return buffer.toString();
  }
}
