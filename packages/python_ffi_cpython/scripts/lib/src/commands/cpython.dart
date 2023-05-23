part of scripts;

const int _gitFailedExitCode = 21;

Directory get _current => Directory.current;

Directory get _cpython =>
    Directory("${_current.path}${Platform.pathSeparator}cpython");

const String _remote = "github.com/python/cpython";

Logger _logger(ArgResults? argResults) =>
    argResults?[_CpythonSubCommand._kVerboseOption] == true
        ? Logger.verbose()
        : Logger.standard();

ProcessResult Function(ProcessResult result) _throwIfNeeded({
  int? exitCode,
  String? message,
}) =>
    (ProcessResult result) {
      if (result.exitCode != 0) {
        stdout.writeln(result.stdout);
        stderr.writeln(result.stderr);
        throw _ToolExit(exitCode ?? result.exitCode, message ?? "");
      }
      return result;
    };

abstract base class _CpythonSubCommand extends Command<void> {
  _CpythonSubCommand() {
    argParser.addFlag(
      _kVerboseOption,
      abbr: "v",
      help: "Print verbose output.",
      defaultsTo: false,
    );
  }

  static const String _kVerboseOption = "verbose";
}

class _CpythonCommand extends Command<void> {
  _CpythonCommand() {
    addSubcommand(_CpythonAllCommand());
    addSubcommand(_CpythonCloneCommand());
    addSubcommand(_CpythonUseCommand());
    addSubcommand(_CpythonPatchCommand());
    addSubcommand(_CpythonBuildCommand());
  }

  @override
  final String name = "cpython";

  @override
  final String description = "Utilities for building cpython.";
}

final class _CpythonAllCommand extends _CpythonSubCommand {
  _CpythonAllCommand() {
    _CpythonCloneCommand.addFlags(argParser);
    _CpythonUseCommand.addFlags(argParser);
    _CpythonBuildCommand.addFlags(argParser);
  }

  @override
  final String name = "all";

  @override
  final String description = "Clone, patch, and build cpython.";

  @override
  Future<void> run() async {
    final Logger logger = _logger(argResults);
    await _clone(_CpythonCloneConfig(argResults, logger: logger));
    await _use(_CpythonUseConfig(argResults, logger: logger));
    await _patch(_CpythonPatchConfig(argResults, logger: logger));
    await _build(_CpythonBuildConfig(argResults, logger: logger));
  }
}
