// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library packaging;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## packaging
///
/// ### python source
/// ```py
/// # This file is dual licensed under the terms of the Apache License, Version
/// # 2.0, and the BSD License. See the LICENSE file in the root of this repository
/// # for complete details.
///
/// __title__ = "packaging"
/// __summary__ = "Core utilities for Python packages"
/// __uri__ = "https://github.com/pypa/packaging"
///
/// __version__ = "23.1"
///
/// __author__ = "Donald Stufft and individual contributors"
/// __email__ = "donald@stufft.io"
///
/// __license__ = "BSD-2-Clause or Apache-2.0"
/// __copyright__ = "2014-2019 %s" % __author__
/// ```
final class packaging extends PythonModule {
  packaging.from(super.pythonModule) : super.from();

  static packaging import() => PythonFfiDart.instance.importModule(
        "packaging",
        packaging.from,
      );
}
