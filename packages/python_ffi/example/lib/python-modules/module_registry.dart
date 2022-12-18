import "dart:async";

import "package:python_ffi/python_ffi.dart";
import "package:python_ffi_example/python-modules/data_class.dart";
import "package:python_ffi_example/python-modules/hello_world.dart";
import "package:python_ffi_example/python-modules/json_parser.dart";
import "package:python_ffi_example/python-modules/primitives.dart";
import "package:python_ffi_example/python-modules/structs.dart";

extension PythonClassNameRegisterExtension on Iterable<String> {
  void registerClassNames() {
    for (final String classname in this) {
      PythonFfi.instance.addClassName(classname);
    }
  }
}

void registerPythonClassNames() {
  HelloWorldModule.classNames.registerClassNames();
  PrimitivesModule.classNames.registerClassNames();
  StructsModule.classNames.registerClassNames();
  DataClassModule.classNames.registerClassNames();
  JsonParserModule.classNames.registerClassNames();
}

FutureOr<void> registerPythonModules() async {
  PythonFfi.instance.prepareModule(HelloWorldModule.definition);
  PythonFfi.instance.prepareModule(PrimitivesModule.definition);
  PythonFfi.instance.prepareModule(StructsModule.definition);
  PythonFfi.instance.prepareModule(DataClassModule.definition);
  PythonFfi.instance.prepareModule(JsonParserModule.definition);

  registerPythonClassNames();
}
