import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter_json_view/flutter_json_view.dart";
import "package:python_ffi_example/pages/base_input_parser.dart";
import "package:python_ffi_example/python_modules/json_parser.g.dart";

class JsonParserPage extends StatelessWidget {
  const JsonParserPage({Key? key}) : super(key: key);

  static final json_parser _jsonParserModule = json_parser.import();

  @override
  Widget build(BuildContext context) => BaseInputParserPage<Object?>(
        title: "JSON Parser",
        parse: (String input) => _jsonParserModule.parse(json_string: input),
        printer: jsonEncode,
        builder: (_, Object? data) => JsonView.string(jsonEncode(data)),
      );
}
