import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";

/// An implementation of [PythonFfiPlatformInterfacePlatform] that uses method channels.
class MethodChannelPythonFfi extends PythonFfiPlatform<Object?> {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel methodChannel =
      const MethodChannel("dartpythonffi.ivlivs.dev/python_ffi");

  @override
  Future<void> initialize() async {
    await methodChannel.invokeMethod<void>("initialize");
  }
}
