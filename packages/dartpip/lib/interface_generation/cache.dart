part of interface_generation;

class InterfaceCache {
  InterfaceCache._();

  static final Map<Object, Interface> _cache = <Object, Interface>{};

  static InterfaceCache? _instance;

  static InterfaceCache get instance => _instance ??= InterfaceCache._();

  Object _effectiveKey(Object key) => switch (key) {
        PythonObjectInterface() => key.reference ?? key,
        _ => key,
      };

  Interface? operator [](Object key) {
    final Object effectiveKey = _effectiveKey(key);
    final Interface? result = _cache[effectiveKey];
    print("Getting $effectiveKey from cache: $result");
    return result;
  }

  void operator []=(Object key, Interface value) {
    final Object effectiveKey = _effectiveKey(key);
    print("Setting $effectiveKey in cache: $value");
    _cache[effectiveKey] = value;
  }

  Iterable<ClassDefinitionInterface> get classDefinitions =>
      _cache.values.whereType<ClassDefinitionInterface>();
}
