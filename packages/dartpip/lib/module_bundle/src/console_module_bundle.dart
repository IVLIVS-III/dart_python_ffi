part of dartpip;

final class _ConsoleModuleBundle<T extends Object> extends _ModuleBundle<T> {
  _ConsoleModuleBundle._({
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

  _SourceFile get _pythonModulesDartFile => _SourceFile(
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
    final String childKey = remainingPathSegments.first;
    if (value is Map<String, dynamic>) {
      assert(
        value["name"] == key,
        "value['name'] must be $key but is ${value["name"]}",
      );
      final Object? children = value["children"];
      if (children is List<Object?>) {
        final Object? child = children.firstWhereOrNull(
          (Object? child) {
            if (child is Map<String, dynamic>) {
              return child["name"] == childKey;
            } else if (child is String) {
              return child == childKey;
            } else {
              return false;
            }
          },
        );
        if (child != null) {
          children[children.indexOf(child)] = _drillDown(
            remainingPathSegments,
            base64,
            child,
          );
          value["children"] = children;
          return value;
        }
        return value;
      } else {
        throw ArgumentError.value(
          value,
          "value",
          "value must be a Map<String, dynamic> with a 'children' key of type List<Object?> but is",
        );
      }
    } else {
      throw ArgumentError.value(
        value,
        "value",
        "value must be a Map<String, dynamic> but is",
      );
    }
  }

  @override
  Future<void> _exportSingleFile(String fileName, ByteData data) async {
    final Map<String, dynamic> moduleEntry =
        (moduleInfo[pythonModule.moduleName] as Map<String, dynamic>?) ??
            pythonModule.moduleInfo;
    final List<String> pathSegments = fileName.split(Platform.pathSeparator);
    final String base64 = String.fromCharCodes(data.buffer.asUint8List());
    moduleEntry["root"] = _drillDown(pathSegments, base64, moduleEntry["root"]);
    moduleInfo = moduleInfo
      ..update(
        pythonModule.moduleName,
        (Object? _) => moduleEntry,
        ifAbsent: () => moduleEntry,
      );
  }

  @override
  Map<String, dynamic> get moduleInfo {
    if (!_pythonModulesDartFile.existsSync()) {
      return <String, dynamic>{};
    }
    final String content = _pythonModulesDartFile.readAsStringSync();
    final RegExpMatch? match = _kPythonModulesDartRegex.firstMatch(content);
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
        _kPythonModulesDartRegex,
        "$_kPythonModulesPrefix$base64$_kPythonModulesSuffix",
      )
      ..ensureHeader(_kPythonModulesGeneratedHeader)
      ..ensureFooter("\n");
  }
}
