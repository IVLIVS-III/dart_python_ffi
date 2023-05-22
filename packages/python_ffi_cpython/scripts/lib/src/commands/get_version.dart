part of scripts;

Future<String> _getVersion(Logger logger) async {
  final String version = await Process.run(
    "git",
    <String>["describe", "--tags", "--abbrev=0"],
    workingDirectory: _cpython.path,
  ).then((ProcessResult result) {
    final String version = (result.stdout as String).trim();
    if (version.startsWith("v")) {
      return version.substring(1);
    }
    return version;
  }).catchError((Object error) => "");
  if (!_CpythonUseCommand.versions.keys.contains(version)) {
    throw _ToolExit(
      1,
      "Unknown version '$version'.\n"
      "Known versions: ${_CpythonUseCommand.versions.keys.join(", ")}",
    );
  }
  return version;
}
