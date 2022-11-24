import "dart:ffi";

import "package:python_ffi_macos/python_ffi_macos.dart";
import "package:python_ffi_macos/src/extensions/convert_extension.dart";
import "package:python_ffi_macos/src/ffi/generated_bindings.g.dart";
import "package:python_ffi_macos/src/function.dart";
import "package:python_ffi_macos/src/module.dart";
import "package:python_ffi_macos/src/object.dart";
import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";

class PythonClassMacos
    extends PythonClassPlatform<PythonFfiMacOS, Pointer<PyObject>>
    with PythonObjectMacosMixin {
  PythonClassMacos(PythonFfiMacOS platform, Pointer<PyObject> reference,
      PythonModuleMacos module)
      : _module = module,
        super(platform, reference);

  final PythonModuleMacos _module;

  final Map<String, PythonFunctionMacos> _functions =
      <String, PythonFunctionMacos>{};

  @override
  PythonClassMacos newInstance(
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) {
    final PythonFunctionMacos initFunction = getMethod("__init__");

    final List<PythonObjectMacos> pyArgs =
        args.map((Object? e) => e.toPythonObject(platform)).toList();
    final Map<String, PythonObjectMacos> pyKwargs =
        Map<String, PythonObjectMacos>.fromEntries(
      (kwargs?.entries ?? <MapEntry<String, Object?>>[])
          .map(
            (MapEntry<String, Object?> e) =>
                MapEntry<String, PythonObjectMacos>(
              e.key,
              e.value.toPythonObject(platform),
            ),
          )
          .toList(),
    );

    final Pointer<PyObject> instance = initFunction.rawCall(
      args: pyArgs.map((PythonObjectMacos e) => e.reference).toList(),
      kwargs: pyKwargs.map(
        (String key, PythonObjectMacos value) =>
            MapEntry<String, Pointer<PyObject>>(key, value.reference),
      ),
    );

    for (final PythonObjectMacos pyArg in pyArgs) {
      pyArg.dispose();
    }
    for (final PythonObjectMacos pyKwarg in pyKwargs.values) {
      pyKwarg.dispose();
    }

    return PythonClassMacos(platform, instance, _module);
  }

  @override
  PythonFunctionMacos getMethod(String functionName) =>
      getFunction_(functionName, _functions);

  @override
  PythonModuleMacos get module => _module;

  @override
  void dispose() {
    for (final PythonFunctionMacos function in _functions.values) {
      function.dispose();
    }
    _functions.clear();
    module.dispose();
    super.dispose();
  }
}
