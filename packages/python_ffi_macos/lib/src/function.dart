import "dart:ffi";

import "package:python_ffi_macos/python_ffi_macos.dart";
import "package:python_ffi_macos/src/extensions/convert_extension.dart";
import "package:python_ffi_macos/src/ffi/generated_bindings.g.dart";
import "package:python_ffi_macos/src/object.dart";
import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";

class PythonFunctionMacos
    extends PythonFunctionPlatform<PythonFfiMacOS, Pointer<PyObject>>
    with PythonObjectMacosMixin {
  PythonFunctionMacos(super.platform, super.reference);

  @override
  T call<T extends Object?>(
    List<Object?> args, {
    Map<String, Object?>? kwargs,
    T Function(PythonObjectMacos)? converter,
  }) {
    final List<Pointer<PyObject>> mappedArgs = args
        .map((Object? arg) => arg.toPythonObject(platform).reference)
        .toList();

    final Map<String, Pointer<PyObject>>? mappedKwargs = kwargs?.map(
      (String key, Object? value) => MapEntry<String, Pointer<PyObject>>(
        key,
        value.toPythonObject(platform).reference,
      ),
    );

    final Pointer<PyObject> rawResult =
        rawCall(args: mappedArgs, kwargs: mappedKwargs);

    final PythonObjectMacos result = PythonObjectMacos(platform, rawResult);

    if (converter != null) {
      return converter(result);
    }

    final Object? mappedResult = result.toDartObject();
    if (mappedResult is! PythonObjectPlatform) {
      result.dispose();
    }

    return mappedResult as T;
  }

  /// Calls the python function with raw pyObject args and kwargs
  Pointer<PyObject> rawCall({
    List<Pointer<PyObject>>? args,
    Map<String, Pointer<PyObject>>? kwargs,
  }) {
    // prepare args
    final int argsLen = args?.length ?? 0;
    final Pointer<PyObject> pArgs = platform.bindings.PyTuple_New(argsLen);
    if (pArgs == nullptr) {
      throw PythonFfiException("Creating argument tuple failed");
    }
    for (int i = 0; i < argsLen; i++) {
      platform.bindings.PyTuple_SetItem(pArgs, i, args![i]);
    }

    // TODO: prepare kwargs
    // prepare kwargs
    final Pointer<PyObject> pKwargs = nullptr;

    // call function
    final Pointer<PyObject> result =
        platform.bindings.PyObject_Call(reference, pArgs, pKwargs);
    platform.bindings.Py_DecRef(pArgs);

    // check for errors
    platform.ensureNoPythonError();

    return result;
  }
}
