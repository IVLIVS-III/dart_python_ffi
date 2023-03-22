import "package:python_ffi/python_ffi.dart";

class LiblaxParserModule extends PythonModule {
  LiblaxParserModule.from(super.pythonModule) : super.from();

  static LiblaxParserModule import() => PythonModule.import(
        "liblax.parser",
        LiblaxParserModule.from,
      );

  String run(String data) =>
      getFunction("run").call(<Object?>[data]).toString();
}

class LiblaxModule extends PythonModule {
  LiblaxModule.from(super.pythonModule) : super.from();

  static LiblaxModule import() => PythonModule.import(
        "liblax",
        LiblaxModule.from,
      );

  LiblaxParserModule get parser => LiblaxParserModule.import();
}
