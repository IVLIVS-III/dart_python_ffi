part of python_ffi_cpython_dart;

class _PythonModuleMacos
    extends PythonModuleInterface<PythonFfiMacOSBase, Pointer<PyObject>>
    with _PythonObjectMacosMixin {
  _PythonModuleMacos(super.platform, super.reference)
      : super(
          initializer: _PythonObjectMacosRefcountUtil.initializer,
          finalizer: _PythonObjectMacosRefcountUtil.finalizer,
        );

  _PythonClassDefinitionMacos _getClassDefinition(String name) {
    final _PythonObjectMacos classAttribute = getAttributeRaw(name);
    return _PythonClassDefinitionMacos(platform, classAttribute.reference);
  }

  @override
  _PythonClassMacos getClass(
    String name,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) {
    final _PythonClassDefinitionMacos classDefinition =
        _getClassDefinition(name);
    final _PythonClassMacos classInstance =
        classDefinition.newInstance(args, kwargs);
    return classInstance;
  }

  @override
  _PythonModuleMacos getModule(String name) {
    final _PythonObjectMacos moduleAttribute = getAttributeRaw(name);
    return _PythonModuleMacos(platform, moduleAttribute.reference);
  }
}
