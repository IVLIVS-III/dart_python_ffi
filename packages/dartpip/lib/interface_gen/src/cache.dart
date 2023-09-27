part of interface_gen;

/// Cache for inspection results.
/// This is used to deal with circular references in inspected Python modules.
final class InspectionCache {
  /// Creates a new instance of [InspectionCache].
  InspectionCache();

  final Map<Object?, (int, InspectEntry)> _cache =
      <Object?, (int, InspectEntry)>{};

  Object? _effectiveKey(Object? key) => switch (key) {
        PythonObjectInterface<PythonFfiDelegate<Object?>, Object?>() =>
          key.reference ?? key,
        _ => key,
      };

  int get _nextId => _cache.length;

  /// Retrieves the [InspectEntry] for the given [key].
  /// Returns `null` if no entry exists for the given [key].
  InspectEntry? operator [](Object? key) => _cache[_effectiveKey(key)]?.$2;

  /// Sets or updates the [InspectEntry] for the given [key].
  void operator []=(Object? key, InspectEntry value) {
    // do not cache primitive objects
    if (value is Primitive) {
      return;
    }
    final Object? effectiveKey = _effectiveKey(key);
    final int id = _cache[effectiveKey]?.$1 ?? _nextId;
    _cache[effectiveKey] = (id, value);
  }

  /// Returns the id of the [InspectEntry] for the given [key].
  /// Returns `null` if no entry exists for the given [key].
  int? id(Object? key) => _cache[_effectiveKey(key)]?.$1;

  /// Returns an iterable of all [InspectEntry]s in the cache.
  /// The iterable contains tuples of the form `(id, entry)` where `id` is the
  /// id of the entry and `entry` is the entry itself.
  Iterable<(int, InspectEntry)> get entries => _cache.values;

  Iterable<T> _getOfType<T extends InspectEntry>(InspectEntryType type) =>
      entries
          .where(((int, InspectEntry) e) => e.$2.type == type)
          .map(((int, InspectEntry) e) => e.$2)
          .whereType();

  /// Returns all instances of [Module] from the cache.
  /// They represent inspected Python module objects.
  Iterable<Module> get modules => _getOfType(InspectEntryType.module);

  /// Returns all instances of [ClassDefinition] from the cache.
  /// They represent inspected Python class definitions.
  Iterable<ClassDefinition> get classDefinitions =>
      _getOfType(InspectEntryType.classDefinition);

  /// Returns all instances of [ClassInstance] from the cache.
  /// They represent inspected Python class instances.
  /// They also contain inspected Python objects related to type annotations.
  /// See [typedefs] for getting only those instances.
  Iterable<ClassInstance> get classes => _getOfType(InspectEntryType.class_);

  /// Returns some instances of [ClassInstance] from the cache.
  /// They represent inspected Python objects related to type annotations.
  /// In particular, this returns `typing.TypeVar` and `typing.Union` instances.
  Iterable<ClassInstance> get typedefs => classes.where(types.isType);

  /// Returns all instances of [Function_] from the cache.
  /// They represent inspected Python function objects.
  Iterable<Function_> get functions => _getOfType(InspectEntryType.function);

  /// Returns all instances of [Object_] from the cache.
  /// They represent inspected Python objects that are not of any other type.
  Iterable<Object_> get objects => _getOfType(InspectEntryType.object);
}
