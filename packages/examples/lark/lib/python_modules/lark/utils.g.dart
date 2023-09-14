// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library utils;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## Enumerator
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
///
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
///
/// ### python source
/// ```py
/// class Enumerator(Serialize):
///     def __init__(self) -> None:
///         self.enums: Dict[Any, int] = {}
///
///     def get(self, item) -> int:
///         if item not in self.enums:
///             self.enums[item] = len(self.enums)
///         return self.enums[item]
///
///     def __len__(self):
///         return len(self.enums)
///
///     def reversed(self) -> Dict[int, Any]:
///         r = {v: k for k, v in self.enums.items()}
///         assert len(r) == len(self.enums)
///         return r
/// ```
final class Enumerator extends PythonClass {
  factory Enumerator() => PythonFfiDart.instance.importClass(
        "lark.utils",
        "Enumerator",
        Enumerator.from,
        <Object?>[],
        <String, Object?>{},
      );

  Enumerator.from(super.pythonClass) : super.from();

  /// ## get
  ///
  /// ### python source
  /// ```py
  /// def get(self, item) -> int:
  ///         if item not in self.enums:
  ///             self.enums[item] = len(self.enums)
  ///         return self.enums[item]
  /// ```
  int $get({
    required Object? item,
  }) =>
      getFunction("get").call(
        <Object?>[
          item,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## memo_serialize
  ///
  /// ### python source
  /// ```py
  /// def memo_serialize(self, types_to_memoize: List) -> Any:
  ///         memo = SerializeMemoizer(types_to_memoize)
  ///         return self.serialize(memo), memo.serialize()
  /// ```
  Object? memo_serialize({
    required Object? types_to_memoize,
  }) =>
      getFunction("memo_serialize").call(
        <Object?>[
          types_to_memoize,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## reversed
  ///
  /// ### python source
  /// ```py
  /// def reversed(self) -> Dict[int, Any]:
  ///         r = {v: k for k, v in self.enums.items()}
  ///         assert len(r) == len(self.enums)
  ///         return r
  /// ```
  Object? reversed() => getFunction("reversed").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## serialize
  ///
  /// ### python source
  /// ```py
  /// def serialize(self, memo = None) -> Dict[str, Any]:
  ///         if memo and memo.in_types(self):
  ///             return {'@': memo.memoized.get(self)}
  ///
  ///         fields = getattr(self, '__serialize_fields__')
  ///         res = {f: _serialize(getattr(self, f), memo) for f in fields}
  ///         res['__type__'] = type(self).__name__
  ///         if hasattr(self, '_serialize'):
  ///             self._serialize(res, memo)  # type: ignore[attr-defined]
  ///         return res
  /// ```
  Object? serialize({
    Object? memo,
  }) =>
      getFunction("serialize").call(
        <Object?>[
          memo,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## deserialize (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## enums (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get enums => getAttribute("enums");

  /// ## enums (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set enums(Object? enums) => setAttribute("enums", enums);
}

/// ## FS
///
/// ### python source
/// ```py
/// class FS:
///     exists = staticmethod(os.path.exists)
///
///     @staticmethod
///     def open(name, mode="r", **kwargs):
///         if _has_atomicwrites and "w" in mode:
///             return atomicwrites.atomic_write(name, mode=mode, overwrite=True, **kwargs)
///         else:
///             return open(name, mode, **kwargs)
/// ```
final class FS extends PythonClass {
  factory FS() => PythonFfiDart.instance.importClass(
        "lark.utils",
        "FS",
        FS.from,
        <Object?>[],
      );

  FS.from(super.pythonClass) : super.from();

  /// ## exists
  ///
  /// ### python docstring
  ///
  /// Test whether a path exists.  Returns False for broken symbolic links
  Object? exists() => getFunction("exists").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## open
  ///
  /// ### python source
  /// ```py
  /// @staticmethod
  ///     def open(name, mode="r", **kwargs):
  ///         if _has_atomicwrites and "w" in mode:
  ///             return atomicwrites.atomic_write(name, mode=mode, overwrite=True, **kwargs)
  ///         else:
  ///             return open(name, mode, **kwargs)
  /// ```
  Object? open({
    Object? mode = "r",
    Map<String, Object?> kwargs = const <String, Object?>{},
  }) =>
      getFunction("open").call(
        <Object?>[
          mode,
        ],
        kwargs: <String, Object?>{
          ...kwargs,
        },
      );
}

/// ## Serialize
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
///
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
///
/// ### python source
/// ```py
/// class Serialize:
///     """Safe-ish serialization interface that doesn't rely on Pickle
///
///     Attributes:
///         __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///         __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                         Should include all field types that aren't builtin types.
///     """
///
///     def memo_serialize(self, types_to_memoize: List) -> Any:
///         memo = SerializeMemoizer(types_to_memoize)
///         return self.serialize(memo), memo.serialize()
///
///     def serialize(self, memo = None) -> Dict[str, Any]:
///         if memo and memo.in_types(self):
///             return {'@': memo.memoized.get(self)}
///
///         fields = getattr(self, '__serialize_fields__')
///         res = {f: _serialize(getattr(self, f), memo) for f in fields}
///         res['__type__'] = type(self).__name__
///         if hasattr(self, '_serialize'):
///             self._serialize(res, memo)  # type: ignore[attr-defined]
///         return res
///
///     @classmethod
///     def deserialize(cls: Type[_T], data: Dict[str, Any], memo: Dict[int, Any]) -> _T:
///         namespace = getattr(cls, '__serialize_namespace__', [])
///         namespace = {c.__name__:c for c in namespace}
///
///         fields = getattr(cls, '__serialize_fields__')
///
///         if '@' in data:
///             return memo[data['@']]
///
///         inst = cls.__new__(cls)
///         for f in fields:
///             try:
///                 setattr(inst, f, _deserialize(data[f], namespace, memo))
///             except KeyError as e:
///                 raise KeyError("Cannot find key for class", cls, e)
///
///         if hasattr(inst, '_deserialize'):
///             inst._deserialize()  # type: ignore[attr-defined]
///
///         return inst
/// ```
final class Serialize extends PythonClass {
  factory Serialize() => PythonFfiDart.instance.importClass(
        "lark.utils",
        "Serialize",
        Serialize.from,
        <Object?>[],
      );

  Serialize.from(super.pythonClass) : super.from();

  /// ## memo_serialize
  ///
  /// ### python source
  /// ```py
  /// def memo_serialize(self, types_to_memoize: List) -> Any:
  ///         memo = SerializeMemoizer(types_to_memoize)
  ///         return self.serialize(memo), memo.serialize()
  /// ```
  Object? memo_serialize({
    required Object? types_to_memoize,
  }) =>
      getFunction("memo_serialize").call(
        <Object?>[
          types_to_memoize,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## serialize
  ///
  /// ### python source
  /// ```py
  /// def serialize(self, memo = None) -> Dict[str, Any]:
  ///         if memo and memo.in_types(self):
  ///             return {'@': memo.memoized.get(self)}
  ///
  ///         fields = getattr(self, '__serialize_fields__')
  ///         res = {f: _serialize(getattr(self, f), memo) for f in fields}
  ///         res['__type__'] = type(self).__name__
  ///         if hasattr(self, '_serialize'):
  ///             self._serialize(res, memo)  # type: ignore[attr-defined]
  ///         return res
  /// ```
  Object? serialize({
    Object? memo,
  }) =>
      getFunction("serialize").call(
        <Object?>[
          memo,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## deserialize (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);
}

/// ## SerializeMemoizer
///
/// ### python docstring
///
/// A version of serialize that memoizes objects to reduce space
///
/// ### python source
/// ```py
/// class SerializeMemoizer(Serialize):
///     "A version of serialize that memoizes objects to reduce space"
///
///     __serialize_fields__ = 'memoized',
///
///     def __init__(self, types_to_memoize: List) -> None:
///         self.types_to_memoize = tuple(types_to_memoize)
///         self.memoized = Enumerator()
///
///     def in_types(self, value: Serialize) -> bool:
///         return isinstance(value, self.types_to_memoize)
///
///     def serialize(self) -> Dict[int, Any]:  # type: ignore[override]
///         return _serialize(self.memoized.reversed(), None)
///
///     @classmethod
///     def deserialize(cls, data: Dict[int, Any], namespace: Dict[str, Any], memo: Dict[Any, Any]) -> Dict[int, Any]:  # type: ignore[override]
///         return _deserialize(data, namespace, memo)
/// ```
final class SerializeMemoizer extends PythonClass {
  factory SerializeMemoizer({
    required Object? types_to_memoize,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.utils",
        "SerializeMemoizer",
        SerializeMemoizer.from,
        <Object?>[
          types_to_memoize,
        ],
        <String, Object?>{},
      );

  SerializeMemoizer.from(super.pythonClass) : super.from();

  /// ## in_types
  ///
  /// ### python source
  /// ```py
  /// def in_types(self, value: Serialize) -> bool:
  ///         return isinstance(value, self.types_to_memoize)
  /// ```
  bool in_types({
    required Serialize value,
  }) =>
      getFunction("in_types").call(
        <Object?>[
          value,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## memo_serialize
  ///
  /// ### python source
  /// ```py
  /// def memo_serialize(self, types_to_memoize: List) -> Any:
  ///         memo = SerializeMemoizer(types_to_memoize)
  ///         return self.serialize(memo), memo.serialize()
  /// ```
  Object? memo_serialize({
    required Object? types_to_memoize,
  }) =>
      getFunction("memo_serialize").call(
        <Object?>[
          types_to_memoize,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## serialize
  ///
  /// ### python source
  /// ```py
  /// def serialize(self) -> Dict[int, Any]:  # type: ignore[override]
  ///         return _serialize(self.memoized.reversed(), None)
  /// ```
  Object? serialize() => getFunction("serialize").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## deserialize (getter)
  ///
  /// ### python docstring
  ///
  /// A version of serialize that memoizes objects to reduce space
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  ///
  /// ### python docstring
  ///
  /// A version of serialize that memoizes objects to reduce space
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## types_to_memoize (getter)
  ///
  /// ### python docstring
  ///
  /// A version of serialize that memoizes objects to reduce space
  Object? get types_to_memoize => getAttribute("types_to_memoize");

  /// ## types_to_memoize (setter)
  ///
  /// ### python docstring
  ///
  /// A version of serialize that memoizes objects to reduce space
  set types_to_memoize(Object? types_to_memoize) =>
      setAttribute("types_to_memoize", types_to_memoize);

  /// ## memoized (getter)
  ///
  /// ### python docstring
  ///
  /// A version of serialize that memoizes objects to reduce space
  Object? get memoized => getAttribute("memoized");

  /// ## memoized (setter)
  ///
  /// ### python docstring
  ///
  /// A version of serialize that memoizes objects to reduce space
  set memoized(Object? memoized) => setAttribute("memoized", memoized);
}

/// ## fzset
///
/// ### python source
/// ```py
/// class fzset(frozenset):
///     def __repr__(self):
///         return '{%s}' % ', '.join(map(repr, self))
/// ```
final class fzset extends PythonClass {
  factory fzset() => PythonFfiDart.instance.importClass(
        "lark.utils",
        "fzset",
        fzset.from,
        <Object?>[],
      );

  fzset.from(super.pythonClass) : super.from();

  /// ## copy (getter)
  Object? get copy => getAttribute("copy");

  /// ## copy (setter)
  set copy(Object? copy) => setAttribute("copy", copy);

  /// ## difference (getter)
  Object? get difference => getAttribute("difference");

  /// ## difference (setter)
  set difference(Object? difference) => setAttribute("difference", difference);

  /// ## intersection (getter)
  Object? get intersection => getAttribute("intersection");

  /// ## intersection (setter)
  set intersection(Object? intersection) =>
      setAttribute("intersection", intersection);

  /// ## isdisjoint (getter)
  Object? get isdisjoint => getAttribute("isdisjoint");

  /// ## isdisjoint (setter)
  set isdisjoint(Object? isdisjoint) => setAttribute("isdisjoint", isdisjoint);

  /// ## issubset (getter)
  Object? get issubset => getAttribute("issubset");

  /// ## issubset (setter)
  set issubset(Object? issubset) => setAttribute("issubset", issubset);

  /// ## issuperset (getter)
  Object? get issuperset => getAttribute("issuperset");

  /// ## issuperset (setter)
  set issuperset(Object? issuperset) => setAttribute("issuperset", issuperset);

  /// ## symmetric_difference (getter)
  Object? get symmetric_difference => getAttribute("symmetric_difference");

  /// ## symmetric_difference (setter)
  set symmetric_difference(Object? symmetric_difference) =>
      setAttribute("symmetric_difference", symmetric_difference);

  /// ## union (getter)
  Object? get union => getAttribute("union");

  /// ## union (setter)
  set union(Object? union) => setAttribute("union", union);
}

/// ## product
final class product extends PythonClass {
  factory product() => PythonFfiDart.instance.importClass(
        "lark.utils",
        "product",
        product.from,
        <Object?>[],
      );

  product.from(super.pythonClass) : super.from();
}

/// ## UCD
final class UCD extends PythonClass {
  factory UCD() => PythonFfiDart.instance.importClass(
        "lark.utils",
        "UCD",
        UCD.from,
        <Object?>[],
      );

  UCD.from(super.pythonClass) : super.from();

  /// ## unidata_version (getter)
  Object? get unidata_version => getAttribute("unidata_version");

  /// ## unidata_version (setter)
  set unidata_version(Object? unidata_version) =>
      setAttribute("unidata_version", unidata_version);

  /// ## bidirectional (getter)
  Object? get bidirectional => getAttribute("bidirectional");

  /// ## bidirectional (setter)
  set bidirectional(Object? bidirectional) =>
      setAttribute("bidirectional", bidirectional);

  /// ## category (getter)
  Object? get category => getAttribute("category");

  /// ## category (setter)
  set category(Object? category) => setAttribute("category", category);

  /// ## combining (getter)
  Object? get combining => getAttribute("combining");

  /// ## combining (setter)
  set combining(Object? combining) => setAttribute("combining", combining);

  /// ## decimal (getter)
  Object? get decimal => getAttribute("decimal");

  /// ## decimal (setter)
  set decimal(Object? decimal) => setAttribute("decimal", decimal);

  /// ## decomposition (getter)
  Object? get decomposition => getAttribute("decomposition");

  /// ## decomposition (setter)
  set decomposition(Object? decomposition) =>
      setAttribute("decomposition", decomposition);

  /// ## digit (getter)
  Object? get digit => getAttribute("digit");

  /// ## digit (setter)
  set digit(Object? digit) => setAttribute("digit", digit);

  /// ## east_asian_width (getter)
  Object? get east_asian_width => getAttribute("east_asian_width");

  /// ## east_asian_width (setter)
  set east_asian_width(Object? east_asian_width) =>
      setAttribute("east_asian_width", east_asian_width);

  /// ## is_normalized (getter)
  Object? get is_normalized => getAttribute("is_normalized");

  /// ## is_normalized (setter)
  set is_normalized(Object? is_normalized) =>
      setAttribute("is_normalized", is_normalized);

  /// ## lookup (getter)
  Object? get lookup => getAttribute("lookup");

  /// ## lookup (setter)
  set lookup(Object? lookup) => setAttribute("lookup", lookup);

  /// ## mirrored (getter)
  Object? get mirrored => getAttribute("mirrored");

  /// ## mirrored (setter)
  set mirrored(Object? mirrored) => setAttribute("mirrored", mirrored);

  /// ## name (getter)
  Object? get name => getAttribute("name");

  /// ## name (setter)
  set name(Object? name) => setAttribute("name", name);

  /// ## normalize (getter)
  Object? get normalize => getAttribute("normalize");

  /// ## normalize (setter)
  set normalize(Object? normalize) => setAttribute("normalize", normalize);

  /// ## numeric (getter)
  Object? get numeric => getAttribute("numeric");

  /// ## numeric (setter)
  set numeric(Object? numeric) => setAttribute("numeric", numeric);
}

/// ## utils
///
/// ### python source
/// ```py
/// import unicodedata
/// import os
/// from itertools import product
/// from collections import deque
/// from typing import Callable, Iterator, List, Optional, Tuple, Type, TypeVar, Union, Dict, Any, Sequence, Iterable
///
/// ###{standalone
/// import sys, re
/// import logging
///
/// logger: logging.Logger = logging.getLogger("lark")
/// logger.addHandler(logging.StreamHandler())
/// # Set to highest level, since we have some warnings amongst the code
/// # By default, we should not output any log messages
/// logger.setLevel(logging.CRITICAL)
///
///
/// NO_VALUE = object()
///
/// T = TypeVar("T")
///
///
/// def classify(seq: Iterable, key: Optional[Callable] = None, value: Optional[Callable] = None) -> Dict:
///     d: Dict[Any, Any] = {}
///     for item in seq:
///         k = key(item) if (key is not None) else item
///         v = value(item) if (value is not None) else item
///         try:
///             d[k].append(v)
///         except KeyError:
///             d[k] = [v]
///     return d
///
///
/// def _deserialize(data: Any, namespace: Dict[str, Any], memo: Dict) -> Any:
///     if isinstance(data, dict):
///         if '__type__' in data:  # Object
///             class_ = namespace[data['__type__']]
///             return class_.deserialize(data, memo)
///         elif '@' in data:
///             return memo[data['@']]
///         return {key:_deserialize(value, namespace, memo) for key, value in data.items()}
///     elif isinstance(data, list):
///         return [_deserialize(value, namespace, memo) for value in data]
///     return data
///
///
/// _T = TypeVar("_T", bound="Serialize")
///
/// class Serialize:
///     """Safe-ish serialization interface that doesn't rely on Pickle
///
///     Attributes:
///         __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///         __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                         Should include all field types that aren't builtin types.
///     """
///
///     def memo_serialize(self, types_to_memoize: List) -> Any:
///         memo = SerializeMemoizer(types_to_memoize)
///         return self.serialize(memo), memo.serialize()
///
///     def serialize(self, memo = None) -> Dict[str, Any]:
///         if memo and memo.in_types(self):
///             return {'@': memo.memoized.get(self)}
///
///         fields = getattr(self, '__serialize_fields__')
///         res = {f: _serialize(getattr(self, f), memo) for f in fields}
///         res['__type__'] = type(self).__name__
///         if hasattr(self, '_serialize'):
///             self._serialize(res, memo)  # type: ignore[attr-defined]
///         return res
///
///     @classmethod
///     def deserialize(cls: Type[_T], data: Dict[str, Any], memo: Dict[int, Any]) -> _T:
///         namespace = getattr(cls, '__serialize_namespace__', [])
///         namespace = {c.__name__:c for c in namespace}
///
///         fields = getattr(cls, '__serialize_fields__')
///
///         if '@' in data:
///             return memo[data['@']]
///
///         inst = cls.__new__(cls)
///         for f in fields:
///             try:
///                 setattr(inst, f, _deserialize(data[f], namespace, memo))
///             except KeyError as e:
///                 raise KeyError("Cannot find key for class", cls, e)
///
///         if hasattr(inst, '_deserialize'):
///             inst._deserialize()  # type: ignore[attr-defined]
///
///         return inst
///
///
/// class SerializeMemoizer(Serialize):
///     "A version of serialize that memoizes objects to reduce space"
///
///     __serialize_fields__ = 'memoized',
///
///     def __init__(self, types_to_memoize: List) -> None:
///         self.types_to_memoize = tuple(types_to_memoize)
///         self.memoized = Enumerator()
///
///     def in_types(self, value: Serialize) -> bool:
///         return isinstance(value, self.types_to_memoize)
///
///     def serialize(self) -> Dict[int, Any]:  # type: ignore[override]
///         return _serialize(self.memoized.reversed(), None)
///
///     @classmethod
///     def deserialize(cls, data: Dict[int, Any], namespace: Dict[str, Any], memo: Dict[Any, Any]) -> Dict[int, Any]:  # type: ignore[override]
///         return _deserialize(data, namespace, memo)
///
///
/// try:
///     import regex
///     _has_regex = True
/// except ImportError:
///     _has_regex = False
///
/// if sys.version_info >= (3, 11):
///     import re._parser as sre_parse
///     import re._constants as sre_constants
/// else:
///     import sre_parse
///     import sre_constants
///
/// categ_pattern = re.compile(r'\\p{[A-Za-z_]+}')
///
/// def get_regexp_width(expr: str) -> Union[Tuple[int, int], List[int]]:
///     if _has_regex:
///         # Since `sre_parse` cannot deal with Unicode categories of the form `\p{Mn}`, we replace these with
///         # a simple letter, which makes no difference as we are only trying to get the possible lengths of the regex
///         # match here below.
///         regexp_final = re.sub(categ_pattern, 'A', expr)
///     else:
///         if re.search(categ_pattern, expr):
///             raise ImportError('`regex` module must be installed in order to use Unicode categories.', expr)
///         regexp_final = expr
///     try:
///         # Fixed in next version (past 0.960) of typeshed
///         return [int(x) for x in sre_parse.parse(regexp_final).getwidth()]   # type: ignore[attr-defined]
///     except sre_constants.error:
///         if not _has_regex:
///             raise ValueError(expr)
///         else:
///             # sre_parse does not support the new features in regex. To not completely fail in that case,
///             # we manually test for the most important info (whether the empty string is matched)
///             c = regex.compile(regexp_final)
///             if c.match('') is None:
///                 # MAXREPEAT is a none pickable subclass of int, therefore needs to be converted to enable caching
///                 return 1, int(sre_constants.MAXREPEAT)
///             else:
///                 return 0, int(sre_constants.MAXREPEAT)
///
/// ###}
///
///
/// _ID_START =    'Lu', 'Ll', 'Lt', 'Lm', 'Lo', 'Mn', 'Mc', 'Pc'
/// _ID_CONTINUE = _ID_START + ('Nd', 'Nl',)
///
/// def _test_unicode_category(s: str, categories: Sequence[str]) -> bool:
///     if len(s) != 1:
///         return all(_test_unicode_category(char, categories) for char in s)
///     return s == '_' or unicodedata.category(s) in categories
///
/// def is_id_continue(s: str) -> bool:
///     """
///     Checks if all characters in `s` are alphanumeric characters (Unicode standard, so diacritics, indian vowels, non-latin
///     numbers, etc. all pass). Synonymous with a Python `ID_CONTINUE` identifier. See PEP 3131 for details.
///     """
///     return _test_unicode_category(s, _ID_CONTINUE)
///
/// def is_id_start(s: str) -> bool:
///     """
///     Checks if all characters in `s` are alphabetic characters (Unicode standard, so diacritics, indian vowels, non-latin
///     numbers, etc. all pass). Synonymous with a Python `ID_START` identifier. See PEP 3131 for details.
///     """
///     return _test_unicode_category(s, _ID_START)
///
///
/// def dedup_list(l: List[T]) -> List[T]:
///     """Given a list (l) will removing duplicates from the list,
///        preserving the original order of the list. Assumes that
///        the list entries are hashable."""
///     dedup = set()
///     # This returns None, but that's expected
///     return [x for x in l if not (x in dedup or dedup.add(x))]  # type: ignore[func-returns-value]
///     # 2x faster (ordered in PyPy and CPython 3.6+, guaranteed to be ordered in Python 3.7+)
///     # return list(dict.fromkeys(l))
///
///
/// class Enumerator(Serialize):
///     def __init__(self) -> None:
///         self.enums: Dict[Any, int] = {}
///
///     def get(self, item) -> int:
///         if item not in self.enums:
///             self.enums[item] = len(self.enums)
///         return self.enums[item]
///
///     def __len__(self):
///         return len(self.enums)
///
///     def reversed(self) -> Dict[int, Any]:
///         r = {v: k for k, v in self.enums.items()}
///         assert len(r) == len(self.enums)
///         return r
///
///
///
/// def combine_alternatives(lists):
///     """
///     Accepts a list of alternatives, and enumerates all their possible concatenations.
///
///     Examples:
///         >>> combine_alternatives([range(2), [4,5]])
///         [[0, 4], [0, 5], [1, 4], [1, 5]]
///
///         >>> combine_alternatives(["abc", "xy", '$'])
///         [['a', 'x', '$'], ['a', 'y', '$'], ['b', 'x', '$'], ['b', 'y', '$'], ['c', 'x', '$'], ['c', 'y', '$']]
///
///         >>> combine_alternatives([])
///         [[]]
///     """
///     if not lists:
///         return [[]]
///     assert all(l for l in lists), lists
///     return list(product(*lists))
///
/// try:
///     import atomicwrites
///     _has_atomicwrites = True
/// except ImportError:
///     _has_atomicwrites = False
///
/// class FS:
///     exists = staticmethod(os.path.exists)
///
///     @staticmethod
///     def open(name, mode="r", **kwargs):
///         if _has_atomicwrites and "w" in mode:
///             return atomicwrites.atomic_write(name, mode=mode, overwrite=True, **kwargs)
///         else:
///             return open(name, mode, **kwargs)
///
///
///
/// def isascii(s: str) -> bool:
///     """ str.isascii only exists in python3.7+ """
///     if sys.version_info >= (3, 7):
///         return s.isascii()
///     else:
///         try:
///             s.encode('ascii')
///             return True
///         except (UnicodeDecodeError, UnicodeEncodeError):
///             return False
///
///
/// class fzset(frozenset):
///     def __repr__(self):
///         return '{%s}' % ', '.join(map(repr, self))
///
///
/// def classify_bool(seq: Sequence, pred: Callable) -> Any:
///     false_elems = []
///     true_elems = [elem for elem in seq if pred(elem) or false_elems.append(elem)]  # type: ignore[func-returns-value]
///     return true_elems, false_elems
///
///
/// def bfs(initial: Sequence, expand: Callable) -> Iterator:
///     open_q = deque(list(initial))
///     visited = set(open_q)
///     while open_q:
///         node = open_q.popleft()
///         yield node
///         for next_node in expand(node):
///             if next_node not in visited:
///                 visited.add(next_node)
///                 open_q.append(next_node)
///
/// def bfs_all_unique(initial, expand):
///     "bfs, but doesn't keep track of visited (aka seen), because there can be no repetitions"
///     open_q = deque(list(initial))
///     while open_q:
///         node = open_q.popleft()
///         yield node
///         open_q += expand(node)
///
///
/// def _serialize(value: Any, memo: Optional[SerializeMemoizer]) -> Any:
///     if isinstance(value, Serialize):
///         return value.serialize(memo)
///     elif isinstance(value, list):
///         return [_serialize(elem, memo) for elem in value]
///     elif isinstance(value, frozenset):
///         return list(value)  # TODO reversible?
///     elif isinstance(value, dict):
///         return {key:_serialize(elem, memo) for key, elem in value.items()}
///     # assert value is None or isinstance(value, (int, float, str, tuple)), value
///     return value
///
///
///
///
/// def small_factors(n: int, max_factor: int) -> List[Tuple[int, int]]:
///     """
///     Splits n up into smaller factors and summands <= max_factor.
///     Returns a list of [(a, b), ...]
///     so that the following code returns n:
///
///     n = 1
///     for a, b in values:
///         n = n * a + b
///
///     Currently, we also keep a + b <= max_factor, but that might change
///     """
///     assert n >= 0
///     assert max_factor > 2
///     if n <= max_factor:
///         return [(n, 0)]
///
///     for a in range(max_factor, 1, -1):
///         r, b = divmod(n, a)
///         if a + b <= max_factor:
///             return small_factors(r, max_factor) + [(a, b)]
///     assert False, "Failed to factorize %s" % n
/// ```
final class utils extends PythonModule {
  utils.from(super.pythonModule) : super.from();

  static utils import() => PythonFfiDart.instance.importModule(
        "lark.utils",
        utils.from,
      );

  /// ## bfs
  ///
  /// ### python source
  /// ```py
  /// def bfs(initial: Sequence, expand: Callable) -> Iterator:
  ///     open_q = deque(list(initial))
  ///     visited = set(open_q)
  ///     while open_q:
  ///         node = open_q.popleft()
  ///         yield node
  ///         for next_node in expand(node):
  ///             if next_node not in visited:
  ///                 visited.add(next_node)
  ///                 open_q.append(next_node)
  /// ```
  Iterator bfs({
    required Object? initial,
    required Function expand,
  }) =>
      getFunction("bfs").call(
        <Object?>[
          initial,
          expand,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## bfs_all_unique
  ///
  /// ### python docstring
  ///
  /// bfs, but doesn't keep track of visited (aka seen), because there can be no repetitions
  ///
  /// ### python source
  /// ```py
  /// def bfs_all_unique(initial, expand):
  ///     "bfs, but doesn't keep track of visited (aka seen), because there can be no repetitions"
  ///     open_q = deque(list(initial))
  ///     while open_q:
  ///         node = open_q.popleft()
  ///         yield node
  ///         open_q += expand(node)
  /// ```
  Object? bfs_all_unique({
    required Object? initial,
    required Object? expand,
  }) =>
      getFunction("bfs_all_unique").call(
        <Object?>[
          initial,
          expand,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## classify
  ///
  /// ### python source
  /// ```py
  /// def classify(seq: Iterable, key: Optional[Callable] = None, value: Optional[Callable] = None) -> Dict:
  ///     d: Dict[Any, Any] = {}
  ///     for item in seq:
  ///         k = key(item) if (key is not None) else item
  ///         v = value(item) if (value is not None) else item
  ///         try:
  ///             d[k].append(v)
  ///         except KeyError:
  ///             d[k] = [v]
  ///     return d
  /// ```
  Object? classify({
    required Iterable seq,
    Object? key,
    Object? value,
  }) =>
      getFunction("classify").call(
        <Object?>[
          seq,
          key,
          value,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## classify_bool
  ///
  /// ### python source
  /// ```py
  /// def classify_bool(seq: Sequence, pred: Callable) -> Any:
  ///     false_elems = []
  ///     true_elems = [elem for elem in seq if pred(elem) or false_elems.append(elem)]  # type: ignore[func-returns-value]
  ///     return true_elems, false_elems
  /// ```
  Object? classify_bool({
    required Object? seq,
    required Function pred,
  }) =>
      getFunction("classify_bool").call(
        <Object?>[
          seq,
          pred,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## combine_alternatives
  ///
  /// ### python docstring
  ///
  /// Accepts a list of alternatives, and enumerates all their possible concatenations.
  ///
  /// Examples:
  ///     >>> combine_alternatives([range(2), [4,5]])
  ///     [[0, 4], [0, 5], [1, 4], [1, 5]]
  ///
  ///     >>> combine_alternatives(["abc", "xy", '$'])
  ///     [['a', 'x', '$'], ['a', 'y', '$'], ['b', 'x', '$'], ['b', 'y', '$'], ['c', 'x', '$'], ['c', 'y', '$']]
  ///
  ///     >>> combine_alternatives([])
  ///     [[]]
  ///
  /// ### python source
  /// ```py
  /// def combine_alternatives(lists):
  ///     """
  ///     Accepts a list of alternatives, and enumerates all their possible concatenations.
  ///
  ///     Examples:
  ///         >>> combine_alternatives([range(2), [4,5]])
  ///         [[0, 4], [0, 5], [1, 4], [1, 5]]
  ///
  ///         >>> combine_alternatives(["abc", "xy", '$'])
  ///         [['a', 'x', '$'], ['a', 'y', '$'], ['b', 'x', '$'], ['b', 'y', '$'], ['c', 'x', '$'], ['c', 'y', '$']]
  ///
  ///         >>> combine_alternatives([])
  ///         [[]]
  ///     """
  ///     if not lists:
  ///         return [[]]
  ///     assert all(l for l in lists), lists
  ///     return list(product(*lists))
  /// ```
  Object? combine_alternatives({
    required Object? lists,
  }) =>
      getFunction("combine_alternatives").call(
        <Object?>[
          lists,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## dedup_list
  ///
  /// ### python docstring
  ///
  /// Given a list (l) will removing duplicates from the list,
  /// preserving the original order of the list. Assumes that
  /// the list entries are hashable.
  ///
  /// ### python source
  /// ```py
  /// def dedup_list(l: List[T]) -> List[T]:
  ///     """Given a list (l) will removing duplicates from the list,
  ///        preserving the original order of the list. Assumes that
  ///        the list entries are hashable."""
  ///     dedup = set()
  ///     # This returns None, but that's expected
  ///     return [x for x in l if not (x in dedup or dedup.add(x))]  # type: ignore[func-returns-value]
  ///     # 2x faster (ordered in PyPy and CPython 3.6+, guaranteed to be ordered in Python 3.7+)
  ///     # return list(dict.fromkeys(l))
  /// ```
  Object? dedup_list({
    required Object? l,
  }) =>
      getFunction("dedup_list").call(
        <Object?>[
          l,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## get_regexp_width
  ///
  /// ### python source
  /// ```py
  /// def get_regexp_width(expr: str) -> Union[Tuple[int, int], List[int]]:
  ///     if _has_regex:
  ///         # Since `sre_parse` cannot deal with Unicode categories of the form `\p{Mn}`, we replace these with
  ///         # a simple letter, which makes no difference as we are only trying to get the possible lengths of the regex
  ///         # match here below.
  ///         regexp_final = re.sub(categ_pattern, 'A', expr)
  ///     else:
  ///         if re.search(categ_pattern, expr):
  ///             raise ImportError('`regex` module must be installed in order to use Unicode categories.', expr)
  ///         regexp_final = expr
  ///     try:
  ///         # Fixed in next version (past 0.960) of typeshed
  ///         return [int(x) for x in sre_parse.parse(regexp_final).getwidth()]   # type: ignore[attr-defined]
  ///     except sre_constants.error:
  ///         if not _has_regex:
  ///             raise ValueError(expr)
  ///         else:
  ///             # sre_parse does not support the new features in regex. To not completely fail in that case,
  ///             # we manually test for the most important info (whether the empty string is matched)
  ///             c = regex.compile(regexp_final)
  ///             if c.match('') is None:
  ///                 # MAXREPEAT is a none pickable subclass of int, therefore needs to be converted to enable caching
  ///                 return 1, int(sre_constants.MAXREPEAT)
  ///             else:
  ///                 return 0, int(sre_constants.MAXREPEAT)
  /// ```
  Object? get_regexp_width({
    required String expr,
  }) =>
      getFunction("get_regexp_width").call(
        <Object?>[
          expr,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## is_id_continue
  ///
  /// ### python docstring
  ///
  /// Checks if all characters in `s` are alphanumeric characters (Unicode standard, so diacritics, indian vowels, non-latin
  /// numbers, etc. all pass). Synonymous with a Python `ID_CONTINUE` identifier. See PEP 3131 for details.
  ///
  /// ### python source
  /// ```py
  /// def is_id_continue(s: str) -> bool:
  ///     """
  ///     Checks if all characters in `s` are alphanumeric characters (Unicode standard, so diacritics, indian vowels, non-latin
  ///     numbers, etc. all pass). Synonymous with a Python `ID_CONTINUE` identifier. See PEP 3131 for details.
  ///     """
  ///     return _test_unicode_category(s, _ID_CONTINUE)
  /// ```
  bool is_id_continue({
    required String s,
  }) =>
      getFunction("is_id_continue").call(
        <Object?>[
          s,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## is_id_start
  ///
  /// ### python docstring
  ///
  /// Checks if all characters in `s` are alphabetic characters (Unicode standard, so diacritics, indian vowels, non-latin
  /// numbers, etc. all pass). Synonymous with a Python `ID_START` identifier. See PEP 3131 for details.
  ///
  /// ### python source
  /// ```py
  /// def is_id_start(s: str) -> bool:
  ///     """
  ///     Checks if all characters in `s` are alphabetic characters (Unicode standard, so diacritics, indian vowels, non-latin
  ///     numbers, etc. all pass). Synonymous with a Python `ID_START` identifier. See PEP 3131 for details.
  ///     """
  ///     return _test_unicode_category(s, _ID_START)
  /// ```
  bool is_id_start({
    required String s,
  }) =>
      getFunction("is_id_start").call(
        <Object?>[
          s,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## isascii
  ///
  /// ### python docstring
  ///
  /// str.isascii only exists in python3.7+
  ///
  /// ### python source
  /// ```py
  /// def isascii(s: str) -> bool:
  ///     """ str.isascii only exists in python3.7+ """
  ///     if sys.version_info >= (3, 7):
  ///         return s.isascii()
  ///     else:
  ///         try:
  ///             s.encode('ascii')
  ///             return True
  ///         except (UnicodeDecodeError, UnicodeEncodeError):
  ///             return False
  /// ```
  bool isascii({
    required String s,
  }) =>
      getFunction("isascii").call(
        <Object?>[
          s,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## small_factors
  ///
  /// ### python docstring
  ///
  /// Splits n up into smaller factors and summands <= max_factor.
  /// Returns a list of [(a, b), ...]
  /// so that the following code returns n:
  ///
  /// n = 1
  /// for a, b in values:
  ///     n = n * a + b
  ///
  /// Currently, we also keep a + b <= max_factor, but that might change
  ///
  /// ### python source
  /// ```py
  /// def small_factors(n: int, max_factor: int) -> List[Tuple[int, int]]:
  ///     """
  ///     Splits n up into smaller factors and summands <= max_factor.
  ///     Returns a list of [(a, b), ...]
  ///     so that the following code returns n:
  ///
  ///     n = 1
  ///     for a, b in values:
  ///         n = n * a + b
  ///
  ///     Currently, we also keep a + b <= max_factor, but that might change
  ///     """
  ///     assert n >= 0
  ///     assert max_factor > 2
  ///     if n <= max_factor:
  ///         return [(n, 0)]
  ///
  ///     for a in range(max_factor, 1, -1):
  ///         r, b = divmod(n, a)
  ///         if a + b <= max_factor:
  ///             return small_factors(r, max_factor) + [(a, b)]
  ///     assert False, "Failed to factorize %s" % n
  /// ```
  Object? small_factors({
    required int n,
    required int max_factor,
  }) =>
      getFunction("small_factors").call(
        <Object?>[
          n,
          max_factor,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## sys
  sys get $sys => sys.import();

  /// ## unicodedata
  unicodedata get $unicodedata => unicodedata.import();

  /// ## NO_VALUE (getter)
  Object? get NO_VALUE => getAttribute("NO_VALUE");

  /// ## NO_VALUE (setter)
  set NO_VALUE(Object? NO_VALUE) => setAttribute("NO_VALUE", NO_VALUE);

  /// ## T (getter)
  Object? get T => getAttribute("T");

  /// ## T (setter)
  set T(Object? T) => setAttribute("T", T);

  /// ## categ_pattern (getter)
  Object? get categ_pattern => getAttribute("categ_pattern");

  /// ## categ_pattern (setter)
  set categ_pattern(Object? categ_pattern) =>
      setAttribute("categ_pattern", categ_pattern);

  /// ## logger (getter)
  Object? get logger => getAttribute("logger");

  /// ## logger (setter)
  set logger(Object? logger) => setAttribute("logger", logger);

  /// ## Callable (getter)
  Object? get Callable => getAttribute("Callable");

  /// ## Callable (setter)
  set Callable(Object? Callable) => setAttribute("Callable", Callable);

  /// ## Dict (getter)
  Object? get Dict => getAttribute("Dict");

  /// ## Dict (setter)
  set Dict(Object? Dict) => setAttribute("Dict", Dict);

  /// ## Iterable (getter)
  Object? get $Iterable => getAttribute("Iterable");

  /// ## Iterable (setter)
  set $Iterable(Object? $Iterable) => setAttribute("Iterable", $Iterable);

  /// ## Iterator (getter)
  Object? get $Iterator => getAttribute("Iterator");

  /// ## Iterator (setter)
  set $Iterator(Object? $Iterator) => setAttribute("Iterator", $Iterator);

  /// ## List (getter)
  Object? get $List => getAttribute("List");

  /// ## List (setter)
  set $List(Object? $List) => setAttribute("List", $List);

  /// ## Optional (getter)
  Object? get Optional => getAttribute("Optional");

  /// ## Optional (setter)
  set Optional(Object? Optional) => setAttribute("Optional", Optional);

  /// ## Sequence (getter)
  Object? get Sequence => getAttribute("Sequence");

  /// ## Sequence (setter)
  set Sequence(Object? Sequence) => setAttribute("Sequence", Sequence);

  /// ## Tuple (getter)
  Object? get Tuple => getAttribute("Tuple");

  /// ## Tuple (setter)
  set Tuple(Object? Tuple) => setAttribute("Tuple", Tuple);

  /// ## Type (getter)
  Object? get Type => getAttribute("Type");

  /// ## Type (setter)
  set Type(Object? Type) => setAttribute("Type", Type);

  /// ## Union (getter)
  Object? get Union => getAttribute("Union");

  /// ## Union (setter)
  set Union(Object? Union) => setAttribute("Union", Union);
}

/// ## sys
final class sys extends PythonModule {
  sys.from(super.pythonModule) : super.from();

  static sys import() => PythonFfiDart.instance.importModule(
        "lark.sys",
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

/// ## unicodedata
final class unicodedata extends PythonModule {
  unicodedata.from(super.pythonModule) : super.from();

  static unicodedata import() => PythonFfiDart.instance.importModule(
        "lark.unicodedata",
        unicodedata.from,
      );

  /// ## unidata_version (getter)
  Object? get unidata_version => getAttribute("unidata_version");

  /// ## unidata_version (setter)
  set unidata_version(Object? unidata_version) =>
      setAttribute("unidata_version", unidata_version);
}
