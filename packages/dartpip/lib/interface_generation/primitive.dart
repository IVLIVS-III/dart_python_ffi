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
  void collectChild(String childName) {}

  @override
  String emit() => throw UnimplementedError();

  @override
  void emitDocstring(StringBuffer buffer) {}
}
