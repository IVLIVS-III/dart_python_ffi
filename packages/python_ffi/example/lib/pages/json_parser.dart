import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter_json_view/flutter_json_view.dart";
import "package:python_ffi_example/pages/base_input_parser.dart";
import "package:python_ffi_example/python_modules/json_parser.dart";

class JsonParserPage extends StatelessWidget {
  const JsonParserPage({Key? key}) : super(key: key);

  static final JsonParserModule _jsonParserModule = JsonParserModule.import();

  @override
  Widget build(BuildContext context) => BaseInputParserPage<Object?>(
        title: "JSON Parser",
        parse: _jsonParserModule.parse,
        printer: jsonEncode,
        builder: (_, Object? data) => JsonView.string(jsonEncode(data)),
      );
}
