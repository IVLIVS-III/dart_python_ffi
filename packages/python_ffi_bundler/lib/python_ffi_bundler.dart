import "package:args/args.dart";
import "package:python_ffi_bundler/module_bundle.dart";
import "package:python_ffi_bundler/python_module.dart";

const String kAppTypeFlutter = "flutter";
const String kAppTypeConsole = "console";

Future<void> bundle(ArgResults results) async {
  final String appRoot = results["app-root"] as String;
  final String pythonModulePath = results["python-module"] as String;
  final String appType = results["app-type"] as String;

  final PythonModule<Object> pythonModule =
      PythonModule.fromPath(pythonModulePath);
  late final ModuleBundle<PythonModule<Object>> moduleBundle;

  switch (appType) {
    case kAppTypeFlutter:
      moduleBundle = FlutterModuleBundle<Object>(
        pythonModule: pythonModule,
        appRoot: appRoot,
      );
      break;
    case kAppTypeConsole:
      moduleBundle = ConsoleModuleBundle<Object>(
        pythonModule: pythonModule,
        appRoot: appRoot,
      );
      break;
  }

  await moduleBundle.export();
}
