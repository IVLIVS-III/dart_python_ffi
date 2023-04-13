import "dart:async";

import "package:fj_playground/utils/fj_interpreter.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:python_ffi/python_ffi.dart";

class OutputBox extends StatefulWidget {
  const OutputBox({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<OutputBox> createState() => _OutputBoxState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<TextEditingController>("controller", controller),
    );
  }
}

class _OutputBoxState extends State<OutputBox> {
  final StreamController<String> _outputController = StreamController<String>();

  Future<void> _onControllerChanged() async {
    try {
      final String output = await runFJInterpreter(widget.controller.text);
      _outputController.add(output);
    } on PythonExceptionInterface<PythonFfiDelegate<Object>, Object> catch (e) {
      final Set<String> commonErrorTypes = <String>{
        "Exception",
        "UnexpectedEOF",
        "UnexpectedCharacters",
        "VisitError",
      };
      for (final String errorType in commonErrorTypes) {
        if (e.type == errorType) {
          final String error = e.toString();
          final int index = error.lastIndexOf("$errorType: ");
          if (index != -1) {
            _outputController
                .addError(error.substring(index + errorType.length + 2));
            return;
          }
        }
      }
      _outputController.addError(e);
    } on Exception catch (e) {
      debugPrint(e.toString());
      _outputController.addError(e);
    }
  }

  @override
  void initState() {
    widget.controller.addListener(_onControllerChanged);
    super.initState();
  }

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
          child: StreamBuilder<String>(
            stream: _outputController.stream,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasError) {
                return ErrorOutput(error: snapshot.error);
              } else if (snapshot.hasData) {
                return ComputationOutput(text: snapshot.requireData);
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            },
          ),
        ),
      );

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    _outputController.close();
    super.dispose();
  }
}

class ErrorOutput extends StatelessWidget {
  const ErrorOutput({
    Key? key,
    this.error,
  }) : super(key: key);

  final Object? error;

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.red,
        child: TextField(
          controller: TextEditingController(text: error.toString()),
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
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Object?>("error", error));
  }
}

class ComputationOutput extends StatelessWidget {
  const ComputationOutput({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) => TextField(
        controller: TextEditingController(text: text),
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
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty("text", text));
  }
}
