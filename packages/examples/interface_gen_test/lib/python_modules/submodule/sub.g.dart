// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library sub;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## sub
final class sub extends PythonModule {
  sub.from(super.pythonModule) : super.from();

  static sub import() => PythonFfiDart.instance.importModule(
        "submodule.sub",
        sub.from,
      );
}
