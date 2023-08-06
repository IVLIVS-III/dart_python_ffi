part of interface_gen;

/// TODO: Document.
final class InspectionCache {
  /// TODO: Document.
  InspectionCache();

  final Map<Object?, (int, InspectEntry)> _cache =
      <Object?, (int, InspectEntry)>{};

  Object? _effectiveKey(Object? key) => switch (key) {
        PythonObjectInterface<PythonFfiDelegate<Object?>, Object?>() =>
          key.reference ?? key,
        _ => key,
      };

  int get _nextId => _cache.length;

  /// TODO: Document.
  InspectEntry? operator [](Object? key) => _cache[_effectiveKey(key)]?.$2;

  /// TODO: Document.
  void operator []=(Object? key, InspectEntry value) {
    // do not cache primitive objects
    if (value is Primitive) {
      return;
    }
    final Object? effectiveKey = _effectiveKey(key);
    final int id = _cache[effectiveKey]?.$1 ?? _nextId;
    _cache[effectiveKey] = (id, value);
  }

  /// TODO: Document.
  int? id(Object? key) => _cache[_effectiveKey(key)]?.$1;

  /// TODO: Document.
  Iterable<(int, InspectEntry)> get entries => _cache.values;

  Iterable<T> _getOfType<T extends InspectEntry>(InspectEntryType type) =>
      entries
          .where(((int, InspectEntry) e) => e.$2.type == type)
          .map(((int, InspectEntry) e) => e.$2)
          .whereType();

  /// TODO: Document.
  Iterable<Module> get modules => _getOfType(InspectEntryType.module);

  /// TODO: Document.
  Iterable<ClassDefinition> get classDefinitions =>
      _getOfType(InspectEntryType.classDefinition);

  /// TODO: Document.
  Iterable<ClassInstance> get classes => _getOfType(InspectEntryType.class_);

  /// TODO: Document.
  Iterable<ClassInstance> get typedefs => classes.where(types.isType);

  /// TODO: Document.
  Iterable<Function_> get functions => _getOfType(InspectEntryType.function);

  /// TODO: Document.
  Iterable<Object_> get objects => _getOfType(InspectEntryType.object);
}
