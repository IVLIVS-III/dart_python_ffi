// ignore_for_file: camel_case_types, non_constant_identifier_names

library empty_module;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## empty_module
final class empty_module extends PythonModule {
  empty_module.from(super.pythonModule) : super.from();

  static empty_module import() => PythonFfiDart.instance.importModule(
        "empty_module",
        empty_module.from,
      );
}
