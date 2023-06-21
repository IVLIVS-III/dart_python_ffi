import "dart:io";

import "package:args/args.dart";
import "package:basic_cli_adder/basic_cli_adder.dart";
import "package:basic_cli_adder/python_modules/src/python_modules.g.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";

void main(List<String> arguments) async {
  final ArgParser argParser = ArgParser()
    ..addSeparator("usage: basic_cli_adder [options] <x> <y>\n")
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

  final List<String> numbers = argResults.rest;
  if (numbers.length != 2) {
    print(argParser.usage);
    return;
  }

  final num x = num.parse(numbers[0]);
  final num y = num.parse(numbers[1]);

  await PythonFfiDart.instance.initialize(kPythonModules, libPath: libPath);

  final BasicCliAdder basicCliAdder = BasicCliAdder.import();
  final num result = basicCliAdder.add(x, y);
  print("$x + $y = $result");
}
