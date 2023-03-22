part of python_ffi_interface;

extension FutureOrExtension<T> on FutureOr<T> {
  Future<T> get asFuture => Future<T>.value(this);

  static FutureOr<Iterable<T>> wait<T>(Iterable<FutureOr<T>> futures) {
    final List<FutureOr<T>> futuresList = futures.toList();
    if (futuresList.whereType<Future<T>>().isNotEmpty) {
      return Future.wait(futuresList.map((FutureOr<T> e) => e.asFuture));
    }
    return futuresList.map((FutureOr<T> e) => e as T);
  }
}
