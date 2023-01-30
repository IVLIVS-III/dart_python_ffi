part of python_ffi_dart;

abstract class PythonObject
    extends PythonObjectPlatform<PythonFfiPlatform<Object?>, Object?> {
  PythonObject.from(this._delegate)
      : super(_delegate.platform, _delegate.reference) {
    PythonObjectPlatform.verify(_delegate);
  }

  final PythonObjectPlatform<PythonFfiPlatform<Object?>, Object?> _delegate;

  @override
  Object? toDartObject() => _delegate.toDartObject();

  @override
  T getAttributeRaw<
          T extends PythonObjectPlatform<PythonFfiPlatform<Object?>,
              Object?>>(String attributeName) =>
      _delegate.getAttributeRaw(attributeName);

  @override
  T getAttribute<T extends Object?>(String attributeName) =>
      _delegate.getAttribute(attributeName);

  @override
  void setAttributeRaw<
          T extends PythonObjectPlatform<PythonFfiPlatform<Object?>,
              Object?>>(String attributeName, T value) =>
      _delegate.setAttributeRaw(attributeName, value);

  @override
  void setAttribute<T extends Object?>(String attributeName, T value) =>
      _delegate.setAttribute(attributeName, value);

  @override
  void dispose() {
    _delegate.dispose();
  }

  @override
  Object? noSuchMethod(Invocation invocation) {
    try {
      return _delegate.noSuchMethod(invocation);
    } on Exception catch (_) {}
    return super.noSuchMethod(invocation);
  }
}
