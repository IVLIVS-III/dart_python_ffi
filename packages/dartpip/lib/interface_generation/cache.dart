part of interface_generation;

class _InterfaceCache {
  _InterfaceCache._();

  static final Map<Object, Interface> _cache = <Object, Interface>{};

  static _InterfaceCache? _instance;

  static _InterfaceCache get instance => _instance ??= _InterfaceCache._();

  Object _effectiveKey(Object key) => switch (key) {
        PythonObjectInterface() => key.reference ?? key,
        _ => key,
      };

  Interface? operator [](Object key) => _cache[_effectiveKey(key)];

  void operator []=(Object key, Interface value) =>
      _cache[_effectiveKey(key)] = value;

  Iterable<ClassDefinitionInterface> get classDefinitions =>
      _cache.values.whereType();

  Iterable<ClassInterface> get classes => _cache.values.whereType();
}
