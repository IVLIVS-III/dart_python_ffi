part of dartpip;

extension _KeyMappingExtension<K, V> on Map<K, V> {
  Map<T, V> mapKeys<T>(
    T Function(K key) f,
  ) =>
      map((K key, V value) => MapEntry<T, V>(f(key), value));
}

extension _ValueMappingExtension<K, V> on Map<K, V> {
  Map<K, T> mapValues<T>(
    T Function(V value) f,
  ) =>
      map((K key, V value) => MapEntry<K, T>(key, f(value)));
}
