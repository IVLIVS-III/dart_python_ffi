import 'dart:collection';
import 'dart:typed_data';

import 'package:interface_gen_test/interface_gen_test.dart';
import 'package:interface_gen_test/python_modules/class_init_adds_field.g.dart'
    as class_init_adds_field;
import 'package:interface_gen_test/python_modules/class_types.g.dart'
    as class_types;
import 'package:interface_gen_test/python_modules/dataclass.g.dart'
    as dataclass;
import 'package:interface_gen_test/python_modules/empty_module.g.dart'
    as empty_module;
import 'package:interface_gen_test/python_modules/generic_types.g.dart'
    as generic_types;
import 'package:interface_gen_test/python_modules/inherited_fields_rename.g.dart'
    as inherited_fields_rename;
import 'package:interface_gen_test/python_modules/module_field.g.dart'
    as module_field;
import 'package:interface_gen_test/python_modules/module_function.g.dart'
    as module_function;
import 'package:interface_gen_test/python_modules/primitive_types.g.dart'
    as primitive_types;
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

  group("primitive_types", () {
    test("module can be imported", () {
      expect(primitive_types.primitive_types.import(), anything);
    });

    test("get None", () {
      final Null result = primitive_types.primitive_types.import().get_None();
      expect(result, null);
    });
    test("get bool", () {
      final bool result = primitive_types.primitive_types.import().get_bool();
      expect(result, true);
    });
    test("get int", () {
      final int result = primitive_types.primitive_types.import().get_int();
      expect(result, 1);
    });
    test("get float", () {
      final double result =
          primitive_types.primitive_types.import().get_float();
      expect(result, 3.14);
    });
    test("get num", () {
      final primitive_types.$num result =
          primitive_types.primitive_types.import().get_num();
      expect(result, 3.14);
    });
    test("get str", () {
      final String result = primitive_types.primitive_types.import().get_str();
      expect(result, "lorem ipsum");
    });
    test("get bytes", () {
      final Uint8List result =
          primitive_types.primitive_types.import().get_bytes();
      expect(result, Uint8List.fromList("lorem ipsum".codeUnits));
    });
    test("get dict", () {
      final Map<String, int> result =
          primitive_types.primitive_types.import().get_dict();
      expect(result, {"a": 1, "b": 2});
    });
    test("get dict nested", () {
      final Map<String, Map<String, int>> result =
          primitive_types.primitive_types.import().get_dict_nested();
      expect(result, {
        "a": {"b": 1}
      });
    });
    test("get list", () {
      final List<int> result =
          primitive_types.primitive_types.import().get_list();
      expect(result, [1, 2, 3]);
    });
    test("get list implicit", () {
      final List<Object?> result =
          primitive_types.primitive_types.import().get_list_implicit();
      expect(result, [1, "a", false]);
    });
    test("get list nested", () {
      final List<List<int>> result =
          primitive_types.primitive_types.import().get_list_nested();
      expect(result, [
        [1, 2],
        [3, 4]
      ]);
    });
    test("get tuple", () {
      final List<int> result =
          primitive_types.primitive_types.import().get_tuple();
      expect(result, [1, 2, 3]);
    });
    test("get set", () {
      final Set<int> result =
          primitive_types.primitive_types.import().get_set();
      expect(result, {1, 2, 3});
    });
    test("get container nested", () {
      final List<List<Set<int>>> result =
          primitive_types.primitive_types.import().get_container_nested();
      expect(result, [
        [
          {1, 2},
          {3, 4}
        ],
        [
          {5, 6},
          {7, 8}
        ]
      ]);
    });
    test("get Iterator", () {
      final Iterator<int> result =
          primitive_types.primitive_types.import().get_Iterator();
      expect(result, isA<Iterator<int>>());
      expect(result.moveNext(), true);
      expect(result.current, 1);
      expect(result.moveNext(), true);
      expect(result.current, 2);
      expect(result.moveNext(), true);
      expect(result.current, 3);
      expect(result.moveNext(), false);
    });
    test("get Iterator nested", () {
      final Iterator<List<int>> result =
          primitive_types.primitive_types.import().get_Iterator_nested();
      expect(result, isA<Iterator<List<int>>>());
      expect(result.moveNext(), true);
      expect(result.current, [1, 2]);
      expect(result.moveNext(), true);
      expect(result.current, [3, 4]);
      expect(result.moveNext(), false);
    });
    test("get Generator", () {
      final Iterator<int> result =
          primitive_types.primitive_types.import().get_Generator();
      expect(result, isA<Iterator<int>>());
      expect(result.moveNext(), true);
      expect(result.current, 1);
      expect(result.moveNext(), true);
      expect(result.current, 2);
      expect(result.moveNext(), true);
      expect(result.current, 3);
      expect(result.moveNext(), false);
    });
    test("get Iterable", () {
      final Iterable<int> result =
          primitive_types.primitive_types.import().get_Iterable();
      expect(result, isA<Iterable<int>>());
      expect(result, [1, 2, 3]);
    });
    test("get Callable", () {
      final String Function(int) result =
          primitive_types.primitive_types.import().get_Callable();
      expect(result, isA<String Function(int)>());
      expect(result(1), "1");
    });
    test("get Any", () {
      final Object? result = primitive_types.primitive_types.import().get_Any();
      expect(result, 1);
    });
    test("get Any implicit", () {
      final Object? result =
          primitive_types.primitive_types.import().get_Any_implicit();
      expect(result, 1);
    });

    test("set None", () {
      expect(
        primitive_types.primitive_types.import().set_None($_: null),
        true,
      );
    });
    test("set bool", () {
      expect(
        primitive_types.primitive_types.import().set_bool($_: true),
        true,
      );
    });
    test("set int", () {
      expect(
        primitive_types.primitive_types.import().set_int($_: 1),
        true,
      );
    });
    test("set float", () {
      expect(
        primitive_types.primitive_types.import().set_float($_: 3.14),
        true,
      );
    });
    test("set num", () {
      expect(
        primitive_types.primitive_types.import().set_num($_: 1),
        true,
      );
      expect(
        primitive_types.primitive_types.import().set_num($_: 3.14),
        true,
      );
    });
    test("set str", () {
      expect(
        primitive_types.primitive_types.import().set_str($_: "lorem ipsum"),
        true,
      );
    });
    test("set bytes", () {
      expect(
        primitive_types.primitive_types
            .import()
            .set_bytes($_: Uint8List.fromList("lorem ipsum".codeUnits)),
        true,
      );
    });
    test("set dict", () {
      expect(
        primitive_types.primitive_types
            .import()
            .set_dict($_: <String, int>{"a": 1, "b": 2}),
        true,
      );
    });
    test("set dict nested", () {
      expect(
        primitive_types.primitive_types
            .import()
            .set_dict_nested($_: <String, Map<String, int>>{
          "a": {"b": 1}
        }),
        true,
      );
    });
    test("set list", () {
      expect(
        primitive_types.primitive_types.import().set_list($_: <int>[1, 2, 3]),
        true,
      );
    });
    test("set list implicit", () {
      expect(
        primitive_types.primitive_types
            .import()
            .set_list_implicit($_: <Object?>[1, "a", false]),
        true,
      );
    });
    test("set list nested", () {
      expect(
        primitive_types.primitive_types
            .import()
            .set_list_nested($_: <List<int>>[
          [1, 2],
          [3, 4]
        ]),
        true,
      );
    });
    test("set tuple", () {
      expect(
        primitive_types.primitive_types
            .import()
            .set_tuple($_: PythonTuple<int>.from(<int>[1, 2, 3])),
        true,
      );
    });
    test("set set", () {
      expect(
        primitive_types.primitive_types.import().set_set($_: <int>{1, 2, 3}),
        true,
      );
    });
    test("set container nested", () {
      expect(
        primitive_types.primitive_types
            .import()
            .set_container_nested($_: <List<Set<int>>>[
          [
            {1, 2},
            {3, 4}
          ],
          [
            {5, 6},
            {7, 8}
          ]
        ]),
        true,
      );
    });
    test("set Iterator", () {
      expect(
        primitive_types.primitive_types
            .import()
            .set_Iterator($_: <int>[1, 2, 3].iterator),
        true,
      );
    });
    test("set Iterator nested", () {
      expect(
        primitive_types.primitive_types.import().set_Iterator_nested(
                $_: <List<int>>[
              [1, 2],
              [3, 4]
            ].iterator),
        true,
      );
    });
    test("set Generator", () {
      expect(
        primitive_types.primitive_types
            .import()
            .set_Generator($_: <int>[1, 2, 3].iterator),
        true,
      );
    });
    test("set Iterable", () {
      expect(
        primitive_types.primitive_types
            .import()
            .set_Iterable($_: _BasicIterable(<int>[1, 2, 3].iterator)),
        true,
      );
      expect(
        primitive_types.primitive_types.import().set_Iterable($_: [1, 2, 3]),
        true,
      );
    });
    test("set Callable", () {
      expect(
        primitive_types.primitive_types
            .import()
            .set_Callable($_: (int a) => "$a"),
        true,
      );
    });
    test("set Any", () {
      expect(
        primitive_types.primitive_types.import().set_Any($_: 1),
        true,
      );
    });
    test("set Any implicit", () {
      expect(
        primitive_types.primitive_types.import().set_Any_implicit($_: 1),
        true,
      );
    });
  });

  group("generic_types", () {
    test("module can be imported", () {
      expect(generic_types.generic_types.import(), anything);
    });

    test(
      "get Callable",
      () {
        // TODO: implement generics
        /*
      final T Function<T>(T) result =
          generic_types.generic_types.import().get_Callable_generic();
      expect(result, isA<T Function<T>(T)>());
      expect(result(1), 1);
      */
      },
      skip: "TODO: implement generics",
    );

    test("set Callable", () {
      expect(
        generic_types.generic_types.import().set_Callable($_: <T>(T a) => a),
        true,
      );
    });
  });

  group("class_types", () {
    test("module can be imported", () {
      expect(class_types.class_types.import(), anything);
    });

    test("class can be instantiated", () {
      expect(class_types.A(), anything);
    });
    test("class get", () {
      final class_types.A result = class_types.A().$get();
      expect(result, isA<class_types.A>());
      expect(result, class_types.A());
    });
    test("class set", () {
      expect(
        class_types.A().$set($_: class_types.A()),
        true,
      );
    });

    test("get A", () {
      final class_types.A result = class_types.class_types.import().get_A();
      expect(result, isA<class_types.A>());
      expect(result, class_types.A());
    });
    test("get list", () {
      final List<class_types.A> result =
          class_types.class_types.import().get_list_A();
      expect(result, isA<List<class_types.A>>());
      expect(result, <class_types.A>[class_types.A()]);
    });
    test("get map", () {
      final Map<String, class_types.A> result =
          class_types.class_types.import().get_map_A();
      expect(result, isA<Map<String, class_types.A>>());
      expect(result, <String, class_types.A>{"a": class_types.A()});
    });

    test("set A", () {
      expect(
        class_types.class_types.import().set_A($_: class_types.A()),
        true,
      );
    });
    test("set list", () {
      expect(
        class_types.class_types.import().set_list_A($_: <class_types.A>[
          class_types.A(),
        ]),
        true,
      );
    });
    test("set map", () {
      expect(
        class_types.class_types.import().set_map_A($_: <String, class_types.A>{
          "a": class_types.A(),
        }),
        true,
      );
    });
  });
}

final class _BasicIterable<E> with IterableMixin<E> implements Iterable<E> {
  _BasicIterable(this.iterator);

  @override
  final Iterator<E> iterator;
}
