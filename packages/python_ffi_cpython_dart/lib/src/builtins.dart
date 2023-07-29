part of python_ffi_cpython_dart;

final class BuiltinsModule extends _PythonModuleCPython {
  BuiltinsModule.from(
      PythonModuleInterface<PythonFfiDelegate<Object?>, Object?> pythonModule)
      : super(
          pythonModule.platform as PythonFfiCPythonBase,
          pythonModule.reference! as Pointer<PyObject>,
        );

  static BuiltinsModule import() =>
      BuiltinsModule.from(PythonFfiDelegate.instance.importModule("builtins"));

  Object? dir(Object? object) => getFunction("dir").call(<Object?>[object]);

  String str(Object? object) => getFunction("str").call(<Object?>[object]);

  String repr(Object? object) => getFunction("repr").call(<Object?>[object]);

  int hash(Object? object) => getFunction("hash").call(<Object?>[object]);
}
