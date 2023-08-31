// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library packaging;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## InvalidMarker
///
/// ### python docstring
///
/// An invalid marker was found, users should refer to PEP 508.
///
/// ### python source
/// ```py
/// class InvalidMarker(ValueError):
///     """
///     An invalid marker was found, users should refer to PEP 508.
///     """
/// ```
final class InvalidMarker extends PythonClass {
  factory InvalidMarker() => PythonFfiDart.instance.importClass(
        "packaging.markers",
        "InvalidMarker",
        InvalidMarker.from,
        <Object?>[],
      );

  InvalidMarker.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// An invalid marker was found, users should refer to PEP 508.
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// An invalid marker was found, users should refer to PEP 508.
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// An invalid marker was found, users should refer to PEP 508.
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// An invalid marker was found, users should refer to PEP 508.
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// An invalid marker was found, users should refer to PEP 508.
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// An invalid marker was found, users should refer to PEP 508.
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## InvalidSpecifier
///
/// ### python docstring
///
/// Raised when attempting to create a :class:`Specifier` with a specifier
/// string that is invalid.
///
/// >>> Specifier("lolwat")
/// Traceback (most recent call last):
///     ...
/// packaging.specifiers.InvalidSpecifier: Invalid specifier: 'lolwat'
///
/// ### python source
/// ```py
/// class InvalidSpecifier(ValueError):
///     """
///     Raised when attempting to create a :class:`Specifier` with a specifier
///     string that is invalid.
///
///     >>> Specifier("lolwat")
///     Traceback (most recent call last):
///         ...
///     packaging.specifiers.InvalidSpecifier: Invalid specifier: 'lolwat'
///     """
/// ```
final class InvalidSpecifier extends PythonClass {
  factory InvalidSpecifier() => PythonFfiDart.instance.importClass(
        "packaging.specifiers",
        "InvalidSpecifier",
        InvalidSpecifier.from,
        <Object?>[],
      );

  InvalidSpecifier.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// Raised when attempting to create a :class:`Specifier` with a specifier
  /// string that is invalid.
  ///
  /// >>> Specifier("lolwat")
  /// Traceback (most recent call last):
  ///     ...
  /// packaging.specifiers.InvalidSpecifier: Invalid specifier: 'lolwat'
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// Raised when attempting to create a :class:`Specifier` with a specifier
  /// string that is invalid.
  ///
  /// >>> Specifier("lolwat")
  /// Traceback (most recent call last):
  ///     ...
  /// packaging.specifiers.InvalidSpecifier: Invalid specifier: 'lolwat'
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// Raised when attempting to create a :class:`Specifier` with a specifier
  /// string that is invalid.
  ///
  /// >>> Specifier("lolwat")
  /// Traceback (most recent call last):
  ///     ...
  /// packaging.specifiers.InvalidSpecifier: Invalid specifier: 'lolwat'
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// Raised when attempting to create a :class:`Specifier` with a specifier
  /// string that is invalid.
  ///
  /// >>> Specifier("lolwat")
  /// Traceback (most recent call last):
  ///     ...
  /// packaging.specifiers.InvalidSpecifier: Invalid specifier: 'lolwat'
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// Raised when attempting to create a :class:`Specifier` with a specifier
  /// string that is invalid.
  ///
  /// >>> Specifier("lolwat")
  /// Traceback (most recent call last):
  ///     ...
  /// packaging.specifiers.InvalidSpecifier: Invalid specifier: 'lolwat'
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// Raised when attempting to create a :class:`Specifier` with a specifier
  /// string that is invalid.
  ///
  /// >>> Specifier("lolwat")
  /// Traceback (most recent call last):
  ///     ...
  /// packaging.specifiers.InvalidSpecifier: Invalid specifier: 'lolwat'
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## Marker
///
/// ### python source
/// ```py
/// class Marker:
///     def __init__(self, marker: str) -> None:
///         # Note: We create a Marker object without calling this constructor in
///         #       packaging.requirements.Requirement. If any additional logic is
///         #       added here, make sure to mirror/adapt Requirement.
///         try:
///             self._markers = _normalize_extra_values(_parse_marker(marker))
///             # The attribute `_markers` can be described in terms of a recursive type:
///             # MarkerList = List[Union[Tuple[Node, ...], str, MarkerList]]
///             #
///             # For example, the following expression:
///             # python_version > "3.6" or (python_version == "3.6" and os_name == "unix")
///             #
///             # is parsed into:
///             # [
///             #     (<Variable('python_version')>, <Op('>')>, <Value('3.6')>),
///             #     'and',
///             #     [
///             #         (<Variable('python_version')>, <Op('==')>, <Value('3.6')>),
///             #         'or',
///             #         (<Variable('os_name')>, <Op('==')>, <Value('unix')>)
///             #     ]
///             # ]
///         except ParserSyntaxError as e:
///             raise InvalidMarker(str(e)) from e
///
///     def __str__(self) -> str:
///         return _format_marker(self._markers)
///
///     def __repr__(self) -> str:
///         return f"<Marker('{self}')>"
///
///     def __hash__(self) -> int:
///         return hash((self.__class__.__name__, str(self)))
///
///     def __eq__(self, other: Any) -> bool:
///         if not isinstance(other, Marker):
///             return NotImplemented
///
///         return str(self) == str(other)
///
///     def evaluate(self, environment: Optional[Dict[str, str]] = None) -> bool:
///         """Evaluate a marker.
///
///         Return the boolean from evaluating the given marker against the
///         environment. environment is an optional argument to override all or
///         part of the determined environment.
///
///         The environment is determined from the current Python process.
///         """
///         current_environment = default_environment()
///         current_environment["extra"] = ""
///         if environment is not None:
///             current_environment.update(environment)
///             # The API used to allow setting extra to None. We need to handle this
///             # case for backwards compatibility.
///             if current_environment["extra"] is None:
///                 current_environment["extra"] = ""
///
///         return _evaluate_markers(self._markers, current_environment)
/// ```
final class Marker extends PythonClass {
  factory Marker({
    required String marker,
  }) =>
      PythonFfiDart.instance.importClass(
        "packaging.markers",
        "Marker",
        Marker.from,
        <Object?>[
          marker,
        ],
        <String, Object?>{},
      );

  Marker.from(super.pythonClass) : super.from();

  /// ## evaluate
  ///
  /// ### python docstring
  ///
  /// Evaluate a marker.
  ///
  /// Return the boolean from evaluating the given marker against the
  /// environment. environment is an optional argument to override all or
  /// part of the determined environment.
  ///
  /// The environment is determined from the current Python process.
  ///
  /// ### python source
  /// ```py
  /// def evaluate(self, environment: Optional[Dict[str, str]] = None) -> bool:
  ///         """Evaluate a marker.
  ///
  ///         Return the boolean from evaluating the given marker against the
  ///         environment. environment is an optional argument to override all or
  ///         part of the determined environment.
  ///
  ///         The environment is determined from the current Python process.
  ///         """
  ///         current_environment = default_environment()
  ///         current_environment["extra"] = ""
  ///         if environment is not None:
  ///             current_environment.update(environment)
  ///             # The API used to allow setting extra to None. We need to handle this
  ///             # case for backwards compatibility.
  ///             if current_environment["extra"] is None:
  ///                 current_environment["extra"] = ""
  ///
  ///         return _evaluate_markers(self._markers, current_environment)
  /// ```
  bool evaluate({
    Object? environment,
  }) =>
      getFunction("evaluate").call(
        <Object?>[
          environment,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## Op
///
/// ### python source
/// ```py
/// class Op(Node):
///     def serialize(self) -> str:
///         return str(self)
/// ```
final class Op extends PythonClass {
  factory Op({
    required String value,
  }) =>
      PythonFfiDart.instance.importClass(
        "packaging._parser",
        "Op",
        Op.from,
        <Object?>[
          value,
        ],
        <String, Object?>{},
      );

  Op.from(super.pythonClass) : super.from();

  /// ## serialize
  ///
  /// ### python source
  /// ```py
  /// def serialize(self) -> str:
  ///         return str(self)
  /// ```
  String serialize() => getFunction("serialize").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## value (getter)
  Object? get value => getAttribute("value");

  /// ## value (setter)
  set value(Object? value) => setAttribute("value", value);
}

/// ## ParserSyntaxError
///
/// ### python docstring
///
/// The provided source text could not be parsed correctly.
///
/// ### python source
/// ```py
/// class ParserSyntaxError(Exception):
///     """The provided source text could not be parsed correctly."""
///
///     def __init__(
///         self,
///         message: str,
///         *,
///         source: str,
///         span: Tuple[int, int],
///     ) -> None:
///         self.span = span
///         self.message = message
///         self.source = source
///
///         super().__init__()
///
///     def __str__(self) -> str:
///         marker = " " * self.span[0] + "~" * (self.span[1] - self.span[0]) + "^"
///         return "\n    ".join([self.message, self.source, marker])
/// ```
final class ParserSyntaxError extends PythonClass {
  factory ParserSyntaxError({
    required String message,
    required String source,
    required Object? span,
  }) =>
      PythonFfiDart.instance.importClass(
        "packaging._tokenizer",
        "ParserSyntaxError",
        ParserSyntaxError.from,
        <Object?>[
          message,
        ],
        <String, Object?>{
          "source": source,
          "span": span,
        },
      );

  ParserSyntaxError.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// The provided source text could not be parsed correctly.
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// The provided source text could not be parsed correctly.
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// The provided source text could not be parsed correctly.
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// The provided source text could not be parsed correctly.
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// The provided source text could not be parsed correctly.
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// The provided source text could not be parsed correctly.
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);

  /// ## span (getter)
  ///
  /// ### python docstring
  ///
  /// The provided source text could not be parsed correctly.
  Object? get span => getAttribute("span");

  /// ## span (setter)
  ///
  /// ### python docstring
  ///
  /// The provided source text could not be parsed correctly.
  set span(Object? span) => setAttribute("span", span);

  /// ## message (getter)
  ///
  /// ### python docstring
  ///
  /// The provided source text could not be parsed correctly.
  Object? get message => getAttribute("message");

  /// ## message (setter)
  ///
  /// ### python docstring
  ///
  /// The provided source text could not be parsed correctly.
  set message(Object? message) => setAttribute("message", message);

  /// ## source (getter)
  ///
  /// ### python docstring
  ///
  /// The provided source text could not be parsed correctly.
  Object? get source => getAttribute("source");

  /// ## source (setter)
  ///
  /// ### python docstring
  ///
  /// The provided source text could not be parsed correctly.
  set source(Object? source) => setAttribute("source", source);
}

/// ## Specifier
///
/// ### python docstring
///
/// This class abstracts handling of version specifiers.
///
/// .. tip::
///
///     It is generally not required to instantiate this manually. You should instead
///     prefer to work with :class:`SpecifierSet` instead, which can parse
///     comma-separated version specifiers (which is what package metadata contains).
///
/// ### python source
/// ```py
/// class Specifier(BaseSpecifier):
///     """This class abstracts handling of version specifiers.
///
///     .. tip::
///
///         It is generally not required to instantiate this manually. You should instead
///         prefer to work with :class:`SpecifierSet` instead, which can parse
///         comma-separated version specifiers (which is what package metadata contains).
///     """
///
///     _operator_regex_str = r"""
///         (?P<operator>(~=|==|!=|<=|>=|<|>|===))
///         """
///     _version_regex_str = r"""
///         (?P<version>
///             (?:
///                 # The identity operators allow for an escape hatch that will
///                 # do an exact string match of the version you wish to install.
///                 # This will not be parsed by PEP 440 and we cannot determine
///                 # any semantic meaning from it. This operator is discouraged
///                 # but included entirely as an escape hatch.
///                 (?<====)  # Only match for the identity operator
///                 \s*
///                 [^\s;)]*  # The arbitrary version can be just about anything,
///                           # we match everything except for whitespace, a
///                           # semi-colon for marker support, and a closing paren
///                           # since versions can be enclosed in them.
///             )
///             |
///             (?:
///                 # The (non)equality operators allow for wild card and local
///                 # versions to be specified so we have to define these two
///                 # operators separately to enable that.
///                 (?<===|!=)            # Only match for equals and not equals
///
///                 \s*
///                 v?
///                 (?:[0-9]+!)?          # epoch
///                 [0-9]+(?:\.[0-9]+)*   # release
///
///                 # You cannot use a wild card and a pre-release, post-release, a dev or
///                 # local version together so group them with a | and make them optional.
///                 (?:
///                     \.\*  # Wild card syntax of .*
///                     |
///                     (?:                                  # pre release
///                         [-_\.]?
///                         (alpha|beta|preview|pre|a|b|c|rc)
///                         [-_\.]?
///                         [0-9]*
///                     )?
///                     (?:                                  # post release
///                         (?:-[0-9]+)|(?:[-_\.]?(post|rev|r)[-_\.]?[0-9]*)
///                     )?
///                     (?:[-_\.]?dev[-_\.]?[0-9]*)?         # dev release
///                     (?:\+[a-z0-9]+(?:[-_\.][a-z0-9]+)*)? # local
///                 )?
///             )
///             |
///             (?:
///                 # The compatible operator requires at least two digits in the
///                 # release segment.
///                 (?<=~=)               # Only match for the compatible operator
///
///                 \s*
///                 v?
///                 (?:[0-9]+!)?          # epoch
///                 [0-9]+(?:\.[0-9]+)+   # release  (We have a + instead of a *)
///                 (?:                   # pre release
///                     [-_\.]?
///                     (alpha|beta|preview|pre|a|b|c|rc)
///                     [-_\.]?
///                     [0-9]*
///                 )?
///                 (?:                                   # post release
///                     (?:-[0-9]+)|(?:[-_\.]?(post|rev|r)[-_\.]?[0-9]*)
///                 )?
///                 (?:[-_\.]?dev[-_\.]?[0-9]*)?          # dev release
///             )
///             |
///             (?:
///                 # All other operators only allow a sub set of what the
///                 # (non)equality operators do. Specifically they do not allow
///                 # local versions to be specified nor do they allow the prefix
///                 # matching wild cards.
///                 (?<!==|!=|~=)         # We have special cases for these
///                                       # operators so we want to make sure they
///                                       # don't match here.
///
///                 \s*
///                 v?
///                 (?:[0-9]+!)?          # epoch
///                 [0-9]+(?:\.[0-9]+)*   # release
///                 (?:                   # pre release
///                     [-_\.]?
///                     (alpha|beta|preview|pre|a|b|c|rc)
///                     [-_\.]?
///                     [0-9]*
///                 )?
///                 (?:                                   # post release
///                     (?:-[0-9]+)|(?:[-_\.]?(post|rev|r)[-_\.]?[0-9]*)
///                 )?
///                 (?:[-_\.]?dev[-_\.]?[0-9]*)?          # dev release
///             )
///         )
///         """
///
///     _regex = re.compile(
///         r"^\s*" + _operator_regex_str + _version_regex_str + r"\s*$",
///         re.VERBOSE | re.IGNORECASE,
///     )
///
///     _operators = {
///         "~=": "compatible",
///         "==": "equal",
///         "!=": "not_equal",
///         "<=": "less_than_equal",
///         ">=": "greater_than_equal",
///         "<": "less_than",
///         ">": "greater_than",
///         "===": "arbitrary",
///     }
///
///     def __init__(self, spec: str = "", prereleases: Optional[bool] = None) -> None:
///         """Initialize a Specifier instance.
///
///         :param spec:
///             The string representation of a specifier which will be parsed and
///             normalized before use.
///         :param prereleases:
///             This tells the specifier if it should accept prerelease versions if
///             applicable or not. The default of ``None`` will autodetect it from the
///             given specifiers.
///         :raises InvalidSpecifier:
///             If the given specifier is invalid (i.e. bad syntax).
///         """
///         match = self._regex.search(spec)
///         if not match:
///             raise InvalidSpecifier(f"Invalid specifier: '{spec}'")
///
///         self._spec: Tuple[str, str] = (
///             match.group("operator").strip(),
///             match.group("version").strip(),
///         )
///
///         # Store whether or not this Specifier should accept prereleases
///         self._prereleases = prereleases
///
///     # https://github.com/python/mypy/pull/13475#pullrequestreview-1079784515
///     @property  # type: ignore[override]
///     def prereleases(self) -> bool:
///         # If there is an explicit prereleases set for this, then we'll just
///         # blindly use that.
///         if self._prereleases is not None:
///             return self._prereleases
///
///         # Look at all of our specifiers and determine if they are inclusive
///         # operators, and if they are if they are including an explicit
///         # prerelease.
///         operator, version = self._spec
///         if operator in ["==", ">=", "<=", "~=", "==="]:
///             # The == specifier can include a trailing .*, if it does we
///             # want to remove before parsing.
///             if operator == "==" and version.endswith(".*"):
///                 version = version[:-2]
///
///             # Parse the version, and if it is a pre-release than this
///             # specifier allows pre-releases.
///             if Version(version).is_prerelease:
///                 return True
///
///         return False
///
///     @prereleases.setter
///     def prereleases(self, value: bool) -> None:
///         self._prereleases = value
///
///     @property
///     def operator(self) -> str:
///         """The operator of this specifier.
///
///         >>> Specifier("==1.2.3").operator
///         '=='
///         """
///         return self._spec[0]
///
///     @property
///     def version(self) -> str:
///         """The version of this specifier.
///
///         >>> Specifier("==1.2.3").version
///         '1.2.3'
///         """
///         return self._spec[1]
///
///     def __repr__(self) -> str:
///         """A representation of the Specifier that shows all internal state.
///
///         >>> Specifier('>=1.0.0')
///         <Specifier('>=1.0.0')>
///         >>> Specifier('>=1.0.0', prereleases=False)
///         <Specifier('>=1.0.0', prereleases=False)>
///         >>> Specifier('>=1.0.0', prereleases=True)
///         <Specifier('>=1.0.0', prereleases=True)>
///         """
///         pre = (
///             f", prereleases={self.prereleases!r}"
///             if self._prereleases is not None
///             else ""
///         )
///
///         return f"<{self.__class__.__name__}({str(self)!r}{pre})>"
///
///     def __str__(self) -> str:
///         """A string representation of the Specifier that can be round-tripped.
///
///         >>> str(Specifier('>=1.0.0'))
///         '>=1.0.0'
///         >>> str(Specifier('>=1.0.0', prereleases=False))
///         '>=1.0.0'
///         """
///         return "{}{}".format(*self._spec)
///
///     @property
///     def _canonical_spec(self) -> Tuple[str, str]:
///         canonical_version = canonicalize_version(
///             self._spec[1],
///             strip_trailing_zero=(self._spec[0] != "~="),
///         )
///         return self._spec[0], canonical_version
///
///     def __hash__(self) -> int:
///         return hash(self._canonical_spec)
///
///     def __eq__(self, other: object) -> bool:
///         """Whether or not the two Specifier-like objects are equal.
///
///         :param other: The other object to check against.
///
///         The value of :attr:`prereleases` is ignored.
///
///         >>> Specifier("==1.2.3") == Specifier("== 1.2.3.0")
///         True
///         >>> (Specifier("==1.2.3", prereleases=False) ==
///         ...  Specifier("==1.2.3", prereleases=True))
///         True
///         >>> Specifier("==1.2.3") == "==1.2.3"
///         True
///         >>> Specifier("==1.2.3") == Specifier("==1.2.4")
///         False
///         >>> Specifier("==1.2.3") == Specifier("~=1.2.3")
///         False
///         """
///         if isinstance(other, str):
///             try:
///                 other = self.__class__(str(other))
///             except InvalidSpecifier:
///                 return NotImplemented
///         elif not isinstance(other, self.__class__):
///             return NotImplemented
///
///         return self._canonical_spec == other._canonical_spec
///
///     def _get_operator(self, op: str) -> CallableOperator:
///         operator_callable: CallableOperator = getattr(
///             self, f"_compare_{self._operators[op]}"
///         )
///         return operator_callable
///
///     def _compare_compatible(self, prospective: Version, spec: str) -> bool:
///
///         # Compatible releases have an equivalent combination of >= and ==. That
///         # is that ~=2.2 is equivalent to >=2.2,==2.*. This allows us to
///         # implement this in terms of the other specifiers instead of
///         # implementing it ourselves. The only thing we need to do is construct
///         # the other specifiers.
///
///         # We want everything but the last item in the version, but we want to
///         # ignore suffix segments.
///         prefix = ".".join(
///             list(itertools.takewhile(_is_not_suffix, _version_split(spec)))[:-1]
///         )
///
///         # Add the prefix notation to the end of our string
///         prefix += ".*"
///
///         return self._get_operator(">=")(prospective, spec) and self._get_operator("==")(
///             prospective, prefix
///         )
///
///     def _compare_equal(self, prospective: Version, spec: str) -> bool:
///
///         # We need special logic to handle prefix matching
///         if spec.endswith(".*"):
///             # In the case of prefix matching we want to ignore local segment.
///             normalized_prospective = canonicalize_version(
///                 prospective.public, strip_trailing_zero=False
///             )
///             # Get the normalized version string ignoring the trailing .*
///             normalized_spec = canonicalize_version(spec[:-2], strip_trailing_zero=False)
///             # Split the spec out by dots, and pretend that there is an implicit
///             # dot in between a release segment and a pre-release segment.
///             split_spec = _version_split(normalized_spec)
///
///             # Split the prospective version out by dots, and pretend that there
///             # is an implicit dot in between a release segment and a pre-release
///             # segment.
///             split_prospective = _version_split(normalized_prospective)
///
///             # 0-pad the prospective version before shortening it to get the correct
///             # shortened version.
///             padded_prospective, _ = _pad_version(split_prospective, split_spec)
///
///             # Shorten the prospective version to be the same length as the spec
///             # so that we can determine if the specifier is a prefix of the
///             # prospective version or not.
///             shortened_prospective = padded_prospective[: len(split_spec)]
///
///             return shortened_prospective == split_spec
///         else:
///             # Convert our spec string into a Version
///             spec_version = Version(spec)
///
///             # If the specifier does not have a local segment, then we want to
///             # act as if the prospective version also does not have a local
///             # segment.
///             if not spec_version.local:
///                 prospective = Version(prospective.public)
///
///             return prospective == spec_version
///
///     def _compare_not_equal(self, prospective: Version, spec: str) -> bool:
///         return not self._compare_equal(prospective, spec)
///
///     def _compare_less_than_equal(self, prospective: Version, spec: str) -> bool:
///
///         # NB: Local version identifiers are NOT permitted in the version
///         # specifier, so local version labels can be universally removed from
///         # the prospective version.
///         return Version(prospective.public) <= Version(spec)
///
///     def _compare_greater_than_equal(self, prospective: Version, spec: str) -> bool:
///
///         # NB: Local version identifiers are NOT permitted in the version
///         # specifier, so local version labels can be universally removed from
///         # the prospective version.
///         return Version(prospective.public) >= Version(spec)
///
///     def _compare_less_than(self, prospective: Version, spec_str: str) -> bool:
///
///         # Convert our spec to a Version instance, since we'll want to work with
///         # it as a version.
///         spec = Version(spec_str)
///
///         # Check to see if the prospective version is less than the spec
///         # version. If it's not we can short circuit and just return False now
///         # instead of doing extra unneeded work.
///         if not prospective < spec:
///             return False
///
///         # This special case is here so that, unless the specifier itself
///         # includes is a pre-release version, that we do not accept pre-release
///         # versions for the version mentioned in the specifier (e.g. <3.1 should
///         # not match 3.1.dev0, but should match 3.0.dev0).
///         if not spec.is_prerelease and prospective.is_prerelease:
///             if Version(prospective.base_version) == Version(spec.base_version):
///                 return False
///
///         # If we've gotten to here, it means that prospective version is both
///         # less than the spec version *and* it's not a pre-release of the same
///         # version in the spec.
///         return True
///
///     def _compare_greater_than(self, prospective: Version, spec_str: str) -> bool:
///
///         # Convert our spec to a Version instance, since we'll want to work with
///         # it as a version.
///         spec = Version(spec_str)
///
///         # Check to see if the prospective version is greater than the spec
///         # version. If it's not we can short circuit and just return False now
///         # instead of doing extra unneeded work.
///         if not prospective > spec:
///             return False
///
///         # This special case is here so that, unless the specifier itself
///         # includes is a post-release version, that we do not accept
///         # post-release versions for the version mentioned in the specifier
///         # (e.g. >3.1 should not match 3.0.post0, but should match 3.2.post0).
///         if not spec.is_postrelease and prospective.is_postrelease:
///             if Version(prospective.base_version) == Version(spec.base_version):
///                 return False
///
///         # Ensure that we do not allow a local version of the version mentioned
///         # in the specifier, which is technically greater than, to match.
///         if prospective.local is not None:
///             if Version(prospective.base_version) == Version(spec.base_version):
///                 return False
///
///         # If we've gotten to here, it means that prospective version is both
///         # greater than the spec version *and* it's not a pre-release of the
///         # same version in the spec.
///         return True
///
///     def _compare_arbitrary(self, prospective: Version, spec: str) -> bool:
///         return str(prospective).lower() == str(spec).lower()
///
///     def __contains__(self, item: Union[str, Version]) -> bool:
///         """Return whether or not the item is contained in this specifier.
///
///         :param item: The item to check for.
///
///         This is used for the ``in`` operator and behaves the same as
///         :meth:`contains` with no ``prereleases`` argument passed.
///
///         >>> "1.2.3" in Specifier(">=1.2.3")
///         True
///         >>> Version("1.2.3") in Specifier(">=1.2.3")
///         True
///         >>> "1.0.0" in Specifier(">=1.2.3")
///         False
///         >>> "1.3.0a1" in Specifier(">=1.2.3")
///         False
///         >>> "1.3.0a1" in Specifier(">=1.2.3", prereleases=True)
///         True
///         """
///         return self.contains(item)
///
///     def contains(
///         self, item: UnparsedVersion, prereleases: Optional[bool] = None
///     ) -> bool:
///         """Return whether or not the item is contained in this specifier.
///
///         :param item:
///             The item to check for, which can be a version string or a
///             :class:`Version` instance.
///         :param prereleases:
///             Whether or not to match prereleases with this Specifier. If set to
///             ``None`` (the default), it uses :attr:`prereleases` to determine
///             whether or not prereleases are allowed.
///
///         >>> Specifier(">=1.2.3").contains("1.2.3")
///         True
///         >>> Specifier(">=1.2.3").contains(Version("1.2.3"))
///         True
///         >>> Specifier(">=1.2.3").contains("1.0.0")
///         False
///         >>> Specifier(">=1.2.3").contains("1.3.0a1")
///         False
///         >>> Specifier(">=1.2.3", prereleases=True).contains("1.3.0a1")
///         True
///         >>> Specifier(">=1.2.3").contains("1.3.0a1", prereleases=True)
///         True
///         """
///
///         # Determine if prereleases are to be allowed or not.
///         if prereleases is None:
///             prereleases = self.prereleases
///
///         # Normalize item to a Version, this allows us to have a shortcut for
///         # "2.0" in Specifier(">=2")
///         normalized_item = _coerce_version(item)
///
///         # Determine if we should be supporting prereleases in this specifier
///         # or not, if we do not support prereleases than we can short circuit
///         # logic if this version is a prereleases.
///         if normalized_item.is_prerelease and not prereleases:
///             return False
///
///         # Actually do the comparison to determine if this item is contained
///         # within this Specifier or not.
///         operator_callable: CallableOperator = self._get_operator(self.operator)
///         return operator_callable(normalized_item, self.version)
///
///     def filter(
///         self, iterable: Iterable[UnparsedVersionVar], prereleases: Optional[bool] = None
///     ) -> Iterator[UnparsedVersionVar]:
///         """Filter items in the given iterable, that match the specifier.
///
///         :param iterable:
///             An iterable that can contain version strings and :class:`Version` instances.
///             The items in the iterable will be filtered according to the specifier.
///         :param prereleases:
///             Whether or not to allow prereleases in the returned iterator. If set to
///             ``None`` (the default), it will be intelligently decide whether to allow
///             prereleases or not (based on the :attr:`prereleases` attribute, and
///             whether the only versions matching are prereleases).
///
///         This method is smarter than just ``filter(Specifier().contains, [...])``
///         because it implements the rule from :pep:`440` that a prerelease item
///         SHOULD be accepted if no other versions match the given specifier.
///
///         >>> list(Specifier(">=1.2.3").filter(["1.2", "1.3", "1.5a1"]))
///         ['1.3']
///         >>> list(Specifier(">=1.2.3").filter(["1.2", "1.2.3", "1.3", Version("1.4")]))
///         ['1.2.3', '1.3', <Version('1.4')>]
///         >>> list(Specifier(">=1.2.3").filter(["1.2", "1.5a1"]))
///         ['1.5a1']
///         >>> list(Specifier(">=1.2.3").filter(["1.3", "1.5a1"], prereleases=True))
///         ['1.3', '1.5a1']
///         >>> list(Specifier(">=1.2.3", prereleases=True).filter(["1.3", "1.5a1"]))
///         ['1.3', '1.5a1']
///         """
///
///         yielded = False
///         found_prereleases = []
///
///         kw = {"prereleases": prereleases if prereleases is not None else True}
///
///         # Attempt to iterate over all the values in the iterable and if any of
///         # them match, yield them.
///         for version in iterable:
///             parsed_version = _coerce_version(version)
///
///             if self.contains(parsed_version, **kw):
///                 # If our version is a prerelease, and we were not set to allow
///                 # prereleases, then we'll store it for later in case nothing
///                 # else matches this specifier.
///                 if parsed_version.is_prerelease and not (
///                     prereleases or self.prereleases
///                 ):
///                     found_prereleases.append(version)
///                 # Either this is not a prerelease, or we should have been
///                 # accepting prereleases from the beginning.
///                 else:
///                     yielded = True
///                     yield version
///
///         # Now that we've iterated over everything, determine if we've yielded
///         # any values, and if we have not and we have any prereleases stored up
///         # then we will go ahead and yield the prereleases.
///         if not yielded and found_prereleases:
///             for version in found_prereleases:
///                 yield version
/// ```
final class Specifier extends PythonClass {
  factory Specifier({
    String spec = "",
    Object? prereleases,
  }) =>
      PythonFfiDart.instance.importClass(
        "packaging.specifiers",
        "Specifier",
        Specifier.from,
        <Object?>[
          spec,
          prereleases,
        ],
        <String, Object?>{},
      );

  Specifier.from(super.pythonClass) : super.from();

  /// ## contains
  ///
  /// ### python docstring
  ///
  /// Return whether or not the item is contained in this specifier.
  ///
  /// :param item:
  ///     The item to check for, which can be a version string or a
  ///     :class:`Version` instance.
  /// :param prereleases:
  ///     Whether or not to match prereleases with this Specifier. If set to
  ///     ``None`` (the default), it uses :attr:`prereleases` to determine
  ///     whether or not prereleases are allowed.
  ///
  /// >>> Specifier(">=1.2.3").contains("1.2.3")
  /// True
  /// >>> Specifier(">=1.2.3").contains(Version("1.2.3"))
  /// True
  /// >>> Specifier(">=1.2.3").contains("1.0.0")
  /// False
  /// >>> Specifier(">=1.2.3").contains("1.3.0a1")
  /// False
  /// >>> Specifier(">=1.2.3", prereleases=True).contains("1.3.0a1")
  /// True
  /// >>> Specifier(">=1.2.3").contains("1.3.0a1", prereleases=True)
  /// True
  ///
  /// ### python source
  /// ```py
  /// def contains(
  ///         self, item: UnparsedVersion, prereleases: Optional[bool] = None
  ///     ) -> bool:
  ///         """Return whether or not the item is contained in this specifier.
  ///
  ///         :param item:
  ///             The item to check for, which can be a version string or a
  ///             :class:`Version` instance.
  ///         :param prereleases:
  ///             Whether or not to match prereleases with this Specifier. If set to
  ///             ``None`` (the default), it uses :attr:`prereleases` to determine
  ///             whether or not prereleases are allowed.
  ///
  ///         >>> Specifier(">=1.2.3").contains("1.2.3")
  ///         True
  ///         >>> Specifier(">=1.2.3").contains(Version("1.2.3"))
  ///         True
  ///         >>> Specifier(">=1.2.3").contains("1.0.0")
  ///         False
  ///         >>> Specifier(">=1.2.3").contains("1.3.0a1")
  ///         False
  ///         >>> Specifier(">=1.2.3", prereleases=True).contains("1.3.0a1")
  ///         True
  ///         >>> Specifier(">=1.2.3").contains("1.3.0a1", prereleases=True)
  ///         True
  ///         """
  ///
  ///         # Determine if prereleases are to be allowed or not.
  ///         if prereleases is None:
  ///             prereleases = self.prereleases
  ///
  ///         # Normalize item to a Version, this allows us to have a shortcut for
  ///         # "2.0" in Specifier(">=2")
  ///         normalized_item = _coerce_version(item)
  ///
  ///         # Determine if we should be supporting prereleases in this specifier
  ///         # or not, if we do not support prereleases than we can short circuit
  ///         # logic if this version is a prereleases.
  ///         if normalized_item.is_prerelease and not prereleases:
  ///             return False
  ///
  ///         # Actually do the comparison to determine if this item is contained
  ///         # within this Specifier or not.
  ///         operator_callable: CallableOperator = self._get_operator(self.operator)
  ///         return operator_callable(normalized_item, self.version)
  /// ```
  bool contains({
    required Object? item,
    Object? prereleases,
  }) =>
      getFunction("contains").call(
        <Object?>[
          item,
          prereleases,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## filter
  ///
  /// ### python docstring
  ///
  /// Filter items in the given iterable, that match the specifier.
  ///
  /// :param iterable:
  ///     An iterable that can contain version strings and :class:`Version` instances.
  ///     The items in the iterable will be filtered according to the specifier.
  /// :param prereleases:
  ///     Whether or not to allow prereleases in the returned iterator. If set to
  ///     ``None`` (the default), it will be intelligently decide whether to allow
  ///     prereleases or not (based on the :attr:`prereleases` attribute, and
  ///     whether the only versions matching are prereleases).
  ///
  /// This method is smarter than just ``filter(Specifier().contains, [...])``
  /// because it implements the rule from :pep:`440` that a prerelease item
  /// SHOULD be accepted if no other versions match the given specifier.
  ///
  /// >>> list(Specifier(">=1.2.3").filter(["1.2", "1.3", "1.5a1"]))
  /// ['1.3']
  /// >>> list(Specifier(">=1.2.3").filter(["1.2", "1.2.3", "1.3", Version("1.4")]))
  /// ['1.2.3', '1.3', <Version('1.4')>]
  /// >>> list(Specifier(">=1.2.3").filter(["1.2", "1.5a1"]))
  /// ['1.5a1']
  /// >>> list(Specifier(">=1.2.3").filter(["1.3", "1.5a1"], prereleases=True))
  /// ['1.3', '1.5a1']
  /// >>> list(Specifier(">=1.2.3", prereleases=True).filter(["1.3", "1.5a1"]))
  /// ['1.3', '1.5a1']
  ///
  /// ### python source
  /// ```py
  /// def filter(
  ///         self, iterable: Iterable[UnparsedVersionVar], prereleases: Optional[bool] = None
  ///     ) -> Iterator[UnparsedVersionVar]:
  ///         """Filter items in the given iterable, that match the specifier.
  ///
  ///         :param iterable:
  ///             An iterable that can contain version strings and :class:`Version` instances.
  ///             The items in the iterable will be filtered according to the specifier.
  ///         :param prereleases:
  ///             Whether or not to allow prereleases in the returned iterator. If set to
  ///             ``None`` (the default), it will be intelligently decide whether to allow
  ///             prereleases or not (based on the :attr:`prereleases` attribute, and
  ///             whether the only versions matching are prereleases).
  ///
  ///         This method is smarter than just ``filter(Specifier().contains, [...])``
  ///         because it implements the rule from :pep:`440` that a prerelease item
  ///         SHOULD be accepted if no other versions match the given specifier.
  ///
  ///         >>> list(Specifier(">=1.2.3").filter(["1.2", "1.3", "1.5a1"]))
  ///         ['1.3']
  ///         >>> list(Specifier(">=1.2.3").filter(["1.2", "1.2.3", "1.3", Version("1.4")]))
  ///         ['1.2.3', '1.3', <Version('1.4')>]
  ///         >>> list(Specifier(">=1.2.3").filter(["1.2", "1.5a1"]))
  ///         ['1.5a1']
  ///         >>> list(Specifier(">=1.2.3").filter(["1.3", "1.5a1"], prereleases=True))
  ///         ['1.3', '1.5a1']
  ///         >>> list(Specifier(">=1.2.3", prereleases=True).filter(["1.3", "1.5a1"]))
  ///         ['1.3', '1.5a1']
  ///         """
  ///
  ///         yielded = False
  ///         found_prereleases = []
  ///
  ///         kw = {"prereleases": prereleases if prereleases is not None else True}
  ///
  ///         # Attempt to iterate over all the values in the iterable and if any of
  ///         # them match, yield them.
  ///         for version in iterable:
  ///             parsed_version = _coerce_version(version)
  ///
  ///             if self.contains(parsed_version, **kw):
  ///                 # If our version is a prerelease, and we were not set to allow
  ///                 # prereleases, then we'll store it for later in case nothing
  ///                 # else matches this specifier.
  ///                 if parsed_version.is_prerelease and not (
  ///                     prereleases or self.prereleases
  ///                 ):
  ///                     found_prereleases.append(version)
  ///                 # Either this is not a prerelease, or we should have been
  ///                 # accepting prereleases from the beginning.
  ///                 else:
  ///                     yielded = True
  ///                     yield version
  ///
  ///         # Now that we've iterated over everything, determine if we've yielded
  ///         # any values, and if we have not and we have any prereleases stored up
  ///         # then we will go ahead and yield the prereleases.
  ///         if not yielded and found_prereleases:
  ///             for version in found_prereleases:
  ///                 yield version
  /// ```
  Iterator<Object?> filter({
    required Iterable<Object?> iterable,
    Object? prereleases,
  }) =>
      TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("filter").call(
            <Object?>[
              iterable,
              prereleases,
            ],
            kwargs: <String, Object?>{},
          ),
        ),
      ).transform((e) => e).cast<Object?>();

  /// ## operator (getter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of version specifiers.
  ///
  /// .. tip::
  ///
  ///     It is generally not required to instantiate this manually. You should instead
  ///     prefer to work with :class:`SpecifierSet` instead, which can parse
  ///     comma-separated version specifiers (which is what package metadata contains).
  Object? get $operator => getAttribute("operator");

  /// ## operator (setter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of version specifiers.
  ///
  /// .. tip::
  ///
  ///     It is generally not required to instantiate this manually. You should instead
  ///     prefer to work with :class:`SpecifierSet` instead, which can parse
  ///     comma-separated version specifiers (which is what package metadata contains).
  set $operator(Object? $operator) => setAttribute("operator", $operator);

  /// ## prereleases (getter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of version specifiers.
  ///
  /// .. tip::
  ///
  ///     It is generally not required to instantiate this manually. You should instead
  ///     prefer to work with :class:`SpecifierSet` instead, which can parse
  ///     comma-separated version specifiers (which is what package metadata contains).
  Object? get prereleases => getAttribute("prereleases");

  /// ## prereleases (setter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of version specifiers.
  ///
  /// .. tip::
  ///
  ///     It is generally not required to instantiate this manually. You should instead
  ///     prefer to work with :class:`SpecifierSet` instead, which can parse
  ///     comma-separated version specifiers (which is what package metadata contains).
  set prereleases(Object? prereleases) =>
      setAttribute("prereleases", prereleases);

  /// ## version (getter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of version specifiers.
  ///
  /// .. tip::
  ///
  ///     It is generally not required to instantiate this manually. You should instead
  ///     prefer to work with :class:`SpecifierSet` instead, which can parse
  ///     comma-separated version specifiers (which is what package metadata contains).
  Object? get version => getAttribute("version");

  /// ## version (setter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of version specifiers.
  ///
  /// .. tip::
  ///
  ///     It is generally not required to instantiate this manually. You should instead
  ///     prefer to work with :class:`SpecifierSet` instead, which can parse
  ///     comma-separated version specifiers (which is what package metadata contains).
  set version(Object? version) => setAttribute("version", version);
}

/// ## UndefinedComparison
///
/// ### python docstring
///
/// An invalid operation was attempted on a value that doesn't support it.
///
/// ### python source
/// ```py
/// class UndefinedComparison(ValueError):
///     """
///     An invalid operation was attempted on a value that doesn't support it.
///     """
/// ```
final class UndefinedComparison extends PythonClass {
  factory UndefinedComparison() => PythonFfiDart.instance.importClass(
        "packaging.markers",
        "UndefinedComparison",
        UndefinedComparison.from,
        <Object?>[],
      );

  UndefinedComparison.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// An invalid operation was attempted on a value that doesn't support it.
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// An invalid operation was attempted on a value that doesn't support it.
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// An invalid operation was attempted on a value that doesn't support it.
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// An invalid operation was attempted on a value that doesn't support it.
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// An invalid operation was attempted on a value that doesn't support it.
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// An invalid operation was attempted on a value that doesn't support it.
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## UndefinedEnvironmentName
///
/// ### python docstring
///
/// A name was attempted to be used that does not exist inside of the
/// environment.
///
/// ### python source
/// ```py
/// class UndefinedEnvironmentName(ValueError):
///     """
///     A name was attempted to be used that does not exist inside of the
///     environment.
///     """
/// ```
final class UndefinedEnvironmentName extends PythonClass {
  factory UndefinedEnvironmentName() => PythonFfiDart.instance.importClass(
        "packaging.markers",
        "UndefinedEnvironmentName",
        UndefinedEnvironmentName.from,
        <Object?>[],
      );

  UndefinedEnvironmentName.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// A name was attempted to be used that does not exist inside of the
  /// environment.
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// A name was attempted to be used that does not exist inside of the
  /// environment.
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// A name was attempted to be used that does not exist inside of the
  /// environment.
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// A name was attempted to be used that does not exist inside of the
  /// environment.
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// A name was attempted to be used that does not exist inside of the
  /// environment.
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// A name was attempted to be used that does not exist inside of the
  /// environment.
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## Value
///
/// ### python source
/// ```py
/// class Value(Node):
///     def serialize(self) -> str:
///         return f'"{self}"'
/// ```
final class Value extends PythonClass {
  factory Value({
    required String value,
  }) =>
      PythonFfiDart.instance.importClass(
        "packaging._parser",
        "Value",
        Value.from,
        <Object?>[
          value,
        ],
        <String, Object?>{},
      );

  Value.from(super.pythonClass) : super.from();

  /// ## serialize
  ///
  /// ### python source
  /// ```py
  /// def serialize(self) -> str:
  ///         return f'"{self}"'
  /// ```
  String serialize() => getFunction("serialize").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## value (getter)
  Object? get value => getAttribute("value");

  /// ## value (setter)
  set value(Object? value) => setAttribute("value", value);
}

/// ## Variable
///
/// ### python source
/// ```py
/// class Variable(Node):
///     def serialize(self) -> str:
///         return str(self)
/// ```
final class Variable extends PythonClass {
  factory Variable({
    required String value,
  }) =>
      PythonFfiDart.instance.importClass(
        "packaging._parser",
        "Variable",
        Variable.from,
        <Object?>[
          value,
        ],
        <String, Object?>{},
      );

  Variable.from(super.pythonClass) : super.from();

  /// ## serialize
  ///
  /// ### python source
  /// ```py
  /// def serialize(self) -> str:
  ///         return str(self)
  /// ```
  String serialize() => getFunction("serialize").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## value (getter)
  Object? get value => getAttribute("value");

  /// ## value (setter)
  set value(Object? value) => setAttribute("value", value);
}

/// ## InvalidRequirement
///
/// ### python docstring
///
/// An invalid requirement was found, users should refer to PEP 508.
///
/// ### python source
/// ```py
/// class InvalidRequirement(ValueError):
///     """
///     An invalid requirement was found, users should refer to PEP 508.
///     """
/// ```
final class InvalidRequirement extends PythonClass {
  factory InvalidRequirement() => PythonFfiDart.instance.importClass(
        "packaging.requirements",
        "InvalidRequirement",
        InvalidRequirement.from,
        <Object?>[],
      );

  InvalidRequirement.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// An invalid requirement was found, users should refer to PEP 508.
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// An invalid requirement was found, users should refer to PEP 508.
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// An invalid requirement was found, users should refer to PEP 508.
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// An invalid requirement was found, users should refer to PEP 508.
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// An invalid requirement was found, users should refer to PEP 508.
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// An invalid requirement was found, users should refer to PEP 508.
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## Requirement
///
/// ### python docstring
///
/// Parse a requirement.
///
/// Parse a given requirement string into its parts, such as name, specifier,
/// URL, and extras. Raises InvalidRequirement on a badly-formed requirement
/// string.
///
/// ### python source
/// ```py
/// class Requirement:
///     """Parse a requirement.
///
///     Parse a given requirement string into its parts, such as name, specifier,
///     URL, and extras. Raises InvalidRequirement on a badly-formed requirement
///     string.
///     """
///
///     # TODO: Can we test whether something is contained within a requirement?
///     #       If so how do we do that? Do we need to test against the _name_ of
///     #       the thing as well as the version? What about the markers?
///     # TODO: Can we normalize the name and extra name?
///
///     def __init__(self, requirement_string: str) -> None:
///         try:
///             parsed = _parse_requirement(requirement_string)
///         except ParserSyntaxError as e:
///             raise InvalidRequirement(str(e)) from e
///
///         self.name: str = parsed.name
///         if parsed.url:
///             parsed_url = urllib.parse.urlparse(parsed.url)
///             if parsed_url.scheme == "file":
///                 if urllib.parse.urlunparse(parsed_url) != parsed.url:
///                     raise InvalidRequirement("Invalid URL given")
///             elif not (parsed_url.scheme and parsed_url.netloc) or (
///                 not parsed_url.scheme and not parsed_url.netloc
///             ):
///                 raise InvalidRequirement(f"Invalid URL: {parsed.url}")
///             self.url: Optional[str] = parsed.url
///         else:
///             self.url = None
///         self.extras: Set[str] = set(parsed.extras if parsed.extras else [])
///         self.specifier: SpecifierSet = SpecifierSet(parsed.specifier)
///         self.marker: Optional[Marker] = None
///         if parsed.marker is not None:
///             self.marker = Marker.__new__(Marker)
///             self.marker._markers = _normalize_extra_values(parsed.marker)
///
///     def __str__(self) -> str:
///         parts: List[str] = [self.name]
///
///         if self.extras:
///             formatted_extras = ",".join(sorted(self.extras))
///             parts.append(f"[{formatted_extras}]")
///
///         if self.specifier:
///             parts.append(str(self.specifier))
///
///         if self.url:
///             parts.append(f"@ {self.url}")
///             if self.marker:
///                 parts.append(" ")
///
///         if self.marker:
///             parts.append(f"; {self.marker}")
///
///         return "".join(parts)
///
///     def __repr__(self) -> str:
///         return f"<Requirement('{self}')>"
///
///     def __hash__(self) -> int:
///         return hash((self.__class__.__name__, str(self)))
///
///     def __eq__(self, other: Any) -> bool:
///         if not isinstance(other, Requirement):
///             return NotImplemented
///
///         return (
///             self.name == other.name
///             and self.extras == other.extras
///             and self.specifier == other.specifier
///             and self.url == other.url
///             and self.marker == other.marker
///         )
/// ```
final class Requirement extends PythonClass {
  factory Requirement({
    required String requirement_string,
  }) =>
      PythonFfiDart.instance.importClass(
        "packaging.requirements",
        "Requirement",
        Requirement.from,
        <Object?>[
          requirement_string,
        ],
        <String, Object?>{},
      );

  Requirement.from(super.pythonClass) : super.from();

  /// ## name (getter)
  ///
  /// ### python docstring
  ///
  /// Parse a requirement.
  ///
  /// Parse a given requirement string into its parts, such as name, specifier,
  /// URL, and extras. Raises InvalidRequirement on a badly-formed requirement
  /// string.
  Object? get name => getAttribute("name");

  /// ## name (setter)
  ///
  /// ### python docstring
  ///
  /// Parse a requirement.
  ///
  /// Parse a given requirement string into its parts, such as name, specifier,
  /// URL, and extras. Raises InvalidRequirement on a badly-formed requirement
  /// string.
  set name(Object? name) => setAttribute("name", name);

  /// ## url (getter)
  ///
  /// ### python docstring
  ///
  /// Parse a requirement.
  ///
  /// Parse a given requirement string into its parts, such as name, specifier,
  /// URL, and extras. Raises InvalidRequirement on a badly-formed requirement
  /// string.
  Object? get url => getAttribute("url");

  /// ## url (setter)
  ///
  /// ### python docstring
  ///
  /// Parse a requirement.
  ///
  /// Parse a given requirement string into its parts, such as name, specifier,
  /// URL, and extras. Raises InvalidRequirement on a badly-formed requirement
  /// string.
  set url(Object? url) => setAttribute("url", url);

  /// ## extras (getter)
  ///
  /// ### python docstring
  ///
  /// Parse a requirement.
  ///
  /// Parse a given requirement string into its parts, such as name, specifier,
  /// URL, and extras. Raises InvalidRequirement on a badly-formed requirement
  /// string.
  Object? get extras => getAttribute("extras");

  /// ## extras (setter)
  ///
  /// ### python docstring
  ///
  /// Parse a requirement.
  ///
  /// Parse a given requirement string into its parts, such as name, specifier,
  /// URL, and extras. Raises InvalidRequirement on a badly-formed requirement
  /// string.
  set extras(Object? extras) => setAttribute("extras", extras);

  /// ## specifier (getter)
  ///
  /// ### python docstring
  ///
  /// Parse a requirement.
  ///
  /// Parse a given requirement string into its parts, such as name, specifier,
  /// URL, and extras. Raises InvalidRequirement on a badly-formed requirement
  /// string.
  Object? get specifier => getAttribute("specifier");

  /// ## specifier (setter)
  ///
  /// ### python docstring
  ///
  /// Parse a requirement.
  ///
  /// Parse a given requirement string into its parts, such as name, specifier,
  /// URL, and extras. Raises InvalidRequirement on a badly-formed requirement
  /// string.
  set specifier(Object? specifier) => setAttribute("specifier", specifier);

  /// ## marker (getter)
  ///
  /// ### python docstring
  ///
  /// Parse a requirement.
  ///
  /// Parse a given requirement string into its parts, such as name, specifier,
  /// URL, and extras. Raises InvalidRequirement on a badly-formed requirement
  /// string.
  Object? get marker => getAttribute("marker");

  /// ## marker (setter)
  ///
  /// ### python docstring
  ///
  /// Parse a requirement.
  ///
  /// Parse a given requirement string into its parts, such as name, specifier,
  /// URL, and extras. Raises InvalidRequirement on a badly-formed requirement
  /// string.
  set marker(Object? marker) => setAttribute("marker", marker);
}

/// ## SpecifierSet
///
/// ### python docstring
///
/// This class abstracts handling of a set of version specifiers.
///
/// It can be passed a single specifier (``>=3.0``), a comma-separated list of
/// specifiers (``>=3.0,!=3.1``), or no specifier at all.
///
/// ### python source
/// ```py
/// class SpecifierSet(BaseSpecifier):
///     """This class abstracts handling of a set of version specifiers.
///
///     It can be passed a single specifier (``>=3.0``), a comma-separated list of
///     specifiers (``>=3.0,!=3.1``), or no specifier at all.
///     """
///
///     def __init__(
///         self, specifiers: str = "", prereleases: Optional[bool] = None
///     ) -> None:
///         """Initialize a SpecifierSet instance.
///
///         :param specifiers:
///             The string representation of a specifier or a comma-separated list of
///             specifiers which will be parsed and normalized before use.
///         :param prereleases:
///             This tells the SpecifierSet if it should accept prerelease versions if
///             applicable or not. The default of ``None`` will autodetect it from the
///             given specifiers.
///
///         :raises InvalidSpecifier:
///             If the given ``specifiers`` are not parseable than this exception will be
///             raised.
///         """
///
///         # Split on `,` to break each individual specifier into it's own item, and
///         # strip each item to remove leading/trailing whitespace.
///         split_specifiers = [s.strip() for s in specifiers.split(",") if s.strip()]
///
///         # Parsed each individual specifier, attempting first to make it a
///         # Specifier.
///         parsed: Set[Specifier] = set()
///         for specifier in split_specifiers:
///             parsed.add(Specifier(specifier))
///
///         # Turn our parsed specifiers into a frozen set and save them for later.
///         self._specs = frozenset(parsed)
///
///         # Store our prereleases value so we can use it later to determine if
///         # we accept prereleases or not.
///         self._prereleases = prereleases
///
///     @property
///     def prereleases(self) -> Optional[bool]:
///         # If we have been given an explicit prerelease modifier, then we'll
///         # pass that through here.
///         if self._prereleases is not None:
///             return self._prereleases
///
///         # If we don't have any specifiers, and we don't have a forced value,
///         # then we'll just return None since we don't know if this should have
///         # pre-releases or not.
///         if not self._specs:
///             return None
///
///         # Otherwise we'll see if any of the given specifiers accept
///         # prereleases, if any of them do we'll return True, otherwise False.
///         return any(s.prereleases for s in self._specs)
///
///     @prereleases.setter
///     def prereleases(self, value: bool) -> None:
///         self._prereleases = value
///
///     def __repr__(self) -> str:
///         """A representation of the specifier set that shows all internal state.
///
///         Note that the ordering of the individual specifiers within the set may not
///         match the input string.
///
///         >>> SpecifierSet('>=1.0.0,!=2.0.0')
///         <SpecifierSet('!=2.0.0,>=1.0.0')>
///         >>> SpecifierSet('>=1.0.0,!=2.0.0', prereleases=False)
///         <SpecifierSet('!=2.0.0,>=1.0.0', prereleases=False)>
///         >>> SpecifierSet('>=1.0.0,!=2.0.0', prereleases=True)
///         <SpecifierSet('!=2.0.0,>=1.0.0', prereleases=True)>
///         """
///         pre = (
///             f", prereleases={self.prereleases!r}"
///             if self._prereleases is not None
///             else ""
///         )
///
///         return f"<SpecifierSet({str(self)!r}{pre})>"
///
///     def __str__(self) -> str:
///         """A string representation of the specifier set that can be round-tripped.
///
///         Note that the ordering of the individual specifiers within the set may not
///         match the input string.
///
///         >>> str(SpecifierSet(">=1.0.0,!=1.0.1"))
///         '!=1.0.1,>=1.0.0'
///         >>> str(SpecifierSet(">=1.0.0,!=1.0.1", prereleases=False))
///         '!=1.0.1,>=1.0.0'
///         """
///         return ",".join(sorted(str(s) for s in self._specs))
///
///     def __hash__(self) -> int:
///         return hash(self._specs)
///
///     def __and__(self, other: Union["SpecifierSet", str]) -> "SpecifierSet":
///         """Return a SpecifierSet which is a combination of the two sets.
///
///         :param other: The other object to combine with.
///
///         >>> SpecifierSet(">=1.0.0,!=1.0.1") & '<=2.0.0,!=2.0.1'
///         <SpecifierSet('!=1.0.1,!=2.0.1,<=2.0.0,>=1.0.0')>
///         >>> SpecifierSet(">=1.0.0,!=1.0.1") & SpecifierSet('<=2.0.0,!=2.0.1')
///         <SpecifierSet('!=1.0.1,!=2.0.1,<=2.0.0,>=1.0.0')>
///         """
///         if isinstance(other, str):
///             other = SpecifierSet(other)
///         elif not isinstance(other, SpecifierSet):
///             return NotImplemented
///
///         specifier = SpecifierSet()
///         specifier._specs = frozenset(self._specs | other._specs)
///
///         if self._prereleases is None and other._prereleases is not None:
///             specifier._prereleases = other._prereleases
///         elif self._prereleases is not None and other._prereleases is None:
///             specifier._prereleases = self._prereleases
///         elif self._prereleases == other._prereleases:
///             specifier._prereleases = self._prereleases
///         else:
///             raise ValueError(
///                 "Cannot combine SpecifierSets with True and False prerelease "
///                 "overrides."
///             )
///
///         return specifier
///
///     def __eq__(self, other: object) -> bool:
///         """Whether or not the two SpecifierSet-like objects are equal.
///
///         :param other: The other object to check against.
///
///         The value of :attr:`prereleases` is ignored.
///
///         >>> SpecifierSet(">=1.0.0,!=1.0.1") == SpecifierSet(">=1.0.0,!=1.0.1")
///         True
///         >>> (SpecifierSet(">=1.0.0,!=1.0.1", prereleases=False) ==
///         ...  SpecifierSet(">=1.0.0,!=1.0.1", prereleases=True))
///         True
///         >>> SpecifierSet(">=1.0.0,!=1.0.1") == ">=1.0.0,!=1.0.1"
///         True
///         >>> SpecifierSet(">=1.0.0,!=1.0.1") == SpecifierSet(">=1.0.0")
///         False
///         >>> SpecifierSet(">=1.0.0,!=1.0.1") == SpecifierSet(">=1.0.0,!=1.0.2")
///         False
///         """
///         if isinstance(other, (str, Specifier)):
///             other = SpecifierSet(str(other))
///         elif not isinstance(other, SpecifierSet):
///             return NotImplemented
///
///         return self._specs == other._specs
///
///     def __len__(self) -> int:
///         """Returns the number of specifiers in this specifier set."""
///         return len(self._specs)
///
///     def __iter__(self) -> Iterator[Specifier]:
///         """
///         Returns an iterator over all the underlying :class:`Specifier` instances
///         in this specifier set.
///
///         >>> sorted(SpecifierSet(">=1.0.0,!=1.0.1"), key=str)
///         [<Specifier('!=1.0.1')>, <Specifier('>=1.0.0')>]
///         """
///         return iter(self._specs)
///
///     def __contains__(self, item: UnparsedVersion) -> bool:
///         """Return whether or not the item is contained in this specifier.
///
///         :param item: The item to check for.
///
///         This is used for the ``in`` operator and behaves the same as
///         :meth:`contains` with no ``prereleases`` argument passed.
///
///         >>> "1.2.3" in SpecifierSet(">=1.0.0,!=1.0.1")
///         True
///         >>> Version("1.2.3") in SpecifierSet(">=1.0.0,!=1.0.1")
///         True
///         >>> "1.0.1" in SpecifierSet(">=1.0.0,!=1.0.1")
///         False
///         >>> "1.3.0a1" in SpecifierSet(">=1.0.0,!=1.0.1")
///         False
///         >>> "1.3.0a1" in SpecifierSet(">=1.0.0,!=1.0.1", prereleases=True)
///         True
///         """
///         return self.contains(item)
///
///     def contains(
///         self,
///         item: UnparsedVersion,
///         prereleases: Optional[bool] = None,
///         installed: Optional[bool] = None,
///     ) -> bool:
///         """Return whether or not the item is contained in this SpecifierSet.
///
///         :param item:
///             The item to check for, which can be a version string or a
///             :class:`Version` instance.
///         :param prereleases:
///             Whether or not to match prereleases with this SpecifierSet. If set to
///             ``None`` (the default), it uses :attr:`prereleases` to determine
///             whether or not prereleases are allowed.
///
///         >>> SpecifierSet(">=1.0.0,!=1.0.1").contains("1.2.3")
///         True
///         >>> SpecifierSet(">=1.0.0,!=1.0.1").contains(Version("1.2.3"))
///         True
///         >>> SpecifierSet(">=1.0.0,!=1.0.1").contains("1.0.1")
///         False
///         >>> SpecifierSet(">=1.0.0,!=1.0.1").contains("1.3.0a1")
///         False
///         >>> SpecifierSet(">=1.0.0,!=1.0.1", prereleases=True).contains("1.3.0a1")
///         True
///         >>> SpecifierSet(">=1.0.0,!=1.0.1").contains("1.3.0a1", prereleases=True)
///         True
///         """
///         # Ensure that our item is a Version instance.
///         if not isinstance(item, Version):
///             item = Version(item)
///
///         # Determine if we're forcing a prerelease or not, if we're not forcing
///         # one for this particular filter call, then we'll use whatever the
///         # SpecifierSet thinks for whether or not we should support prereleases.
///         if prereleases is None:
///             prereleases = self.prereleases
///
///         # We can determine if we're going to allow pre-releases by looking to
///         # see if any of the underlying items supports them. If none of them do
///         # and this item is a pre-release then we do not allow it and we can
///         # short circuit that here.
///         # Note: This means that 1.0.dev1 would not be contained in something
///         #       like >=1.0.devabc however it would be in >=1.0.debabc,>0.0.dev0
///         if not prereleases and item.is_prerelease:
///             return False
///
///         if installed and item.is_prerelease:
///             item = Version(item.base_version)
///
///         # We simply dispatch to the underlying specs here to make sure that the
///         # given version is contained within all of them.
///         # Note: This use of all() here means that an empty set of specifiers
///         #       will always return True, this is an explicit design decision.
///         return all(s.contains(item, prereleases=prereleases) for s in self._specs)
///
///     def filter(
///         self, iterable: Iterable[UnparsedVersionVar], prereleases: Optional[bool] = None
///     ) -> Iterator[UnparsedVersionVar]:
///         """Filter items in the given iterable, that match the specifiers in this set.
///
///         :param iterable:
///             An iterable that can contain version strings and :class:`Version` instances.
///             The items in the iterable will be filtered according to the specifier.
///         :param prereleases:
///             Whether or not to allow prereleases in the returned iterator. If set to
///             ``None`` (the default), it will be intelligently decide whether to allow
///             prereleases or not (based on the :attr:`prereleases` attribute, and
///             whether the only versions matching are prereleases).
///
///         This method is smarter than just ``filter(SpecifierSet(...).contains, [...])``
///         because it implements the rule from :pep:`440` that a prerelease item
///         SHOULD be accepted if no other versions match the given specifier.
///
///         >>> list(SpecifierSet(">=1.2.3").filter(["1.2", "1.3", "1.5a1"]))
///         ['1.3']
///         >>> list(SpecifierSet(">=1.2.3").filter(["1.2", "1.3", Version("1.4")]))
///         ['1.3', <Version('1.4')>]
///         >>> list(SpecifierSet(">=1.2.3").filter(["1.2", "1.5a1"]))
///         []
///         >>> list(SpecifierSet(">=1.2.3").filter(["1.3", "1.5a1"], prereleases=True))
///         ['1.3', '1.5a1']
///         >>> list(SpecifierSet(">=1.2.3", prereleases=True).filter(["1.3", "1.5a1"]))
///         ['1.3', '1.5a1']
///
///         An "empty" SpecifierSet will filter items based on the presence of prerelease
///         versions in the set.
///
///         >>> list(SpecifierSet("").filter(["1.3", "1.5a1"]))
///         ['1.3']
///         >>> list(SpecifierSet("").filter(["1.5a1"]))
///         ['1.5a1']
///         >>> list(SpecifierSet("", prereleases=True).filter(["1.3", "1.5a1"]))
///         ['1.3', '1.5a1']
///         >>> list(SpecifierSet("").filter(["1.3", "1.5a1"], prereleases=True))
///         ['1.3', '1.5a1']
///         """
///         # Determine if we're forcing a prerelease or not, if we're not forcing
///         # one for this particular filter call, then we'll use whatever the
///         # SpecifierSet thinks for whether or not we should support prereleases.
///         if prereleases is None:
///             prereleases = self.prereleases
///
///         # If we have any specifiers, then we want to wrap our iterable in the
///         # filter method for each one, this will act as a logical AND amongst
///         # each specifier.
///         if self._specs:
///             for spec in self._specs:
///                 iterable = spec.filter(iterable, prereleases=bool(prereleases))
///             return iter(iterable)
///         # If we do not have any specifiers, then we need to have a rough filter
///         # which will filter out any pre-releases, unless there are no final
///         # releases.
///         else:
///             filtered: List[UnparsedVersionVar] = []
///             found_prereleases: List[UnparsedVersionVar] = []
///
///             for item in iterable:
///                 parsed_version = _coerce_version(item)
///
///                 # Store any item which is a pre-release for later unless we've
///                 # already found a final version or we are accepting prereleases
///                 if parsed_version.is_prerelease and not prereleases:
///                     if not filtered:
///                         found_prereleases.append(item)
///                 else:
///                     filtered.append(item)
///
///             # If we've found no items except for pre-releases, then we'll go
///             # ahead and use the pre-releases
///             if not filtered and found_prereleases and prereleases is None:
///                 return iter(found_prereleases)
///
///             return iter(filtered)
/// ```
final class SpecifierSet extends PythonClass {
  factory SpecifierSet({
    String specifiers = "",
    Object? prereleases,
  }) =>
      PythonFfiDart.instance.importClass(
        "packaging.specifiers",
        "SpecifierSet",
        SpecifierSet.from,
        <Object?>[
          specifiers,
          prereleases,
        ],
        <String, Object?>{},
      );

  SpecifierSet.from(super.pythonClass) : super.from();

  /// ## contains
  ///
  /// ### python docstring
  ///
  /// Return whether or not the item is contained in this SpecifierSet.
  ///
  /// :param item:
  ///     The item to check for, which can be a version string or a
  ///     :class:`Version` instance.
  /// :param prereleases:
  ///     Whether or not to match prereleases with this SpecifierSet. If set to
  ///     ``None`` (the default), it uses :attr:`prereleases` to determine
  ///     whether or not prereleases are allowed.
  ///
  /// >>> SpecifierSet(">=1.0.0,!=1.0.1").contains("1.2.3")
  /// True
  /// >>> SpecifierSet(">=1.0.0,!=1.0.1").contains(Version("1.2.3"))
  /// True
  /// >>> SpecifierSet(">=1.0.0,!=1.0.1").contains("1.0.1")
  /// False
  /// >>> SpecifierSet(">=1.0.0,!=1.0.1").contains("1.3.0a1")
  /// False
  /// >>> SpecifierSet(">=1.0.0,!=1.0.1", prereleases=True).contains("1.3.0a1")
  /// True
  /// >>> SpecifierSet(">=1.0.0,!=1.0.1").contains("1.3.0a1", prereleases=True)
  /// True
  ///
  /// ### python source
  /// ```py
  /// def contains(
  ///         self,
  ///         item: UnparsedVersion,
  ///         prereleases: Optional[bool] = None,
  ///         installed: Optional[bool] = None,
  ///     ) -> bool:
  ///         """Return whether or not the item is contained in this SpecifierSet.
  ///
  ///         :param item:
  ///             The item to check for, which can be a version string or a
  ///             :class:`Version` instance.
  ///         :param prereleases:
  ///             Whether or not to match prereleases with this SpecifierSet. If set to
  ///             ``None`` (the default), it uses :attr:`prereleases` to determine
  ///             whether or not prereleases are allowed.
  ///
  ///         >>> SpecifierSet(">=1.0.0,!=1.0.1").contains("1.2.3")
  ///         True
  ///         >>> SpecifierSet(">=1.0.0,!=1.0.1").contains(Version("1.2.3"))
  ///         True
  ///         >>> SpecifierSet(">=1.0.0,!=1.0.1").contains("1.0.1")
  ///         False
  ///         >>> SpecifierSet(">=1.0.0,!=1.0.1").contains("1.3.0a1")
  ///         False
  ///         >>> SpecifierSet(">=1.0.0,!=1.0.1", prereleases=True).contains("1.3.0a1")
  ///         True
  ///         >>> SpecifierSet(">=1.0.0,!=1.0.1").contains("1.3.0a1", prereleases=True)
  ///         True
  ///         """
  ///         # Ensure that our item is a Version instance.
  ///         if not isinstance(item, Version):
  ///             item = Version(item)
  ///
  ///         # Determine if we're forcing a prerelease or not, if we're not forcing
  ///         # one for this particular filter call, then we'll use whatever the
  ///         # SpecifierSet thinks for whether or not we should support prereleases.
  ///         if prereleases is None:
  ///             prereleases = self.prereleases
  ///
  ///         # We can determine if we're going to allow pre-releases by looking to
  ///         # see if any of the underlying items supports them. If none of them do
  ///         # and this item is a pre-release then we do not allow it and we can
  ///         # short circuit that here.
  ///         # Note: This means that 1.0.dev1 would not be contained in something
  ///         #       like >=1.0.devabc however it would be in >=1.0.debabc,>0.0.dev0
  ///         if not prereleases and item.is_prerelease:
  ///             return False
  ///
  ///         if installed and item.is_prerelease:
  ///             item = Version(item.base_version)
  ///
  ///         # We simply dispatch to the underlying specs here to make sure that the
  ///         # given version is contained within all of them.
  ///         # Note: This use of all() here means that an empty set of specifiers
  ///         #       will always return True, this is an explicit design decision.
  ///         return all(s.contains(item, prereleases=prereleases) for s in self._specs)
  /// ```
  bool contains({
    required Object? item,
    Object? prereleases,
    Object? installed,
  }) =>
      getFunction("contains").call(
        <Object?>[
          item,
          prereleases,
          installed,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## filter
  ///
  /// ### python docstring
  ///
  /// Filter items in the given iterable, that match the specifiers in this set.
  ///
  /// :param iterable:
  ///     An iterable that can contain version strings and :class:`Version` instances.
  ///     The items in the iterable will be filtered according to the specifier.
  /// :param prereleases:
  ///     Whether or not to allow prereleases in the returned iterator. If set to
  ///     ``None`` (the default), it will be intelligently decide whether to allow
  ///     prereleases or not (based on the :attr:`prereleases` attribute, and
  ///     whether the only versions matching are prereleases).
  ///
  /// This method is smarter than just ``filter(SpecifierSet(...).contains, [...])``
  /// because it implements the rule from :pep:`440` that a prerelease item
  /// SHOULD be accepted if no other versions match the given specifier.
  ///
  /// >>> list(SpecifierSet(">=1.2.3").filter(["1.2", "1.3", "1.5a1"]))
  /// ['1.3']
  /// >>> list(SpecifierSet(">=1.2.3").filter(["1.2", "1.3", Version("1.4")]))
  /// ['1.3', <Version('1.4')>]
  /// >>> list(SpecifierSet(">=1.2.3").filter(["1.2", "1.5a1"]))
  /// []
  /// >>> list(SpecifierSet(">=1.2.3").filter(["1.3", "1.5a1"], prereleases=True))
  /// ['1.3', '1.5a1']
  /// >>> list(SpecifierSet(">=1.2.3", prereleases=True).filter(["1.3", "1.5a1"]))
  /// ['1.3', '1.5a1']
  ///
  /// An "empty" SpecifierSet will filter items based on the presence of prerelease
  /// versions in the set.
  ///
  /// >>> list(SpecifierSet("").filter(["1.3", "1.5a1"]))
  /// ['1.3']
  /// >>> list(SpecifierSet("").filter(["1.5a1"]))
  /// ['1.5a1']
  /// >>> list(SpecifierSet("", prereleases=True).filter(["1.3", "1.5a1"]))
  /// ['1.3', '1.5a1']
  /// >>> list(SpecifierSet("").filter(["1.3", "1.5a1"], prereleases=True))
  /// ['1.3', '1.5a1']
  ///
  /// ### python source
  /// ```py
  /// def filter(
  ///         self, iterable: Iterable[UnparsedVersionVar], prereleases: Optional[bool] = None
  ///     ) -> Iterator[UnparsedVersionVar]:
  ///         """Filter items in the given iterable, that match the specifiers in this set.
  ///
  ///         :param iterable:
  ///             An iterable that can contain version strings and :class:`Version` instances.
  ///             The items in the iterable will be filtered according to the specifier.
  ///         :param prereleases:
  ///             Whether or not to allow prereleases in the returned iterator. If set to
  ///             ``None`` (the default), it will be intelligently decide whether to allow
  ///             prereleases or not (based on the :attr:`prereleases` attribute, and
  ///             whether the only versions matching are prereleases).
  ///
  ///         This method is smarter than just ``filter(SpecifierSet(...).contains, [...])``
  ///         because it implements the rule from :pep:`440` that a prerelease item
  ///         SHOULD be accepted if no other versions match the given specifier.
  ///
  ///         >>> list(SpecifierSet(">=1.2.3").filter(["1.2", "1.3", "1.5a1"]))
  ///         ['1.3']
  ///         >>> list(SpecifierSet(">=1.2.3").filter(["1.2", "1.3", Version("1.4")]))
  ///         ['1.3', <Version('1.4')>]
  ///         >>> list(SpecifierSet(">=1.2.3").filter(["1.2", "1.5a1"]))
  ///         []
  ///         >>> list(SpecifierSet(">=1.2.3").filter(["1.3", "1.5a1"], prereleases=True))
  ///         ['1.3', '1.5a1']
  ///         >>> list(SpecifierSet(">=1.2.3", prereleases=True).filter(["1.3", "1.5a1"]))
  ///         ['1.3', '1.5a1']
  ///
  ///         An "empty" SpecifierSet will filter items based on the presence of prerelease
  ///         versions in the set.
  ///
  ///         >>> list(SpecifierSet("").filter(["1.3", "1.5a1"]))
  ///         ['1.3']
  ///         >>> list(SpecifierSet("").filter(["1.5a1"]))
  ///         ['1.5a1']
  ///         >>> list(SpecifierSet("", prereleases=True).filter(["1.3", "1.5a1"]))
  ///         ['1.3', '1.5a1']
  ///         >>> list(SpecifierSet("").filter(["1.3", "1.5a1"], prereleases=True))
  ///         ['1.3', '1.5a1']
  ///         """
  ///         # Determine if we're forcing a prerelease or not, if we're not forcing
  ///         # one for this particular filter call, then we'll use whatever the
  ///         # SpecifierSet thinks for whether or not we should support prereleases.
  ///         if prereleases is None:
  ///             prereleases = self.prereleases
  ///
  ///         # If we have any specifiers, then we want to wrap our iterable in the
  ///         # filter method for each one, this will act as a logical AND amongst
  ///         # each specifier.
  ///         if self._specs:
  ///             for spec in self._specs:
  ///                 iterable = spec.filter(iterable, prereleases=bool(prereleases))
  ///             return iter(iterable)
  ///         # If we do not have any specifiers, then we need to have a rough filter
  ///         # which will filter out any pre-releases, unless there are no final
  ///         # releases.
  ///         else:
  ///             filtered: List[UnparsedVersionVar] = []
  ///             found_prereleases: List[UnparsedVersionVar] = []
  ///
  ///             for item in iterable:
  ///                 parsed_version = _coerce_version(item)
  ///
  ///                 # Store any item which is a pre-release for later unless we've
  ///                 # already found a final version or we are accepting prereleases
  ///                 if parsed_version.is_prerelease and not prereleases:
  ///                     if not filtered:
  ///                         found_prereleases.append(item)
  ///                 else:
  ///                     filtered.append(item)
  ///
  ///             # If we've found no items except for pre-releases, then we'll go
  ///             # ahead and use the pre-releases
  ///             if not filtered and found_prereleases and prereleases is None:
  ///                 return iter(found_prereleases)
  ///
  ///             return iter(filtered)
  /// ```
  Iterator<Object?> filter({
    required Iterable<Object?> iterable,
    Object? prereleases,
  }) =>
      TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("filter").call(
            <Object?>[
              iterable,
              prereleases,
            ],
            kwargs: <String, Object?>{},
          ),
        ),
      ).transform((e) => e).cast<Object?>();

  /// ## prereleases (getter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a set of version specifiers.
  ///
  /// It can be passed a single specifier (``>=3.0``), a comma-separated list of
  /// specifiers (``>=3.0,!=3.1``), or no specifier at all.
  Object? get prereleases => getAttribute("prereleases");

  /// ## prereleases (setter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a set of version specifiers.
  ///
  /// It can be passed a single specifier (``>=3.0``), a comma-separated list of
  /// specifiers (``>=3.0,!=3.1``), or no specifier at all.
  set prereleases(Object? prereleases) =>
      setAttribute("prereleases", prereleases);
}

/// ## BaseSpecifier
///
/// ### python source
/// ```py
/// class BaseSpecifier(metaclass=abc.ABCMeta):
///     @abc.abstractmethod
///     def __str__(self) -> str:
///         """
///         Returns the str representation of this Specifier-like object. This
///         should be representative of the Specifier itself.
///         """
///
///     @abc.abstractmethod
///     def __hash__(self) -> int:
///         """
///         Returns a hash value for this Specifier-like object.
///         """
///
///     @abc.abstractmethod
///     def __eq__(self, other: object) -> bool:
///         """
///         Returns a boolean representing whether or not the two Specifier-like
///         objects are equal.
///
///         :param other: The other object to check against.
///         """
///
///     @property
///     @abc.abstractmethod
///     def prereleases(self) -> Optional[bool]:
///         """Whether or not pre-releases as a whole are allowed.
///
///         This can be set to either ``True`` or ``False`` to explicitly enable or disable
///         prereleases or it can be set to ``None`` (the default) to use default semantics.
///         """
///
///     @prereleases.setter
///     def prereleases(self, value: bool) -> None:
///         """Setter for :attr:`prereleases`.
///
///         :param value: The value to set.
///         """
///
///     @abc.abstractmethod
///     def contains(self, item: str, prereleases: Optional[bool] = None) -> bool:
///         """
///         Determines if the given item is contained within this specifier.
///         """
///
///     @abc.abstractmethod
///     def filter(
///         self, iterable: Iterable[UnparsedVersionVar], prereleases: Optional[bool] = None
///     ) -> Iterator[UnparsedVersionVar]:
///         """
///         Takes an iterable of items and filters them so that only items which
///         are contained within this specifier are allowed in it.
///         """
/// ```
final class BaseSpecifier extends PythonClass {
  factory BaseSpecifier() => PythonFfiDart.instance.importClass(
        "packaging.specifiers",
        "BaseSpecifier",
        BaseSpecifier.from,
        <Object?>[],
      );

  BaseSpecifier.from(super.pythonClass) : super.from();

  /// ## contains
  ///
  /// ### python docstring
  ///
  /// Determines if the given item is contained within this specifier.
  ///
  /// ### python source
  /// ```py
  /// @abc.abstractmethod
  ///     def contains(self, item: str, prereleases: Optional[bool] = None) -> bool:
  ///         """
  ///         Determines if the given item is contained within this specifier.
  ///         """
  /// ```
  bool contains({
    required String item,
    Object? prereleases,
  }) =>
      getFunction("contains").call(
        <Object?>[
          item,
          prereleases,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## filter
  ///
  /// ### python docstring
  ///
  /// Takes an iterable of items and filters them so that only items which
  /// are contained within this specifier are allowed in it.
  ///
  /// ### python source
  /// ```py
  /// @abc.abstractmethod
  ///     def filter(
  ///         self, iterable: Iterable[UnparsedVersionVar], prereleases: Optional[bool] = None
  ///     ) -> Iterator[UnparsedVersionVar]:
  ///         """
  ///         Takes an iterable of items and filters them so that only items which
  ///         are contained within this specifier are allowed in it.
  ///         """
  /// ```
  Iterator<Object?> filter({
    required Iterable<Object?> iterable,
    Object? prereleases,
  }) =>
      TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("filter").call(
            <Object?>[
              iterable,
              prereleases,
            ],
            kwargs: <String, Object?>{},
          ),
        ),
      ).transform((e) => e).cast<Object?>();

  /// ## prereleases (getter)
  Object? get prereleases => getAttribute("prereleases");

  /// ## prereleases (setter)
  set prereleases(Object? prereleases) =>
      setAttribute("prereleases", prereleases);
}

/// ## Version
///
/// ### python docstring
///
/// This class abstracts handling of a project's versions.
///
/// A :class:`Version` instance is comparison aware and can be compared and
/// sorted using the standard Python interfaces.
///
/// >>> v1 = Version("1.0a5")
/// >>> v2 = Version("1.0")
/// >>> v1
/// <Version('1.0a5')>
/// >>> v2
/// <Version('1.0')>
/// >>> v1 < v2
/// True
/// >>> v1 == v2
/// False
/// >>> v1 > v2
/// False
/// >>> v1 >= v2
/// False
/// >>> v1 <= v2
/// True
///
/// ### python source
/// ```py
/// class Version(_BaseVersion):
///     """This class abstracts handling of a project's versions.
///
///     A :class:`Version` instance is comparison aware and can be compared and
///     sorted using the standard Python interfaces.
///
///     >>> v1 = Version("1.0a5")
///     >>> v2 = Version("1.0")
///     >>> v1
///     <Version('1.0a5')>
///     >>> v2
///     <Version('1.0')>
///     >>> v1 < v2
///     True
///     >>> v1 == v2
///     False
///     >>> v1 > v2
///     False
///     >>> v1 >= v2
///     False
///     >>> v1 <= v2
///     True
///     """
///
///     _regex = re.compile(r"^\s*" + VERSION_PATTERN + r"\s*$", re.VERBOSE | re.IGNORECASE)
///     _key: CmpKey
///
///     def __init__(self, version: str) -> None:
///         """Initialize a Version object.
///
///         :param version:
///             The string representation of a version which will be parsed and normalized
///             before use.
///         :raises InvalidVersion:
///             If the ``version`` does not conform to PEP 440 in any way then this
///             exception will be raised.
///         """
///
///         # Validate the version and parse it into pieces
///         match = self._regex.search(version)
///         if not match:
///             raise InvalidVersion(f"Invalid version: '{version}'")
///
///         # Store the parsed out pieces of the version
///         self._version = _Version(
///             epoch=int(match.group("epoch")) if match.group("epoch") else 0,
///             release=tuple(int(i) for i in match.group("release").split(".")),
///             pre=_parse_letter_version(match.group("pre_l"), match.group("pre_n")),
///             post=_parse_letter_version(
///                 match.group("post_l"), match.group("post_n1") or match.group("post_n2")
///             ),
///             dev=_parse_letter_version(match.group("dev_l"), match.group("dev_n")),
///             local=_parse_local_version(match.group("local")),
///         )
///
///         # Generate a key which will be used for sorting
///         self._key = _cmpkey(
///             self._version.epoch,
///             self._version.release,
///             self._version.pre,
///             self._version.post,
///             self._version.dev,
///             self._version.local,
///         )
///
///     def __repr__(self) -> str:
///         """A representation of the Version that shows all internal state.
///
///         >>> Version('1.0.0')
///         <Version('1.0.0')>
///         """
///         return f"<Version('{self}')>"
///
///     def __str__(self) -> str:
///         """A string representation of the version that can be rounded-tripped.
///
///         >>> str(Version("1.0a5"))
///         '1.0a5'
///         """
///         parts = []
///
///         # Epoch
///         if self.epoch != 0:
///             parts.append(f"{self.epoch}!")
///
///         # Release segment
///         parts.append(".".join(str(x) for x in self.release))
///
///         # Pre-release
///         if self.pre is not None:
///             parts.append("".join(str(x) for x in self.pre))
///
///         # Post-release
///         if self.post is not None:
///             parts.append(f".post{self.post}")
///
///         # Development release
///         if self.dev is not None:
///             parts.append(f".dev{self.dev}")
///
///         # Local version segment
///         if self.local is not None:
///             parts.append(f"+{self.local}")
///
///         return "".join(parts)
///
///     @property
///     def epoch(self) -> int:
///         """The epoch of the version.
///
///         >>> Version("2.0.0").epoch
///         0
///         >>> Version("1!2.0.0").epoch
///         1
///         """
///         _epoch: int = self._version.epoch
///         return _epoch
///
///     @property
///     def release(self) -> Tuple[int, ...]:
///         """The components of the "release" segment of the version.
///
///         >>> Version("1.2.3").release
///         (1, 2, 3)
///         >>> Version("2.0.0").release
///         (2, 0, 0)
///         >>> Version("1!2.0.0.post0").release
///         (2, 0, 0)
///
///         Includes trailing zeroes but not the epoch or any pre-release / development /
///         post-release suffixes.
///         """
///         _release: Tuple[int, ...] = self._version.release
///         return _release
///
///     @property
///     def pre(self) -> Optional[Tuple[str, int]]:
///         """The pre-release segment of the version.
///
///         >>> print(Version("1.2.3").pre)
///         None
///         >>> Version("1.2.3a1").pre
///         ('a', 1)
///         >>> Version("1.2.3b1").pre
///         ('b', 1)
///         >>> Version("1.2.3rc1").pre
///         ('rc', 1)
///         """
///         _pre: Optional[Tuple[str, int]] = self._version.pre
///         return _pre
///
///     @property
///     def post(self) -> Optional[int]:
///         """The post-release number of the version.
///
///         >>> print(Version("1.2.3").post)
///         None
///         >>> Version("1.2.3.post1").post
///         1
///         """
///         return self._version.post[1] if self._version.post else None
///
///     @property
///     def dev(self) -> Optional[int]:
///         """The development number of the version.
///
///         >>> print(Version("1.2.3").dev)
///         None
///         >>> Version("1.2.3.dev1").dev
///         1
///         """
///         return self._version.dev[1] if self._version.dev else None
///
///     @property
///     def local(self) -> Optional[str]:
///         """The local version segment of the version.
///
///         >>> print(Version("1.2.3").local)
///         None
///         >>> Version("1.2.3+abc").local
///         'abc'
///         """
///         if self._version.local:
///             return ".".join(str(x) for x in self._version.local)
///         else:
///             return None
///
///     @property
///     def public(self) -> str:
///         """The public portion of the version.
///
///         >>> Version("1.2.3").public
///         '1.2.3'
///         >>> Version("1.2.3+abc").public
///         '1.2.3'
///         >>> Version("1.2.3+abc.dev1").public
///         '1.2.3'
///         """
///         return str(self).split("+", 1)[0]
///
///     @property
///     def base_version(self) -> str:
///         """The "base version" of the version.
///
///         >>> Version("1.2.3").base_version
///         '1.2.3'
///         >>> Version("1.2.3+abc").base_version
///         '1.2.3'
///         >>> Version("1!1.2.3+abc.dev1").base_version
///         '1!1.2.3'
///
///         The "base version" is the public version of the project without any pre or post
///         release markers.
///         """
///         parts = []
///
///         # Epoch
///         if self.epoch != 0:
///             parts.append(f"{self.epoch}!")
///
///         # Release segment
///         parts.append(".".join(str(x) for x in self.release))
///
///         return "".join(parts)
///
///     @property
///     def is_prerelease(self) -> bool:
///         """Whether this version is a pre-release.
///
///         >>> Version("1.2.3").is_prerelease
///         False
///         >>> Version("1.2.3a1").is_prerelease
///         True
///         >>> Version("1.2.3b1").is_prerelease
///         True
///         >>> Version("1.2.3rc1").is_prerelease
///         True
///         >>> Version("1.2.3dev1").is_prerelease
///         True
///         """
///         return self.dev is not None or self.pre is not None
///
///     @property
///     def is_postrelease(self) -> bool:
///         """Whether this version is a post-release.
///
///         >>> Version("1.2.3").is_postrelease
///         False
///         >>> Version("1.2.3.post1").is_postrelease
///         True
///         """
///         return self.post is not None
///
///     @property
///     def is_devrelease(self) -> bool:
///         """Whether this version is a development release.
///
///         >>> Version("1.2.3").is_devrelease
///         False
///         >>> Version("1.2.3.dev1").is_devrelease
///         True
///         """
///         return self.dev is not None
///
///     @property
///     def major(self) -> int:
///         """The first item of :attr:`release` or ``0`` if unavailable.
///
///         >>> Version("1.2.3").major
///         1
///         """
///         return self.release[0] if len(self.release) >= 1 else 0
///
///     @property
///     def minor(self) -> int:
///         """The second item of :attr:`release` or ``0`` if unavailable.
///
///         >>> Version("1.2.3").minor
///         2
///         >>> Version("1").minor
///         0
///         """
///         return self.release[1] if len(self.release) >= 2 else 0
///
///     @property
///     def micro(self) -> int:
///         """The third item of :attr:`release` or ``0`` if unavailable.
///
///         >>> Version("1.2.3").micro
///         3
///         >>> Version("1").micro
///         0
///         """
///         return self.release[2] if len(self.release) >= 3 else 0
/// ```
final class Version extends PythonClass {
  factory Version({
    required String version,
  }) =>
      PythonFfiDart.instance.importClass(
        "packaging.version",
        "Version",
        Version.from,
        <Object?>[
          version,
        ],
        <String, Object?>{},
      );

  Version.from(super.pythonClass) : super.from();

  /// ## base_version (getter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  Object? get base_version => getAttribute("base_version");

  /// ## base_version (setter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  set base_version(Object? base_version) =>
      setAttribute("base_version", base_version);

  /// ## dev (getter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  Object? get dev => getAttribute("dev");

  /// ## dev (setter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  set dev(Object? dev) => setAttribute("dev", dev);

  /// ## epoch (getter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  Object? get epoch => getAttribute("epoch");

  /// ## epoch (setter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  set epoch(Object? epoch) => setAttribute("epoch", epoch);

  /// ## is_devrelease (getter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  Object? get is_devrelease => getAttribute("is_devrelease");

  /// ## is_devrelease (setter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  set is_devrelease(Object? is_devrelease) =>
      setAttribute("is_devrelease", is_devrelease);

  /// ## is_postrelease (getter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  Object? get is_postrelease => getAttribute("is_postrelease");

  /// ## is_postrelease (setter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  set is_postrelease(Object? is_postrelease) =>
      setAttribute("is_postrelease", is_postrelease);

  /// ## is_prerelease (getter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  Object? get is_prerelease => getAttribute("is_prerelease");

  /// ## is_prerelease (setter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  set is_prerelease(Object? is_prerelease) =>
      setAttribute("is_prerelease", is_prerelease);

  /// ## local (getter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  Object? get local => getAttribute("local");

  /// ## local (setter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  set local(Object? local) => setAttribute("local", local);

  /// ## major (getter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  Object? get major => getAttribute("major");

  /// ## major (setter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  set major(Object? major) => setAttribute("major", major);

  /// ## micro (getter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  Object? get micro => getAttribute("micro");

  /// ## micro (setter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  set micro(Object? micro) => setAttribute("micro", micro);

  /// ## minor (getter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  Object? get minor => getAttribute("minor");

  /// ## minor (setter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  set minor(Object? minor) => setAttribute("minor", minor);

  /// ## post (getter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  Object? get post => getAttribute("post");

  /// ## post (setter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  set post(Object? post) => setAttribute("post", post);

  /// ## pre (getter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  Object? get pre => getAttribute("pre");

  /// ## pre (setter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  set pre(Object? pre) => setAttribute("pre", pre);

  /// ## public (getter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  Object? get public => getAttribute("public");

  /// ## public (setter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  set public(Object? public) => setAttribute("public", public);

  /// ## release (getter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  Object? get release => getAttribute("release");

  /// ## release (setter)
  ///
  /// ### python docstring
  ///
  /// This class abstracts handling of a project's versions.
  ///
  /// A :class:`Version` instance is comparison aware and can be compared and
  /// sorted using the standard Python interfaces.
  ///
  /// >>> v1 = Version("1.0a5")
  /// >>> v2 = Version("1.0")
  /// >>> v1
  /// <Version('1.0a5')>
  /// >>> v2
  /// <Version('1.0')>
  /// >>> v1 < v2
  /// True
  /// >>> v1 == v2
  /// False
  /// >>> v1 > v2
  /// False
  /// >>> v1 >= v2
  /// False
  /// >>> v1 <= v2
  /// True
  set release(Object? release) => setAttribute("release", release);
}

/// ## accumulate
final class accumulate extends PythonClass {
  factory accumulate() => PythonFfiDart.instance.importClass(
        "itertools",
        "accumulate",
        accumulate.from,
        <Object?>[],
      );

  accumulate.from(super.pythonClass) : super.from();
}

/// ## chain
final class chain extends PythonClass {
  factory chain() => PythonFfiDart.instance.importClass(
        "itertools",
        "chain",
        chain.from,
        <Object?>[],
      );

  chain.from(super.pythonClass) : super.from();
}

/// ## combinations
final class combinations extends PythonClass {
  factory combinations() => PythonFfiDart.instance.importClass(
        "itertools",
        "combinations",
        combinations.from,
        <Object?>[],
      );

  combinations.from(super.pythonClass) : super.from();
}

/// ## combinations_with_replacement
final class combinations_with_replacement extends PythonClass {
  factory combinations_with_replacement() => PythonFfiDart.instance.importClass(
        "itertools",
        "combinations_with_replacement",
        combinations_with_replacement.from,
        <Object?>[],
      );

  combinations_with_replacement.from(super.pythonClass) : super.from();
}

/// ## compress
final class compress extends PythonClass {
  factory compress() => PythonFfiDart.instance.importClass(
        "itertools",
        "compress",
        compress.from,
        <Object?>[],
      );

  compress.from(super.pythonClass) : super.from();
}

/// ## count
final class count extends PythonClass {
  factory count() => PythonFfiDart.instance.importClass(
        "itertools",
        "count",
        count.from,
        <Object?>[],
      );

  count.from(super.pythonClass) : super.from();
}

/// ## cycle
final class cycle extends PythonClass {
  factory cycle() => PythonFfiDart.instance.importClass(
        "itertools",
        "cycle",
        cycle.from,
        <Object?>[],
      );

  cycle.from(super.pythonClass) : super.from();
}

/// ## dropwhile
final class dropwhile extends PythonClass {
  factory dropwhile() => PythonFfiDart.instance.importClass(
        "itertools",
        "dropwhile",
        dropwhile.from,
        <Object?>[],
      );

  dropwhile.from(super.pythonClass) : super.from();
}

/// ## filterfalse
final class filterfalse extends PythonClass {
  factory filterfalse() => PythonFfiDart.instance.importClass(
        "itertools",
        "filterfalse",
        filterfalse.from,
        <Object?>[],
      );

  filterfalse.from(super.pythonClass) : super.from();
}

/// ## groupby
final class groupby extends PythonClass {
  factory groupby() => PythonFfiDart.instance.importClass(
        "itertools",
        "groupby",
        groupby.from,
        <Object?>[],
      );

  groupby.from(super.pythonClass) : super.from();
}

/// ## islice
final class islice extends PythonClass {
  factory islice() => PythonFfiDart.instance.importClass(
        "itertools",
        "islice",
        islice.from,
        <Object?>[],
      );

  islice.from(super.pythonClass) : super.from();
}

/// ## pairwise
final class pairwise extends PythonClass {
  factory pairwise() => PythonFfiDart.instance.importClass(
        "itertools",
        "pairwise",
        pairwise.from,
        <Object?>[],
      );

  pairwise.from(super.pythonClass) : super.from();
}

/// ## permutations
final class permutations extends PythonClass {
  factory permutations() => PythonFfiDart.instance.importClass(
        "itertools",
        "permutations",
        permutations.from,
        <Object?>[],
      );

  permutations.from(super.pythonClass) : super.from();
}

/// ## product
final class product extends PythonClass {
  factory product() => PythonFfiDart.instance.importClass(
        "itertools",
        "product",
        product.from,
        <Object?>[],
      );

  product.from(super.pythonClass) : super.from();
}

/// ## repeat
final class repeat extends PythonClass {
  factory repeat() => PythonFfiDart.instance.importClass(
        "itertools",
        "repeat",
        repeat.from,
        <Object?>[],
      );

  repeat.from(super.pythonClass) : super.from();
}

/// ## starmap
final class starmap extends PythonClass {
  factory starmap() => PythonFfiDart.instance.importClass(
        "itertools",
        "starmap",
        starmap.from,
        <Object?>[],
      );

  starmap.from(super.pythonClass) : super.from();
}

/// ## takewhile
final class takewhile extends PythonClass {
  factory takewhile() => PythonFfiDart.instance.importClass(
        "itertools",
        "takewhile",
        takewhile.from,
        <Object?>[],
      );

  takewhile.from(super.pythonClass) : super.from();
}

/// ## zip_longest
final class zip_longest extends PythonClass {
  factory zip_longest() => PythonFfiDart.instance.importClass(
        "itertools",
        "zip_longest",
        zip_longest.from,
        <Object?>[],
      );

  zip_longest.from(super.pythonClass) : super.from();
}

/// ## Tag
///
/// ### python docstring
///
/// A representation of the tag triple for a wheel.
///
/// Instances are considered immutable and thus are hashable. Equality checking
/// is also supported.
///
/// ### python source
/// ```py
/// class Tag:
///     """
///     A representation of the tag triple for a wheel.
///
///     Instances are considered immutable and thus are hashable. Equality checking
///     is also supported.
///     """
///
///     __slots__ = ["_interpreter", "_abi", "_platform", "_hash"]
///
///     def __init__(self, interpreter: str, abi: str, platform: str) -> None:
///         self._interpreter = interpreter.lower()
///         self._abi = abi.lower()
///         self._platform = platform.lower()
///         # The __hash__ of every single element in a Set[Tag] will be evaluated each time
///         # that a set calls its `.disjoint()` method, which may be called hundreds of
///         # times when scanning a page of links for packages with tags matching that
///         # Set[Tag]. Pre-computing the value here produces significant speedups for
///         # downstream consumers.
///         self._hash = hash((self._interpreter, self._abi, self._platform))
///
///     @property
///     def interpreter(self) -> str:
///         return self._interpreter
///
///     @property
///     def abi(self) -> str:
///         return self._abi
///
///     @property
///     def platform(self) -> str:
///         return self._platform
///
///     def __eq__(self, other: object) -> bool:
///         if not isinstance(other, Tag):
///             return NotImplemented
///
///         return (
///             (self._hash == other._hash)  # Short-circuit ASAP for perf reasons.
///             and (self._platform == other._platform)
///             and (self._abi == other._abi)
///             and (self._interpreter == other._interpreter)
///         )
///
///     def __hash__(self) -> int:
///         return self._hash
///
///     def __str__(self) -> str:
///         return f"{self._interpreter}-{self._abi}-{self._platform}"
///
///     def __repr__(self) -> str:
///         return f"<{self} @ {id(self)}>"
/// ```
final class Tag extends PythonClass {
  factory Tag({
    required String interpreter,
    required String abi,
    required String platform,
  }) =>
      PythonFfiDart.instance.importClass(
        "packaging.tags",
        "Tag",
        Tag.from,
        <Object?>[
          interpreter,
          abi,
          platform,
        ],
        <String, Object?>{},
      );

  Tag.from(super.pythonClass) : super.from();

  /// ## abi (getter)
  ///
  /// ### python docstring
  ///
  /// A representation of the tag triple for a wheel.
  ///
  /// Instances are considered immutable and thus are hashable. Equality checking
  /// is also supported.
  Object? get abi => getAttribute("abi");

  /// ## abi (setter)
  ///
  /// ### python docstring
  ///
  /// A representation of the tag triple for a wheel.
  ///
  /// Instances are considered immutable and thus are hashable. Equality checking
  /// is also supported.
  set abi(Object? abi) => setAttribute("abi", abi);

  /// ## interpreter (getter)
  ///
  /// ### python docstring
  ///
  /// A representation of the tag triple for a wheel.
  ///
  /// Instances are considered immutable and thus are hashable. Equality checking
  /// is also supported.
  Object? get interpreter => getAttribute("interpreter");

  /// ## interpreter (setter)
  ///
  /// ### python docstring
  ///
  /// A representation of the tag triple for a wheel.
  ///
  /// Instances are considered immutable and thus are hashable. Equality checking
  /// is also supported.
  set interpreter(Object? interpreter) =>
      setAttribute("interpreter", interpreter);

  /// ## platform (getter)
  ///
  /// ### python docstring
  ///
  /// A representation of the tag triple for a wheel.
  ///
  /// Instances are considered immutable and thus are hashable. Equality checking
  /// is also supported.
  Object? get $platform => getAttribute("platform");

  /// ## platform (setter)
  ///
  /// ### python docstring
  ///
  /// A representation of the tag triple for a wheel.
  ///
  /// Instances are considered immutable and thus are hashable. Equality checking
  /// is also supported.
  set $platform(Object? $platform) => setAttribute("platform", $platform);
}

/// ## InvalidSdistFilename
///
/// ### python docstring
///
/// An invalid sdist filename was found, users should refer to the packaging user guide.
///
/// ### python source
/// ```py
/// class InvalidSdistFilename(ValueError):
///     """
///     An invalid sdist filename was found, users should refer to the packaging user guide.
///     """
/// ```
final class InvalidSdistFilename extends PythonClass {
  factory InvalidSdistFilename() => PythonFfiDart.instance.importClass(
        "packaging.utils",
        "InvalidSdistFilename",
        InvalidSdistFilename.from,
        <Object?>[],
      );

  InvalidSdistFilename.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// An invalid sdist filename was found, users should refer to the packaging user guide.
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// An invalid sdist filename was found, users should refer to the packaging user guide.
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// An invalid sdist filename was found, users should refer to the packaging user guide.
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// An invalid sdist filename was found, users should refer to the packaging user guide.
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// An invalid sdist filename was found, users should refer to the packaging user guide.
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// An invalid sdist filename was found, users should refer to the packaging user guide.
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## InvalidVersion
///
/// ### python docstring
///
/// Raised when a version string is not a valid version.
///
/// >>> Version("invalid")
/// Traceback (most recent call last):
///     ...
/// packaging.version.InvalidVersion: Invalid version: 'invalid'
///
/// ### python source
/// ```py
/// class InvalidVersion(ValueError):
///     """Raised when a version string is not a valid version.
///
///     >>> Version("invalid")
///     Traceback (most recent call last):
///         ...
///     packaging.version.InvalidVersion: Invalid version: 'invalid'
///     """
/// ```
final class InvalidVersion extends PythonClass {
  factory InvalidVersion() => PythonFfiDart.instance.importClass(
        "packaging.version",
        "InvalidVersion",
        InvalidVersion.from,
        <Object?>[],
      );

  InvalidVersion.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// Raised when a version string is not a valid version.
  ///
  /// >>> Version("invalid")
  /// Traceback (most recent call last):
  ///     ...
  /// packaging.version.InvalidVersion: Invalid version: 'invalid'
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// Raised when a version string is not a valid version.
  ///
  /// >>> Version("invalid")
  /// Traceback (most recent call last):
  ///     ...
  /// packaging.version.InvalidVersion: Invalid version: 'invalid'
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// Raised when a version string is not a valid version.
  ///
  /// >>> Version("invalid")
  /// Traceback (most recent call last):
  ///     ...
  /// packaging.version.InvalidVersion: Invalid version: 'invalid'
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// Raised when a version string is not a valid version.
  ///
  /// >>> Version("invalid")
  /// Traceback (most recent call last):
  ///     ...
  /// packaging.version.InvalidVersion: Invalid version: 'invalid'
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// Raised when a version string is not a valid version.
  ///
  /// >>> Version("invalid")
  /// Traceback (most recent call last):
  ///     ...
  /// packaging.version.InvalidVersion: Invalid version: 'invalid'
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// Raised when a version string is not a valid version.
  ///
  /// >>> Version("invalid")
  /// Traceback (most recent call last):
  ///     ...
  /// packaging.version.InvalidVersion: Invalid version: 'invalid'
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## InvalidWheelFilename
///
/// ### python docstring
///
/// An invalid wheel filename was found, users should refer to PEP 427.
///
/// ### python source
/// ```py
/// class InvalidWheelFilename(ValueError):
///     """
///     An invalid wheel filename was found, users should refer to PEP 427.
///     """
/// ```
final class InvalidWheelFilename extends PythonClass {
  factory InvalidWheelFilename() => PythonFfiDart.instance.importClass(
        "packaging.utils",
        "InvalidWheelFilename",
        InvalidWheelFilename.from,
        <Object?>[],
      );

  InvalidWheelFilename.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// An invalid wheel filename was found, users should refer to PEP 427.
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// An invalid wheel filename was found, users should refer to PEP 427.
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// An invalid wheel filename was found, users should refer to PEP 427.
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// An invalid wheel filename was found, users should refer to PEP 427.
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// An invalid wheel filename was found, users should refer to PEP 427.
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// An invalid wheel filename was found, users should refer to PEP 427.
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## InfinityType
///
/// ### python source
/// ```py
/// class InfinityType:
///     def __repr__(self) -> str:
///         return "Infinity"
///
///     def __hash__(self) -> int:
///         return hash(repr(self))
///
///     def __lt__(self, other: object) -> bool:
///         return False
///
///     def __le__(self, other: object) -> bool:
///         return False
///
///     def __eq__(self, other: object) -> bool:
///         return isinstance(other, self.__class__)
///
///     def __gt__(self, other: object) -> bool:
///         return True
///
///     def __ge__(self, other: object) -> bool:
///         return True
///
///     def __neg__(self: object) -> "NegativeInfinityType":
///         return NegativeInfinity
/// ```
final class InfinityType extends PythonClass {
  factory InfinityType() => PythonFfiDart.instance.importClass(
        "packaging._structures",
        "InfinityType",
        InfinityType.from,
        <Object?>[],
      );

  InfinityType.from(super.pythonClass) : super.from();
}

/// ## NegativeInfinityType
///
/// ### python source
/// ```py
/// class NegativeInfinityType:
///     def __repr__(self) -> str:
///         return "-Infinity"
///
///     def __hash__(self) -> int:
///         return hash(repr(self))
///
///     def __lt__(self, other: object) -> bool:
///         return True
///
///     def __le__(self, other: object) -> bool:
///         return True
///
///     def __eq__(self, other: object) -> bool:
///         return isinstance(other, self.__class__)
///
///     def __gt__(self, other: object) -> bool:
///         return False
///
///     def __ge__(self, other: object) -> bool:
///         return False
///
///     def __neg__(self: object) -> InfinityType:
///         return Infinity
/// ```
final class NegativeInfinityType extends PythonClass {
  factory NegativeInfinityType() => PythonFfiDart.instance.importClass(
        "packaging._structures",
        "NegativeInfinityType",
        NegativeInfinityType.from,
        <Object?>[],
      );

  NegativeInfinityType.from(super.pythonClass) : super.from();
}

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

/// ## markers
///
/// ### python source
/// ```py
/// # This file is dual licensed under the terms of the Apache License, Version
/// # 2.0, and the BSD License. See the LICENSE file in the root of this repository
/// # for complete details.
///
/// import operator
/// import os
/// import platform
/// import sys
/// from typing import Any, Callable, Dict, List, Optional, Tuple, Union
///
/// from ._parser import (
///     MarkerAtom,
///     MarkerList,
///     Op,
///     Value,
///     Variable,
///     parse_marker as _parse_marker,
/// )
/// from ._tokenizer import ParserSyntaxError
/// from .specifiers import InvalidSpecifier, Specifier
/// from .utils import canonicalize_name
///
/// __all__ = [
///     "InvalidMarker",
///     "UndefinedComparison",
///     "UndefinedEnvironmentName",
///     "Marker",
///     "default_environment",
/// ]
///
/// Operator = Callable[[str, str], bool]
///
///
/// class InvalidMarker(ValueError):
///     """
///     An invalid marker was found, users should refer to PEP 508.
///     """
///
///
/// class UndefinedComparison(ValueError):
///     """
///     An invalid operation was attempted on a value that doesn't support it.
///     """
///
///
/// class UndefinedEnvironmentName(ValueError):
///     """
///     A name was attempted to be used that does not exist inside of the
///     environment.
///     """
///
///
/// def _normalize_extra_values(results: Any) -> Any:
///     """
///     Normalize extra values.
///     """
///     if isinstance(results[0], tuple):
///         lhs, op, rhs = results[0]
///         if isinstance(lhs, Variable) and lhs.value == "extra":
///             normalized_extra = canonicalize_name(rhs.value)
///             rhs = Value(normalized_extra)
///         elif isinstance(rhs, Variable) and rhs.value == "extra":
///             normalized_extra = canonicalize_name(lhs.value)
///             lhs = Value(normalized_extra)
///         results[0] = lhs, op, rhs
///     return results
///
///
/// def _format_marker(
///     marker: Union[List[str], MarkerAtom, str], first: Optional[bool] = True
/// ) -> str:
///
///     assert isinstance(marker, (list, tuple, str))
///
///     # Sometimes we have a structure like [[...]] which is a single item list
///     # where the single item is itself it's own list. In that case we want skip
///     # the rest of this function so that we don't get extraneous () on the
///     # outside.
///     if (
///         isinstance(marker, list)
///         and len(marker) == 1
///         and isinstance(marker[0], (list, tuple))
///     ):
///         return _format_marker(marker[0])
///
///     if isinstance(marker, list):
///         inner = (_format_marker(m, first=False) for m in marker)
///         if first:
///             return " ".join(inner)
///         else:
///             return "(" + " ".join(inner) + ")"
///     elif isinstance(marker, tuple):
///         return " ".join([m.serialize() for m in marker])
///     else:
///         return marker
///
///
/// _operators: Dict[str, Operator] = {
///     "in": lambda lhs, rhs: lhs in rhs,
///     "not in": lambda lhs, rhs: lhs not in rhs,
///     "<": operator.lt,
///     "<=": operator.le,
///     "==": operator.eq,
///     "!=": operator.ne,
///     ">=": operator.ge,
///     ">": operator.gt,
/// }
///
///
/// def _eval_op(lhs: str, op: Op, rhs: str) -> bool:
///     try:
///         spec = Specifier("".join([op.serialize(), rhs]))
///     except InvalidSpecifier:
///         pass
///     else:
///         return spec.contains(lhs, prereleases=True)
///
///     oper: Optional[Operator] = _operators.get(op.serialize())
///     if oper is None:
///         raise UndefinedComparison(f"Undefined {op!r} on {lhs!r} and {rhs!r}.")
///
///     return oper(lhs, rhs)
///
///
/// def _normalize(*values: str, key: str) -> Tuple[str, ...]:
///     # PEP 685 – Comparison of extra names for optional distribution dependencies
///     # https://peps.python.org/pep-0685/
///     # > When comparing extra names, tools MUST normalize the names being
///     # > compared using the semantics outlined in PEP 503 for names
///     if key == "extra":
///         return tuple(canonicalize_name(v) for v in values)
///
///     # other environment markers don't have such standards
///     return values
///
///
/// def _evaluate_markers(markers: MarkerList, environment: Dict[str, str]) -> bool:
///     groups: List[List[bool]] = [[]]
///
///     for marker in markers:
///         assert isinstance(marker, (list, tuple, str))
///
///         if isinstance(marker, list):
///             groups[-1].append(_evaluate_markers(marker, environment))
///         elif isinstance(marker, tuple):
///             lhs, op, rhs = marker
///
///             if isinstance(lhs, Variable):
///                 environment_key = lhs.value
///                 lhs_value = environment[environment_key]
///                 rhs_value = rhs.value
///             else:
///                 lhs_value = lhs.value
///                 environment_key = rhs.value
///                 rhs_value = environment[environment_key]
///
///             lhs_value, rhs_value = _normalize(lhs_value, rhs_value, key=environment_key)
///             groups[-1].append(_eval_op(lhs_value, op, rhs_value))
///         else:
///             assert marker in ["and", "or"]
///             if marker == "or":
///                 groups.append([])
///
///     return any(all(item) for item in groups)
///
///
/// def format_full_version(info: "sys._version_info") -> str:
///     version = "{0.major}.{0.minor}.{0.micro}".format(info)
///     kind = info.releaselevel
///     if kind != "final":
///         version += kind[0] + str(info.serial)
///     return version
///
///
/// def default_environment() -> Dict[str, str]:
///     iver = format_full_version(sys.implementation.version)
///     implementation_name = sys.implementation.name
///     return {
///         "implementation_name": implementation_name,
///         "implementation_version": iver,
///         "os_name": os.name,
///         "platform_machine": platform.machine(),
///         "platform_release": platform.release(),
///         "platform_system": platform.system(),
///         "platform_version": platform.version(),
///         "python_full_version": platform.python_version(),
///         "platform_python_implementation": platform.python_implementation(),
///         "python_version": ".".join(platform.python_version_tuple()[:2]),
///         "sys_platform": sys.platform,
///     }
///
///
/// class Marker:
///     def __init__(self, marker: str) -> None:
///         # Note: We create a Marker object without calling this constructor in
///         #       packaging.requirements.Requirement. If any additional logic is
///         #       added here, make sure to mirror/adapt Requirement.
///         try:
///             self._markers = _normalize_extra_values(_parse_marker(marker))
///             # The attribute `_markers` can be described in terms of a recursive type:
///             # MarkerList = List[Union[Tuple[Node, ...], str, MarkerList]]
///             #
///             # For example, the following expression:
///             # python_version > "3.6" or (python_version == "3.6" and os_name == "unix")
///             #
///             # is parsed into:
///             # [
///             #     (<Variable('python_version')>, <Op('>')>, <Value('3.6')>),
///             #     'and',
///             #     [
///             #         (<Variable('python_version')>, <Op('==')>, <Value('3.6')>),
///             #         'or',
///             #         (<Variable('os_name')>, <Op('==')>, <Value('unix')>)
///             #     ]
///             # ]
///         except ParserSyntaxError as e:
///             raise InvalidMarker(str(e)) from e
///
///     def __str__(self) -> str:
///         return _format_marker(self._markers)
///
///     def __repr__(self) -> str:
///         return f"<Marker('{self}')>"
///
///     def __hash__(self) -> int:
///         return hash((self.__class__.__name__, str(self)))
///
///     def __eq__(self, other: Any) -> bool:
///         if not isinstance(other, Marker):
///             return NotImplemented
///
///         return str(self) == str(other)
///
///     def evaluate(self, environment: Optional[Dict[str, str]] = None) -> bool:
///         """Evaluate a marker.
///
///         Return the boolean from evaluating the given marker against the
///         environment. environment is an optional argument to override all or
///         part of the determined environment.
///
///         The environment is determined from the current Python process.
///         """
///         current_environment = default_environment()
///         current_environment["extra"] = ""
///         if environment is not None:
///             current_environment.update(environment)
///             # The API used to allow setting extra to None. We need to handle this
///             # case for backwards compatibility.
///             if current_environment["extra"] is None:
///                 current_environment["extra"] = ""
///
///         return _evaluate_markers(self._markers, current_environment)
/// ```
final class markers extends PythonModule {
  markers.from(super.pythonModule) : super.from();

  static markers import() => PythonFfiDart.instance.importModule(
        "packaging.markers",
        markers.from,
      );

  /// ## default_environment
  ///
  /// ### python source
  /// ```py
  /// def default_environment() -> Dict[str, str]:
  ///     iver = format_full_version(sys.implementation.version)
  ///     implementation_name = sys.implementation.name
  ///     return {
  ///         "implementation_name": implementation_name,
  ///         "implementation_version": iver,
  ///         "os_name": os.name,
  ///         "platform_machine": platform.machine(),
  ///         "platform_release": platform.release(),
  ///         "platform_system": platform.system(),
  ///         "platform_version": platform.version(),
  ///         "python_full_version": platform.python_version(),
  ///         "platform_python_implementation": platform.python_implementation(),
  ///         "python_version": ".".join(platform.python_version_tuple()[:2]),
  ///         "sys_platform": sys.platform,
  ///     }
  /// ```
  Object? default_environment() => getFunction("default_environment").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## format_full_version
  ///
  /// ### python source
  /// ```py
  /// def format_full_version(info: "sys._version_info") -> str:
  ///     version = "{0.major}.{0.minor}.{0.micro}".format(info)
  ///     kind = info.releaselevel
  ///     if kind != "final":
  ///         version += kind[0] + str(info.serial)
  ///     return version
  /// ```
  String format_full_version({
    required Object? info,
  }) =>
      getFunction("format_full_version").call(
        <Object?>[
          info,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## sys
final class sys extends PythonModule {
  sys.from(super.pythonModule) : super.from();

  static sys import() => PythonFfiDart.instance.importModule(
        "sys",
        sys.from,
      );

  /// ## abiflags (getter)
  Object? get abiflags => getAttribute("abiflags");

  /// ## abiflags (setter)
  set abiflags(Object? abiflags) => setAttribute("abiflags", abiflags);

  /// ## api_version (getter)
  Object? get api_version => getAttribute("api_version");

  /// ## api_version (setter)
  set api_version(Object? api_version) =>
      setAttribute("api_version", api_version);

  /// ## argv (getter)
  Object? get argv => getAttribute("argv");

  /// ## argv (setter)
  set argv(Object? argv) => setAttribute("argv", argv);

  /// ## base_exec_prefix (getter)
  Object? get base_exec_prefix => getAttribute("base_exec_prefix");

  /// ## base_exec_prefix (setter)
  set base_exec_prefix(Object? base_exec_prefix) =>
      setAttribute("base_exec_prefix", base_exec_prefix);

  /// ## base_prefix (getter)
  Object? get base_prefix => getAttribute("base_prefix");

  /// ## base_prefix (setter)
  set base_prefix(Object? base_prefix) =>
      setAttribute("base_prefix", base_prefix);

  /// ## builtin_module_names (getter)
  Object? get builtin_module_names => getAttribute("builtin_module_names");

  /// ## builtin_module_names (setter)
  set builtin_module_names(Object? builtin_module_names) =>
      setAttribute("builtin_module_names", builtin_module_names);

  /// ## byteorder (getter)
  Object? get byteorder => getAttribute("byteorder");

  /// ## byteorder (setter)
  set byteorder(Object? byteorder) => setAttribute("byteorder", byteorder);

  /// ## copyright (getter)
  Object? get copyright => getAttribute("copyright");

  /// ## copyright (setter)
  set copyright(Object? copyright) => setAttribute("copyright", copyright);

  /// ## dont_write_bytecode (getter)
  Object? get dont_write_bytecode => getAttribute("dont_write_bytecode");

  /// ## dont_write_bytecode (setter)
  set dont_write_bytecode(Object? dont_write_bytecode) =>
      setAttribute("dont_write_bytecode", dont_write_bytecode);

  /// ## exec_prefix (getter)
  Object? get exec_prefix => getAttribute("exec_prefix");

  /// ## exec_prefix (setter)
  set exec_prefix(Object? exec_prefix) =>
      setAttribute("exec_prefix", exec_prefix);

  /// ## executable (getter)
  Object? get executable => getAttribute("executable");

  /// ## executable (setter)
  set executable(Object? executable) => setAttribute("executable", executable);

  /// ## flags (getter)
  Object? get flags => getAttribute("flags");

  /// ## flags (setter)
  set flags(Object? flags) => setAttribute("flags", flags);

  /// ## float_info (getter)
  Object? get float_info => getAttribute("float_info");

  /// ## float_info (setter)
  set float_info(Object? float_info) => setAttribute("float_info", float_info);

  /// ## float_repr_style (getter)
  Object? get float_repr_style => getAttribute("float_repr_style");

  /// ## float_repr_style (setter)
  set float_repr_style(Object? float_repr_style) =>
      setAttribute("float_repr_style", float_repr_style);

  /// ## hash_info (getter)
  Object? get hash_info => getAttribute("hash_info");

  /// ## hash_info (setter)
  set hash_info(Object? hash_info) => setAttribute("hash_info", hash_info);

  /// ## hexversion (getter)
  Object? get hexversion => getAttribute("hexversion");

  /// ## hexversion (setter)
  set hexversion(Object? hexversion) => setAttribute("hexversion", hexversion);

  /// ## int_info (getter)
  Object? get int_info => getAttribute("int_info");

  /// ## int_info (setter)
  set int_info(Object? int_info) => setAttribute("int_info", int_info);

  /// ## maxsize (getter)
  Object? get maxsize => getAttribute("maxsize");

  /// ## maxsize (setter)
  set maxsize(Object? maxsize) => setAttribute("maxsize", maxsize);

  /// ## maxunicode (getter)
  Object? get maxunicode => getAttribute("maxunicode");

  /// ## maxunicode (setter)
  set maxunicode(Object? maxunicode) => setAttribute("maxunicode", maxunicode);

  /// ## meta_path (getter)
  Object? get meta_path => getAttribute("meta_path");

  /// ## meta_path (setter)
  set meta_path(Object? meta_path) => setAttribute("meta_path", meta_path);

  /// ## modules (getter)
  Object? get modules => getAttribute("modules");

  /// ## modules (setter)
  set modules(Object? modules) => setAttribute("modules", modules);

  /// ## orig_argv (getter)
  Object? get orig_argv => getAttribute("orig_argv");

  /// ## orig_argv (setter)
  set orig_argv(Object? orig_argv) => setAttribute("orig_argv", orig_argv);

  /// ## path (getter)
  Object? get path => getAttribute("path");

  /// ## path (setter)
  set path(Object? path) => setAttribute("path", path);

  /// ## path_hooks (getter)
  Object? get path_hooks => getAttribute("path_hooks");

  /// ## path_hooks (setter)
  set path_hooks(Object? path_hooks) => setAttribute("path_hooks", path_hooks);

  /// ## path_importer_cache (getter)
  Object? get path_importer_cache => getAttribute("path_importer_cache");

  /// ## path_importer_cache (setter)
  set path_importer_cache(Object? path_importer_cache) =>
      setAttribute("path_importer_cache", path_importer_cache);

  /// ## platform (getter)
  Object? get $platform => getAttribute("platform");

  /// ## platform (setter)
  set $platform(Object? $platform) => setAttribute("platform", $platform);

  /// ## platlibdir (getter)
  Object? get platlibdir => getAttribute("platlibdir");

  /// ## platlibdir (setter)
  set platlibdir(Object? platlibdir) => setAttribute("platlibdir", platlibdir);

  /// ## prefix (getter)
  Object? get prefix => getAttribute("prefix");

  /// ## prefix (setter)
  set prefix(Object? prefix) => setAttribute("prefix", prefix);

  /// ## pycache_prefix (getter)
  Null get pycache_prefix => getAttribute("pycache_prefix");

  /// ## pycache_prefix (setter)
  set pycache_prefix(Null pycache_prefix) =>
      setAttribute("pycache_prefix", pycache_prefix);

  /// ## thread_info (getter)
  Object? get thread_info => getAttribute("thread_info");

  /// ## thread_info (setter)
  set thread_info(Object? thread_info) =>
      setAttribute("thread_info", thread_info);

  /// ## version (getter)
  Object? get version => getAttribute("version");

  /// ## version (setter)
  set version(Object? version) => setAttribute("version", version);

  /// ## version_info (getter)
  Object? get version_info => getAttribute("version_info");

  /// ## version_info (setter)
  set version_info(Object? version_info) =>
      setAttribute("version_info", version_info);

  /// ## warnoptions (getter)
  Object? get warnoptions => getAttribute("warnoptions");

  /// ## warnoptions (setter)
  set warnoptions(Object? warnoptions) =>
      setAttribute("warnoptions", warnoptions);
}

/// ## requirements
///
/// ### python source
/// ```py
/// # This file is dual licensed under the terms of the Apache License, Version
/// # 2.0, and the BSD License. See the LICENSE file in the root of this repository
/// # for complete details.
///
/// import urllib.parse
/// from typing import Any, List, Optional, Set
///
/// from ._parser import parse_requirement as _parse_requirement
/// from ._tokenizer import ParserSyntaxError
/// from .markers import Marker, _normalize_extra_values
/// from .specifiers import SpecifierSet
///
///
/// class InvalidRequirement(ValueError):
///     """
///     An invalid requirement was found, users should refer to PEP 508.
///     """
///
///
/// class Requirement:
///     """Parse a requirement.
///
///     Parse a given requirement string into its parts, such as name, specifier,
///     URL, and extras. Raises InvalidRequirement on a badly-formed requirement
///     string.
///     """
///
///     # TODO: Can we test whether something is contained within a requirement?
///     #       If so how do we do that? Do we need to test against the _name_ of
///     #       the thing as well as the version? What about the markers?
///     # TODO: Can we normalize the name and extra name?
///
///     def __init__(self, requirement_string: str) -> None:
///         try:
///             parsed = _parse_requirement(requirement_string)
///         except ParserSyntaxError as e:
///             raise InvalidRequirement(str(e)) from e
///
///         self.name: str = parsed.name
///         if parsed.url:
///             parsed_url = urllib.parse.urlparse(parsed.url)
///             if parsed_url.scheme == "file":
///                 if urllib.parse.urlunparse(parsed_url) != parsed.url:
///                     raise InvalidRequirement("Invalid URL given")
///             elif not (parsed_url.scheme and parsed_url.netloc) or (
///                 not parsed_url.scheme and not parsed_url.netloc
///             ):
///                 raise InvalidRequirement(f"Invalid URL: {parsed.url}")
///             self.url: Optional[str] = parsed.url
///         else:
///             self.url = None
///         self.extras: Set[str] = set(parsed.extras if parsed.extras else [])
///         self.specifier: SpecifierSet = SpecifierSet(parsed.specifier)
///         self.marker: Optional[Marker] = None
///         if parsed.marker is not None:
///             self.marker = Marker.__new__(Marker)
///             self.marker._markers = _normalize_extra_values(parsed.marker)
///
///     def __str__(self) -> str:
///         parts: List[str] = [self.name]
///
///         if self.extras:
///             formatted_extras = ",".join(sorted(self.extras))
///             parts.append(f"[{formatted_extras}]")
///
///         if self.specifier:
///             parts.append(str(self.specifier))
///
///         if self.url:
///             parts.append(f"@ {self.url}")
///             if self.marker:
///                 parts.append(" ")
///
///         if self.marker:
///             parts.append(f"; {self.marker}")
///
///         return "".join(parts)
///
///     def __repr__(self) -> str:
///         return f"<Requirement('{self}')>"
///
///     def __hash__(self) -> int:
///         return hash((self.__class__.__name__, str(self)))
///
///     def __eq__(self, other: Any) -> bool:
///         if not isinstance(other, Requirement):
///             return NotImplemented
///
///         return (
///             self.name == other.name
///             and self.extras == other.extras
///             and self.specifier == other.specifier
///             and self.url == other.url
///             and self.marker == other.marker
///         )
/// ```
final class requirements extends PythonModule {
  requirements.from(super.pythonModule) : super.from();

  static requirements import() => PythonFfiDart.instance.importModule(
        "packaging.requirements",
        requirements.from,
      );
}

/// ## specifiers
///
/// ### python docstring
///
/// .. testsetup::
///
///     from packaging.specifiers import Specifier, SpecifierSet, InvalidSpecifier
///     from packaging.version import Version
///
/// ### python source
/// ```py
/// # This file is dual licensed under the terms of the Apache License, Version
/// # 2.0, and the BSD License. See the LICENSE file in the root of this repository
/// # for complete details.
/// """
/// .. testsetup::
///
///     from packaging.specifiers import Specifier, SpecifierSet, InvalidSpecifier
///     from packaging.version import Version
/// """
///
/// import abc
/// import itertools
/// import re
/// from typing import (
///     Callable,
///     Iterable,
///     Iterator,
///     List,
///     Optional,
///     Set,
///     Tuple,
///     TypeVar,
///     Union,
/// )
///
/// from .utils import canonicalize_version
/// from .version import Version
///
/// UnparsedVersion = Union[Version, str]
/// UnparsedVersionVar = TypeVar("UnparsedVersionVar", bound=UnparsedVersion)
/// CallableOperator = Callable[[Version, str], bool]
///
///
/// def _coerce_version(version: UnparsedVersion) -> Version:
///     if not isinstance(version, Version):
///         version = Version(version)
///     return version
///
///
/// class InvalidSpecifier(ValueError):
///     """
///     Raised when attempting to create a :class:`Specifier` with a specifier
///     string that is invalid.
///
///     >>> Specifier("lolwat")
///     Traceback (most recent call last):
///         ...
///     packaging.specifiers.InvalidSpecifier: Invalid specifier: 'lolwat'
///     """
///
///
/// class BaseSpecifier(metaclass=abc.ABCMeta):
///     @abc.abstractmethod
///     def __str__(self) -> str:
///         """
///         Returns the str representation of this Specifier-like object. This
///         should be representative of the Specifier itself.
///         """
///
///     @abc.abstractmethod
///     def __hash__(self) -> int:
///         """
///         Returns a hash value for this Specifier-like object.
///         """
///
///     @abc.abstractmethod
///     def __eq__(self, other: object) -> bool:
///         """
///         Returns a boolean representing whether or not the two Specifier-like
///         objects are equal.
///
///         :param other: The other object to check against.
///         """
///
///     @property
///     @abc.abstractmethod
///     def prereleases(self) -> Optional[bool]:
///         """Whether or not pre-releases as a whole are allowed.
///
///         This can be set to either ``True`` or ``False`` to explicitly enable or disable
///         prereleases or it can be set to ``None`` (the default) to use default semantics.
///         """
///
///     @prereleases.setter
///     def prereleases(self, value: bool) -> None:
///         """Setter for :attr:`prereleases`.
///
///         :param value: The value to set.
///         """
///
///     @abc.abstractmethod
///     def contains(self, item: str, prereleases: Optional[bool] = None) -> bool:
///         """
///         Determines if the given item is contained within this specifier.
///         """
///
///     @abc.abstractmethod
///     def filter(
///         self, iterable: Iterable[UnparsedVersionVar], prereleases: Optional[bool] = None
///     ) -> Iterator[UnparsedVersionVar]:
///         """
///         Takes an iterable of items and filters them so that only items which
///         are contained within this specifier are allowed in it.
///         """
///
///
/// class Specifier(BaseSpecifier):
///     """This class abstracts handling of version specifiers.
///
///     .. tip::
///
///         It is generally not required to instantiate this manually. You should instead
///         prefer to work with :class:`SpecifierSet` instead, which can parse
///         comma-separated version specifiers (which is what package metadata contains).
///     """
///
///     _operator_regex_str = r"""
///         (?P<operator>(~=|==|!=|<=|>=|<|>|===))
///         """
///     _version_regex_str = r"""
///         (?P<version>
///             (?:
///                 # The identity operators allow for an escape hatch that will
///                 # do an exact string match of the version you wish to install.
///                 # This will not be parsed by PEP 440 and we cannot determine
///                 # any semantic meaning from it. This operator is discouraged
///                 # but included entirely as an escape hatch.
///                 (?<====)  # Only match for the identity operator
///                 \s*
///                 [^\s;)]*  # The arbitrary version can be just about anything,
///                           # we match everything except for whitespace, a
///                           # semi-colon for marker support, and a closing paren
///                           # since versions can be enclosed in them.
///             )
///             |
///             (?:
///                 # The (non)equality operators allow for wild card and local
///                 # versions to be specified so we have to define these two
///                 # operators separately to enable that.
///                 (?<===|!=)            # Only match for equals and not equals
///
///                 \s*
///                 v?
///                 (?:[0-9]+!)?          # epoch
///                 [0-9]+(?:\.[0-9]+)*   # release
///
///                 # You cannot use a wild card and a pre-release, post-release, a dev or
///                 # local version together so group them with a | and make them optional.
///                 (?:
///                     \.\*  # Wild card syntax of .*
///                     |
///                     (?:                                  # pre release
///                         [-_\.]?
///                         (alpha|beta|preview|pre|a|b|c|rc)
///                         [-_\.]?
///                         [0-9]*
///                     )?
///                     (?:                                  # post release
///                         (?:-[0-9]+)|(?:[-_\.]?(post|rev|r)[-_\.]?[0-9]*)
///                     )?
///                     (?:[-_\.]?dev[-_\.]?[0-9]*)?         # dev release
///                     (?:\+[a-z0-9]+(?:[-_\.][a-z0-9]+)*)? # local
///                 )?
///             )
///             |
///             (?:
///                 # The compatible operator requires at least two digits in the
///                 # release segment.
///                 (?<=~=)               # Only match for the compatible operator
///
///                 \s*
///                 v?
///                 (?:[0-9]+!)?          # epoch
///                 [0-9]+(?:\.[0-9]+)+   # release  (We have a + instead of a *)
///                 (?:                   # pre release
///                     [-_\.]?
///                     (alpha|beta|preview|pre|a|b|c|rc)
///                     [-_\.]?
///                     [0-9]*
///                 )?
///                 (?:                                   # post release
///                     (?:-[0-9]+)|(?:[-_\.]?(post|rev|r)[-_\.]?[0-9]*)
///                 )?
///                 (?:[-_\.]?dev[-_\.]?[0-9]*)?          # dev release
///             )
///             |
///             (?:
///                 # All other operators only allow a sub set of what the
///                 # (non)equality operators do. Specifically they do not allow
///                 # local versions to be specified nor do they allow the prefix
///                 # matching wild cards.
///                 (?<!==|!=|~=)         # We have special cases for these
///                                       # operators so we want to make sure they
///                                       # don't match here.
///
///                 \s*
///                 v?
///                 (?:[0-9]+!)?          # epoch
///                 [0-9]+(?:\.[0-9]+)*   # release
///                 (?:                   # pre release
///                     [-_\.]?
///                     (alpha|beta|preview|pre|a|b|c|rc)
///                     [-_\.]?
///                     [0-9]*
///                 )?
///                 (?:                                   # post release
///                     (?:-[0-9]+)|(?:[-_\.]?(post|rev|r)[-_\.]?[0-9]*)
///                 )?
///                 (?:[-_\.]?dev[-_\.]?[0-9]*)?          # dev release
///             )
///         )
///         """
///
///     _regex = re.compile(
///         r"^\s*" + _operator_regex_str + _version_regex_str + r"\s*$",
///         re.VERBOSE | re.IGNORECASE,
///     )
///
///     _operators = {
///         "~=": "compatible",
///         "==": "equal",
///         "!=": "not_equal",
///         "<=": "less_than_equal",
///         ">=": "greater_than_equal",
///         "<": "less_than",
///         ">": "greater_than",
///         "===": "arbitrary",
///     }
///
///     def __init__(self, spec: str = "", prereleases: Optional[bool] = None) -> None:
///         """Initialize a Specifier instance.
///
///         :param spec:
///             The string representation of a specifier which will be parsed and
///             normalized before use.
///         :param prereleases:
///             This tells the specifier if it should accept prerelease versions if
///             applicable or not. The default of ``None`` will autodetect it from the
///             given specifiers.
///         :raises InvalidSpecifier:
///             If the given specifier is invalid (i.e. bad syntax).
///         """
///         match = self._regex.search(spec)
///         if not match:
///             raise InvalidSpecifier(f"Invalid specifier: '{spec}'")
///
///         self._spec: Tuple[str, str] = (
///             match.group("operator").strip(),
///             match.group("version").strip(),
///         )
///
///         # Store whether or not this Specifier should accept prereleases
///         self._prereleases = prereleases
///
///     # https://github.com/python/mypy/pull/13475#pullrequestreview-1079784515
///     @property  # type: ignore[override]
///     def prereleases(self) -> bool:
///         # If there is an explicit prereleases set for this, then we'll just
///         # blindly use that.
///         if self._prereleases is not None:
///             return self._prereleases
///
///         # Look at all of our specifiers and determine if they are inclusive
///         # operators, and if they are if they are including an explicit
///         # prerelease.
///         operator, version = self._spec
///         if operator in ["==", ">=", "<=", "~=", "==="]:
///             # The == specifier can include a trailing .*, if it does we
///             # want to remove before parsing.
///             if operator == "==" and version.endswith(".*"):
///                 version = version[:-2]
///
///             # Parse the version, and if it is a pre-release than this
///             # specifier allows pre-releases.
///             if Version(version).is_prerelease:
///                 return True
///
///         return False
///
///     @prereleases.setter
///     def prereleases(self, value: bool) -> None:
///         self._prereleases = value
///
///     @property
///     def operator(self) -> str:
///         """The operator of this specifier.
///
///         >>> Specifier("==1.2.3").operator
///         '=='
///         """
///         return self._spec[0]
///
///     @property
///     def version(self) -> str:
///         """The version of this specifier.
///
///         >>> Specifier("==1.2.3").version
///         '1.2.3'
///         """
///         return self._spec[1]
///
///     def __repr__(self) -> str:
///         """A representation of the Specifier that shows all internal state.
///
///         >>> Specifier('>=1.0.0')
///         <Specifier('>=1.0.0')>
///         >>> Specifier('>=1.0.0', prereleases=False)
///         <Specifier('>=1.0.0', prereleases=False)>
///         >>> Specifier('>=1.0.0', prereleases=True)
///         <Specifier('>=1.0.0', prereleases=True)>
///         """
///         pre = (
///             f", prereleases={self.prereleases!r}"
///             if self._prereleases is not None
///             else ""
///         )
///
///         return f"<{self.__class__.__name__}({str(self)!r}{pre})>"
///
///     def __str__(self) -> str:
///         """A string representation of the Specifier that can be round-tripped.
///
///         >>> str(Specifier('>=1.0.0'))
///         '>=1.0.0'
///         >>> str(Specifier('>=1.0.0', prereleases=False))
///         '>=1.0.0'
///         """
///         return "{}{}".format(*self._spec)
///
///     @property
///     def _canonical_spec(self) -> Tuple[str, str]:
///         canonical_version = canonicalize_version(
///             self._spec[1],
///             strip_trailing_zero=(self._spec[0] != "~="),
///         )
///         return self._spec[0], canonical_version
///
///     def __hash__(self) -> int:
///         return hash(self._canonical_spec)
///
///     def __eq__(self, other: object) -> bool:
///         """Whether or not the two Specifier-like objects are equal.
///
///         :param other: The other object to check against.
///
///         The value of :attr:`prereleases` is ignored.
///
///         >>> Specifier("==1.2.3") == Specifier("== 1.2.3.0")
///         True
///         >>> (Specifier("==1.2.3", prereleases=False) ==
///         ...  Specifier("==1.2.3", prereleases=True))
///         True
///         >>> Specifier("==1.2.3") == "==1.2.3"
///         True
///         >>> Specifier("==1.2.3") == Specifier("==1.2.4")
///         False
///         >>> Specifier("==1.2.3") == Specifier("~=1.2.3")
///         False
///         """
///         if isinstance(other, str):
///             try:
///                 other = self.__class__(str(other))
///             except InvalidSpecifier:
///                 return NotImplemented
///         elif not isinstance(other, self.__class__):
///             return NotImplemented
///
///         return self._canonical_spec == other._canonical_spec
///
///     def _get_operator(self, op: str) -> CallableOperator:
///         operator_callable: CallableOperator = getattr(
///             self, f"_compare_{self._operators[op]}"
///         )
///         return operator_callable
///
///     def _compare_compatible(self, prospective: Version, spec: str) -> bool:
///
///         # Compatible releases have an equivalent combination of >= and ==. That
///         # is that ~=2.2 is equivalent to >=2.2,==2.*. This allows us to
///         # implement this in terms of the other specifiers instead of
///         # implementing it ourselves. The only thing we need to do is construct
///         # the other specifiers.
///
///         # We want everything but the last item in the version, but we want to
///         # ignore suffix segments.
///         prefix = ".".join(
///             list(itertools.takewhile(_is_not_suffix, _version_split(spec)))[:-1]
///         )
///
///         # Add the prefix notation to the end of our string
///         prefix += ".*"
///
///         return self._get_operator(">=")(prospective, spec) and self._get_operator("==")(
///             prospective, prefix
///         )
///
///     def _compare_equal(self, prospective: Version, spec: str) -> bool:
///
///         # We need special logic to handle prefix matching
///         if spec.endswith(".*"):
///             # In the case of prefix matching we want to ignore local segment.
///             normalized_prospective = canonicalize_version(
///                 prospective.public, strip_trailing_zero=False
///             )
///             # Get the normalized version string ignoring the trailing .*
///             normalized_spec = canonicalize_version(spec[:-2], strip_trailing_zero=False)
///             # Split the spec out by dots, and pretend that there is an implicit
///             # dot in between a release segment and a pre-release segment.
///             split_spec = _version_split(normalized_spec)
///
///             # Split the prospective version out by dots, and pretend that there
///             # is an implicit dot in between a release segment and a pre-release
///             # segment.
///             split_prospective = _version_split(normalized_prospective)
///
///             # 0-pad the prospective version before shortening it to get the correct
///             # shortened version.
///             padded_prospective, _ = _pad_version(split_prospective, split_spec)
///
///             # Shorten the prospective version to be the same length as the spec
///             # so that we can determine if the specifier is a prefix of the
///             # prospective version or not.
///             shortened_prospective = padded_prospective[: len(split_spec)]
///
///             return shortened_prospective == split_spec
///         else:
///             # Convert our spec string into a Version
///             spec_version = Version(spec)
///
///             # If the specifier does not have a local segment, then we want to
///             # act as if the prospective version also does not have a local
///             # segment.
///             if not spec_version.local:
///                 prospective = Version(prospective.public)
///
///             return prospective == spec_version
///
///     def _compare_not_equal(self, prospective: Version, spec: str) -> bool:
///         return not self._compare_equal(prospective, spec)
///
///     def _compare_less_than_equal(self, prospective: Version, spec: str) -> bool:
///
///         # NB: Local version identifiers are NOT permitted in the version
///         # specifier, so local version labels can be universally removed from
///         # the prospective version.
///         return Version(prospective.public) <= Version(spec)
///
///     def _compare_greater_than_equal(self, prospective: Version, spec: str) -> bool:
///
///         # NB: Local version identifiers are NOT permitted in the version
///         # specifier, so local version labels can be universally removed from
///         # the prospective version.
///         return Version(prospective.public) >= Version(spec)
///
///     def _compare_less_than(self, prospective: Version, spec_str: str) -> bool:
///
///         # Convert our spec to a Version instance, since we'll want to work with
///         # it as a version.
///         spec = Version(spec_str)
///
///         # Check to see if the prospective version is less than the spec
///         # version. If it's not we can short circuit and just return False now
///         # instead of doing extra unneeded work.
///         if not prospective < spec:
///             return False
///
///         # This special case is here so that, unless the specifier itself
///         # includes is a pre-release version, that we do not accept pre-release
///         # versions for the version mentioned in the specifier (e.g. <3.1 should
///         # not match 3.1.dev0, but should match 3.0.dev0).
///         if not spec.is_prerelease and prospective.is_prerelease:
///             if Version(prospective.base_version) == Version(spec.base_version):
///                 return False
///
///         # If we've gotten to here, it means that prospective version is both
///         # less than the spec version *and* it's not a pre-release of the same
///         # version in the spec.
///         return True
///
///     def _compare_greater_than(self, prospective: Version, spec_str: str) -> bool:
///
///         # Convert our spec to a Version instance, since we'll want to work with
///         # it as a version.
///         spec = Version(spec_str)
///
///         # Check to see if the prospective version is greater than the spec
///         # version. If it's not we can short circuit and just return False now
///         # instead of doing extra unneeded work.
///         if not prospective > spec:
///             return False
///
///         # This special case is here so that, unless the specifier itself
///         # includes is a post-release version, that we do not accept
///         # post-release versions for the version mentioned in the specifier
///         # (e.g. >3.1 should not match 3.0.post0, but should match 3.2.post0).
///         if not spec.is_postrelease and prospective.is_postrelease:
///             if Version(prospective.base_version) == Version(spec.base_version):
///                 return False
///
///         # Ensure that we do not allow a local version of the version mentioned
///         # in the specifier, which is technically greater than, to match.
///         if prospective.local is not None:
///             if Version(prospective.base_version) == Version(spec.base_version):
///                 return False
///
///         # If we've gotten to here, it means that prospective version is both
///         # greater than the spec version *and* it's not a pre-release of the
///         # same version in the spec.
///         return True
///
///     def _compare_arbitrary(self, prospective: Version, spec: str) -> bool:
///         return str(prospective).lower() == str(spec).lower()
///
///     def __contains__(self, item: Union[str, Version]) -> bool:
///         """Return whether or not the item is contained in this specifier.
///
///         :param item: The item to check for.
///
///         This is used for the ``in`` operator and behaves the same as
///         :meth:`contains` with no ``prereleases`` argument passed.
///
///         >>> "1.2.3" in Specifier(">=1.2.3")
///         True
///         >>> Version("1.2.3") in Specifier(">=1.2.3")
///         True
///         >>> "1.0.0" in Specifier(">=1.2.3")
///         False
///         >>> "1.3.0a1" in Specifier(">=1.2.3")
///         False
///         >>> "1.3.0a1" in Specifier(">=1.2.3", prereleases=True)
///         True
///         """
///         return self.contains(item)
///
///     def contains(
///         self, item: UnparsedVersion, prereleases: Optional[bool] = None
///     ) -> bool:
///         """Return whether or not the item is contained in this specifier.
///
///         :param item:
///             The item to check for, which can be a version string or a
///             :class:`Version` instance.
///         :param prereleases:
///             Whether or not to match prereleases with this Specifier. If set to
///             ``None`` (the default), it uses :attr:`prereleases` to determine
///             whether or not prereleases are allowed.
///
///         >>> Specifier(">=1.2.3").contains("1.2.3")
///         True
///         >>> Specifier(">=1.2.3").contains(Version("1.2.3"))
///         True
///         >>> Specifier(">=1.2.3").contains("1.0.0")
///         False
///         >>> Specifier(">=1.2.3").contains("1.3.0a1")
///         False
///         >>> Specifier(">=1.2.3", prereleases=True).contains("1.3.0a1")
///         True
///         >>> Specifier(">=1.2.3").contains("1.3.0a1", prereleases=True)
///         True
///         """
///
///         # Determine if prereleases are to be allowed or not.
///         if prereleases is None:
///             prereleases = self.prereleases
///
///         # Normalize item to a Version, this allows us to have a shortcut for
///         # "2.0" in Specifier(">=2")
///         normalized_item = _coerce_version(item)
///
///         # Determine if we should be supporting prereleases in this specifier
///         # or not, if we do not support prereleases than we can short circuit
///         # logic if this version is a prereleases.
///         if normalized_item.is_prerelease and not prereleases:
///             return False
///
///         # Actually do the comparison to determine if this item is contained
///         # within this Specifier or not.
///         operator_callable: CallableOperator = self._get_operator(self.operator)
///         return operator_callable(normalized_item, self.version)
///
///     def filter(
///         self, iterable: Iterable[UnparsedVersionVar], prereleases: Optional[bool] = None
///     ) -> Iterator[UnparsedVersionVar]:
///         """Filter items in the given iterable, that match the specifier.
///
///         :param iterable:
///             An iterable that can contain version strings and :class:`Version` instances.
///             The items in the iterable will be filtered according to the specifier.
///         :param prereleases:
///             Whether or not to allow prereleases in the returned iterator. If set to
///             ``None`` (the default), it will be intelligently decide whether to allow
///             prereleases or not (based on the :attr:`prereleases` attribute, and
///             whether the only versions matching are prereleases).
///
///         This method is smarter than just ``filter(Specifier().contains, [...])``
///         because it implements the rule from :pep:`440` that a prerelease item
///         SHOULD be accepted if no other versions match the given specifier.
///
///         >>> list(Specifier(">=1.2.3").filter(["1.2", "1.3", "1.5a1"]))
///         ['1.3']
///         >>> list(Specifier(">=1.2.3").filter(["1.2", "1.2.3", "1.3", Version("1.4")]))
///         ['1.2.3', '1.3', <Version('1.4')>]
///         >>> list(Specifier(">=1.2.3").filter(["1.2", "1.5a1"]))
///         ['1.5a1']
///         >>> list(Specifier(">=1.2.3").filter(["1.3", "1.5a1"], prereleases=True))
///         ['1.3', '1.5a1']
///         >>> list(Specifier(">=1.2.3", prereleases=True).filter(["1.3", "1.5a1"]))
///         ['1.3', '1.5a1']
///         """
///
///         yielded = False
///         found_prereleases = []
///
///         kw = {"prereleases": prereleases if prereleases is not None else True}
///
///         # Attempt to iterate over all the values in the iterable and if any of
///         # them match, yield them.
///         for version in iterable:
///             parsed_version = _coerce_version(version)
///
///             if self.contains(parsed_version, **kw):
///                 # If our version is a prerelease, and we were not set to allow
///                 # prereleases, then we'll store it for later in case nothing
///                 # else matches this specifier.
///                 if parsed_version.is_prerelease and not (
///                     prereleases or self.prereleases
///                 ):
///                     found_prereleases.append(version)
///                 # Either this is not a prerelease, or we should have been
///                 # accepting prereleases from the beginning.
///                 else:
///                     yielded = True
///                     yield version
///
///         # Now that we've iterated over everything, determine if we've yielded
///         # any values, and if we have not and we have any prereleases stored up
///         # then we will go ahead and yield the prereleases.
///         if not yielded and found_prereleases:
///             for version in found_prereleases:
///                 yield version
///
///
/// _prefix_regex = re.compile(r"^([0-9]+)((?:a|b|c|rc)[0-9]+)$")
///
///
/// def _version_split(version: str) -> List[str]:
///     result: List[str] = []
///     for item in version.split("."):
///         match = _prefix_regex.search(item)
///         if match:
///             result.extend(match.groups())
///         else:
///             result.append(item)
///     return result
///
///
/// def _is_not_suffix(segment: str) -> bool:
///     return not any(
///         segment.startswith(prefix) for prefix in ("dev", "a", "b", "rc", "post")
///     )
///
///
/// def _pad_version(left: List[str], right: List[str]) -> Tuple[List[str], List[str]]:
///     left_split, right_split = [], []
///
///     # Get the release segment of our versions
///     left_split.append(list(itertools.takewhile(lambda x: x.isdigit(), left)))
///     right_split.append(list(itertools.takewhile(lambda x: x.isdigit(), right)))
///
///     # Get the rest of our versions
///     left_split.append(left[len(left_split[0]) :])
///     right_split.append(right[len(right_split[0]) :])
///
///     # Insert our padding
///     left_split.insert(1, ["0"] * max(0, len(right_split[0]) - len(left_split[0])))
///     right_split.insert(1, ["0"] * max(0, len(left_split[0]) - len(right_split[0])))
///
///     return (list(itertools.chain(*left_split)), list(itertools.chain(*right_split)))
///
///
/// class SpecifierSet(BaseSpecifier):
///     """This class abstracts handling of a set of version specifiers.
///
///     It can be passed a single specifier (``>=3.0``), a comma-separated list of
///     specifiers (``>=3.0,!=3.1``), or no specifier at all.
///     """
///
///     def __init__(
///         self, specifiers: str = "", prereleases: Optional[bool] = None
///     ) -> None:
///         """Initialize a SpecifierSet instance.
///
///         :param specifiers:
///             The string representation of a specifier or a comma-separated list of
///             specifiers which will be parsed and normalized before use.
///         :param prereleases:
///             This tells the SpecifierSet if it should accept prerelease versions if
///             applicable or not. The default of ``None`` will autodetect it from the
///             given specifiers.
///
///         :raises InvalidSpecifier:
///             If the given ``specifiers`` are not parseable than this exception will be
///             raised.
///         """
///
///         # Split on `,` to break each individual specifier into it's own item, and
///         # strip each item to remove leading/trailing whitespace.
///         split_specifiers = [s.strip() for s in specifiers.split(",") if s.strip()]
///
///         # Parsed each individual specifier, attempting first to make it a
///         # Specifier.
///         parsed: Set[Specifier] = set()
///         for specifier in split_specifiers:
///             parsed.add(Specifier(specifier))
///
///         # Turn our parsed specifiers into a frozen set and save them for later.
///         self._specs = frozenset(parsed)
///
///         # Store our prereleases value so we can use it later to determine if
///         # we accept prereleases or not.
///         self._prereleases = prereleases
///
///     @property
///     def prereleases(self) -> Optional[bool]:
///         # If we have been given an explicit prerelease modifier, then we'll
///         # pass that through here.
///         if self._prereleases is not None:
///             return self._prereleases
///
///         # If we don't have any specifiers, and we don't have a forced value,
///         # then we'll just return None since we don't know if this should have
///         # pre-releases or not.
///         if not self._specs:
///             return None
///
///         # Otherwise we'll see if any of the given specifiers accept
///         # prereleases, if any of them do we'll return True, otherwise False.
///         return any(s.prereleases for s in self._specs)
///
///     @prereleases.setter
///     def prereleases(self, value: bool) -> None:
///         self._prereleases = value
///
///     def __repr__(self) -> str:
///         """A representation of the specifier set that shows all internal state.
///
///         Note that the ordering of the individual specifiers within the set may not
///         match the input string.
///
///         >>> SpecifierSet('>=1.0.0,!=2.0.0')
///         <SpecifierSet('!=2.0.0,>=1.0.0')>
///         >>> SpecifierSet('>=1.0.0,!=2.0.0', prereleases=False)
///         <SpecifierSet('!=2.0.0,>=1.0.0', prereleases=False)>
///         >>> SpecifierSet('>=1.0.0,!=2.0.0', prereleases=True)
///         <SpecifierSet('!=2.0.0,>=1.0.0', prereleases=True)>
///         """
///         pre = (
///             f", prereleases={self.prereleases!r}"
///             if self._prereleases is not None
///             else ""
///         )
///
///         return f"<SpecifierSet({str(self)!r}{pre})>"
///
///     def __str__(self) -> str:
///         """A string representation of the specifier set that can be round-tripped.
///
///         Note that the ordering of the individual specifiers within the set may not
///         match the input string.
///
///         >>> str(SpecifierSet(">=1.0.0,!=1.0.1"))
///         '!=1.0.1,>=1.0.0'
///         >>> str(SpecifierSet(">=1.0.0,!=1.0.1", prereleases=False))
///         '!=1.0.1,>=1.0.0'
///         """
///         return ",".join(sorted(str(s) for s in self._specs))
///
///     def __hash__(self) -> int:
///         return hash(self._specs)
///
///     def __and__(self, other: Union["SpecifierSet", str]) -> "SpecifierSet":
///         """Return a SpecifierSet which is a combination of the two sets.
///
///         :param other: The other object to combine with.
///
///         >>> SpecifierSet(">=1.0.0,!=1.0.1") & '<=2.0.0,!=2.0.1'
///         <SpecifierSet('!=1.0.1,!=2.0.1,<=2.0.0,>=1.0.0')>
///         >>> SpecifierSet(">=1.0.0,!=1.0.1") & SpecifierSet('<=2.0.0,!=2.0.1')
///         <SpecifierSet('!=1.0.1,!=2.0.1,<=2.0.0,>=1.0.0')>
///         """
///         if isinstance(other, str):
///             other = SpecifierSet(other)
///         elif not isinstance(other, SpecifierSet):
///             return NotImplemented
///
///         specifier = SpecifierSet()
///         specifier._specs = frozenset(self._specs | other._specs)
///
///         if self._prereleases is None and other._prereleases is not None:
///             specifier._prereleases = other._prereleases
///         elif self._prereleases is not None and other._prereleases is None:
///             specifier._prereleases = self._prereleases
///         elif self._prereleases == other._prereleases:
///             specifier._prereleases = self._prereleases
///         else:
///             raise ValueError(
///                 "Cannot combine SpecifierSets with True and False prerelease "
///                 "overrides."
///             )
///
///         return specifier
///
///     def __eq__(self, other: object) -> bool:
///         """Whether or not the two SpecifierSet-like objects are equal.
///
///         :param other: The other object to check against.
///
///         The value of :attr:`prereleases` is ignored.
///
///         >>> SpecifierSet(">=1.0.0,!=1.0.1") == SpecifierSet(">=1.0.0,!=1.0.1")
///         True
///         >>> (SpecifierSet(">=1.0.0,!=1.0.1", prereleases=False) ==
///         ...  SpecifierSet(">=1.0.0,!=1.0.1", prereleases=True))
///         True
///         >>> SpecifierSet(">=1.0.0,!=1.0.1") == ">=1.0.0,!=1.0.1"
///         True
///         >>> SpecifierSet(">=1.0.0,!=1.0.1") == SpecifierSet(">=1.0.0")
///         False
///         >>> SpecifierSet(">=1.0.0,!=1.0.1") == SpecifierSet(">=1.0.0,!=1.0.2")
///         False
///         """
///         if isinstance(other, (str, Specifier)):
///             other = SpecifierSet(str(other))
///         elif not isinstance(other, SpecifierSet):
///             return NotImplemented
///
///         return self._specs == other._specs
///
///     def __len__(self) -> int:
///         """Returns the number of specifiers in this specifier set."""
///         return len(self._specs)
///
///     def __iter__(self) -> Iterator[Specifier]:
///         """
///         Returns an iterator over all the underlying :class:`Specifier` instances
///         in this specifier set.
///
///         >>> sorted(SpecifierSet(">=1.0.0,!=1.0.1"), key=str)
///         [<Specifier('!=1.0.1')>, <Specifier('>=1.0.0')>]
///         """
///         return iter(self._specs)
///
///     def __contains__(self, item: UnparsedVersion) -> bool:
///         """Return whether or not the item is contained in this specifier.
///
///         :param item: The item to check for.
///
///         This is used for the ``in`` operator and behaves the same as
///         :meth:`contains` with no ``prereleases`` argument passed.
///
///         >>> "1.2.3" in SpecifierSet(">=1.0.0,!=1.0.1")
///         True
///         >>> Version("1.2.3") in SpecifierSet(">=1.0.0,!=1.0.1")
///         True
///         >>> "1.0.1" in SpecifierSet(">=1.0.0,!=1.0.1")
///         False
///         >>> "1.3.0a1" in SpecifierSet(">=1.0.0,!=1.0.1")
///         False
///         >>> "1.3.0a1" in SpecifierSet(">=1.0.0,!=1.0.1", prereleases=True)
///         True
///         """
///         return self.contains(item)
///
///     def contains(
///         self,
///         item: UnparsedVersion,
///         prereleases: Optional[bool] = None,
///         installed: Optional[bool] = None,
///     ) -> bool:
///         """Return whether or not the item is contained in this SpecifierSet.
///
///         :param item:
///             The item to check for, which can be a version string or a
///             :class:`Version` instance.
///         :param prereleases:
///             Whether or not to match prereleases with this SpecifierSet. If set to
///             ``None`` (the default), it uses :attr:`prereleases` to determine
///             whether or not prereleases are allowed.
///
///         >>> SpecifierSet(">=1.0.0,!=1.0.1").contains("1.2.3")
///         True
///         >>> SpecifierSet(">=1.0.0,!=1.0.1").contains(Version("1.2.3"))
///         True
///         >>> SpecifierSet(">=1.0.0,!=1.0.1").contains("1.0.1")
///         False
///         >>> SpecifierSet(">=1.0.0,!=1.0.1").contains("1.3.0a1")
///         False
///         >>> SpecifierSet(">=1.0.0,!=1.0.1", prereleases=True).contains("1.3.0a1")
///         True
///         >>> SpecifierSet(">=1.0.0,!=1.0.1").contains("1.3.0a1", prereleases=True)
///         True
///         """
///         # Ensure that our item is a Version instance.
///         if not isinstance(item, Version):
///             item = Version(item)
///
///         # Determine if we're forcing a prerelease or not, if we're not forcing
///         # one for this particular filter call, then we'll use whatever the
///         # SpecifierSet thinks for whether or not we should support prereleases.
///         if prereleases is None:
///             prereleases = self.prereleases
///
///         # We can determine if we're going to allow pre-releases by looking to
///         # see if any of the underlying items supports them. If none of them do
///         # and this item is a pre-release then we do not allow it and we can
///         # short circuit that here.
///         # Note: This means that 1.0.dev1 would not be contained in something
///         #       like >=1.0.devabc however it would be in >=1.0.debabc,>0.0.dev0
///         if not prereleases and item.is_prerelease:
///             return False
///
///         if installed and item.is_prerelease:
///             item = Version(item.base_version)
///
///         # We simply dispatch to the underlying specs here to make sure that the
///         # given version is contained within all of them.
///         # Note: This use of all() here means that an empty set of specifiers
///         #       will always return True, this is an explicit design decision.
///         return all(s.contains(item, prereleases=prereleases) for s in self._specs)
///
///     def filter(
///         self, iterable: Iterable[UnparsedVersionVar], prereleases: Optional[bool] = None
///     ) -> Iterator[UnparsedVersionVar]:
///         """Filter items in the given iterable, that match the specifiers in this set.
///
///         :param iterable:
///             An iterable that can contain version strings and :class:`Version` instances.
///             The items in the iterable will be filtered according to the specifier.
///         :param prereleases:
///             Whether or not to allow prereleases in the returned iterator. If set to
///             ``None`` (the default), it will be intelligently decide whether to allow
///             prereleases or not (based on the :attr:`prereleases` attribute, and
///             whether the only versions matching are prereleases).
///
///         This method is smarter than just ``filter(SpecifierSet(...).contains, [...])``
///         because it implements the rule from :pep:`440` that a prerelease item
///         SHOULD be accepted if no other versions match the given specifier.
///
///         >>> list(SpecifierSet(">=1.2.3").filter(["1.2", "1.3", "1.5a1"]))
///         ['1.3']
///         >>> list(SpecifierSet(">=1.2.3").filter(["1.2", "1.3", Version("1.4")]))
///         ['1.3', <Version('1.4')>]
///         >>> list(SpecifierSet(">=1.2.3").filter(["1.2", "1.5a1"]))
///         []
///         >>> list(SpecifierSet(">=1.2.3").filter(["1.3", "1.5a1"], prereleases=True))
///         ['1.3', '1.5a1']
///         >>> list(SpecifierSet(">=1.2.3", prereleases=True).filter(["1.3", "1.5a1"]))
///         ['1.3', '1.5a1']
///
///         An "empty" SpecifierSet will filter items based on the presence of prerelease
///         versions in the set.
///
///         >>> list(SpecifierSet("").filter(["1.3", "1.5a1"]))
///         ['1.3']
///         >>> list(SpecifierSet("").filter(["1.5a1"]))
///         ['1.5a1']
///         >>> list(SpecifierSet("", prereleases=True).filter(["1.3", "1.5a1"]))
///         ['1.3', '1.5a1']
///         >>> list(SpecifierSet("").filter(["1.3", "1.5a1"], prereleases=True))
///         ['1.3', '1.5a1']
///         """
///         # Determine if we're forcing a prerelease or not, if we're not forcing
///         # one for this particular filter call, then we'll use whatever the
///         # SpecifierSet thinks for whether or not we should support prereleases.
///         if prereleases is None:
///             prereleases = self.prereleases
///
///         # If we have any specifiers, then we want to wrap our iterable in the
///         # filter method for each one, this will act as a logical AND amongst
///         # each specifier.
///         if self._specs:
///             for spec in self._specs:
///                 iterable = spec.filter(iterable, prereleases=bool(prereleases))
///             return iter(iterable)
///         # If we do not have any specifiers, then we need to have a rough filter
///         # which will filter out any pre-releases, unless there are no final
///         # releases.
///         else:
///             filtered: List[UnparsedVersionVar] = []
///             found_prereleases: List[UnparsedVersionVar] = []
///
///             for item in iterable:
///                 parsed_version = _coerce_version(item)
///
///                 # Store any item which is a pre-release for later unless we've
///                 # already found a final version or we are accepting prereleases
///                 if parsed_version.is_prerelease and not prereleases:
///                     if not filtered:
///                         found_prereleases.append(item)
///                 else:
///                     filtered.append(item)
///
///             # If we've found no items except for pre-releases, then we'll go
///             # ahead and use the pre-releases
///             if not filtered and found_prereleases and prereleases is None:
///                 return iter(found_prereleases)
///
///             return iter(filtered)
/// ```
final class specifiers extends PythonModule {
  specifiers.from(super.pythonModule) : super.from();

  static specifiers import() => PythonFfiDart.instance.importModule(
        "packaging.specifiers",
        specifiers.from,
      );

  /// ## UnparsedVersionVar (getter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.specifiers import Specifier, SpecifierSet, InvalidSpecifier
  ///     from packaging.version import Version
  Object? get UnparsedVersionVar => getAttribute("UnparsedVersionVar");

  /// ## UnparsedVersionVar (setter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.specifiers import Specifier, SpecifierSet, InvalidSpecifier
  ///     from packaging.version import Version
  set UnparsedVersionVar(Object? UnparsedVersionVar) =>
      setAttribute("UnparsedVersionVar", UnparsedVersionVar);
}

/// ## itertools
final class itertools extends PythonModule {
  itertools.from(super.pythonModule) : super.from();

  static itertools import() => PythonFfiDart.instance.importModule(
        "itertools",
        itertools.from,
      );
}

/// ## tags
///
/// ### python source
/// ```py
/// # This file is dual licensed under the terms of the Apache License, Version
/// # 2.0, and the BSD License. See the LICENSE file in the root of this repository
/// # for complete details.
///
/// import logging
/// import platform
/// import subprocess
/// import sys
/// import sysconfig
/// from importlib.machinery import EXTENSION_SUFFIXES
/// from typing import (
///     Dict,
///     FrozenSet,
///     Iterable,
///     Iterator,
///     List,
///     Optional,
///     Sequence,
///     Tuple,
///     Union,
///     cast,
/// )
///
/// from . import _manylinux, _musllinux
///
/// logger = logging.getLogger(__name__)
///
/// PythonVersion = Sequence[int]
/// MacVersion = Tuple[int, int]
///
/// INTERPRETER_SHORT_NAMES: Dict[str, str] = {
///     "python": "py",  # Generic.
///     "cpython": "cp",
///     "pypy": "pp",
///     "ironpython": "ip",
///     "jython": "jy",
/// }
///
///
/// _32_BIT_INTERPRETER = sys.maxsize <= 2**32
///
///
/// class Tag:
///     """
///     A representation of the tag triple for a wheel.
///
///     Instances are considered immutable and thus are hashable. Equality checking
///     is also supported.
///     """
///
///     __slots__ = ["_interpreter", "_abi", "_platform", "_hash"]
///
///     def __init__(self, interpreter: str, abi: str, platform: str) -> None:
///         self._interpreter = interpreter.lower()
///         self._abi = abi.lower()
///         self._platform = platform.lower()
///         # The __hash__ of every single element in a Set[Tag] will be evaluated each time
///         # that a set calls its `.disjoint()` method, which may be called hundreds of
///         # times when scanning a page of links for packages with tags matching that
///         # Set[Tag]. Pre-computing the value here produces significant speedups for
///         # downstream consumers.
///         self._hash = hash((self._interpreter, self._abi, self._platform))
///
///     @property
///     def interpreter(self) -> str:
///         return self._interpreter
///
///     @property
///     def abi(self) -> str:
///         return self._abi
///
///     @property
///     def platform(self) -> str:
///         return self._platform
///
///     def __eq__(self, other: object) -> bool:
///         if not isinstance(other, Tag):
///             return NotImplemented
///
///         return (
///             (self._hash == other._hash)  # Short-circuit ASAP for perf reasons.
///             and (self._platform == other._platform)
///             and (self._abi == other._abi)
///             and (self._interpreter == other._interpreter)
///         )
///
///     def __hash__(self) -> int:
///         return self._hash
///
///     def __str__(self) -> str:
///         return f"{self._interpreter}-{self._abi}-{self._platform}"
///
///     def __repr__(self) -> str:
///         return f"<{self} @ {id(self)}>"
///
///
/// def parse_tag(tag: str) -> FrozenSet[Tag]:
///     """
///     Parses the provided tag (e.g. `py3-none-any`) into a frozenset of Tag instances.
///
///     Returning a set is required due to the possibility that the tag is a
///     compressed tag set.
///     """
///     tags = set()
///     interpreters, abis, platforms = tag.split("-")
///     for interpreter in interpreters.split("."):
///         for abi in abis.split("."):
///             for platform_ in platforms.split("."):
///                 tags.add(Tag(interpreter, abi, platform_))
///     return frozenset(tags)
///
///
/// def _get_config_var(name: str, warn: bool = False) -> Union[int, str, None]:
///     value: Union[int, str, None] = sysconfig.get_config_var(name)
///     if value is None and warn:
///         logger.debug(
///             "Config variable '%s' is unset, Python ABI tag may be incorrect", name
///         )
///     return value
///
///
/// def _normalize_string(string: str) -> str:
///     return string.replace(".", "_").replace("-", "_").replace(" ", "_")
///
///
/// def _abi3_applies(python_version: PythonVersion) -> bool:
///     """
///     Determine if the Python version supports abi3.
///
///     PEP 384 was first implemented in Python 3.2.
///     """
///     return len(python_version) > 1 and tuple(python_version) >= (3, 2)
///
///
/// def _cpython_abis(py_version: PythonVersion, warn: bool = False) -> List[str]:
///     py_version = tuple(py_version)  # To allow for version comparison.
///     abis = []
///     version = _version_nodot(py_version[:2])
///     debug = pymalloc = ucs4 = ""
///     with_debug = _get_config_var("Py_DEBUG", warn)
///     has_refcount = hasattr(sys, "gettotalrefcount")
///     # Windows doesn't set Py_DEBUG, so checking for support of debug-compiled
///     # extension modules is the best option.
///     # https://github.com/pypa/pip/issues/3383#issuecomment-173267692
///     has_ext = "_d.pyd" in EXTENSION_SUFFIXES
///     if with_debug or (with_debug is None and (has_refcount or has_ext)):
///         debug = "d"
///     if py_version < (3, 8):
///         with_pymalloc = _get_config_var("WITH_PYMALLOC", warn)
///         if with_pymalloc or with_pymalloc is None:
///             pymalloc = "m"
///         if py_version < (3, 3):
///             unicode_size = _get_config_var("Py_UNICODE_SIZE", warn)
///             if unicode_size == 4 or (
///                 unicode_size is None and sys.maxunicode == 0x10FFFF
///             ):
///                 ucs4 = "u"
///     elif debug:
///         # Debug builds can also load "normal" extension modules.
///         # We can also assume no UCS-4 or pymalloc requirement.
///         abis.append(f"cp{version}")
///     abis.insert(
///         0,
///         "cp{version}{debug}{pymalloc}{ucs4}".format(
///             version=version, debug=debug, pymalloc=pymalloc, ucs4=ucs4
///         ),
///     )
///     return abis
///
///
/// def cpython_tags(
///     python_version: Optional[PythonVersion] = None,
///     abis: Optional[Iterable[str]] = None,
///     platforms: Optional[Iterable[str]] = None,
///     *,
///     warn: bool = False,
/// ) -> Iterator[Tag]:
///     """
///     Yields the tags for a CPython interpreter.
///
///     The tags consist of:
///     - cp<python_version>-<abi>-<platform>
///     - cp<python_version>-abi3-<platform>
///     - cp<python_version>-none-<platform>
///     - cp<less than python_version>-abi3-<platform>  # Older Python versions down to 3.2.
///
///     If python_version only specifies a major version then user-provided ABIs and
///     the 'none' ABItag will be used.
///
///     If 'abi3' or 'none' are specified in 'abis' then they will be yielded at
///     their normal position and not at the beginning.
///     """
///     if not python_version:
///         python_version = sys.version_info[:2]
///
///     interpreter = f"cp{_version_nodot(python_version[:2])}"
///
///     if abis is None:
///         if len(python_version) > 1:
///             abis = _cpython_abis(python_version, warn)
///         else:
///             abis = []
///     abis = list(abis)
///     # 'abi3' and 'none' are explicitly handled later.
///     for explicit_abi in ("abi3", "none"):
///         try:
///             abis.remove(explicit_abi)
///         except ValueError:
///             pass
///
///     platforms = list(platforms or platform_tags())
///     for abi in abis:
///         for platform_ in platforms:
///             yield Tag(interpreter, abi, platform_)
///     if _abi3_applies(python_version):
///         yield from (Tag(interpreter, "abi3", platform_) for platform_ in platforms)
///     yield from (Tag(interpreter, "none", platform_) for platform_ in platforms)
///
///     if _abi3_applies(python_version):
///         for minor_version in range(python_version[1] - 1, 1, -1):
///             for platform_ in platforms:
///                 interpreter = "cp{version}".format(
///                     version=_version_nodot((python_version[0], minor_version))
///                 )
///                 yield Tag(interpreter, "abi3", platform_)
///
///
/// def _generic_abi() -> List[str]:
///     """
///     Return the ABI tag based on EXT_SUFFIX.
///     """
///     # The following are examples of `EXT_SUFFIX`.
///     # We want to keep the parts which are related to the ABI and remove the
///     # parts which are related to the platform:
///     # - linux:   '.cpython-310-x86_64-linux-gnu.so' => cp310
///     # - mac:     '.cpython-310-darwin.so'           => cp310
///     # - win:     '.cp310-win_amd64.pyd'             => cp310
///     # - win:     '.pyd'                             => cp37 (uses _cpython_abis())
///     # - pypy:    '.pypy38-pp73-x86_64-linux-gnu.so' => pypy38_pp73
///     # - graalpy: '.graalpy-38-native-x86_64-darwin.dylib'
///     #                                               => graalpy_38_native
///
///     ext_suffix = _get_config_var("EXT_SUFFIX", warn=True)
///     if not isinstance(ext_suffix, str) or ext_suffix[0] != ".":
///         raise SystemError("invalid sysconfig.get_config_var('EXT_SUFFIX')")
///     parts = ext_suffix.split(".")
///     if len(parts) < 3:
///         # CPython3.7 and earlier uses ".pyd" on Windows.
///         return _cpython_abis(sys.version_info[:2])
///     soabi = parts[1]
///     if soabi.startswith("cpython"):
///         # non-windows
///         abi = "cp" + soabi.split("-")[1]
///     elif soabi.startswith("cp"):
///         # windows
///         abi = soabi.split("-")[0]
///     elif soabi.startswith("pypy"):
///         abi = "-".join(soabi.split("-")[:2])
///     elif soabi.startswith("graalpy"):
///         abi = "-".join(soabi.split("-")[:3])
///     elif soabi:
///         # pyston, ironpython, others?
///         abi = soabi
///     else:
///         return []
///     return [_normalize_string(abi)]
///
///
/// def generic_tags(
///     interpreter: Optional[str] = None,
///     abis: Optional[Iterable[str]] = None,
///     platforms: Optional[Iterable[str]] = None,
///     *,
///     warn: bool = False,
/// ) -> Iterator[Tag]:
///     """
///     Yields the tags for a generic interpreter.
///
///     The tags consist of:
///     - <interpreter>-<abi>-<platform>
///
///     The "none" ABI will be added if it was not explicitly provided.
///     """
///     if not interpreter:
///         interp_name = interpreter_name()
///         interp_version = interpreter_version(warn=warn)
///         interpreter = "".join([interp_name, interp_version])
///     if abis is None:
///         abis = _generic_abi()
///     else:
///         abis = list(abis)
///     platforms = list(platforms or platform_tags())
///     if "none" not in abis:
///         abis.append("none")
///     for abi in abis:
///         for platform_ in platforms:
///             yield Tag(interpreter, abi, platform_)
///
///
/// def _py_interpreter_range(py_version: PythonVersion) -> Iterator[str]:
///     """
///     Yields Python versions in descending order.
///
///     After the latest version, the major-only version will be yielded, and then
///     all previous versions of that major version.
///     """
///     if len(py_version) > 1:
///         yield f"py{_version_nodot(py_version[:2])}"
///     yield f"py{py_version[0]}"
///     if len(py_version) > 1:
///         for minor in range(py_version[1] - 1, -1, -1):
///             yield f"py{_version_nodot((py_version[0], minor))}"
///
///
/// def compatible_tags(
///     python_version: Optional[PythonVersion] = None,
///     interpreter: Optional[str] = None,
///     platforms: Optional[Iterable[str]] = None,
/// ) -> Iterator[Tag]:
///     """
///     Yields the sequence of tags that are compatible with a specific version of Python.
///
///     The tags consist of:
///     - py*-none-<platform>
///     - <interpreter>-none-any  # ... if `interpreter` is provided.
///     - py*-none-any
///     """
///     if not python_version:
///         python_version = sys.version_info[:2]
///     platforms = list(platforms or platform_tags())
///     for version in _py_interpreter_range(python_version):
///         for platform_ in platforms:
///             yield Tag(version, "none", platform_)
///     if interpreter:
///         yield Tag(interpreter, "none", "any")
///     for version in _py_interpreter_range(python_version):
///         yield Tag(version, "none", "any")
///
///
/// def _mac_arch(arch: str, is_32bit: bool = _32_BIT_INTERPRETER) -> str:
///     if not is_32bit:
///         return arch
///
///     if arch.startswith("ppc"):
///         return "ppc"
///
///     return "i386"
///
///
/// def _mac_binary_formats(version: MacVersion, cpu_arch: str) -> List[str]:
///     formats = [cpu_arch]
///     if cpu_arch == "x86_64":
///         if version < (10, 4):
///             return []
///         formats.extend(["intel", "fat64", "fat32"])
///
///     elif cpu_arch == "i386":
///         if version < (10, 4):
///             return []
///         formats.extend(["intel", "fat32", "fat"])
///
///     elif cpu_arch == "ppc64":
///         # TODO: Need to care about 32-bit PPC for ppc64 through 10.2?
///         if version > (10, 5) or version < (10, 4):
///             return []
///         formats.append("fat64")
///
///     elif cpu_arch == "ppc":
///         if version > (10, 6):
///             return []
///         formats.extend(["fat32", "fat"])
///
///     if cpu_arch in {"arm64", "x86_64"}:
///         formats.append("universal2")
///
///     if cpu_arch in {"x86_64", "i386", "ppc64", "ppc", "intel"}:
///         formats.append("universal")
///
///     return formats
///
///
/// def mac_platforms(
///     version: Optional[MacVersion] = None, arch: Optional[str] = None
/// ) -> Iterator[str]:
///     """
///     Yields the platform tags for a macOS system.
///
///     The `version` parameter is a two-item tuple specifying the macOS version to
///     generate platform tags for. The `arch` parameter is the CPU architecture to
///     generate platform tags for. Both parameters default to the appropriate value
///     for the current system.
///     """
///     version_str, _, cpu_arch = platform.mac_ver()
///     if version is None:
///         version = cast("MacVersion", tuple(map(int, version_str.split(".")[:2])))
///         if version == (10, 16):
///             # When built against an older macOS SDK, Python will report macOS 10.16
///             # instead of the real version.
///             version_str = subprocess.run(
///                 [
///                     sys.executable,
///                     "-sS",
///                     "-c",
///                     "import platform; print(platform.mac_ver()[0])",
///                 ],
///                 check=True,
///                 env={"SYSTEM_VERSION_COMPAT": "0"},
///                 stdout=subprocess.PIPE,
///                 universal_newlines=True,
///             ).stdout
///             version = cast("MacVersion", tuple(map(int, version_str.split(".")[:2])))
///     else:
///         version = version
///     if arch is None:
///         arch = _mac_arch(cpu_arch)
///     else:
///         arch = arch
///
///     if (10, 0) <= version and version < (11, 0):
///         # Prior to Mac OS 11, each yearly release of Mac OS bumped the
///         # "minor" version number.  The major version was always 10.
///         for minor_version in range(version[1], -1, -1):
///             compat_version = 10, minor_version
///             binary_formats = _mac_binary_formats(compat_version, arch)
///             for binary_format in binary_formats:
///                 yield "macosx_{major}_{minor}_{binary_format}".format(
///                     major=10, minor=minor_version, binary_format=binary_format
///                 )
///
///     if version >= (11, 0):
///         # Starting with Mac OS 11, each yearly release bumps the major version
///         # number.   The minor versions are now the midyear updates.
///         for major_version in range(version[0], 10, -1):
///             compat_version = major_version, 0
///             binary_formats = _mac_binary_formats(compat_version, arch)
///             for binary_format in binary_formats:
///                 yield "macosx_{major}_{minor}_{binary_format}".format(
///                     major=major_version, minor=0, binary_format=binary_format
///                 )
///
///     if version >= (11, 0):
///         # Mac OS 11 on x86_64 is compatible with binaries from previous releases.
///         # Arm64 support was introduced in 11.0, so no Arm binaries from previous
///         # releases exist.
///         #
///         # However, the "universal2" binary format can have a
///         # macOS version earlier than 11.0 when the x86_64 part of the binary supports
///         # that version of macOS.
///         if arch == "x86_64":
///             for minor_version in range(16, 3, -1):
///                 compat_version = 10, minor_version
///                 binary_formats = _mac_binary_formats(compat_version, arch)
///                 for binary_format in binary_formats:
///                     yield "macosx_{major}_{minor}_{binary_format}".format(
///                         major=compat_version[0],
///                         minor=compat_version[1],
///                         binary_format=binary_format,
///                     )
///         else:
///             for minor_version in range(16, 3, -1):
///                 compat_version = 10, minor_version
///                 binary_format = "universal2"
///                 yield "macosx_{major}_{minor}_{binary_format}".format(
///                     major=compat_version[0],
///                     minor=compat_version[1],
///                     binary_format=binary_format,
///                 )
///
///
/// def _linux_platforms(is_32bit: bool = _32_BIT_INTERPRETER) -> Iterator[str]:
///     linux = _normalize_string(sysconfig.get_platform())
///     if is_32bit:
///         if linux == "linux_x86_64":
///             linux = "linux_i686"
///         elif linux == "linux_aarch64":
///             linux = "linux_armv7l"
///     _, arch = linux.split("_", 1)
///     yield from _manylinux.platform_tags(linux, arch)
///     yield from _musllinux.platform_tags(arch)
///     yield linux
///
///
/// def _generic_platforms() -> Iterator[str]:
///     yield _normalize_string(sysconfig.get_platform())
///
///
/// def platform_tags() -> Iterator[str]:
///     """
///     Provides the platform tags for this installation.
///     """
///     if platform.system() == "Darwin":
///         return mac_platforms()
///     elif platform.system() == "Linux":
///         return _linux_platforms()
///     else:
///         return _generic_platforms()
///
///
/// def interpreter_name() -> str:
///     """
///     Returns the name of the running interpreter.
///
///     Some implementations have a reserved, two-letter abbreviation which will
///     be returned when appropriate.
///     """
///     name = sys.implementation.name
///     return INTERPRETER_SHORT_NAMES.get(name) or name
///
///
/// def interpreter_version(*, warn: bool = False) -> str:
///     """
///     Returns the version of the running interpreter.
///     """
///     version = _get_config_var("py_version_nodot", warn=warn)
///     if version:
///         version = str(version)
///     else:
///         version = _version_nodot(sys.version_info[:2])
///     return version
///
///
/// def _version_nodot(version: PythonVersion) -> str:
///     return "".join(map(str, version))
///
///
/// def sys_tags(*, warn: bool = False) -> Iterator[Tag]:
///     """
///     Returns the sequence of tag triples for the running interpreter.
///
///     The order of the sequence corresponds to priority order for the
///     interpreter, from most to least important.
///     """
///
///     interp_name = interpreter_name()
///     if interp_name == "cp":
///         yield from cpython_tags(warn=warn)
///     else:
///         yield from generic_tags()
///
///     if interp_name == "pp":
///         interp = "pp3"
///     elif interp_name == "cp":
///         interp = "cp" + interpreter_version(warn=warn)
///     else:
///         interp = None
///     yield from compatible_tags(interpreter=interp)
/// ```
final class tags extends PythonModule {
  tags.from(super.pythonModule) : super.from();

  static tags import() => PythonFfiDart.instance.importModule(
        "packaging.tags",
        tags.from,
      );

  /// ## compatible_tags
  ///
  /// ### python docstring
  ///
  /// Yields the sequence of tags that are compatible with a specific version of Python.
  ///
  /// The tags consist of:
  /// - py*-none-<platform>
  /// - <interpreter>-none-any  # ... if `interpreter` is provided.
  /// - py*-none-any
  ///
  /// ### python source
  /// ```py
  /// def compatible_tags(
  ///     python_version: Optional[PythonVersion] = None,
  ///     interpreter: Optional[str] = None,
  ///     platforms: Optional[Iterable[str]] = None,
  /// ) -> Iterator[Tag]:
  ///     """
  ///     Yields the sequence of tags that are compatible with a specific version of Python.
  ///
  ///     The tags consist of:
  ///     - py*-none-<platform>
  ///     - <interpreter>-none-any  # ... if `interpreter` is provided.
  ///     - py*-none-any
  ///     """
  ///     if not python_version:
  ///         python_version = sys.version_info[:2]
  ///     platforms = list(platforms or platform_tags())
  ///     for version in _py_interpreter_range(python_version):
  ///         for platform_ in platforms:
  ///             yield Tag(version, "none", platform_)
  ///     if interpreter:
  ///         yield Tag(interpreter, "none", "any")
  ///     for version in _py_interpreter_range(python_version):
  ///         yield Tag(version, "none", "any")
  /// ```
  Iterator<Tag> compatible_tags({
    Object? python_version,
    Object? interpreter,
    Object? platforms,
  }) =>
      TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("compatible_tags").call(
            <Object?>[
              python_version,
              interpreter,
              platforms,
            ],
            kwargs: <String, Object?>{},
          ),
        ),
      )
          .transform((e) => Tag.from(
                e,
              ))
          .cast<Tag>();

  /// ## cpython_tags
  ///
  /// ### python docstring
  ///
  /// Yields the tags for a CPython interpreter.
  ///
  /// The tags consist of:
  /// - cp<python_version>-<abi>-<platform>
  /// - cp<python_version>-abi3-<platform>
  /// - cp<python_version>-none-<platform>
  /// - cp<less than python_version>-abi3-<platform>  # Older Python versions down to 3.2.
  ///
  /// If python_version only specifies a major version then user-provided ABIs and
  /// the 'none' ABItag will be used.
  ///
  /// If 'abi3' or 'none' are specified in 'abis' then they will be yielded at
  /// their normal position and not at the beginning.
  ///
  /// ### python source
  /// ```py
  /// def cpython_tags(
  ///     python_version: Optional[PythonVersion] = None,
  ///     abis: Optional[Iterable[str]] = None,
  ///     platforms: Optional[Iterable[str]] = None,
  ///     *,
  ///     warn: bool = False,
  /// ) -> Iterator[Tag]:
  ///     """
  ///     Yields the tags for a CPython interpreter.
  ///
  ///     The tags consist of:
  ///     - cp<python_version>-<abi>-<platform>
  ///     - cp<python_version>-abi3-<platform>
  ///     - cp<python_version>-none-<platform>
  ///     - cp<less than python_version>-abi3-<platform>  # Older Python versions down to 3.2.
  ///
  ///     If python_version only specifies a major version then user-provided ABIs and
  ///     the 'none' ABItag will be used.
  ///
  ///     If 'abi3' or 'none' are specified in 'abis' then they will be yielded at
  ///     their normal position and not at the beginning.
  ///     """
  ///     if not python_version:
  ///         python_version = sys.version_info[:2]
  ///
  ///     interpreter = f"cp{_version_nodot(python_version[:2])}"
  ///
  ///     if abis is None:
  ///         if len(python_version) > 1:
  ///             abis = _cpython_abis(python_version, warn)
  ///         else:
  ///             abis = []
  ///     abis = list(abis)
  ///     # 'abi3' and 'none' are explicitly handled later.
  ///     for explicit_abi in ("abi3", "none"):
  ///         try:
  ///             abis.remove(explicit_abi)
  ///         except ValueError:
  ///             pass
  ///
  ///     platforms = list(platforms or platform_tags())
  ///     for abi in abis:
  ///         for platform_ in platforms:
  ///             yield Tag(interpreter, abi, platform_)
  ///     if _abi3_applies(python_version):
  ///         yield from (Tag(interpreter, "abi3", platform_) for platform_ in platforms)
  ///     yield from (Tag(interpreter, "none", platform_) for platform_ in platforms)
  ///
  ///     if _abi3_applies(python_version):
  ///         for minor_version in range(python_version[1] - 1, 1, -1):
  ///             for platform_ in platforms:
  ///                 interpreter = "cp{version}".format(
  ///                     version=_version_nodot((python_version[0], minor_version))
  ///                 )
  ///                 yield Tag(interpreter, "abi3", platform_)
  /// ```
  Iterator<Tag> cpython_tags({
    Object? python_version,
    Object? abis,
    Object? platforms,
    bool warn = false,
  }) =>
      TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("cpython_tags").call(
            <Object?>[
              python_version,
              abis,
              platforms,
            ],
            kwargs: <String, Object?>{
              "warn": warn,
            },
          ),
        ),
      )
          .transform((e) => Tag.from(
                e,
              ))
          .cast<Tag>();

  /// ## generic_tags
  ///
  /// ### python docstring
  ///
  /// Yields the tags for a generic interpreter.
  ///
  /// The tags consist of:
  /// - <interpreter>-<abi>-<platform>
  ///
  /// The "none" ABI will be added if it was not explicitly provided.
  ///
  /// ### python source
  /// ```py
  /// def generic_tags(
  ///     interpreter: Optional[str] = None,
  ///     abis: Optional[Iterable[str]] = None,
  ///     platforms: Optional[Iterable[str]] = None,
  ///     *,
  ///     warn: bool = False,
  /// ) -> Iterator[Tag]:
  ///     """
  ///     Yields the tags for a generic interpreter.
  ///
  ///     The tags consist of:
  ///     - <interpreter>-<abi>-<platform>
  ///
  ///     The "none" ABI will be added if it was not explicitly provided.
  ///     """
  ///     if not interpreter:
  ///         interp_name = interpreter_name()
  ///         interp_version = interpreter_version(warn=warn)
  ///         interpreter = "".join([interp_name, interp_version])
  ///     if abis is None:
  ///         abis = _generic_abi()
  ///     else:
  ///         abis = list(abis)
  ///     platforms = list(platforms or platform_tags())
  ///     if "none" not in abis:
  ///         abis.append("none")
  ///     for abi in abis:
  ///         for platform_ in platforms:
  ///             yield Tag(interpreter, abi, platform_)
  /// ```
  Iterator<Tag> generic_tags({
    Object? interpreter,
    Object? abis,
    Object? platforms,
    bool warn = false,
  }) =>
      TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("generic_tags").call(
            <Object?>[
              interpreter,
              abis,
              platforms,
            ],
            kwargs: <String, Object?>{
              "warn": warn,
            },
          ),
        ),
      )
          .transform((e) => Tag.from(
                e,
              ))
          .cast<Tag>();

  /// ## interpreter_name
  ///
  /// ### python docstring
  ///
  /// Returns the name of the running interpreter.
  ///
  /// Some implementations have a reserved, two-letter abbreviation which will
  /// be returned when appropriate.
  ///
  /// ### python source
  /// ```py
  /// def interpreter_name() -> str:
  ///     """
  ///     Returns the name of the running interpreter.
  ///
  ///     Some implementations have a reserved, two-letter abbreviation which will
  ///     be returned when appropriate.
  ///     """
  ///     name = sys.implementation.name
  ///     return INTERPRETER_SHORT_NAMES.get(name) or name
  /// ```
  String interpreter_name() => getFunction("interpreter_name").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## interpreter_version
  ///
  /// ### python docstring
  ///
  /// Returns the version of the running interpreter.
  ///
  /// ### python source
  /// ```py
  /// def interpreter_version(*, warn: bool = False) -> str:
  ///     """
  ///     Returns the version of the running interpreter.
  ///     """
  ///     version = _get_config_var("py_version_nodot", warn=warn)
  ///     if version:
  ///         version = str(version)
  ///     else:
  ///         version = _version_nodot(sys.version_info[:2])
  ///     return version
  /// ```
  String interpreter_version({
    bool warn = false,
  }) =>
      getFunction("interpreter_version").call(
        <Object?>[],
        kwargs: <String, Object?>{
          "warn": warn,
        },
      );

  /// ## mac_platforms
  ///
  /// ### python docstring
  ///
  /// Yields the platform tags for a macOS system.
  ///
  /// The `version` parameter is a two-item tuple specifying the macOS version to
  /// generate platform tags for. The `arch` parameter is the CPU architecture to
  /// generate platform tags for. Both parameters default to the appropriate value
  /// for the current system.
  ///
  /// ### python source
  /// ```py
  /// def mac_platforms(
  ///     version: Optional[MacVersion] = None, arch: Optional[str] = None
  /// ) -> Iterator[str]:
  ///     """
  ///     Yields the platform tags for a macOS system.
  ///
  ///     The `version` parameter is a two-item tuple specifying the macOS version to
  ///     generate platform tags for. The `arch` parameter is the CPU architecture to
  ///     generate platform tags for. Both parameters default to the appropriate value
  ///     for the current system.
  ///     """
  ///     version_str, _, cpu_arch = platform.mac_ver()
  ///     if version is None:
  ///         version = cast("MacVersion", tuple(map(int, version_str.split(".")[:2])))
  ///         if version == (10, 16):
  ///             # When built against an older macOS SDK, Python will report macOS 10.16
  ///             # instead of the real version.
  ///             version_str = subprocess.run(
  ///                 [
  ///                     sys.executable,
  ///                     "-sS",
  ///                     "-c",
  ///                     "import platform; print(platform.mac_ver()[0])",
  ///                 ],
  ///                 check=True,
  ///                 env={"SYSTEM_VERSION_COMPAT": "0"},
  ///                 stdout=subprocess.PIPE,
  ///                 universal_newlines=True,
  ///             ).stdout
  ///             version = cast("MacVersion", tuple(map(int, version_str.split(".")[:2])))
  ///     else:
  ///         version = version
  ///     if arch is None:
  ///         arch = _mac_arch(cpu_arch)
  ///     else:
  ///         arch = arch
  ///
  ///     if (10, 0) <= version and version < (11, 0):
  ///         # Prior to Mac OS 11, each yearly release of Mac OS bumped the
  ///         # "minor" version number.  The major version was always 10.
  ///         for minor_version in range(version[1], -1, -1):
  ///             compat_version = 10, minor_version
  ///             binary_formats = _mac_binary_formats(compat_version, arch)
  ///             for binary_format in binary_formats:
  ///                 yield "macosx_{major}_{minor}_{binary_format}".format(
  ///                     major=10, minor=minor_version, binary_format=binary_format
  ///                 )
  ///
  ///     if version >= (11, 0):
  ///         # Starting with Mac OS 11, each yearly release bumps the major version
  ///         # number.   The minor versions are now the midyear updates.
  ///         for major_version in range(version[0], 10, -1):
  ///             compat_version = major_version, 0
  ///             binary_formats = _mac_binary_formats(compat_version, arch)
  ///             for binary_format in binary_formats:
  ///                 yield "macosx_{major}_{minor}_{binary_format}".format(
  ///                     major=major_version, minor=0, binary_format=binary_format
  ///                 )
  ///
  ///     if version >= (11, 0):
  ///         # Mac OS 11 on x86_64 is compatible with binaries from previous releases.
  ///         # Arm64 support was introduced in 11.0, so no Arm binaries from previous
  ///         # releases exist.
  ///         #
  ///         # However, the "universal2" binary format can have a
  ///         # macOS version earlier than 11.0 when the x86_64 part of the binary supports
  ///         # that version of macOS.
  ///         if arch == "x86_64":
  ///             for minor_version in range(16, 3, -1):
  ///                 compat_version = 10, minor_version
  ///                 binary_formats = _mac_binary_formats(compat_version, arch)
  ///                 for binary_format in binary_formats:
  ///                     yield "macosx_{major}_{minor}_{binary_format}".format(
  ///                         major=compat_version[0],
  ///                         minor=compat_version[1],
  ///                         binary_format=binary_format,
  ///                     )
  ///         else:
  ///             for minor_version in range(16, 3, -1):
  ///                 compat_version = 10, minor_version
  ///                 binary_format = "universal2"
  ///                 yield "macosx_{major}_{minor}_{binary_format}".format(
  ///                     major=compat_version[0],
  ///                     minor=compat_version[1],
  ///                     binary_format=binary_format,
  ///                 )
  /// ```
  Iterator<String> mac_platforms({
    Object? version,
    Object? arch,
  }) =>
      TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("mac_platforms").call(
            <Object?>[
              version,
              arch,
            ],
            kwargs: <String, Object?>{},
          ),
        ),
      ).transform((e) => e).cast<String>();

  /// ## parse_tag
  ///
  /// ### python docstring
  ///
  /// Parses the provided tag (e.g. `py3-none-any`) into a frozenset of Tag instances.
  ///
  /// Returning a set is required due to the possibility that the tag is a
  /// compressed tag set.
  ///
  /// ### python source
  /// ```py
  /// def parse_tag(tag: str) -> FrozenSet[Tag]:
  ///     """
  ///     Parses the provided tag (e.g. `py3-none-any`) into a frozenset of Tag instances.
  ///
  ///     Returning a set is required due to the possibility that the tag is a
  ///     compressed tag set.
  ///     """
  ///     tags = set()
  ///     interpreters, abis, platforms = tag.split("-")
  ///     for interpreter in interpreters.split("."):
  ///         for abi in abis.split("."):
  ///             for platform_ in platforms.split("."):
  ///                 tags.add(Tag(interpreter, abi, platform_))
  ///     return frozenset(tags)
  /// ```
  Object? parse_tag({
    required String tag,
  }) =>
      getFunction("parse_tag").call(
        <Object?>[
          tag,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## platform_tags
  ///
  /// ### python docstring
  ///
  /// Provides the platform tags for this installation.
  ///
  /// ### python source
  /// ```py
  /// def platform_tags() -> Iterator[str]:
  ///     """
  ///     Provides the platform tags for this installation.
  ///     """
  ///     if platform.system() == "Darwin":
  ///         return mac_platforms()
  ///     elif platform.system() == "Linux":
  ///         return _linux_platforms()
  ///     else:
  ///         return _generic_platforms()
  /// ```
  Iterator<String> platform_tags() => TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("platform_tags").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ),
      ).transform((e) => e).cast<String>();

  /// ## sys_tags
  ///
  /// ### python docstring
  ///
  /// Returns the sequence of tag triples for the running interpreter.
  ///
  /// The order of the sequence corresponds to priority order for the
  /// interpreter, from most to least important.
  ///
  /// ### python source
  /// ```py
  /// def sys_tags(*, warn: bool = False) -> Iterator[Tag]:
  ///     """
  ///     Returns the sequence of tag triples for the running interpreter.
  ///
  ///     The order of the sequence corresponds to priority order for the
  ///     interpreter, from most to least important.
  ///     """
  ///
  ///     interp_name = interpreter_name()
  ///     if interp_name == "cp":
  ///         yield from cpython_tags(warn=warn)
  ///     else:
  ///         yield from generic_tags()
  ///
  ///     if interp_name == "pp":
  ///         interp = "pp3"
  ///     elif interp_name == "cp":
  ///         interp = "cp" + interpreter_version(warn=warn)
  ///     else:
  ///         interp = None
  ///     yield from compatible_tags(interpreter=interp)
  /// ```
  Iterator<Tag> sys_tags({
    bool warn = false,
  }) =>
      TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("sys_tags").call(
            <Object?>[],
            kwargs: <String, Object?>{
              "warn": warn,
            },
          ),
        ),
      )
          .transform((e) => Tag.from(
                e,
              ))
          .cast<Tag>();

  /// ## EXTENSION_SUFFIXES (getter)
  Object? get EXTENSION_SUFFIXES => getAttribute("EXTENSION_SUFFIXES");

  /// ## EXTENSION_SUFFIXES (setter)
  set EXTENSION_SUFFIXES(Object? EXTENSION_SUFFIXES) =>
      setAttribute("EXTENSION_SUFFIXES", EXTENSION_SUFFIXES);

  /// ## INTERPRETER_SHORT_NAMES (getter)
  Object? get INTERPRETER_SHORT_NAMES =>
      getAttribute("INTERPRETER_SHORT_NAMES");

  /// ## INTERPRETER_SHORT_NAMES (setter)
  set INTERPRETER_SHORT_NAMES(Object? INTERPRETER_SHORT_NAMES) =>
      setAttribute("INTERPRETER_SHORT_NAMES", INTERPRETER_SHORT_NAMES);
}

/// ## utils
///
/// ### python source
/// ```py
/// # This file is dual licensed under the terms of the Apache License, Version
/// # 2.0, and the BSD License. See the LICENSE file in the root of this repository
/// # for complete details.
///
/// import re
/// from typing import FrozenSet, NewType, Tuple, Union, cast
///
/// from .tags import Tag, parse_tag
/// from .version import InvalidVersion, Version
///
/// BuildTag = Union[Tuple[()], Tuple[int, str]]
/// NormalizedName = NewType("NormalizedName", str)
///
///
/// class InvalidWheelFilename(ValueError):
///     """
///     An invalid wheel filename was found, users should refer to PEP 427.
///     """
///
///
/// class InvalidSdistFilename(ValueError):
///     """
///     An invalid sdist filename was found, users should refer to the packaging user guide.
///     """
///
///
/// _canonicalize_regex = re.compile(r"[-_.]+")
/// # PEP 427: The build number must start with a digit.
/// _build_tag_regex = re.compile(r"(\d+)(.*)")
///
///
/// def canonicalize_name(name: str) -> NormalizedName:
///     # This is taken from PEP 503.
///     value = _canonicalize_regex.sub("-", name).lower()
///     return cast(NormalizedName, value)
///
///
/// def canonicalize_version(
///     version: Union[Version, str], *, strip_trailing_zero: bool = True
/// ) -> str:
///     """
///     This is very similar to Version.__str__, but has one subtle difference
///     with the way it handles the release segment.
///     """
///     if isinstance(version, str):
///         try:
///             parsed = Version(version)
///         except InvalidVersion:
///             # Legacy versions cannot be normalized
///             return version
///     else:
///         parsed = version
///
///     parts = []
///
///     # Epoch
///     if parsed.epoch != 0:
///         parts.append(f"{parsed.epoch}!")
///
///     # Release segment
///     release_segment = ".".join(str(x) for x in parsed.release)
///     if strip_trailing_zero:
///         # NB: This strips trailing '.0's to normalize
///         release_segment = re.sub(r"(\.0)+$", "", release_segment)
///     parts.append(release_segment)
///
///     # Pre-release
///     if parsed.pre is not None:
///         parts.append("".join(str(x) for x in parsed.pre))
///
///     # Post-release
///     if parsed.post is not None:
///         parts.append(f".post{parsed.post}")
///
///     # Development release
///     if parsed.dev is not None:
///         parts.append(f".dev{parsed.dev}")
///
///     # Local version segment
///     if parsed.local is not None:
///         parts.append(f"+{parsed.local}")
///
///     return "".join(parts)
///
///
/// def parse_wheel_filename(
///     filename: str,
/// ) -> Tuple[NormalizedName, Version, BuildTag, FrozenSet[Tag]]:
///     if not filename.endswith(".whl"):
///         raise InvalidWheelFilename(
///             f"Invalid wheel filename (extension must be '.whl'): {filename}"
///         )
///
///     filename = filename[:-4]
///     dashes = filename.count("-")
///     if dashes not in (4, 5):
///         raise InvalidWheelFilename(
///             f"Invalid wheel filename (wrong number of parts): {filename}"
///         )
///
///     parts = filename.split("-", dashes - 2)
///     name_part = parts[0]
///     # See PEP 427 for the rules on escaping the project name
///     if "__" in name_part or re.match(r"^[\w\d._]*$", name_part, re.UNICODE) is None:
///         raise InvalidWheelFilename(f"Invalid project name: {filename}")
///     name = canonicalize_name(name_part)
///     version = Version(parts[1])
///     if dashes == 5:
///         build_part = parts[2]
///         build_match = _build_tag_regex.match(build_part)
///         if build_match is None:
///             raise InvalidWheelFilename(
///                 f"Invalid build number: {build_part} in '{filename}'"
///             )
///         build = cast(BuildTag, (int(build_match.group(1)), build_match.group(2)))
///     else:
///         build = ()
///     tags = parse_tag(parts[-1])
///     return (name, version, build, tags)
///
///
/// def parse_sdist_filename(filename: str) -> Tuple[NormalizedName, Version]:
///     if filename.endswith(".tar.gz"):
///         file_stem = filename[: -len(".tar.gz")]
///     elif filename.endswith(".zip"):
///         file_stem = filename[: -len(".zip")]
///     else:
///         raise InvalidSdistFilename(
///             f"Invalid sdist filename (extension must be '.tar.gz' or '.zip'):"
///             f" {filename}"
///         )
///
///     # We are requiring a PEP 440 version, which cannot contain dashes,
///     # so we split on the last dash.
///     name_part, sep, version_part = file_stem.rpartition("-")
///     if not sep:
///         raise InvalidSdistFilename(f"Invalid sdist filename: {filename}")
///
///     name = canonicalize_name(name_part)
///     version = Version(version_part)
///     return (name, version)
/// ```
final class utils extends PythonModule {
  utils.from(super.pythonModule) : super.from();

  static utils import() => PythonFfiDart.instance.importModule(
        "packaging.utils",
        utils.from,
      );

  /// ## canonicalize_name
  ///
  /// ### python source
  /// ```py
  /// def canonicalize_name(name: str) -> NormalizedName:
  ///     # This is taken from PEP 503.
  ///     value = _canonicalize_regex.sub("-", name).lower()
  ///     return cast(NormalizedName, value)
  /// ```
  Object? canonicalize_name({
    required String name,
  }) =>
      getFunction("canonicalize_name").call(
        <Object?>[
          name,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## canonicalize_version
  ///
  /// ### python docstring
  ///
  /// This is very similar to Version.__str__, but has one subtle difference
  /// with the way it handles the release segment.
  ///
  /// ### python source
  /// ```py
  /// def canonicalize_version(
  ///     version: Union[Version, str], *, strip_trailing_zero: bool = True
  /// ) -> str:
  ///     """
  ///     This is very similar to Version.__str__, but has one subtle difference
  ///     with the way it handles the release segment.
  ///     """
  ///     if isinstance(version, str):
  ///         try:
  ///             parsed = Version(version)
  ///         except InvalidVersion:
  ///             # Legacy versions cannot be normalized
  ///             return version
  ///     else:
  ///         parsed = version
  ///
  ///     parts = []
  ///
  ///     # Epoch
  ///     if parsed.epoch != 0:
  ///         parts.append(f"{parsed.epoch}!")
  ///
  ///     # Release segment
  ///     release_segment = ".".join(str(x) for x in parsed.release)
  ///     if strip_trailing_zero:
  ///         # NB: This strips trailing '.0's to normalize
  ///         release_segment = re.sub(r"(\.0)+$", "", release_segment)
  ///     parts.append(release_segment)
  ///
  ///     # Pre-release
  ///     if parsed.pre is not None:
  ///         parts.append("".join(str(x) for x in parsed.pre))
  ///
  ///     # Post-release
  ///     if parsed.post is not None:
  ///         parts.append(f".post{parsed.post}")
  ///
  ///     # Development release
  ///     if parsed.dev is not None:
  ///         parts.append(f".dev{parsed.dev}")
  ///
  ///     # Local version segment
  ///     if parsed.local is not None:
  ///         parts.append(f"+{parsed.local}")
  ///
  ///     return "".join(parts)
  /// ```
  String canonicalize_version({
    required Object? version,
    bool strip_trailing_zero = true,
  }) =>
      getFunction("canonicalize_version").call(
        <Object?>[
          version,
        ],
        kwargs: <String, Object?>{
          "strip_trailing_zero": strip_trailing_zero,
        },
      );

  /// ## parse_sdist_filename
  ///
  /// ### python source
  /// ```py
  /// def parse_sdist_filename(filename: str) -> Tuple[NormalizedName, Version]:
  ///     if filename.endswith(".tar.gz"):
  ///         file_stem = filename[: -len(".tar.gz")]
  ///     elif filename.endswith(".zip"):
  ///         file_stem = filename[: -len(".zip")]
  ///     else:
  ///         raise InvalidSdistFilename(
  ///             f"Invalid sdist filename (extension must be '.tar.gz' or '.zip'):"
  ///             f" {filename}"
  ///         )
  ///
  ///     # We are requiring a PEP 440 version, which cannot contain dashes,
  ///     # so we split on the last dash.
  ///     name_part, sep, version_part = file_stem.rpartition("-")
  ///     if not sep:
  ///         raise InvalidSdistFilename(f"Invalid sdist filename: {filename}")
  ///
  ///     name = canonicalize_name(name_part)
  ///     version = Version(version_part)
  ///     return (name, version)
  /// ```
  Object? parse_sdist_filename({
    required String filename,
  }) =>
      getFunction("parse_sdist_filename").call(
        <Object?>[
          filename,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## parse_wheel_filename
  ///
  /// ### python source
  /// ```py
  /// def parse_wheel_filename(
  ///     filename: str,
  /// ) -> Tuple[NormalizedName, Version, BuildTag, FrozenSet[Tag]]:
  ///     if not filename.endswith(".whl"):
  ///         raise InvalidWheelFilename(
  ///             f"Invalid wheel filename (extension must be '.whl'): {filename}"
  ///         )
  ///
  ///     filename = filename[:-4]
  ///     dashes = filename.count("-")
  ///     if dashes not in (4, 5):
  ///         raise InvalidWheelFilename(
  ///             f"Invalid wheel filename (wrong number of parts): {filename}"
  ///         )
  ///
  ///     parts = filename.split("-", dashes - 2)
  ///     name_part = parts[0]
  ///     # See PEP 427 for the rules on escaping the project name
  ///     if "__" in name_part or re.match(r"^[\w\d._]*$", name_part, re.UNICODE) is None:
  ///         raise InvalidWheelFilename(f"Invalid project name: {filename}")
  ///     name = canonicalize_name(name_part)
  ///     version = Version(parts[1])
  ///     if dashes == 5:
  ///         build_part = parts[2]
  ///         build_match = _build_tag_regex.match(build_part)
  ///         if build_match is None:
  ///             raise InvalidWheelFilename(
  ///                 f"Invalid build number: {build_part} in '{filename}'"
  ///             )
  ///         build = cast(BuildTag, (int(build_match.group(1)), build_match.group(2)))
  ///     else:
  ///         build = ()
  ///     tags = parse_tag(parts[-1])
  ///     return (name, version, build, tags)
  /// ```
  Object? parse_wheel_filename({
    required String filename,
  }) =>
      getFunction("parse_wheel_filename").call(
        <Object?>[
          filename,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## NormalizedName (getter)
  Object? get NormalizedName => getAttribute("NormalizedName");

  /// ## NormalizedName (setter)
  set NormalizedName(Object? NormalizedName) =>
      setAttribute("NormalizedName", NormalizedName);
}

/// ## version
///
/// ### python docstring
///
/// .. testsetup::
///
///     from packaging.version import parse, Version
///
/// ### python source
/// ```py
/// # This file is dual licensed under the terms of the Apache License, Version
/// # 2.0, and the BSD License. See the LICENSE file in the root of this repository
/// # for complete details.
/// """
/// .. testsetup::
///
///     from packaging.version import parse, Version
/// """
///
/// import collections
/// import itertools
/// import re
/// from typing import Any, Callable, Optional, SupportsInt, Tuple, Union
///
/// from ._structures import Infinity, InfinityType, NegativeInfinity, NegativeInfinityType
///
/// __all__ = ["VERSION_PATTERN", "parse", "Version", "InvalidVersion"]
///
/// InfiniteTypes = Union[InfinityType, NegativeInfinityType]
/// PrePostDevType = Union[InfiniteTypes, Tuple[str, int]]
/// SubLocalType = Union[InfiniteTypes, int, str]
/// LocalType = Union[
///     NegativeInfinityType,
///     Tuple[
///         Union[
///             SubLocalType,
///             Tuple[SubLocalType, str],
///             Tuple[NegativeInfinityType, SubLocalType],
///         ],
///         ...,
///     ],
/// ]
/// CmpKey = Tuple[
///     int, Tuple[int, ...], PrePostDevType, PrePostDevType, PrePostDevType, LocalType
/// ]
/// VersionComparisonMethod = Callable[[CmpKey, CmpKey], bool]
///
/// _Version = collections.namedtuple(
///     "_Version", ["epoch", "release", "dev", "pre", "post", "local"]
/// )
///
///
/// def parse(version: str) -> "Version":
///     """Parse the given version string.
///
///     >>> parse('1.0.dev1')
///     <Version('1.0.dev1')>
///
///     :param version: The version string to parse.
///     :raises InvalidVersion: When the version string is not a valid version.
///     """
///     return Version(version)
///
///
/// class InvalidVersion(ValueError):
///     """Raised when a version string is not a valid version.
///
///     >>> Version("invalid")
///     Traceback (most recent call last):
///         ...
///     packaging.version.InvalidVersion: Invalid version: 'invalid'
///     """
///
///
/// class _BaseVersion:
///     _key: Tuple[Any, ...]
///
///     def __hash__(self) -> int:
///         return hash(self._key)
///
///     # Please keep the duplicated `isinstance` check
///     # in the six comparisons hereunder
///     # unless you find a way to avoid adding overhead function calls.
///     def __lt__(self, other: "_BaseVersion") -> bool:
///         if not isinstance(other, _BaseVersion):
///             return NotImplemented
///
///         return self._key < other._key
///
///     def __le__(self, other: "_BaseVersion") -> bool:
///         if not isinstance(other, _BaseVersion):
///             return NotImplemented
///
///         return self._key <= other._key
///
///     def __eq__(self, other: object) -> bool:
///         if not isinstance(other, _BaseVersion):
///             return NotImplemented
///
///         return self._key == other._key
///
///     def __ge__(self, other: "_BaseVersion") -> bool:
///         if not isinstance(other, _BaseVersion):
///             return NotImplemented
///
///         return self._key >= other._key
///
///     def __gt__(self, other: "_BaseVersion") -> bool:
///         if not isinstance(other, _BaseVersion):
///             return NotImplemented
///
///         return self._key > other._key
///
///     def __ne__(self, other: object) -> bool:
///         if not isinstance(other, _BaseVersion):
///             return NotImplemented
///
///         return self._key != other._key
///
///
/// # Deliberately not anchored to the start and end of the string, to make it
/// # easier for 3rd party code to reuse
/// _VERSION_PATTERN = r"""
///     v?
///     (?:
///         (?:(?P<epoch>[0-9]+)!)?                           # epoch
///         (?P<release>[0-9]+(?:\.[0-9]+)*)                  # release segment
///         (?P<pre>                                          # pre-release
///             [-_\.]?
///             (?P<pre_l>(a|b|c|rc|alpha|beta|pre|preview))
///             [-_\.]?
///             (?P<pre_n>[0-9]+)?
///         )?
///         (?P<post>                                         # post release
///             (?:-(?P<post_n1>[0-9]+))
///             |
///             (?:
///                 [-_\.]?
///                 (?P<post_l>post|rev|r)
///                 [-_\.]?
///                 (?P<post_n2>[0-9]+)?
///             )
///         )?
///         (?P<dev>                                          # dev release
///             [-_\.]?
///             (?P<dev_l>dev)
///             [-_\.]?
///             (?P<dev_n>[0-9]+)?
///         )?
///     )
///     (?:\+(?P<local>[a-z0-9]+(?:[-_\.][a-z0-9]+)*))?       # local version
/// """
///
/// VERSION_PATTERN = _VERSION_PATTERN
/// """
/// A string containing the regular expression used to match a valid version.
///
/// The pattern is not anchored at either end, and is intended for embedding in larger
/// expressions (for example, matching a version number as part of a file name). The
/// regular expression should be compiled with the ``re.VERBOSE`` and ``re.IGNORECASE``
/// flags set.
///
/// :meta hide-value:
/// """
///
///
/// class Version(_BaseVersion):
///     """This class abstracts handling of a project's versions.
///
///     A :class:`Version` instance is comparison aware and can be compared and
///     sorted using the standard Python interfaces.
///
///     >>> v1 = Version("1.0a5")
///     >>> v2 = Version("1.0")
///     >>> v1
///     <Version('1.0a5')>
///     >>> v2
///     <Version('1.0')>
///     >>> v1 < v2
///     True
///     >>> v1 == v2
///     False
///     >>> v1 > v2
///     False
///     >>> v1 >= v2
///     False
///     >>> v1 <= v2
///     True
///     """
///
///     _regex = re.compile(r"^\s*" + VERSION_PATTERN + r"\s*$", re.VERBOSE | re.IGNORECASE)
///     _key: CmpKey
///
///     def __init__(self, version: str) -> None:
///         """Initialize a Version object.
///
///         :param version:
///             The string representation of a version which will be parsed and normalized
///             before use.
///         :raises InvalidVersion:
///             If the ``version`` does not conform to PEP 440 in any way then this
///             exception will be raised.
///         """
///
///         # Validate the version and parse it into pieces
///         match = self._regex.search(version)
///         if not match:
///             raise InvalidVersion(f"Invalid version: '{version}'")
///
///         # Store the parsed out pieces of the version
///         self._version = _Version(
///             epoch=int(match.group("epoch")) if match.group("epoch") else 0,
///             release=tuple(int(i) for i in match.group("release").split(".")),
///             pre=_parse_letter_version(match.group("pre_l"), match.group("pre_n")),
///             post=_parse_letter_version(
///                 match.group("post_l"), match.group("post_n1") or match.group("post_n2")
///             ),
///             dev=_parse_letter_version(match.group("dev_l"), match.group("dev_n")),
///             local=_parse_local_version(match.group("local")),
///         )
///
///         # Generate a key which will be used for sorting
///         self._key = _cmpkey(
///             self._version.epoch,
///             self._version.release,
///             self._version.pre,
///             self._version.post,
///             self._version.dev,
///             self._version.local,
///         )
///
///     def __repr__(self) -> str:
///         """A representation of the Version that shows all internal state.
///
///         >>> Version('1.0.0')
///         <Version('1.0.0')>
///         """
///         return f"<Version('{self}')>"
///
///     def __str__(self) -> str:
///         """A string representation of the version that can be rounded-tripped.
///
///         >>> str(Version("1.0a5"))
///         '1.0a5'
///         """
///         parts = []
///
///         # Epoch
///         if self.epoch != 0:
///             parts.append(f"{self.epoch}!")
///
///         # Release segment
///         parts.append(".".join(str(x) for x in self.release))
///
///         # Pre-release
///         if self.pre is not None:
///             parts.append("".join(str(x) for x in self.pre))
///
///         # Post-release
///         if self.post is not None:
///             parts.append(f".post{self.post}")
///
///         # Development release
///         if self.dev is not None:
///             parts.append(f".dev{self.dev}")
///
///         # Local version segment
///         if self.local is not None:
///             parts.append(f"+{self.local}")
///
///         return "".join(parts)
///
///     @property
///     def epoch(self) -> int:
///         """The epoch of the version.
///
///         >>> Version("2.0.0").epoch
///         0
///         >>> Version("1!2.0.0").epoch
///         1
///         """
///         _epoch: int = self._version.epoch
///         return _epoch
///
///     @property
///     def release(self) -> Tuple[int, ...]:
///         """The components of the "release" segment of the version.
///
///         >>> Version("1.2.3").release
///         (1, 2, 3)
///         >>> Version("2.0.0").release
///         (2, 0, 0)
///         >>> Version("1!2.0.0.post0").release
///         (2, 0, 0)
///
///         Includes trailing zeroes but not the epoch or any pre-release / development /
///         post-release suffixes.
///         """
///         _release: Tuple[int, ...] = self._version.release
///         return _release
///
///     @property
///     def pre(self) -> Optional[Tuple[str, int]]:
///         """The pre-release segment of the version.
///
///         >>> print(Version("1.2.3").pre)
///         None
///         >>> Version("1.2.3a1").pre
///         ('a', 1)
///         >>> Version("1.2.3b1").pre
///         ('b', 1)
///         >>> Version("1.2.3rc1").pre
///         ('rc', 1)
///         """
///         _pre: Optional[Tuple[str, int]] = self._version.pre
///         return _pre
///
///     @property
///     def post(self) -> Optional[int]:
///         """The post-release number of the version.
///
///         >>> print(Version("1.2.3").post)
///         None
///         >>> Version("1.2.3.post1").post
///         1
///         """
///         return self._version.post[1] if self._version.post else None
///
///     @property
///     def dev(self) -> Optional[int]:
///         """The development number of the version.
///
///         >>> print(Version("1.2.3").dev)
///         None
///         >>> Version("1.2.3.dev1").dev
///         1
///         """
///         return self._version.dev[1] if self._version.dev else None
///
///     @property
///     def local(self) -> Optional[str]:
///         """The local version segment of the version.
///
///         >>> print(Version("1.2.3").local)
///         None
///         >>> Version("1.2.3+abc").local
///         'abc'
///         """
///         if self._version.local:
///             return ".".join(str(x) for x in self._version.local)
///         else:
///             return None
///
///     @property
///     def public(self) -> str:
///         """The public portion of the version.
///
///         >>> Version("1.2.3").public
///         '1.2.3'
///         >>> Version("1.2.3+abc").public
///         '1.2.3'
///         >>> Version("1.2.3+abc.dev1").public
///         '1.2.3'
///         """
///         return str(self).split("+", 1)[0]
///
///     @property
///     def base_version(self) -> str:
///         """The "base version" of the version.
///
///         >>> Version("1.2.3").base_version
///         '1.2.3'
///         >>> Version("1.2.3+abc").base_version
///         '1.2.3'
///         >>> Version("1!1.2.3+abc.dev1").base_version
///         '1!1.2.3'
///
///         The "base version" is the public version of the project without any pre or post
///         release markers.
///         """
///         parts = []
///
///         # Epoch
///         if self.epoch != 0:
///             parts.append(f"{self.epoch}!")
///
///         # Release segment
///         parts.append(".".join(str(x) for x in self.release))
///
///         return "".join(parts)
///
///     @property
///     def is_prerelease(self) -> bool:
///         """Whether this version is a pre-release.
///
///         >>> Version("1.2.3").is_prerelease
///         False
///         >>> Version("1.2.3a1").is_prerelease
///         True
///         >>> Version("1.2.3b1").is_prerelease
///         True
///         >>> Version("1.2.3rc1").is_prerelease
///         True
///         >>> Version("1.2.3dev1").is_prerelease
///         True
///         """
///         return self.dev is not None or self.pre is not None
///
///     @property
///     def is_postrelease(self) -> bool:
///         """Whether this version is a post-release.
///
///         >>> Version("1.2.3").is_postrelease
///         False
///         >>> Version("1.2.3.post1").is_postrelease
///         True
///         """
///         return self.post is not None
///
///     @property
///     def is_devrelease(self) -> bool:
///         """Whether this version is a development release.
///
///         >>> Version("1.2.3").is_devrelease
///         False
///         >>> Version("1.2.3.dev1").is_devrelease
///         True
///         """
///         return self.dev is not None
///
///     @property
///     def major(self) -> int:
///         """The first item of :attr:`release` or ``0`` if unavailable.
///
///         >>> Version("1.2.3").major
///         1
///         """
///         return self.release[0] if len(self.release) >= 1 else 0
///
///     @property
///     def minor(self) -> int:
///         """The second item of :attr:`release` or ``0`` if unavailable.
///
///         >>> Version("1.2.3").minor
///         2
///         >>> Version("1").minor
///         0
///         """
///         return self.release[1] if len(self.release) >= 2 else 0
///
///     @property
///     def micro(self) -> int:
///         """The third item of :attr:`release` or ``0`` if unavailable.
///
///         >>> Version("1.2.3").micro
///         3
///         >>> Version("1").micro
///         0
///         """
///         return self.release[2] if len(self.release) >= 3 else 0
///
///
/// def _parse_letter_version(
///     letter: str, number: Union[str, bytes, SupportsInt]
/// ) -> Optional[Tuple[str, int]]:
///
///     if letter:
///         # We consider there to be an implicit 0 in a pre-release if there is
///         # not a numeral associated with it.
///         if number is None:
///             number = 0
///
///         # We normalize any letters to their lower case form
///         letter = letter.lower()
///
///         # We consider some words to be alternate spellings of other words and
///         # in those cases we want to normalize the spellings to our preferred
///         # spelling.
///         if letter == "alpha":
///             letter = "a"
///         elif letter == "beta":
///             letter = "b"
///         elif letter in ["c", "pre", "preview"]:
///             letter = "rc"
///         elif letter in ["rev", "r"]:
///             letter = "post"
///
///         return letter, int(number)
///     if not letter and number:
///         # We assume if we are given a number, but we are not given a letter
///         # then this is using the implicit post release syntax (e.g. 1.0-1)
///         letter = "post"
///
///         return letter, int(number)
///
///     return None
///
///
/// _local_version_separators = re.compile(r"[\._-]")
///
///
/// def _parse_local_version(local: str) -> Optional[LocalType]:
///     """
///     Takes a string like abc.1.twelve and turns it into ("abc", 1, "twelve").
///     """
///     if local is not None:
///         return tuple(
///             part.lower() if not part.isdigit() else int(part)
///             for part in _local_version_separators.split(local)
///         )
///     return None
///
///
/// def _cmpkey(
///     epoch: int,
///     release: Tuple[int, ...],
///     pre: Optional[Tuple[str, int]],
///     post: Optional[Tuple[str, int]],
///     dev: Optional[Tuple[str, int]],
///     local: Optional[Tuple[SubLocalType]],
/// ) -> CmpKey:
///
///     # When we compare a release version, we want to compare it with all of the
///     # trailing zeros removed. So we'll use a reverse the list, drop all the now
///     # leading zeros until we come to something non zero, then take the rest
///     # re-reverse it back into the correct order and make it a tuple and use
///     # that for our sorting key.
///     _release = tuple(
///         reversed(list(itertools.dropwhile(lambda x: x == 0, reversed(release))))
///     )
///
///     # We need to "trick" the sorting algorithm to put 1.0.dev0 before 1.0a0.
///     # We'll do this by abusing the pre segment, but we _only_ want to do this
///     # if there is not a pre or a post segment. If we have one of those then
///     # the normal sorting rules will handle this case correctly.
///     if pre is None and post is None and dev is not None:
///         _pre: PrePostDevType = NegativeInfinity
///     # Versions without a pre-release (except as noted above) should sort after
///     # those with one.
///     elif pre is None:
///         _pre = Infinity
///     else:
///         _pre = pre
///
///     # Versions without a post segment should sort before those with one.
///     if post is None:
///         _post: PrePostDevType = NegativeInfinity
///
///     else:
///         _post = post
///
///     # Versions without a development segment should sort after those with one.
///     if dev is None:
///         _dev: PrePostDevType = Infinity
///
///     else:
///         _dev = dev
///
///     if local is None:
///         # Versions without a local segment should sort before those with one.
///         _local: LocalType = NegativeInfinity
///     else:
///         # Versions with a local segment need that segment parsed to implement
///         # the sorting rules in PEP440.
///         # - Alpha numeric segments sort before numeric segments
///         # - Alpha numeric segments sort lexicographically
///         # - Numeric segments sort numerically
///         # - Shorter versions sort before longer versions when the prefixes
///         #   match exactly
///         _local = tuple(
///             (i, "") if isinstance(i, int) else (NegativeInfinity, i) for i in local
///         )
///
///     return epoch, _release, _pre, _post, _dev, _local
/// ```
final class version extends PythonModule {
  version.from(super.pythonModule) : super.from();

  static version import() => PythonFfiDart.instance.importModule(
        "packaging.version",
        version.from,
      );

  /// ## parse
  ///
  /// ### python docstring
  ///
  /// Parse the given version string.
  ///
  /// >>> parse('1.0.dev1')
  /// <Version('1.0.dev1')>
  ///
  /// :param version: The version string to parse.
  /// :raises InvalidVersion: When the version string is not a valid version.
  ///
  /// ### python source
  /// ```py
  /// def parse(version: str) -> "Version":
  ///     """Parse the given version string.
  ///
  ///     >>> parse('1.0.dev1')
  ///     <Version('1.0.dev1')>
  ///
  ///     :param version: The version string to parse.
  ///     :raises InvalidVersion: When the version string is not a valid version.
  ///     """
  ///     return Version(version)
  /// ```
  Object? parse({
    required String version,
  }) =>
      getFunction("parse").call(
        <Object?>[
          version,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## VERSION_PATTERN (getter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  Object? get VERSION_PATTERN => getAttribute("VERSION_PATTERN");

  /// ## VERSION_PATTERN (setter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  set VERSION_PATTERN(Object? VERSION_PATTERN) =>
      setAttribute("VERSION_PATTERN", VERSION_PATTERN);
}
