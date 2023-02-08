part of python_ffi_macos_dart;

class _PythonModuleMacos
    extends PythonModuleInterface<PythonFfiMacOSBase, Pointer<PyObject>>
    with _PythonObjectMacosMixin {
  _PythonModuleMacos(super.platform, super.reference);

  final Map<String, _PythonFunctionMacos> _functions =
      <String, _PythonFunctionMacos>{};
  final Map<String, _PythonClassDefinitionMacos> _classes =
      <String, _PythonClassDefinitionMacos>{};

  @override
  _PythonFunctionMacos getFunction(String functionName) {
    final _PythonFunctionMacos? cachedFunction = _functions[functionName];
    if (cachedFunction != null) {
      platform.bindings.Py_IncRef(cachedFunction.reference);
      return cachedFunction;
    }

    final PythonObjectInterface<PythonFfiMacOSBase, Pointer<PyObject>>
    functionAttribute = getAttributeRaw(functionName);
    final _PythonFunctionMacos function =
    _PythonFunctionMacos(platform, functionAttribute.reference);

    _functions[functionName] = function;

    return function;
  }

  _PythonClassDefinitionMacos _getClassDefinition(String className) {
    final _PythonClassDefinitionMacos? cachedClass = _classes[className];
    if (cachedClass != null) {
      return cachedClass;
    }

    final _PythonObjectMacos classAttribute = getAttributeRaw(className);
    final _PythonClassDefinitionMacos classDefinition =
        _PythonClassDefinitionMacos(platform, classAttribute.reference);

    _classes[className] = classDefinition;
    return classDefinition;
  }

  @override
  _PythonClassMacos getClass(
    String className,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) {
    final _PythonClassDefinitionMacos classDefinition =
        _getClassDefinition(className);
    final _PythonClassMacos classInstance =
        classDefinition.newInstance(args, kwargs);
    return classInstance;
  }

  @override
  void dispose() {
    for (final _PythonFunctionMacos function in _functions.values) {
      function.dispose();
    }
    _functions.clear();
    for (final _PythonClassDefinitionMacos classDefinition in _classes.values) {
      classDefinition.dispose();
    }
    _classes.clear();
    platform.disposeModule(this);
    super.dispose();
  }
}
