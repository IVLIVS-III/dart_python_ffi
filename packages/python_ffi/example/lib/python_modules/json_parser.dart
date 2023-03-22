import "package:python_ffi/python_ffi.dart";

class JsonParserModule extends PythonModule {
  JsonParserModule.from(super.pythonModule) : super.from();

  static JsonParserModule import() => PythonModule.import(
        "json_parser",
        JsonParserModule.from,
      );

  Object? parse(String json_string) =>
      getFunction("parse").call(<Object?>[json_string]);
}
