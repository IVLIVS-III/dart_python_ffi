/// A Dart wrapper of [pytimeparse](https://pypi.org/project/pytimeparse/), a
/// Python library for parsing human-readable time strings.
library pytimeparse_dart;

import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:pytimeparse_dart/python_modules/src/python_modules.g.dart";

export "extensions.dart";
export "python_modules/pytimeparse.g.dart";

Future<void> initialize({String? libPath}) async {
  await PythonFfiDart.instance.initialize(kPythonModules, libPath: libPath);
}
