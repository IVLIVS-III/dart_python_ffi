/// Support for doing something awesome.
///
/// More dartdocs go here.
library python_ffi_dart;

import "dart:async";

import "dart:io";

import "package:python_ffi_macos/python_ffi_macos.dart";
import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";

part "src/python_ffi_dart_base.dart";

part "src/extensions/register_python_class_names.dart";

part "src/class.dart";

part "src/module.dart";

part "src/object.dart";

// TODO: Export any libraries intended for clients of this package.
