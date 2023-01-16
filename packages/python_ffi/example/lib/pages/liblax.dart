import "package:flutter/material.dart";
import "package:python_ffi_example/pages/base_input_parser.dart";
import "package:python_ffi_example/python-modules/liblax.dart";
import "package:tex_text/tex_text.dart";

class LiblaxPage extends StatelessWidget {
  const LiblaxPage({Key? key}) : super(key: key);

  static final LiblaxModule _liblaxModule = LiblaxModule.import();

  @override
  Widget build(BuildContext context) => BaseInputParserPage<String>(
        title: "Liblax",
        parse: (String input) => _liblaxModule.parser.run(input),
        printer: (_) => _,
        builder: (_, String data) => Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: TexText("\$$data\$"),
          ),
        ),
      );
}
