part of python_ffi_interface;

/// Represents a Python source entity.
///
/// This can be a file or a directory.
abstract class PythonSourceEntity {
  /// Creates a new Python source entity from a path element.
  PythonSourceEntity(this.name);

  /// Returns the source files in this entity.
  Iterable<PythonSourceFileEntity> get sourceFiles;

  /// The name (path element) of this entity.
  final String name;
}

/// Represents a Python source file entity.
///
/// This can be a file or a base64 String.
abstract class PythonSourceFileEntity extends PythonSourceEntity {
  /// Creates a new Python source file entity from a file name.
  PythonSourceFileEntity(super.name);

  @override
  Iterable<PythonSourceFileEntity> get sourceFiles sync* {
    yield this;
  }
}

/// Represents a Python source file.
class SourceFile extends PythonSourceFileEntity {
  /// Creates a new Python source file from a file name.
  SourceFile(super.name);
}

/// Represents a Python source file as a base64 String.
class SourceBase64 extends PythonSourceFileEntity {
  /// Creates a new Python source file from a file name and base64 String.
  SourceBase64(super.name, this.base64);

  /// The source file encoded as a base64 String.
  final String base64;
}

/// Represents a Python source directory.
class SourceDirectory extends PythonSourceEntity {
  /// Creates a new Python source directory from a directory name.
  SourceDirectory(super.name);

  final Set<PythonSourceEntity> _children = <PythonSourceEntity>{};

  @override
  Iterable<PythonSourceFileEntity> get sourceFiles sync* {
    for (final PythonSourceEntity child in _children) {
      yield* child.sourceFiles.map((PythonSourceFileEntity e) {
        if (e is SourceFile) {
          return SourceFile("$name/${e.name}");
        } else if (e is SourceBase64) {
          return SourceBase64("$name/${e.name}", e.base64);
        }
        return SourceFile("$name/${e.name}");
      });
    }
  }

  /// Adds a child to this directory.
  void add(PythonSourceEntity child) {
    _children.add(child);
  }
}

/// Represents a Python module definition.
///
/// This is used to generate the Python module.
class PythonModuleDefinition {
  /// Creates a new Python module definition.
  PythonModuleDefinition({
    required this.name,
    required this.root,
    this.license,
  });

  /// The name of the module.
  final String name;

  /// The root of the module.
  final PythonSourceEntity root;

  /// The license of the module.
  final PythonSourceFileEntity? license;

  /// Returns the source files in this module.
  Iterable<PythonSourceFileEntity> get sourceFiles => root.sourceFiles;
}
