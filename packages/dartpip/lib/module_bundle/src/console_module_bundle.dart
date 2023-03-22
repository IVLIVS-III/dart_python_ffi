part of module_bundle;

class ConsoleModuleBundle<T extends Object>
    extends ModuleBundle<PythonModule<T>> {
  ConsoleModuleBundle({
    required super.pythonModule,
    required super.appRoot,
  });

  @override
  Directory get _pythonModuleDestinationDirectory => Directory(
        <String>[_appRootDirectory.path, "lib", "python_modules", "src"].join(
          Platform.pathSeparator,
        ),
      );

  static const String _pythonModulesDartFileName = "python_modules.g.dart";

  SourceFile get _pythonModulesDartFile => SourceFile(
        <String>[
          _pythonModuleDestinationDirectory.path,
          _pythonModulesDartFileName
        ].join(Platform.pathSeparator),
      );

  @override
  ByteData _transformSourceData(ByteData data) {
    final String base64 =
        base64Encode(super._transformSourceData(data).buffer.asUint8List());
    return ByteData.view(Uint8List.fromList(base64.codeUnits).buffer);
  }

  @override
  String _transformSourceFileName(String fileName) =>
      _pythonModulesDartFileName;

  @override
  Map<String, dynamic> _updateModuleInfo(Map<String, dynamic> moduleInfo) =>
      moduleInfo;

  Map<String, dynamic> _drillDown(
    List<String> pathSegments,
    String base64,
    Object? value,
  ) {
    assert(pathSegments.isNotEmpty, "pathSegments must not be empty");
    if (pathSegments.length == 1) {
      late final Object? name;
      if (value is String) {
        name = value;
      } else if (value is Map<String, dynamic>) {
        name = value["name"];
      } else {
        throw ArgumentError.value(
          value,
          "value",
          "value must be either a String or a Map<String, dynamic>",
        );
      }
      return <String, dynamic>{"name": name, "base64": base64};
    }
    final String key = pathSegments.first;
    final List<String> remainingPathSegments = pathSegments.sublist(1);
    if (value is Map<String, dynamic>) {
      value[key] = _drillDown(remainingPathSegments, base64, value[key]);
      return value;
    } else {
      throw ArgumentError.value(
        value,
        "value",
        "value must be either a Map<String, dynamic>",
      );
    }
  }

  @override
  Future<void> _exportSingleFile(String fileName, ByteData data) async {
    final Map<String, dynamic> moduleEntry = pythonModule.moduleInfo;
    final List<String> pathSegments = fileName.split(Platform.pathSeparator);
    final String base64 = String.fromCharCodes(data.buffer.asUint8List());
    moduleEntry["root"] = _drillDown(pathSegments, base64, moduleEntry["root"]);
    moduleInfo = moduleInfo
      ..update(
        pythonModule.moduleName,
        (dynamic _) => moduleEntry,
        ifAbsent: () => moduleEntry,
      );
  }

  @override
  Map<String, dynamic> get moduleInfo {
    if (!_pythonModulesDartFile.existsSync()) {
      return <String, dynamic>{};
    }
    final String content = _pythonModulesDartFile.readAsStringSync();
    final RegExpMatch? match = kPythonModulesDartRegex.firstMatch(content);
    if (match == null) {
      return <String, dynamic>{};
    }
    final String? rawBase64 = match.group(1);
    if (rawBase64 == null) {
      return <String, dynamic>{};
    }
    final String rawJson = utf8.decode(base64Decode(rawBase64));
    return jsonDecode(rawJson) as Map<String, dynamic>;
  }

  @override
  set moduleInfo(Map<String, dynamic> moduleInfo) {
    final String newJson = jsonEncode(moduleInfo);
    final String base64 = base64Encode(utf8.encode(newJson));
    _pythonModulesDartFile
      ..replace(
        kPythonModulesDartRegex,
        "$kPythonModulesPrefix$base64$kPythonModulesSuffix",
      )
      ..ensureHeader(kPythonModulesGeneratedHeader)
      ..ensureFooter("\n");
  }
}
