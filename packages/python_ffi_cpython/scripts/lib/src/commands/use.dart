part of scripts;

final class _CpythonUseConfig {
  factory _CpythonUseConfig(
    ArgResults? argResults, {
    Logger? logger,
  }) =>
      _CpythonUseConfig._(
        logger: logger ?? _logger(argResults),
        versionTag:
            argResults?[_CpythonUseCommand._kVersionTagOption] as String? ??
                _CpythonUseCommand.defaultVersion,
      );

  _CpythonUseConfig._({
    required this.logger,
    required this.versionTag,
  });

  final Logger logger;
  final String versionTag;
}

final class _CpythonUseCommand extends _CpythonSubCommand {
  _CpythonUseCommand() {
    addFlags(argParser);
  }

  static void addFlags(ArgParser argParser) {
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
    await _use(_CpythonUseConfig(argResults));
  }
}

Future<void> _use(_CpythonUseConfig config) async {
  final Logger logger = config.logger;
  final Progress progress =
      logger.progress("Checking out v${config.versionTag}");
  await Process.run(
    "git",
    <String>["checkout", "v${config.versionTag}"],
    workingDirectory: _cpython.path,
  ).then(
    _throwIfNeeded(message: "git failed checking out ${config.versionTag}"),
  );
  progress.finish(showTiming: true);
}
