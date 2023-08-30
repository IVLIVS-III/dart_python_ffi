// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library utils;

import "package:python_ffi_dart/python_ffi_dart.dart";

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
