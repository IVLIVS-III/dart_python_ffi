part of python_ffi_dart;

typedef PythonClassFrom<T extends PythonClass> = T Function(
  PythonClassPlatform<PythonFfiPlatform<Object?>, Object?> pythonClass,
);

abstract class PythonClassDefinition extends PythonObject {
  PythonClassDefinition.from(this._classDefinitionDelegate)
      : super.from(_classDefinitionDelegate);

  final PythonClassDefinitionPlatform<PythonFfiPlatform<Object?>, Object?>
      _classDefinitionDelegate;

  PythonClassPlatform<PythonFfiPlatform<Object?>, Object?> newInstance(
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

  final PythonClassPlatform<PythonFfiPlatform<Object?>, Object?> _classDelegate;

  PythonFunctionPlatform<PythonFfiPlatform<Object?>, Object?> getMethod(
    String functionName,
  ) =>
      _classDelegate.getMethod(functionName);
}
