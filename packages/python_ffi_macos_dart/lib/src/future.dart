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
    try {
      for (final Object? element in iterable) {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        print("├── [${DateTime.now()}] $element");
        if (element is Future<Object?>) {
          print("├── [${DateTime.now()}] ⏳ waiting for future");

          if (element is PythonFutureMacos<Object?>) {
            print("├── [${DateTime.now()}] ⏳ future is a python future");
            final PythonFutureMacos<Object?> pythonFuture = element;
            final Completer<T> completer = Completer<T>();
            void doneCallback(Object? result) {
              print("├── [${DateTime.now()}] ⏳ future resolved: $result");
              completer.complete(result as T);
            }

            final PythonFunctionMacos addDoneCallbackFunc =
                pythonFuture.getFunction("add_done_callback");
            print(
              "├── [${DateTime.now()}] ⏳ adding done callback: $doneCallback",
            );
            addDoneCallbackFunc.call(<Object?>[doneCallback.generic1]);
            print("├── [${DateTime.now()}] ⏳ done callback added");
            return completer.future;
          } else {
            print("├── [${DateTime.now()}] ⏳ future is not a python future");
            return element as Future<T>;
          }
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

  // TODO: remove debug prints
  Future<T> _consumeTimer(Iterable<Object?> iterable) async {
    try {
      for (final Object? element in iterable) {
        print("├── [${DateTime.now()}] $element");
        if (element is Future<Object?>) {
          print("├── [${DateTime.now()}] ⏳ waiting for future");

          if (element is PythonFutureMacos<Object?>) {
            print("├── [${DateTime.now()}] ⏳ future is a python future");
            final PythonFutureMacos<Object?> pythonFuture = element;
            final Completer<T> completer = Completer<T>();
            final Timer t = Timer.periodic(
              const Duration(milliseconds: 10),
              (Timer timer) {
                if (timer.tick > 200) {
                  timer.cancel();
                  completer.completeError(
                    Exception("future timed out"),
                  );
                }
                print(
                  "├── [${DateTime.now()}] ⏳ (${timer.tick}) waiting for future",
                );
                final PythonFunctionMacos isDoneFunc =
                    pythonFuture.getFunction("done");
                if (isDoneFunc.call<bool>(<Object?>[])) {
                  print("├── [${DateTime.now()}] ⏳ future is completed");
                  timer.cancel();
                  final PythonFunctionMacos resultFunc =
                      pythonFuture.getFunction("result");
                  completer.complete(resultFunc.call<T>(<Object?>[]));
                }
              },
            );
            return completer.future;
          } else {
            print("├── [${DateTime.now()}] ⏳ future is not a python future");
            return element as Future<T>;
          }
        }
        await Future<void>.delayed(const Duration(milliseconds: 10));
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
    final Future<T> consumeFuture = _consumeTimer(iterable);
    print(
      "├── [${DateTime.now()}] ⏳ waiting for consume future $consumeFuture",
    );
    consumeFuture.then((T value) {
      print("├── [${DateTime.now()}] ⏳ consume future resolved: $value");
      completer.complete(value);
    });
    print(
      "├── [${DateTime.now()}] ⏳ returning completer future ${completer.future}",
    );
    return completer.future;
  }

  @override
  Stream<T> asStream() {
    print("├── [${DateTime.now()}] ⏳ asStream");
    return _future().asStream();
  }

  @override
  Future<T> catchError(Function onError, {bool Function(Object error)? test}) {
    print("├── [${DateTime.now()}] ⏳ catchError");
    return _future().catchError(onError, test: test);
  }

  @override
  Future<R> then<R>(
    FutureOr<R> Function(T value) onValue, {
    Function? onError,
  }) {
    print("├── [${DateTime.now()}] ⏳ then");
    return _future().then((T value) {
      print("├── [${DateTime.now()}] ⏳ then onValue");
      return onValue(value);
    }, onError: onError);
  }

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
