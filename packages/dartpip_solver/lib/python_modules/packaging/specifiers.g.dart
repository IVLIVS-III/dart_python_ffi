// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library specifiers;

import "package:python_ffi_dart/python_ffi_dart.dart";

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
