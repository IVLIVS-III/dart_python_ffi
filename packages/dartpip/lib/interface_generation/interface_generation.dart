library interface_generation;

import "dart:io";

import "package:dartpip/dartpip.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";

part "cache.dart";
part "class.dart";
part "class_definition.dart";
part "extensions.dart";
part "function.dart";
part "interface.dart";
part "module.dart";
part "object.dart";
part "primitive.dart";

Future<dynamic> generateInterface({
  required PythonModuleDefinition moduleDefinition,
  required String appType,
}) async {
  print("Generating Dart interface for ${moduleDefinition.name}...");
  await PythonFfiDart.instance.prepareModule(moduleDefinition);
  final ModuleInterface interface = PythonFfiDart.instance
      .importModule(moduleDefinition.name, ModuleInterface.from)
    ..collectChildren();

  final String importSuffix = appType == kAppTypeConsole ? "_dart" : "";
  final String prelude = """
// ignore_for_file: camel_case_types

import "package:python_ffi$importSuffix/python_ffi$importSuffix.dart";
""";
  return """
$prelude
${InterfaceCache.instance.classDefinitions.map((Interface interface) => interface.emit()).join("\n")}
${interface.emit()}
""";
}
