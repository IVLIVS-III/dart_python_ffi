part of dartpip_solver;

/// A [Future] that is only evaluated once.
class LazyFuture<T> implements Future<T> {
  /// Creates a [LazyFuture] that will evaluate [future] the first time it is
  /// accessed.
  LazyFuture(Future<T> Function() future) : _future = future;

  final Future<T> Function() _future;

  Completer<T>? _completer;

  T? _value;

  FutureOr<T> get _internalValue {
    final T? value = _value;
    if (value != null) {
      return value;
    }
    final Completer<T>? completer = _completer;
    if (completer != null) {
      return completer.future;
    }
    final Completer<T> newCompleter = Completer<T>();
    _completer = newCompleter;
    _future().then((T value) {
      _value = value;
      _completer?.complete(value);
    });
    return newCompleter.future;
  }

  Future<T> get _internalFuture => switch (_internalValue) {
        Future<T>() => _internalValue as Future<T>,
        T() => Future<T>.value(_internalValue),
      };

  @override
  Stream<T> asStream() {
    final FutureOr<T> internalValue = _internalValue;
    if (internalValue is Future<T>) {
      return internalValue.asStream();
    }
    return Stream<T>.value(internalValue);
  }

  @override
  Future<T> catchError(Function onError, {bool Function(Object error)? test}) =>
      _internalFuture.catchError(onError, test: test);

  @override
  Future<R> then<R>(
    FutureOr<R> Function(T value) onValue, {
    Function? onError,
  }) =>
      _internalFuture.then(onValue, onError: onError);

  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout}) =>
      _internalFuture.timeout(timeLimit, onTimeout: onTimeout);

  @override
  Future<T> whenComplete(FutureOr<void> Function() action) =>
      _internalFuture.whenComplete(action);
}
