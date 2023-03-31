import "dart:io";

import "package:basic_dataclass/basic_dataclass.dart";
import "package:basic_dataclass/python_modules/src/python_modules.g.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";

void main(List<String> arguments) async {
  await PythonFfiDart.instance.initialize(kPythonModules);

  final Person person = Person(arguments.first);
  print("<use W,A,S,D to move, press q to quit>");
  String? input;
  do {
    print(person);
    stdout.write("> ");
    input = stdin.readLineSync();
    switch (input) {
      case "w":
        person.move(0, -1);
        break;
      case "a":
        person.move(-1, 0);
        break;
      case "s":
        person.move(0, 1);
        break;
      case "d":
        person.move(1, 0);
        break;
    }
  } while (input != "q");
}
