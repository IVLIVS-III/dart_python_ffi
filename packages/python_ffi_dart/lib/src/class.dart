part of python_ffi_dart;

/// Function that returns a [PythonClass] from a [PythonClassInterface].
///
/// This is used for proper type inference.
typedef PythonClassFrom<T extends PythonClass> = T Function(
  PythonClassInterface<PythonFfiDelegate<Object?>, Object?> pythonClass,
);

/// Interface for a Python class definition.
///
/// This is only used to create a [PythonClass] instance.
/// See [PythonClass] for the Dart class of a Python class instance.
abstract class PythonClassDefinition extends PythonObject {
  /// Creates a new [PythonClassDefinition] from a [PythonClassDefinitionInterface].
  PythonClassDefinition.from(this._classDefinitionDelegate)
      : super.from(_classDefinitionDelegate);

  final PythonClassDefinitionInterface<PythonFfiDelegate<Object?>, Object?>
      _classDefinitionDelegate;

  /// Instantiates a new [PythonClass] from this class definition.
  PythonClassInterface<PythonFfiDelegate<Object?>, Object?> newInstance(
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) =>
      _classDefinitionDelegate.newInstance(args, kwargs);

  /// Instantiates a new [PythonClass] from this class definition.
  T call<T extends Object?>(
    List<Object?> args, {
    Map<String, Object?>? kwargs,
  }) =>
      _classDefinitionDelegate.call(args, kwargs: kwargs);

  /// Instantiates a new [PythonClass] from this class definition.
  Object? rawCall({List<Object?>? args, Map<String, Object?>? kwargs}) =>
      _classDefinitionDelegate.rawCall(args: args, kwargs: kwargs);
}

/// Interface for a Python class instance.
///
/// This is an abstraction over a generic Python class instance.
abstract class PythonClass extends PythonObject {
  /// Creates a new [PythonClass] from a [PythonClassInterface].
  PythonClass.from(this._classDelegate) : super.from(_classDelegate);

  final PythonClassInterface<PythonFfiDelegate<Object?>, Object?>
      _classDelegate;

  /// Gets a method from the class.
  PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?> getMethod(
    String functionName,
  ) =>
      _classDelegate.getMethod(functionName);

  @override
  String toString() {
    if (hasAttribute("__str__")) {
      return getFunction("__str__").call(<Object?>[]);
    }
    return super.toString();
  }
}
