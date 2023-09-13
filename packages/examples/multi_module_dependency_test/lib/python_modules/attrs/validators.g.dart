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

  /// ## and_
  ///
  /// ### python docstring
  ///
  /// A validator that composes multiple validators into one.
  ///
  /// When called on a value, it runs all wrapped validators.
  ///
  /// :param callables validators: Arbitrary number of validators.
  ///
  /// .. versionadded:: 17.1.0
  ///
  /// ### python source
  /// ```py
  /// def and_(*validators):
  ///     """
  ///     A validator that composes multiple validators into one.
  ///
  ///     When called on a value, it runs all wrapped validators.
  ///
  ///     :param callables validators: Arbitrary number of validators.
  ///
  ///     .. versionadded:: 17.1.0
  ///     """
  ///     vals = []
  ///     for validator in validators:
  ///         vals.extend(
  ///             validator._validators
  ///             if isinstance(validator, _AndValidator)
  ///             else [validator]
  ///         )
  ///
  ///     return _AndValidator(tuple(vals))
  /// ```
  Object? and_({
    List<Object?> validators = const <Object?>[],
  }) =>
      getFunction("and_").call(
        <Object?>[
          ...validators,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## deep_iterable
  ///
  /// ### python docstring
  ///
  /// A validator that performs deep validation of an iterable.
  ///
  /// :param member_validator: Validator(s) to apply to iterable members
  /// :param iterable_validator: Validator to apply to iterable itself
  ///     (optional)
  ///
  /// .. versionadded:: 19.1.0
  ///
  /// :raises TypeError: if any sub-validators fail
  ///
  /// ### python source
  /// ```py
  /// def deep_iterable(member_validator, iterable_validator=None):
  ///     """
  ///     A validator that performs deep validation of an iterable.
  ///
  ///     :param member_validator: Validator(s) to apply to iterable members
  ///     :param iterable_validator: Validator to apply to iterable itself
  ///         (optional)
  ///
  ///     .. versionadded:: 19.1.0
  ///
  ///     :raises TypeError: if any sub-validators fail
  ///     """
  ///     if isinstance(member_validator, (list, tuple)):
  ///         member_validator = and_(*member_validator)
  ///     return _DeepIterable(member_validator, iterable_validator)
  /// ```
  Object? deep_iterable({
    required Object? member_validator,
    Object? iterable_validator,
  }) =>
      getFunction("deep_iterable").call(
        <Object?>[
          member_validator,
          iterable_validator,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## deep_mapping
  ///
  /// ### python docstring
  ///
  /// A validator that performs deep validation of a dictionary.
  ///
  /// :param key_validator: Validator to apply to dictionary keys
  /// :param value_validator: Validator to apply to dictionary values
  /// :param mapping_validator: Validator to apply to top-level mapping
  ///     attribute (optional)
  ///
  /// .. versionadded:: 19.1.0
  ///
  /// :raises TypeError: if any sub-validators fail
  ///
  /// ### python source
  /// ```py
  /// def deep_mapping(key_validator, value_validator, mapping_validator=None):
  ///     """
  ///     A validator that performs deep validation of a dictionary.
  ///
  ///     :param key_validator: Validator to apply to dictionary keys
  ///     :param value_validator: Validator to apply to dictionary values
  ///     :param mapping_validator: Validator to apply to top-level mapping
  ///         attribute (optional)
  ///
  ///     .. versionadded:: 19.1.0
  ///
  ///     :raises TypeError: if any sub-validators fail
  ///     """
  ///     return _DeepMapping(key_validator, value_validator, mapping_validator)
  /// ```
  Object? deep_mapping({
    required Object? key_validator,
    required Object? value_validator,
    Object? mapping_validator,
  }) =>
      getFunction("deep_mapping").call(
        <Object?>[
          key_validator,
          value_validator,
          mapping_validator,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## ge
  ///
  /// ### python docstring
  ///
  /// A validator that raises `ValueError` if the initializer is called
  /// with a number smaller than *val*.
  ///
  /// :param val: Inclusive lower bound for values
  ///
  /// .. versionadded:: 21.3.0
  ///
  /// ### python source
  /// ```py
  /// def ge(val):
  ///     """
  ///     A validator that raises `ValueError` if the initializer is called
  ///     with a number smaller than *val*.
  ///
  ///     :param val: Inclusive lower bound for values
  ///
  ///     .. versionadded:: 21.3.0
  ///     """
  ///     return _NumberValidator(val, ">=", operator.ge)
  /// ```
  Object? ge({
    required Object? val,
  }) =>
      getFunction("ge").call(
        <Object?>[
          val,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## get_disabled
  ///
  /// ### python docstring
  ///
  /// Return a bool indicating whether validators are currently disabled or not.
  ///
  /// :return: ``True`` if validators are currently disabled.
  /// :rtype: bool
  ///
  /// .. versionadded:: 21.3.0
  ///
  /// ### python source
  /// ```py
  /// def get_disabled():
  ///     """
  ///     Return a bool indicating whether validators are currently disabled or not.
  ///
  ///     :return: ``True`` if validators are currently disabled.
  ///     :rtype: bool
  ///
  ///     .. versionadded:: 21.3.0
  ///     """
  ///     return not get_run_validators()
  /// ```
  Object? get_disabled() => getFunction("get_disabled").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## gt
  ///
  /// ### python docstring
  ///
  /// A validator that raises `ValueError` if the initializer is called
  /// with a number smaller or equal to *val*.
  ///
  /// :param val: Exclusive lower bound for values
  ///
  /// .. versionadded:: 21.3.0
  ///
  /// ### python source
  /// ```py
  /// def gt(val):
  ///     """
  ///     A validator that raises `ValueError` if the initializer is called
  ///     with a number smaller or equal to *val*.
  ///
  ///     :param val: Exclusive lower bound for values
  ///
  ///     .. versionadded:: 21.3.0
  ///     """
  ///     return _NumberValidator(val, ">", operator.gt)
  /// ```
  Object? gt({
    required Object? val,
  }) =>
      getFunction("gt").call(
        <Object?>[
          val,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## in_
  ///
  /// ### python docstring
  ///
  /// A validator that raises a `ValueError` if the initializer is called
  /// with a value that does not belong in the options provided.  The check is
  /// performed using ``value in options``.
  ///
  /// :param options: Allowed options.
  /// :type options: list, tuple, `enum.Enum`, ...
  ///
  /// :raises ValueError: With a human readable error message, the attribute (of
  ///    type `attrs.Attribute`), the expected options, and the value it
  ///    got.
  ///
  /// .. versionadded:: 17.1.0
  /// .. versionchanged:: 22.1.0
  ///    The ValueError was incomplete until now and only contained the human
  ///    readable error message. Now it contains all the information that has
  ///    been promised since 17.1.0.
  ///
  /// ### python source
  /// ```py
  /// def in_(options):
  ///     """
  ///     A validator that raises a `ValueError` if the initializer is called
  ///     with a value that does not belong in the options provided.  The check is
  ///     performed using ``value in options``.
  ///
  ///     :param options: Allowed options.
  ///     :type options: list, tuple, `enum.Enum`, ...
  ///
  ///     :raises ValueError: With a human readable error message, the attribute (of
  ///        type `attrs.Attribute`), the expected options, and the value it
  ///        got.
  ///
  ///     .. versionadded:: 17.1.0
  ///     .. versionchanged:: 22.1.0
  ///        The ValueError was incomplete until now and only contained the human
  ///        readable error message. Now it contains all the information that has
  ///        been promised since 17.1.0.
  ///     """
  ///     return _InValidator(options)
  /// ```
  Object? in_({
    required Object? options,
  }) =>
      getFunction("in_").call(
        <Object?>[
          options,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## instance_of
  ///
  /// ### python docstring
  ///
  /// A validator that raises a `TypeError` if the initializer is called
  /// with a wrong type for this particular attribute (checks are performed using
  /// `isinstance` therefore it's also valid to pass a tuple of types).
  ///
  /// :param type: The type to check for.
  /// :type type: type or tuple of type
  ///
  /// :raises TypeError: With a human readable error message, the attribute
  ///     (of type `attrs.Attribute`), the expected type, and the value it
  ///     got.
  ///
  /// ### python source
  /// ```py
  /// def instance_of(type):
  ///     """
  ///     A validator that raises a `TypeError` if the initializer is called
  ///     with a wrong type for this particular attribute (checks are performed using
  ///     `isinstance` therefore it's also valid to pass a tuple of types).
  ///
  ///     :param type: The type to check for.
  ///     :type type: type or tuple of type
  ///
  ///     :raises TypeError: With a human readable error message, the attribute
  ///         (of type `attrs.Attribute`), the expected type, and the value it
  ///         got.
  ///     """
  ///     return _InstanceOfValidator(type)
  /// ```
  Object? instance_of({
    required Object? type,
  }) =>
      getFunction("instance_of").call(
        <Object?>[
          type,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## is_callable
  ///
  /// ### python docstring
  ///
  /// A validator that raises a `attrs.exceptions.NotCallableError` if the
  /// initializer is called with a value for this particular attribute
  /// that is not callable.
  ///
  /// .. versionadded:: 19.1.0
  ///
  /// :raises attrs.exceptions.NotCallableError: With a human readable error
  ///     message containing the attribute (`attrs.Attribute`) name,
  ///     and the value it got.
  ///
  /// ### python source
  /// ```py
  /// def is_callable():
  ///     """
  ///     A validator that raises a `attrs.exceptions.NotCallableError` if the
  ///     initializer is called with a value for this particular attribute
  ///     that is not callable.
  ///
  ///     .. versionadded:: 19.1.0
  ///
  ///     :raises attrs.exceptions.NotCallableError: With a human readable error
  ///         message containing the attribute (`attrs.Attribute`) name,
  ///         and the value it got.
  ///     """
  ///     return _IsCallableValidator()
  /// ```
  Object? is_callable() => getFunction("is_callable").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## le
  ///
  /// ### python docstring
  ///
  /// A validator that raises `ValueError` if the initializer is called
  /// with a number greater than *val*.
  ///
  /// :param val: Inclusive upper bound for values
  ///
  /// .. versionadded:: 21.3.0
  ///
  /// ### python source
  /// ```py
  /// def le(val):
  ///     """
  ///     A validator that raises `ValueError` if the initializer is called
  ///     with a number greater than *val*.
  ///
  ///     :param val: Inclusive upper bound for values
  ///
  ///     .. versionadded:: 21.3.0
  ///     """
  ///     return _NumberValidator(val, "<=", operator.le)
  /// ```
  Object? le({
    required Object? val,
  }) =>
      getFunction("le").call(
        <Object?>[
          val,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## lt
  ///
  /// ### python docstring
  ///
  /// A validator that raises `ValueError` if the initializer is called
  /// with a number larger or equal to *val*.
  ///
  /// :param val: Exclusive upper bound for values
  ///
  /// .. versionadded:: 21.3.0
  ///
  /// ### python source
  /// ```py
  /// def lt(val):
  ///     """
  ///     A validator that raises `ValueError` if the initializer is called
  ///     with a number larger or equal to *val*.
  ///
  ///     :param val: Exclusive upper bound for values
  ///
  ///     .. versionadded:: 21.3.0
  ///     """
  ///     return _NumberValidator(val, "<", operator.lt)
  /// ```
  Object? lt({
    required Object? val,
  }) =>
      getFunction("lt").call(
        <Object?>[
          val,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## matches_re
  ///
  /// ### python docstring
  ///
  /// A validator that raises `ValueError` if the initializer is called
  /// with a string that doesn't match *regex*.
  ///
  /// :param regex: a regex string or precompiled pattern to match against
  /// :param int flags: flags that will be passed to the underlying re function
  ///     (default 0)
  /// :param callable func: which underlying `re` function to call. Valid options
  ///     are `re.fullmatch`, `re.search`, and `re.match`; the default ``None``
  ///     means `re.fullmatch`. For performance reasons, the pattern is always
  ///     precompiled using `re.compile`.
  ///
  /// .. versionadded:: 19.2.0
  /// .. versionchanged:: 21.3.0 *regex* can be a pre-compiled pattern.
  ///
  /// ### python source
  /// ```py
  /// def matches_re(regex, flags=0, func=None):
  ///     r"""
  ///     A validator that raises `ValueError` if the initializer is called
  ///     with a string that doesn't match *regex*.
  ///
  ///     :param regex: a regex string or precompiled pattern to match against
  ///     :param int flags: flags that will be passed to the underlying re function
  ///         (default 0)
  ///     :param callable func: which underlying `re` function to call. Valid options
  ///         are `re.fullmatch`, `re.search`, and `re.match`; the default ``None``
  ///         means `re.fullmatch`. For performance reasons, the pattern is always
  ///         precompiled using `re.compile`.
  ///
  ///     .. versionadded:: 19.2.0
  ///     .. versionchanged:: 21.3.0 *regex* can be a pre-compiled pattern.
  ///     """
  ///     valid_funcs = (re.fullmatch, None, re.search, re.match)
  ///     if func not in valid_funcs:
  ///         raise ValueError(
  ///             "'func' must be one of {}.".format(
  ///                 ", ".join(
  ///                     sorted(
  ///                         e and e.__name__ or "None" for e in set(valid_funcs)
  ///                     )
  ///                 )
  ///             )
  ///         )
  ///
  ///     if isinstance(regex, Pattern):
  ///         if flags:
  ///             raise TypeError(
  ///                 "'flags' can only be used with a string pattern; "
  ///                 "pass flags to re.compile() instead"
  ///             )
  ///         pattern = regex
  ///     else:
  ///         pattern = re.compile(regex, flags)
  ///
  ///     if func is re.match:
  ///         match_func = pattern.match
  ///     elif func is re.search:
  ///         match_func = pattern.search
  ///     else:
  ///         match_func = pattern.fullmatch
  ///
  ///     return _MatchesReValidator(pattern, match_func)
  /// ```
  Object? matches_re({
    required Object? regex,
    Object? flags = 0,
    Object? func,
  }) =>
      getFunction("matches_re").call(
        <Object?>[
          regex,
          flags,
          func,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## max_len
  ///
  /// ### python docstring
  ///
  /// A validator that raises `ValueError` if the initializer is called
  /// with a string or iterable that is longer than *length*.
  ///
  /// :param int length: Maximum length of the string or iterable
  ///
  /// .. versionadded:: 21.3.0
  ///
  /// ### python source
  /// ```py
  /// def max_len(length):
  ///     """
  ///     A validator that raises `ValueError` if the initializer is called
  ///     with a string or iterable that is longer than *length*.
  ///
  ///     :param int length: Maximum length of the string or iterable
  ///
  ///     .. versionadded:: 21.3.0
  ///     """
  ///     return _MaxLengthValidator(length)
  /// ```
  Object? max_len({
    required Object? length,
  }) =>
      getFunction("max_len").call(
        <Object?>[
          length,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## min_len
  ///
  /// ### python docstring
  ///
  /// A validator that raises `ValueError` if the initializer is called
  /// with a string or iterable that is shorter than *length*.
  ///
  /// :param int length: Minimum length of the string or iterable
  ///
  /// .. versionadded:: 22.1.0
  ///
  /// ### python source
  /// ```py
  /// def min_len(length):
  ///     """
  ///     A validator that raises `ValueError` if the initializer is called
  ///     with a string or iterable that is shorter than *length*.
  ///
  ///     :param int length: Minimum length of the string or iterable
  ///
  ///     .. versionadded:: 22.1.0
  ///     """
  ///     return _MinLengthValidator(length)
  /// ```
  Object? min_len({
    required Object? length,
  }) =>
      getFunction("min_len").call(
        <Object?>[
          length,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## not_
  ///
  /// ### python docstring
  ///
  /// A validator that wraps and logically 'inverts' the validator passed to it.
  /// It will raise a `ValueError` if the provided validator *doesn't* raise a
  /// `ValueError` or `TypeError` (by default), and will suppress the exception
  /// if the provided validator *does*.
  ///
  /// Intended to be used with existing validators to compose logic without
  /// needing to create inverted variants, for example, ``not_(in_(...))``.
  ///
  /// :param validator: A validator to be logically inverted.
  /// :param msg: Message to raise if validator fails.
  ///     Formatted with keys ``exc_types`` and ``validator``.
  /// :type msg: str
  /// :param exc_types: Exception type(s) to capture.
  ///     Other types raised by child validators will not be intercepted and
  ///     pass through.
  ///
  /// :raises ValueError: With a human readable error message,
  ///     the attribute (of type `attrs.Attribute`),
  ///     the validator that failed to raise an exception,
  ///     the value it got,
  ///     and the expected exception types.
  ///
  /// .. versionadded:: 22.2.0
  ///
  /// ### python source
  /// ```py
  /// def not_(validator, *, msg=None, exc_types=(ValueError, TypeError)):
  ///     """
  ///     A validator that wraps and logically 'inverts' the validator passed to it.
  ///     It will raise a `ValueError` if the provided validator *doesn't* raise a
  ///     `ValueError` or `TypeError` (by default), and will suppress the exception
  ///     if the provided validator *does*.
  ///
  ///     Intended to be used with existing validators to compose logic without
  ///     needing to create inverted variants, for example, ``not_(in_(...))``.
  ///
  ///     :param validator: A validator to be logically inverted.
  ///     :param msg: Message to raise if validator fails.
  ///         Formatted with keys ``exc_types`` and ``validator``.
  ///     :type msg: str
  ///     :param exc_types: Exception type(s) to capture.
  ///         Other types raised by child validators will not be intercepted and
  ///         pass through.
  ///
  ///     :raises ValueError: With a human readable error message,
  ///         the attribute (of type `attrs.Attribute`),
  ///         the validator that failed to raise an exception,
  ///         the value it got,
  ///         and the expected exception types.
  ///
  ///     .. versionadded:: 22.2.0
  ///     """
  ///     try:
  ///         exc_types = tuple(exc_types)
  ///     except TypeError:
  ///         exc_types = (exc_types,)
  ///     return _NotValidator(validator, msg, exc_types)
  /// ```
  Object? not_({
    required Object? validator,
    Object? msg,
    Object? exc_types = const [null, null],
  }) =>
      getFunction("not_").call(
        <Object?>[
          validator,
        ],
        kwargs: <String, Object?>{
          "msg": msg,
          "exc_types": exc_types,
        },
      );

  /// ## optional
  ///
  /// ### python docstring
  ///
  /// A validator that makes an attribute optional.  An optional attribute is one
  /// which can be set to ``None`` in addition to satisfying the requirements of
  /// the sub-validator.
  ///
  /// :param Callable | tuple[Callable] | list[Callable] validator: A validator
  ///     (or validators) that is used for non-``None`` values.
  ///
  /// .. versionadded:: 15.1.0
  /// .. versionchanged:: 17.1.0 *validator* can be a list of validators.
  /// .. versionchanged:: 23.1.0 *validator* can also be a tuple of validators.
  ///
  /// ### python source
  /// ```py
  /// def optional(validator):
  ///     """
  ///     A validator that makes an attribute optional.  An optional attribute is one
  ///     which can be set to ``None`` in addition to satisfying the requirements of
  ///     the sub-validator.
  ///
  ///     :param Callable | tuple[Callable] | list[Callable] validator: A validator
  ///         (or validators) that is used for non-``None`` values.
  ///
  ///     .. versionadded:: 15.1.0
  ///     .. versionchanged:: 17.1.0 *validator* can be a list of validators.
  ///     .. versionchanged:: 23.1.0 *validator* can also be a tuple of validators.
  ///     """
  ///     if isinstance(validator, (list, tuple)):
  ///         return _OptionalValidator(_AndValidator(validator))
  ///
  ///     return _OptionalValidator(validator)
  /// ```
  Object? optional({
    required Object? validator,
  }) =>
      getFunction("optional").call(
        <Object?>[
          validator,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## provides
  ///
  /// ### python docstring
  ///
  /// A validator that raises a `TypeError` if the initializer is called
  /// with an object that does not provide the requested *interface* (checks are
  /// performed using ``interface.providedBy(value)`` (see `zope.interface
  /// <https://zopeinterface.readthedocs.io/en/latest/>`_).
  ///
  /// :param interface: The interface to check for.
  /// :type interface: ``zope.interface.Interface``
  ///
  /// :raises TypeError: With a human readable error message, the attribute
  ///     (of type `attrs.Attribute`), the expected interface, and the
  ///     value it got.
  ///
  /// .. deprecated:: 23.1.0
  ///
  /// ### python source
  /// ```py
  /// def provides(interface):
  ///     """
  ///     A validator that raises a `TypeError` if the initializer is called
  ///     with an object that does not provide the requested *interface* (checks are
  ///     performed using ``interface.providedBy(value)`` (see `zope.interface
  ///     <https://zopeinterface.readthedocs.io/en/latest/>`_).
  ///
  ///     :param interface: The interface to check for.
  ///     :type interface: ``zope.interface.Interface``
  ///
  ///     :raises TypeError: With a human readable error message, the attribute
  ///         (of type `attrs.Attribute`), the expected interface, and the
  ///         value it got.
  ///
  ///     .. deprecated:: 23.1.0
  ///     """
  ///     import warnings
  ///
  ///     warnings.warn(
  ///         "attrs's zope-interface support is deprecated and will be removed in, "
  ///         "or after, April 2024.",
  ///         DeprecationWarning,
  ///         stacklevel=2,
  ///     )
  ///     return _ProvidesValidator(interface)
  /// ```
  Object? provides({
    required Object? $interface,
  }) =>
      getFunction("provides").call(
        <Object?>[
          $interface,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_disabled
  ///
  /// ### python docstring
  ///
  /// Globally disable or enable running validators.
  ///
  /// By default, they are run.
  ///
  /// :param disabled: If ``True``, disable running all validators.
  /// :type disabled: bool
  ///
  /// .. warning::
  ///
  ///     This function is not thread-safe!
  ///
  /// .. versionadded:: 21.3.0
  ///
  /// ### python source
  /// ```py
  /// def set_disabled(disabled):
  ///     """
  ///     Globally disable or enable running validators.
  ///
  ///     By default, they are run.
  ///
  ///     :param disabled: If ``True``, disable running all validators.
  ///     :type disabled: bool
  ///
  ///     .. warning::
  ///
  ///         This function is not thread-safe!
  ///
  ///     .. versionadded:: 21.3.0
  ///     """
  ///     set_run_validators(not disabled)
  /// ```
  Object? set_disabled({
    required Object? disabled,
  }) =>
      getFunction("set_disabled").call(
        <Object?>[
          disabled,
        ],
        kwargs: <String, Object?>{},
      );
}
