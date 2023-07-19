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

  static const String _k__defaults__ = "__defaults__";

  List<Object?>? get __defaults__ =>
      hasAttribute(_k__defaults__) ? getAttribute(_k__defaults__) : null;

  @override
  Iterable<String> get _childrenNames sync* {
    final PythonCodeObject? code = __code__;
    yield* code?.co_varnames ?? const <String>[];
  }

  @override
  Interface? collectChild(String childName) {
    final PythonCodeObject? code = __code__;
    if (code == null) {
      print("Warning: $this does not have a code object");
      return null;
    }
    final List<String>? co_varnames = code.co_varnames;
    if (co_varnames == null) {
      print("Warning: $this does not have co_varnames");
      return null;
    }
    if (!co_varnames.contains(childName)) {
      print("Warning: $this does not have child $childName");
      return null;
    }
    final int idx = co_varnames.indexOf(childName);
    final int ridx = co_varnames.length - idx - 1;
    final List<Object?> defaults = __defaults__ ?? const <Object?>[];
    final int didx = defaults.length - ridx - 1;
    final Object? value =
        didx >= 0 && didx < defaults.length ? defaults[didx] : null;
    final PrimitiveInterface result = switch (value) {
      Object() => PrimitiveInterface(value),
      null => NullInterface(),
    };
    _children[childName] = result;
    return result;
  }

  String get name => (_source as dynamic).__name__ as String;

  Iterable<(String, String?)> _parameters({bool isMethod = false}) =>
      _children.entries
          .where(
            (MapEntry<String, Interface> entry) =>
                !isMethod || entry.key != "self",
          )
          .map(
            (MapEntry<String, Interface> e) => (
              e.key,
              switch (e.value) {
                NullInterface() => null,
                PrimitiveInterface() => e.value.emit(),
                _ => throw UnimplementedError(e.toString()),
              }
            ),
          );

  String parameterList({bool isMethod = false}) {
    final Iterable<(String, String?)> parameters =
        _parameters(isMethod: isMethod);
    if (parameters.isEmpty) {
      return "";
    }
    return "{${parameters.map(
      ((String, String?) e) {
        final String name = e.$1;
        final String? defaultValue = e.$2;
        final String core = "Object? $name";
        return defaultValue == null
            ? "required $core,"
            : "$core = $defaultValue,";
      },
    ).join(" ")}}";
  }

  String argumentList({bool isMethod = false}) =>
      _parameters(isMethod: isMethod)
          .map(((String, String?) e) => "${e.$1},")
          .join(" ");

  @override
  String emit({bool isMethod = false}) {
    final String functionName = name;
    final StringBuffer buffer = StringBuffer()..writeln("/// ## $functionName");
    emitDocstring(buffer);
    buffer.writeln("""
Object? $functionName(${parameterList(isMethod: isMethod)})
  => getFunction("$functionName").call(<Object?>[${argumentList(isMethod: isMethod)}]);
""");
    return buffer.toString();
  }
}
