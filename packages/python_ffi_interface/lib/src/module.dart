part of python_ffi_interface;

/// Abstract base class for any Dart representation of a Python module.
abstract class PythonModuleInterface<P extends PythonFfiDelegate<R>,
    R extends Object?> extends PythonObjectInterface<P, R> {
  /// Creates a new Python module.
  PythonModuleInterface(
    super.delegate,
    super.reference, {
    required super.initializer,
    required super.finalizer,
  });

  /// Creates a class instance of the class given by [name] defined within the
  /// module.
  PythonClassInterface<P, R> getClass(
    String name,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]);

  /// Gets a submodule of the given [name] defined in the module.
  PythonModuleInterface<P, R> getModule(String name);
}
