import "package:python_ffi/python_ffi.dart";

class JsonParserModule extends PythonModule {
  JsonParserModule.from(super.pythonModule) : super.from();

  static JsonParserModule import() => PythonModule.import(
        "json_parser",
        JsonParserModule.from,
      );

  Object? parse(String jsonString) =>
      getFunction("parse").call(<Object?>[jsonString]);

  List<Object?> get all__ => List<Object?>.from(getAttribute("__all__"));

  set all__(List<Object?> value) => setAttribute("__all__", value);
}
