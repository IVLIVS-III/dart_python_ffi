part of python_ffi_macos_dart;

class PythonModuleMacos
    extends PythonModulePlatform<PythonFfiMacOSBase, Pointer<PyObject>>
    with _PythonObjectMacosMixin {
  PythonModuleMacos(super.platform, super.reference);

  final Map<String, PythonFunctionMacos> _functions =
      <String, PythonFunctionMacos>{};
  final Map<String, PythonClassDefinitionMacos> _classes =
      <String, PythonClassDefinitionMacos>{};

  @override
  PythonFunctionMacos getFunction(String functionName) =>
      getFunction_(functionName, _functions);

  PythonClassDefinitionMacos _getClassDefinition(String className) {
    final PythonClassDefinitionMacos? cachedClass = _classes[className];
    if (cachedClass != null) {
      return cachedClass;
    }

    final _PythonObjectMacos classAttribute = getAttributeRaw(className);
    final PythonClassDefinitionMacos classDefinition =
        PythonClassDefinitionMacos(platform, classAttribute.reference);

    _classes[className] = classDefinition;
    return classDefinition;
  }

  @override
  PythonClassMacos getClass(
    String className,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) {
    final PythonClassDefinitionMacos classDefinition =
        _getClassDefinition(className);
    final PythonClassMacos classInstance =
        classDefinition.newInstance(args, kwargs);
    return classInstance;
  }

  @override
  void dispose() {
    for (final PythonFunctionMacos function in _functions.values) {
      function.dispose();
    }
    _functions.clear();
    for (final PythonClassDefinitionMacos classDefinition in _classes.values) {
      classDefinition.dispose();
    }
    _classes.clear();
    platform.disposeModule(this);
    super.dispose();
  }
}
