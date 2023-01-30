import "package:python_ffi/python_ffi.dart";

class JsonParserModule extends PythonModule {
  JsonParserModule.from(super.pythonModule) : super.from();

  static JsonParserModule import() => PythonModule.import(
        "json_parser",
        JsonParserModule.from,
      );

  Object? parse(String json_string) =>
      getFunction("parse").call(<Object?>[json_string]);

  static PythonModuleDefinition get definition => PythonModuleDefinition(
        name: "json_parser",
        root: SourceDirectory("json_parser")
          ..add(SourceFile("__init__.py"))
          ..add(SourceFile("lexer.py"))
          ..add(SourceFile("parser.py")),
        classNames: classNames,
      );

  static Iterable<String> get classNames => const <String>[];
}
