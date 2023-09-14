// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library version;

import "package:python_ffi_dart/python_ffi_dart.dart";

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
        "packaging.version",
        "InfinityType",
        InfinityType.from,
        <Object?>[],
      );

  InfinityType.from(super.pythonClass) : super.from();
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
        "packaging.version",
        "NegativeInfinityType",
        NegativeInfinityType.from,
        <Object?>[],
      );

  NegativeInfinityType.from(super.pythonClass) : super.from();
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
        "packaging.version",
        "accumulate",
        accumulate.from,
        <Object?>[],
      );

  accumulate.from(super.pythonClass) : super.from();
}

/// ## chain
final class chain extends PythonClass {
  factory chain() => PythonFfiDart.instance.importClass(
        "packaging.version",
        "chain",
        chain.from,
        <Object?>[],
      );

  chain.from(super.pythonClass) : super.from();
}

/// ## combinations
final class combinations extends PythonClass {
  factory combinations() => PythonFfiDart.instance.importClass(
        "packaging.version",
        "combinations",
        combinations.from,
        <Object?>[],
      );

  combinations.from(super.pythonClass) : super.from();
}

/// ## combinations_with_replacement
final class combinations_with_replacement extends PythonClass {
  factory combinations_with_replacement() => PythonFfiDart.instance.importClass(
        "packaging.version",
        "combinations_with_replacement",
        combinations_with_replacement.from,
        <Object?>[],
      );

  combinations_with_replacement.from(super.pythonClass) : super.from();
}

/// ## compress
final class compress extends PythonClass {
  factory compress() => PythonFfiDart.instance.importClass(
        "packaging.version",
        "compress",
        compress.from,
        <Object?>[],
      );

  compress.from(super.pythonClass) : super.from();
}

/// ## count
final class count extends PythonClass {
  factory count() => PythonFfiDart.instance.importClass(
        "packaging.version",
        "count",
        count.from,
        <Object?>[],
      );

  count.from(super.pythonClass) : super.from();
}

/// ## cycle
final class cycle extends PythonClass {
  factory cycle() => PythonFfiDart.instance.importClass(
        "packaging.version",
        "cycle",
        cycle.from,
        <Object?>[],
      );

  cycle.from(super.pythonClass) : super.from();
}

/// ## dropwhile
final class dropwhile extends PythonClass {
  factory dropwhile() => PythonFfiDart.instance.importClass(
        "packaging.version",
        "dropwhile",
        dropwhile.from,
        <Object?>[],
      );

  dropwhile.from(super.pythonClass) : super.from();
}

/// ## filterfalse
final class filterfalse extends PythonClass {
  factory filterfalse() => PythonFfiDart.instance.importClass(
        "packaging.version",
        "filterfalse",
        filterfalse.from,
        <Object?>[],
      );

  filterfalse.from(super.pythonClass) : super.from();
}

/// ## groupby
final class groupby extends PythonClass {
  factory groupby() => PythonFfiDart.instance.importClass(
        "packaging.version",
        "groupby",
        groupby.from,
        <Object?>[],
      );

  groupby.from(super.pythonClass) : super.from();
}

/// ## islice
final class islice extends PythonClass {
  factory islice() => PythonFfiDart.instance.importClass(
        "packaging.version",
        "islice",
        islice.from,
        <Object?>[],
      );

  islice.from(super.pythonClass) : super.from();
}

/// ## pairwise
final class pairwise extends PythonClass {
  factory pairwise() => PythonFfiDart.instance.importClass(
        "packaging.version",
        "pairwise",
        pairwise.from,
        <Object?>[],
      );

  pairwise.from(super.pythonClass) : super.from();
}

/// ## permutations
final class permutations extends PythonClass {
  factory permutations() => PythonFfiDart.instance.importClass(
        "packaging.version",
        "permutations",
        permutations.from,
        <Object?>[],
      );

  permutations.from(super.pythonClass) : super.from();
}

/// ## product
final class product extends PythonClass {
  factory product() => PythonFfiDart.instance.importClass(
        "packaging.version",
        "product",
        product.from,
        <Object?>[],
      );

  product.from(super.pythonClass) : super.from();
}

/// ## repeat
final class repeat extends PythonClass {
  factory repeat() => PythonFfiDart.instance.importClass(
        "packaging.version",
        "repeat",
        repeat.from,
        <Object?>[],
      );

  repeat.from(super.pythonClass) : super.from();
}

/// ## starmap
final class starmap extends PythonClass {
  factory starmap() => PythonFfiDart.instance.importClass(
        "packaging.version",
        "starmap",
        starmap.from,
        <Object?>[],
      );

  starmap.from(super.pythonClass) : super.from();
}

/// ## takewhile
final class takewhile extends PythonClass {
  factory takewhile() => PythonFfiDart.instance.importClass(
        "packaging.version",
        "takewhile",
        takewhile.from,
        <Object?>[],
      );

  takewhile.from(super.pythonClass) : super.from();
}

/// ## zip_longest
final class zip_longest extends PythonClass {
  factory zip_longest() => PythonFfiDart.instance.importClass(
        "packaging.version",
        "zip_longest",
        zip_longest.from,
        <Object?>[],
      );

  zip_longest.from(super.pythonClass) : super.from();
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

  /// ## itertools
  itertools get $itertools => itertools.import();

  /// ## Infinity (getter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  Object? get Infinity => getAttribute("Infinity");

  /// ## Infinity (setter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  set Infinity(Object? Infinity) => setAttribute("Infinity", Infinity);

  /// ## NegativeInfinity (getter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  Object? get NegativeInfinity => getAttribute("NegativeInfinity");

  /// ## NegativeInfinity (setter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  set NegativeInfinity(Object? NegativeInfinity) =>
      setAttribute("NegativeInfinity", NegativeInfinity);

  /// ## Callable (getter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  Object? get Callable => getAttribute("Callable");

  /// ## Callable (setter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  set Callable(Object? Callable) => setAttribute("Callable", Callable);

  /// ## CmpKey (getter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  Object? get CmpKey => getAttribute("CmpKey");

  /// ## CmpKey (setter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  set CmpKey(Object? CmpKey) => setAttribute("CmpKey", CmpKey);

  /// ## InfiniteTypes (getter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  Object? get InfiniteTypes => getAttribute("InfiniteTypes");

  /// ## InfiniteTypes (setter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  set InfiniteTypes(Object? InfiniteTypes) =>
      setAttribute("InfiniteTypes", InfiniteTypes);

  /// ## LocalType (getter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  Object? get LocalType => getAttribute("LocalType");

  /// ## LocalType (setter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  set LocalType(Object? LocalType) => setAttribute("LocalType", LocalType);

  /// ## Optional (getter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  Object? get Optional => getAttribute("Optional");

  /// ## Optional (setter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  set Optional(Object? Optional) => setAttribute("Optional", Optional);

  /// ## PrePostDevType (getter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  Object? get PrePostDevType => getAttribute("PrePostDevType");

  /// ## PrePostDevType (setter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  set PrePostDevType(Object? PrePostDevType) =>
      setAttribute("PrePostDevType", PrePostDevType);

  /// ## SubLocalType (getter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  Object? get SubLocalType => getAttribute("SubLocalType");

  /// ## SubLocalType (setter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  set SubLocalType(Object? SubLocalType) =>
      setAttribute("SubLocalType", SubLocalType);

  /// ## Tuple (getter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  Object? get Tuple => getAttribute("Tuple");

  /// ## Tuple (setter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  set Tuple(Object? Tuple) => setAttribute("Tuple", Tuple);

  /// ## Union (getter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  Object? get Union => getAttribute("Union");

  /// ## Union (setter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  set Union(Object? Union) => setAttribute("Union", Union);

  /// ## VersionComparisonMethod (getter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  Object? get VersionComparisonMethod =>
      getAttribute("VersionComparisonMethod");

  /// ## VersionComparisonMethod (setter)
  ///
  /// ### python docstring
  ///
  /// .. testsetup::
  ///
  ///     from packaging.version import parse, Version
  set VersionComparisonMethod(Object? VersionComparisonMethod) =>
      setAttribute("VersionComparisonMethod", VersionComparisonMethod);

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

/// ## itertools
final class itertools extends PythonModule {
  itertools.from(super.pythonModule) : super.from();

  static itertools import() => PythonFfiDart.instance.importModule(
        "packaging.itertools",
        itertools.from,
      );
}
