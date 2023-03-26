part of dartpip;

/// Implements the `bundle` command.
class BundleCommand extends Command<void> {
  /// Creates a new instance of the [BundleCommand] class.
  BundleCommand() {
    argParser
      ..addOption(_kAppRootOption, abbr: "r", mandatory: true)
      ..addOption(
        _kPythonModulesRootOption,
        abbr: "m",
        mandatory: true,
      );
  }

  @override
  final String name = "bundle";

  @override
  final String description =
      "Bundles all Python modules specified in pubspec.yaml for a Dart application.";

  String _getAppType(Map<dynamic, dynamic> pubspecYaml) {
    final dynamic dependencies = pubspecYaml["dependencies"];

    if (dependencies is! Map) {
      throw StateError(
        "pubspec.yaml does not contain a valid dependencies map.",
      );
    }

    if (dependencies.containsKey("flutter")) {
      return _kAppTypeFlutter;
    } else {
      return _kAppTypeConsole;
    }
  }

  Map<dynamic, dynamic> _getPythonFfiMap(Map<dynamic, dynamic> pubspecYaml) {
    final dynamic pythonFfi = pubspecYaml["python_ffi"];
    if (pythonFfi is! Map) {
      throw StateError(
        "pubspec.yaml does not contain a valid python_ffi map.",
      );
    }

    return pythonFfi;
  }

  Iterable<String> _getPythonModuleNames(Map<dynamic, dynamic> pythonFfiMap) {
    final dynamic pythonModules = pythonFfiMap["modules"];
    if (pythonModules is! Map) {
      return <String>[];
    }

    return pythonModules.keys.cast<String>();
  }

  @override
  Future<void>? run() async {
    final ArgResults? argResults = this.argResults;
    if (argResults == null) {
      throw StateError("Options must be provided.");
    }

    final String appRoot = argResults[_kAppRootOption] as String;
    final String pythonModuleRoot =
        argResults[_kPythonModulesRootOption] as String;

    final Map<dynamic, dynamic> pubspecYaml = _parsePubspec(appRoot);
    final String appType = _getAppType(pubspecYaml);
    final Iterable<String> pythonModuleNames =
        _getPythonModuleNames(_getPythonFfiMap(pubspecYaml));

    if (pythonModuleNames.isEmpty) {
      print("No Python modules specified in pubspec.yaml.");
      return;
    }

    final List<Future<void>> futures = <Future<void>>[];
    for (final String pythonModuleName in <String>[
      "python_ffi",
      ...pythonModuleNames
    ]) {
      print("Bundling Python module '$pythonModuleName'...");
      futures.add(
        _bundleModule(
          appRoot: appRoot,
          pythonModulePath: <String>[pythonModuleRoot, pythonModuleName]
              .join(Platform.pathSeparator),
          appType: appType,
        ),
      );
    }

    await Future.wait(futures);
  }
}
