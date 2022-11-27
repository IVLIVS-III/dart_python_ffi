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
  final Map<String, PythonClassMacos> _classes = <String, PythonClassMacos>{};

  @override
  PythonFunctionMacos getFunction(String functionName) =>
      getFunction_(functionName, _functions);

  PythonClassMacos _getClassObject(String className) {
    final PythonClassMacos? cachedClass = _classes[className];
    if (cachedClass != null) {
      return cachedClass;
    }

    final PythonObjectMacos classAttribute = getAttribute(className);
    final PythonClassMacos class_ =
        PythonClassMacos(platform, classAttribute.reference);

    _classes[className] = class_;
    return class_;
  }

  @override
  PythonClassMacos getClass(
    String className,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) {
    final PythonClassMacos class_ = _getClassObject(className);
    final PythonClassMacos classInstance = class_.newInstance(args, kwargs);
    return classInstance;
  }

  @override
  void dispose() {
    for (final PythonFunctionMacos function in _functions.values) {
      function.dispose();
    }
    _functions.clear();
    for (final PythonClassMacos class_ in _classes.values) {
      class_.dispose();
    }
    _classes.clear();
    platform.disposeModule(this);
    super.dispose();
  }
}
