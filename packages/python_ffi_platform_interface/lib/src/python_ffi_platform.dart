import "dart:async";

import "package:plugin_platform_interface/plugin_platform_interface.dart";
import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";
import "package:python_ffi_platform_interface/src/python_ffi_method_channel.dart";

abstract class PythonFfiPlatform<R extends Object?> extends PlatformInterface {
  /// Constructs a PythonFfiPlatform.
  PythonFfiPlatform() : super(token: _token);

  static final Object _token = Object();

  static PythonFfiPlatform<Object?> _instance = MethodChannelPythonFfi();

  /// The default instance of [PythonFfiPlatform] to use.
  ///
  /// Defaults to [MethodChannelPythonFfi].
  static PythonFfiPlatform<Object?> get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PythonFfiPlatform] when
  /// they register themselves.
  static set instance(PythonFfiPlatform<Object?> instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Checks whether the Python runtime was initialized
  bool get isInitialized;

  /// Initializes the native platform Python runtime
  FutureOr<void> initialize() async {
    throw UnimplementedError("initialize() has not been implemented.");
  }

  /// Checks whether an exception occurred in python
  // TODO: return a proper python exception object
  bool pythonErrorOccurred() {
    throw UnimplementedError("pythonErrorOccurred() has not been implemented.");
  }

  /// Prints the current python exception
  void pythonErrorPrint() {
    throw UnimplementedError("pythonErrorPrint() has not been implemented.");
  }

  /// Throws a dart exception if an exception occurred in python
  void ensureNoPythonError() {
    throw UnimplementedError("ensureNoPythonError() has not been implemented.");
  }

  /// Imports a Python module.
  /// The module must be builtin or bundled with the app via flutter assets.
  PythonModulePlatform<PythonFfiPlatform<R>, R> importModule(
    String moduleName,
  ) {
    throw UnimplementedError("importModule() has not been implemented.");
  }

  /// Imports a Python class from the specified module.
  PythonClassPlatform<PythonFfiPlatform<R>, R> importClass(
    String moduleName,
    String className,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) {
    throw UnimplementedError("importClass() has not been implemented.");
  }

  /// Appends a path to the Python sys.path
  FutureOr<void> appendToPath(String path) async {
    throw UnimplementedError("appendToPath() has not been implemented.");
  }
}
