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
        "attr.setters",
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
/// ### python docstring
///
/// Commonly used hooks for on_setattr.
///
/// ### python source
/// ```py
/// # SPDX-License-Identifier: MIT
///
/// """
/// Commonly used hooks for on_setattr.
/// """
///
///
/// from . import _config
/// from .exceptions import FrozenAttributeError
///
///
/// def pipe(*setters):
///     """
///     Run all *setters* and return the return value of the last one.
///
///     .. versionadded:: 20.1.0
///     """
///
///     def wrapped_pipe(instance, attrib, new_value):
///         rv = new_value
///
///         for setter in setters:
///             rv = setter(instance, attrib, rv)
///
///         return rv
///
///     return wrapped_pipe
///
///
/// def frozen(_, __, ___):
///     """
///     Prevent an attribute to be modified.
///
///     .. versionadded:: 20.1.0
///     """
///     raise FrozenAttributeError()
///
///
/// def validate(instance, attrib, new_value):
///     """
///     Run *attrib*'s validator on *new_value* if it has one.
///
///     .. versionadded:: 20.1.0
///     """
///     if _config._run_validators is False:
///         return new_value
///
///     v = attrib.validator
///     if not v:
///         return new_value
///
///     v(instance, attrib, new_value)
///
///     return new_value
///
///
/// def convert(instance, attrib, new_value):
///     """
///     Run *attrib*'s converter -- if it has one --  on *new_value* and return the
///     result.
///
///     .. versionadded:: 20.1.0
///     """
///     c = attrib.converter
///     if c:
///         return c(new_value)
///
///     return new_value
///
///
/// # Sentinel for disabling class-wide *on_setattr* hooks for certain attributes.
/// # autodata stopped working, so the docstring is inlined in the API docs.
/// NO_OP = object()
/// ```
final class setters extends PythonModule {
  setters.from(super.pythonModule) : super.from();

  static setters import() => PythonFfiDart.instance.importModule(
        "attr.setters",
        setters.from,
      );

  /// ## convert
  ///
  /// ### python docstring
  ///
  /// Run *attrib*'s converter -- if it has one --  on *new_value* and return the
  /// result.
  ///
  /// .. versionadded:: 20.1.0
  ///
  /// ### python source
  /// ```py
  /// def convert(instance, attrib, new_value):
  ///     """
  ///     Run *attrib*'s converter -- if it has one --  on *new_value* and return the
  ///     result.
  ///
  ///     .. versionadded:: 20.1.0
  ///     """
  ///     c = attrib.converter
  ///     if c:
  ///         return c(new_value)
  ///
  ///     return new_value
  /// ```
  Object? convert({
    required Object? instance,
    required Object? attrib,
    required Object? new_value,
  }) =>
      getFunction("convert").call(
        <Object?>[
          instance,
          attrib,
          new_value,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## frozen
  ///
  /// ### python docstring
  ///
  /// Prevent an attribute to be modified.
  ///
  /// .. versionadded:: 20.1.0
  ///
  /// ### python source
  /// ```py
  /// def frozen(_, __, ___):
  ///     """
  ///     Prevent an attribute to be modified.
  ///
  ///     .. versionadded:: 20.1.0
  ///     """
  ///     raise FrozenAttributeError()
  /// ```
  Object? frozen({
    required Object? $_,
    required Object? $__,
    required Object? $___,
  }) =>
      getFunction("frozen").call(
        <Object?>[
          $_,
          $__,
          $___,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## pipe
  ///
  /// ### python docstring
  ///
  /// Run all *setters* and return the return value of the last one.
  ///
  /// .. versionadded:: 20.1.0
  ///
  /// ### python source
  /// ```py
  /// def pipe(*setters):
  ///     """
  ///     Run all *setters* and return the return value of the last one.
  ///
  ///     .. versionadded:: 20.1.0
  ///     """
  ///
  ///     def wrapped_pipe(instance, attrib, new_value):
  ///         rv = new_value
  ///
  ///         for setter in setters:
  ///             rv = setter(instance, attrib, rv)
  ///
  ///         return rv
  ///
  ///     return wrapped_pipe
  /// ```
  Object? pipe({
    List<Object?> setters = const <Object?>[],
  }) =>
      getFunction("pipe").call(
        <Object?>[
          ...setters,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## validate
  ///
  /// ### python docstring
  ///
  /// Run *attrib*'s validator on *new_value* if it has one.
  ///
  /// .. versionadded:: 20.1.0
  ///
  /// ### python source
  /// ```py
  /// def validate(instance, attrib, new_value):
  ///     """
  ///     Run *attrib*'s validator on *new_value* if it has one.
  ///
  ///     .. versionadded:: 20.1.0
  ///     """
  ///     if _config._run_validators is False:
  ///         return new_value
  ///
  ///     v = attrib.validator
  ///     if not v:
  ///         return new_value
  ///
  ///     v(instance, attrib, new_value)
  ///
  ///     return new_value
  /// ```
  Object? validate({
    required Object? instance,
    required Object? attrib,
    required Object? new_value,
  }) =>
      getFunction("validate").call(
        <Object?>[
          instance,
          attrib,
          new_value,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## NO_OP (getter)
  ///
  /// ### python docstring
  ///
  /// Commonly used hooks for on_setattr.
  Object? get NO_OP => getAttribute("NO_OP");

  /// ## NO_OP (setter)
  ///
  /// ### python docstring
  ///
  /// Commonly used hooks for on_setattr.
  set NO_OP(Object? NO_OP) => setAttribute("NO_OP", NO_OP);
}
