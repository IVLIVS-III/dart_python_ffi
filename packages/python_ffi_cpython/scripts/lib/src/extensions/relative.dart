part of scripts;

extension _RelativeExtension on FileSystemEntity {
  String get relativePath {
    final String path = absolute.path;
    final String cwd = Directory.current.path;
    if (path.startsWith(cwd)) {
      return ".${path.substring(cwd.length)}";
    }
    return path;
  }
}
