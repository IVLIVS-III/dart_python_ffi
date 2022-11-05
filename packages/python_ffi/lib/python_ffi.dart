// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import "dart:async";

import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";

/*
typedef PythonModule
    = PythonModulePlatform<PythonFfiPlatform<Object?>, Object?>;
*/

typedef PythonModuleFrom<T extends PythonModule> = T Function(
  PythonModulePlatform<PythonFfiPlatform<Object?>, Object?> pythonModule,
);

class PythonModule
    extends PythonModulePlatform<PythonFfiPlatform<Object?>, Object?> {
  PythonModule.from(
    PythonModulePlatform<PythonFfiPlatform<Object?>, Object?> pythonModule,
  )   : _pythonModule = pythonModule,
        super(pythonModule.platform, pythonModule.reference);

  static FutureOr<T> import<T extends PythonModule>(
    String moduleName,
    PythonModuleFrom<T> from,
  ) =>
      PythonFfi.instance.importModule(moduleName, from);

  final PythonModulePlatform<PythonFfiPlatform<Object?>, Object?> _pythonModule;

  @override
  void dispose() {
    _pythonModule.dispose();
  }

  @override
  Object? getAttribute(String attributeName) =>
      _pythonModule.getAttribute(attributeName);

  @override
  PythonFunctionPlatform<PythonFfiPlatform<Object?>, Object?> getFunction(
    String functionName,
  ) =>
      _pythonModule.getFunction(functionName);

  @override
  Object? toDartObject() => _pythonModule.toDartObject();
}

class PythonFfi {
  PythonFfi._();

  static PythonFfi? _instance;

  static PythonFfi get instance {
    _instance ??= PythonFfi._();
    return _instance!;
  }

  FutureOr<void> initialize() async =>
      await PythonFfiPlatform.instance.initialize();

  void _ensureInitialized() {
    if (!PythonFfiPlatform.instance.isInitialized) {
      throw PythonFfiException(
        "PythonFfi is not initialized. Call `PythonFfi.instance.initialize()` before using it.",
      );
    }
  }

  Future<T> importModule<T extends PythonModule>(
    String name,
    PythonModuleFrom<T> from,
  ) async {
    _ensureInitialized();
    return from(await PythonFfiPlatform.instance.importModule(name));
  }

  Future<void> appendToPath(String path) async {
    _ensureInitialized();
    await PythonFfiPlatform.instance.appendToPath(path);
  }
}
