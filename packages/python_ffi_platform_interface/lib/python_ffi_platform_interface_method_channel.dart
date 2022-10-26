import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'python_ffi_platform_interface_platform_interface.dart';

/// An implementation of [PythonFfiPlatformInterfacePlatform] that uses method channels.
class MethodChannelPythonFfiPlatformInterface extends PythonFfiPlatformInterfacePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('python_ffi_platform_interface');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
