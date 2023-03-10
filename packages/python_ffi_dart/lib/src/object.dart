part of python_ffi_dart;

abstract class PythonObject
    extends PythonObjectInterface<PythonFfiDelegate<Object?>, Object?> {
  PythonObject.from(this._delegate)
      : super(
          _delegate.platform,
          _delegate.reference,
          initializer: _delegate.initializer,
          finalizer: _delegate.finalizer,
        ) {
    PythonObjectInterface.verify(_delegate);
  }

  final PythonObjectInterface<PythonFfiDelegate<Object?>, Object?> _delegate;

  @override
  PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?> getFunction(
    String name,
  ) =>
      _delegate.getFunction(name);

  @override
  Object? toDartObject() => _delegate.toDartObject();

  @override
  bool hasAttribute(String attributeName) =>
      _delegate.hasAttribute(attributeName);

  @override
  T getAttributeRaw<
          T extends PythonObjectInterface<PythonFfiDelegate<Object?>,
              Object?>>(String attributeName) =>
      _delegate.getAttributeRaw(attributeName);

  @override
  T getAttribute<T extends Object?>(String attributeName) =>
      _delegate.getAttribute(attributeName);

  @override
  void setAttributeRaw<
          T extends PythonObjectInterface<PythonFfiDelegate<Object?>,
              Object?>>(String attributeName, T value) =>
      _delegate.setAttributeRaw(attributeName, value);

  @override
  void setAttribute<T extends Object?>(String attributeName, T value) =>
      _delegate.setAttribute(attributeName, value);

/*
  @override
  Object? noSuchMethod(Invocation invocation) {
    try {
      return _delegate.noSuchMethod(invocation);
    } on Exception catch (_) {}
    return super.noSuchMethod(invocation);
  }
  */
}
