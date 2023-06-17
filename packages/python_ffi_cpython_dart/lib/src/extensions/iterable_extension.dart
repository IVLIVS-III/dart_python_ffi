/// Extension to add a single element to an iterable.
extension IterableExtension<T> on Iterable<T> {
  /// Adds a single element to an iterable.
  Iterable<T> add(T element) sync* {
    yield* this;
    yield element;
  }
}
