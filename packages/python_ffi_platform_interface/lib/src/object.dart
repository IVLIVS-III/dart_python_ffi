part of python_ffi_platform_interface;

abstract class PythonObjectPlatform<P extends PythonFfiPlatform<R>,
    R extends Object?> extends PlatformInterface {
  PythonObjectPlatform(this.platform, this.reference) : super(token: _token);

  static final Object _token = Object();

  /// Throws an [AssertionError] if [instance] does not extend
  /// [PythonObjectPlatform].
  ///
  /// This is used by the app-facing [PythonObject] to ensure that
  /// the object in which it's going to delegate calls has been
  /// constructed properly.
  static void verify(PythonObjectPlatform<Object?, Object?> instance) {
    PlatformInterface.verify(instance, _token);
  }

  final P platform;
  final R reference;

  Object? toDartObject();

  T getAttributeRaw<T extends PythonObjectPlatform<P, R>>(String attributeName);

  T getAttribute<T extends Object?>(String attributeName);

  void setAttributeRaw<T extends PythonObjectPlatform<P, R>>(
    String attributeName,
    T value,
  );

  void setAttribute<T extends Object?>(String attributeName, T value);

  /// Disposes the python object
  @mustCallSuper
  void dispose();

  @override
  @mustCallSuper
  dynamic noSuchMethod(Invocation invocation);
}
