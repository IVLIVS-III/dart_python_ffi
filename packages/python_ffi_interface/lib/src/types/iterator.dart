part of python_ffi_interface;

/// Represents a Python iterator.
final class PythonIterator<T extends Object?, P extends PythonFfiDelegate<R>,
        R extends Object?> extends PythonClassInterface<P, R>
    implements Iterator<T> {
  /// Creates a new Python iterator.
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

  @override
  T_out getAttribute<T_out extends Object?>(String attributeName) =>
      _iterator.getAttribute<T_out>(attributeName);

  @override
  T_out getAttributeRaw<T_out extends PythonObjectInterface<P, R>>(
    String attributeName,
  ) =>
      _iterator.getAttributeRaw<T_out>(attributeName);

  @override
  PythonFunctionInterface<P, R> getFunction(String name) =>
      _iterator.getFunction(name);

  @override
  bool hasAttribute(String attributeName) =>
      _iterator.hasAttribute(attributeName);

  @override
  void setAttribute<T_in extends Object?>(String attributeName, T_in value) =>
      _iterator.setAttribute(attributeName, value);

  @override
  void setAttributeRaw<T_in extends PythonObjectInterface<P, R>>(
    String attributeName,
    T_in value,
  ) =>
      _iterator.setAttributeRaw(attributeName, value);

  @override
  Object? toDartObject() => this;
}

/// Adds type information to the untyped [PythonIterator].
class TypedIterator<T> implements Iterator<T> {
  /// Creates a new typed iterator from the given untyped iterator.
  TypedIterator.from(this._iterator);

  final Iterator<Object?> _iterator;

  @override
  T get current => _iterator.current as T;

  @override
  bool moveNext() => _iterator.moveNext();
}
