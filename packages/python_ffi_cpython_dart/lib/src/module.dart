part of python_ffi_cpython_dart;

class _PythonModuleCPython
    extends PythonModuleInterface<PythonFfiCPythonBase, Pointer<PyObject>>
    with _PythonObjectCPythonMixin {
  _PythonModuleCPython(super.platform, super.reference)
      : super(
          initializer: _PythonObjectCPythonRefcountUtil.initializer,
          finalizer: _PythonObjectCPythonRefcountUtil.finalizer,
        );

  _PythonClassDefinitionCPython _getClassDefinition(String name) {
    final _PythonObjectCPython classAttribute = getAttributeRaw(name);
    return _PythonClassDefinitionCPython(platform, classAttribute.reference);
  }

  @override
  _PythonClassCPython getClass(
    String name,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) {
    final _PythonClassDefinitionCPython classDefinition =
        _getClassDefinition(name);
    final _PythonClassCPython classInstance =
        classDefinition.newInstance(args, kwargs);
    return classInstance;
  }

  @override
  _PythonModuleCPython getModule(String name) {
    final _PythonObjectCPython moduleAttribute = getAttributeRaw(name);
    return _PythonModuleCPython(platform, moduleAttribute.reference);
  }
}
