import "package:basic_cli_adder/basic_cli_adder.dart";
import "package:basic_cli_adder/python_modules/src/python_modules.g.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:test/test.dart";

void main() async {
  await PythonFfiDart.instance.initialize(kPythonModules);

  test("add", () {
    expect(BasicCliAdder.import().add(1, 2), 3);
  });
}
