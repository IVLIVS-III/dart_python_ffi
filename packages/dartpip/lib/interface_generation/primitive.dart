part of interface_generation;

final class PrimitiveInterface implements Interface {
  PrimitiveInterface(this._source);

  Object _source;

  @override
  Iterable<String> get _childrenNames => const <String>[];

  @override
  Map<String, Interface> get _children => const <String, Interface>{};

  @override
  Iterable<String> _dir() => const <String>[];

  @override
  void collectChildren() {}

  @override
  Interface? collectChild(String childName) => null;

  @override
  String emit() {
    final Object source = _source;
    return switch (source) {
      List() when source.isEmpty => "const []",
      Map() when source.isEmpty => "const {}",
      Set() when source.isEmpty => "const {}",
      String() => jsonEncode(source),
      _ => source.toString(),
    };
  }

  @override
  void emitDocstring(StringBuffer buffer) {}

  @override
  void emitProperties(StringBuffer buffer) {}
}

final class NullInterface extends PrimitiveInterface {
  NullInterface() : super(const Object());

  @override
  String emit() => throw UnsupportedError("NullInterface.emit");
}
