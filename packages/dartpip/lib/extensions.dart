part of dartpip;

extension _KeyMappingExtension<K, V> on Map<K, V> {
  Map<T, V> mapKeys<T>(T Function(K key) f) =>
      map((K key, V value) => MapEntry<T, V>(f(key), value));
}

extension _ValueMappingExtension<K, V> on Map<K, V> {
  Map<K, T> mapValues<T>(T Function(V value) f) =>
      map((K key, V value) => MapEntry<K, T>(key, f(value)));
}

extension _ToIterableExtension<T> on T? {
  Iterable<T> toIterable() sync* {
    final T? object = this;
    if (object != null) {
      yield object;
    }
  }
}

extension _FutureToIterableExtension<T> on Future<T?> {
  Future<Iterable<T>> toIterable() async => (await this).toIterable();
}
