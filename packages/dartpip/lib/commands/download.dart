part of dartpip;

/// Implements the `download` command.
class DownloadCommand extends Command<void> {
  /// Creates a new instance of the [DownloadCommand] class.
  DownloadCommand();

  @override
  final String name = "download";

  @override
  final String description = "Downloads python modules from PyPI.";

  @override
  Future<void>? run() async {
    final ArgResults? argResults = this.argResults;
    if (argResults == null) {
      throw StateError("Options must be provided.");
    }

    final List<String> projectNames = argResults.rest;

    if (projectNames.isEmpty) {
      throw StateError("No package names provided.");
    }

    final List<Future<void>> futures = <Future<void>>[];
    for (final String projectName in projectNames) {
      futures.add(PyPIService().fetch(projectName: projectName));
    }

    await Future.wait(futures);
  }
}
