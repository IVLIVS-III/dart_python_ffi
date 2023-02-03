import "package:flutter/material.dart";
import "package:python_ffi/python_ffi.dart";
import "package:python_ffi_example/pages/dashboard.dart";
import "package:python_ffi_example/pages/json_parser.dart";
import "package:python_ffi_example/pages/liblax.dart";
import "package:python_ffi_example/pages/small_examples.dart";
import "package:python_ffi_example/pages/type_mappings.dart";
import "package:python_ffi_example/python_modules/module_registry.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PythonFfi.instance.initialize();
  await registerPythonModules();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: const DashboardPage(),
        routes: <String, WidgetBuilder>{
          "/small-examples": (BuildContext context) => const SmallExamplesPage(),
          "/type_mappings": (BuildContext context) => TypeMappingsPage(),
          "/json_parser": (BuildContext context) => const JsonParserPage(),
          "/liblax": (BuildContext context) => const LiblaxPage(),
        },
      );
}
