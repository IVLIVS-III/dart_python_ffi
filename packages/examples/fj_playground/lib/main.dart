import "package:fj_playground/pages/editor_page.dart";
import "package:fj_playground/widgets/intents.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:python_ffi/python_ffi.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PythonFfi.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "FJ Playground",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
        home: Shortcuts(
          shortcuts: <ShortcutActivator, Intent>{
            SingleActivator(
              LogicalKeyboardKey.keyO,
              control: defaultTargetPlatform != TargetPlatform.macOS,
              meta: defaultTargetPlatform == TargetPlatform.macOS,
            ): const OpenIntent(),
            SingleActivator(
              LogicalKeyboardKey.keyS,
              control: defaultTargetPlatform != TargetPlatform.macOS,
              meta: defaultTargetPlatform == TargetPlatform.macOS,
            ): const SaveIntent(),
            SingleActivator(
              LogicalKeyboardKey.keyN,
              control: defaultTargetPlatform != TargetPlatform.macOS,
              meta: defaultTargetPlatform == TargetPlatform.macOS,
            ): const NewIntent(),
            const SingleActivator(LogicalKeyboardKey.tab): const TabIntent(),
          },
          child: const EditorPage(),
        ),
      );
}
