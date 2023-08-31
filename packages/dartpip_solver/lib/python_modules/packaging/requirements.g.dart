// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library requirements;

import "package:python_ffi_dart/python_ffi_dart.dart";

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
