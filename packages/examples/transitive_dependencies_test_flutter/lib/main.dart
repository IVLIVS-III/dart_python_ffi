import "package:flutter/material.dart";
import "package:python_ffi/python_ffi.dart";
import "package:transitive_dependencies_test_flutter/python_modules/feedparser.g.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PythonFfi.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Transitive Dependencies Test Flutter",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Transitive Dependencies Test Flutter"),
          ),
          drawer: Drawer(
            child: ListView(
              children: const <Widget>[
                DrawerHeader(
                  child: SizedBox.shrink(),
                ),
                AboutListTile(),
              ],
            ),
          ),
          body: Center(
            child: Text(feedparser.import().USER_AGENT.toString()),
          ),
        ),
      );
}
