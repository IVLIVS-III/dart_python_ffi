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

Future<_ModuleBundle<Object>?> _bundleModule({
  required String appRoot,
  required String pythonModulePath,
  required String appType,
  bool isSubmodule = false,
}) async {
  final _PythonModule<Object>? pythonModule =
      _PythonModule.fromPath(pythonModulePath);

  if (pythonModule == null) {
    // TODO: move to logger
    print("⚠️   Warning: could not find Python module at '$pythonModulePath'.");
    return null;
  }

  final _ModuleBundle<Object> moduleBundle = _ModuleBundle<Object>.fromAppType(
    appType,
    pythonModule: pythonModule,
    appRoot: appRoot,
  );

  if (!isSubmodule) {
    await moduleBundle.export();
  }
  return moduleBundle;
}

Future<Iterable<_ModuleBundle<Object>>> _bundleCacheModule({
  required String appRoot,
  required String projectName,
  required String projectVersion,
  required String appType,
}) async {
  final Iterable<_PythonModule<Object>> pythonModules =
      await _PythonModule.fromCache(
    projectName: projectName,
    version: projectVersion,
  );

  print(
    "Discovered ${pythonModules.length} modules in cache directory '$projectName-$projectVersion': ${pythonModules.map((_PythonModule<Object> e) => "${e.moduleName}@${e.path}").join(", ")}.",
  );

  final Iterable<_ModuleBundle<Object>> moduleBundles = pythonModules.map(
    (_PythonModule<Object> e) => _ModuleBundle<Object>.fromAppType(
      appType,
      pythonModule: e,
      appRoot: appRoot,
    ),
  );

  await Future.wait(moduleBundles.map((_ModuleBundle<Object> e) => e.export()));
  return moduleBundles;
}

Future<_ConsoleModuleBundle<Object>> _ensureConsoleModuleBundle(
  _ModuleBundle<Object> moduleBundle,
) async {
  switch (moduleBundle) {
    case _ConsoleModuleBundle<Object>():
      return moduleBundle;
    case _FlutterModuleBundle<Object>():
      final PythonSourceEntity sourceTree = moduleBundle._sourceTree;
      final String modulesRoot = p.join(moduleBundle.appRoot, "python-modules");
      final PythonSourceEntity newSourceTree =
          await _ensureConsolePythonSourceEntity(
        sourceTree,
        parentDir: modulesRoot,
      );
      return _FakeConsoleModuleBundle<Object>._(
        pythonModule: moduleBundle.pythonModule,
        appRoot: moduleBundle.appRoot,
        sourceTree: newSourceTree,
      );
  }
}

Future<PythonSourceEntity> _ensureConsolePythonSourceEntity(
  PythonSourceEntity entity, {
  required String parentDir,
}) async {
  switch (entity) {
    case SourceFile():
      final File file = File(p.join(parentDir, entity.name));
      if (!file.existsSync()) {
        throw StateError("File '${file.path}' does not exist.");
      }
      final String base64 = base64Encode(file.readAsBytesSync());
      return SourceBase64(entity.name, base64);
    case SourceDirectory():
      final SourceDirectory newEntity = SourceDirectory(entity.name);
      final List<PythonSourceEntity> newChildren = await Future.wait(
        entity.children.map(
          (PythonSourceEntity e) => _ensureConsolePythonSourceEntity(
            e,
            parentDir: p.join(parentDir, entity.name),
          ),
        ),
      );
      newEntity.addAll(newChildren);
      return newEntity;
    case SourceBase64():
      return entity;
  }
}

Future<void> _generateTypeDefs(
  _ModuleBundle<Object> moduleBundle, {
  required String appType,
  required String subPath,
}) async {
  final String parentModulePrefix =
      subPath.replaceAll(Platform.pathSeparator, ".");
  final String moduleName = moduleBundle.pythonModule.moduleName;
  final String stdlibPath = (await PythonFfiDart.instance.stdlibDir).path;
  final InspectionCache cache = InspectionCache();
  final String json = await doInspection(
    parentModulePrefix.isNotEmpty ? null : moduleBundle.definition,
    moduleName: moduleName,
    appType: appType,
    cache: cache,
    stdlibPath: stdlibPath,
    parentModulePrefix: parentModulePrefix,
  );
  if (json == "null") {
    // return;
  }
  final String parentPath = "lib/python_modules/$subPath";
  final File jsonfile = File("$parentPath$moduleName.g.json");
  if (!jsonfile.existsSync()) {
    jsonfile.createSync(recursive: true);
  }
  await jsonfile.writeAsString(json);
  final File outfile = File("$parentPath$moduleName.g.dart");
  if (!outfile.existsSync()) {
    outfile.createSync(recursive: true);
  }
  await outfile.writeAsString(
    emitInspection(
      cache,
      moduleParentPrefix: parentModulePrefix,
    ),
  );
  Process.runSync("dart", <String>["format", outfile.absolute.path]);
}

Future<void> _bundleAndGenerate({
  required _ModuleBundle<Object>? moduleBundle,
  required String appType,
  required String appRoot,
  String subPath = "",
}) async {
  try {
    if (moduleBundle == null) {
      return;
    }
    if (moduleBundle.isBuiltin) {
      return;
    }
    await _generateTypeDefs(moduleBundle, appType: appType, subPath: subPath);

    // find hidden submodules
    final _PythonModule<Object> pythonModule = moduleBundle.pythonModule;
    final List<Future<void>> nestedFutures = <Future<void>>[];
    if (pythonModule is _MultiFilePythonModule) {
      try {
        final Directory searchDirectory = Directory(pythonModule.path);
        for (final FileSystemEntity child
            in searchDirectory.listSync().whereNot(
                  (FileSystemEntity element) => element.name.startsWith("_"),
                )) {
          print("found hidden submodule: '${child.path}'");
          nestedFutures.add(
            _bundleAndGenerate(
              moduleBundle: await _bundleModule(
                appRoot: appRoot,
                pythonModulePath: child.path,
                appType: appType,
                isSubmodule: true,
              ),
              appType: appType,
              appRoot: appRoot,
              subPath: "$subPath${pythonModule.moduleName}/",
            ),
          );
        }
      } on FileSystemException {
        // ignore
      }
    }
    // ignore: avoid_catching_errors
  } on StateError {
    return;
  }
}
