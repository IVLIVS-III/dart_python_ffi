import "package:basic_cli_adder/basic_cli_adder.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:test/test.dart";

void main() async {
  setUpAll(() async {
    await PythonFfiDart.instance.initialize(pythonModules: kPythonModules);
  });

  test("add", () {
    expect(basic_cli_adder.import().add(x: 1, y: 2), 3);
  });
}
