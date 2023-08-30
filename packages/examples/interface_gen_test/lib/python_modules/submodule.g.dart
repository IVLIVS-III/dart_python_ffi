// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library submodule;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## submodule
final class submodule extends PythonModule {
  submodule.from(super.pythonModule) : super.from();

  static submodule import() => PythonFfiDart.instance.importModule(
        "submodule",
        submodule.from,
      );
}
