import "dart:async";

import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:python_ffi_dart_example/python_modules/type_mappings.dart";

FutureOr<void> registerPythonModules() async {
  await PythonFfiDart.instance.prepareModule(TypeMappingsModule.definition);
}
