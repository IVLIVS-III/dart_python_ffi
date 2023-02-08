part of python_ffi_macos_dart;

class PythonModuleMacos
    extends PythonModuleInterface<PythonFfiMacOSBase, Pointer<PyObject>>
    with _PythonObjectMacosMixin {
  PythonModuleMacos(super.platform, super.reference);

  final Map<String, _PythonClassDefinitionMacos> _classes =
      <String, _PythonClassDefinitionMacos>{};
  final Map<String, PythonModuleMacos> _modules = <String, PythonModuleMacos>{};

  _PythonClassDefinitionMacos _getClassDefinition(String name) {
    final _PythonClassDefinitionMacos? cachedClass = _classes[name];
    if (cachedClass != null) {
      return cachedClass;
    }

    final _PythonObjectMacos classAttribute = getAttributeRaw(name);
    final _PythonClassDefinitionMacos classDefinition =
        _PythonClassDefinitionMacos(platform, classAttribute.reference);

    _classes[name] = classDefinition;
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
  PythonModuleMacos getModule(String name) {
    final PythonModuleMacos? cachedModule = _modules[name];
    if (cachedModule != null) {
      return cachedModule;
    }

    final _PythonObjectMacos moduleAttribute = getAttributeRaw(name);
    final PythonModuleMacos module =
        PythonModuleMacos(platform, moduleAttribute.reference);

    _modules[name] = module;
    return module;
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
