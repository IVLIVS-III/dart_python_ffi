part of python_ffi_interface;

class PythonIterable<T extends Object?, P extends PythonFfiDelegate<R>,
    R extends Object?> extends Iterable<T> {
  PythonIterable(this._iterable);

  final PythonObjectInterface<P, R> _iterable;

  @override
  Iterator<T> get iterator => PythonIterator<T, P, R>(
        _iterable.getFunction("__iter__").call(<Object?>[]),
      );
}

class TypedIterable<T> extends Iterable<T> {
  TypedIterable.from(this._iterable);

  final Iterable<Object?> _iterable;

  @override
  Iterator<T> get iterator => TypedIterator<T>.from(_iterable.iterator);
}
