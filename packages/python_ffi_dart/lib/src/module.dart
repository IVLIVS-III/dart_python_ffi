part of python_ffi_dart;

/// A callback that creates a new [PythonModule] from a [PythonFfiDelegate].
typedef PythonModuleFrom<T extends PythonModule> = T Function(
  PythonModuleInterface<PythonFfiDelegate<Object?>, Object?> pythonModule,
);

/// The Dart representation of a Python module.
abstract class PythonModule extends PythonObject {
  /// Creates a new [PythonModule] from a [PythonFfiDelegate].
  PythonModule.from(this._moduleDelegate) : super.from(_moduleDelegate);

  /// Imports a Python module.
  ///
  /// Use this method instead of the constructor.
  static T import<T extends PythonModule>(
    String moduleName,
    PythonModuleFrom<T> from,
  ) =>
      PythonFfiDart.instance.importModule(moduleName, from);

  final PythonModuleInterface<PythonFfiDelegate<Object?>, Object?>
      _moduleDelegate;

  /// Gets a class from the module.
  PythonClassInterface<PythonFfiDelegate<Object?>, Object?> getClass(
    String className,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) =>
      _moduleDelegate.getClass(className, args, kwargs);
}
