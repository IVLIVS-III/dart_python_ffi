extension KeyMappingExtension<K, V> on Map<K, V> {
  Map<T, V> mapKeys<T>(
    T Function(K key) f,
  ) =>
      map((K key, V value) => MapEntry<T, V>(f(key), value));
}

extension ValueMappingExtension<K, V> on Map<K, V> {
  Map<K, T> mapValues<T>(
    T Function(V value) f,
  ) =>
      map((K key, V value) => MapEntry<K, T>(key, f(value)));
}

extension CamelCaseExtension on String {
  String get camelCase {
    final List<String> parts = split("_");
    final String firstPart = parts.first;
    final List<String> restParts = parts.sublist(1);

    return <String>[
      firstPart,
      ...restParts.map((String part) => part.capitalize()),
    ].join();
  }

  String capitalize() =>
      isEmpty ? this : "${this[0].toUpperCase()}${substring(1)}";
}
