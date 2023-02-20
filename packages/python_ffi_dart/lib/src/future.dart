part of python_ffi_dart;

class PythonFuture<T> extends PythonObject implements Future<T> {
  PythonFuture.from(this._futureDelegate) : super.from(_futureDelegate);

  final PythonFutureInterface<T, PythonFfiDelegate<Object?>, Object?>
      _futureDelegate;

  @override
  Stream<T> asStream() => _futureDelegate.asStream();

  @override
  Future<T> catchError(Function onError, {bool Function(Object error)? test}) =>
      _futureDelegate.catchError(onError, test: test);

  @override
  Future<R> then<R>(
    FutureOr<R> Function(T value) onValue, {
    Function? onError,
  }) =>
      _futureDelegate.then(onValue, onError: onError);

  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout}) =>
      _futureDelegate.timeout(timeLimit, onTimeout: onTimeout);

  @override
  Future<T> whenComplete(FutureOr<void> Function() action) =>
      _futureDelegate.whenComplete(action);

  Future<R> cast<R extends Object?>() =>
      PythonFuture<R>.from(_futureDelegate.cast());
}
