part of python_ffi_interface;

/// Abstract base class for any Dart representation of a Python class definition.
///
/// This is purely used to instantiate a new Python class instance.
abstract class PythonClassDefinitionInterface<P extends PythonFfiDelegate<R>,
    R extends Object?> extends PythonObjectInterface<P, R> {
  /// Creates a new Python class definition.
  PythonClassDefinitionInterface(
    super.delegate,
    super.reference, {
    required super.initializer,
    required super.finalizer,
  });

  /// Creates a new instance of this class definition.
  PythonClassInterface<P, R> newInstance(
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]);

  /// Creates a new instance of this class definition.
  T call<T extends Object?>(List<Object?> args, {Map<String, Object?>? kwargs});

  /// Creates a new instance of this class definition.
  R rawCall({List<R>? args, Map<String, R>? kwargs});
}

/// Abstract base class for any Dart representation of a Python class instance.
abstract class PythonClassInterface<P extends PythonFfiDelegate<R>,
    R extends Object?> extends PythonObjectInterface<P, R> {
  /// Creates a new Python class instance.
  PythonClassInterface(
    super.delegate,
    super.reference, {
    required super.initializer,
    required super.finalizer,
  });

  /// Gets a method from the class.
  PythonFunctionInterface<P, R> getMethod(String name) => getFunction(name);
}
