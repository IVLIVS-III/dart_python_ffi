part of python_ffi_dart;

typedef PythonModuleFrom<T extends PythonModule> = T Function(
  PythonModuleInterface<PythonFfiDelegate<Object?>, Object?> pythonModule,
);

abstract class PythonModule extends PythonObject {
  PythonModule.from(this._moduleDelegate) : super.from(_moduleDelegate);

  static T import<T extends PythonModule>(
    String moduleName,
    PythonModuleFrom<T> from,
  ) =>
      PythonFfiDart.instance.importModule(moduleName, from);

  final PythonModuleInterface<PythonFfiDelegate<Object?>, Object?>
      _moduleDelegate;

  @override
  PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?> getFunction(
    String name,
  ) =>
      _moduleDelegate.getFunction(name);

  PythonClassInterface<PythonFfiDelegate<Object?>, Object?> getClass(
    String className,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) =>
      _moduleDelegate.getClass(className, args, kwargs);
}
