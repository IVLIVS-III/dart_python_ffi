import "package:fj_playground/widgets/input_box.dart";
import "package:fj_playground/widgets/output_box.dart";
import "package:flutter/material.dart";

class EditorPage extends StatefulWidget {
  const EditorPage({Key? key}) : super(key: key);

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Row(
          children: <Widget>[
            Flexible(
              flex: 5,
              child: InputBox(
                controller: _inputController,
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
      );
}
