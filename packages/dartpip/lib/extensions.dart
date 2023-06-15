part of dartpip;

extension _KeyMappingExtension<K, V> on Map<K, V> {
  Map<T, V> mapKeys<T>(T Function(K key) f) =>
      map((K key, V value) => MapEntry<T, V>(f(key), value));
}

extension _ValueMappingExtension<K, V> on Map<K, V> {
  Map<K, T> mapValues<T>(T Function(V value) f) =>
      map((K key, V value) => MapEntry<K, T>(key, f(value)));
}

extension _ConvertExtension<T> on FutureOr<T> {
  Future<T> asFuture() {
    if (this is Future<T>) {
      return this as Future<T>;
    }
    return Future<T>.value(this as T);
  }
}

extension _SymbolToNameExtension on Symbol {
  String get name =>
      RegExp(r'^Symbol\("(.*)"\)$').firstMatch(toString())?.group(1) ??
      toString();
}
