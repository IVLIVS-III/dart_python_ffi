part of python_ffi_interface;

/// Extension class to bring the [Future.wait] method to [FutureOr].
///
/// This is necessary because [Future.wait] only accepts [Iterable<Future<T>>].
extension FutureOrExtension<T> on FutureOr<T> {
  /// Returns a [Future] that completes with the value of this [FutureOr].
  Future<T> get asFuture => Future<T>.value(this);

  /// Returns a [Future] that completes with the values of the given
  /// [Iterable<FutureOr<T>>].
  ///
  /// This mirrors the [Future.wait] method, but accepts [Iterable<FutureOr<T>>].
  static FutureOr<Iterable<T>> wait<T>(Iterable<FutureOr<T>> futures) {
    final List<FutureOr<T>> futuresList = futures.toList();
    if (futuresList.whereType<Future<T>>().isNotEmpty) {
      return Future.wait(futuresList.map((FutureOr<T> e) => e.asFuture));
    }
    return futuresList.map((FutureOr<T> e) => e as T);
  }
}
