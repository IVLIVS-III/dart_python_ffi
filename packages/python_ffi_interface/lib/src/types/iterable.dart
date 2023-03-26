part of python_ffi_interface;

/// Represents a Python iterable.
class PythonIterable<T extends Object?, P extends PythonFfiDelegate<R>,
        R extends Object?> extends PythonClassInterface<P, R>
    with IterableMixin<T>
    implements Iterable<T> {
  /// Creates a new Python iterable.
  PythonIterable(this._iterable)
      : super(
          _iterable.platform,
          _iterable.reference,
          initializer: _iterable.initializer,
          finalizer: _iterable.finalizer,
        );

  final PythonObjectInterface<P, R> _iterable;

  @override
  Iterator<T> get iterator => PythonIterator<T, P, R>(
        _iterable.getFunction("__iter__").call(<Object?>[]),
      );

  @override
  T_out getAttribute<T_out extends Object?>(String attributeName) =>
      _iterable.getAttribute<T_out>(attributeName);

  @override
  T_out getAttributeRaw<T_out extends PythonObjectInterface<P, R>>(
    String attributeName,
  ) =>
      _iterable.getAttributeRaw<T_out>(attributeName);

  @override
  PythonFunctionInterface<P, R> getFunction(String name) =>
      _iterable.getFunction(name);

  @override
  bool hasAttribute(String attributeName) =>
      _iterable.hasAttribute(attributeName);

  @override
  void setAttribute<T_in extends Object?>(String attributeName, T_in value) =>
      _iterable.setAttribute(attributeName, value);

  @override
  void setAttributeRaw<T_in extends PythonObjectInterface<P, R>>(
    String attributeName,
    T_in value,
  ) =>
      _iterable.setAttributeRaw(attributeName, value);

  @override
  Object? toDartObject() => this;
}

/// Adds type information to the untyped [PythonIterable].
class TypedIterable<T> with IterableMixin<T> implements Iterable<T> {
  /// Creates a new typed iterable from the given untyped iterable.
  TypedIterable.from(this._iterable);

  final Iterable<Object?> _iterable;

  @override
  Iterator<T> get iterator => TypedIterator<T>.from(_iterable.iterator);
}
