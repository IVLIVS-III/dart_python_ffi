// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library converters;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## converters
///
/// ### python source
/// ```py
/// # SPDX-License-Identifier: MIT
///
/// from attr.converters import *  # noqa
/// ```
final class converters extends PythonModule {
  converters.from(super.pythonModule) : super.from();

  static converters import() => PythonFfiDart.instance.importModule(
        "attrs.converters",
        converters.from,
      );
}
