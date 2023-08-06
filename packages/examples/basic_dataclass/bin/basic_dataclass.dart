import "dart:io";

import "package:args/args.dart";
import "package:basic_dataclass/basic_dataclass.dart";
import "package:basic_dataclass/python_modules/src/python_modules.g.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";

void main(List<String> arguments) async {
  final ArgParser argParser = ArgParser()
    ..addSeparator("usage: basic_dataclass [options] <PlayerName>\n")
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

  await PythonFfiDart.instance.initialize(kPythonModules, libPath: libPath);

  final Person person = Person(argResults.rest.first);
  print("<use W,A,S,D to move, press q to quit>");
  String? input;
  do {
    print(person);
    stdout.write("> ");
    input = stdin.readLineSync();
    switch (input) {
      case "w":
        person.move(0, -1);
      case "a":
        person.move(-1, 0);
      case "s":
        person.move(0, 1);
      case "d":
        person.move(1, 0);
    }
  } while (input != "q");
}
