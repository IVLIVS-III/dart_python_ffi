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

Future<_ModuleBundle<_PythonModule<Object>>> _bundleModule({
  required String appRoot,
  required String pythonModulePath,
  required String appType,
}) async {
  final _PythonModule<Object> pythonModule =
      _PythonModule.fromPath(pythonModulePath);

  final _ModuleBundle<_PythonModule<Object>> moduleBundle = switch (appType) {
    _kAppTypeFlutter => _FlutterModuleBundle<Object>(
        pythonModule: pythonModule,
        appRoot: appRoot,
      ),
    _kAppTypeConsole => _ConsoleModuleBundle<Object>(
        pythonModule: pythonModule,
        appRoot: appRoot,
      ),
    _ => throw StateError("Invalid app type: $appType"),
  };

  await moduleBundle.export();
  return moduleBundle;
}

Future<_ModuleBundle<_PythonModule<Object>>> _bundleCacheModule({
  required String appRoot,
  required String projectName,
  required String projectVersion,
  required String appType,
}) async {
  final _PythonModule<Object> pythonModule = await _PythonModule.fromCache(
    projectName: projectName,
    version: projectVersion,
  );
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
  return moduleBundle;
}

Future<void> _generateTypeDefs(
  PythonModuleDefinition moduleDefinition, {
  required String appType,
}) async {
  final String stdlibPath = (await PythonFfiDart.instance.stdlibDir).path;
  final InspectionCache cache = InspectionCache();
  final String json = await doInspection(
    moduleDefinition,
    appType: appType,
    cache: cache,
    stdlibPath: stdlibPath,
  );
  final File jsonfile =
      File("lib/python_modules/${moduleDefinition.name}.g.json");
  if (!jsonfile.existsSync()) {
    jsonfile.createSync();
  }
  await jsonfile.writeAsString(json);
  final File outfile =
      File("lib/python_modules/${moduleDefinition.name}.g.dart");
  if (!outfile.existsSync()) {
    outfile.createSync();
  }
  await outfile.writeAsString(emitInspection(cache));
  Process.runSync("dart", <String>["format", outfile.absolute.path]);
  return;
}
