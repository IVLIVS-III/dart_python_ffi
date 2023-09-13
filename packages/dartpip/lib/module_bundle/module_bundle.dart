part of dartpip;

/// Describes a Python module bundled for consumption by the Dart Python FFI.
sealed class _ModuleBundle<T extends Object> {
  _ModuleBundle({
    required this.pythonModule,
    required this.appRoot,
  });

  factory _ModuleBundle.fromAppType(
    AppType appType, {
    required _PythonModule<T> pythonModule,
    required String appRoot,
  }) =>
      switch (appType) {
        AppType.flutter => _FlutterModuleBundle<T>._(
            pythonModule: pythonModule,
            appRoot: appRoot,
          ),
        AppType.console => _ConsoleModuleBundle<T>._(
            pythonModule: pythonModule,
            appRoot: appRoot,
          ),
      };

  final _PythonModule<T> pythonModule;
  final String appRoot;

  bool get isBuiltin => pythonModule is _BuiltinPythonModule;

  Directory get _appRootDirectory => Directory(appRoot);

  Directory get _pythonModuleDestinationDirectory;

  ByteData _transformSourceData(ByteData data) => data;

  String _transformSourceFileName(String fileName) => fileName;

  _SourceFile _sourceFile(String fileName) => _SourceFile(
        <String>[
          _pythonModuleDestinationDirectory.path,
          _transformSourceFileName(fileName),
        ].join(Platform.pathSeparator),
      );

  Future<void> _exportSingleFile(String fileName, ByteData data);

  Future<void> _exportMultiFile(Map<List<String>, ByteData> data) async {
    for (final MapEntry<List<String>, ByteData> entry in data.entries) {
      await _exportSingleFile(
        entry.key.join(Platform.pathSeparator),
        entry.value,
      );
    }
  }

  FutureOr<void> _postExport(List<List<String>> filePaths) {
    moduleInfo = _updateModuleInfo(moduleInfo);
  }

  Map<String, dynamic> get moduleInfo;

  set moduleInfo(Map<String, dynamic> moduleInfo);

  Map<String, dynamic> _updateModuleInfo(Map<String, dynamic> moduleInfo) =>
      moduleInfo
        ..update(
          pythonModule.moduleName,
          (Object? prev) => pythonModule.moduleInfo,
          ifAbsent: () => pythonModule.moduleInfo,
        );

  Future<void> export() async {
    final _PythonModule<Object> pythonModule = this.pythonModule;
    if (!(await pythonModule.load())) {
      print("Failed to load Python module ${pythonModule.moduleName}.");
      throw StateError(
        "Failed to load Python module ${pythonModule.moduleName}.",
      );
    }

    if (pythonModule is _BuiltinPythonModule) {
      await _exportSingleFile(
        "${pythonModule.moduleName}.py",
        _transformSourceData(pythonModule.data),
      );
      await _postExport(<List<String>>[
        <String>["${pythonModule.moduleName}.py"],
      ]);
    } else if (pythonModule is _SingleFilePythonModule) {
      await _exportSingleFile(
        pythonModule.fileName,
        _transformSourceData(pythonModule.data),
      );
      await _postExport(<List<String>>[
        <String>[pythonModule.fileName],
      ]);
    } else if (pythonModule is _MultiFilePythonModule) {
      await _exportMultiFile(
        pythonModule.data
            .mapKeys(
              (List<String> key) => <String>[pythonModule.moduleName, ...key],
            )
            .mapValues(_transformSourceData),
      );
      await _postExport(
        pythonModule.data.keys
            .map((List<String> e) => <String>[pythonModule.moduleName, ...e])
            .toList(),
      );
    }
  }

  PythonSourceEntity get _sourceTree {
    final Object? entry = moduleInfo[pythonModule.moduleName];
    if (entry == null) {
      throw StateError(
        "Python module ${pythonModule.moduleName} not found in module info.",
      );
    }
    final (PythonSourceEntity root, _) =
        PythonFfiCPythonDart.decodePythonSourceEntity(entry);
    return root;
  }

  PythonModuleDefinition get definition => PythonModuleDefinition(
        name: pythonModule.moduleName,
        root: _sourceTree,
      );
}
