import "package:python_ffi/python_ffi.dart";

final class JsonParserModule extends PythonModule {
  JsonParserModule.from(super.pythonModule) : super.from();

  static JsonParserModule import() => PythonModule.import(
        "json_parser",
        JsonParserModule.from,
      );

  Object? parse(String jsonString) =>
      getFunction("parse").call(<Object?>[jsonString]);

  // ignore: non_constant_identifier_names
  List<Object?> get all__ => List<Object?>.from(getAttribute("__all__"));

  // ignore: non_constant_identifier_names
  set all__(List<Object?> value) => setAttribute("__all__", value);
}
