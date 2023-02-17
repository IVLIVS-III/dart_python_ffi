part of python_ffi_macos_dart;

class PythonModuleMacos
    extends PythonModuleInterface<PythonFfiMacOSBase, Pointer<PyObject>>
    with _PythonObjectMacosMixin {
  PythonModuleMacos(super.platform, super.reference)
      : super(
          initializer: _PythonObjectMacosRefcountUtil.initializer,
          finalizer: _PythonObjectMacosRefcountUtil.finalizer,
        );

  _PythonClassDefinitionMacos _getClassDefinition(String name) {
    final _PythonObjectMacos classAttribute = getAttributeRaw(name);
    return _PythonClassDefinitionMacos(platform, classAttribute.reference);
  }

  @override
  PythonClassMacos getClass(
    String name,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) {
    final _PythonClassDefinitionMacos classDefinition =
        _getClassDefinition(name);
    final PythonClassMacos classInstance =
        classDefinition.newInstance(args, kwargs);
    return classInstance;
  }

  @override
  PythonModuleMacos getModule(String name) {
    final _PythonObjectMacos moduleAttribute = getAttributeRaw(name);
    return PythonModuleMacos(platform, moduleAttribute.reference);
  }
}
