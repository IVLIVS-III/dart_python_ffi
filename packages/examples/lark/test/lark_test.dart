import "package:lark/python_modules/lark.g.dart";
import "package:lark/python_modules/src/python_modules.g.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:test/test.dart";

void main() async {
  group("smoke tests", () {
    setUpAll(() async {
      await PythonFfiDart.instance.initialize(kPythonModules);
    });

    test("module can be imported", () {
      expect(lark.import(), anything);
    });
  });
}
