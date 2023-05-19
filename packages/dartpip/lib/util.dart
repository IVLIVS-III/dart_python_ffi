part of dartpip;

String _readPubspec(String appRoot) {
  final Directory appRootDir = Directory(appRoot);
  final File pubspecFile =
      File("${appRootDir.path}${Platform.pathSeparator}pubspec.yaml");
  final String pubspecString = pubspecFile.readAsStringSync();

  return pubspecString;
}

Map<dynamic, dynamic> _parsePubspec(String appRoot, [String? pubspecString]) {
  pubspecString ??= _readPubspec(appRoot);
  final dynamic pubspecYaml = loadYaml(pubspecString);

  if (pubspecYaml is! Map) {
    throw StateError("pubspec.yaml is not a valid YAML map.");
  }

  return pubspecYaml;
}

int _detectIndentation(String pubspecString) {
  final int environmentKeyIndex = pubspecString.indexOf("environment:");
  final int sdkKeyIndex = pubspecString.indexOf("sdk:", environmentKeyIndex);
  final String relevantSubstring = pubspecString.substring(
    environmentKeyIndex,
    sdkKeyIndex,
  );
  final int lastNewlineIndex = relevantSubstring.lastIndexOf("\n");
  return relevantSubstring.length - lastNewlineIndex - 1;
}

Future<void> _bundleModule({
  required String appRoot,
  required String pythonModulePath,
  required String appType,
}) async {
  final _PythonModule<Object> pythonModule =
      _PythonModule.fromPath(pythonModulePath);
  late final _ModuleBundle<_PythonModule<Object>> moduleBundle;

  switch (appType) {
    case _kAppTypeFlutter:
      moduleBundle = _FlutterModuleBundle<Object>(
        pythonModule: pythonModule,
        appRoot: appRoot,
      );
    case _kAppTypeConsole:
      moduleBundle = _ConsoleModuleBundle<Object>(
        pythonModule: pythonModule,
        appRoot: appRoot,
      );
  }

  await moduleBundle.export();
}
