import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

class InputBox extends StatefulWidget {
  const InputBox({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<InputBox> createState() => _InputBoxState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<TextEditingController>("controller", controller),
    );
  }
}

class _InputBoxState extends State<InputBox> {
  TextEditingController get _inputController => widget.controller;
  final ScrollController _inputScrollController = ScrollController();
  final TextEditingController _lineNumberController = TextEditingController();
  final ScrollController _lineNumberScrollController = ScrollController();

  int? _glyphsPerLine;

  void _syncLineNumbers() {
    final String text = _inputController.text;
    final List<String> lines = text.split("\n");
    final List<MapEntry<int, String>> lineEntries =
        lines.asMap().entries.toList()
          ..sort(
            (MapEntry<int, String> a, MapEntry<int, String> b) =>
                a.key.compareTo(b.key),
          );
    final Iterable<String> lineNumbers =
        lineEntries.map<String>((MapEntry<int, String> e) {
      final int lineNumber = e.key + 1;
      if (e.value.isEmpty) {
        return lineNumber.toString();
      }
      final int lineLength = e.value.length;
      final int? glyphsPerLine = _glyphsPerLine;
      final int lineCount =
          glyphsPerLine == null ? 1 : (lineLength / glyphsPerLine).ceil();
      return (<String>[lineNumber.toString()] +
              List<String>.generate(lineCount - 1, (_) => ""))
          .join("\n");
    });
    _lineNumberController.text = lineNumbers.join("\n");
  }

  @override
  void initState() {
    _inputController.addListener(_syncLineNumbers);
    _inputScrollController.addListener(() {
      _lineNumberScrollController.jumpTo(_inputScrollController.offset);
    });
    _syncLineNumbers();
    super.initState();
  }

  static const double _kOuterPadding = 4;
  static const double _kInnerPadding = 2 * _kOuterPadding;
  static const double _kLineNumbersWidth = 40;
  static const double _kBorderWidth = 1;
  static const double _kMissingSpace =
      3 * _kOuterPadding + _kLineNumbersWidth + _kBorderWidth + _kInnerPadding;
  static const double _kGlyphWidth = 10;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double editorWidth = constraints.maxWidth - _kMissingSpace;
          final int glyphsPerLine = (editorWidth / _kGlyphWidth).floor();
          if (_glyphsPerLine != glyphsPerLine) {
            _glyphsPerLine = glyphsPerLine;
            _syncLineNumbers();
          }

          return Padding(
            padding: const EdgeInsets.all(_kOuterPadding),
            child: Row(
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        width: _kBorderWidth,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: _kOuterPadding),
                    child: SizedBox(
                      width: _kLineNumbersWidth,
                      child: ScrollConfiguration(
                        behavior: const ScrollBehavior().copyWith(
                          scrollbars: false,
                          overscroll: false,
                        ),
                        child: TextField(
                          controller: _lineNumberController,
                          scrollPhysics: const NeverScrollableScrollPhysics(),
                          scrollController: _lineNumberScrollController,
                          readOnly: true,
                          enabled: false,
                          maxLines: null,
                          expands: true,
                          autofocus: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontFamily: "FiraCode",
                            fontFamilyFallback: const <String>["monospace"],
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.7),
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: _kInnerPadding),
                    child: TextField(
                      controller: _inputController,
                      scrollController: _inputScrollController,
                      maxLines: null,
                      expands: true,
                      autofocus: true,
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
                ),
              ],
            ),
          );
        },
      );

  @override
  void dispose() {
    _inputController.removeListener(_syncLineNumbers);
    super.dispose();
  }
}
