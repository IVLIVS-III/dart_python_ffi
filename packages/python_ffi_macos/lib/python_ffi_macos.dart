import "dart:ffi";
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import "package:python_ffi_macos/src/ffi/generated_bindings.g.dart";
import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";

// const String _libName = "libpython3.11";
const String _libPath =
    "/Library/Frameworks/Python.framework/Versions/3.11/Python";

/// The macOS implementation of [PythonFfiPlatform].
class PythonFfiMacOS extends PythonFfiPlatform {
  /// Registers this class as the default instance of [PythonFfiPlatform].
  static void registerWith() {
    PythonFfiPlatform.instance = PythonFfiMacOS();
  }

  DartPythonCBindings? _bindings;

  DartPythonCBindings get bindings {
    if (_bindings == null) {
      throw Exception("PythonFfiMacOS not initialized");
    }
    return _bindings!;
  }

  bool get isInitialized => _bindings != null;

  /// Checks whether the python runtime was initialized
  bool get pyInitialized => bindings.Py_IsInitialized() != 0;

  // Attempt to bundle the python library with the app via flutter assets.
  /*
  Future<void> _copyDylib() async {
    const String dylibAssetPath =
        "packages/python_ffi_macos/assets/$_libName.dylib";
    final ByteData dylibAsset =
        await PlatformAssetBundle().load(dylibAssetPath);

    final Directory supportDir = await getApplicationSupportDirectory();
    final File dylibFile = File("${supportDir.path}/python/$_libName.dylib");
    if (!dylibFile.existsSync()) {
      dylibFile.createSync(recursive: true);
    }

    await dylibFile.writeAsBytes(dylibAsset.buffer.asUint8List());

    final DynamicLibrary dylib = DynamicLibrary.open(dylibFile.path);
    _bindings = DartPythonCBindings(dylib);
  }
  */

  void _openDylib() {
    final DynamicLibrary dylib = DynamicLibrary.open(_libPath);
    _bindings = DartPythonCBindings(dylib);
  }

  Future<void> _copyModule(String moduleName) async {
    final Directory supportDir = await getApplicationSupportDirectory();
    final File moduleFile =
        File("${supportDir.path}/python_ffi/packages/$moduleName.py");
    if (!moduleFile.existsSync()) {
      moduleFile.createSync(recursive: true);
    }

    final ByteData moduleAsset =
        await PlatformAssetBundle().load("python-modules/$moduleName.py");
    await moduleFile.writeAsBytes(moduleAsset.buffer.asUint8List());

    print("Copied module $moduleName to ${moduleFile.path}");
  }

  @override
  Future<void> initialize() async {
    if (!isInitialized) {
      _openDylib();
    }

    await _copyModule("hello_world");

    bindings.Py_Initialize();
  }

  @override
  void helloWorld() {
    // TODO: implement helloWorld
    super.helloWorld();
  }
}
