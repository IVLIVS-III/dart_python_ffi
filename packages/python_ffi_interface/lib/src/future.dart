part of python_ffi_interface;

abstract class PythonFutureInterface<T extends Object?,
        P extends PythonFfiDelegate<R>, R extends Object?>
    extends PythonObjectInterface<P, R> implements Future<T> {
  PythonFutureInterface(
    super.delegate,
    super.reference, {
    required super.initializer,
    required super.finalizer,
  });

  PythonFutureInterface<S, P, R> cast<S extends Object?>();
}

abstract class PythonFfiAwaitableInterface<T extends Object?,
    P extends PythonFfiDelegate<R>, R extends Object?> {
  bool Function() get isDone;

  T Function() get result;
}
