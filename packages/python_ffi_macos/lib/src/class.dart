import "dart:ffi";

import "package:python_ffi_macos/python_ffi_macos.dart";
import "package:python_ffi_macos/src/extensions/convert_extension.dart";
import "package:python_ffi_macos/src/ffi/generated_bindings.g.dart";
import "package:python_ffi_macos/src/function.dart";
import "package:python_ffi_macos/src/object.dart";
import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";

class PythonClassDefinitionMacos
    extends PythonClassDefinitionPlatform<PythonFfiMacOS, Pointer<PyObject>>
    with PythonObjectMacosMixin {
  PythonClassDefinitionMacos(super.platform, super.reference);

  @override
  PythonClassMacos newInstance(
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) {
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

    final Pointer<PyObject> instance = rawCall(
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

    return PythonClassMacos(platform, instance);
  }

  @override
  T call<T extends Object?>(
    List<Object?> args, {
    Map<String, Object?>? kwargs,
  }) =>
      PythonObjectMacosMixin.staticCall<T>(
        platform,
        reference,
        args,
        kwargs: kwargs,
      );

  @override
  Pointer<PyObject> rawCall({
    List<Pointer<PyObject>>? args,
    Map<String, Pointer<PyObject>>? kwargs,
  }) =>
      PythonObjectMacosMixin.staticRawCall(
        platform,
        reference,
        args: args,
        kwargs: kwargs,
      );
}

class PythonClassMacos
    extends PythonClassPlatform<PythonFfiMacOS, Pointer<PyObject>>
    with PythonObjectMacosMixin {
  PythonClassMacos(super.platform, super.reference);

  final Map<String, PythonFunctionMacos> _functions =
      <String, PythonFunctionMacos>{};

  @override
  PythonFunctionMacos getMethod(String functionName) =>
      getFunction_(functionName, _functions);

  @override
  void dispose() {
    for (final PythonFunctionMacos function in _functions.values) {
      function.dispose();
    }
    _functions.clear();
    super.dispose();
  }
}
