part of dartpip;

/// TODO: Document.
sealed class PythonDependency {
  PythonDependency._({required this.name});

  /// TODO: Document.
  final String name;
}

/// TODO: Document.
final class PyPiDependency extends PythonDependency {
  /// TODO: Document.
  PyPiDependency({
    required super.name,
    required this.version,
  }) : super._();

  /// TODO: Document.
  final String version;
}

/// TODO: Document.
final class GitDependency extends PythonDependency {
  /// TODO: Document.
  GitDependency({
    required super.name,
    required this.url,
    required this.ref,
  }) : super._();

  /// TODO: Document.
  final String url;

  /// TODO: Document.
  final String ref;
}

/// TODO: Document.
final class PathDependency extends PythonDependency {
  /// TODO: Document.
  PathDependency({
    required super.name,
    required this.path,
  }) : super._();

  /// TODO: Document.
  final String path;
}
