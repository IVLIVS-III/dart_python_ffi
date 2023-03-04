part of python_ffi_macos_dart;

class PythonFutureMacos<T>
    extends PythonFutureInterface<T, PythonFfiMacOSBase, Pointer<PyObject>>
    with _PythonObjectMacosMixin {
  PythonFutureMacos(super.platform, super.reference)
      : super(
          initializer: _PythonObjectMacosRefcountUtil.initializer,
          finalizer: _PythonObjectMacosRefcountUtil.finalizer,
        );

  Future<T> _consume(Iterable<Object?> iterable) async {
    // TODO: implement _consume. This should mirror somewhat python Task.__step
    //       set the add_done_callback on the first future we get
    try {
      for (final Object? element in iterable) {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        print("├── $element");
        if (element is Future<Object?>) {
          print("├── ⏳ waiting for future");
          await element;
        }
      }
    } on _PythonExceptionMacos catch (e) {
      switch (e.type) {
        case "StopIteration":
          print("└── ⏹️ stop iteration");
          return e.value as T;
        default:
          rethrow;
      }
    } on Exception catch (e) {
      print("└── ❌ error: $e");
      rethrow;
    }
    final T result = getFunction("result").call(<Object?>[]);
    return result;
  }

  void _startEventLoop() {
    final PythonModuleInterface<PythonFfiDelegate<Pointer<PyObject>>,
        Pointer<PyObject>> asyncio = platform.importModule("asyncio.events");
    final Object? loop = asyncio.getFunction("new_event_loop").call(
      <Object?>[],
    );
    asyncio.getFunction("set_event_loop").call(<Object?>[loop]);
    asyncio.getFunction("_set_running_loop").call(<Object?>[loop]);
  }

  Future<T> _future() {
    final Completer<T> completer = Completer<T>();
    _startEventLoop();
    final Iterable<Object?> iterable =
        getFunction("__await__").call(<Object?>[]);
    _consume(iterable).then(completer.complete);
    return completer.future;
  }

  @override
  Stream<T> asStream() => _future().asStream();

  @override
  Future<T> catchError(Function onError, {bool Function(Object error)? test}) =>
      _future().catchError(onError, test: test);

  @override
  Future<R> then<R>(
    FutureOr<R> Function(T value) onValue, {
    Function? onError,
  }) =>
      _future().then(onValue, onError: onError);

  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout}) =>
      _future().timeout(timeLimit, onTimeout: onTimeout);

  @override
  Future<T> whenComplete(FutureOr<void> Function() action) =>
      _future().whenComplete(action);

  @override
  PythonFutureInterface<S, PythonFfiMacOSBase, Pointer<PyObject>>
      cast<S extends Object?>() => PythonFutureMacos<S>(platform, reference);
}
