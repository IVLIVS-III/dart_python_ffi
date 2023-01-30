import "package:python_ffi/python_ffi.dart";

class LiblaxParserModule extends PythonModule {
  LiblaxParserModule.from(super.pythonModule) : super.from();

  static LiblaxParserModule import() => PythonModule.import(
        "liblax.parser",
        LiblaxParserModule.from,
      );

  String run(String data) =>
      getFunction("run").call(<Object?>[data]).toString();

  static PythonModuleDefinition get definition => PythonModuleDefinition(
        name: "parser",
        root: SourceDirectory("liblax")..add(SourceFile("parser.py")),
        classNames: classNames,
      );

  static Iterable<String> get classNames => const <String>[];
}

class LiblaxModule extends PythonModule {
  LiblaxModule.from(super.pythonModule) : super.from();

  static LiblaxModule import() => PythonModule.import(
        "liblax",
        LiblaxModule.from,
      );

  LiblaxParserModule get parser => LiblaxParserModule.import();

  static PythonModuleDefinition get definition => PythonModuleDefinition(
        name: "liblax",
        root: SourceDirectory("liblax")
          ..add(SourceFile("__init__.py"))
          ..add(SourceFile("core.py"))
          ..add(SourceFile("parser.py")),
        classNames: classNames,
      );

  static Iterable<String> get classNames => const <String>[
        "Function",
        "Chk",
        "Num",
        "Block",
        "Op",
        "Sum",
        "Sub",
        "Mul",
        "Div",
        "Pow",
        "Exp",
      ];
}
