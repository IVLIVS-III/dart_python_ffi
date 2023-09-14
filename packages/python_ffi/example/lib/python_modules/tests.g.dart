// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library tests;

import "package:python_ffi/python_ffi.dart";

/// ## tests
final class tests extends PythonModule {
  tests.from(super.pythonModule) : super.from();

  static tests import() => PythonFfi.instance.importModule(
        "tests",
        tests.from,
      );
}
