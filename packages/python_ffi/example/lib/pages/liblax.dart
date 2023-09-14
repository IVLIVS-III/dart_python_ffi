import "package:flutter/material.dart";
import "package:python_ffi_example/pages/base_input_parser.dart";
import "package:python_ffi_example/python_modules/liblax.g.dart";
import "package:tex_text/tex_text.dart";

class LiblaxPage extends StatelessWidget {
  const LiblaxPage({Key? key}) : super(key: key);

  static final liblax _liblaxModule = liblax.import();

  @override
  Widget build(BuildContext context) => BaseInputParserPage<String>(
        title: "Liblax",
        parse: (String input) => _liblaxModule.run(data: input).toString(),
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
