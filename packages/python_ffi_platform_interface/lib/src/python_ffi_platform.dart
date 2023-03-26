part of python_ffi_platform_interface;

abstract class PythonFfiPlatform<R extends Object?> extends PlatformInterface
    implements PythonFfiDelegate<R> {
  /// Constructs a PythonFfiPlatform.
  PythonFfiPlatform() : super(token: _token);

  static final Object _token = Object();

  static late PythonFfiPlatform<Object?> _instance;

  /// The default instance of [PythonFfiPlatform] to use.
  ///
  /// No default exists, so this must be set before using the plugin.
  /// This is set by the Flutter engine when it's available.
  static PythonFfiPlatform<Object?> get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PythonFfiPlatform] when
  /// they register themselves.
  static set instance(PythonFfiPlatform<Object?> instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }
}
