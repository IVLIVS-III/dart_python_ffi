import "package:flutter/material.dart";

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Plugin example app"),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: const Text("Small Examples"),
              onTap: () {
                Navigator.of(context).pushNamed("/small-examples");
              },
            ),
            ListTile(
              title: const Text("Json Parser"),
              onTap: () {
                Navigator.of(context).pushNamed("/json_parser");
              },
            ),
            ListTile(
              title: const Text("Liblax"),
              onTap: () {
                Navigator.of(context).pushNamed("/liblax");
              },
            ),
          ],
        ),
      );
}
