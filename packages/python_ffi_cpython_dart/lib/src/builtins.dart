part of python_ffi_cpython_dart;

/// TODO: Document.
final class BuiltinsModule extends _PythonModuleCPython {
  /// TODO: Document.
  BuiltinsModule.from(
    PythonModuleInterface<PythonFfiDelegate<Object?>, Object?> pythonModule,
  ) : super(
          pythonModule.platform as PythonFfiCPythonBase,
          pythonModule.reference! as Pointer<PyObject>,
        );

  /// TODO: Document.
  // ignore: prefer_constructors_over_static_methods
  static BuiltinsModule import() =>
      BuiltinsModule.from(PythonFfiDelegate.instance.importModule("builtins"));

  /// TODO: Document.
  Object? dir(Object? object) => getFunction("dir").call(<Object?>[object]);

  /// TODO: Document.
  String str(Object? object) => getFunction("str").call(<Object?>[object]);

  /// TODO: Document.
  String repr(Object? object) => getFunction("repr").call(<Object?>[object]);

  /// TODO: Document.
  int hash(Object? object) => getFunction("hash").call(<Object?>[object]);

  /// TODO: Document.
  Object? type(Object? object) => getFunction("type").call(<Object?>[object]);
}
