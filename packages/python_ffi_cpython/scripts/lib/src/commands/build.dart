part of scripts;

final class _CpythonBuildCommand extends _CpythonSubCommand {
  @override
  final String name = "build";

  @override
  final String description = "Build the cpython dynamic library.";

  @override
  Future<void> run() async {
    await _build(_logger(argResults));
  }
}

Future<void> _build(Logger logger) async {
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
  await Process.run(
    "make",
    <String>["libpython$minorVersion.dylib", "-j"],
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
