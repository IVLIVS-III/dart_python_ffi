part of scripts;

final class _CpythonBuildConfig {
  factory _CpythonBuildConfig(
    ArgResults? argResults, {
    Logger? logger,
  }) {
    final int jobs = int.tryParse(argResults?["jobs"] as String? ?? "") ??
        _CpythonBuildCommand._defaultJobs;
    return _CpythonBuildConfig._(
      logger: logger ?? _logger(argResults),
      jobs: jobs == -1 ? null : jobs,
    );
  }

  _CpythonBuildConfig._({
    required this.logger,
    this.jobs,
  });

  final Logger logger;
  final int? jobs;
}

final class _CpythonBuildCommand extends _CpythonSubCommand {
  _CpythonBuildCommand() {
    addFlags(argParser);
  }

  static void addFlags(ArgParser argParser) {
    argParser.addOption(
      "jobs",
      abbr: "j",
      help:
          "The number of build jobs to run simultaneously.\nDefaults to the number of processors minus one.\nUse -1 for unlimited.",
      defaultsTo: _defaultJobs.toString(),
    );
  }

  @override
  final String name = "build";

  @override
  final String description = "Build the cpython dynamic library.";

  static int get _defaultJobs => max(1, Platform.numberOfProcessors - 1);

  @override
  Future<void> run() async {
    await _build(_CpythonBuildConfig(argResults));
  }
}

Future<void> _build(_CpythonBuildConfig config) async {
  final Logger logger = config.logger;
  final int? jobs = config.jobs;

  // configure
  final Progress configureProgress = logger.progress("Configuring cpython");
  final Map<String, String> configureEnvironment = <String, String>{};
  final List<String> configureArgs = <String>[
    "--disable-test-modules",
    "--without-doc-strings",
    "--enable-shared",
    "--without-ensurepip",
    "--without-system-ffi",
  ];
  if (Platform.isMacOS) {
    configureArgs.addAll(<String>[
      "--enable-universalsdk",
      "--with-universal-archs=universal2",
    ]);
    configureEnvironment["MACOSX_DEPLOYMENT_TARGET"] = "10.13";
  }
  await Process.run(
    "./configure",
    configureArgs,
    workingDirectory: _cpython.path,
    environment: configureEnvironment,
  ).then(_throwIfNeeded(message: "configure failed"));
  configureProgress.finish(showTiming: true);

  // build
  final String version = await _getVersion(logger);
  final String minorVersion = version.split(".").take(2).join(".");
  final Progress buildProgress = logger.progress("Building cpython");
  late final String targetExtension;
  switch (Platform.operatingSystem) {
    case "linux":
      targetExtension = "so";
    case "macos":
      targetExtension = "dylib";
    case "windows":
      targetExtension = "dll";
    default:
      throw UnsupportedError(
        "Unsupported operating system: ${Platform.operatingSystem}.",
      );
  }
  await Process.run(
    "make",
    <String>[
      "libpython$minorVersion.$targetExtension",
      "-j",
      if (jobs != null) jobs.toString(),
    ],
    workingDirectory: _cpython.path,
  ).then(_throwIfNeeded(message: "make failed"));
  buildProgress.finish(showTiming: true);

  // check
  final Progress checkProgress = logger.progress("Checking cpython");
  await Process.run(
    "./dylib_check",
    <String>[],
    workingDirectory: _cpython.path,
  ).then(_throwIfNeeded(message: "dylib_check failed"));
  checkProgress.finish(showTiming: true);
}
