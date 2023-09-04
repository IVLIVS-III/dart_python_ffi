// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library tests;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## tests
///
/// ### python docstring
///
/// __init__.py
/// (c) Will Roberts  18 February, 2015
///
/// pytimeparse.tests module
///
/// ### python source
/// ```py
/// #!/usr/bin/env python
/// # -*- coding: utf-8 -*-
///
/// '''
/// __init__.py
/// (c) Will Roberts  18 February, 2015
///
/// pytimeparse.tests module
/// '''
/// ```
final class tests extends PythonModule {
  tests.from(super.pythonModule) : super.from();

  static tests import() => PythonFfiDart.instance.importModule(
        "pytimeparse.tests",
        tests.from,
      );
}
