part of python_ffi_platform_interface;

abstract class PythonObjectPlatform<P extends PythonFfiPlatform<R>,
        R extends Object?> extends PlatformInterface
    implements PythonObjectInterface<P, R> {
  PythonObjectPlatform(this.platform, this.reference) : super(token: _token);

  @override
  final P platform;

  @override
  final R reference;

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
}
