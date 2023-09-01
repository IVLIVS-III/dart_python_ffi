// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library exceptions;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## AttrsAttributeNotFoundError
///
/// ### python docstring
///
/// An *attrs* function couldn't find an attribute that the user asked for.
///
/// .. versionadded:: 16.2.0
///
/// ### python source
/// ```py
/// class AttrsAttributeNotFoundError(ValueError):
///     """
///     An *attrs* function couldn't find an attribute that the user asked for.
///
///     .. versionadded:: 16.2.0
///     """
/// ```
final class AttrsAttributeNotFoundError extends PythonClass {
  factory AttrsAttributeNotFoundError() => PythonFfiDart.instance.importClass(
        "attr.exceptions",
        "AttrsAttributeNotFoundError",
        AttrsAttributeNotFoundError.from,
        <Object?>[],
      );

  AttrsAttributeNotFoundError.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// An *attrs* function couldn't find an attribute that the user asked for.
  ///
  /// .. versionadded:: 16.2.0
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// An *attrs* function couldn't find an attribute that the user asked for.
  ///
  /// .. versionadded:: 16.2.0
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// An *attrs* function couldn't find an attribute that the user asked for.
  ///
  /// .. versionadded:: 16.2.0
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// An *attrs* function couldn't find an attribute that the user asked for.
  ///
  /// .. versionadded:: 16.2.0
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// An *attrs* function couldn't find an attribute that the user asked for.
  ///
  /// .. versionadded:: 16.2.0
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// An *attrs* function couldn't find an attribute that the user asked for.
  ///
  /// .. versionadded:: 16.2.0
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## DefaultAlreadySetError
///
/// ### python docstring
///
/// A default has been set when defining the field and is attempted to be reset
/// using the decorator.
///
/// .. versionadded:: 17.1.0
///
/// ### python source
/// ```py
/// class DefaultAlreadySetError(RuntimeError):
///     """
///     A default has been set when defining the field and is attempted to be reset
///     using the decorator.
///
///     .. versionadded:: 17.1.0
///     """
/// ```
final class DefaultAlreadySetError extends PythonClass {
  factory DefaultAlreadySetError() => PythonFfiDart.instance.importClass(
        "attr.exceptions",
        "DefaultAlreadySetError",
        DefaultAlreadySetError.from,
        <Object?>[],
      );

  DefaultAlreadySetError.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// A default has been set when defining the field and is attempted to be reset
  /// using the decorator.
  ///
  /// .. versionadded:: 17.1.0
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// A default has been set when defining the field and is attempted to be reset
  /// using the decorator.
  ///
  /// .. versionadded:: 17.1.0
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// A default has been set when defining the field and is attempted to be reset
  /// using the decorator.
  ///
  /// .. versionadded:: 17.1.0
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// A default has been set when defining the field and is attempted to be reset
  /// using the decorator.
  ///
  /// .. versionadded:: 17.1.0
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// A default has been set when defining the field and is attempted to be reset
  /// using the decorator.
  ///
  /// .. versionadded:: 17.1.0
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// A default has been set when defining the field and is attempted to be reset
  /// using the decorator.
  ///
  /// .. versionadded:: 17.1.0
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

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

/// ## FrozenError
///
/// ### python docstring
///
/// A frozen/immutable instance or attribute have been attempted to be
/// modified.
///
/// It mirrors the behavior of ``namedtuples`` by using the same error message
/// and subclassing `AttributeError`.
///
/// .. versionadded:: 20.1.0
///
/// ### python source
/// ```py
/// class FrozenError(AttributeError):
///     """
///     A frozen/immutable instance or attribute have been attempted to be
///     modified.
///
///     It mirrors the behavior of ``namedtuples`` by using the same error message
///     and subclassing `AttributeError`.
///
///     .. versionadded:: 20.1.0
///     """
///
///     msg = "can't set attribute"
///     args = [msg]
/// ```
final class FrozenError extends PythonClass {
  factory FrozenError() => PythonFfiDart.instance.importClass(
        "attr.exceptions",
        "FrozenError",
        FrozenError.from,
        <Object?>[],
      );

  FrozenError.from(super.pythonClass) : super.from();

  /// ## name (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  Object? get name => getAttribute("name");

  /// ## name (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  set name(Object? name) => setAttribute("name", name);

  /// ## obj (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  Object? get obj => getAttribute("obj");

  /// ## obj (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  set obj(Object? obj) => setAttribute("obj", obj);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  set args(Object? args) => setAttribute("args", args);

  /// ## msg (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  Object? get msg => getAttribute("msg");

  /// ## msg (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  set msg(Object? msg) => setAttribute("msg", msg);
}

/// ## FrozenInstanceError
///
/// ### python docstring
///
/// A frozen instance has been attempted to be modified.
///
/// .. versionadded:: 16.1.0
///
/// ### python source
/// ```py
/// class FrozenInstanceError(FrozenError):
///     """
///     A frozen instance has been attempted to be modified.
///
///     .. versionadded:: 16.1.0
///     """
/// ```
final class FrozenInstanceError extends PythonClass {
  factory FrozenInstanceError() => PythonFfiDart.instance.importClass(
        "attr.exceptions",
        "FrozenInstanceError",
        FrozenInstanceError.from,
        <Object?>[],
      );

  FrozenInstanceError.from(super.pythonClass) : super.from();

  /// ## name (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  Object? get name => getAttribute("name");

  /// ## name (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  set name(Object? name) => setAttribute("name", name);

  /// ## obj (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  Object? get obj => getAttribute("obj");

  /// ## obj (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  set obj(Object? obj) => setAttribute("obj", obj);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  set args(Object? args) => setAttribute("args", args);

  /// ## msg (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  Object? get msg => getAttribute("msg");

  /// ## msg (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  set msg(Object? msg) => setAttribute("msg", msg);
}

/// ## NotAnAttrsClassError
///
/// ### python docstring
///
/// A non-*attrs* class has been passed into an *attrs* function.
///
/// .. versionadded:: 16.2.0
///
/// ### python source
/// ```py
/// class NotAnAttrsClassError(ValueError):
///     """
///     A non-*attrs* class has been passed into an *attrs* function.
///
///     .. versionadded:: 16.2.0
///     """
/// ```
final class NotAnAttrsClassError extends PythonClass {
  factory NotAnAttrsClassError() => PythonFfiDart.instance.importClass(
        "attr.exceptions",
        "NotAnAttrsClassError",
        NotAnAttrsClassError.from,
        <Object?>[],
      );

  NotAnAttrsClassError.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// A non-*attrs* class has been passed into an *attrs* function.
  ///
  /// .. versionadded:: 16.2.0
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// A non-*attrs* class has been passed into an *attrs* function.
  ///
  /// .. versionadded:: 16.2.0
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// A non-*attrs* class has been passed into an *attrs* function.
  ///
  /// .. versionadded:: 16.2.0
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// A non-*attrs* class has been passed into an *attrs* function.
  ///
  /// .. versionadded:: 16.2.0
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// A non-*attrs* class has been passed into an *attrs* function.
  ///
  /// .. versionadded:: 16.2.0
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// A non-*attrs* class has been passed into an *attrs* function.
  ///
  /// .. versionadded:: 16.2.0
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

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
        "attr.exceptions",
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

/// ## PythonTooOldError
///
/// ### python docstring
///
/// It was attempted to use an *attrs* feature that requires a newer Python
/// version.
///
/// .. versionadded:: 18.2.0
///
/// ### python source
/// ```py
/// class PythonTooOldError(RuntimeError):
///     """
///     It was attempted to use an *attrs* feature that requires a newer Python
///     version.
///
///     .. versionadded:: 18.2.0
///     """
/// ```
final class PythonTooOldError extends PythonClass {
  factory PythonTooOldError() => PythonFfiDart.instance.importClass(
        "attr.exceptions",
        "PythonTooOldError",
        PythonTooOldError.from,
        <Object?>[],
      );

  PythonTooOldError.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// It was attempted to use an *attrs* feature that requires a newer Python
  /// version.
  ///
  /// .. versionadded:: 18.2.0
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// It was attempted to use an *attrs* feature that requires a newer Python
  /// version.
  ///
  /// .. versionadded:: 18.2.0
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// It was attempted to use an *attrs* feature that requires a newer Python
  /// version.
  ///
  /// .. versionadded:: 18.2.0
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// It was attempted to use an *attrs* feature that requires a newer Python
  /// version.
  ///
  /// .. versionadded:: 18.2.0
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// It was attempted to use an *attrs* feature that requires a newer Python
  /// version.
  ///
  /// .. versionadded:: 18.2.0
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// It was attempted to use an *attrs* feature that requires a newer Python
  /// version.
  ///
  /// .. versionadded:: 18.2.0
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## UnannotatedAttributeError
///
/// ### python docstring
///
/// A class with ``auto_attribs=True`` has a field without a type annotation.
///
/// .. versionadded:: 17.3.0
///
/// ### python source
/// ```py
/// class UnannotatedAttributeError(RuntimeError):
///     """
///     A class with ``auto_attribs=True`` has a field without a type annotation.
///
///     .. versionadded:: 17.3.0
///     """
/// ```
final class UnannotatedAttributeError extends PythonClass {
  factory UnannotatedAttributeError() => PythonFfiDart.instance.importClass(
        "attr.exceptions",
        "UnannotatedAttributeError",
        UnannotatedAttributeError.from,
        <Object?>[],
      );

  UnannotatedAttributeError.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// A class with ``auto_attribs=True`` has a field without a type annotation.
  ///
  /// .. versionadded:: 17.3.0
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// A class with ``auto_attribs=True`` has a field without a type annotation.
  ///
  /// .. versionadded:: 17.3.0
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// A class with ``auto_attribs=True`` has a field without a type annotation.
  ///
  /// .. versionadded:: 17.3.0
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// A class with ``auto_attribs=True`` has a field without a type annotation.
  ///
  /// .. versionadded:: 17.3.0
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// A class with ``auto_attribs=True`` has a field without a type annotation.
  ///
  /// .. versionadded:: 17.3.0
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// A class with ``auto_attribs=True`` has a field without a type annotation.
  ///
  /// .. versionadded:: 17.3.0
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## exceptions
///
/// ### python source
/// ```py
/// # SPDX-License-Identifier: MIT
///
/// from attr.exceptions import *  # noqa
/// ```
final class exceptions extends PythonModule {
  exceptions.from(super.pythonModule) : super.from();

  static exceptions import() => PythonFfiDart.instance.importModule(
        "attrs.exceptions",
        exceptions.from,
      );
}
