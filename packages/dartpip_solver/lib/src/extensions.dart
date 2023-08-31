part of dartpip_solver;

/// Adds a 'name' getter to each [FileSystemEntity].
extension NameExtension on FileSystemEntity {
  /// Returns the name of this [FileSystemEntity].
  String get name => path.split(Platform.pathSeparator).last;
}
