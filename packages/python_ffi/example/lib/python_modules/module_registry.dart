import "dart:async";

import "package:python_ffi/python_ffi.dart";
import "package:python_ffi_example/python_modules/data_class.dart";
import "package:python_ffi_example/python_modules/hello_world.dart";
import "package:python_ffi_example/python_modules/json_parser.dart";
import "package:python_ffi_example/python_modules/liblax.dart";
import "package:python_ffi_example/python_modules/primitives.dart";
import "package:python_ffi_example/python_modules/structs.dart";
import "package:python_ffi_example/python_modules/type_mappings.dart";

FutureOr<void> registerPythonModules() async {
  PythonFfi.instance.prepareModule(HelloWorldModule.definition);
  PythonFfi.instance.prepareModule(PrimitivesModule.definition);
  PythonFfi.instance.prepareModule(StructsModule.definition);
  PythonFfi.instance.prepareModule(DataClassModule.definition);
  PythonFfi.instance.prepareModule(JsonParserModule.definition);
  PythonFfi.instance.prepareModule(LiblaxModule.definition);
  PythonFfi.instance.prepareModule(TypeMappingsModule.definition);
}
