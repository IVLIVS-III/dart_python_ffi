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
  final result = await generateInterface(
    moduleDefinition: moduleDefinition,
    appType: appType,
  );
  final outfile = File("lib/python_modules/${moduleDefinition.name}.g.dart");
  if (!outfile.existsSync()) {
    outfile.createSync();
  }
  await outfile.writeAsString(result.toString());
  Process.runSync("dart", <String>["format", outfile.absolute.path]);
  return;
  print("Generating type definitions for ${moduleDefinition.name}...");
  await PythonFfiDart.instance.prepareModule(moduleDefinition);
  final TypeGenerationModule pythonModuleHandle = PythonFfiDart.instance
      .importModule(moduleDefinition.name, TypeGenerationModule.from);
  final TypeDefinitionsCache cache = TypeDefinitionsCache();
  final TypeDefinition typeDefinition =
      pythonModuleHandle.typeDefinition(moduleDefinition.name, cache: cache);
  print(jsonEncode(cache.dump.reversed.toList()));
  for (final TypeDefinition typeDefinition in cache.values) {
    print("${typeDefinition.type.name}: ${typeDefinition.export}");
  }
  // print(typeDefinition.codeify(appType: appType));
  print(pythonModuleHandle.toJsonRaw);
  print(jsonEncode(pythonModuleHandle.toJsonHydrated(<Object, int>{})));
  print("Generated type definitions for ${moduleDefinition.name}.");
}
