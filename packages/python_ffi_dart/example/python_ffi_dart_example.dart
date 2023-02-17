import "package:python_ffi_dart/python_ffi_dart.dart";

import "lib/python_modules/hello_world.dart";
import "lib/python_modules/module_registry.dart";

void main() async {
  await PythonFfiDart.instance.initialize();
  await registerPythonModules();

  HelloWorldModule.import().hello_world();
}
