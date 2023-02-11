import "package:args/args.dart";
import "package:python_ffi_bundler/python_ffi_bundler.dart";

Future<void> main(List<String> arguments) async {
  final ArgParser parser = ArgParser()
    ..addOption("app-root", abbr: "r", mandatory: true)
    ..addOption(
      "python-module",
      abbr: "m",
      mandatory: true,
    )
    ..addOption(
      "app-type",
      abbr: "t",
      allowed: <String>[kAppTypeFlutter, kAppTypeConsole],
      defaultsTo: kAppTypeFlutter,
    );

  final ArgResults results = parser.parse(arguments);
  await bundle(results);
}
