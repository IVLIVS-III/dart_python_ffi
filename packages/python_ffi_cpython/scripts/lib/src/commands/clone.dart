part of scripts;

final class _CpythonCloneConfig {
  factory _CpythonCloneConfig(
    ArgResults? argResults, {
    Logger? logger,
  }) =>
      _CpythonCloneConfig._(
        logger: logger ?? _logger(argResults),
        force: argResults?["force"] as bool? ?? false,
      );

  _CpythonCloneConfig._({
    required this.logger,
    required this.force,
  });

  final Logger logger;
  final bool force;
}

final class _CpythonCloneCommand extends _CpythonSubCommand {
  _CpythonCloneCommand() {
    addFlags(argParser);
  }

  static void addFlags(ArgParser argParser) {
    argParser.addFlag(
      "force",
      abbr: "f",
      help: "Force a fresh clone.",
      defaultsTo: false,
    );
  }

  @override
  final String name = "clone";

  @override
  final String description = "Clone the cpython github repo.";

  @override
  Future<void> run() async {
    await _clone(_CpythonCloneConfig(argResults));
  }
}

class _State {
  factory _State({bool force = false}) => _State._(
        null,
        force ? false : null,
        force ? false : null,
        force: force,
      );

  _State._(
    this._dirExists,
    this._isGitRepo,
    this._isClone, {
    required this.force,
  });

  bool? _dirExists;
  bool? _isGitRepo;
  bool? _isClone;

  final bool force;

  bool get dirExists => _dirExists ?? true;

  set dirExists(bool value) => _dirExists = value;

  bool get isGitRepo => _isGitRepo ?? false;

  set isGitRepo(bool value) => _isGitRepo = value;

  bool get isClone => _isClone ?? false;

  set isClone(bool value) => _isClone = value;

  bool get shouldDelete => dirExists && (force || !isGitRepo || !isClone);

  bool get shouldClone => force || !dirExists || !isGitRepo || !isClone;

  void _checkDirExists(Logger logger) {
    if (_dirExists == null) {
      final Progress progress =
          logger.progress("Checking if '${_cpython.relativePath}' exists");
      final bool dirExists = _cpython.existsSync();
      _dirExists = dirExists;
      progress.finish(showTiming: true);
    }
  }

  Future<void> _checkIsGitRepo(Logger logger) async {
    if (_isGitRepo == null) {
      if (force) {
        _isGitRepo = false;
        return;
      }
      if (!dirExists) {
        _isGitRepo = false;
        return;
      }
      final Progress progress = logger
          .progress("Checking if '${_cpython.relativePath}' is a git repo");
      final bool isGitRepo = await Process.run(
        "git",
        <String>["rev-parse", "--is-inside-work-tree"],
        workingDirectory: _cpython.path,
      ).then((ProcessResult result) => result.exitCode == 0);
      _isGitRepo = isGitRepo;
      progress.finish(showTiming: true);
    }
  }

  Future<void> _checkIsClone(Logger logger) async {
    if (_isClone == null) {
      if (force) {
        _isClone = false;
        return;
      }
      if (!dirExists || !isGitRepo) {
        _isGitRepo = false;
        return;
      }
      final Progress progress = logger.progress(
        "Checking if '${_cpython.relativePath}' is a clone of '$_remote'",
      );
      final String remoteUrl = await Process.run(
        "git",
        <String>["config", "--get", "remote.origin.url"],
        workingDirectory: _cpython.path,
      ).then((ProcessResult result) => (result.stdout as String).trim());
      final bool isClone = remoteUrl == "https://$_remote.git";
      _isClone = isClone;
      progress.finish(showTiming: true);
    }
  }
}

Future<void> _clone(_CpythonCloneConfig config) async {
  final Logger logger = config.logger;

  final _State state = _State(force: config.force).._checkDirExists(logger);
  await state._checkIsGitRepo(logger);
  await state._checkIsClone(logger);

  // delete cpython directory if needed
  if (state.shouldDelete) {
    final Progress progress =
        logger.progress("Deleting '${_cpython.relativePath}'");
    await _cpython.delete(recursive: true);
    progress.finish(showTiming: true);
  }

  // clone cpython repo if needed
  if (state.shouldClone) {
    final Progress progress =
        logger.progress("Cloning '$_remote' into '${_cpython.relativePath}'");
    await Process.run(
      "git",
      <String>["clone", "https://$_remote.git"],
    ).then(_throwIfNeeded(message: "git failed cloning '$_remote'"));
    progress.finish(showTiming: true);
  }

  // fetch latest cpython repo
  final Progress fetchProgress = logger.progress("Fetching '$_remote'");
  await Process.run(
    "git",
    <String>["fetch"],
    workingDirectory: _cpython.path,
  ).then(_throwIfNeeded(message: "git failed fetching '$_remote'"));
  fetchProgress.finish(showTiming: true);

  // reset to origin/main branch
  final Progress resetProgress =
      logger.progress("Restoring '${_cpython.relativePath}' to a clean state");
  await Process.run(
    "git",
    <String>["reset", "--hard", "origin/main"],
    workingDirectory: _cpython.path,
  ).then(
    _throwIfNeeded(
      message:
          "git failed restoring '${_cpython.relativePath}' to a clean state",
    ),
  );
  resetProgress.finish(showTiming: true);

  // delete untracked files
  final Progress cleanProgress = logger
      .progress("Cleaning untracked files from '${_cpython.relativePath}'");
  await Process.run(
    "git",
    <String>["clean", "-fd"],
    workingDirectory: _cpython.path,
  ).then(_throwIfNeeded(message: "git failed cleaning untracked files"));
  cleanProgress.finish(showTiming: true);
}
