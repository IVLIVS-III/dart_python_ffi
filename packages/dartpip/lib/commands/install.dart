part of dartpip;

/// Implements the `install` command.
///
/// This will:
///
///   1. Fetch direct python dependencies from `pubspec.yaml`
///   2. Add new dependencies listed on the commandline
///   3. Build a dependency tree and resolve versions
///   4. For each (direct and transitive) dependency, check the cache or
///      download
///   5. Bundle the dependencies
class InstallCommand extends _PubspecCommand<void> {
  @override
  final String name = "install";

  @override
  final String description =
      "Installs and bundles all Python modules specified in pubspec.yaml for a Dart application.";

  Directory get _pythonModuleRoot {
    final AppData appData = AppData.findOrCreate(".dartpip");
    final Directory cacheDir =
        Directory(<String>[appData.path, "cache"].join(Platform.pathSeparator));
    return cacheDir;
  }

  @override
  Future<void>? run() async {
    final ArgResults? argResults = this.argResults;
    if (argResults == null) {
      throw StateError("Options must be provided.");
    }

    final Map<dynamic, dynamic> pubspecYaml = _parsePubspec(_appRoot);
    final Set<String> pythonModuleNames = argResults.rest.toSet()
      ..addAll(_getPythonModuleNames(_getPythonFfiMap(pubspecYaml)));

    if (pythonModuleNames.isEmpty) {
      print(
        "No Python modules specified. Add them to pubspec.yaml or via 'dartpip install <module>.",
      );
      return;
    }

    // TODO: download modules if they don't exist in the cache

    return;

    // Remove modules.json file if it exists.
    // This is necessary because the file is not overwritten. Otherwise old and
    // no longer used modules would still be listed in the file.
    final File modulesJsonFile = File(
      <String>[_appRoot, "python-modules", "modules.json"]
          .join(Platform.pathSeparator),
    );
    if (modulesJsonFile.existsSync()) {
      modulesJsonFile.deleteSync();
    }

    final String appType = _getAppType(pubspecYaml);
    // resets the pubspec.yaml generated assets
    _removeGeneratedAssetDeclarations(appType, _appRoot);

    final List<Future<void>> futures = <Future<void>>[
      _bundleModule(
        appRoot: _appRoot,
        pythonModulePath: _kBuiltinPythonFfiModuleName,
        appType: appType,
      ),
    ];
    for (final String pythonModuleName in pythonModuleNames) {
      print("Bundling Python module '$pythonModuleName'...");
      futures.add(
        _bundleModule(
          appRoot: _appRoot,
          pythonModulePath: <String>[_pythonModuleRoot.path, pythonModuleName]
              .join(Platform.pathSeparator),
          appType: appType,
        ),
      );
    }

    await Future.wait(futures);
  }
}

class _Version {
  factory _Version(String identifier) {
    final Match? match = _versionRegex.firstMatch(identifier);
    if (match == null) {
      throw ArgumentError.value(
        identifier,
        "identifier",
        "Invalid version identifier.",
      );
    }
    final String? epoch = match.group(1);
    final String? release = match.group(2);
    final String? pre = match.group(3);
    final String? preL = match.group(4);
    final String? preN = match.group(5);
    final String? post = match.group(6);
    final String? postN1 = match.group(7);
    final String? postL = match.group(8);
    final String? postN2 = match.group(9);
    final String? dev = match.group(10);
    final String? devL = match.group(11);
    final String? devN = match.group(12);
    final String? local = match.group(13);
    if (release == null) {
      throw ArgumentError.value(
        identifier,
        "identifier",
        "Invalid version identifier, release part not specified.",
      );
    }
    return _Version._(
      epoch: epoch,
      release: release,
      pre: pre,
      preL: preL,
      preN: preN,
      post: post,
      postN1: postN1,
      postL: postL,
      postN2: postN2,
      dev: dev,
      devL: devL,
      devN: devN,
      local: local,
    );
  }

  _Version._({
    this.epoch,
    required this.release,
    this.pre,
    this.preL,
    this.preN,
    this.post,
    this.postN1,
    this.postL,
    this.postN2,
    this.dev,
    this.devL,
    this.devN,
    this.local,
  });

  final String? epoch;
  final String release;
  final String? pre;
  final String? preL;
  final String? preN;
  final String? post;
  final String? postN1;
  final String? postL;
  final String? postN2;
  final String? dev;
  final String? devL;
  final String? devN;
  final String? local;

  /// https://peps.python.org/pep-0440/#appendix-b-parsing-version-strings-with-regular-expressions
  static const String _kVersionPattern =
      r"v?(?:(?:([0-9]+)!)?([0-9]+(?:\.[0-9]+)*)([-_\.]?((?:a|b|c|rc|alpha|beta|pre|preview))[-_\.]?([0-9]+)?)?((?:-([0-9]+))|(?:[-_\.]?(post|rev|r)[-_\.]?([0-9]+)?))?([-_\.]?(dev)[-_\.]?([0-9]+)?)?)(?:\+([a-z0-9]+(?:[-_\.][a-z0-9]+)*))?";

  static final RegExp _versionRegex =
      RegExp("^\\s*$_kVersionPattern\\s*\$", caseSensitive: false);

  Iterable<int> get releaseParts => release.split(".").map(int.parse);
}

class VersionConstraintException implements Exception {
  VersionConstraintException._(this._constraint1, this._constraint2);

  final _VersionConstraint _constraint1;
  final _VersionConstraint _constraint2;

  @override
  String toString() =>
      "VersionConstraintException: '$_constraint1' & '$_constraint2' are incompatible.";
}

abstract class _VersionConstraint {
  factory _VersionConstraint(String identifier) {
    if (identifier.trim().toLowerCase() == "any") {
      return _AnyVersionConstraint();
    }
    return _RequirementVersionConstraint._();
  }

  _VersionConstraint._();

  _VersionConstraint operator &(_VersionConstraint other);
}

class _AnyVersionConstraint extends _VersionConstraint {
  _AnyVersionConstraint() : super._();

  @override
  _VersionConstraint operator &(_VersionConstraint other) => other;
}

class _RequirementVersionConstraint extends _VersionConstraint {
  _RequirementVersionConstraint._() : super._();

  final String name;
  final String url;
  final String extras;
  final String specifier;
  final String marker;

  _RequirementVersionConstraint _combine(_RequirementVersionConstraint other) {
    // TODO: implement _combine
    throw VersionConstraintException._(this, other);
  }

  @override
  _VersionConstraint operator &(_VersionConstraint other) {
    if (other is _AnyVersionConstraint) {
      return this;
    }
    if (other is _RequirementVersionConstraint) {
      return _combine(other);
    }
    throw UnimplementedError();
  }
}

class _DependencyNode {
  _DependencyNode(this._name, this._versionConstraint);

  final String _name;
  final _VersionConstraint _versionConstraint;

  final Set<_DependencyNode> _dependencies = <_DependencyNode>{};

  bool isResolvable() {
    return false;
  }
}

class _DependencyTree {
  final Map<String, pub.VersionConstraint> _dependencies =
      <String, pub.VersionConstraint>{};

  void addDependency(String name, pub.VersionConstraint versionConstraint) {
    if (_dependencies.containsKey(name)) {
      final pub.VersionConstraint existingVersionConstraint =
          _dependencies[name]!;
    }
    _dependencies[name] = versionConstraint;
  }

  bool isResolvable() {
    return false;
  }
}
