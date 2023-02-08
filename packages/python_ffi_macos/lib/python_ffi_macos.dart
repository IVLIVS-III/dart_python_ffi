library python_ffi_macos;

import "dart:async";
import "dart:io";

import "package:flutter/services.dart";
import "package:path_provider/path_provider.dart" as path_provider;
import "package:python_ffi_macos_dart/python_ffi_macos_dart.dart";
import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";

// const String _libName = "libpython3.11";
const String _libPath =
    "/Library/Frameworks/Python.framework/Versions/3.11/Python";

/// The macOS implementation of [PythonFfiPlatform].
class PythonFfiMacOS extends PythonFfiMacOSBase
    with PythonFfiMacOSMixin
    implements PythonFfiPlatform<Pointer<PyObject>> {
  /// Registers this class as the default instance of [PythonFfiPlatform].
  static void registerWith() {
    PythonFfiPlatform.instance = PythonFfiMacOS();
  }

  @override
  Future<Directory> getApplicationSupportDirectory() async =>
      path_provider.getApplicationSupportDirectory();

  @override
  Future<ByteData> loadPythonFile(String path) async =>
      PlatformAssetBundle().load(path);
}
