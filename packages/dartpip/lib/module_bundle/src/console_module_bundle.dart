part of dartpip;

final class _ConsoleModuleBundle<T extends Object> extends _ModuleBundle<T> {
  _ConsoleModuleBundle._({
    required super.pythonModule,
    required super.appRoot,
  });

  @override
  Directory get _pythonModuleDestinationDirectory =>
      Directory(p.join(_appRootDirectory.path, "lib", "python_modules", "src"));

  static const String _pythonModulesDartFileName = "python_modules.g.dart";

  _SourceFile get _pythonModulesDartFile => _SourceFile(
        p.join(
          _pythonModuleDestinationDirectory.path,
          _pythonModulesDartFileName,
        ),
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
      final String name = switch (value) {
        String() => value,
        Map<String, dynamic>() when value["name"] is String =>
          value["name"] as String,
        _ => throw ArgumentError.value(
            value,
            "value",
            "value must be either a String or a Map<String, dynamic> with a 'name' key",
          ),
      };
      return <String, Object>{"name": name, "base64": base64};
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
    final Object? rawEntry = moduleInfo[pythonModule.moduleName];
    final Object moduleEntry = rawEntry ?? pythonModule.moduleInfo;
    final List<String> pathSegments = fileName.split(Platform.pathSeparator);
    final String base64 = String.fromCharCodes(data.buffer.asUint8List());
    final Map<String, dynamic> filledModuleEntry =
        _drillDown(pathSegments, base64, moduleEntry);
    moduleInfo = moduleInfo
      ..update(
        pythonModule.moduleName,
        (Object? _) => filledModuleEntry,
        ifAbsent: () => filledModuleEntry,
      );
  }

  @override
  Map<String, Object> get moduleInfo {
    if (!_pythonModulesDartFile.existsSync()) {
      return <String, Object>{};
    }
    final String content = _pythonModulesDartFile.readAsStringSync();
    final RegExpMatch? match = _kPythonModulesDartRegex.firstMatch(content);
    if (match == null) {
      return <String, Object>{};
    }
    final String? rawBase64 = match.group(1);
    if (rawBase64 == null) {
      return <String, Object>{};
    }
    final String rawJson = utf8.decode(base64Decode(rawBase64));
    return Map<String, Object>.from(
      jsonDecode(rawJson) as Map<String, dynamic>,
    );
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

final class _FakeConsoleModuleBundle<T extends Object>
    extends _ConsoleModuleBundle<T> {
  _FakeConsoleModuleBundle._({
    required super.pythonModule,
    required super.appRoot,
    required PythonSourceEntity sourceTree,
  })  : _sourceTree = sourceTree,
        super._();

  @override
  final PythonSourceEntity _sourceTree;
}
