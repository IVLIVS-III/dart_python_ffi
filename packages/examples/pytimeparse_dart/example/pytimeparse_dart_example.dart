import "dart:io";

import "package:pytimeparse_dart/pytimeparse_dart.dart";

void main() async {
  await initialize();
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
