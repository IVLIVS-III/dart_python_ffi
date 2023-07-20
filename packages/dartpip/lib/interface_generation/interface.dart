part of interface_generation;

sealed class Interface {
  Object get _source;

  Map<String, Interface> get _children;

  Iterable<String> _dir();

  Iterable<String> get _childrenNames;

  void collectChildren();

  Interface? collectChild(String childName);

  String emit();

  void emitDocstring(StringBuffer buffer);
}

base mixin InterfaceImpl on PythonObjectInterface implements Interface {
  final Map<String, Interface> _children = <String, Interface>{};

  Iterable<String> _dir() sync* {
    final Object? dirResult = BuiltinsModule.import().dir(this);
    if (dirResult is List) {
      yield* dirResult.whereType();
    }
  }

  Iterable<String> get _childrenNames => _dir();

  bool _filterAttribute(String attribute) {
    if (attribute.startsWith("_")) {
      return false;
    }
    return true;
  }

  void collectChildren() {
    for (final String childName in _childrenNames.where(_filterAttribute)) {
      final result = collectChild(childName);
      print("collected $childName: $result");
    }
  }

  @override
  Interface? collectChild(String childName) =>
      throw UnimplementedError("collectChild: $childName");

  Interface? _collectAttribute(String attribute) {
    if (!hasAttribute(attribute)) {
      print("Warning: $this does not have attribute $attribute");
      return null;
    }
    final Object? value = getAttribute(attribute);
    if (value == null) {
      print("Warning: $this has null attribute $attribute");
      return null;
    }
    if (value is! PythonObjectInterface) {
      final PrimitiveInterface result = PrimitiveInterface(value);
      _children[attribute] = result;
      return result;
    }
    final Interface? cached = _InterfaceCache.instance[value];
    if (cached != null) {
      _children[attribute] = cached;
      return cached;
    }
    final Interface result = switch (value) {
      PythonModuleInterface() => ModuleInterface.from(value),
      PythonClassDefinitionInterface() => ClassDefinitionInterface.from(value),
      PythonClassInterface() => ClassInterface.from(value),
      PythonFunctionInterface() => FunctionInterface.from(value),
      PythonObjectInterface() => ObjectInterface.from(value),
    } as Interface;
    _InterfaceCache.instance[value] = result;
    _children[attribute] = result;
    result.collectChildren();
    return result;
  }

  String emit() => throw UnimplementedError("emit");

  void emitDocstring(StringBuffer buffer) {
    dynamic object = _source;
    final Object? doc = object.__doc__;
    if (doc is String) {
      buffer
        ..writeln("///")
        ..writeln("/// ### python docstring")
        ..writeln(doc.trim().leftPadLines(1, pad: "/// ", trimLines: true));
    }
  }
}
