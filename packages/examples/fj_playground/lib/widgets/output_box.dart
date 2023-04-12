import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

class OutputBox extends StatefulWidget {
  const OutputBox({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  State<OutputBox> createState() => _OutputBoxState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty("text", text));
  }
}

class _OutputBoxState extends State<OutputBox> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.text);

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: TextField(
            controller: _controller,
            readOnly: true,
            maxLines: null,
            expands: true,
            autofocus: false,
            autocorrect: false,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            style: const TextStyle(
              fontFamily: "FiraCode",
              fontFamilyFallback: <String>["monospace"],
            ),
          ),
        ),
      );
}
