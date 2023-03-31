import "package:basic_cli_adder/basic_cli_adder.dart";
import "package:basic_cli_adder/python_modules/src/python_modules.g.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";

void main(List<String> arguments) async {
  final num x = num.parse(arguments[0]);
  final num y = num.parse(arguments[1]);

  await PythonFfiDart.instance.initialize(kPythonModules);

  final BasicCliAdder basicCliAdder = BasicCliAdder.import();
  final num result = basicCliAdder.add(x, y);
  print("$x + $y = $result");
}
