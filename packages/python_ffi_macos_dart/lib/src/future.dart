part of python_ffi_macos_dart;

class PythonFutureMacos<T>
    extends PythonFutureInterface<T, PythonFfiMacOSBase, Pointer<PyObject>>
    with _PythonObjectMacosMixin {
  PythonFutureMacos(super.platform, super.reference)
      : super(
          initializer: _PythonObjectMacosRefcountUtil.initializer,
          finalizer: _PythonObjectMacosRefcountUtil.finalizer,
        );

  @override
  Stream<T> asStream() {
    // TODO: implement asStream
    throw UnimplementedError("asStream() is not implemented yet");
  }

  @override
  Future<T> catchError(Function onError, {bool Function(Object error)? test}) {
    // TODO: implement catchError
    throw UnimplementedError("catchError() is not implemented yet");
  }

  @override
  Future<R> then<R>(
    FutureOr<R> Function(T value) onValue, {
    Function? onError,
  }) {
    // TODO: implement then
    throw UnimplementedError("then() is not implemented yet");
  }

  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout}) {
    // TODO: implement timeout
    throw UnimplementedError("timeout() is not implemented yet");
  }

  @override
  Future<T> whenComplete(FutureOr<void> Function() action) {
    // TODO: implement whenComplete
    throw UnimplementedError("whenComplete() is not implemented yet");
  }

  @override
  PythonFutureInterface<S, PythonFfiMacOSBase, Pointer<PyObject>>
      cast<S extends Object?>() {
    // TODO: implement cast
    throw UnimplementedError("cast() is not implemented yet");
  }
}
