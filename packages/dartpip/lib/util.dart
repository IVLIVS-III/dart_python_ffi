part of dartpip;

String _readPubspec(String appRoot) {
  final Directory appRootDir = Directory(appRoot);
  final File pubspecFile = File(p.join(appRootDir.path, "pubspec.yaml"));
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
  required AppType appType,
  bool isSubmodule = false,
}) async {
  final _PythonModule<Object>? pythonModule =
      _PythonModule.fromPath(pythonModulePath);

  if (pythonModule == null) {
    DartpipCommandRunner.logger.trace(
      "⚠️   Warning: could not find Python module at '$pythonModulePath'.",
    );
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
  required AppType appType,
}) async {
  final Iterable<_PythonModule<Object>> pythonModules =
      await _PythonModule.fromCache(
    projectName: projectName,
    version: projectVersion,
  );

  DartpipCommandRunner.logger.trace(
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
  required AppType appType,
  required String subPath,
  required bool dump,
}) async {
  final String parentModulePrefix =
      subPath.replaceAll(Platform.pathSeparator, ".");
  final String moduleName = moduleBundle.pythonModule.moduleName;
  final String stdlibPath = (await PythonFfiDart.instance.stdlibDir).path;
  final InspectionCache cache = InspectionCache();
  final String? json = await doInspection(
    parentModulePrefix.isNotEmpty ? null : moduleBundle.definition,
    moduleName: moduleName,
    appType: appType,
    cache: cache,
    stdlibPath: stdlibPath,
    dump: dump,
    parentModulePrefix: parentModulePrefix,
  );
  // If subPath is empty, we still want a trailing slash.
  // p.join() ignores empty strings.
  final String parentPath =
      p.join("lib", "python_modules") + Platform.pathSeparator + subPath;
  if (dump && json != null) {
    final File jsonFile = File("$parentPath$moduleName.g.json");
    if (!jsonFile.existsSync()) {
      jsonFile.createSync(recursive: true);
    }
    await jsonFile.writeAsString(json);
  }
  final File outfile = File("$parentPath$moduleName.g.dart");
  if (!outfile.existsSync()) {
    outfile.createSync(recursive: true);
  }
  await outfile.writeAsString(
    emitInspection(
      cache,
      appType: appType,
      moduleParentPrefix: parentModulePrefix,
    ),
  );
  Process.runSync("dart", <String>["format", outfile.absolute.path]);
}

Future<void> _bundleAndGenerate({
  required _ModuleBundle<Object>? moduleBundle,
  required AppType appType,
  required String appRoot,
  required bool dump,
  String subPath = "",
}) async {
  try {
    if (moduleBundle == null) {
      return;
    }
    if (moduleBundle.isBuiltin) {
      return;
    }
    await _generateTypeDefs(
      moduleBundle,
      appType: appType,
      subPath: subPath,
      dump: dump,
    );

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
          DartpipCommandRunner.logger.trace(
            "found hidden submodule: '${child.path}'",
          );
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
              dump: dump,
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
