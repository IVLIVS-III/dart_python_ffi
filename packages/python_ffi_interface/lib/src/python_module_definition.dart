part of python_ffi_interface;

abstract class PythonSourceEntity {
  PythonSourceEntity(this.name);

  Iterable<PythonSourceFileEntity> get sourceFiles;

  final String name;
}

abstract class PythonSourceFileEntity extends PythonSourceEntity {
  PythonSourceFileEntity(super.name);

  @override
  Iterable<PythonSourceFileEntity> get sourceFiles sync* {
    yield this;
  }
}

class SourceFile extends PythonSourceFileEntity {
  SourceFile(super.name);
}

class SourceBytes extends PythonSourceFileEntity {
  SourceBytes(super.name, this.bytes);

  final Uint8List bytes;
}

class SourceBase64 extends PythonSourceFileEntity {
  SourceBase64(super.name, this.base64);

  final String base64;
}

class SourceDirectory extends PythonSourceEntity {
  SourceDirectory(super.name);

  final Set<PythonSourceEntity> _children = <PythonSourceEntity>{};

  @override
  Iterable<PythonSourceFileEntity> get sourceFiles sync* {
    for (final PythonSourceEntity child in _children) {
      yield* child.sourceFiles.map((PythonSourceFileEntity e) {
        if (e is SourceFile) {
          return SourceFile("$name/${e.name}");
        } else if (e is SourceBytes) {
          return SourceBytes("$name/${e.name}", e.bytes);
        }
        return SourceFile("$name/${e.name}");
      });
    }
  }

  void add(PythonSourceEntity child) {
    _children.add(child);
  }
}

class PythonModuleDefinition {
  PythonModuleDefinition({
    required this.name,
    required this.root,
    required this.classNames,
    this.license,
  });

  factory PythonModuleDefinition.fromJson(
      {required String name, required Map<String, dynamic> json}) {
    final PythonSourceEntity root = _parseSourceEntity(json["root"]);
    final Iterable<String> classNames =
        (json["classNames"] as List<dynamic>).cast<String>();
    final PythonSourceFileEntity? license = json["license"] == null
        ? null
        : _parseSourceFileEntity(json["license"]);
    return PythonModuleDefinition(
      name: name,
      root: root,
      classNames: classNames,
      license: license,
    );
  }

  final String name;
  final PythonSourceEntity root;
  final Iterable<String> classNames;
  final PythonSourceFileEntity? license;

  Iterable<PythonSourceFileEntity> get sourceFiles => root.sourceFiles;
}
