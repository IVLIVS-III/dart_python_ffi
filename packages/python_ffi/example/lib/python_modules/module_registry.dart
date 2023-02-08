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
  await Future.wait<void>(<Future<void>>[
    PythonFfi.instance.prepareModule(HelloWorldModule.definition).asFuture,
    PythonFfi.instance.prepareModule(PrimitivesModule.definition).asFuture,
    PythonFfi.instance.prepareModule(StructsModule.definition).asFuture,
    PythonFfi.instance.prepareModule(DataClassModule.definition).asFuture,
    PythonFfi.instance.prepareModule(JsonParserModule.definition).asFuture,
    PythonFfi.instance.prepareModule(LiblaxModule.definition).asFuture,
    PythonFfi.instance.prepareModule(TypeMappingsModule.definition).asFuture,
  ]);
}
