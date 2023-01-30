/// Support for doing something awesome.
///
/// More dartdocs go here.
library python_ffi_macos_dart;

// TODO: Export any libraries intended for clients of this package.

import "dart:async";
import "dart:collection";
import "dart:ffi";
import "dart:io";
import "dart:typed_data";

import "package:ffi/ffi.dart";

import "package:python_ffi_macos_dart/src/ffi/generated_bindings.g.dart";
import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";

part "src/python_ffi_macos_dart_base.dart";

part "src/class.dart";

part "src/exception.dart";

part "src/extensions/convert_extension.dart";

part "src/extensions/malloc_extension.dart";

part "src/extensions/object_extension.dart";

part "src/function.dart";

part "src/module.dart";

part "src/object.dart";

// const String _libName = "libpython3.11";
const String _libPath =
    "/Library/Frameworks/Python.framework/Versions/3.11/Python";
