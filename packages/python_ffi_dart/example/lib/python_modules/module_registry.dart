import "dart:async";

import "package:python_ffi_dart/python_ffi_dart.dart";

import "hello_world.dart";

FutureOr<void> registerPythonModules() async {
  await PythonFfiDart.instance.prepareModule(HelloWorldModule.definition);
}
