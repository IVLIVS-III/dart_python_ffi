part of interface_generation;

final class PythonCodeObject extends PythonObject {
  PythonCodeObject.from(super.delegate) : super.from();

  static const String _kco_varnames = "co_varnames";

  List<String>? get co_varnames => hasAttribute(_kco_varnames)
      ? getAttribute<List<Object?>>(_kco_varnames).cast()
      : null;
}

final class FunctionInterface extends PythonFunction
    with InterfaceImpl
    implements Interface {
  FunctionInterface.from(super.delegate)
      : _source = delegate,
        super.from();

  Object _source;

  static const String _k__code__ = "__code__";

  PythonCodeObject? get __code__ => hasAttribute(_k__code__)
      ? PythonCodeObject.from(getAttribute(_k__code__))
      : null;

  @override
  Iterable<String> get _childrenNames sync* {
    final PythonCodeObject? code = __code__;
    yield* code?.co_varnames ?? super._childrenNames;
  }

  @override
  void collectChild(String childName) {
    final PythonCodeObject? code = __code__;
    if (code == null) {
      print("Warning: $this does not have a code object");
      return;
    }
    final List<String>? co_varnames = code.co_varnames;
    if (co_varnames == null) {
      print("Warning: $this does not have co_varnames");
      return;
    }
    if (!co_varnames.contains(childName)) {
      print("Warning: $this does not have child $childName");
      return;
    }
    // TODO: used default values instead
    _children[childName] = PrimitiveInterface(childName);
  }

  @override
  String emit() {
    dynamic function = _source;
    final String functionName = function.__name__ as String;
    final StringBuffer buffer = StringBuffer()..writeln("/// ## $functionName");
    emitDocstring(buffer);
    buffer.writeln("""
Object? $functionName(${_children.keys.map((String e) => "Object? $e").join(", ")})
  => getFunction("$functionName").call(<Object?>[${_children.keys.join(", ")}]);
""");
    return buffer.toString();
  }
}
