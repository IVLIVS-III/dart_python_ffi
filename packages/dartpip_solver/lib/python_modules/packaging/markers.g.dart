// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library markers;

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
        "packaging.markers",
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
        "packaging.markers",
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
        "packaging.markers",
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
        "packaging.markers",
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
        "packaging.markers",
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
        "packaging.markers",
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

  /// ## sys
  sys get $sys => sys.import();

  /// ## Callable (getter)
  Object? get Callable => getAttribute("Callable");

  /// ## Callable (setter)
  set Callable(Object? Callable) => setAttribute("Callable", Callable);

  /// ## Dict (getter)
  Object? get Dict => getAttribute("Dict");

  /// ## Dict (setter)
  set Dict(Object? Dict) => setAttribute("Dict", Dict);

  /// ## List (getter)
  Object? get $List => getAttribute("List");

  /// ## List (setter)
  set $List(Object? $List) => setAttribute("List", $List);

  /// ## MarkerList (getter)
  Object? get MarkerList => getAttribute("MarkerList");

  /// ## MarkerList (setter)
  set MarkerList(Object? MarkerList) => setAttribute("MarkerList", MarkerList);

  /// ## Operator (getter)
  Object? get Operator => getAttribute("Operator");

  /// ## Operator (setter)
  set Operator(Object? Operator) => setAttribute("Operator", Operator);

  /// ## Optional (getter)
  Object? get Optional => getAttribute("Optional");

  /// ## Optional (setter)
  set Optional(Object? Optional) => setAttribute("Optional", Optional);

  /// ## Tuple (getter)
  Object? get Tuple => getAttribute("Tuple");

  /// ## Tuple (setter)
  set Tuple(Object? Tuple) => setAttribute("Tuple", Tuple);

  /// ## Union (getter)
  Object? get Union => getAttribute("Union");

  /// ## Union (setter)
  set Union(Object? Union) => setAttribute("Union", Union);
}

/// ## sys
final class sys extends PythonModule {
  sys.from(super.pythonModule) : super.from();

  static sys import() => PythonFfiDart.instance.importModule(
        "packaging.sys",
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
