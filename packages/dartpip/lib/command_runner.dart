part of dartpip;

/// The command line application for bundling Python modules into Dart
/// applications.
class DartpipCommandRunner extends CommandRunner<void> {
  /// Creates a new [DartpipCommandRunner].
  DartpipCommandRunner()
      : super(
          "dartpip",
          "The command line application for bundling Python modules into Dart applications.",
        ) {
    argParser.addFlag(
      _kVerboseOption,
      abbr: "v",
      negatable: false,
      help: "Print verbose output.",
    );

    addCommand(InstallCommand());
    addCommand(BundleModuleCommand());
    addCommand(BundleCommand());
    addCommand(DownloadCommand());
  }

  static Logger? _logger;

  /// Gets the logger for for all dartpip sub-features.
  static Logger get logger => _logger ??= Logger.standard();

  @override
  Future<void> runCommand(ArgResults topLevelResults) async {
    final bool verbose = topLevelResults[_kVerboseOption] as bool;
    _logger = verbose ? Logger.verbose() : Logger.standard();

    return super.runCommand(topLevelResults);
  }
}
