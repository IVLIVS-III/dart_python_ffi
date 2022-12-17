import "dart:ffi";

import "package:python_ffi_macos/python_ffi_macos.dart";
import "package:python_ffi_macos/src/class.dart";
import "package:python_ffi_macos/src/ffi/generated_bindings.g.dart";
import "package:python_ffi_macos/src/function.dart";
import "package:python_ffi_macos/src/object.dart";
import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";

class PythonModuleMacos
    extends PythonModulePlatform<PythonFfiMacOS, Pointer<PyObject>>
    with PythonObjectMacosMixin {
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

    final PythonObjectMacos classAttribute = getAttributeRaw(className);
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
