import "dart:io";

import "package:dartpip/dartpip.dart";
import "package:yaml/yaml.dart";

String readPubspec(String appRoot) {
  final Directory appRootDir = Directory(appRoot);
  final File pubspecFile =
      File("${appRootDir.path}${Platform.pathSeparator}pubspec.yaml");
  final String pubspecString = pubspecFile.readAsStringSync();

  return pubspecString;
}

Map<dynamic, dynamic> parsePubspec(String appRoot, [String? pubspecString]) {
  pubspecString ??= readPubspec(appRoot);
  final dynamic pubspecYaml = loadYaml(pubspecString);

  if (pubspecYaml is! Map) {
    throw StateError("pubspec.yaml is not a valid YAML map.");
  }

  return pubspecYaml;
}

int detectIndentation(String pubspecString) {
  final int environmentKeyIndex = pubspecString.indexOf("environment:");
  final int sdkKeyIndex = pubspecString.indexOf("sdk:", environmentKeyIndex);
  final String relevantSubstring = pubspecString.substring(
    environmentKeyIndex,
    sdkKeyIndex,
  );
  final int lastNewlineIndex = relevantSubstring.lastIndexOf("\n");
  return relevantSubstring.length - lastNewlineIndex - 1;
}

Future<void> bundleModule({
  required String appRoot,
  required String pythonModulePath,
  required String appType,
}) async {
  final PythonModule<Object> pythonModule =
      PythonModule.fromPath(pythonModulePath);
  late final ModuleBundle<PythonModule<Object>> moduleBundle;

  switch (appType) {
    case kAppTypeFlutter:
      moduleBundle = FlutterModuleBundle<Object>(
        pythonModule: pythonModule,
        appRoot: appRoot,
      );
      break;
    case kAppTypeConsole:
      moduleBundle = ConsoleModuleBundle<Object>(
        pythonModule: pythonModule,
        appRoot: appRoot,
      );
      break;
  }

  await moduleBundle.export();
}
