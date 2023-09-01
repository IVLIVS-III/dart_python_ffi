// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library setters;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## FrozenAttributeError
///
/// ### python docstring
///
/// A frozen attribute has been attempted to be modified.
///
/// .. versionadded:: 20.1.0
///
/// ### python source
/// ```py
/// class FrozenAttributeError(FrozenError):
///     """
///     A frozen attribute has been attempted to be modified.
///
///     .. versionadded:: 20.1.0
///     """
/// ```
final class FrozenAttributeError extends PythonClass {
  factory FrozenAttributeError() => PythonFfiDart.instance.importClass(
        "attr.exceptions",
        "FrozenAttributeError",
        FrozenAttributeError.from,
        <Object?>[],
      );

  FrozenAttributeError.from(super.pythonClass) : super.from();

  /// ## name (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  Object? get name => getAttribute("name");

  /// ## name (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  set name(Object? name) => setAttribute("name", name);

  /// ## obj (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  Object? get obj => getAttribute("obj");

  /// ## obj (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  set obj(Object? obj) => setAttribute("obj", obj);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  set args(Object? args) => setAttribute("args", args);

  /// ## msg (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  Object? get msg => getAttribute("msg");

  /// ## msg (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  set msg(Object? msg) => setAttribute("msg", msg);
}

/// ## setters
///
/// ### python source
/// ```py
/// # SPDX-License-Identifier: MIT
///
/// from attr.setters import *  # noqa
/// ```
final class setters extends PythonModule {
  setters.from(super.pythonModule) : super.from();

  static setters import() => PythonFfiDart.instance.importModule(
        "attrs.setters",
        setters.from,
      );
}
