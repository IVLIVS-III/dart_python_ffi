part of dartpip;

extension _KeyMappingExtension<K, V> on Map<K, V> {
  Map<T, V> mapKeys<T>(T Function(K key) f) =>
      map((K key, V value) => MapEntry<T, V>(f(key), value));
}

extension _ValueMappingExtension<K, V> on Map<K, V> {
  Map<K, T> mapValues<T>(T Function(V value) f) =>
      map((K key, V value) => MapEntry<K, T>(key, f(value)));
}

/// Adds a 'name' getter to each [FileSystemEntity].
extension NameExtension on FileSystemEntity {
  /// Returns the name of this [FileSystemEntity].
  String get name => path.split(Platform.pathSeparator).last;
}
