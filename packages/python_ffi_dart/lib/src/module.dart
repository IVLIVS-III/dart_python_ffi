part of python_ffi_dart;

typedef PythonModuleFrom<T extends PythonModule> = T Function(
  PythonModulePlatform<PythonFfiPlatform<Object?>, Object?> pythonModule,
);

abstract class PythonModule extends PythonObject {
  PythonModule.from(this._moduleDelegate) : super.from(_moduleDelegate);

  static T import<T extends PythonModule>(
    String moduleName,
    PythonModuleFrom<T> from,
  ) =>
      PythonFfiDart.instance.importModule(moduleName, from);

  final PythonModulePlatform<PythonFfiPlatform<Object?>, Object?>
      _moduleDelegate;

  PythonFunctionPlatform<PythonFfiPlatform<Object?>, Object?> getFunction(
    String functionName,
  ) =>
      _moduleDelegate.getFunction(functionName);

  PythonClassPlatform<PythonFfiPlatform<Object?>, Object?> getClass(
    String className,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) =>
      _moduleDelegate.getClass(className, args, kwargs);
}
