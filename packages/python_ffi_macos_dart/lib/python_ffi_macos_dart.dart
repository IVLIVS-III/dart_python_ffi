/// Support for doing something awesome.
///
/// More dartdocs go here.
library python_ffi_macos_dart;

// TODO: Export any libraries intended for clients of this package.

import "dart:async";
import "dart:convert";
import "dart:ffi";
import "dart:io";
import "dart:typed_data";

import "package:ffi/ffi.dart";
import "package:python_ffi_interface/python_ffi_interface.dart";
import "package:python_ffi_macos_dart/src/ffi/generated_bindings.g.dart";

export "dart:ffi" show Pointer;

export "package:python_ffi_macos_dart/src/ffi/generated_bindings.g.dart"
    show PyObject;

part "src/class.dart";
part "src/exception.dart";
part "src/extensions/convert_to_dart_extension.dart";
part "src/extensions/convert_to_python_extension.dart";
part "src/extensions/function_extension.dart";
part "src/extensions/malloc_extension.dart";
part "src/extensions/object_extension.dart";
part "src/extensions/refcount_extension.dart";
part "src/extensions/type_extension.dart";
part "src/function.dart";
part "src/module.dart";
part "src/object.dart";
part "src/python_ffi_macos_dart_base.dart";
