part of dartpip;

/// Base class for Python dependencies.
sealed class PythonDependency {
  PythonDependency._({required this.name});

  /// The name of the dependency.
  final String name;

  @override
  String toString() => name;
}

/// A Python dependency from PyPI, consisting of a name and a version
/// constraint.
final class PyPIDependency extends PythonDependency {
  /// Creates a new [PyPIDependency].
  PyPIDependency({
    required super.name,
    required this.version,
  }) : super._();

  /// The version constraint of the dependency.
  final String version;

  @override
  String toString() => "$name: $version";
}

/// A Python dependency from a Git repository, consisting of a name, a URL, and
/// a Git ref.
/// This can be used to depend on a specific commit, branch, or tag.
final class GitDependency extends PythonDependency {
  /// Creates a new [GitDependency].
  GitDependency({
    required super.name,
    required this.url,
    required this.ref,
  }) : super._();

  /// The URL of the Git repository.
  final String url;

  /// The Git ref to depend on. Can be a commit, branch, or tag.
  final String ref;

  @override
  String toString() => "$name: $url@$ref";
}

/// A Python dependency from a local path.
/// The path can be absolute or relative to the project root.
final class PathDependency extends PythonDependency {
  /// Creates a new [PathDependency].
  PathDependency({
    required super.name,
    required this.path,
  }) : super._();

  /// The path to the dependency. Can be absolute or relative to the project.
  final String path;

  @override
  String toString() => "$name: $path";
}
