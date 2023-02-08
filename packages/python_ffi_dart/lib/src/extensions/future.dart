part of python_ffi_dart;

extension FutureOrExtension<T> on FutureOr<T> {
  Future<T> get asFuture => Future<T>.value(this);
}
