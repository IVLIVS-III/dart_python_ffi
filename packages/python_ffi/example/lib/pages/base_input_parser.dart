import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

class BaseInputParserPage<T extends Object?> extends StatefulWidget {
  const BaseInputParserPage({
    Key? key,
    required this.title,
    required this.parse,
    required this.printer,
    required this.builder,
  }) : super(key: key);

  final String title;
  final T Function(String input) parse;
  final String Function(T parsed) printer;
  final Widget Function(BuildContext context, T parsedData) builder;

  @override
  State<BaseInputParserPage<T>> createState() => _BaseInputParserPageState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty("title", title))
      ..add(ObjectFlagProperty<T Function(String input)>.has("parse", parse))
      ..add(
        ObjectFlagProperty<String Function(T parsed)>.has(
          "printer",
          printer,
        ),
      )
      ..add(
        ObjectFlagProperty<
            Widget Function(
              BuildContext context,
              T parsedData,
            )>.has("builder", builder),
      );
  }
}

class _BaseInputParserPageState<T extends Object?>
    extends State<BaseInputParserPage<T>> {
  final TextEditingController _textEditingController = TextEditingController();
  T? _parsedInput;
  Exception? _exception;

  void _onInput() {
    final String input = _textEditingController.text;

    if (input.isEmpty) {
      setState(() {
        _parsedInput = null;
        _exception = null;
      });
      return;
    }

    try {
      _parsedInput = widget.parse(input);
      _exception = null;
    } on Exception catch (e) {
      _parsedInput = null;
      _exception = e;
    }
    setState(() {});
  }

  @override
  void initState() {
    _textEditingController.addListener(_onInput);
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController
      ..removeListener(_onInput)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget parsedView = Container();

    final T? parsedInput = _parsedInput;
    final Exception? exception = _exception;
    if (parsedInput != null) {
      parsedView = widget.builder(context, parsedInput);
    } else if (exception != null) {
      parsedView = Padding(
        padding: const EdgeInsets.all(8),
        child: Text(exception.toString()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: _textEditingController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  label: Text("Enter input here"),
                  hintText: "Enter input here",
                  border: OutlineInputBorder(),
                ),
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ),
          if (parsedInput != null) ...<Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(
                "Parsed output:",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  widget.printer(parsedInput).replaceAll("\n", r"\n"),
                  softWrap: false,
                ),
              ),
            ),
          ],
          Expanded(
            child: parsedView,
          ),
        ],
      ),
    );
  }
}
