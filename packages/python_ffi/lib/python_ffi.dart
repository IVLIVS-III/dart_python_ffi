// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";

class PythonFfi {
  PythonFfi._() {
    PythonFfiPlatform.instance.initialize();
  }

  static PythonFfi? _instance;

  static PythonFfi get instance {
    _instance ??= PythonFfi._();
    return _instance!;
  }

  Future<PythonModulePlatform> importModule(String name) async =>
      PythonFfiPlatform.instance.importModule(name);

  Future<void> appendToPath(String path) async {
    await PythonFfiPlatform.instance.appendToPath(path);
  }

  void helloWorld() {
    PythonFfiPlatform.instance.helloWorld();
  }
}
