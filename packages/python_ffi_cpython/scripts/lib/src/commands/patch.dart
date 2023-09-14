part of scripts;

final class _CpythonPatchConfig {
  factory _CpythonPatchConfig(
    ArgResults? argResults, {
    Logger? logger,
  }) =>
      _CpythonPatchConfig._(
        logger: logger ?? _logger(argResults),
      );

  _CpythonPatchConfig._({
    required this.logger,
  });

  final Logger logger;
}

final class _CpythonPatchCommand extends _CpythonSubCommand {
  @override
  final String name = "patch";

  @override
  final String description = "Apply the patch used by dart_python_ffi.";

  @override
  Future<void> run() async {
    await _patch(_CpythonPatchConfig(argResults));
  }
}

Future<void> _patch(_CpythonPatchConfig config) async {
  final Logger logger = config.logger;

  final String version = await _getVersion(logger);
  final File patchFile = File(
    p.join(
      _current.path,
      "patches",
      "${Platform.operatingSystem}$version.patch",
    ),
  );
  final Progress checkPatchFileProgress =
      logger.progress("Checking if patch '${patchFile.relativePath}' exists");
  if (!patchFile.existsSync()) {
    throw _ToolExit(1, "Patch file '${patchFile.relativePath}' doesn't exist.");
  }
  checkPatchFileProgress.finish(showTiming: true);

  // extract added files from patch file
  final Progress extractProgress = logger.progress(
    "Deleting files that will be added by patch '${patchFile.relativePath}'",
  );
  final List<String> lines = await patchFile.readAsLines();
  const String addedFileMarker = "--- /dev/null";
  final List<String> addedFiles = lines.fold(
    <String>[],
    (List<String> previousValue, String element) {
      if (element.startsWith("+++ b/") && previousValue.lastOrNull == "") {
        previousValue
          ..removeLast()
          ..add(element.substring(6).trim());
      }
      if (previousValue.lastOrNull == "") {
        previousValue.removeLast();
      }
      if (element == addedFileMarker) {
        previousValue.add("");
      }
      return previousValue;
    },
  );
  final Iterable<Future<void>> deleteTasks = addedFiles.map((String e) async {
    final File file = File(p.join(_cpython.path, e));
    if (file.existsSync()) {
      await file.delete(recursive: true);
    }
  });
  await Future.wait(deleteTasks);
  extractProgress.finish(showTiming: true);

  // apply patch file
  final Progress applyProgress =
      logger.progress("Applying patch '${patchFile.relativePath}'");
  await Process.run(
    "git",
    <String>["apply", patchFile.path],
    workingDirectory: _cpython.path,
  ).then(_throwIfNeeded(message: "git failed applying patch"));
  applyProgress.finish(showTiming: true);
}
