import "package:basic_cli_adder/basic_cli_adder.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:test/test.dart";

void main() async {
  await PythonFfiDart.instance.initialize(kPythonModules);

  test("add", () {
    expect(basic_cli_adder.import().add(x: 1, y: 2), 3);
  });
}
