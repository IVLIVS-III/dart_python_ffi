import "package:multi_module_dependency_test/python_modules/attr.g.dart";
import "package:multi_module_dependency_test/python_modules/attrs.g.dart";
import "package:multi_module_dependency_test/python_modules/src/python_modules.g.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:test/test.dart";

void main() async {
  group("smoke tests", () {
    setUpAll(() async {
      await PythonFfiDart.instance.initialize(kPythonModules);
    });

    test("attr module can be imported", () {
      expect(attr.import(), anything);
    });
    
    test("attrs module can be imported", () {
      expect(attrs.import(), anything);
    });
  });
}
