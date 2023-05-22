part of scripts;

final class _CpythonUseCommand extends _CpythonSubCommand {
  _CpythonUseCommand() {
    argParser.addOption(
      _kVersionTagOption,
      abbr: "t",
      help: "The version-tag to checkout.",
      valueHelp: "version tag",
      allowed: versions.keys.toList(),
      allowedHelp: versions,
      defaultsTo: defaultVersion,
    );
  }

  @override
  final String name = "use";

  @override
  final String description = "Checkout the specified version.";

  static const String _kVersionTagOption = "version-tag";

  static Map<String, String> get versions => const <String, String>{
        "3.11.3": "The latest version of Python 3.11.",
      };

  static String get defaultVersion => "3.11.3";

  @override
  Future<void> run() async {
    final String? versionTag = argResults?[_kVersionTagOption] as String?;
    if (versionTag == null) {
      throw _ToolExit(1, "No version specified.");
    }
    await _use(_logger(argResults), versionTag: versionTag);
  }
}

Future<void> _use(Logger logger, {required String versionTag}) async {
  final Progress progress = logger.progress("Checking out v$versionTag");
  await Process.run(
    "git",
    <String>["checkout", "v$versionTag"],
    workingDirectory: _cpython.path,
  ).then(
    _throwIfNeeded(message: "git failed checking out $versionTag"),
  );
  progress.finish(showTiming: true);
}
