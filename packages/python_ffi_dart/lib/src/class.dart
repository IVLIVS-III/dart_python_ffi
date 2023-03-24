part of python_ffi_dart;

typedef PythonClassFrom<T extends PythonClass> = T Function(
  PythonClassInterface<PythonFfiDelegate<Object?>, Object?> pythonClass,
);

abstract class PythonClassDefinition extends PythonObject {
  PythonClassDefinition.from(this._classDefinitionDelegate)
      : super.from(_classDefinitionDelegate);

  final PythonClassDefinitionInterface<PythonFfiDelegate<Object?>, Object?>
      _classDefinitionDelegate;

  PythonClassInterface<PythonFfiDelegate<Object?>, Object?> newInstance(
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) =>
      _classDefinitionDelegate.newInstance(args, kwargs);

  T call<T extends Object?>(
    List<Object?> args, {
    Map<String, Object?>? kwargs,
  }) =>
      _classDefinitionDelegate.call(args, kwargs: kwargs);

  Object? rawCall({List<Object?>? args, Map<String, Object?>? kwargs}) =>
      _classDefinitionDelegate.rawCall(args: args, kwargs: kwargs);
}

abstract class PythonClass extends PythonObject {
  PythonClass.from(this._classDelegate) : super.from(_classDelegate);

  final PythonClassInterface<PythonFfiDelegate<Object?>, Object?>
      _classDelegate;

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
