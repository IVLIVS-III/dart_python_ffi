import "dart:io";

import "package:file_picker/file_picker.dart";
import "package:fj_playground/widgets/input_box.dart";
import "package:fj_playground/widgets/intents.dart";
import "package:fj_playground/widgets/output_box.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

class EditorPage extends StatefulWidget {
  const EditorPage({Key? key}) : super(key: key);

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final TextEditingController _inputController = TextEditingController();

  int _oldInputHash = "".hashCode;
  bool _isEdited = false;
  String? _filePath;

  bool get isEdited => _isEdited && _filePath != null;

  Future<void> _open() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: "Open",
      type: FileType.custom,
      allowedExtensions: <String>["txt", "fj", "java"],
      lockParentWindow: true,
    );
    final String? filePath = result?.files.single.path;
    if (filePath != null) {
      setState(() {
        _filePath = filePath;
        final String contents = File(filePath).readAsStringSync();
        _oldInputHash = contents.hashCode;
        _inputController.text = contents;
        _isEdited = false;
      });
    }
  }

  Future<void> _save() async {
    final String? filePath = _filePath ??
        await FilePicker.platform.saveFile(
          dialogTitle: "Save",
          fileName: _filePath,
          type: FileType.custom,
          allowedExtensions: <String>["txt", "fj", "java"],
          lockParentWindow: true,
        );
    if (filePath != null) {
      final File file = File(filePath);
      if (!file.existsSync()) {
        await file.create(recursive: true);
      }
      await file.writeAsString(_inputController.text);
      if (mounted) {
        setState(() {
          _filePath = filePath;
          _isEdited = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Saved as: '$filePath'"),
          ),
        );
      }
    }
  }

  void _new() {
    setState(() {
      _inputController.clear();
      _filePath = null;
      _oldInputHash = "".hashCode;
    });
  }

  void _tab() {
    final int start = _inputController.selection.start;
    final int end = _inputController.selection.end;
    final String text = _inputController.text;
    final String before = text.substring(0, start);
    final String after = text.substring(end);
    _inputController
      ..text = "$before  $after"
      ..selection = TextSelection.collapsed(
        offset: start + 2,
      );
  }

  void _handleInputChanged() {
    final int hashcode = _inputController.text.hashCode;
    if (hashcode != _oldInputHash) {
      _oldInputHash = hashcode;
      setState(() {
        _isEdited = true;
      });
    }
  }

  @override
  void initState() {
    _inputController.addListener(_handleInputChanged);
    super.initState();
  }

  @override
  void dispose() {
    _inputController
      ..removeListener(_handleInputChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? fileName = _filePath?.split(Platform.pathSeparator).last;
    final bool isNewFile = fileName == null;
    final String title = fileName ?? "new File";
    final String titleWithStar = title + (isEdited ? "*" : "");
    final Text titleText = Text(
      titleWithStar,
      style: TextStyle(
        fontStyle: isNewFile ? FontStyle.italic : FontStyle.normal,
      ),
    );

    return Actions(
      actions: <Type, Action<Intent>>{
        OpenIntent: CallbackAction<OpenIntent>(
          onInvoke: (OpenIntent intent) => _open(),
        ),
        SaveIntent: CallbackAction<SaveIntent>(
          onInvoke: (SaveIntent intent) => _save(),
        ),
        NewIntent: CallbackAction<NewIntent>(
          onInvoke: (NewIntent intent) => _new(),
        ),
        TabIntent: CallbackAction<TabIntent>(
          onInvoke: (TabIntent intent) => _tab(),
        ),
      },
      child: Scaffold(
        body: Row(
          children: <Widget>[
            Flexible(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          OutlinedButton(
                            onPressed: null,
                            child: titleText,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 8),
                          ),
                          OutlinedButton.icon(
                            onPressed: _open,
                            icon: const Icon(Icons.file_open),
                            label: const Text("Open"),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 8),
                          ),
                          OutlinedButton.icon(
                            onPressed: _save,
                            icon: const Icon(Icons.save),
                            label: const Text("Save"),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 8),
                          ),
                          OutlinedButton.icon(
                            onPressed: _new,
                            icon: const Icon(Icons.add),
                            label: const Text("New"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: InputBox(
                      controller: _inputController,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 4,
              child: OutputBox(
                controller: _inputController,
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          tooltip: "About FJ Playground",
          onPressed: () {
            showAboutDialog(
              context: context,
              applicationName: "FJ Playground",
              applicationVersion: "0.0.4",
              applicationLegalese: "© 2023 Julius Bredemeyer",
            );
          },
          child: const Icon(Icons.info_outline),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>("isEdited", isEdited));
  }
}
