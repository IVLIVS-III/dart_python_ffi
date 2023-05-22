part of scripts;

class _ToolExit implements Exception {
  _ToolExit(this.exitCode, this.message) {
    print("❌ error (code $exitCode): $message");
    exit(exitCode);
  }

  final int exitCode;
  final String message;
}
