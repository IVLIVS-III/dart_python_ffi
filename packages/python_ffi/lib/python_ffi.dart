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

typedef PythonClassFrom<T extends PythonClass> = T Function(
  PythonClassPlatform<PythonFfiPlatform<Object?>, Object?> pythonClass,
);

class PythonModule
    extends PythonModulePlatform<PythonFfiPlatform<Object?>, Object?> {
  PythonModule.from(
    PythonModulePlatform<PythonFfiPlatform<Object?>, Object?> pythonModule,
  )   : _pythonModule = pythonModule,
        super(pythonModule.platform, pythonModule.reference);

  static T import<T extends PythonModule>(
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

abstract class _PythonClass
    extends PythonClassPlatform<PythonFfiPlatform<Object?>, Object?> {
  _PythonClass.from(
    PythonClassPlatform<PythonFfiPlatform<Object?>, Object?> pythonClass,
  )   : _pythonClass = pythonClass,
        super(pythonClass.platform, pythonClass.reference);

  final PythonClassPlatform<PythonFfiPlatform<Object?>, Object?> _pythonClass;

  @override
  void dispose() {
    _pythonClass.dispose();
  }

  @override
  Object? getAttribute(String attributeName) =>
      _pythonClass.getAttribute(attributeName);

  @override
  Object? toDartObject() => _pythonClass.toDartObject();
}

abstract class PythonClass extends _PythonClass {
  PythonClass.from(
    PythonClassPlatform<PythonFfiPlatform<Object?>, Object?> pythonClass,
  ) : super.from(pythonClass);

  PythonClass.import(String moduleName, String className, PythonClassFrom from)
      : super.from(PythonFfi.instance.importClass(moduleName, className, from));
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

  T importModule<T extends PythonModule>(
    String name,
    PythonModuleFrom<T> from,
  ) {
    _ensureInitialized();
    return from(PythonFfiPlatform.instance.importModule(name));
  }

  T importClass<T extends PythonClass>(
    String moduleName,
    String className,
    PythonClassFrom<T> from,
  ) {
    _ensureInitialized();
    return from(PythonFfiPlatform.instance.importClass(moduleName, className));
  }

  Future<void> appendToPath(String path) async {
    _ensureInitialized();
    await PythonFfiPlatform.instance.appendToPath(path);
  }
}
