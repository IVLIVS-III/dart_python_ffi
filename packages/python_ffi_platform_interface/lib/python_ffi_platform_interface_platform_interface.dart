import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'python_ffi_platform_interface_method_channel.dart';

abstract class PythonFfiPlatformInterfacePlatform extends PlatformInterface {
  /// Constructs a PythonFfiPlatformInterfacePlatform.
  PythonFfiPlatformInterfacePlatform() : super(token: _token);

  static final Object _token = Object();

  static PythonFfiPlatformInterfacePlatform _instance = MethodChannelPythonFfiPlatformInterface();

  /// The default instance of [PythonFfiPlatformInterfacePlatform] to use.
  ///
  /// Defaults to [MethodChannelPythonFfiPlatformInterface].
  static PythonFfiPlatformInterfacePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PythonFfiPlatformInterfacePlatform] when
  /// they register themselves.
  static set instance(PythonFfiPlatformInterfacePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
