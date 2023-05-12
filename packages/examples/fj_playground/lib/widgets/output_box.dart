import "dart:async";
import "dart:io";

import "package:file_picker/file_picker.dart";
import "package:fj_playground/utils/fj_interpreter.dart";
import "package:fj_playground/widgets/switch_chip.dart";
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
  final StreamController<InterpreterResult> _outputController =
      StreamController<InterpreterResult>();

  bool _withContructor = false;
  bool _onlyTypecheck = false;
  InterpreterResult? _result;

  Future<void> _export() async {
    final String? result = _result?.text;
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error: no output to export"),
        ),
      );
      return;
    }
    final String? filePath = await FilePicker.platform.saveFile(
      dialogTitle: "Export",
      type: FileType.custom,
      allowedExtensions: <String>["txt", "fj", "java"],
      lockParentWindow: true,
    );
    if (filePath != null) {
      final File file = File(filePath);
      if (!file.existsSync()) {
        await file.create(recursive: true);
      }
      await file.writeAsString(result);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Exported output successfully to '$filePath'"),
          ),
        );
      }
    }
  }

  Future<void> _onControllerChanged() async {
    try {
      final InterpreterResult result = await runFJInterpreter(
        widget.controller.text,
        withConstructor: _withContructor,
        onlyTypecheck: _onlyTypecheck,
      );
      _outputController.add(result);
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
                .addError(error.substring(index + errorType.length + 2).trim());
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    OutlinedButton.icon(
                      onPressed: _export,
                      icon: const Icon(Icons.save_as),
                      label: const Text("Export"),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    SwitchChip(
                      value: _withContructor,
                      label: "with constructor",
                      onChanged: (bool value) {
                        setState(() {
                          _withContructor = value;
                        });
                        _onControllerChanged();
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    SwitchChip(
                      value: _onlyTypecheck,
                      label: "only typecheck",
                      onChanged: (bool value) {
                        setState(() {
                          _onlyTypecheck = value;
                        });
                        _onControllerChanged();
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: StreamBuilder<InterpreterResult>(
                  stream: _outputController.stream,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<InterpreterResult> snapshot,
                  ) {
                    if (snapshot.hasError) {
                      _result = null;
                      return ErrorOutput(error: snapshot.error);
                    } else if (snapshot.hasData) {
                      _result = snapshot.requireData;
                      return ComputationOutput(result: snapshot.requireData);
                    } else {
                      _result = null;
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
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
    required this.result,
  }) : super(key: key);

  final InterpreterResult result;

  @override
  Widget build(BuildContext context) => TextField(
        controller: TextEditingController(text: result.text),
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
    properties.add(DiagnosticsProperty<InterpreterResult>("result", result));
  }
}
