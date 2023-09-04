// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library exceptions;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## CharacterEncodingOverride
///
/// ### python source
/// ```py
/// class CharacterEncodingOverride(ThingsNobodyCaresAboutButMe):
///     pass
/// ```
final class CharacterEncodingOverride extends PythonClass {
  factory CharacterEncodingOverride() => PythonFfiDart.instance.importClass(
        "feedparser.exceptions",
        "CharacterEncodingOverride",
        CharacterEncodingOverride.from,
        <Object?>[],
      );

  CharacterEncodingOverride.from(super.pythonClass) : super.from();

  /// ## args (getter)
  Object? get args => getAttribute("args");

  /// ## args (setter)
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## CharacterEncodingUnknown
///
/// ### python source
/// ```py
/// class CharacterEncodingUnknown(ThingsNobodyCaresAboutButMe):
///     pass
/// ```
final class CharacterEncodingUnknown extends PythonClass {
  factory CharacterEncodingUnknown() => PythonFfiDart.instance.importClass(
        "feedparser.exceptions",
        "CharacterEncodingUnknown",
        CharacterEncodingUnknown.from,
        <Object?>[],
      );

  CharacterEncodingUnknown.from(super.pythonClass) : super.from();

  /// ## args (getter)
  Object? get args => getAttribute("args");

  /// ## args (setter)
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## NonXMLContentType
///
/// ### python source
/// ```py
/// class NonXMLContentType(ThingsNobodyCaresAboutButMe):
///     pass
/// ```
final class NonXMLContentType extends PythonClass {
  factory NonXMLContentType() => PythonFfiDart.instance.importClass(
        "feedparser.exceptions",
        "NonXMLContentType",
        NonXMLContentType.from,
        <Object?>[],
      );

  NonXMLContentType.from(super.pythonClass) : super.from();

  /// ## args (getter)
  Object? get args => getAttribute("args");

  /// ## args (setter)
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## ThingsNobodyCaresAboutButMe
///
/// ### python source
/// ```py
/// class ThingsNobodyCaresAboutButMe(Exception):
///     pass
/// ```
final class ThingsNobodyCaresAboutButMe extends PythonClass {
  factory ThingsNobodyCaresAboutButMe() => PythonFfiDart.instance.importClass(
        "feedparser.exceptions",
        "ThingsNobodyCaresAboutButMe",
        ThingsNobodyCaresAboutButMe.from,
        <Object?>[],
      );

  ThingsNobodyCaresAboutButMe.from(super.pythonClass) : super.from();

  /// ## args (getter)
  Object? get args => getAttribute("args");

  /// ## args (setter)
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## UndeclaredNamespace
///
/// ### python source
/// ```py
/// class UndeclaredNamespace(Exception):
///     pass
/// ```
final class UndeclaredNamespace extends PythonClass {
  factory UndeclaredNamespace() => PythonFfiDart.instance.importClass(
        "feedparser.exceptions",
        "UndeclaredNamespace",
        UndeclaredNamespace.from,
        <Object?>[],
      );

  UndeclaredNamespace.from(super.pythonClass) : super.from();

  /// ## args (getter)
  Object? get args => getAttribute("args");

  /// ## args (setter)
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## exceptions
///
/// ### python source
/// ```py
/// # Exceptions used throughout feedparser
/// # Copyright 2010-2022 Kurt McKee <contactme@kurtmckee.org>
/// # Copyright 2002-2008 Mark Pilgrim
/// # All rights reserved.
/// #
/// # This file is a part of feedparser.
/// #
/// # Redistribution and use in source and binary forms, with or without modification,
/// # are permitted provided that the following conditions are met:
/// #
/// # * Redistributions of source code must retain the above copyright notice,
/// #   this list of conditions and the following disclaimer.
/// # * Redistributions in binary form must reproduce the above copyright notice,
/// #   this list of conditions and the following disclaimer in the documentation
/// #   and/or other materials provided with the distribution.
/// #
/// # THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 'AS IS'
/// # AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
/// # IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
/// # ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
/// # LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
/// # CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
/// # SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
/// # INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
/// # CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
/// # ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
/// # POSSIBILITY OF SUCH DAMAGE.
///
/// __all__ = [
///     'ThingsNobodyCaresAboutButMe',
///     'CharacterEncodingOverride',
///     'CharacterEncodingUnknown',
///     'NonXMLContentType',
///     'UndeclaredNamespace',
/// ]
///
///
/// class ThingsNobodyCaresAboutButMe(Exception):
///     pass
///
///
/// class CharacterEncodingOverride(ThingsNobodyCaresAboutButMe):
///     pass
///
///
/// class CharacterEncodingUnknown(ThingsNobodyCaresAboutButMe):
///     pass
///
///
/// class NonXMLContentType(ThingsNobodyCaresAboutButMe):
///     pass
///
///
/// class UndeclaredNamespace(Exception):
///     pass
/// ```
final class exceptions extends PythonModule {
  exceptions.from(super.pythonModule) : super.from();

  static exceptions import() => PythonFfiDart.instance.importModule(
        "feedparser.exceptions",
        exceptions.from,
      );
}
