part of python_ffi_interface;

class PythonIterator<T extends Object?, P extends PythonFfiDelegate<R>,
        R extends Object?> extends PythonClassInterface<P, R>
    implements Iterator<T> {
  PythonIterator(this._iterator)
      : super(
          _iterator.platform,
          _iterator.reference,
          initializer: _iterator.initializer,
          finalizer: _iterator.finalizer,
        );

  final PythonObjectInterface<P, R> _iterator;

  T? _current;

  @override
  T get current {
    final T? current = _current;
    if (current == null) {
      throw StateError("No current element: call moveNext() first.");
    }
    return current;
  }

  @override
  bool moveNext() {
    try {
      _current = _iterator.getFunction("__next__").call(<Object?>[]) as T;
      return true;
    } on PythonExceptionInterface<P, R> catch (e) {
      if (e.type == "StopIteration") {
        return false;
      } else {
        rethrow;
      }
    }
  }
}

class TypedIterator<T> implements Iterator<T> {
  TypedIterator.from(this._iterator);

  final Iterator<Object?> _iterator;

  @override
  T get current => _iterator.current as T;

  @override
  bool moveNext() => _iterator.moveNext();
}
