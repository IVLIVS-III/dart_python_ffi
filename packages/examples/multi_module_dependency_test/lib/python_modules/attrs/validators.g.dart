// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library validators;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## validators
///
/// ### python source
/// ```py
/// # SPDX-License-Identifier: MIT
///
/// from attr.validators import *  # noqa
/// ```
final class validators extends PythonModule {
  validators.from(super.pythonModule) : super.from();

  static validators import() => PythonFfiDart.instance.importModule(
        "attrs.validators",
        validators.from,
      );
}
