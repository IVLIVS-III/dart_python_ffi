// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library common;


import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## LexerConf
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
/// class LexerConf(Serialize):
///     __serialize_fields__ = 'terminals', 'ignore', 'g_regex_flags', 'use_bytes', 'lexer_type'
///     __serialize_namespace__ = TerminalDef,
/// 
///     terminals: Collection[TerminalDef]
///     re_module: ModuleType
///     ignore: Collection[str]
///     postlex: 'Optional[PostLex]'
///     callbacks: Dict[str, _Callback]
///     g_regex_flags: int
///     skip_validation: bool
///     use_bytes: bool
///     lexer_type: Optional[_LexerArgType]
///     strict: bool
/// 
///     def __init__(self, terminals: Collection[TerminalDef], re_module: ModuleType, ignore: Collection[str]=(), postlex: 'Optional[PostLex]'=None,
///                  callbacks: Optional[Dict[str, _Callback]]=None, g_regex_flags: int=0, skip_validation: bool=False, use_bytes: bool=False, strict: bool=False):
///         self.terminals = terminals
///         self.terminals_by_name = {t.name: t for t in self.terminals}
///         assert len(self.terminals) == len(self.terminals_by_name)
///         self.ignore = ignore
///         self.postlex = postlex
///         self.callbacks = callbacks or {}
///         self.g_regex_flags = g_regex_flags
///         self.re_module = re_module
///         self.skip_validation = skip_validation
///         self.use_bytes = use_bytes
///         self.strict = strict
///         self.lexer_type = None
/// 
///     def _deserialize(self):
///         self.terminals_by_name = {t.name: t for t in self.terminals}
/// 
///     def __deepcopy__(self, memo=None):
///         return type(self)(
///             deepcopy(self.terminals, memo),
///             self.re_module,
///             deepcopy(self.ignore, memo),
///             deepcopy(self.postlex, memo),
///             deepcopy(self.callbacks, memo),
///             deepcopy(self.g_regex_flags, memo),
///             deepcopy(self.skip_validation, memo),
///             deepcopy(self.use_bytes, memo),
///         )
/// ```
final class LexerConf extends PythonClass {
  factory LexerConf(
{required Object? terminals ,
required ModuleType re_module ,
 Object? ignore = const [],
 Object? postlex ,
 Object? callbacks ,
 int g_regex_flags = 0,
 bool skip_validation = false,
 bool use_bytes = false,
 bool strict = false,
}    ) =>
      PythonFfiDart.instance.importClass(
        "lark.common",
        "LexerConf",
        LexerConf.from,
<Object?>[
terminals,
re_module,
ignore,
postlex,
callbacks,
g_regex_flags,
skip_validation,
use_bytes,
strict,
],
<String, Object?>{
},
      );

  LexerConf.from(super.pythonClass) : super.from();

/// ## memo_serialize
///
/// ### python source
/// ```py
/// def memo_serialize(self, types_to_memoize: List) -> Any:
///         memo = SerializeMemoizer(types_to_memoize)
///         return self.serialize(memo), memo.serialize()
/// ```
Object? memo_serialize(
{required Object? types_to_memoize ,
}) => 
getFunction("memo_serialize").call(
<Object?>[
types_to_memoize,
],
kwargs: <String, Object?>{
},
)
;/// ## serialize
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
Object? serialize(
{ Object? memo ,
}) => 
getFunction("serialize").call(
<Object?>[
memo,
],
kwargs: <String, Object?>{
},
)
;/// ## deserialize (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get deserialize => 
getAttribute("deserialize");

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
set deserialize(Object? deserialize)
  => setAttribute("deserialize", deserialize);

/// ## terminals (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get terminals => 
getAttribute("terminals");

/// ## terminals (setter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
set terminals(Object? terminals)
  => setAttribute("terminals", terminals);

/// ## terminals_by_name (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get terminals_by_name => 
getAttribute("terminals_by_name");

/// ## terminals_by_name (setter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
set terminals_by_name(Object? terminals_by_name)
  => setAttribute("terminals_by_name", terminals_by_name);

/// ## ignore (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get ignore => 
getAttribute("ignore");

/// ## ignore (setter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
set ignore(Object? ignore)
  => setAttribute("ignore", ignore);

/// ## postlex (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get postlex => 
getAttribute("postlex");

/// ## postlex (setter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
set postlex(Object? postlex)
  => setAttribute("postlex", postlex);

/// ## callbacks (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get callbacks => 
getAttribute("callbacks");

/// ## callbacks (setter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
set callbacks(Object? callbacks)
  => setAttribute("callbacks", callbacks);

/// ## g_regex_flags (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get g_regex_flags => 
getAttribute("g_regex_flags");

/// ## g_regex_flags (setter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
set g_regex_flags(Object? g_regex_flags)
  => setAttribute("g_regex_flags", g_regex_flags);

/// ## re_module (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get re_module => 
getAttribute("re_module");

/// ## re_module (setter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
set re_module(Object? re_module)
  => setAttribute("re_module", re_module);

/// ## skip_validation (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get skip_validation => 
getAttribute("skip_validation");

/// ## skip_validation (setter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
set skip_validation(Object? skip_validation)
  => setAttribute("skip_validation", skip_validation);

/// ## use_bytes (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get use_bytes => 
getAttribute("use_bytes");

/// ## use_bytes (setter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
set use_bytes(Object? use_bytes)
  => setAttribute("use_bytes", use_bytes);

/// ## strict (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get strict => 
getAttribute("strict");

/// ## strict (setter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
set strict(Object? strict)
  => setAttribute("strict", strict);

/// ## lexer_type (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get lexer_type => 
getAttribute("lexer_type");

/// ## lexer_type (setter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
set lexer_type(Object? lexer_type)
  => setAttribute("lexer_type", lexer_type);

}
/// ## ModuleType
final class ModuleType extends PythonClass {
  factory ModuleType(
    ) =>
      PythonFfiDart.instance.importClass(
        "lark.common",
        "ModuleType",
        ModuleType.from,
<Object?>[],
      );

  ModuleType.from(super.pythonClass) : super.from();

}
/// ## ParserConf
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
/// class ParserConf(Serialize):
///     __serialize_fields__ = 'rules', 'start', 'parser_type'
/// 
///     def __init__(self, rules, callbacks, start):
///         assert isinstance(start, list)
///         self.rules = rules
///         self.callbacks = callbacks
///         self.start = start
/// 
///         self.parser_type = None
/// ```
final class ParserConf extends PythonClass {
  factory ParserConf(
{required Object? rules ,
required Object? callbacks ,
required Object? start ,
}    ) =>
      PythonFfiDart.instance.importClass(
        "lark.common",
        "ParserConf",
        ParserConf.from,
<Object?>[
rules,
callbacks,
start,
],
<String, Object?>{
},
      );

  ParserConf.from(super.pythonClass) : super.from();

/// ## memo_serialize
///
/// ### python source
/// ```py
/// def memo_serialize(self, types_to_memoize: List) -> Any:
///         memo = SerializeMemoizer(types_to_memoize)
///         return self.serialize(memo), memo.serialize()
/// ```
Object? memo_serialize(
{required Object? types_to_memoize ,
}) => 
getFunction("memo_serialize").call(
<Object?>[
types_to_memoize,
],
kwargs: <String, Object?>{
},
)
;/// ## serialize
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
Object? serialize(
{ Object? memo ,
}) => 
getFunction("serialize").call(
<Object?>[
memo,
],
kwargs: <String, Object?>{
},
)
;/// ## deserialize (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get deserialize => 
getAttribute("deserialize");

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
set deserialize(Object? deserialize)
  => setAttribute("deserialize", deserialize);

/// ## rules (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get rules => 
getAttribute("rules");

/// ## rules (setter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
set rules(Object? rules)
  => setAttribute("rules", rules);

/// ## callbacks (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get callbacks => 
getAttribute("callbacks");

/// ## callbacks (setter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
set callbacks(Object? callbacks)
  => setAttribute("callbacks", callbacks);

/// ## start (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get start => 
getAttribute("start");

/// ## start (setter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
set start(Object? start)
  => setAttribute("start", start);

/// ## parser_type (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get parser_type => 
getAttribute("parser_type");

/// ## parser_type (setter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
set parser_type(Object? parser_type)
  => setAttribute("parser_type", parser_type);

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
  factory Serialize(
    ) =>
      PythonFfiDart.instance.importClass(
        "lark.common",
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
Object? memo_serialize(
{required Object? types_to_memoize ,
}) => 
getFunction("memo_serialize").call(
<Object?>[
types_to_memoize,
],
kwargs: <String, Object?>{
},
)
;/// ## serialize
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
Object? serialize(
{ Object? memo ,
}) => 
getFunction("serialize").call(
<Object?>[
memo,
],
kwargs: <String, Object?>{
},
)
;/// ## deserialize (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get deserialize => 
getAttribute("deserialize");

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
set deserialize(Object? deserialize)
  => setAttribute("deserialize", deserialize);

}
/// ## TerminalDef
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
/// class TerminalDef(Serialize):
///     __serialize_fields__ = 'name', 'pattern', 'priority'
///     __serialize_namespace__ = PatternStr, PatternRE
/// 
///     name: str
///     pattern: Pattern
///     priority: int
/// 
///     def __init__(self, name: str, pattern: Pattern, priority: int = TOKEN_DEFAULT_PRIORITY) -> None:
///         assert isinstance(pattern, Pattern), pattern
///         self.name = name
///         self.pattern = pattern
///         self.priority = priority
/// 
///     def __repr__(self):
///         return '%s(%r, %r)' % (type(self).__name__, self.name, self.pattern)
/// 
///     def user_repr(self) -> str:
///         if self.name.startswith('__'):  # We represent a generated terminal
///             return self.pattern.raw or self.name
///         else:
///             return self.name
/// ```
final class TerminalDef extends PythonClass {
  factory TerminalDef(
{required String name ,
required Object? pattern ,
 int priority = 0,
}    ) =>
      PythonFfiDart.instance.importClass(
        "lark.common",
        "TerminalDef",
        TerminalDef.from,
<Object?>[
name,
pattern,
priority,
],
<String, Object?>{
},
      );

  TerminalDef.from(super.pythonClass) : super.from();

/// ## memo_serialize
///
/// ### python source
/// ```py
/// def memo_serialize(self, types_to_memoize: List) -> Any:
///         memo = SerializeMemoizer(types_to_memoize)
///         return self.serialize(memo), memo.serialize()
/// ```
Object? memo_serialize(
{required Object? types_to_memoize ,
}) => 
getFunction("memo_serialize").call(
<Object?>[
types_to_memoize,
],
kwargs: <String, Object?>{
},
)
;/// ## serialize
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
Object? serialize(
{ Object? memo ,
}) => 
getFunction("serialize").call(
<Object?>[
memo,
],
kwargs: <String, Object?>{
},
)
;/// ## user_repr
///
/// ### python source
/// ```py
/// def user_repr(self) -> str:
///         if self.name.startswith('__'):  # We represent a generated terminal
///             return self.pattern.raw or self.name
///         else:
///             return self.name
/// ```
String user_repr(
) => 
getFunction("user_repr").call(
<Object?>[
],
kwargs: <String, Object?>{
},
)
;/// ## deserialize (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get deserialize => 
getAttribute("deserialize");

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
set deserialize(Object? deserialize)
  => setAttribute("deserialize", deserialize);

/// ## name (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get name => 
getAttribute("name");

/// ## name (setter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
set name(Object? name)
  => setAttribute("name", name);

/// ## pattern (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get pattern => 
getAttribute("pattern");

/// ## pattern (setter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
set pattern(Object? pattern)
  => setAttribute("pattern", pattern);

/// ## priority (getter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
Object? get priority => 
getAttribute("priority");

/// ## priority (setter)
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
/// 
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
set priority(Object? priority)
  => setAttribute("priority", priority);

}
/// ## Token
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
///
/// ### python source
/// ```py
/// class Token(str):
///     """A string with meta-information, that is produced by the lexer.
/// 
///     When parsing text, the resulting chunks of the input that haven't been discarded,
///     will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
///     so normal string comparisons and operations will work as expected.
/// 
///     Attributes:
///         type: Name of the token (as specified in grammar)
///         value: Value of the token (redundant, as ``token.value == token`` will always be true)
///         start_pos: The index of the token in the text
///         line: The line of the token in the text (starting with 1)
///         column: The column of the token in the text (starting with 1)
///         end_line: The line where the token ends
///         end_column: The next column after the end of the token. For example,
///             if the token is a single character with a column value of 4,
///             end_column will be 5.
///         end_pos: the index where the token ends (basically ``start_pos + len(token)``)
///     """
///     __slots__ = ('type', 'start_pos', 'value', 'line', 'column', 'end_line', 'end_column', 'end_pos')
/// 
///     __match_args__ = ('type', 'value')
/// 
///     type: str
///     start_pos: Optional[int]
///     value: Any
///     line: Optional[int]
///     column: Optional[int]
///     end_line: Optional[int]
///     end_column: Optional[int]
///     end_pos: Optional[int]
/// 
/// 
///     @overload
///     def __new__(
///             cls,
///             type: str,
///             value: Any,
///             start_pos: Optional[int] = None,
///             line: Optional[int] = None,
///             column: Optional[int] = None,
///             end_line: Optional[int] = None,
///             end_column: Optional[int] = None,
///             end_pos: Optional[int] = None
///     ) -> 'Token':
///         ...
/// 
///     @overload
///     def __new__(
///             cls,
///             type_: str,
///             value: Any,
///             start_pos: Optional[int] = None,
///             line: Optional[int] = None,
///             column: Optional[int] = None,
///             end_line: Optional[int] = None,
///             end_column: Optional[int] = None,
///             end_pos: Optional[int] = None
///     ) -> 'Token':        ...
/// 
///     def __new__(cls, *args, **kwargs):
///         if "type_" in kwargs:
///             warnings.warn("`type_` is deprecated use `type` instead", DeprecationWarning)
/// 
///             if "type" in kwargs:
///                 raise TypeError("Error: using both 'type' and the deprecated 'type_' as arguments.")
///             kwargs["type"] = kwargs.pop("type_")
/// 
///         return cls._future_new(*args, **kwargs)
/// 
/// 
///     @classmethod
///     def _future_new(cls, type, value, start_pos=None, line=None, column=None, end_line=None, end_column=None, end_pos=None):
///         inst = super(Token, cls).__new__(cls, value)
/// 
///         inst.type = type
///         inst.start_pos = start_pos
///         inst.value = value
///         inst.line = line
///         inst.column = column
///         inst.end_line = end_line
///         inst.end_column = end_column
///         inst.end_pos = end_pos
///         return inst
/// 
///     @overload
///     def update(self, type: Optional[str] = None, value: Optional[Any] = None) -> 'Token':
///         ...
/// 
///     @overload
///     def update(self, type_: Optional[str] = None, value: Optional[Any] = None) -> 'Token':
///         ...
/// 
///     def update(self, *args, **kwargs):
///         if "type_" in kwargs:
///             warnings.warn("`type_` is deprecated use `type` instead", DeprecationWarning)
/// 
///             if "type" in kwargs:
///                 raise TypeError("Error: using both 'type' and the deprecated 'type_' as arguments.")
///             kwargs["type"] = kwargs.pop("type_")
/// 
///         return self._future_update(*args, **kwargs)
/// 
///     def _future_update(self, type: Optional[str] = None, value: Optional[Any] = None) -> 'Token':
///         return Token.new_borrow_pos(
///             type if type is not None else self.type,
///             value if value is not None else self.value,
///             self
///         )
/// 
///     @classmethod
///     def new_borrow_pos(cls: Type[_T], type_: str, value: Any, borrow_t: 'Token') -> _T:
///         return cls(type_, value, borrow_t.start_pos, borrow_t.line, borrow_t.column, borrow_t.end_line, borrow_t.end_column, borrow_t.end_pos)
/// 
///     def __reduce__(self):
///         return (self.__class__, (self.type, self.value, self.start_pos, self.line, self.column))
/// 
///     def __repr__(self):
///         return 'Token(%r, %r)' % (self.type, self.value)
/// 
///     def __deepcopy__(self, memo):
///         return Token(self.type, self.value, self.start_pos, self.line, self.column)
/// 
///     def __eq__(self, other):
///         if isinstance(other, Token) and self.type != other.type:
///             return False
/// 
///         return str.__eq__(self, other)
/// 
///     __hash__ = str.__hash__
/// ```
final class Token extends PythonClass {
  factory Token(
    ) =>
      PythonFfiDart.instance.importClass(
        "lark.common",
        "Token",
        Token.from,
<Object?>[],
      );

  Token.from(super.pythonClass) : super.from();

/// ## update
///
/// ### python source
/// ```py
/// def update(self, *args, **kwargs):
///         if "type_" in kwargs:
///             warnings.warn("`type_` is deprecated use `type` instead", DeprecationWarning)
/// 
///             if "type" in kwargs:
///                 raise TypeError("Error: using both 'type' and the deprecated 'type_' as arguments.")
///             kwargs["type"] = kwargs.pop("type_")
/// 
///         return self._future_update(*args, **kwargs)
/// ```
Object? update(
{List<Object?> args = const <Object?>[],
Map<String, Object?> kwargs = const <String, Object?>{},
}) => 
getFunction("update").call(
<Object?>[
...args,
],
kwargs: <String, Object?>{
...kwargs,
},
)
;/// ## column (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get column => 
getAttribute("column");

/// ## column (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set column(Object? column)
  => setAttribute("column", column);

/// ## end_column (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get end_column => 
getAttribute("end_column");

/// ## end_column (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set end_column(Object? end_column)
  => setAttribute("end_column", end_column);

/// ## end_line (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get end_line => 
getAttribute("end_line");

/// ## end_line (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set end_line(Object? end_line)
  => setAttribute("end_line", end_line);

/// ## end_pos (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get end_pos => 
getAttribute("end_pos");

/// ## end_pos (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set end_pos(Object? end_pos)
  => setAttribute("end_pos", end_pos);

/// ## line (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get line => 
getAttribute("line");

/// ## line (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set line(Object? line)
  => setAttribute("line", line);

/// ## start_pos (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get start_pos => 
getAttribute("start_pos");

/// ## start_pos (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set start_pos(Object? start_pos)
  => setAttribute("start_pos", start_pos);

/// ## type (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get type => 
getAttribute("type");

/// ## type (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set type(Object? type)
  => setAttribute("type", type);

/// ## value (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get value => 
getAttribute("value");

/// ## value (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set value(Object? value)
  => setAttribute("value", value);

/// ## capitalize (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get capitalize => 
getAttribute("capitalize");

/// ## capitalize (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set capitalize(Object? capitalize)
  => setAttribute("capitalize", capitalize);

/// ## casefold (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get casefold => 
getAttribute("casefold");

/// ## casefold (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set casefold(Object? casefold)
  => setAttribute("casefold", casefold);

/// ## center (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get center => 
getAttribute("center");

/// ## center (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set center(Object? center)
  => setAttribute("center", center);

/// ## count (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get count => 
getAttribute("count");

/// ## count (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set count(Object? count)
  => setAttribute("count", count);

/// ## encode (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get encode => 
getAttribute("encode");

/// ## encode (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set encode(Object? encode)
  => setAttribute("encode", encode);

/// ## endswith (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get endswith => 
getAttribute("endswith");

/// ## endswith (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set endswith(Object? endswith)
  => setAttribute("endswith", endswith);

/// ## expandtabs (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get expandtabs => 
getAttribute("expandtabs");

/// ## expandtabs (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set expandtabs(Object? expandtabs)
  => setAttribute("expandtabs", expandtabs);

/// ## find (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get find => 
getAttribute("find");

/// ## find (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set find(Object? find)
  => setAttribute("find", find);

/// ## format (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get format => 
getAttribute("format");

/// ## format (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set format(Object? format)
  => setAttribute("format", format);

/// ## format_map (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get format_map => 
getAttribute("format_map");

/// ## format_map (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set format_map(Object? format_map)
  => setAttribute("format_map", format_map);

/// ## index (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get index => 
getAttribute("index");

/// ## index (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set index(Object? index)
  => setAttribute("index", index);

/// ## isalnum (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get isalnum => 
getAttribute("isalnum");

/// ## isalnum (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set isalnum(Object? isalnum)
  => setAttribute("isalnum", isalnum);

/// ## isalpha (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get isalpha => 
getAttribute("isalpha");

/// ## isalpha (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set isalpha(Object? isalpha)
  => setAttribute("isalpha", isalpha);

/// ## isascii (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get isascii => 
getAttribute("isascii");

/// ## isascii (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set isascii(Object? isascii)
  => setAttribute("isascii", isascii);

/// ## isdecimal (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get isdecimal => 
getAttribute("isdecimal");

/// ## isdecimal (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set isdecimal(Object? isdecimal)
  => setAttribute("isdecimal", isdecimal);

/// ## isdigit (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get isdigit => 
getAttribute("isdigit");

/// ## isdigit (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set isdigit(Object? isdigit)
  => setAttribute("isdigit", isdigit);

/// ## isidentifier (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get isidentifier => 
getAttribute("isidentifier");

/// ## isidentifier (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set isidentifier(Object? isidentifier)
  => setAttribute("isidentifier", isidentifier);

/// ## islower (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get islower => 
getAttribute("islower");

/// ## islower (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set islower(Object? islower)
  => setAttribute("islower", islower);

/// ## isnumeric (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get isnumeric => 
getAttribute("isnumeric");

/// ## isnumeric (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set isnumeric(Object? isnumeric)
  => setAttribute("isnumeric", isnumeric);

/// ## isprintable (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get isprintable => 
getAttribute("isprintable");

/// ## isprintable (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set isprintable(Object? isprintable)
  => setAttribute("isprintable", isprintable);

/// ## isspace (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get isspace => 
getAttribute("isspace");

/// ## isspace (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set isspace(Object? isspace)
  => setAttribute("isspace", isspace);

/// ## istitle (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get istitle => 
getAttribute("istitle");

/// ## istitle (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set istitle(Object? istitle)
  => setAttribute("istitle", istitle);

/// ## isupper (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get isupper => 
getAttribute("isupper");

/// ## isupper (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set isupper(Object? isupper)
  => setAttribute("isupper", isupper);

/// ## join (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get join => 
getAttribute("join");

/// ## join (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set join(Object? join)
  => setAttribute("join", join);

/// ## ljust (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get ljust => 
getAttribute("ljust");

/// ## ljust (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set ljust(Object? ljust)
  => setAttribute("ljust", ljust);

/// ## lower (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get lower => 
getAttribute("lower");

/// ## lower (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set lower(Object? lower)
  => setAttribute("lower", lower);

/// ## lstrip (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get lstrip => 
getAttribute("lstrip");

/// ## lstrip (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set lstrip(Object? lstrip)
  => setAttribute("lstrip", lstrip);

/// ## new_borrow_pos (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get new_borrow_pos => 
getAttribute("new_borrow_pos");

/// ## new_borrow_pos (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set new_borrow_pos(Object? new_borrow_pos)
  => setAttribute("new_borrow_pos", new_borrow_pos);

/// ## partition (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get partition => 
getAttribute("partition");

/// ## partition (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set partition(Object? partition)
  => setAttribute("partition", partition);

/// ## removeprefix (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get removeprefix => 
getAttribute("removeprefix");

/// ## removeprefix (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set removeprefix(Object? removeprefix)
  => setAttribute("removeprefix", removeprefix);

/// ## removesuffix (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get removesuffix => 
getAttribute("removesuffix");

/// ## removesuffix (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set removesuffix(Object? removesuffix)
  => setAttribute("removesuffix", removesuffix);

/// ## replace (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get replace => 
getAttribute("replace");

/// ## replace (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set replace(Object? replace)
  => setAttribute("replace", replace);

/// ## rfind (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get rfind => 
getAttribute("rfind");

/// ## rfind (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set rfind(Object? rfind)
  => setAttribute("rfind", rfind);

/// ## rindex (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get rindex => 
getAttribute("rindex");

/// ## rindex (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set rindex(Object? rindex)
  => setAttribute("rindex", rindex);

/// ## rjust (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get rjust => 
getAttribute("rjust");

/// ## rjust (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set rjust(Object? rjust)
  => setAttribute("rjust", rjust);

/// ## rpartition (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get rpartition => 
getAttribute("rpartition");

/// ## rpartition (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set rpartition(Object? rpartition)
  => setAttribute("rpartition", rpartition);

/// ## rsplit (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get rsplit => 
getAttribute("rsplit");

/// ## rsplit (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set rsplit(Object? rsplit)
  => setAttribute("rsplit", rsplit);

/// ## rstrip (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get rstrip => 
getAttribute("rstrip");

/// ## rstrip (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set rstrip(Object? rstrip)
  => setAttribute("rstrip", rstrip);

/// ## split (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get split => 
getAttribute("split");

/// ## split (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set split(Object? split)
  => setAttribute("split", split);

/// ## splitlines (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get splitlines => 
getAttribute("splitlines");

/// ## splitlines (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set splitlines(Object? splitlines)
  => setAttribute("splitlines", splitlines);

/// ## startswith (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get startswith => 
getAttribute("startswith");

/// ## startswith (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set startswith(Object? startswith)
  => setAttribute("startswith", startswith);

/// ## strip (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get strip => 
getAttribute("strip");

/// ## strip (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set strip(Object? strip)
  => setAttribute("strip", strip);

/// ## swapcase (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get swapcase => 
getAttribute("swapcase");

/// ## swapcase (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set swapcase(Object? swapcase)
  => setAttribute("swapcase", swapcase);

/// ## title (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get title => 
getAttribute("title");

/// ## title (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set title(Object? title)
  => setAttribute("title", title);

/// ## translate (getter)
///
/// ### python docstring
///
/// ±U*   Að~,   að~,   ð~,   ¡ð~,   Áð~,   1},   Q},   q},   },   ±},   Ñ},   ñ},   ¹|   },   1},   Q},   q},   },   ±},   Ñ},   ñ},   },   1},   Q},   q},   },   ±},   Ñ},   ñ},   },   1},   Q},   q},   },   ±},   Ñ},   ñ},    },   1 },   Q },   q },    },   ± },   Ñ },   ñ },   !},   1!},   Q!},   q!},   !},   ±!},   Ñ!},   ñ!},   "},   1"},   Q"},   q"},   "},   ±"},   1Z,   !1Z,   Pºy}  @       1jp)   qjp)   ±jp)   ñjp)   1kp)   qkp)   hp)   Ñhp)   ip)   Qip)   ip)   Ñip)   !fp)   afp)   ¡fp)   áfp)   !gp)   agp)   dp)   Ádp)   ep)   Aep)   ep)   Áep)   ÑIp)   Jp)   QJp)   Jp)   ÑJp)   Kp)   3p)   Ñ3p)   4p)   Q4p)   4p)   Ñ4p)   !p)   ap)   ¡p)   áp)   !p)   ap)   ¡Øg)   áØg)   !Ùg)   aÙg)   ¡Ùg)   áÙg)   Æg)   ÁÆg)   Çg)   AÇg)   Çg)   ÁÇg
Object? get translate => 
getAttribute("translate");

/// ## translate (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set translate(Object? translate)
  => setAttribute("translate", translate);

/// ## upper (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get upper => 
getAttribute("upper");

/// ## upper (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set upper(Object? upper)
  => setAttribute("upper", upper);

/// ## zfill (getter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
Object? get zfill => 
getAttribute("zfill");

/// ## zfill (setter)
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
/// 
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
/// 
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
set zfill(Object? zfill)
  => setAttribute("zfill", zfill);

}
/// ## common
///
/// ### python source
/// ```py
/// from copy import deepcopy
/// import sys
/// from types import ModuleType
/// from typing import Callable, Collection, Dict, Optional, TYPE_CHECKING
/// 
/// if TYPE_CHECKING:
///     from .lark import PostLex
///     from .lexer import Lexer
///     from typing import Union, Type
///     if sys.version_info >= (3, 8):
///         from typing import Literal
///     else:
///         from typing_extensions import Literal
///     if sys.version_info >= (3, 10):
///         from typing import TypeAlias
///     else:
///         from typing_extensions import TypeAlias
/// 
/// from .utils import Serialize
/// from .lexer import TerminalDef, Token
/// 
/// ###{standalone
/// 
/// _ParserArgType: 'TypeAlias' = 'Literal["earley", "lalr", "cyk", "auto"]'
/// _LexerArgType: 'TypeAlias' = 'Union[Literal["auto", "basic", "contextual", "dynamic", "dynamic_complete"], Type[Lexer]]'
/// _Callback = Callable[[Token], Token]
/// 
/// class LexerConf(Serialize):
///     __serialize_fields__ = 'terminals', 'ignore', 'g_regex_flags', 'use_bytes', 'lexer_type'
///     __serialize_namespace__ = TerminalDef,
/// 
///     terminals: Collection[TerminalDef]
///     re_module: ModuleType
///     ignore: Collection[str]
///     postlex: 'Optional[PostLex]'
///     callbacks: Dict[str, _Callback]
///     g_regex_flags: int
///     skip_validation: bool
///     use_bytes: bool
///     lexer_type: Optional[_LexerArgType]
///     strict: bool
/// 
///     def __init__(self, terminals: Collection[TerminalDef], re_module: ModuleType, ignore: Collection[str]=(), postlex: 'Optional[PostLex]'=None,
///                  callbacks: Optional[Dict[str, _Callback]]=None, g_regex_flags: int=0, skip_validation: bool=False, use_bytes: bool=False, strict: bool=False):
///         self.terminals = terminals
///         self.terminals_by_name = {t.name: t for t in self.terminals}
///         assert len(self.terminals) == len(self.terminals_by_name)
///         self.ignore = ignore
///         self.postlex = postlex
///         self.callbacks = callbacks or {}
///         self.g_regex_flags = g_regex_flags
///         self.re_module = re_module
///         self.skip_validation = skip_validation
///         self.use_bytes = use_bytes
///         self.strict = strict
///         self.lexer_type = None
/// 
///     def _deserialize(self):
///         self.terminals_by_name = {t.name: t for t in self.terminals}
/// 
///     def __deepcopy__(self, memo=None):
///         return type(self)(
///             deepcopy(self.terminals, memo),
///             self.re_module,
///             deepcopy(self.ignore, memo),
///             deepcopy(self.postlex, memo),
///             deepcopy(self.callbacks, memo),
///             deepcopy(self.g_regex_flags, memo),
///             deepcopy(self.skip_validation, memo),
///             deepcopy(self.use_bytes, memo),
///         )
/// 
/// 
/// class ParserConf(Serialize):
///     __serialize_fields__ = 'rules', 'start', 'parser_type'
/// 
///     def __init__(self, rules, callbacks, start):
///         assert isinstance(start, list)
///         self.rules = rules
///         self.callbacks = callbacks
///         self.start = start
/// 
///         self.parser_type = None
/// 
/// ###}
/// ```
final class common extends PythonModule {
  common.from(super.pythonModule) : super.from();
  
  static common import() => PythonFfiDart.instance
      .importModule("lark.common", common.from,);

/// ## sys
sys get $sys => sys.import();
/// ## Callable (getter)
Object? get Callable => 
getAttribute("Callable");

/// ## Callable (setter)
set Callable(Object? Callable)
  => setAttribute("Callable", Callable);

/// ## Collection (getter)
Object? get Collection => 
getAttribute("Collection");

/// ## Collection (setter)
set Collection(Object? Collection)
  => setAttribute("Collection", Collection);

/// ## Dict (getter)
Object? get Dict => 
getAttribute("Dict");

/// ## Dict (setter)
set Dict(Object? Dict)
  => setAttribute("Dict", Dict);

/// ## Optional (getter)
Object? get Optional => 
getAttribute("Optional");

/// ## Optional (setter)
set Optional(Object? Optional)
  => setAttribute("Optional", Optional);

/// ## TYPE_CHECKING (getter)
Object? get TYPE_CHECKING => 
getAttribute("TYPE_CHECKING");

/// ## TYPE_CHECKING (setter)
set TYPE_CHECKING(Object? TYPE_CHECKING)
  => setAttribute("TYPE_CHECKING", TYPE_CHECKING);

}
/// ## sys
final class sys extends PythonModule {
  sys.from(super.pythonModule) : super.from();
  
  static sys import() => PythonFfiDart.instance
      .importModule("lark.sys", sys.from,);

/// ## abiflags (getter)
Object? get abiflags => 
getAttribute("abiflags");

/// ## abiflags (setter)
set abiflags(Object? abiflags)
  => setAttribute("abiflags", abiflags);

/// ## api_version (getter)
Object? get api_version => 
getAttribute("api_version");

/// ## api_version (setter)
set api_version(Object? api_version)
  => setAttribute("api_version", api_version);

/// ## argv (getter)
Object? get argv => 
getAttribute("argv");

/// ## argv (setter)
set argv(Object? argv)
  => setAttribute("argv", argv);

/// ## base_exec_prefix (getter)
Object? get base_exec_prefix => 
getAttribute("base_exec_prefix");

/// ## base_exec_prefix (setter)
set base_exec_prefix(Object? base_exec_prefix)
  => setAttribute("base_exec_prefix", base_exec_prefix);

/// ## base_prefix (getter)
Object? get base_prefix => 
getAttribute("base_prefix");

/// ## base_prefix (setter)
set base_prefix(Object? base_prefix)
  => setAttribute("base_prefix", base_prefix);

/// ## builtin_module_names (getter)
Object? get builtin_module_names => 
getAttribute("builtin_module_names");

/// ## builtin_module_names (setter)
set builtin_module_names(Object? builtin_module_names)
  => setAttribute("builtin_module_names", builtin_module_names);

/// ## byteorder (getter)
Object? get byteorder => 
getAttribute("byteorder");

/// ## byteorder (setter)
set byteorder(Object? byteorder)
  => setAttribute("byteorder", byteorder);

/// ## copyright (getter)
Object? get copyright => 
getAttribute("copyright");

/// ## copyright (setter)
set copyright(Object? copyright)
  => setAttribute("copyright", copyright);

/// ## dont_write_bytecode (getter)
Object? get dont_write_bytecode => 
getAttribute("dont_write_bytecode");

/// ## dont_write_bytecode (setter)
set dont_write_bytecode(Object? dont_write_bytecode)
  => setAttribute("dont_write_bytecode", dont_write_bytecode);

/// ## exec_prefix (getter)
Object? get exec_prefix => 
getAttribute("exec_prefix");

/// ## exec_prefix (setter)
set exec_prefix(Object? exec_prefix)
  => setAttribute("exec_prefix", exec_prefix);

/// ## executable (getter)
Object? get executable => 
getAttribute("executable");

/// ## executable (setter)
set executable(Object? executable)
  => setAttribute("executable", executable);

/// ## flags (getter)
Object? get flags => 
getAttribute("flags");

/// ## flags (setter)
set flags(Object? flags)
  => setAttribute("flags", flags);

/// ## float_info (getter)
Object? get float_info => 
getAttribute("float_info");

/// ## float_info (setter)
set float_info(Object? float_info)
  => setAttribute("float_info", float_info);

/// ## float_repr_style (getter)
Object? get float_repr_style => 
getAttribute("float_repr_style");

/// ## float_repr_style (setter)
set float_repr_style(Object? float_repr_style)
  => setAttribute("float_repr_style", float_repr_style);

/// ## hash_info (getter)
Object? get hash_info => 
getAttribute("hash_info");

/// ## hash_info (setter)
set hash_info(Object? hash_info)
  => setAttribute("hash_info", hash_info);

/// ## hexversion (getter)
Object? get hexversion => 
getAttribute("hexversion");

/// ## hexversion (setter)
set hexversion(Object? hexversion)
  => setAttribute("hexversion", hexversion);

/// ## int_info (getter)
Object? get int_info => 
getAttribute("int_info");

/// ## int_info (setter)
set int_info(Object? int_info)
  => setAttribute("int_info", int_info);

/// ## maxsize (getter)
Object? get maxsize => 
getAttribute("maxsize");

/// ## maxsize (setter)
set maxsize(Object? maxsize)
  => setAttribute("maxsize", maxsize);

/// ## maxunicode (getter)
Object? get maxunicode => 
getAttribute("maxunicode");

/// ## maxunicode (setter)
set maxunicode(Object? maxunicode)
  => setAttribute("maxunicode", maxunicode);

/// ## meta_path (getter)
Object? get meta_path => 
getAttribute("meta_path");

/// ## meta_path (setter)
set meta_path(Object? meta_path)
  => setAttribute("meta_path", meta_path);

/// ## modules (getter)
Object? get modules => 
getAttribute("modules");

/// ## modules (setter)
set modules(Object? modules)
  => setAttribute("modules", modules);

/// ## orig_argv (getter)
Object? get orig_argv => 
getAttribute("orig_argv");

/// ## orig_argv (setter)
set orig_argv(Object? orig_argv)
  => setAttribute("orig_argv", orig_argv);

/// ## path (getter)
Object? get path => 
getAttribute("path");

/// ## path (setter)
set path(Object? path)
  => setAttribute("path", path);

/// ## path_hooks (getter)
Object? get path_hooks => 
getAttribute("path_hooks");

/// ## path_hooks (setter)
set path_hooks(Object? path_hooks)
  => setAttribute("path_hooks", path_hooks);

/// ## path_importer_cache (getter)
Object? get path_importer_cache => 
getAttribute("path_importer_cache");

/// ## path_importer_cache (setter)
set path_importer_cache(Object? path_importer_cache)
  => setAttribute("path_importer_cache", path_importer_cache);

/// ## platform (getter)
Object? get $platform => 
getAttribute("platform");

/// ## platform (setter)
set $platform(Object? $platform)
  => setAttribute("platform", $platform);

/// ## platlibdir (getter)
Object? get platlibdir => 
getAttribute("platlibdir");

/// ## platlibdir (setter)
set platlibdir(Object? platlibdir)
  => setAttribute("platlibdir", platlibdir);

/// ## prefix (getter)
Object? get prefix => 
getAttribute("prefix");

/// ## prefix (setter)
set prefix(Object? prefix)
  => setAttribute("prefix", prefix);

/// ## pycache_prefix (getter)
Null get pycache_prefix => 
getAttribute("pycache_prefix");

/// ## pycache_prefix (setter)
set pycache_prefix(Null pycache_prefix)
  => setAttribute("pycache_prefix", pycache_prefix);

/// ## thread_info (getter)
Object? get thread_info => 
getAttribute("thread_info");

/// ## thread_info (setter)
set thread_info(Object? thread_info)
  => setAttribute("thread_info", thread_info);

/// ## version (getter)
Object? get version => 
getAttribute("version");

/// ## version (setter)
set version(Object? version)
  => setAttribute("version", version);

/// ## version_info (getter)
Object? get version_info => 
getAttribute("version_info");

/// ## version_info (setter)
set version_info(Object? version_info)
  => setAttribute("version_info", version_info);

/// ## warnoptions (getter)
Object? get warnoptions => 
getAttribute("warnoptions");

/// ## warnoptions (setter)
set warnoptions(Object? warnoptions)
  => setAttribute("warnoptions", warnoptions);

}
