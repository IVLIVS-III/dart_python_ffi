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

  /// ## default_if_none
  ///
  /// ### python docstring
  ///
  /// A converter that allows to replace ``None`` values by *default* or the
  /// result of *factory*.
  ///
  /// :param default: Value to be used if ``None`` is passed. Passing an instance
  ///    of `attrs.Factory` is supported, however the ``takes_self`` option
  ///    is *not*.
  /// :param callable factory: A callable that takes no parameters whose result
  ///    is used if ``None`` is passed.
  ///
  /// :raises TypeError: If **neither** *default* or *factory* is passed.
  /// :raises TypeError: If **both** *default* and *factory* are passed.
  /// :raises ValueError: If an instance of `attrs.Factory` is passed with
  ///    ``takes_self=True``.
  ///
  /// .. versionadded:: 18.2.0
  ///
  /// ### python source
  /// ```py
  /// def default_if_none(default=NOTHING, factory=None):
  ///     """
  ///     A converter that allows to replace ``None`` values by *default* or the
  ///     result of *factory*.
  ///
  ///     :param default: Value to be used if ``None`` is passed. Passing an instance
  ///        of `attrs.Factory` is supported, however the ``takes_self`` option
  ///        is *not*.
  ///     :param callable factory: A callable that takes no parameters whose result
  ///        is used if ``None`` is passed.
  ///
  ///     :raises TypeError: If **neither** *default* or *factory* is passed.
  ///     :raises TypeError: If **both** *default* and *factory* are passed.
  ///     :raises ValueError: If an instance of `attrs.Factory` is passed with
  ///        ``takes_self=True``.
  ///
  ///     .. versionadded:: 18.2.0
  ///     """
  ///     if default is NOTHING and factory is None:
  ///         raise TypeError("Must pass either `default` or `factory`.")
  ///
  ///     if default is not NOTHING and factory is not None:
  ///         raise TypeError(
  ///             "Must pass either `default` or `factory` but not both."
  ///         )
  ///
  ///     if factory is not None:
  ///         default = Factory(factory)
  ///
  ///     if isinstance(default, Factory):
  ///         if default.takes_self:
  ///             raise ValueError(
  ///                 "`takes_self` is not supported by default_if_none."
  ///             )
  ///
  ///         def default_if_none_converter(val):
  ///             if val is not None:
  ///                 return val
  ///
  ///             return default.factory()
  ///
  ///     else:
  ///
  ///         def default_if_none_converter(val):
  ///             if val is not None:
  ///                 return val
  ///
  ///             return default
  ///
  ///     return default_if_none_converter
  /// ```
  Object? default_if_none({
    Object? $default,
    Object? $factory,
  }) =>
      getFunction("default_if_none").call(
        <Object?>[
          $default,
          $factory,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## optional
  ///
  /// ### python docstring
  ///
  /// A converter that allows an attribute to be optional. An optional attribute
  /// is one which can be set to ``None``.
  ///
  /// Type annotations will be inferred from the wrapped converter's, if it
  /// has any.
  ///
  /// :param callable converter: the converter that is used for non-``None``
  ///     values.
  ///
  /// .. versionadded:: 17.1.0
  ///
  /// ### python source
  /// ```py
  /// def optional(converter):
  ///     """
  ///     A converter that allows an attribute to be optional. An optional attribute
  ///     is one which can be set to ``None``.
  ///
  ///     Type annotations will be inferred from the wrapped converter's, if it
  ///     has any.
  ///
  ///     :param callable converter: the converter that is used for non-``None``
  ///         values.
  ///
  ///     .. versionadded:: 17.1.0
  ///     """
  ///
  ///     def optional_converter(val):
  ///         if val is None:
  ///             return None
  ///         return converter(val)
  ///
  ///     xtr = _AnnotationExtractor(converter)
  ///
  ///     t = xtr.get_first_param_type()
  ///     if t:
  ///         optional_converter.__annotations__["val"] = typing.Optional[t]
  ///
  ///     rt = xtr.get_return_type()
  ///     if rt:
  ///         optional_converter.__annotations__["return"] = typing.Optional[rt]
  ///
  ///     return optional_converter
  /// ```
  Object? optional({
    required Object? converter,
  }) =>
      getFunction("optional").call(
        <Object?>[
          converter,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## pipe
  ///
  /// ### python docstring
  ///
  /// A converter that composes multiple converters into one.
  ///
  /// When called on a value, it runs all wrapped converters, returning the
  /// *last* value.
  ///
  /// Type annotations will be inferred from the wrapped converters', if
  /// they have any.
  ///
  /// :param callables converters: Arbitrary number of converters.
  ///
  /// .. versionadded:: 20.1.0
  ///
  /// ### python source
  /// ```py
  /// def pipe(*converters):
  ///     """
  ///     A converter that composes multiple converters into one.
  ///
  ///     When called on a value, it runs all wrapped converters, returning the
  ///     *last* value.
  ///
  ///     Type annotations will be inferred from the wrapped converters', if
  ///     they have any.
  ///
  ///     :param callables converters: Arbitrary number of converters.
  ///
  ///     .. versionadded:: 20.1.0
  ///     """
  ///
  ///     def pipe_converter(val):
  ///         for converter in converters:
  ///             val = converter(val)
  ///
  ///         return val
  ///
  ///     if not converters:
  ///         # If the converter list is empty, pipe_converter is the identity.
  ///         A = typing.TypeVar("A")
  ///         pipe_converter.__annotations__ = {"val": A, "return": A}
  ///     else:
  ///         # Get parameter type from first converter.
  ///         t = _AnnotationExtractor(converters[0]).get_first_param_type()
  ///         if t:
  ///             pipe_converter.__annotations__["val"] = t
  ///
  ///         # Get return type from last converter.
  ///         rt = _AnnotationExtractor(converters[-1]).get_return_type()
  ///         if rt:
  ///             pipe_converter.__annotations__["return"] = rt
  ///
  ///     return pipe_converter
  /// ```
  Object? pipe({
    List<Object?> converters = const <Object?>[],
  }) =>
      getFunction("pipe").call(
        <Object?>[
          ...converters,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## to_bool
  ///
  /// ### python docstring
  ///
  /// Convert "boolean" strings (e.g., from env. vars.) to real booleans.
  ///
  /// Values mapping to :code:`True`:
  ///
  /// - :code:`True`
  /// - :code:`"true"` / :code:`"t"`
  /// - :code:`"yes"` / :code:`"y"`
  /// - :code:`"on"`
  /// - :code:`"1"`
  /// - :code:`1`
  ///
  /// Values mapping to :code:`False`:
  ///
  /// - :code:`False`
  /// - :code:`"false"` / :code:`"f"`
  /// - :code:`"no"` / :code:`"n"`
  /// - :code:`"off"`
  /// - :code:`"0"`
  /// - :code:`0`
  ///
  /// :raises ValueError: for any other value.
  ///
  /// .. versionadded:: 21.3.0
  ///
  /// ### python source
  /// ```py
  /// def to_bool(val):
  ///     """
  ///     Convert "boolean" strings (e.g., from env. vars.) to real booleans.
  ///
  ///     Values mapping to :code:`True`:
  ///
  ///     - :code:`True`
  ///     - :code:`"true"` / :code:`"t"`
  ///     - :code:`"yes"` / :code:`"y"`
  ///     - :code:`"on"`
  ///     - :code:`"1"`
  ///     - :code:`1`
  ///
  ///     Values mapping to :code:`False`:
  ///
  ///     - :code:`False`
  ///     - :code:`"false"` / :code:`"f"`
  ///     - :code:`"no"` / :code:`"n"`
  ///     - :code:`"off"`
  ///     - :code:`"0"`
  ///     - :code:`0`
  ///
  ///     :raises ValueError: for any other value.
  ///
  ///     .. versionadded:: 21.3.0
  ///     """
  ///     if isinstance(val, str):
  ///         val = val.lower()
  ///     truthy = {True, "true", "t", "yes", "y", "on", "1", 1}
  ///     falsy = {False, "false", "f", "no", "n", "off", "0", 0}
  ///     try:
  ///         if val in truthy:
  ///             return True
  ///         if val in falsy:
  ///             return False
  ///     except TypeError:
  ///         # Raised when "val" is not hashable (e.g., lists)
  ///         pass
  ///     raise ValueError(f"Cannot convert value to bool: {val}")
  /// ```
  Object? to_bool({
    required Object? val,
  }) =>
      getFunction("to_bool").call(
        <Object?>[
          val,
        ],
        kwargs: <String, Object?>{},
      );
}
