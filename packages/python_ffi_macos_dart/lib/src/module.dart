part of python_ffi_macos_dart;

class PythonModuleMacos
    extends PythonModuleInterface<PythonFfiMacOSBase, Pointer<PyObject>>
    with _PythonObjectMacosMixin {
  PythonModuleMacos(super.platform, super.reference);

  final Map<String, PythonFunctionMacos> _functions =
      <String, PythonFunctionMacos>{};
  final Map<String, _PythonClassDefinitionMacos> _classes =
      <String, _PythonClassDefinitionMacos>{};

  @override
  PythonFunctionMacos getFunction(String name) {
    final PythonFunctionMacos? cachedFunction = _functions[name];
    if (cachedFunction != null) {
      platform.bindings.Py_IncRef(cachedFunction.reference);
      return cachedFunction;
    }

    final PythonObjectInterface<PythonFfiMacOSBase, Pointer<PyObject>>
        functionAttribute = getAttributeRaw(name);
    final PythonFunctionMacos function =
        PythonFunctionMacos(platform, functionAttribute.reference);

    _functions[name] = function;

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
  void dispose() {
    for (final PythonFunctionMacos function in _functions.values) {
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
