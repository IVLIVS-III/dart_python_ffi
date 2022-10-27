import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:python_ffi_platform_interface/python_ffi_method_channel.dart';

abstract class PythonFfiPlatform extends PlatformInterface {
  /// Constructs a PythonFfiPlatform.
  PythonFfiPlatform() : super(token: _token);

  static final Object _token = Object();

  static PythonFfiPlatform _instance = MethodChannelPythonFfi();

  /// The default instance of [PythonFfiPlatform] to use.
  ///
  /// Defaults to [MethodChannelPythonFfi].
  static PythonFfiPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PythonFfiPlatform] when
  /// they register themselves.
  static set instance(PythonFfiPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> initialize() async {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  void helloWorld() {
    throw UnimplementedError('helloWorld() has not been implemented.');
  }
}
