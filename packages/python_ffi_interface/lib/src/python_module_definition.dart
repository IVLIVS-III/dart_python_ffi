part of python_ffi_interface;

abstract class PythonSourceEntity {
  PythonSourceEntity(this.name);

  Iterable<String> get sourceFiles;

  final String name;
}

class SourceFile extends PythonSourceEntity {
  SourceFile(super.name);

  @override
  Iterable<String> get sourceFiles sync* {
    yield name;
  }
}

class SourceDirectory extends PythonSourceEntity {
  SourceDirectory(super.name);

  final Set<PythonSourceEntity> _children = <PythonSourceEntity>{};

  @override
  Iterable<String> get sourceFiles sync* {
    for (final PythonSourceEntity child in _children) {
      yield* child.sourceFiles.map((String e) => "$name/$e");
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
  });

  final String name;
  final PythonSourceEntity root;
  final Iterable<String> classNames;

  Iterable<String> get sourceFiles => root.sourceFiles;
}
