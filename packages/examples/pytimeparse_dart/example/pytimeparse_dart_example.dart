import "dart:io";

import "package:args/args.dart";
import "package:pytimeparse_dart/pytimeparse_dart.dart";

void main(List<String> arguments) async {
  final ArgParser argParser = ArgParser()
    ..addSeparator("usage: pytimeparse_dart_example [options]\n")
    ..addOption(
      "libPath",
      abbr: "l",
      defaultsTo: null,
      mandatory: Platform.isWindows || Platform.isLinux,
      help:
      "Path to the Python dynamic library. Specify this option on Windows, Linux, or if you want to use a custom Python version.",
    )
    ..addFlag(
      "help",
      abbr: "h",
      help: "Show this help message.",
      negatable: false,
    );
  final ArgResults argResults = argParser.parse(arguments);
  final Object? helpArg = argResults["help"];
  final bool help = switch (helpArg) {
    bool() => helpArg,
    _ => false,
  };
  if (help) {
    print(argParser.usage);
    return;
  }

  final Object? libPathArg = argResults["libPath"];
  final String? libPath = switch (libPathArg) {
    String() => libPathArg,
    _ => null,
  };

  await initialize(libPath: libPath);
  stdout.write("Enter a duration: ");
  final String? input = stdin.readLineSync();
  final PyTimeParse pyTimeParse = PyTimeParse.import();
  final num? seconds = pyTimeParse.parse(input ?? "");
  if (seconds == null) {
    stdout.writeln("unable to normalize duration: $input");
    return;
  }
  final Duration duration = seconds.asDuration;
  stdout.writeln("normalized duration: $duration");
}
