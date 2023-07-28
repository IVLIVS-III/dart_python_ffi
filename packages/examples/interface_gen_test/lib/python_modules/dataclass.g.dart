// ignore_for_file: camel_case_types, non_constant_identifier_names

library dataclass;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## DataClass
///
/// ### python docstring
///
/// DataClass(field0: int, field1: int = 1)
///
/// ### python source
/// ```py
/// @dataclass
/// class DataClass:
///     field0: int
///     field1: int = 1
///     field2: int = field(init=False, default=2)
/// ```
final class DataClass extends PythonClass {
  factory DataClass({
    required Object? field0,
    Object? field1 = 1,
  }) =>
      PythonFfiDart.instance.importClass(
        "dataclass",
        "DataClass",
        DataClass.from,
        <Object?>[
          field0,
          field1,
        ],
        <String, Object?>{},
      );

  DataClass.from(super.pythonClass) : super.from();

  /// ## field1 (getter)
  Object? get field1 => getAttribute("field1");

  /// ## field1 (setter)
  set field1(Object? field1) => setAttribute("field1", field1);

  /// ## field2 (getter)
  Object? get field2 => getAttribute("field2");

  /// ## field2 (setter)
  set field2(Object? field2) => setAttribute("field2", field2);

  /// ## field0 (getter)
  Object? get field0 => getAttribute("field0");

  /// ## field0 (setter)
  set field0(Object? field0) => setAttribute("field0", field0);
}

/// ## dataclass
///
/// ### python source
/// ```py
/// from dataclasses import dataclass, field
///
/// @dataclass
/// class DataClass:
///     field0: int
///     field1: int = 1
///     field2: int = field(init=False, default=2)
/// ```
final class dataclass extends PythonModule {
  dataclass.from(super.pythonModule) : super.from();

  static dataclass import() => PythonFfiDart.instance.importModule(
        "dataclass",
        dataclass.from,
      );
}
