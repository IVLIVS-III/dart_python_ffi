import "dart:async";

import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:python_ffi_dart/src/python_ffi.dart";

FutureOr<void> registerPythonModules() async {
  await Future.wait<void>(<Future<void>>[
    PythonFfiDart.instance.prepareModule(PythonFfiModule.definition).asFuture,
  ]);
}
