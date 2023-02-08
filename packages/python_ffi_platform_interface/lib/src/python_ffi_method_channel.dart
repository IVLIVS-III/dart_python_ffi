import "dart:async";

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
  bool get isInitialized => false;

  @override
  Future<void> initialize() async {
    await methodChannel.invokeMethod<void>("initialize");
  }

  @override
  void addClassName(String className) {
    throw UnimplementedError("addClassName() has not been implemented.");
  }

  @override
  void removeClassName(String className) {
    throw UnimplementedError("addClassName() has not been implemented.");
  }

  @override
  FutureOr<void> appendToPath(String path) {
    // TODO: implement appendToPath
    throw UnimplementedError();
  }

  @override
  void ensureNoPythonError() {
    // TODO: implement ensureNoPythonError
  }

  @override
  PythonClassInterface<PythonFfiDelegate<Object?>, Object?> importClass(
    String moduleName,
    String className,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) {
    // TODO: implement importClass
    throw UnimplementedError();
  }

  @override
  PythonModuleInterface<PythonFfiDelegate<Object?>, Object?> importModule(
    String moduleName,
  ) {
    // TODO: implement importModule
    throw UnimplementedError();
  }

  @override
  FutureOr<void> prepareModule(PythonModuleDefinition moduleDefinition) {
    // TODO: implement prepareModule
    throw UnimplementedError();
  }

  @override
  bool pythonErrorOccurred() {
    // TODO: implement pythonErrorOccurred
    throw UnimplementedError();
  }

  @override
  void pythonErrorPrint() {
    // TODO: implement pythonErrorPrint
  }
}
