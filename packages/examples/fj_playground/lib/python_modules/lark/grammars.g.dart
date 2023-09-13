// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library grammars;

import "package:python_ffi/python_ffi.dart";

/// ## grammars
final class grammars extends PythonModule {
  grammars.from(super.pythonModule) : super.from();

  static grammars import() => PythonFfi.instance.importModule(
        "lark.grammars",
        grammars.from,
      );
}
