/// MacOS and Windows implementation of python_ffi_dart.
library python_ffi_cpython_dart;

import "dart:async";
import "dart:convert";
import "dart:ffi";
import "dart:io";
import "dart:typed_data";

import "package:ffi/ffi.dart";
import "package:python_ffi_cpython_dart/src/ffi/generated_bindings.g.dart";
import "package:python_ffi_interface/python_ffi_interface.dart";

export "dart:ffi" show Pointer;

export "package:python_ffi_cpython_dart/src/ffi/generated_bindings.g.dart"
    show PyObject;
export "package:python_ffi_cpython_dart/src/ffi/generated_bindings.g.dart"
    show DartPythonCBindings;

part "src/assets/libpython3.11.so.dart";
part "src/assets/python311.dll.dart";
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
part "src/python_ffi_cpython_dart_base.dart";
