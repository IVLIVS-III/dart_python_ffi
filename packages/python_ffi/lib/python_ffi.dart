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
  T getAttribute<T extends Object?>(String attributeName) =>
      _pythonModule.getAttribute(attributeName);

  @override
  T getAttributeRaw<
          T extends PythonObjectPlatform<PythonFfiPlatform<Object?>,
              Object?>>(String attributeName) =>
      _pythonModule.getAttributeRaw(attributeName);

  @override
  PythonFunctionPlatform<PythonFfiPlatform<Object?>, Object?> getFunction(
    String functionName,
  ) =>
      _pythonModule.getFunction(functionName);

  @override
  PythonClassPlatform<PythonFfiPlatform<Object?>, Object?> getClass(
    String className,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) =>
      _pythonModule.getClass(className, args, kwargs);

  @override
  Object? toDartObject() => _pythonModule.toDartObject();
}

abstract class PythonClass
    extends PythonClassPlatform<PythonFfiPlatform<Object?>, Object?> {
  PythonClass.from(
    PythonClassPlatform<PythonFfiPlatform<Object?>, Object?> pythonClass,
  )   : _pythonClass = pythonClass,
        super(pythonClass.platform, pythonClass.reference);

  final PythonClassPlatform<PythonFfiPlatform<Object?>, Object?> _pythonClass;

  @override
  void dispose() {
    _pythonClass.dispose();
  }

  @override
  T call<T extends Object?>(
    List<Object?> args, {
    Map<String, Object?>? kwargs,
  }) =>
      _pythonClass.call(args, kwargs: kwargs);

  @override
  Object? rawCall({List<Object?>? args, Map<String, Object?>? kwargs}) =>
      _pythonClass.rawCall(args: args, kwargs: kwargs);

  @override
  T getAttribute<T extends Object?>(String attributeName) =>
      _pythonClass.getAttribute(attributeName);

  @override
  T getAttributeRaw<
          T extends PythonObjectPlatform<PythonFfiPlatform<Object?>,
              Object?>>(String attributeName) =>
      _pythonClass.getAttributeRaw(attributeName);

  @override
  PythonFunctionPlatform<PythonFfiPlatform<Object?>, Object?> getMethod(
    String functionName,
  ) =>
      _pythonClass.getMethod(functionName);

  @override
  PythonClassPlatform<PythonFfiPlatform<Object?>, Object?> newInstance(
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) =>
      _pythonClass.newInstance(args, kwargs);

  @override
  Object? toDartObject() => _pythonClass.toDartObject();
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

  void addClassName(String className) =>
      PythonFfiPlatform.instance.addClassName(className);

  void removeClassName(String className) =>
      PythonFfiPlatform.instance.removeClassName(className);

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
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) {
    _ensureInitialized();
    // TODO: integrate pythonClassType properly
    return from(
      PythonFfiPlatform.instance
          .importClass(moduleName, className, args, kwargs),
    );
  }

  Future<void> appendToPath(String path) async {
    _ensureInitialized();
    await PythonFfiPlatform.instance.appendToPath(path);
  }
}
