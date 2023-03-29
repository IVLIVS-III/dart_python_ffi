import "dart:io";

import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:pytimeparse_dart/python_modules/src/python_modules.g.dart";
import "package:pytimeparse_dart/pytimeparse_dart.dart";

void main() async {
  await PythonFfiDart.instance.initialize(kPythonModules);
  stdout.write("Enter a duration: ");
  final String? input = stdin.readLineSync();
  final PyTimeParse pyTimeParse = PyTimeParse.import();
  final int? seconds = pyTimeParse.parse(input ?? "");
  if (seconds == null) {
    stdout.writeln("unable to normalize duration: $input");
    return;
  }
  final Duration duration = Duration(seconds: seconds);
  stdout.writeln("normalized duration: $duration");
}
