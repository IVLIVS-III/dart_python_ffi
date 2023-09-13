// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library validators;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## NotCallableError
///
/// ### python docstring
///
/// A field requiring a callable has been set with a value that is not
/// callable.
///
/// .. versionadded:: 19.2.0
///
/// ### python source
/// ```py
/// class NotCallableError(TypeError):
///     """
///     A field requiring a callable has been set with a value that is not
///     callable.
///
///     .. versionadded:: 19.2.0
///     """
///
///     def __init__(self, msg, value):
///         super(TypeError, self).__init__(msg, value)
///         self.msg = msg
///         self.value = value
///
///     def __str__(self):
///         return str(self.msg)
/// ```
final class NotCallableError extends PythonClass {
  factory NotCallableError({
    required Object? msg,
    required Object? value,
  }) =>
      PythonFfiDart.instance.importClass(
        "attr.validators",
        "NotCallableError",
        NotCallableError.from,
        <Object?>[
          msg,
          value,
        ],
        <String, Object?>{},
      );

  NotCallableError.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);

  /// ## msg (getter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  Object? get msg => getAttribute("msg");

  /// ## msg (setter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  set msg(Object? msg) => setAttribute("msg", msg);

  /// ## value (getter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  Object? get value => getAttribute("value");

  /// ## value (setter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  set value(Object? value) => setAttribute("value", value);
}

/// ## validators
///
/// ### python docstring
///
/// Commonly useful validators.
///
/// ### python source
/// ```py
/// # SPDX-License-Identifier: MIT
///
/// """
/// Commonly useful validators.
/// """
///
///
/// import operator
/// import re
///
/// from contextlib import contextmanager
/// from re import Pattern
///
/// from ._config import get_run_validators, set_run_validators
/// from ._make import _AndValidator, and_, attrib, attrs
/// from .converters import default_if_none
/// from .exceptions import NotCallableError
///
///
/// __all__ = [
///     "and_",
///     "deep_iterable",
///     "deep_mapping",
///     "disabled",
///     "ge",
///     "get_disabled",
///     "gt",
///     "in_",
///     "instance_of",
///     "is_callable",
///     "le",
///     "lt",
///     "matches_re",
///     "max_len",
///     "min_len",
///     "not_",
///     "optional",
///     "provides",
///     "set_disabled",
/// ]
///
///
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
///
///
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
///
///
/// @contextmanager
/// def disabled():
///     """
///     Context manager that disables running validators within its context.
///
///     .. warning::
///
///         This context manager is not thread-safe!
///
///     .. versionadded:: 21.3.0
///     """
///     set_run_validators(False)
///     try:
///         yield
///     finally:
///         set_run_validators(True)
///
///
/// @attrs(repr=False, slots=True, hash=True)
/// class _InstanceOfValidator:
///     type = attrib()
///
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if not isinstance(value, self.type):
///             raise TypeError(
///                 "'{name}' must be {type!r} (got {value!r} that is a "
///                 "{actual!r}).".format(
///                     name=attr.name,
///                     type=self.type,
///                     actual=value.__class__,
///                     value=value,
///                 ),
///                 attr,
///                 self.type,
///                 value,
///             )
///
///     def __repr__(self):
///         return "<instance_of validator for type {type!r}>".format(
///             type=self.type
///         )
///
///
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
///
///
/// @attrs(repr=False, frozen=True, slots=True)
/// class _MatchesReValidator:
///     pattern = attrib()
///     match_func = attrib()
///
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if not self.match_func(value):
///             raise ValueError(
///                 "'{name}' must match regex {pattern!r}"
///                 " ({value!r} doesn't)".format(
///                     name=attr.name, pattern=self.pattern.pattern, value=value
///                 ),
///                 attr,
///                 self.pattern,
///                 value,
///             )
///
///     def __repr__(self):
///         return "<matches_re validator for pattern {pattern!r}>".format(
///             pattern=self.pattern
///         )
///
///
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
///
///
/// @attrs(repr=False, slots=True, hash=True)
/// class _ProvidesValidator:
///     interface = attrib()
///
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if not self.interface.providedBy(value):
///             raise TypeError(
///                 "'{name}' must provide {interface!r} which {value!r} "
///                 "doesn't.".format(
///                     name=attr.name, interface=self.interface, value=value
///                 ),
///                 attr,
///                 self.interface,
///                 value,
///             )
///
///     def __repr__(self):
///         return "<provides validator for interface {interface!r}>".format(
///             interface=self.interface
///         )
///
///
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
///
///
/// @attrs(repr=False, slots=True, hash=True)
/// class _OptionalValidator:
///     validator = attrib()
///
///     def __call__(self, inst, attr, value):
///         if value is None:
///             return
///
///         self.validator(inst, attr, value)
///
///     def __repr__(self):
///         return "<optional validator for {what} or None>".format(
///             what=repr(self.validator)
///         )
///
///
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
///
///
/// @attrs(repr=False, slots=True, hash=True)
/// class _InValidator:
///     options = attrib()
///
///     def __call__(self, inst, attr, value):
///         try:
///             in_options = value in self.options
///         except TypeError:  # e.g. `1 in "abc"`
///             in_options = False
///
///         if not in_options:
///             raise ValueError(
///                 "'{name}' must be in {options!r} (got {value!r})".format(
///                     name=attr.name, options=self.options, value=value
///                 ),
///                 attr,
///                 self.options,
///                 value,
///             )
///
///     def __repr__(self):
///         return "<in_ validator with options {options!r}>".format(
///             options=self.options
///         )
///
///
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
///
///
/// @attrs(repr=False, slots=False, hash=True)
/// class _IsCallableValidator:
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if not callable(value):
///             message = (
///                 "'{name}' must be callable "
///                 "(got {value!r} that is a {actual!r})."
///             )
///             raise NotCallableError(
///                 msg=message.format(
///                     name=attr.name, value=value, actual=value.__class__
///                 ),
///                 value=value,
///             )
///
///     def __repr__(self):
///         return "<is_callable validator>"
///
///
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
///
///
/// @attrs(repr=False, slots=True, hash=True)
/// class _DeepIterable:
///     member_validator = attrib(validator=is_callable())
///     iterable_validator = attrib(
///         default=None, validator=optional(is_callable())
///     )
///
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if self.iterable_validator is not None:
///             self.iterable_validator(inst, attr, value)
///
///         for member in value:
///             self.member_validator(inst, attr, member)
///
///     def __repr__(self):
///         iterable_identifier = (
///             ""
///             if self.iterable_validator is None
///             else f" {self.iterable_validator!r}"
///         )
///         return (
///             "<deep_iterable validator for{iterable_identifier}"
///             " iterables of {member!r}>"
///         ).format(
///             iterable_identifier=iterable_identifier,
///             member=self.member_validator,
///         )
///
///
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
///
///
/// @attrs(repr=False, slots=True, hash=True)
/// class _DeepMapping:
///     key_validator = attrib(validator=is_callable())
///     value_validator = attrib(validator=is_callable())
///     mapping_validator = attrib(default=None, validator=optional(is_callable()))
///
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if self.mapping_validator is not None:
///             self.mapping_validator(inst, attr, value)
///
///         for key in value:
///             self.key_validator(inst, attr, key)
///             self.value_validator(inst, attr, value[key])
///
///     def __repr__(self):
///         return (
///             "<deep_mapping validator for objects mapping {key!r} to {value!r}>"
///         ).format(key=self.key_validator, value=self.value_validator)
///
///
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
///
///
/// @attrs(repr=False, frozen=True, slots=True)
/// class _NumberValidator:
///     bound = attrib()
///     compare_op = attrib()
///     compare_func = attrib()
///
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if not self.compare_func(value, self.bound):
///             raise ValueError(
///                 "'{name}' must be {op} {bound}: {value}".format(
///                     name=attr.name,
///                     op=self.compare_op,
///                     bound=self.bound,
///                     value=value,
///                 )
///             )
///
///     def __repr__(self):
///         return "<Validator for x {op} {bound}>".format(
///             op=self.compare_op, bound=self.bound
///         )
///
///
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
///
///
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
///
///
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
///
///
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
///
///
/// @attrs(repr=False, frozen=True, slots=True)
/// class _MaxLengthValidator:
///     max_length = attrib()
///
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if len(value) > self.max_length:
///             raise ValueError(
///                 "Length of '{name}' must be <= {max}: {len}".format(
///                     name=attr.name, max=self.max_length, len=len(value)
///                 )
///             )
///
///     def __repr__(self):
///         return f"<max_len validator for {self.max_length}>"
///
///
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
///
///
/// @attrs(repr=False, frozen=True, slots=True)
/// class _MinLengthValidator:
///     min_length = attrib()
///
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if len(value) < self.min_length:
///             raise ValueError(
///                 "Length of '{name}' must be => {min}: {len}".format(
///                     name=attr.name, min=self.min_length, len=len(value)
///                 )
///             )
///
///     def __repr__(self):
///         return f"<min_len validator for {self.min_length}>"
///
///
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
///
///
/// @attrs(repr=False, slots=True, hash=True)
/// class _SubclassOfValidator:
///     type = attrib()
///
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if not issubclass(value, self.type):
///             raise TypeError(
///                 "'{name}' must be a subclass of {type!r} "
///                 "(got {value!r}).".format(
///                     name=attr.name,
///                     type=self.type,
///                     value=value,
///                 ),
///                 attr,
///                 self.type,
///                 value,
///             )
///
///     def __repr__(self):
///         return "<subclass_of validator for type {type!r}>".format(
///             type=self.type
///         )
///
///
/// def _subclass_of(type):
///     """
///     A validator that raises a `TypeError` if the initializer is called
///     with a wrong type for this particular attribute (checks are performed using
///     `issubclass` therefore it's also valid to pass a tuple of types).
///
///     :param type: The type to check for.
///     :type type: type or tuple of types
///
///     :raises TypeError: With a human readable error message, the attribute
///         (of type `attrs.Attribute`), the expected type, and the value it
///         got.
///     """
///     return _SubclassOfValidator(type)
///
///
/// @attrs(repr=False, slots=True, hash=True)
/// class _NotValidator:
///     validator = attrib()
///     msg = attrib(
///         converter=default_if_none(
///             "not_ validator child '{validator!r}' "
///             "did not raise a captured error"
///         )
///     )
///     exc_types = attrib(
///         validator=deep_iterable(
///             member_validator=_subclass_of(Exception),
///             iterable_validator=instance_of(tuple),
///         ),
///     )
///
///     def __call__(self, inst, attr, value):
///         try:
///             self.validator(inst, attr, value)
///         except self.exc_types:
///             pass  # suppress error to invert validity
///         else:
///             raise ValueError(
///                 self.msg.format(
///                     validator=self.validator,
///                     exc_types=self.exc_types,
///                 ),
///                 attr,
///                 self.validator,
///                 value,
///                 self.exc_types,
///             )
///
///     def __repr__(self):
///         return (
///             "<not_ validator wrapping {what!r}, " "capturing {exc_types!r}>"
///         ).format(
///             what=self.validator,
///             exc_types=self.exc_types,
///         )
///
///
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
final class validators extends PythonModule {
  validators.from(super.pythonModule) : super.from();

  static validators import() => PythonFfiDart.instance.importModule(
        "attr.validators",
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

  /// ## attrib
  ///
  /// ### python docstring
  ///
  /// Create a new attribute on a class.
  ///
  /// ..  warning::
  ///
  ///     Does *not* do anything unless the class is also decorated with
  ///     `attr.s` / `attrs.define` / et cetera!
  ///
  /// Please consider using `attrs.field` in new code (``attr.ib`` will *never*
  /// go away, though).
  ///
  /// :param default: A value that is used if an *attrs*-generated ``__init__``
  ///     is used and no value is passed while instantiating or the attribute is
  ///     excluded using ``init=False``.
  ///
  ///     If the value is an instance of `attrs.Factory`, its callable will be
  ///     used to construct a new value (useful for mutable data types like lists
  ///     or dicts).
  ///
  ///     If a default is not set (or set manually to `attrs.NOTHING`), a value
  ///     *must* be supplied when instantiating; otherwise a `TypeError`
  ///     will be raised.
  ///
  ///     The default can also be set using decorator notation as shown below.
  ///
  /// :type default: Any value
  ///
  /// :param callable factory: Syntactic sugar for
  ///     ``default=attr.Factory(factory)``.
  ///
  /// :param validator: `callable` that is called by *attrs*-generated
  ///     ``__init__`` methods after the instance has been initialized.  They
  ///     receive the initialized instance, the :func:`~attrs.Attribute`, and the
  ///     passed value.
  ///
  ///     The return value is *not* inspected so the validator has to throw an
  ///     exception itself.
  ///
  ///     If a `list` is passed, its items are treated as validators and must
  ///     all pass.
  ///
  ///     Validators can be globally disabled and re-enabled using
  ///     `attrs.validators.get_disabled` / `attrs.validators.set_disabled`.
  ///
  ///     The validator can also be set using decorator notation as shown below.
  ///
  /// :type validator: `callable` or a `list` of `callable`\ s.
  ///
  /// :param repr: Include this attribute in the generated ``__repr__``
  ///     method. If ``True``, include the attribute; if ``False``, omit it. By
  ///     default, the built-in ``repr()`` function is used. To override how the
  ///     attribute value is formatted, pass a ``callable`` that takes a single
  ///     value and returns a string. Note that the resulting string is used
  ///     as-is, i.e. it will be used directly *instead* of calling ``repr()``
  ///     (the default).
  /// :type repr: a `bool` or a `callable` to use a custom function.
  ///
  /// :param eq: If ``True`` (default), include this attribute in the
  ///     generated ``__eq__`` and ``__ne__`` methods that check two instances
  ///     for equality. To override how the attribute value is compared,
  ///     pass a ``callable`` that takes a single value and returns the value
  ///     to be compared.
  /// :type eq: a `bool` or a `callable`.
  ///
  /// :param order: If ``True`` (default), include this attributes in the
  ///     generated ``__lt__``, ``__le__``, ``__gt__`` and ``__ge__`` methods.
  ///     To override how the attribute value is ordered,
  ///     pass a ``callable`` that takes a single value and returns the value
  ///     to be ordered.
  /// :type order: a `bool` or a `callable`.
  ///
  /// :param cmp: Setting *cmp* is equivalent to setting *eq* and *order* to the
  ///     same value. Must not be mixed with *eq* or *order*.
  /// :type cmp: a `bool` or a `callable`.
  ///
  /// :param Optional[bool] hash: Include this attribute in the generated
  ///     ``__hash__`` method.  If ``None`` (default), mirror *eq*'s value.  This
  ///     is the correct behavior according the Python spec.  Setting this value
  ///     to anything else than ``None`` is *discouraged*.
  /// :param bool init: Include this attribute in the generated ``__init__``
  ///     method.  It is possible to set this to ``False`` and set a default
  ///     value.  In that case this attributed is unconditionally initialized
  ///     with the specified default value or factory.
  /// :param callable converter: `callable` that is called by
  ///     *attrs*-generated ``__init__`` methods to convert attribute's value
  ///     to the desired format.  It is given the passed-in value, and the
  ///     returned value will be used as the new value of the attribute.  The
  ///     value is converted before being passed to the validator, if any.
  /// :param metadata: An arbitrary mapping, to be used by third-party
  ///     components.  See `extending-metadata`.
  ///
  /// :param type: The type of the attribute. Nowadays, the preferred method to
  ///     specify the type is using a variable annotation (see :pep:`526`).
  ///     This argument is provided for backward compatibility.
  ///     Regardless of the approach used, the type will be stored on
  ///     ``Attribute.type``.
  ///
  ///     Please note that *attrs* doesn't do anything with this metadata by
  ///     itself. You can use it as part of your own code or for
  ///     `static type checking <types>`.
  /// :param kw_only: Make this attribute keyword-only in the generated
  ///     ``__init__`` (if ``init`` is ``False``, this parameter is ignored).
  /// :param on_setattr: Allows to overwrite the *on_setattr* setting from
  ///     `attr.s`. If left `None`, the *on_setattr* value from `attr.s` is used.
  ///     Set to `attrs.setters.NO_OP` to run **no** `setattr` hooks for this
  ///     attribute -- regardless of the setting in `attr.s`.
  /// :type on_setattr: `callable`, or a list of callables, or `None`, or
  ///     `attrs.setters.NO_OP`
  /// :param Optional[str] alias: Override this attribute's parameter name in the
  ///     generated ``__init__`` method. If left `None`, default to ``name``
  ///     stripped of leading underscores. See `private-attributes`.
  ///
  /// .. versionadded:: 15.2.0 *convert*
  /// .. versionadded:: 16.3.0 *metadata*
  /// .. versionchanged:: 17.1.0 *validator* can be a ``list`` now.
  /// .. versionchanged:: 17.1.0
  ///    *hash* is ``None`` and therefore mirrors *eq* by default.
  /// .. versionadded:: 17.3.0 *type*
  /// .. deprecated:: 17.4.0 *convert*
  /// .. versionadded:: 17.4.0 *converter* as a replacement for the deprecated
  ///    *convert* to achieve consistency with other noun-based arguments.
  /// .. versionadded:: 18.1.0
  ///    ``factory=f`` is syntactic sugar for ``default=attr.Factory(f)``.
  /// .. versionadded:: 18.2.0 *kw_only*
  /// .. versionchanged:: 19.2.0 *convert* keyword argument removed.
  /// .. versionchanged:: 19.2.0 *repr* also accepts a custom callable.
  /// .. deprecated:: 19.2.0 *cmp* Removal on or after 2021-06-01.
  /// .. versionadded:: 19.2.0 *eq* and *order*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.3.0 *kw_only* backported to Python 2
  /// .. versionchanged:: 21.1.0
  ///    *eq*, *order*, and *cmp* also accept a custom callable
  /// .. versionchanged:: 21.1.0 *cmp* undeprecated
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// ### python source
  /// ```py
  /// def attrib(
  ///     default=NOTHING,
  ///     validator=None,
  ///     repr=True,
  ///     cmp=None,
  ///     hash=None,
  ///     init=True,
  ///     metadata=None,
  ///     type=None,
  ///     converter=None,
  ///     factory=None,
  ///     kw_only=False,
  ///     eq=None,
  ///     order=None,
  ///     on_setattr=None,
  ///     alias=None,
  /// ):
  ///     """
  ///     Create a new attribute on a class.
  ///
  ///     ..  warning::
  ///
  ///         Does *not* do anything unless the class is also decorated with
  ///         `attr.s` / `attrs.define` / et cetera!
  ///
  ///     Please consider using `attrs.field` in new code (``attr.ib`` will *never*
  ///     go away, though).
  ///
  ///     :param default: A value that is used if an *attrs*-generated ``__init__``
  ///         is used and no value is passed while instantiating or the attribute is
  ///         excluded using ``init=False``.
  ///
  ///         If the value is an instance of `attrs.Factory`, its callable will be
  ///         used to construct a new value (useful for mutable data types like lists
  ///         or dicts).
  ///
  ///         If a default is not set (or set manually to `attrs.NOTHING`), a value
  ///         *must* be supplied when instantiating; otherwise a `TypeError`
  ///         will be raised.
  ///
  ///         The default can also be set using decorator notation as shown below.
  ///
  ///     :type default: Any value
  ///
  ///     :param callable factory: Syntactic sugar for
  ///         ``default=attr.Factory(factory)``.
  ///
  ///     :param validator: `callable` that is called by *attrs*-generated
  ///         ``__init__`` methods after the instance has been initialized.  They
  ///         receive the initialized instance, the :func:`~attrs.Attribute`, and the
  ///         passed value.
  ///
  ///         The return value is *not* inspected so the validator has to throw an
  ///         exception itself.
  ///
  ///         If a `list` is passed, its items are treated as validators and must
  ///         all pass.
  ///
  ///         Validators can be globally disabled and re-enabled using
  ///         `attrs.validators.get_disabled` / `attrs.validators.set_disabled`.
  ///
  ///         The validator can also be set using decorator notation as shown below.
  ///
  ///     :type validator: `callable` or a `list` of `callable`\\ s.
  ///
  ///     :param repr: Include this attribute in the generated ``__repr__``
  ///         method. If ``True``, include the attribute; if ``False``, omit it. By
  ///         default, the built-in ``repr()`` function is used. To override how the
  ///         attribute value is formatted, pass a ``callable`` that takes a single
  ///         value and returns a string. Note that the resulting string is used
  ///         as-is, i.e. it will be used directly *instead* of calling ``repr()``
  ///         (the default).
  ///     :type repr: a `bool` or a `callable` to use a custom function.
  ///
  ///     :param eq: If ``True`` (default), include this attribute in the
  ///         generated ``__eq__`` and ``__ne__`` methods that check two instances
  ///         for equality. To override how the attribute value is compared,
  ///         pass a ``callable`` that takes a single value and returns the value
  ///         to be compared.
  ///     :type eq: a `bool` or a `callable`.
  ///
  ///     :param order: If ``True`` (default), include this attributes in the
  ///         generated ``__lt__``, ``__le__``, ``__gt__`` and ``__ge__`` methods.
  ///         To override how the attribute value is ordered,
  ///         pass a ``callable`` that takes a single value and returns the value
  ///         to be ordered.
  ///     :type order: a `bool` or a `callable`.
  ///
  ///     :param cmp: Setting *cmp* is equivalent to setting *eq* and *order* to the
  ///         same value. Must not be mixed with *eq* or *order*.
  ///     :type cmp: a `bool` or a `callable`.
  ///
  ///     :param Optional[bool] hash: Include this attribute in the generated
  ///         ``__hash__`` method.  If ``None`` (default), mirror *eq*'s value.  This
  ///         is the correct behavior according the Python spec.  Setting this value
  ///         to anything else than ``None`` is *discouraged*.
  ///     :param bool init: Include this attribute in the generated ``__init__``
  ///         method.  It is possible to set this to ``False`` and set a default
  ///         value.  In that case this attributed is unconditionally initialized
  ///         with the specified default value or factory.
  ///     :param callable converter: `callable` that is called by
  ///         *attrs*-generated ``__init__`` methods to convert attribute's value
  ///         to the desired format.  It is given the passed-in value, and the
  ///         returned value will be used as the new value of the attribute.  The
  ///         value is converted before being passed to the validator, if any.
  ///     :param metadata: An arbitrary mapping, to be used by third-party
  ///         components.  See `extending-metadata`.
  ///
  ///     :param type: The type of the attribute. Nowadays, the preferred method to
  ///         specify the type is using a variable annotation (see :pep:`526`).
  ///         This argument is provided for backward compatibility.
  ///         Regardless of the approach used, the type will be stored on
  ///         ``Attribute.type``.
  ///
  ///         Please note that *attrs* doesn't do anything with this metadata by
  ///         itself. You can use it as part of your own code or for
  ///         `static type checking <types>`.
  ///     :param kw_only: Make this attribute keyword-only in the generated
  ///         ``__init__`` (if ``init`` is ``False``, this parameter is ignored).
  ///     :param on_setattr: Allows to overwrite the *on_setattr* setting from
  ///         `attr.s`. If left `None`, the *on_setattr* value from `attr.s` is used.
  ///         Set to `attrs.setters.NO_OP` to run **no** `setattr` hooks for this
  ///         attribute -- regardless of the setting in `attr.s`.
  ///     :type on_setattr: `callable`, or a list of callables, or `None`, or
  ///         `attrs.setters.NO_OP`
  ///     :param Optional[str] alias: Override this attribute's parameter name in the
  ///         generated ``__init__`` method. If left `None`, default to ``name``
  ///         stripped of leading underscores. See `private-attributes`.
  ///
  ///     .. versionadded:: 15.2.0 *convert*
  ///     .. versionadded:: 16.3.0 *metadata*
  ///     .. versionchanged:: 17.1.0 *validator* can be a ``list`` now.
  ///     .. versionchanged:: 17.1.0
  ///        *hash* is ``None`` and therefore mirrors *eq* by default.
  ///     .. versionadded:: 17.3.0 *type*
  ///     .. deprecated:: 17.4.0 *convert*
  ///     .. versionadded:: 17.4.0 *converter* as a replacement for the deprecated
  ///        *convert* to achieve consistency with other noun-based arguments.
  ///     .. versionadded:: 18.1.0
  ///        ``factory=f`` is syntactic sugar for ``default=attr.Factory(f)``.
  ///     .. versionadded:: 18.2.0 *kw_only*
  ///     .. versionchanged:: 19.2.0 *convert* keyword argument removed.
  ///     .. versionchanged:: 19.2.0 *repr* also accepts a custom callable.
  ///     .. deprecated:: 19.2.0 *cmp* Removal on or after 2021-06-01.
  ///     .. versionadded:: 19.2.0 *eq* and *order*
  ///     .. versionadded:: 20.1.0 *on_setattr*
  ///     .. versionchanged:: 20.3.0 *kw_only* backported to Python 2
  ///     .. versionchanged:: 21.1.0
  ///        *eq*, *order*, and *cmp* also accept a custom callable
  ///     .. versionchanged:: 21.1.0 *cmp* undeprecated
  ///     .. versionadded:: 22.2.0 *alias*
  ///     """
  ///     eq, eq_key, order, order_key = _determine_attrib_eq_order(
  ///         cmp, eq, order, True
  ///     )
  ///
  ///     if hash is not None and hash is not True and hash is not False:
  ///         raise TypeError(
  ///             "Invalid value for hash.  Must be True, False, or None."
  ///         )
  ///
  ///     if factory is not None:
  ///         if default is not NOTHING:
  ///             raise ValueError(
  ///                 "The `default` and `factory` arguments are mutually "
  ///                 "exclusive."
  ///             )
  ///         if not callable(factory):
  ///             raise ValueError("The `factory` argument must be a callable.")
  ///         default = Factory(factory)
  ///
  ///     if metadata is None:
  ///         metadata = {}
  ///
  ///     # Apply syntactic sugar by auto-wrapping.
  ///     if isinstance(on_setattr, (list, tuple)):
  ///         on_setattr = setters.pipe(*on_setattr)
  ///
  ///     if validator and isinstance(validator, (list, tuple)):
  ///         validator = and_(*validator)
  ///
  ///     if converter and isinstance(converter, (list, tuple)):
  ///         converter = pipe(*converter)
  ///
  ///     return _CountingAttr(
  ///         default=default,
  ///         validator=validator,
  ///         repr=repr,
  ///         cmp=None,
  ///         hash=hash,
  ///         init=init,
  ///         converter=converter,
  ///         metadata=metadata,
  ///         type=type,
  ///         kw_only=kw_only,
  ///         eq=eq,
  ///         eq_key=eq_key,
  ///         order=order,
  ///         order_key=order_key,
  ///         on_setattr=on_setattr,
  ///         alias=alias,
  ///     )
  /// ```
  Object? attrib({
    Object? $default,
    Object? validator,
    Object? repr = true,
    Object? cmp,
    Object? hash,
    Object? init = true,
    Object? metadata,
    Object? type,
    Object? converter,
    Object? $factory,
    Object? kw_only = false,
    Object? eq,
    Object? order,
    Object? on_setattr,
    Object? alias,
  }) =>
      getFunction("attrib").call(
        <Object?>[
          $default,
          validator,
          repr,
          cmp,
          hash,
          init,
          metadata,
          type,
          converter,
          $factory,
          kw_only,
          eq,
          order,
          on_setattr,
          alias,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## attrs
  ///
  /// ### python docstring
  ///
  /// A class decorator that adds :term:`dunder methods` according to the
  /// specified attributes using `attr.ib` or the *these* argument.
  ///
  /// Please consider using `attrs.define` / `attrs.frozen` in new code
  /// (``attr.s`` will *never* go away, though).
  ///
  /// :param these: A dictionary of name to `attr.ib` mappings.  This is
  ///     useful to avoid the definition of your attributes within the class body
  ///     because you can't (e.g. if you want to add ``__repr__`` methods to
  ///     Django models) or don't want to.
  ///
  ///     If *these* is not ``None``, *attrs* will *not* search the class body
  ///     for attributes and will *not* remove any attributes from it.
  ///
  ///     The order is deduced from the order of the attributes inside *these*.
  ///
  /// :type these: `dict` of `str` to `attr.ib`
  ///
  /// :param str repr_ns: When using nested classes, there's no way in Python 2
  ///     to automatically detect that.  Therefore it's possible to set the
  ///     namespace explicitly for a more meaningful ``repr`` output.
  /// :param bool auto_detect: Instead of setting the *init*, *repr*, *eq*,
  ///     *order*, and *hash* arguments explicitly, assume they are set to
  ///     ``True`` **unless any** of the involved methods for one of the
  ///     arguments is implemented in the *current* class (i.e. it is *not*
  ///     inherited from some base class).
  ///
  ///     So for example by implementing ``__eq__`` on a class yourself,
  ///     *attrs* will deduce ``eq=False`` and will create *neither*
  ///     ``__eq__`` *nor* ``__ne__`` (but Python classes come with a sensible
  ///     ``__ne__`` by default, so it *should* be enough to only implement
  ///     ``__eq__`` in most cases).
  ///
  ///     .. warning::
  ///
  ///        If you prevent *attrs* from creating the ordering methods for you
  ///        (``order=False``, e.g. by implementing ``__le__``), it becomes
  ///        *your* responsibility to make sure its ordering is sound. The best
  ///        way is to use the `functools.total_ordering` decorator.
  ///
  ///
  ///     Passing ``True`` or ``False`` to *init*, *repr*, *eq*, *order*,
  ///     *cmp*, or *hash* overrides whatever *auto_detect* would determine.
  ///
  /// :param bool repr: Create a ``__repr__`` method with a human readable
  ///     representation of *attrs* attributes..
  /// :param bool str: Create a ``__str__`` method that is identical to
  ///     ``__repr__``.  This is usually not necessary except for
  ///     `Exception`\ s.
  /// :param Optional[bool] eq: If ``True`` or ``None`` (default), add ``__eq__``
  ///     and ``__ne__`` methods that check two instances for equality.
  ///
  ///     They compare the instances as if they were tuples of their *attrs*
  ///     attributes if and only if the types of both classes are *identical*!
  /// :param Optional[bool] order: If ``True``, add ``__lt__``, ``__le__``,
  ///     ``__gt__``, and ``__ge__`` methods that behave like *eq* above and
  ///     allow instances to be ordered. If ``None`` (default) mirror value of
  ///     *eq*.
  /// :param Optional[bool] cmp: Setting *cmp* is equivalent to setting *eq*
  ///     and *order* to the same value. Must not be mixed with *eq* or *order*.
  /// :param Optional[bool] unsafe_hash: If ``None`` (default), the ``__hash__``
  ///     method is generated according how *eq* and *frozen* are set.
  ///
  ///     1. If *both* are True, *attrs* will generate a ``__hash__`` for you.
  ///     2. If *eq* is True and *frozen* is False, ``__hash__`` will be set to
  ///        None, marking it unhashable (which it is).
  ///     3. If *eq* is False, ``__hash__`` will be left untouched meaning the
  ///        ``__hash__`` method of the base class will be used (if base class is
  ///        ``object``, this means it will fall back to id-based hashing.).
  ///
  ///     Although not recommended, you can decide for yourself and force
  ///     *attrs* to create one (e.g. if the class is immutable even though you
  ///     didn't freeze it programmatically) by passing ``True`` or not.  Both of
  ///     these cases are rather special and should be used carefully.
  ///
  ///     See our documentation on `hashing`, Python's documentation on
  ///     `object.__hash__`, and the `GitHub issue that led to the default \
  ///     behavior <https://github.com/python-attrs/attrs/issues/136>`_ for more
  ///     details.
  /// :param Optional[bool] hash: Alias for *unsafe_hash*. *unsafe_hash* takes
  ///     precedence.
  /// :param bool init: Create a ``__init__`` method that initializes the
  ///     *attrs* attributes. Leading underscores are stripped for the argument
  ///     name. If a ``__attrs_pre_init__`` method exists on the class, it will
  ///     be called before the class is initialized. If a ``__attrs_post_init__``
  ///     method exists on the class, it will be called after the class is fully
  ///     initialized.
  ///
  ///     If ``init`` is ``False``, an ``__attrs_init__`` method will be
  ///     injected instead. This allows you to define a custom ``__init__``
  ///     method that can do pre-init work such as ``super().__init__()``,
  ///     and then call ``__attrs_init__()`` and ``__attrs_post_init__()``.
  /// :param bool slots: Create a :term:`slotted class <slotted classes>` that's
  ///     more memory-efficient. Slotted classes are generally superior to the
  ///     default dict classes, but have some gotchas you should know about, so
  ///     we encourage you to read the :term:`glossary entry <slotted classes>`.
  /// :param bool frozen: Make instances immutable after initialization.  If
  ///     someone attempts to modify a frozen instance,
  ///     `attrs.exceptions.FrozenInstanceError` is raised.
  ///
  ///     .. note::
  ///
  ///         1. This is achieved by installing a custom ``__setattr__`` method
  ///            on your class, so you can't implement your own.
  ///
  ///         2. True immutability is impossible in Python.
  ///
  ///         3. This *does* have a minor a runtime performance `impact
  ///            <how-frozen>` when initializing new instances.  In other words:
  ///            ``__init__`` is slightly slower with ``frozen=True``.
  ///
  ///         4. If a class is frozen, you cannot modify ``self`` in
  ///            ``__attrs_post_init__`` or a self-written ``__init__``. You can
  ///            circumvent that limitation by using
  ///            ``object.__setattr__(self, "attribute_name", value)``.
  ///
  ///         5. Subclasses of a frozen class are frozen too.
  ///
  /// :param bool weakref_slot: Make instances weak-referenceable.  This has no
  ///     effect unless ``slots`` is also enabled.
  /// :param bool auto_attribs: If ``True``, collect :pep:`526`-annotated
  ///     attributes from the class body.
  ///
  ///     In this case, you **must** annotate every field.  If *attrs*
  ///     encounters a field that is set to an `attr.ib` but lacks a type
  ///     annotation, an `attr.exceptions.UnannotatedAttributeError` is
  ///     raised.  Use ``field_name: typing.Any = attr.ib(...)`` if you don't
  ///     want to set a type.
  ///
  ///     If you assign a value to those attributes (e.g. ``x: int = 42``), that
  ///     value becomes the default value like if it were passed using
  ///     ``attr.ib(default=42)``.  Passing an instance of `attrs.Factory` also
  ///     works as expected in most cases (see warning below).
  ///
  ///     Attributes annotated as `typing.ClassVar`, and attributes that are
  ///     neither annotated nor set to an `attr.ib` are **ignored**.
  ///
  ///     .. warning::
  ///        For features that use the attribute name to create decorators (e.g.
  ///        :ref:`validators <validators>`), you still *must* assign `attr.ib`
  ///        to them. Otherwise Python will either not find the name or try to
  ///        use the default value to call e.g. ``validator`` on it.
  ///
  ///        These errors can be quite confusing and probably the most common bug
  ///        report on our bug tracker.
  ///
  /// :param bool kw_only: Make all attributes keyword-only
  ///     in the generated ``__init__`` (if ``init`` is ``False``, this
  ///     parameter is ignored).
  /// :param bool cache_hash: Ensure that the object's hash code is computed
  ///     only once and stored on the object.  If this is set to ``True``,
  ///     hashing must be either explicitly or implicitly enabled for this
  ///     class.  If the hash code is cached, avoid any reassignments of
  ///     fields involved in hash code computation or mutations of the objects
  ///     those fields point to after object creation.  If such changes occur,
  ///     the behavior of the object's hash code is undefined.
  /// :param bool auto_exc: If the class subclasses `BaseException`
  ///     (which implicitly includes any subclass of any exception), the
  ///     following happens to behave like a well-behaved Python exceptions
  ///     class:
  ///
  ///     - the values for *eq*, *order*, and *hash* are ignored and the
  ///       instances compare and hash by the instance's ids (N.B. *attrs* will
  ///       *not* remove existing implementations of ``__hash__`` or the equality
  ///       methods. It just won't add own ones.),
  ///     - all attributes that are either passed into ``__init__`` or have a
  ///       default value are additionally available as a tuple in the ``args``
  ///       attribute,
  ///     - the value of *str* is ignored leaving ``__str__`` to base classes.
  /// :param bool collect_by_mro: Setting this to `True` fixes the way *attrs*
  ///    collects attributes from base classes.  The default behavior is
  ///    incorrect in certain cases of multiple inheritance.  It should be on by
  ///    default but is kept off for backward-compatibility.
  ///
  ///    See issue `#428 <https://github.com/python-attrs/attrs/issues/428>`_ for
  ///    more details.
  ///
  /// :param Optional[bool] getstate_setstate:
  ///    .. note::
  ///       This is usually only interesting for slotted classes and you should
  ///       probably just set *auto_detect* to `True`.
  ///
  ///    If `True`, ``__getstate__`` and
  ///    ``__setstate__`` are generated and attached to the class. This is
  ///    necessary for slotted classes to be pickleable. If left `None`, it's
  ///    `True` by default for slotted classes and ``False`` for dict classes.
  ///
  ///    If *auto_detect* is `True`, and *getstate_setstate* is left `None`,
  ///    and **either** ``__getstate__`` or ``__setstate__`` is detected directly
  ///    on the class (i.e. not inherited), it is set to `False` (this is usually
  ///    what you want).
  ///
  /// :param on_setattr: A callable that is run whenever the user attempts to set
  ///     an attribute (either by assignment like ``i.x = 42`` or by using
  ///     `setattr` like ``setattr(i, "x", 42)``). It receives the same arguments
  ///     as validators: the instance, the attribute that is being modified, and
  ///     the new value.
  ///
  ///     If no exception is raised, the attribute is set to the return value of
  ///     the callable.
  ///
  ///     If a list of callables is passed, they're automatically wrapped in an
  ///     `attrs.setters.pipe`.
  /// :type on_setattr: `callable`, or a list of callables, or `None`, or
  ///     `attrs.setters.NO_OP`
  ///
  /// :param Optional[callable] field_transformer:
  ///     A function that is called with the original class object and all
  ///     fields right before *attrs* finalizes the class.  You can use
  ///     this, e.g., to automatically add converters or validators to
  ///     fields based on their types.  See `transform-fields` for more details.
  ///
  /// :param bool match_args:
  ///     If `True` (default), set ``__match_args__`` on the class to support
  ///     :pep:`634` (Structural Pattern Matching). It is a tuple of all
  ///     non-keyword-only ``__init__`` parameter names on Python 3.10 and later.
  ///     Ignored on older Python versions.
  ///
  /// .. versionadded:: 16.0.0 *slots*
  /// .. versionadded:: 16.1.0 *frozen*
  /// .. versionadded:: 16.3.0 *str*
  /// .. versionadded:: 16.3.0 Support for ``__attrs_post_init__``.
  /// .. versionchanged:: 17.1.0
  ///    *hash* supports ``None`` as value which is also the default now.
  /// .. versionadded:: 17.3.0 *auto_attribs*
  /// .. versionchanged:: 18.1.0
  ///    If *these* is passed, no attributes are deleted from the class body.
  /// .. versionchanged:: 18.1.0 If *these* is ordered, the order is retained.
  /// .. versionadded:: 18.2.0 *weakref_slot*
  /// .. deprecated:: 18.2.0
  ///    ``__lt__``, ``__le__``, ``__gt__``, and ``__ge__`` now raise a
  ///    `DeprecationWarning` if the classes compared are subclasses of
  ///    each other. ``__eq`` and ``__ne__`` never tried to compared subclasses
  ///    to each other.
  /// .. versionchanged:: 19.2.0
  ///    ``__lt__``, ``__le__``, ``__gt__``, and ``__ge__`` now do not consider
  ///    subclasses comparable anymore.
  /// .. versionadded:: 18.2.0 *kw_only*
  /// .. versionadded:: 18.2.0 *cache_hash*
  /// .. versionadded:: 19.1.0 *auto_exc*
  /// .. deprecated:: 19.2.0 *cmp* Removal on or after 2021-06-01.
  /// .. versionadded:: 19.2.0 *eq* and *order*
  /// .. versionadded:: 20.1.0 *auto_detect*
  /// .. versionadded:: 20.1.0 *collect_by_mro*
  /// .. versionadded:: 20.1.0 *getstate_setstate*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionadded:: 20.3.0 *field_transformer*
  /// .. versionchanged:: 21.1.0
  ///    ``init=False`` injects ``__attrs_init__``
  /// .. versionchanged:: 21.1.0 Support for ``__attrs_pre_init__``
  /// .. versionchanged:: 21.1.0 *cmp* undeprecated
  /// .. versionadded:: 21.3.0 *match_args*
  /// .. versionadded:: 22.2.0
  ///    *unsafe_hash* as an alias for *hash* (for :pep:`681` compliance).
  ///
  /// ### python source
  /// ```py
  /// def attrs(
  ///     maybe_cls=None,
  ///     these=None,
  ///     repr_ns=None,
  ///     repr=None,
  ///     cmp=None,
  ///     hash=None,
  ///     init=None,
  ///     slots=False,
  ///     frozen=False,
  ///     weakref_slot=True,
  ///     str=False,
  ///     auto_attribs=False,
  ///     kw_only=False,
  ///     cache_hash=False,
  ///     auto_exc=False,
  ///     eq=None,
  ///     order=None,
  ///     auto_detect=False,
  ///     collect_by_mro=False,
  ///     getstate_setstate=None,
  ///     on_setattr=None,
  ///     field_transformer=None,
  ///     match_args=True,
  ///     unsafe_hash=None,
  /// ):
  ///     r"""
  ///     A class decorator that adds :term:`dunder methods` according to the
  ///     specified attributes using `attr.ib` or the *these* argument.
  ///
  ///     Please consider using `attrs.define` / `attrs.frozen` in new code
  ///     (``attr.s`` will *never* go away, though).
  ///
  ///     :param these: A dictionary of name to `attr.ib` mappings.  This is
  ///         useful to avoid the definition of your attributes within the class body
  ///         because you can't (e.g. if you want to add ``__repr__`` methods to
  ///         Django models) or don't want to.
  ///
  ///         If *these* is not ``None``, *attrs* will *not* search the class body
  ///         for attributes and will *not* remove any attributes from it.
  ///
  ///         The order is deduced from the order of the attributes inside *these*.
  ///
  ///     :type these: `dict` of `str` to `attr.ib`
  ///
  ///     :param str repr_ns: When using nested classes, there's no way in Python 2
  ///         to automatically detect that.  Therefore it's possible to set the
  ///         namespace explicitly for a more meaningful ``repr`` output.
  ///     :param bool auto_detect: Instead of setting the *init*, *repr*, *eq*,
  ///         *order*, and *hash* arguments explicitly, assume they are set to
  ///         ``True`` **unless any** of the involved methods for one of the
  ///         arguments is implemented in the *current* class (i.e. it is *not*
  ///         inherited from some base class).
  ///
  ///         So for example by implementing ``__eq__`` on a class yourself,
  ///         *attrs* will deduce ``eq=False`` and will create *neither*
  ///         ``__eq__`` *nor* ``__ne__`` (but Python classes come with a sensible
  ///         ``__ne__`` by default, so it *should* be enough to only implement
  ///         ``__eq__`` in most cases).
  ///
  ///         .. warning::
  ///
  ///            If you prevent *attrs* from creating the ordering methods for you
  ///            (``order=False``, e.g. by implementing ``__le__``), it becomes
  ///            *your* responsibility to make sure its ordering is sound. The best
  ///            way is to use the `functools.total_ordering` decorator.
  ///
  ///
  ///         Passing ``True`` or ``False`` to *init*, *repr*, *eq*, *order*,
  ///         *cmp*, or *hash* overrides whatever *auto_detect* would determine.
  ///
  ///     :param bool repr: Create a ``__repr__`` method with a human readable
  ///         representation of *attrs* attributes..
  ///     :param bool str: Create a ``__str__`` method that is identical to
  ///         ``__repr__``.  This is usually not necessary except for
  ///         `Exception`\ s.
  ///     :param Optional[bool] eq: If ``True`` or ``None`` (default), add ``__eq__``
  ///         and ``__ne__`` methods that check two instances for equality.
  ///
  ///         They compare the instances as if they were tuples of their *attrs*
  ///         attributes if and only if the types of both classes are *identical*!
  ///     :param Optional[bool] order: If ``True``, add ``__lt__``, ``__le__``,
  ///         ``__gt__``, and ``__ge__`` methods that behave like *eq* above and
  ///         allow instances to be ordered. If ``None`` (default) mirror value of
  ///         *eq*.
  ///     :param Optional[bool] cmp: Setting *cmp* is equivalent to setting *eq*
  ///         and *order* to the same value. Must not be mixed with *eq* or *order*.
  ///     :param Optional[bool] unsafe_hash: If ``None`` (default), the ``__hash__``
  ///         method is generated according how *eq* and *frozen* are set.
  ///
  ///         1. If *both* are True, *attrs* will generate a ``__hash__`` for you.
  ///         2. If *eq* is True and *frozen* is False, ``__hash__`` will be set to
  ///            None, marking it unhashable (which it is).
  ///         3. If *eq* is False, ``__hash__`` will be left untouched meaning the
  ///            ``__hash__`` method of the base class will be used (if base class is
  ///            ``object``, this means it will fall back to id-based hashing.).
  ///
  ///         Although not recommended, you can decide for yourself and force
  ///         *attrs* to create one (e.g. if the class is immutable even though you
  ///         didn't freeze it programmatically) by passing ``True`` or not.  Both of
  ///         these cases are rather special and should be used carefully.
  ///
  ///         See our documentation on `hashing`, Python's documentation on
  ///         `object.__hash__`, and the `GitHub issue that led to the default \
  ///         behavior <https://github.com/python-attrs/attrs/issues/136>`_ for more
  ///         details.
  ///     :param Optional[bool] hash: Alias for *unsafe_hash*. *unsafe_hash* takes
  ///         precedence.
  ///     :param bool init: Create a ``__init__`` method that initializes the
  ///         *attrs* attributes. Leading underscores are stripped for the argument
  ///         name. If a ``__attrs_pre_init__`` method exists on the class, it will
  ///         be called before the class is initialized. If a ``__attrs_post_init__``
  ///         method exists on the class, it will be called after the class is fully
  ///         initialized.
  ///
  ///         If ``init`` is ``False``, an ``__attrs_init__`` method will be
  ///         injected instead. This allows you to define a custom ``__init__``
  ///         method that can do pre-init work such as ``super().__init__()``,
  ///         and then call ``__attrs_init__()`` and ``__attrs_post_init__()``.
  ///     :param bool slots: Create a :term:`slotted class <slotted classes>` that's
  ///         more memory-efficient. Slotted classes are generally superior to the
  ///         default dict classes, but have some gotchas you should know about, so
  ///         we encourage you to read the :term:`glossary entry <slotted classes>`.
  ///     :param bool frozen: Make instances immutable after initialization.  If
  ///         someone attempts to modify a frozen instance,
  ///         `attrs.exceptions.FrozenInstanceError` is raised.
  ///
  ///         .. note::
  ///
  ///             1. This is achieved by installing a custom ``__setattr__`` method
  ///                on your class, so you can't implement your own.
  ///
  ///             2. True immutability is impossible in Python.
  ///
  ///             3. This *does* have a minor a runtime performance `impact
  ///                <how-frozen>` when initializing new instances.  In other words:
  ///                ``__init__`` is slightly slower with ``frozen=True``.
  ///
  ///             4. If a class is frozen, you cannot modify ``self`` in
  ///                ``__attrs_post_init__`` or a self-written ``__init__``. You can
  ///                circumvent that limitation by using
  ///                ``object.__setattr__(self, "attribute_name", value)``.
  ///
  ///             5. Subclasses of a frozen class are frozen too.
  ///
  ///     :param bool weakref_slot: Make instances weak-referenceable.  This has no
  ///         effect unless ``slots`` is also enabled.
  ///     :param bool auto_attribs: If ``True``, collect :pep:`526`-annotated
  ///         attributes from the class body.
  ///
  ///         In this case, you **must** annotate every field.  If *attrs*
  ///         encounters a field that is set to an `attr.ib` but lacks a type
  ///         annotation, an `attr.exceptions.UnannotatedAttributeError` is
  ///         raised.  Use ``field_name: typing.Any = attr.ib(...)`` if you don't
  ///         want to set a type.
  ///
  ///         If you assign a value to those attributes (e.g. ``x: int = 42``), that
  ///         value becomes the default value like if it were passed using
  ///         ``attr.ib(default=42)``.  Passing an instance of `attrs.Factory` also
  ///         works as expected in most cases (see warning below).
  ///
  ///         Attributes annotated as `typing.ClassVar`, and attributes that are
  ///         neither annotated nor set to an `attr.ib` are **ignored**.
  ///
  ///         .. warning::
  ///            For features that use the attribute name to create decorators (e.g.
  ///            :ref:`validators <validators>`), you still *must* assign `attr.ib`
  ///            to them. Otherwise Python will either not find the name or try to
  ///            use the default value to call e.g. ``validator`` on it.
  ///
  ///            These errors can be quite confusing and probably the most common bug
  ///            report on our bug tracker.
  ///
  ///     :param bool kw_only: Make all attributes keyword-only
  ///         in the generated ``__init__`` (if ``init`` is ``False``, this
  ///         parameter is ignored).
  ///     :param bool cache_hash: Ensure that the object's hash code is computed
  ///         only once and stored on the object.  If this is set to ``True``,
  ///         hashing must be either explicitly or implicitly enabled for this
  ///         class.  If the hash code is cached, avoid any reassignments of
  ///         fields involved in hash code computation or mutations of the objects
  ///         those fields point to after object creation.  If such changes occur,
  ///         the behavior of the object's hash code is undefined.
  ///     :param bool auto_exc: If the class subclasses `BaseException`
  ///         (which implicitly includes any subclass of any exception), the
  ///         following happens to behave like a well-behaved Python exceptions
  ///         class:
  ///
  ///         - the values for *eq*, *order*, and *hash* are ignored and the
  ///           instances compare and hash by the instance's ids (N.B. *attrs* will
  ///           *not* remove existing implementations of ``__hash__`` or the equality
  ///           methods. It just won't add own ones.),
  ///         - all attributes that are either passed into ``__init__`` or have a
  ///           default value are additionally available as a tuple in the ``args``
  ///           attribute,
  ///         - the value of *str* is ignored leaving ``__str__`` to base classes.
  ///     :param bool collect_by_mro: Setting this to `True` fixes the way *attrs*
  ///        collects attributes from base classes.  The default behavior is
  ///        incorrect in certain cases of multiple inheritance.  It should be on by
  ///        default but is kept off for backward-compatibility.
  ///
  ///        See issue `#428 <https://github.com/python-attrs/attrs/issues/428>`_ for
  ///        more details.
  ///
  ///     :param Optional[bool] getstate_setstate:
  ///        .. note::
  ///           This is usually only interesting for slotted classes and you should
  ///           probably just set *auto_detect* to `True`.
  ///
  ///        If `True`, ``__getstate__`` and
  ///        ``__setstate__`` are generated and attached to the class. This is
  ///        necessary for slotted classes to be pickleable. If left `None`, it's
  ///        `True` by default for slotted classes and ``False`` for dict classes.
  ///
  ///        If *auto_detect* is `True`, and *getstate_setstate* is left `None`,
  ///        and **either** ``__getstate__`` or ``__setstate__`` is detected directly
  ///        on the class (i.e. not inherited), it is set to `False` (this is usually
  ///        what you want).
  ///
  ///     :param on_setattr: A callable that is run whenever the user attempts to set
  ///         an attribute (either by assignment like ``i.x = 42`` or by using
  ///         `setattr` like ``setattr(i, "x", 42)``). It receives the same arguments
  ///         as validators: the instance, the attribute that is being modified, and
  ///         the new value.
  ///
  ///         If no exception is raised, the attribute is set to the return value of
  ///         the callable.
  ///
  ///         If a list of callables is passed, they're automatically wrapped in an
  ///         `attrs.setters.pipe`.
  ///     :type on_setattr: `callable`, or a list of callables, or `None`, or
  ///         `attrs.setters.NO_OP`
  ///
  ///     :param Optional[callable] field_transformer:
  ///         A function that is called with the original class object and all
  ///         fields right before *attrs* finalizes the class.  You can use
  ///         this, e.g., to automatically add converters or validators to
  ///         fields based on their types.  See `transform-fields` for more details.
  ///
  ///     :param bool match_args:
  ///         If `True` (default), set ``__match_args__`` on the class to support
  ///         :pep:`634` (Structural Pattern Matching). It is a tuple of all
  ///         non-keyword-only ``__init__`` parameter names on Python 3.10 and later.
  ///         Ignored on older Python versions.
  ///
  ///     .. versionadded:: 16.0.0 *slots*
  ///     .. versionadded:: 16.1.0 *frozen*
  ///     .. versionadded:: 16.3.0 *str*
  ///     .. versionadded:: 16.3.0 Support for ``__attrs_post_init__``.
  ///     .. versionchanged:: 17.1.0
  ///        *hash* supports ``None`` as value which is also the default now.
  ///     .. versionadded:: 17.3.0 *auto_attribs*
  ///     .. versionchanged:: 18.1.0
  ///        If *these* is passed, no attributes are deleted from the class body.
  ///     .. versionchanged:: 18.1.0 If *these* is ordered, the order is retained.
  ///     .. versionadded:: 18.2.0 *weakref_slot*
  ///     .. deprecated:: 18.2.0
  ///        ``__lt__``, ``__le__``, ``__gt__``, and ``__ge__`` now raise a
  ///        `DeprecationWarning` if the classes compared are subclasses of
  ///        each other. ``__eq`` and ``__ne__`` never tried to compared subclasses
  ///        to each other.
  ///     .. versionchanged:: 19.2.0
  ///        ``__lt__``, ``__le__``, ``__gt__``, and ``__ge__`` now do not consider
  ///        subclasses comparable anymore.
  ///     .. versionadded:: 18.2.0 *kw_only*
  ///     .. versionadded:: 18.2.0 *cache_hash*
  ///     .. versionadded:: 19.1.0 *auto_exc*
  ///     .. deprecated:: 19.2.0 *cmp* Removal on or after 2021-06-01.
  ///     .. versionadded:: 19.2.0 *eq* and *order*
  ///     .. versionadded:: 20.1.0 *auto_detect*
  ///     .. versionadded:: 20.1.0 *collect_by_mro*
  ///     .. versionadded:: 20.1.0 *getstate_setstate*
  ///     .. versionadded:: 20.1.0 *on_setattr*
  ///     .. versionadded:: 20.3.0 *field_transformer*
  ///     .. versionchanged:: 21.1.0
  ///        ``init=False`` injects ``__attrs_init__``
  ///     .. versionchanged:: 21.1.0 Support for ``__attrs_pre_init__``
  ///     .. versionchanged:: 21.1.0 *cmp* undeprecated
  ///     .. versionadded:: 21.3.0 *match_args*
  ///     .. versionadded:: 22.2.0
  ///        *unsafe_hash* as an alias for *hash* (for :pep:`681` compliance).
  ///     """
  ///     eq_, order_ = _determine_attrs_eq_order(cmp, eq, order, None)
  ///
  ///     # unsafe_hash takes precedence due to PEP 681.
  ///     if unsafe_hash is not None:
  ///         hash = unsafe_hash
  ///
  ///     if isinstance(on_setattr, (list, tuple)):
  ///         on_setattr = setters.pipe(*on_setattr)
  ///
  ///     def wrap(cls):
  ///         is_frozen = frozen or _has_frozen_base_class(cls)
  ///         is_exc = auto_exc is True and issubclass(cls, BaseException)
  ///         has_own_setattr = auto_detect and _has_own_attribute(
  ///             cls, "__setattr__"
  ///         )
  ///
  ///         if has_own_setattr and is_frozen:
  ///             raise ValueError("Can't freeze a class with a custom __setattr__.")
  ///
  ///         builder = _ClassBuilder(
  ///             cls,
  ///             these,
  ///             slots,
  ///             is_frozen,
  ///             weakref_slot,
  ///             _determine_whether_to_implement(
  ///                 cls,
  ///                 getstate_setstate,
  ///                 auto_detect,
  ///                 ("__getstate__", "__setstate__"),
  ///                 default=slots,
  ///             ),
  ///             auto_attribs,
  ///             kw_only,
  ///             cache_hash,
  ///             is_exc,
  ///             collect_by_mro,
  ///             on_setattr,
  ///             has_own_setattr,
  ///             field_transformer,
  ///         )
  ///         if _determine_whether_to_implement(
  ///             cls, repr, auto_detect, ("__repr__",)
  ///         ):
  ///             builder.add_repr(repr_ns)
  ///         if str is True:
  ///             builder.add_str()
  ///
  ///         eq = _determine_whether_to_implement(
  ///             cls, eq_, auto_detect, ("__eq__", "__ne__")
  ///         )
  ///         if not is_exc and eq is True:
  ///             builder.add_eq()
  ///         if not is_exc and _determine_whether_to_implement(
  ///             cls, order_, auto_detect, ("__lt__", "__le__", "__gt__", "__ge__")
  ///         ):
  ///             builder.add_order()
  ///
  ///         builder.add_setattr()
  ///
  ///         nonlocal hash
  ///         if (
  ///             hash is None
  ///             and auto_detect is True
  ///             and _has_own_attribute(cls, "__hash__")
  ///         ):
  ///             hash = False
  ///
  ///         if hash is not True and hash is not False and hash is not None:
  ///             # Can't use `hash in` because 1 == True for example.
  ///             raise TypeError(
  ///                 "Invalid value for hash.  Must be True, False, or None."
  ///             )
  ///         elif hash is False or (hash is None and eq is False) or is_exc:
  ///             # Don't do anything. Should fall back to __object__'s __hash__
  ///             # which is by id.
  ///             if cache_hash:
  ///                 raise TypeError(
  ///                     "Invalid value for cache_hash.  To use hash caching,"
  ///                     " hashing must be either explicitly or implicitly "
  ///                     "enabled."
  ///                 )
  ///         elif hash is True or (
  ///             hash is None and eq is True and is_frozen is True
  ///         ):
  ///             # Build a __hash__ if told so, or if it's safe.
  ///             builder.add_hash()
  ///         else:
  ///             # Raise TypeError on attempts to hash.
  ///             if cache_hash:
  ///                 raise TypeError(
  ///                     "Invalid value for cache_hash.  To use hash caching,"
  ///                     " hashing must be either explicitly or implicitly "
  ///                     "enabled."
  ///                 )
  ///             builder.make_unhashable()
  ///
  ///         if _determine_whether_to_implement(
  ///             cls, init, auto_detect, ("__init__",)
  ///         ):
  ///             builder.add_init()
  ///         else:
  ///             builder.add_attrs_init()
  ///             if cache_hash:
  ///                 raise TypeError(
  ///                     "Invalid value for cache_hash.  To use hash caching,"
  ///                     " init must be True."
  ///                 )
  ///
  ///         if (
  ///             PY310
  ///             and match_args
  ///             and not _has_own_attribute(cls, "__match_args__")
  ///         ):
  ///             builder.add_match_args()
  ///
  ///         return builder.build_class()
  ///
  ///     # maybe_cls's type depends on the usage of the decorator.  It's a class
  ///     # if it's used as `@attrs` but ``None`` if used as `@attrs()`.
  ///     if maybe_cls is None:
  ///         return wrap
  ///     else:
  ///         return wrap(maybe_cls)
  /// ```
  Object? attrs({
    Object? maybe_cls,
    Object? these,
    Object? repr_ns,
    Object? repr,
    Object? cmp,
    Object? hash,
    Object? init,
    Object? slots = false,
    Object? frozen = false,
    Object? weakref_slot = true,
    Object? str = false,
    Object? auto_attribs = false,
    Object? kw_only = false,
    Object? cache_hash = false,
    Object? auto_exc = false,
    Object? eq,
    Object? order,
    Object? auto_detect = false,
    Object? collect_by_mro = false,
    Object? getstate_setstate,
    Object? on_setattr,
    Object? field_transformer,
    Object? match_args = true,
    Object? unsafe_hash,
  }) =>
      getFunction("attrs").call(
        <Object?>[
          maybe_cls,
          these,
          repr_ns,
          repr,
          cmp,
          hash,
          init,
          slots,
          frozen,
          weakref_slot,
          str,
          auto_attribs,
          kw_only,
          cache_hash,
          auto_exc,
          eq,
          order,
          auto_detect,
          collect_by_mro,
          getstate_setstate,
          on_setattr,
          field_transformer,
          match_args,
          unsafe_hash,
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

  /// ## get_run_validators
  ///
  /// ### python docstring
  ///
  /// Return whether or not validators are run.
  ///
  /// .. deprecated:: 21.3.0 It will not be removed, but it also will not be
  ///     moved to new ``attrs`` namespace. Use `attrs.validators.get_disabled()`
  ///     instead.
  ///
  /// ### python source
  /// ```py
  /// def get_run_validators():
  ///     """
  ///     Return whether or not validators are run.
  ///
  ///     .. deprecated:: 21.3.0 It will not be removed, but it also will not be
  ///         moved to new ``attrs`` namespace. Use `attrs.validators.get_disabled()`
  ///         instead.
  ///     """
  ///     return _run_validators
  /// ```
  Object? get_run_validators() => getFunction("get_run_validators").call(
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

  /// ## set_run_validators
  ///
  /// ### python docstring
  ///
  /// Set whether or not validators are run.  By default, they are run.
  ///
  /// .. deprecated:: 21.3.0 It will not be removed, but it also will not be
  ///     moved to new ``attrs`` namespace. Use `attrs.validators.set_disabled()`
  ///     instead.
  ///
  /// ### python source
  /// ```py
  /// def set_run_validators(run):
  ///     """
  ///     Set whether or not validators are run.  By default, they are run.
  ///
  ///     .. deprecated:: 21.3.0 It will not be removed, but it also will not be
  ///         moved to new ``attrs`` namespace. Use `attrs.validators.set_disabled()`
  ///         instead.
  ///     """
  ///     if not isinstance(run, bool):
  ///         raise TypeError("'run' must be bool.")
  ///     global _run_validators
  ///     _run_validators = run
  /// ```
  Object? set_run_validators({
    required Object? run,
  }) =>
      getFunction("set_run_validators").call(
        <Object?>[
          run,
        ],
        kwargs: <String, Object?>{},
      );
}
