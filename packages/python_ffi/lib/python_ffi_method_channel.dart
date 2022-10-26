import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'python_ffi_platform_interface.dart';

/// An implementation of [PythonFfiPlatform] that uses method channels.
class MethodChannelPythonFfi extends PythonFfiPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('python_ffi');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
