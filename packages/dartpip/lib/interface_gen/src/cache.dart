part of interface_gen;

final class InspectionCache {
  InspectionCache._();

  static final Map<Object?, (int, InspectEntry)> _cache =
      <Object?, (int, InspectEntry)>{};

  static InspectionCache? _instance;

  static InspectionCache get instance => _instance ??= InspectionCache._();

  Object? _effectiveKey(Object? key) => switch (key) {
        PythonObjectInterface() => key.reference ?? key,
        _ => key,
      };

  int get _nextId => _cache.length;

  InspectEntry? operator [](Object? key) => _cache[_effectiveKey(key)]?.$2;

  void operator []=(Object? key, InspectEntry value) {
    // do not cache primitive objects
    if (value is Primitive) {
      return;
    }
    final Object? effectiveKey = _effectiveKey(key);
    final int id = _cache[effectiveKey]?.$1 ?? _nextId;
    _cache[effectiveKey] = (id, value);
  }

  int? id(Object? key) => _cache[_effectiveKey(key)]?.$1;

  Iterable<(int, InspectEntry)> get entries => _cache.values;

  Iterable<T> _getOfType<T extends InspectEntry>(InspectEntryType type) =>
      entries
          .where(((int, InspectEntry) e) => e.$2.type == type)
          .map(((int, InspectEntry) e) => e.$2)
          .whereType();

  Iterable<Module> get modules => _getOfType(InspectEntryType.module);

  Iterable<ClassDefinition> get classDefinitions =>
      _getOfType(InspectEntryType.classDefinition);

  Iterable<ClassInstance> get classes => _getOfType(InspectEntryType.class_);

  Iterable<ClassInstance> get typedefs => classes.where(types.isType);

  Iterable<Function_> get functions => _getOfType(InspectEntryType.function);

  Iterable<Object_> get objects => _getOfType(InspectEntryType.object);
}
