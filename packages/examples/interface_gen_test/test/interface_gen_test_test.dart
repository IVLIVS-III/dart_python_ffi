import 'package:interface_gen_test/interface_gen_test.dart';
import 'package:interface_gen_test/python_modules/class_init_adds_field.g.dart'
    as class_init_adds_field;
import 'package:interface_gen_test/python_modules/dataclass.g.dart'
    as dataclass;
import 'package:interface_gen_test/python_modules/empty_module.g.dart'
    as empty_module;
import 'package:interface_gen_test/python_modules/inherited_fields_rename.g.dart'
    as inherited_fields_rename;
import 'package:interface_gen_test/python_modules/module_field.g.dart'
    as module_field;
import 'package:interface_gen_test/python_modules/module_function.g.dart'
    as module_function;
import 'package:python_ffi_dart/python_ffi_dart.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() async => await PythonFfiDart.instance.initialize(kPythonModules));

  group("empty_module", () {
    test("module can be imported", () {
      expect(empty_module.empty_module.import(), anything);
    });
  });

  group("module_field", () {
    test("module can be imported", () {
      expect(module_field.module_field.import(), anything);
    });
    test("field can be read", () {
      expect(module_field.module_field.import().field, 1);
    });
    test("field can be written", () {
      final moduleField = module_field.module_field.import();
      moduleField.field = 2;
      expect(moduleField.field, 2);
    });
  });

  group("module_function", () {
    test("module can be imported", () {
      expect(module_function.module_function.import(), anything);
    });
    test("function can be called", () {
      expect(module_function.module_function.import().function(), 1);
    });
  });

  group("dataclass", () {
    test("module can be imported", () {
      expect(dataclass.dataclass.import(), anything);
    });
    test("class can be instantiated", () {
      expect(dataclass.DataClass(field0: 0), anything);
    });
    test("required field can be read", () {
      expect(dataclass.DataClass(field0: 0).field0, 0);
    });
    test("required field can be written", () {
      final dataClass = dataclass.DataClass(field0: 0);
      dataClass.field0 = 1;
      expect(dataClass.field0, 1);
    });
    test("field with default can be read", () {
      expect(dataclass.DataClass(field0: 0).field1, 1);
    });
    test("field with default can be written", () {
      final dataClass = dataclass.DataClass(field0: 0);
      dataClass.field1 = 2;
      expect(dataClass.field1, 2);
    });
    test("non-init field can be read", () {
      expect(dataclass.DataClass(field0: 0).field2, 2);
    });
    test("non-init field can be written", () {
      final dataClass = dataclass.DataClass(field0: 0);
      dataClass.field2 = 3;
      expect(dataClass.field2, 3);
    });
  });

  group("inherited_fields_rename", () {
    test("module can be imported", () {
      expect(
          inherited_fields_rename.inherited_fields_rename.import(), anything);
    });
    test("module function can be called", () {
      expect(
          inherited_fields_rename.inherited_fields_rename
              .import()
              .$noSuchMethod(),
          1);
    });
    test("module field can be read", () {
      expect(inherited_fields_rename.inherited_fields_rename.import().$getClass,
          1);
    });
    test("module field can be written", () {
      final module = inherited_fields_rename.inherited_fields_rename.import();
      module.$getClass = 2;
      expect(module.$getClass, 2);
    });
    test("class can be instantiated", () {
      expect(inherited_fields_rename.Class(), anything);
    });
    test("class field can be read", () {
      expect(inherited_fields_rename.Class().$initializer, 1);
    });
    test("class field can be written", () {
      final class_ = inherited_fields_rename.Class();
      class_.$initializer = 2;
      expect(class_.$initializer, 2);
    });
    test("class method can be called", () {
      expect(inherited_fields_rename.Class().$newInstance(), 1);
    });
  });

  group("class_init_adds_field", () {
    test("module can be imported", () {
      expect(class_init_adds_field.class_init_adds_field.import(), anything);
    });
    test("class can be instantiated", () {
      expect(class_init_adds_field.ClassInitAddsField(), anything);
    });
    test("field can be read", () {
      expect(class_init_adds_field.ClassInitAddsField().field, 1);
    });
    test("field can be written", () {
      final classInitAddsField = class_init_adds_field.ClassInitAddsField();
      classInitAddsField.field = 2;
      expect(classInitAddsField.field, 2);
    });
  });
}
