// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library tree_matcher;

import "package:python_ffi/python_ffi.dart";

/// ## ChildrenLexer
///
/// ### python source
/// ```py
/// class ChildrenLexer:
///     def __init__(self, children):
///         self.children = children
///
///     def lex(self, parser_state):
///         return self.children
/// ```
final class ChildrenLexer extends PythonClass {
  factory ChildrenLexer({
    required Object? children,
  }) =>
      PythonFfi.instance.importClass(
        "lark.tree_matcher",
        "ChildrenLexer",
        ChildrenLexer.from,
        <Object?>[
          children,
        ],
        <String, Object?>{},
      );

  ChildrenLexer.from(super.pythonClass) : super.from();

  /// ## lex
  ///
  /// ### python source
  /// ```py
  /// def lex(self, parser_state):
  ///         return self.children
  /// ```
  Object? lex({
    required Object? parser_state,
  }) =>
      getFunction("lex").call(
        <Object?>[
          parser_state,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## children (getter)
  Object? get children => getAttribute("children");

  /// ## children (setter)
  set children(Object? children) => setAttribute("children", children);
}

/// ## NonTerminal
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
/// class NonTerminal(Symbol):
///     __serialize_fields__ = 'name',
///
///     is_term: ClassVar[bool] = False
/// ```
final class NonTerminal extends PythonClass {
  factory NonTerminal({
    required String name,
  }) =>
      PythonFfi.instance.importClass(
        "lark.tree_matcher",
        "NonTerminal",
        NonTerminal.from,
        <Object?>[
          name,
        ],
        <String, Object?>{},
      );

  NonTerminal.from(super.pythonClass) : super.from();

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

  /// ## renamed
  ///
  /// ### python source
  /// ```py
  /// def renamed(self, f):
  ///         return type(self)(f(self.name))
  /// ```
  Object? renamed({
    required Object? f,
  }) =>
      getFunction("renamed").call(
        <Object?>[
          f,
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

  /// ## fullrepr (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get fullrepr => getAttribute("fullrepr");

  /// ## fullrepr (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set fullrepr(Object? fullrepr) => setAttribute("fullrepr", fullrepr);

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

  /// ## is_term (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get is_term => getAttribute("is_term");

  /// ## is_term (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set is_term(Object? is_term) => setAttribute("is_term", is_term);

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
  Object? get name => getAttribute("name");

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
  set name(Object? name) => setAttribute("name", name);
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
  factory ParserConf({
    required Object? rules,
    required Object? callbacks,
    required Object? start,
  }) =>
      PythonFfi.instance.importClass(
        "lark.tree_matcher",
        "ParserConf",
        ParserConf.from,
        <Object?>[
          rules,
          callbacks,
          start,
        ],
        <String, Object?>{},
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
  Object? get rules => getAttribute("rules");

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
  set rules(Object? rules) => setAttribute("rules", rules);

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
  Object? get callbacks => getAttribute("callbacks");

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
  set callbacks(Object? callbacks) => setAttribute("callbacks", callbacks);

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
  Object? get start => getAttribute("start");

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
  set start(Object? start) => setAttribute("start", start);

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
  Object? get parser_type => getAttribute("parser_type");

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
  set parser_type(Object? parser_type) =>
      setAttribute("parser_type", parser_type);
}

/// ## Rule
///
/// ### python docstring
///
/// origin : a symbol
/// expansion : a list of symbols
/// order : index of this expansion amongst all rules of the same name
///
/// ### python source
/// ```py
/// class Rule(Serialize):
///     """
///         origin : a symbol
///         expansion : a list of symbols
///         order : index of this expansion amongst all rules of the same name
///     """
///     __slots__ = ('origin', 'expansion', 'alias', 'options', 'order', '_hash')
///
///     __serialize_fields__ = 'origin', 'expansion', 'order', 'alias', 'options'
///     __serialize_namespace__ = Terminal, NonTerminal, RuleOptions
///
///     def __init__(self, origin, expansion, order=0, alias=None, options=None):
///         self.origin = origin
///         self.expansion = expansion
///         self.alias = alias
///         self.order = order
///         self.options = options or RuleOptions()
///         self._hash = hash((self.origin, tuple(self.expansion)))
///
///     def _deserialize(self):
///         self._hash = hash((self.origin, tuple(self.expansion)))
///
///     def __str__(self):
///         return '<%s : %s>' % (self.origin.name, ' '.join(x.name for x in self.expansion))
///
///     def __repr__(self):
///         return 'Rule(%r, %r, %r, %r)' % (self.origin, self.expansion, self.alias, self.options)
///
///     def __hash__(self):
///         return self._hash
///
///     def __eq__(self, other):
///         if not isinstance(other, Rule):
///             return False
///         return self.origin == other.origin and self.expansion == other.expansion
/// ```
final class Rule extends PythonClass {
  factory Rule({
    required Object? origin,
    required Object? expansion,
    Object? order = 0,
    Object? alias,
    Object? options,
  }) =>
      PythonFfi.instance.importClass(
        "lark.tree_matcher",
        "Rule",
        Rule.from,
        <Object?>[
          origin,
          expansion,
          order,
          alias,
          options,
        ],
        <String, Object?>{},
      );

  Rule.from(super.pythonClass) : super.from();

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
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## alias (getter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  Object? get alias => getAttribute("alias");

  /// ## alias (setter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  set alias(Object? alias) => setAttribute("alias", alias);

  /// ## expansion (getter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  Object? get expansion => getAttribute("expansion");

  /// ## expansion (setter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  set expansion(Object? expansion) => setAttribute("expansion", expansion);

  /// ## options (getter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  Object? get options => getAttribute("options");

  /// ## options (setter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  set options(Object? options) => setAttribute("options", options);

  /// ## order (getter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  Object? get order => getAttribute("order");

  /// ## order (setter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  set order(Object? order) => setAttribute("order", order);

  /// ## origin (getter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  Object? get origin => getAttribute("origin");

  /// ## origin (setter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  set origin(Object? origin) => setAttribute("origin", origin);
}

/// ## Terminal
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
/// class Terminal(Symbol):
///     __serialize_fields__ = 'name', 'filter_out'
///
///     is_term: ClassVar[bool] = True
///
///     def __init__(self, name, filter_out=False):
///         self.name = name
///         self.filter_out = filter_out
///
///     @property
///     def fullrepr(self):
///         return '%s(%r, %r)' % (type(self).__name__, self.name, self.filter_out)
///
///     def renamed(self, f):
///         return type(self)(f(self.name), self.filter_out)
/// ```
final class Terminal extends PythonClass {
  factory Terminal({
    required Object? name,
    Object? filter_out = false,
  }) =>
      PythonFfi.instance.importClass(
        "lark.tree_matcher",
        "Terminal",
        Terminal.from,
        <Object?>[
          name,
          filter_out,
        ],
        <String, Object?>{},
      );

  Terminal.from(super.pythonClass) : super.from();

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

  /// ## renamed
  ///
  /// ### python source
  /// ```py
  /// def renamed(self, f):
  ///         return type(self)(f(self.name), self.filter_out)
  /// ```
  Object? renamed({
    required Object? f,
  }) =>
      getFunction("renamed").call(
        <Object?>[
          f,
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

  /// ## fullrepr (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get fullrepr => getAttribute("fullrepr");

  /// ## fullrepr (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set fullrepr(Object? fullrepr) => setAttribute("fullrepr", fullrepr);

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

  /// ## is_term (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get is_term => getAttribute("is_term");

  /// ## is_term (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set is_term(Object? is_term) => setAttribute("is_term", is_term);

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
  Object? get name => getAttribute("name");

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
  set name(Object? name) => setAttribute("name", name);

  /// ## filter_out (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get filter_out => getAttribute("filter_out");

  /// ## filter_out (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set filter_out(Object? filter_out) => setAttribute("filter_out", filter_out);
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
  factory Token() => PythonFfi.instance.importClass(
        "lark.tree_matcher",
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
  Object? update({
    List<Object?> args = const <Object?>[],
    Map<String, Object?> kwargs = const <String, Object?>{},
  }) =>
      getFunction("update").call(
        <Object?>[
          ...args,
        ],
        kwargs: <String, Object?>{
          ...kwargs,
        },
      );

  /// ## column (getter)
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
  Object? get column => getAttribute("column");

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
  set column(Object? column) => setAttribute("column", column);

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
  Object? get end_column => getAttribute("end_column");

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
  set end_column(Object? end_column) => setAttribute("end_column", end_column);

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
  Object? get end_line => getAttribute("end_line");

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
  set end_line(Object? end_line) => setAttribute("end_line", end_line);

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
  Object? get end_pos => getAttribute("end_pos");

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
  set end_pos(Object? end_pos) => setAttribute("end_pos", end_pos);

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
  Object? get line => getAttribute("line");

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
  set line(Object? line) => setAttribute("line", line);

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
  Object? get start_pos => getAttribute("start_pos");

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
  set start_pos(Object? start_pos) => setAttribute("start_pos", start_pos);

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
  Object? get type => getAttribute("type");

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
  set type(Object? type) => setAttribute("type", type);

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
  Object? get value => getAttribute("value");

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
  set value(Object? value) => setAttribute("value", value);

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
  Object? get capitalize => getAttribute("capitalize");

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
  set capitalize(Object? capitalize) => setAttribute("capitalize", capitalize);

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
  Object? get casefold => getAttribute("casefold");

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
  set casefold(Object? casefold) => setAttribute("casefold", casefold);

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
  Object? get center => getAttribute("center");

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
  set center(Object? center) => setAttribute("center", center);

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
  Object? get count => getAttribute("count");

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
  set count(Object? count) => setAttribute("count", count);

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
  Object? get encode => getAttribute("encode");

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
  set encode(Object? encode) => setAttribute("encode", encode);

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
  Object? get endswith => getAttribute("endswith");

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
  set endswith(Object? endswith) => setAttribute("endswith", endswith);

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
  Object? get expandtabs => getAttribute("expandtabs");

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
  set expandtabs(Object? expandtabs) => setAttribute("expandtabs", expandtabs);

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
  Object? get find => getAttribute("find");

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
  set find(Object? find) => setAttribute("find", find);

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
  Object? get format => getAttribute("format");

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
  set format(Object? format) => setAttribute("format", format);

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
  Object? get format_map => getAttribute("format_map");

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
  set format_map(Object? format_map) => setAttribute("format_map", format_map);

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
  Object? get index => getAttribute("index");

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
  set index(Object? index) => setAttribute("index", index);

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
  Object? get isalnum => getAttribute("isalnum");

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
  set isalnum(Object? isalnum) => setAttribute("isalnum", isalnum);

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
  Object? get isalpha => getAttribute("isalpha");

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
  set isalpha(Object? isalpha) => setAttribute("isalpha", isalpha);

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
  Object? get isascii => getAttribute("isascii");

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
  set isascii(Object? isascii) => setAttribute("isascii", isascii);

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
  Object? get isdecimal => getAttribute("isdecimal");

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
  set isdecimal(Object? isdecimal) => setAttribute("isdecimal", isdecimal);

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
  Object? get isdigit => getAttribute("isdigit");

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
  set isdigit(Object? isdigit) => setAttribute("isdigit", isdigit);

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
  Object? get isidentifier => getAttribute("isidentifier");

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
  set isidentifier(Object? isidentifier) =>
      setAttribute("isidentifier", isidentifier);

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
  Object? get islower => getAttribute("islower");

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
  set islower(Object? islower) => setAttribute("islower", islower);

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
  Object? get isnumeric => getAttribute("isnumeric");

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
  set isnumeric(Object? isnumeric) => setAttribute("isnumeric", isnumeric);

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
  Object? get isprintable => getAttribute("isprintable");

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
  set isprintable(Object? isprintable) =>
      setAttribute("isprintable", isprintable);

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
  Object? get isspace => getAttribute("isspace");

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
  set isspace(Object? isspace) => setAttribute("isspace", isspace);

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
  Object? get istitle => getAttribute("istitle");

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
  set istitle(Object? istitle) => setAttribute("istitle", istitle);

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
  Object? get isupper => getAttribute("isupper");

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
  set isupper(Object? isupper) => setAttribute("isupper", isupper);

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
  Object? get join => getAttribute("join");

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
  set join(Object? join) => setAttribute("join", join);

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
  Object? get ljust => getAttribute("ljust");

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
  set ljust(Object? ljust) => setAttribute("ljust", ljust);

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
  Object? get lower => getAttribute("lower");

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
  set lower(Object? lower) => setAttribute("lower", lower);

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
  Object? get lstrip => getAttribute("lstrip");

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
  set lstrip(Object? lstrip) => setAttribute("lstrip", lstrip);

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
  Object? get new_borrow_pos => getAttribute("new_borrow_pos");

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
  set new_borrow_pos(Object? new_borrow_pos) =>
      setAttribute("new_borrow_pos", new_borrow_pos);

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
  Object? get partition => getAttribute("partition");

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
  set partition(Object? partition) => setAttribute("partition", partition);

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
  Object? get removeprefix => getAttribute("removeprefix");

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
  set removeprefix(Object? removeprefix) =>
      setAttribute("removeprefix", removeprefix);

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
  Object? get removesuffix => getAttribute("removesuffix");

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
  set removesuffix(Object? removesuffix) =>
      setAttribute("removesuffix", removesuffix);

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
  Object? get replace => getAttribute("replace");

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
  set replace(Object? replace) => setAttribute("replace", replace);

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
  Object? get rfind => getAttribute("rfind");

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
  set rfind(Object? rfind) => setAttribute("rfind", rfind);

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
  Object? get rindex => getAttribute("rindex");

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
  set rindex(Object? rindex) => setAttribute("rindex", rindex);

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
  Object? get rjust => getAttribute("rjust");

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
  set rjust(Object? rjust) => setAttribute("rjust", rjust);

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
  Object? get rpartition => getAttribute("rpartition");

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
  set rpartition(Object? rpartition) => setAttribute("rpartition", rpartition);

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
  Object? get rsplit => getAttribute("rsplit");

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
  set rsplit(Object? rsplit) => setAttribute("rsplit", rsplit);

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
  Object? get rstrip => getAttribute("rstrip");

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
  set rstrip(Object? rstrip) => setAttribute("rstrip", rstrip);

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
  Object? get split => getAttribute("split");

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
  set split(Object? split) => setAttribute("split", split);

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
  Object? get splitlines => getAttribute("splitlines");

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
  set splitlines(Object? splitlines) => setAttribute("splitlines", splitlines);

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
  Object? get startswith => getAttribute("startswith");

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
  set startswith(Object? startswith) => setAttribute("startswith", startswith);

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
  Object? get strip => getAttribute("strip");

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
  set strip(Object? strip) => setAttribute("strip", strip);

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
  Object? get swapcase => getAttribute("swapcase");

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
  set swapcase(Object? swapcase) => setAttribute("swapcase", swapcase);

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
  Object? get title => getAttribute("title");

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
  set title(Object? title) => setAttribute("title", title);

  /// ## translate (getter)
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
  Object? get translate => getAttribute("translate");

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
  set translate(Object? translate) => setAttribute("translate", translate);

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
  Object? get upper => getAttribute("upper");

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
  set upper(Object? upper) => setAttribute("upper", upper);

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
  Object? get zfill => getAttribute("zfill");

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
  set zfill(Object? zfill) => setAttribute("zfill", zfill);
}

/// ## Tree
///
/// ### python docstring
///
/// The main tree class.
///
/// Creates a new tree, and stores "data" and "children" in attributes of the same name.
/// Trees can be hashed and compared.
///
/// Parameters:
///     data: The name of the rule or alias
///     children: List of matched sub-rules and terminals
///     meta: Line & Column numbers (if ``propagate_positions`` is enabled).
///         meta attributes: (line, column, end_line, end_column, start_pos, end_pos,
///                           container_line, container_column, container_end_line, container_end_column)
///         container_* attributes consider all symbols, including those that have been inlined in the tree.
///         For example, in the rule 'a: _A B _C', the regular attributes will mark the start and end of B,
///         but the container_* attributes will also include _A and _C in the range. However, rules that
///         contain 'a' will consider it in full, including _A and _C for all attributes.
///
/// ### python source
/// ```py
/// class Tree(Generic[_Leaf_T]):
///     """The main tree class.
///
///     Creates a new tree, and stores "data" and "children" in attributes of the same name.
///     Trees can be hashed and compared.
///
///     Parameters:
///         data: The name of the rule or alias
///         children: List of matched sub-rules and terminals
///         meta: Line & Column numbers (if ``propagate_positions`` is enabled).
///             meta attributes: (line, column, end_line, end_column, start_pos, end_pos,
///                               container_line, container_column, container_end_line, container_end_column)
///             container_* attributes consider all symbols, including those that have been inlined in the tree.
///             For example, in the rule 'a: _A B _C', the regular attributes will mark the start and end of B,
///             but the container_* attributes will also include _A and _C in the range. However, rules that
///             contain 'a' will consider it in full, including _A and _C for all attributes.
///     """
///
///     data: str
///     children: 'List[Branch[_Leaf_T]]'
///
///     def __init__(self, data: str, children: 'List[Branch[_Leaf_T]]', meta: Optional[Meta]=None) -> None:
///         self.data = data
///         self.children = children
///         self._meta = meta
///
///     @property
///     def meta(self) -> Meta:
///         if self._meta is None:
///             self._meta = Meta()
///         return self._meta
///
///     def __repr__(self):
///         return 'Tree(%r, %r)' % (self.data, self.children)
///
///     def _pretty_label(self):
///         return self.data
///
///     def _pretty(self, level, indent_str):
///         yield f'{indent_str*level}{self._pretty_label()}'
///         if len(self.children) == 1 and not isinstance(self.children[0], Tree):
///             yield f'\t{self.children[0]}\n'
///         else:
///             yield '\n'
///             for n in self.children:
///                 if isinstance(n, Tree):
///                     yield from n._pretty(level+1, indent_str)
///                 else:
///                     yield f'{indent_str*(level+1)}{n}\n'
///
///     def pretty(self, indent_str: str='  ') -> str:
///         """Returns an indented string representation of the tree.
///
///         Great for debugging.
///         """
///         return ''.join(self._pretty(0, indent_str))
///
///     def __rich__(self, parent:Optional['rich.tree.Tree']=None) -> 'rich.tree.Tree':
///         """Returns a tree widget for the 'rich' library.
///
///         Example:
///             ::
///                 from rich import print
///                 from lark import Tree
///
///                 tree = Tree('root', ['node1', 'node2'])
///                 print(tree)
///         """
///         return self._rich(parent)
///
///     def _rich(self, parent):
///         if parent:
///             tree = parent.add(f'[bold]{self.data}[/bold]')
///         else:
///             import rich.tree
///             tree = rich.tree.Tree(self.data)
///
///         for c in self.children:
///             if isinstance(c, Tree):
///                 c._rich(tree)
///             else:
///                 tree.add(f'[green]{c}[/green]')
///
///         return tree
///
///     def __eq__(self, other):
///         try:
///             return self.data == other.data and self.children == other.children
///         except AttributeError:
///             return False
///
///     def __ne__(self, other):
///         return not (self == other)
///
///     def __hash__(self) -> int:
///         return hash((self.data, tuple(self.children)))
///
///     def iter_subtrees(self) -> 'Iterator[Tree[_Leaf_T]]':
///         """Depth-first iteration.
///
///         Iterates over all the subtrees, never returning to the same node twice (Lark's parse-tree is actually a DAG).
///         """
///         queue = [self]
///         subtrees = OrderedDict()
///         for subtree in queue:
///             subtrees[id(subtree)] = subtree
///             # Reason for type ignore https://github.com/python/mypy/issues/10999
///             queue += [c for c in reversed(subtree.children)  # type: ignore[misc]
///                       if isinstance(c, Tree) and id(c) not in subtrees]
///
///         del queue
///         return reversed(list(subtrees.values()))
///
///     def iter_subtrees_topdown(self):
///         """Breadth-first iteration.
///
///         Iterates over all the subtrees, return nodes in order like pretty() does.
///         """
///         stack = [self]
///         stack_append = stack.append
///         stack_pop = stack.pop
///         while stack:
///             node = stack_pop()
///             if not isinstance(node, Tree):
///                 continue
///             yield node
///             for child in reversed(node.children):
///                 stack_append(child)
///
///     def find_pred(self, pred: 'Callable[[Tree[_Leaf_T]], bool]') -> 'Iterator[Tree[_Leaf_T]]':
///         """Returns all nodes of the tree that evaluate pred(node) as true."""
///         return filter(pred, self.iter_subtrees())
///
///     def find_data(self, data: str) -> 'Iterator[Tree[_Leaf_T]]':
///         """Returns all nodes of the tree whose data equals the given data."""
///         return self.find_pred(lambda t: t.data == data)
///
/// ###}
///
///     def expand_kids_by_data(self, *data_values):
///         """Expand (inline) children with any of the given data values. Returns True if anything changed"""
///         changed = False
///         for i in range(len(self.children)-1, -1, -1):
///             child = self.children[i]
///             if isinstance(child, Tree) and child.data in data_values:
///                 self.children[i:i+1] = child.children
///                 changed = True
///         return changed
///
///
///     def scan_values(self, pred: 'Callable[[Branch[_Leaf_T]], bool]') -> Iterator[_Leaf_T]:
///         """Return all values in the tree that evaluate pred(value) as true.
///
///         This can be used to find all the tokens in the tree.
///
///         Example:
///             >>> all_tokens = tree.scan_values(lambda v: isinstance(v, Token))
///         """
///         for c in self.children:
///             if isinstance(c, Tree):
///                 for t in c.scan_values(pred):
///                     yield t
///             else:
///                 if pred(c):
///                     yield c
///
///     def __deepcopy__(self, memo):
///         return type(self)(self.data, deepcopy(self.children, memo), meta=self._meta)
///
///     def copy(self) -> 'Tree[_Leaf_T]':
///         return type(self)(self.data, self.children)
///
///     def set(self, data: str, children: 'List[Branch[_Leaf_T]]') -> None:
///         self.data = data
///         self.children = children
/// ```
final class Tree extends PythonClass {
  factory Tree({
    required String data,
    required Object? children,
    Object? meta,
  }) =>
      PythonFfi.instance.importClass(
        "lark.tree_matcher",
        "Tree",
        Tree.from,
        <Object?>[
          data,
          children,
          meta,
        ],
        <String, Object?>{},
      );

  Tree.from(super.pythonClass) : super.from();

  /// ## copy
  ///
  /// ### python source
  /// ```py
  /// def copy(self) -> 'Tree[_Leaf_T]':
  ///         return type(self)(self.data, self.children)
  /// ```
  Object? copy() => getFunction("copy").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## expand_kids_by_data
  ///
  /// ### python docstring
  ///
  /// Expand (inline) children with any of the given data values. Returns True if anything changed
  ///
  /// ### python source
  /// ```py
  /// def expand_kids_by_data(self, *data_values):
  ///         """Expand (inline) children with any of the given data values. Returns True if anything changed"""
  ///         changed = False
  ///         for i in range(len(self.children)-1, -1, -1):
  ///             child = self.children[i]
  ///             if isinstance(child, Tree) and child.data in data_values:
  ///                 self.children[i:i+1] = child.children
  ///                 changed = True
  ///         return changed
  /// ```
  Object? expand_kids_by_data({
    List<Object?> data_values = const <Object?>[],
  }) =>
      getFunction("expand_kids_by_data").call(
        <Object?>[
          ...data_values,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## find_data
  ///
  /// ### python docstring
  ///
  /// Returns all nodes of the tree whose data equals the given data.
  ///
  /// ### python source
  /// ```py
  /// def find_data(self, data: str) -> 'Iterator[Tree[_Leaf_T]]':
  ///         """Returns all nodes of the tree whose data equals the given data."""
  ///         return self.find_pred(lambda t: t.data == data)
  /// ```
  Object? find_data({
    required String data,
  }) =>
      getFunction("find_data").call(
        <Object?>[
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## find_pred
  ///
  /// ### python docstring
  ///
  /// Returns all nodes of the tree that evaluate pred(node) as true.
  ///
  /// ### python source
  /// ```py
  /// def find_pred(self, pred: 'Callable[[Tree[_Leaf_T]], bool]') -> 'Iterator[Tree[_Leaf_T]]':
  ///         """Returns all nodes of the tree that evaluate pred(node) as true."""
  ///         return filter(pred, self.iter_subtrees())
  /// ```
  Object? find_pred({
    required Object? pred,
  }) =>
      getFunction("find_pred").call(
        <Object?>[
          pred,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## iter_subtrees
  ///
  /// ### python docstring
  ///
  /// Depth-first iteration.
  ///
  /// Iterates over all the subtrees, never returning to the same node twice (Lark's parse-tree is actually a DAG).
  ///
  /// ### python source
  /// ```py
  /// def iter_subtrees(self) -> 'Iterator[Tree[_Leaf_T]]':
  ///         """Depth-first iteration.
  ///
  ///         Iterates over all the subtrees, never returning to the same node twice (Lark's parse-tree is actually a DAG).
  ///         """
  ///         queue = [self]
  ///         subtrees = OrderedDict()
  ///         for subtree in queue:
  ///             subtrees[id(subtree)] = subtree
  ///             # Reason for type ignore https://github.com/python/mypy/issues/10999
  ///             queue += [c for c in reversed(subtree.children)  # type: ignore[misc]
  ///                       if isinstance(c, Tree) and id(c) not in subtrees]
  ///
  ///         del queue
  ///         return reversed(list(subtrees.values()))
  /// ```
  Object? iter_subtrees() => getFunction("iter_subtrees").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## iter_subtrees_topdown
  ///
  /// ### python docstring
  ///
  /// Breadth-first iteration.
  ///
  /// Iterates over all the subtrees, return nodes in order like pretty() does.
  ///
  /// ### python source
  /// ```py
  /// def iter_subtrees_topdown(self):
  ///         """Breadth-first iteration.
  ///
  ///         Iterates over all the subtrees, return nodes in order like pretty() does.
  ///         """
  ///         stack = [self]
  ///         stack_append = stack.append
  ///         stack_pop = stack.pop
  ///         while stack:
  ///             node = stack_pop()
  ///             if not isinstance(node, Tree):
  ///                 continue
  ///             yield node
  ///             for child in reversed(node.children):
  ///                 stack_append(child)
  /// ```
  Object? iter_subtrees_topdown() => getFunction("iter_subtrees_topdown").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## pretty
  ///
  /// ### python docstring
  ///
  /// Returns an indented string representation of the tree.
  ///
  /// Great for debugging.
  ///
  /// ### python source
  /// ```py
  /// def pretty(self, indent_str: str='  ') -> str:
  ///         """Returns an indented string representation of the tree.
  ///
  ///         Great for debugging.
  ///         """
  ///         return ''.join(self._pretty(0, indent_str))
  /// ```
  String pretty({
    String indent_str = "  ",
  }) =>
      getFunction("pretty").call(
        <Object?>[
          indent_str,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## scan_values
  ///
  /// ### python docstring
  ///
  /// Return all values in the tree that evaluate pred(value) as true.
  ///
  /// This can be used to find all the tokens in the tree.
  ///
  /// Example:
  ///     >>> all_tokens = tree.scan_values(lambda v: isinstance(v, Token))
  ///
  /// ### python source
  /// ```py
  /// def scan_values(self, pred: 'Callable[[Branch[_Leaf_T]], bool]') -> Iterator[_Leaf_T]:
  ///         """Return all values in the tree that evaluate pred(value) as true.
  ///
  ///         This can be used to find all the tokens in the tree.
  ///
  ///         Example:
  ///             >>> all_tokens = tree.scan_values(lambda v: isinstance(v, Token))
  ///         """
  ///         for c in self.children:
  ///             if isinstance(c, Tree):
  ///                 for t in c.scan_values(pred):
  ///                     yield t
  ///             else:
  ///                 if pred(c):
  ///                     yield c
  /// ```
  Iterator<Object?> scan_values({
    required Object? pred,
  }) =>
      TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("scan_values").call(
            <Object?>[
              pred,
            ],
            kwargs: <String, Object?>{},
          ),
        ),
      ).transform((e) => e).cast<Object?>();

  /// ## set
  ///
  /// ### python source
  /// ```py
  /// def set(self, data: str, children: 'List[Branch[_Leaf_T]]') -> None:
  ///         self.data = data
  ///         self.children = children
  /// ```
  Null $set({
    required String data,
    required Object? children,
  }) =>
      getFunction("set").call(
        <Object?>[
          data,
          children,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## meta (getter)
  ///
  /// ### python docstring
  ///
  /// The main tree class.
  ///
  /// Creates a new tree, and stores "data" and "children" in attributes of the same name.
  /// Trees can be hashed and compared.
  ///
  /// Parameters:
  ///     data: The name of the rule or alias
  ///     children: List of matched sub-rules and terminals
  ///     meta: Line & Column numbers (if ``propagate_positions`` is enabled).
  ///         meta attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         container_* attributes consider all symbols, including those that have been inlined in the tree.
  ///         For example, in the rule 'a: _A B _C', the regular attributes will mark the start and end of B,
  ///         but the container_* attributes will also include _A and _C in the range. However, rules that
  ///         contain 'a' will consider it in full, including _A and _C for all attributes.
  Object? get meta => getAttribute("meta");

  /// ## meta (setter)
  ///
  /// ### python docstring
  ///
  /// The main tree class.
  ///
  /// Creates a new tree, and stores "data" and "children" in attributes of the same name.
  /// Trees can be hashed and compared.
  ///
  /// Parameters:
  ///     data: The name of the rule or alias
  ///     children: List of matched sub-rules and terminals
  ///     meta: Line & Column numbers (if ``propagate_positions`` is enabled).
  ///         meta attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         container_* attributes consider all symbols, including those that have been inlined in the tree.
  ///         For example, in the rule 'a: _A B _C', the regular attributes will mark the start and end of B,
  ///         but the container_* attributes will also include _A and _C in the range. However, rules that
  ///         contain 'a' will consider it in full, including _A and _C for all attributes.
  set meta(Object? meta) => setAttribute("meta", meta);

  /// ## data (getter)
  ///
  /// ### python docstring
  ///
  /// The main tree class.
  ///
  /// Creates a new tree, and stores "data" and "children" in attributes of the same name.
  /// Trees can be hashed and compared.
  ///
  /// Parameters:
  ///     data: The name of the rule or alias
  ///     children: List of matched sub-rules and terminals
  ///     meta: Line & Column numbers (if ``propagate_positions`` is enabled).
  ///         meta attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         container_* attributes consider all symbols, including those that have been inlined in the tree.
  ///         For example, in the rule 'a: _A B _C', the regular attributes will mark the start and end of B,
  ///         but the container_* attributes will also include _A and _C in the range. However, rules that
  ///         contain 'a' will consider it in full, including _A and _C for all attributes.
  Object? get data => getAttribute("data");

  /// ## data (setter)
  ///
  /// ### python docstring
  ///
  /// The main tree class.
  ///
  /// Creates a new tree, and stores "data" and "children" in attributes of the same name.
  /// Trees can be hashed and compared.
  ///
  /// Parameters:
  ///     data: The name of the rule or alias
  ///     children: List of matched sub-rules and terminals
  ///     meta: Line & Column numbers (if ``propagate_positions`` is enabled).
  ///         meta attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         container_* attributes consider all symbols, including those that have been inlined in the tree.
  ///         For example, in the rule 'a: _A B _C', the regular attributes will mark the start and end of B,
  ///         but the container_* attributes will also include _A and _C in the range. However, rules that
  ///         contain 'a' will consider it in full, including _A and _C for all attributes.
  set data(Object? data) => setAttribute("data", data);

  /// ## children (getter)
  ///
  /// ### python docstring
  ///
  /// The main tree class.
  ///
  /// Creates a new tree, and stores "data" and "children" in attributes of the same name.
  /// Trees can be hashed and compared.
  ///
  /// Parameters:
  ///     data: The name of the rule or alias
  ///     children: List of matched sub-rules and terminals
  ///     meta: Line & Column numbers (if ``propagate_positions`` is enabled).
  ///         meta attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         container_* attributes consider all symbols, including those that have been inlined in the tree.
  ///         For example, in the rule 'a: _A B _C', the regular attributes will mark the start and end of B,
  ///         but the container_* attributes will also include _A and _C in the range. However, rules that
  ///         contain 'a' will consider it in full, including _A and _C for all attributes.
  Object? get children => getAttribute("children");

  /// ## children (setter)
  ///
  /// ### python docstring
  ///
  /// The main tree class.
  ///
  /// Creates a new tree, and stores "data" and "children" in attributes of the same name.
  /// Trees can be hashed and compared.
  ///
  /// Parameters:
  ///     data: The name of the rule or alias
  ///     children: List of matched sub-rules and terminals
  ///     meta: Line & Column numbers (if ``propagate_positions`` is enabled).
  ///         meta attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         container_* attributes consider all symbols, including those that have been inlined in the tree.
  ///         For example, in the rule 'a: _A B _C', the regular attributes will mark the start and end of B,
  ///         but the container_* attributes will also include _A and _C in the range. However, rules that
  ///         contain 'a' will consider it in full, including _A and _C for all attributes.
  set children(Object? children) => setAttribute("children", children);
}

/// ## TreeMatcher
///
/// ### python docstring
///
/// Match the elements of a tree node, based on an ontology
/// provided by a Lark grammar.
///
/// Supports templates and inlined rules (`rule{a, b,..}` and `_rule`)
///
/// Initialize with an instance of Lark.
///
/// ### python source
/// ```py
/// class TreeMatcher:
///     """Match the elements of a tree node, based on an ontology
///     provided by a Lark grammar.
///
///     Supports templates and inlined rules (`rule{a, b,..}` and `_rule`)
///
///     Initialize with an instance of Lark.
///     """
///
///     def __init__(self, parser):
///         # XXX TODO calling compile twice returns different results!
///         assert not parser.options.maybe_placeholders
///         # XXX TODO: we just ignore the potential existence of a postlexer
///         self.tokens, rules, _extra = parser.grammar.compile(parser.options.start, set())
///
///         self.rules_for_root = defaultdict(list)
///
///         self.rules = list(self._build_recons_rules(rules))
///         self.rules.reverse()
///
///         # Choose the best rule from each group of {rule => [rule.alias]}, since we only really need one derivation.
///         self.rules = _best_rules_from_group(self.rules)
///
///         self.parser = parser
///         self._parser_cache = {}
///
///     def _build_recons_rules(self, rules):
///         "Convert tree-parsing/construction rules to tree-matching rules"
///         expand1s = {r.origin for r in rules if r.options.expand1}
///
///         aliases = defaultdict(list)
///         for r in rules:
///             if r.alias:
///                 aliases[r.origin].append(r.alias)
///
///         rule_names = {r.origin for r in rules}
///         nonterminals = {sym for sym in rule_names
///                         if sym.name.startswith('_') or sym in expand1s or sym in aliases}
///
///         seen = set()
///         for r in rules:
///             recons_exp = [sym if sym in nonterminals else Terminal(sym.name)
///                           for sym in r.expansion if not is_discarded_terminal(sym)]
///
///             # Skip self-recursive constructs
///             if recons_exp == [r.origin] and r.alias is None:
///                 continue
///
///             sym = NonTerminal(r.alias) if r.alias else r.origin
///             rule = make_recons_rule(sym, recons_exp, r.expansion)
///
///             if sym in expand1s and len(recons_exp) != 1:
///                 self.rules_for_root[sym.name].append(rule)
///
///                 if sym.name not in seen:
///                     yield make_recons_rule_to_term(sym, sym)
///                     seen.add(sym.name)
///             else:
///                 if sym.name.startswith('_') or sym in expand1s:
///                     yield rule
///                 else:
///                     self.rules_for_root[sym.name].append(rule)
///
///         for origin, rule_aliases in aliases.items():
///             for alias in rule_aliases:
///                 yield make_recons_rule_to_term(origin, NonTerminal(alias))
///             yield make_recons_rule_to_term(origin, origin)
///
///     def match_tree(self, tree, rulename):
///         """Match the elements of `tree` to the symbols of rule `rulename`.
///
///         Parameters:
///             tree (Tree): the tree node to match
///             rulename (str): The expected full rule name (including template args)
///
///         Returns:
///             Tree: an unreduced tree that matches `rulename`
///
///         Raises:
///             UnexpectedToken: If no match was found.
///
///         Note:
///             It's the callers' responsibility match the tree recursively.
///         """
///         if rulename:
///             # validate
///             name, _args = parse_rulename(rulename)
///             assert tree.data == name
///         else:
///             rulename = tree.data
///
///         # TODO: ambiguity?
///         try:
///             parser = self._parser_cache[rulename]
///         except KeyError:
///             rules = self.rules + _best_rules_from_group(self.rules_for_root[rulename])
///
///             # TODO pass callbacks through dict, instead of alias?
///             callbacks = {rule: rule.alias for rule in rules}
///             conf = ParserConf(rules, callbacks, [rulename])
///             parser = earley.Parser(self.parser.lexer_conf, conf, _match, resolve_ambiguity=True)
///             self._parser_cache[rulename] = parser
///
///         # find a full derivation
///         unreduced_tree = parser.parse(ChildrenLexer(tree.children), rulename)
///         assert unreduced_tree.data == rulename
///         return unreduced_tree
/// ```
final class TreeMatcher extends PythonClass {
  factory TreeMatcher({
    required Object? parser,
  }) =>
      PythonFfi.instance.importClass(
        "lark.tree_matcher",
        "TreeMatcher",
        TreeMatcher.from,
        <Object?>[
          parser,
        ],
        <String, Object?>{},
      );

  TreeMatcher.from(super.pythonClass) : super.from();

  /// ## match_tree
  ///
  /// ### python docstring
  ///
  /// Match the elements of `tree` to the symbols of rule `rulename`.
  ///
  /// Parameters:
  ///     tree (Tree): the tree node to match
  ///     rulename (str): The expected full rule name (including template args)
  ///
  /// Returns:
  ///     Tree: an unreduced tree that matches `rulename`
  ///
  /// Raises:
  ///     UnexpectedToken: If no match was found.
  ///
  /// Note:
  ///     It's the callers' responsibility match the tree recursively.
  ///
  /// ### python source
  /// ```py
  /// def match_tree(self, tree, rulename):
  ///         """Match the elements of `tree` to the symbols of rule `rulename`.
  ///
  ///         Parameters:
  ///             tree (Tree): the tree node to match
  ///             rulename (str): The expected full rule name (including template args)
  ///
  ///         Returns:
  ///             Tree: an unreduced tree that matches `rulename`
  ///
  ///         Raises:
  ///             UnexpectedToken: If no match was found.
  ///
  ///         Note:
  ///             It's the callers' responsibility match the tree recursively.
  ///         """
  ///         if rulename:
  ///             # validate
  ///             name, _args = parse_rulename(rulename)
  ///             assert tree.data == name
  ///         else:
  ///             rulename = tree.data
  ///
  ///         # TODO: ambiguity?
  ///         try:
  ///             parser = self._parser_cache[rulename]
  ///         except KeyError:
  ///             rules = self.rules + _best_rules_from_group(self.rules_for_root[rulename])
  ///
  ///             # TODO pass callbacks through dict, instead of alias?
  ///             callbacks = {rule: rule.alias for rule in rules}
  ///             conf = ParserConf(rules, callbacks, [rulename])
  ///             parser = earley.Parser(self.parser.lexer_conf, conf, _match, resolve_ambiguity=True)
  ///             self._parser_cache[rulename] = parser
  ///
  ///         # find a full derivation
  ///         unreduced_tree = parser.parse(ChildrenLexer(tree.children), rulename)
  ///         assert unreduced_tree.data == rulename
  ///         return unreduced_tree
  /// ```
  Object? match_tree({
    required Object? tree,
    required Object? rulename,
  }) =>
      getFunction("match_tree").call(
        <Object?>[
          tree,
          rulename,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## rules_for_root (getter)
  ///
  /// ### python docstring
  ///
  /// Match the elements of a tree node, based on an ontology
  /// provided by a Lark grammar.
  ///
  /// Supports templates and inlined rules (`rule{a, b,..}` and `_rule`)
  ///
  /// Initialize with an instance of Lark.
  Object? get rules_for_root => getAttribute("rules_for_root");

  /// ## rules_for_root (setter)
  ///
  /// ### python docstring
  ///
  /// Match the elements of a tree node, based on an ontology
  /// provided by a Lark grammar.
  ///
  /// Supports templates and inlined rules (`rule{a, b,..}` and `_rule`)
  ///
  /// Initialize with an instance of Lark.
  set rules_for_root(Object? rules_for_root) =>
      setAttribute("rules_for_root", rules_for_root);

  /// ## rules (getter)
  ///
  /// ### python docstring
  ///
  /// Match the elements of a tree node, based on an ontology
  /// provided by a Lark grammar.
  ///
  /// Supports templates and inlined rules (`rule{a, b,..}` and `_rule`)
  ///
  /// Initialize with an instance of Lark.
  Object? get rules => getAttribute("rules");

  /// ## rules (setter)
  ///
  /// ### python docstring
  ///
  /// Match the elements of a tree node, based on an ontology
  /// provided by a Lark grammar.
  ///
  /// Supports templates and inlined rules (`rule{a, b,..}` and `_rule`)
  ///
  /// Initialize with an instance of Lark.
  set rules(Object? rules) => setAttribute("rules", rules);

  /// ## parser (getter)
  ///
  /// ### python docstring
  ///
  /// Match the elements of a tree node, based on an ontology
  /// provided by a Lark grammar.
  ///
  /// Supports templates and inlined rules (`rule{a, b,..}` and `_rule`)
  ///
  /// Initialize with an instance of Lark.
  Object? get parser => getAttribute("parser");

  /// ## parser (setter)
  ///
  /// ### python docstring
  ///
  /// Match the elements of a tree node, based on an ontology
  /// provided by a Lark grammar.
  ///
  /// Supports templates and inlined rules (`rule{a, b,..}` and `_rule`)
  ///
  /// Initialize with an instance of Lark.
  set parser(Object? parser) => setAttribute("parser", parser);
}

/// ## ForestSumVisitor
///
/// ### python docstring
///
/// A visitor for prioritizing ambiguous parts of the Forest.
///
/// This visitor is used when support for explicit priorities on
/// rules is requested (whether normal, or invert). It walks the
/// forest (or subsets thereof) and cascades properties upwards
/// from the leaves.
///
/// It would be ideal to do this during parsing, however this would
/// require processing each Earley item multiple times. That's
/// a big performance drawback; so running a forest walk is the
/// lesser of two evils: there can be significantly more Earley
/// items created during parsing than there are SPPF nodes in the
/// final tree.
///
/// ### python source
/// ```py
/// class ForestSumVisitor(ForestVisitor):
///     """
///     A visitor for prioritizing ambiguous parts of the Forest.
///
///     This visitor is used when support for explicit priorities on
///     rules is requested (whether normal, or invert). It walks the
///     forest (or subsets thereof) and cascades properties upwards
///     from the leaves.
///
///     It would be ideal to do this during parsing, however this would
///     require processing each Earley item multiple times. That's
///     a big performance drawback; so running a forest walk is the
///     lesser of two evils: there can be significantly more Earley
///     items created during parsing than there are SPPF nodes in the
///     final tree.
///     """
///     def __init__(self):
///         super(ForestSumVisitor, self).__init__(single_visit=True)
///
///     def visit_packed_node_in(self, node):
///         yield node.left
///         yield node.right
///
///     def visit_symbol_node_in(self, node):
///         return iter(node.children)
///
///     def visit_packed_node_out(self, node):
///         priority = node.rule.options.priority if not node.parent.is_intermediate and node.rule.options.priority else 0
///         priority += getattr(node.right, 'priority', 0)
///         priority += getattr(node.left, 'priority', 0)
///         node.priority = priority
///
///     def visit_symbol_node_out(self, node):
///         node.priority = max(child.priority for child in node.children)
/// ```
final class ForestSumVisitor extends PythonClass {
  factory ForestSumVisitor() => PythonFfi.instance.importClass(
        "lark.tree_matcher",
        "ForestSumVisitor",
        ForestSumVisitor.from,
        <Object?>[],
        <String, Object?>{},
      );

  ForestSumVisitor.from(super.pythonClass) : super.from();

  /// ## get_cycle_in_path
  ///
  /// ### python docstring
  ///
  /// A utility function for use in ``on_cycle`` to obtain a slice of
  /// ``path`` that only contains the nodes that make up the cycle.
  ///
  /// ### python source
  /// ```py
  /// def get_cycle_in_path(self, node, path):
  ///         """A utility function for use in ``on_cycle`` to obtain a slice of
  ///         ``path`` that only contains the nodes that make up the cycle."""
  ///         index = len(path) - 1
  ///         while id(path[index]) != id(node):
  ///             index -= 1
  ///         return path[index:]
  /// ```
  Object? get_cycle_in_path({
    required Object? node,
    required Object? path,
  }) =>
      getFunction("get_cycle_in_path").call(
        <Object?>[
          node,
          path,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## on_cycle
  ///
  /// ### python docstring
  ///
  /// Called when a cycle is encountered.
  ///
  /// Parameters:
  ///     node: The node that causes a cycle.
  ///     path: The list of nodes being visited: nodes that have been
  ///         entered but not exited. The first element is the root in a forest
  ///         visit, and the last element is the node visited most recently.
  ///         ``path`` should be treated as read-only.
  ///
  /// ### python source
  /// ```py
  /// def on_cycle(self, node, path):
  ///         """Called when a cycle is encountered.
  ///
  ///         Parameters:
  ///             node: The node that causes a cycle.
  ///             path: The list of nodes being visited: nodes that have been
  ///                 entered but not exited. The first element is the root in a forest
  ///                 visit, and the last element is the node visited most recently.
  ///                 ``path`` should be treated as read-only.
  ///         """
  ///         pass
  /// ```
  Object? on_cycle({
    required Object? node,
    required Object? path,
  }) =>
      getFunction("on_cycle").call(
        <Object?>[
          node,
          path,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit
  ///
  /// ### python source
  /// ```py
  /// def visit(self, root):
  ///         # Visiting is a list of IDs of all symbol/intermediate nodes currently in
  ///         # the stack. It serves two purposes: to detect when we 'recurse' in and out
  ///         # of a symbol/intermediate so that we can process both up and down. Also,
  ///         # since the SPPF can have cycles it allows us to detect if we're trying
  ///         # to recurse into a node that's already on the stack (infinite recursion).
  ///         visiting = set()
  ///
  ///         # set of all nodes that have been visited
  ///         visited = set()
  ///
  ///         # a list of nodes that are currently being visited
  ///         # used for the `on_cycle` callback
  ///         path = []
  ///
  ///         # We do not use recursion here to walk the Forest due to the limited
  ///         # stack size in python. Therefore input_stack is essentially our stack.
  ///         input_stack = deque([root])
  ///
  ///         # It is much faster to cache these as locals since they are called
  ///         # many times in large parses.
  ///         vpno = getattr(self, 'visit_packed_node_out')
  ///         vpni = getattr(self, 'visit_packed_node_in')
  ///         vsno = getattr(self, 'visit_symbol_node_out')
  ///         vsni = getattr(self, 'visit_symbol_node_in')
  ///         vino = getattr(self, 'visit_intermediate_node_out', vsno)
  ///         vini = getattr(self, 'visit_intermediate_node_in', vsni)
  ///         vtn = getattr(self, 'visit_token_node')
  ///         oc = getattr(self, 'on_cycle')
  ///
  ///         while input_stack:
  ///             current = next(reversed(input_stack))
  ///             try:
  ///                 next_node = next(current)
  ///             except StopIteration:
  ///                 input_stack.pop()
  ///                 continue
  ///             except TypeError:
  ///                 ### If the current object is not an iterator, pass through to Token/SymbolNode
  ///                 pass
  ///             else:
  ///                 if next_node is None:
  ///                     continue
  ///
  ///                 if id(next_node) in visiting:
  ///                     oc(next_node, path)
  ///                     continue
  ///
  ///                 input_stack.append(next_node)
  ///                 continue
  ///
  ///             if isinstance(current, TokenNode):
  ///                 vtn(current.token)
  ///                 input_stack.pop()
  ///                 continue
  ///
  ///             current_id = id(current)
  ///             if current_id in visiting:
  ///                 if isinstance(current, PackedNode):
  ///                     vpno(current)
  ///                 elif current.is_intermediate:
  ///                     vino(current)
  ///                 else:
  ///                     vsno(current)
  ///                 input_stack.pop()
  ///                 path.pop()
  ///                 visiting.remove(current_id)
  ///                 visited.add(current_id)
  ///             elif self.single_visit and current_id in visited:
  ///                 input_stack.pop()
  ///             else:
  ///                 visiting.add(current_id)
  ///                 path.append(current)
  ///                 if isinstance(current, PackedNode):
  ///                     next_node = vpni(current)
  ///                 elif current.is_intermediate:
  ///                     next_node = vini(current)
  ///                 else:
  ///                     next_node = vsni(current)
  ///                 if next_node is None:
  ///                     continue
  ///
  ///                 if not isinstance(next_node, ForestNode):
  ///                     next_node = iter(next_node)
  ///                 elif id(next_node) in visiting:
  ///                     oc(next_node, path)
  ///                     continue
  ///
  ///                 input_stack.append(next_node)
  /// ```
  Object? visit({
    required Object? root,
  }) =>
      getFunction("visit").call(
        <Object?>[
          root,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_packed_node_in
  ///
  /// ### python docstring
  ///
  /// Called when a packed node is visited. Nodes that are returned
  /// will be scheduled to be visited.
  ///
  /// ### python source
  /// ```py
  /// def visit_packed_node_in(self, node):
  ///         yield node.left
  ///         yield node.right
  /// ```
  Object? visit_packed_node_in({
    required Object? node,
  }) =>
      getFunction("visit_packed_node_in").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_packed_node_out
  ///
  /// ### python docstring
  ///
  /// Called after all nodes returned from a corresponding ``visit_packed_node_in``
  /// call have been visited.
  ///
  /// ### python source
  /// ```py
  /// def visit_packed_node_out(self, node):
  ///         priority = node.rule.options.priority if not node.parent.is_intermediate and node.rule.options.priority else 0
  ///         priority += getattr(node.right, 'priority', 0)
  ///         priority += getattr(node.left, 'priority', 0)
  ///         node.priority = priority
  /// ```
  Object? visit_packed_node_out({
    required Object? node,
  }) =>
      getFunction("visit_packed_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_symbol_node_in
  ///
  /// ### python docstring
  ///
  /// Called when a symbol node is visited. Nodes that are returned
  /// will be scheduled to be visited. If ``visit_intermediate_node_in``
  /// is not implemented, this function will be called for intermediate
  /// nodes as well.
  ///
  /// ### python source
  /// ```py
  /// def visit_symbol_node_in(self, node):
  ///         return iter(node.children)
  /// ```
  Object? visit_symbol_node_in({
    required Object? node,
  }) =>
      getFunction("visit_symbol_node_in").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_symbol_node_out
  ///
  /// ### python docstring
  ///
  /// Called after all nodes returned from a corresponding ``visit_symbol_node_in``
  /// call have been visited. If ``visit_intermediate_node_out``
  /// is not implemented, this function will be called for intermediate
  /// nodes as well.
  ///
  /// ### python source
  /// ```py
  /// def visit_symbol_node_out(self, node):
  ///         node.priority = max(child.priority for child in node.children)
  /// ```
  Object? visit_symbol_node_out({
    required Object? node,
  }) =>
      getFunction("visit_symbol_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_token_node
  ///
  /// ### python docstring
  ///
  /// Called when a ``Token`` is visited. ``Token`` nodes are always leaves.
  ///
  /// ### python source
  /// ```py
  /// def visit_token_node(self, node):
  ///         """Called when a ``Token`` is visited. ``Token`` nodes are always leaves."""
  ///         pass
  /// ```
  Object? visit_token_node({
    required Object? node,
  }) =>
      getFunction("visit_token_node").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## ForestToParseTree
///
/// ### python docstring
///
/// Used by the earley parser when ambiguity equals 'resolve' or
/// 'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
///
/// Parameters:
///     tree_class: The tree class to use for construction
///     callbacks: A dictionary of rules to functions that output a tree
///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
///     resolve_ambiguity: If True, ambiguities will be resolved based on
///                     priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
///     use_cache: If True, the results of packed node transformations will be cached.
///
/// ### python source
/// ```py
/// class ForestToParseTree(ForestTransformer):
///     """Used by the earley parser when ambiguity equals 'resolve' or
///     'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
///
///     Parameters:
///         tree_class: The tree class to use for construction
///         callbacks: A dictionary of rules to functions that output a tree
///         prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
///         resolve_ambiguity: If True, ambiguities will be resolved based on
///                         priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
///         use_cache: If True, the results of packed node transformations will be cached.
///     """
///
///     def __init__(self, tree_class=Tree, callbacks=dict(), prioritizer=ForestSumVisitor(), resolve_ambiguity=True, use_cache=True):
///         super(ForestToParseTree, self).__init__()
///         self.tree_class = tree_class
///         self.callbacks = callbacks
///         self.prioritizer = prioritizer
///         self.resolve_ambiguity = resolve_ambiguity
///         self._use_cache = use_cache
///         self._cache = {}
///         self._on_cycle_retreat = False
///         self._cycle_node = None
///         self._successful_visits = set()
///
///     def visit(self, root):
///         if self.prioritizer:
///             self.prioritizer.visit(root)
///         super(ForestToParseTree, self).visit(root)
///         self._cache = {}
///
///     def on_cycle(self, node, path):
///         logger.debug("Cycle encountered in the SPPF at node: %s. "
///                 "As infinite ambiguities cannot be represented in a tree, "
///                 "this family of derivations will be discarded.", node)
///         self._cycle_node = node
///         self._on_cycle_retreat = True
///
///     def _check_cycle(self, node):
///         if self._on_cycle_retreat:
///             if id(node) == id(self._cycle_node) or id(node) in self._successful_visits:
///                 self._cycle_node = None
///                 self._on_cycle_retreat = False
///             else:
///                 return Discard
///
///     def _collapse_ambig(self, children):
///         new_children = []
///         for child in children:
///             if hasattr(child, 'data') and child.data == '_ambig':
///                 new_children += child.children
///             else:
///                 new_children.append(child)
///         return new_children
///
///     def _call_rule_func(self, node, data):
///         # called when transforming children of symbol nodes
///         # data is a list of trees or tokens that correspond to the
///         # symbol's rule expansion
///         return self.callbacks[node.rule](data)
///
///     def _call_ambig_func(self, node, data):
///         # called when transforming a symbol node
///         # data is a list of trees where each tree's data is
///         # equal to the name of the symbol or one of its aliases.
///         if len(data) > 1:
///             return self.tree_class('_ambig', data)
///         elif data:
///             return data[0]
///         return Discard
///
///     def transform_symbol_node(self, node, data):
///         if id(node) not in self._successful_visits:
///             return Discard
///         r = self._check_cycle(node)
///         if r is Discard:
///             return r
///         self._successful_visits.remove(id(node))
///         data = self._collapse_ambig(data)
///         return self._call_ambig_func(node, data)
///
///     def transform_intermediate_node(self, node, data):
///         if id(node) not in self._successful_visits:
///             return Discard
///         r = self._check_cycle(node)
///         if r is Discard:
///             return r
///         self._successful_visits.remove(id(node))
///         if len(data) > 1:
///             children = [self.tree_class('_inter', c) for c in data]
///             return self.tree_class('_iambig', children)
///         return data[0]
///
///     def transform_packed_node(self, node, data):
///         r = self._check_cycle(node)
///         if r is Discard:
///             return r
///         if self.resolve_ambiguity and id(node.parent) in self._successful_visits:
///             return Discard
///         if self._use_cache and id(node) in self._cache:
///             return self._cache[id(node)]
///         children = []
///         assert len(data) <= 2
///         data = PackedData(node, data)
///         if data.left is not PackedData.NO_DATA:
///             if node.left.is_intermediate and isinstance(data.left, list):
///                 children += data.left
///             else:
///                 children.append(data.left)
///         if data.right is not PackedData.NO_DATA:
///             children.append(data.right)
///         if node.parent.is_intermediate:
///             return self._cache.setdefault(id(node), children)
///         return self._cache.setdefault(id(node), self._call_rule_func(node, children))
///
///     def visit_symbol_node_in(self, node):
///         super(ForestToParseTree, self).visit_symbol_node_in(node)
///         if self._on_cycle_retreat:
///             return
///         return node.children
///
///     def visit_packed_node_in(self, node):
///         self._on_cycle_retreat = False
///         to_visit = super(ForestToParseTree, self).visit_packed_node_in(node)
///         if not self.resolve_ambiguity or id(node.parent) not in self._successful_visits:
///             if not self._use_cache or id(node) not in self._cache:
///                 return to_visit
///
///     def visit_packed_node_out(self, node):
///         super(ForestToParseTree, self).visit_packed_node_out(node)
///         if not self._on_cycle_retreat:
///             self._successful_visits.add(id(node.parent))
/// ```
final class ForestToParseTree extends PythonClass {
  factory ForestToParseTree({
    Object? tree_class,
    Object? callbacks = const {},
    Object? prioritizer,
    Object? resolve_ambiguity = true,
    Object? use_cache = true,
  }) =>
      PythonFfi.instance.importClass(
        "lark.tree_matcher",
        "ForestToParseTree",
        ForestToParseTree.from,
        <Object?>[
          tree_class,
          callbacks,
          prioritizer,
          resolve_ambiguity,
          use_cache,
        ],
        <String, Object?>{},
      );

  ForestToParseTree.from(super.pythonClass) : super.from();

  /// ## get_cycle_in_path
  ///
  /// ### python docstring
  ///
  /// A utility function for use in ``on_cycle`` to obtain a slice of
  /// ``path`` that only contains the nodes that make up the cycle.
  ///
  /// ### python source
  /// ```py
  /// def get_cycle_in_path(self, node, path):
  ///         """A utility function for use in ``on_cycle`` to obtain a slice of
  ///         ``path`` that only contains the nodes that make up the cycle."""
  ///         index = len(path) - 1
  ///         while id(path[index]) != id(node):
  ///             index -= 1
  ///         return path[index:]
  /// ```
  Object? get_cycle_in_path({
    required Object? node,
    required Object? path,
  }) =>
      getFunction("get_cycle_in_path").call(
        <Object?>[
          node,
          path,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## on_cycle
  ///
  /// ### python docstring
  ///
  /// Called when a cycle is encountered.
  ///
  /// Parameters:
  ///     node: The node that causes a cycle.
  ///     path: The list of nodes being visited: nodes that have been
  ///         entered but not exited. The first element is the root in a forest
  ///         visit, and the last element is the node visited most recently.
  ///         ``path`` should be treated as read-only.
  ///
  /// ### python source
  /// ```py
  /// def on_cycle(self, node, path):
  ///         logger.debug("Cycle encountered in the SPPF at node: %s. "
  ///                 "As infinite ambiguities cannot be represented in a tree, "
  ///                 "this family of derivations will be discarded.", node)
  ///         self._cycle_node = node
  ///         self._on_cycle_retreat = True
  /// ```
  Object? on_cycle({
    required Object? node,
    required Object? path,
  }) =>
      getFunction("on_cycle").call(
        <Object?>[
          node,
          path,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Perform a transformation on an SPPF.
  ///
  /// ### python source
  /// ```py
  /// def transform(self, root):
  ///         """Perform a transformation on an SPPF."""
  ///         self.node_stack.append('result')
  ///         self.data['result'] = []
  ///         self.visit(root)
  ///         assert len(self.data['result']) <= 1
  ///         if self.data['result']:
  ///             return self.data['result'][0]
  /// ```
  Object? transform({
    required Object? root,
  }) =>
      getFunction("transform").call(
        <Object?>[
          root,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform_intermediate_node
  ///
  /// ### python docstring
  ///
  /// Transform an intermediate node.
  ///
  /// ### python source
  /// ```py
  /// def transform_intermediate_node(self, node, data):
  ///         if id(node) not in self._successful_visits:
  ///             return Discard
  ///         r = self._check_cycle(node)
  ///         if r is Discard:
  ///             return r
  ///         self._successful_visits.remove(id(node))
  ///         if len(data) > 1:
  ///             children = [self.tree_class('_inter', c) for c in data]
  ///             return self.tree_class('_iambig', children)
  ///         return data[0]
  /// ```
  Object? transform_intermediate_node({
    required Object? node,
    required Object? data,
  }) =>
      getFunction("transform_intermediate_node").call(
        <Object?>[
          node,
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform_packed_node
  ///
  /// ### python docstring
  ///
  /// Transform a packed node.
  ///
  /// ### python source
  /// ```py
  /// def transform_packed_node(self, node, data):
  ///         r = self._check_cycle(node)
  ///         if r is Discard:
  ///             return r
  ///         if self.resolve_ambiguity and id(node.parent) in self._successful_visits:
  ///             return Discard
  ///         if self._use_cache and id(node) in self._cache:
  ///             return self._cache[id(node)]
  ///         children = []
  ///         assert len(data) <= 2
  ///         data = PackedData(node, data)
  ///         if data.left is not PackedData.NO_DATA:
  ///             if node.left.is_intermediate and isinstance(data.left, list):
  ///                 children += data.left
  ///             else:
  ///                 children.append(data.left)
  ///         if data.right is not PackedData.NO_DATA:
  ///             children.append(data.right)
  ///         if node.parent.is_intermediate:
  ///             return self._cache.setdefault(id(node), children)
  ///         return self._cache.setdefault(id(node), self._call_rule_func(node, children))
  /// ```
  Object? transform_packed_node({
    required Object? node,
    required Object? data,
  }) =>
      getFunction("transform_packed_node").call(
        <Object?>[
          node,
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform_symbol_node
  ///
  /// ### python docstring
  ///
  /// Transform a symbol node.
  ///
  /// ### python source
  /// ```py
  /// def transform_symbol_node(self, node, data):
  ///         if id(node) not in self._successful_visits:
  ///             return Discard
  ///         r = self._check_cycle(node)
  ///         if r is Discard:
  ///             return r
  ///         self._successful_visits.remove(id(node))
  ///         data = self._collapse_ambig(data)
  ///         return self._call_ambig_func(node, data)
  /// ```
  Object? transform_symbol_node({
    required Object? node,
    required Object? data,
  }) =>
      getFunction("transform_symbol_node").call(
        <Object?>[
          node,
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform_token_node
  ///
  /// ### python docstring
  ///
  /// Transform a ``Token``.
  ///
  /// ### python source
  /// ```py
  /// def transform_token_node(self, node):
  ///         """Transform a ``Token``."""
  ///         return node
  /// ```
  Object? transform_token_node({
    required Object? node,
  }) =>
      getFunction("transform_token_node").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit
  ///
  /// ### python source
  /// ```py
  /// def visit(self, root):
  ///         if self.prioritizer:
  ///             self.prioritizer.visit(root)
  ///         super(ForestToParseTree, self).visit(root)
  ///         self._cache = {}
  /// ```
  Object? visit({
    required Object? root,
  }) =>
      getFunction("visit").call(
        <Object?>[
          root,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_intermediate_node_out
  ///
  /// ### python source
  /// ```py
  /// def visit_intermediate_node_out(self, node):
  ///         self._visit_node_out_helper(node, self.transform_intermediate_node)
  /// ```
  Object? visit_intermediate_node_out({
    required Object? node,
  }) =>
      getFunction("visit_intermediate_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_packed_node_in
  ///
  /// ### python docstring
  ///
  /// Called when a packed node is visited. Nodes that are returned
  /// will be scheduled to be visited.
  ///
  /// ### python source
  /// ```py
  /// def visit_packed_node_in(self, node):
  ///         self._on_cycle_retreat = False
  ///         to_visit = super(ForestToParseTree, self).visit_packed_node_in(node)
  ///         if not self.resolve_ambiguity or id(node.parent) not in self._successful_visits:
  ///             if not self._use_cache or id(node) not in self._cache:
  ///                 return to_visit
  /// ```
  Object? visit_packed_node_in({
    required Object? node,
  }) =>
      getFunction("visit_packed_node_in").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_packed_node_out
  ///
  /// ### python docstring
  ///
  /// Called after all nodes returned from a corresponding ``visit_packed_node_in``
  /// call have been visited.
  ///
  /// ### python source
  /// ```py
  /// def visit_packed_node_out(self, node):
  ///         super(ForestToParseTree, self).visit_packed_node_out(node)
  ///         if not self._on_cycle_retreat:
  ///             self._successful_visits.add(id(node.parent))
  /// ```
  Object? visit_packed_node_out({
    required Object? node,
  }) =>
      getFunction("visit_packed_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_symbol_node_in
  ///
  /// ### python docstring
  ///
  /// Called when a symbol node is visited. Nodes that are returned
  /// will be scheduled to be visited. If ``visit_intermediate_node_in``
  /// is not implemented, this function will be called for intermediate
  /// nodes as well.
  ///
  /// ### python source
  /// ```py
  /// def visit_symbol_node_in(self, node):
  ///         super(ForestToParseTree, self).visit_symbol_node_in(node)
  ///         if self._on_cycle_retreat:
  ///             return
  ///         return node.children
  /// ```
  Object? visit_symbol_node_in({
    required Object? node,
  }) =>
      getFunction("visit_symbol_node_in").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_symbol_node_out
  ///
  /// ### python docstring
  ///
  /// Called after all nodes returned from a corresponding ``visit_symbol_node_in``
  /// call have been visited. If ``visit_intermediate_node_out``
  /// is not implemented, this function will be called for intermediate
  /// nodes as well.
  ///
  /// ### python source
  /// ```py
  /// def visit_symbol_node_out(self, node):
  ///         self._visit_node_out_helper(node, self.transform_symbol_node)
  /// ```
  Object? visit_symbol_node_out({
    required Object? node,
  }) =>
      getFunction("visit_symbol_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_token_node
  ///
  /// ### python docstring
  ///
  /// Called when a ``Token`` is visited. ``Token`` nodes are always leaves.
  ///
  /// ### python source
  /// ```py
  /// def visit_token_node(self, node):
  ///         transformed = self.transform_token_node(node)
  ///         if transformed is not Discard:
  ///             self.data[self.node_stack[-1]].append(transformed)
  /// ```
  Object? visit_token_node({
    required Object? node,
  }) =>
      getFunction("visit_token_node").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## tree_class (getter)
  ///
  /// ### python docstring
  ///
  /// Used by the earley parser when ambiguity equals 'resolve' or
  /// 'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
  ///
  /// Parameters:
  ///     tree_class: The tree class to use for construction
  ///     callbacks: A dictionary of rules to functions that output a tree
  ///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
  ///     resolve_ambiguity: If True, ambiguities will be resolved based on
  ///                     priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
  ///     use_cache: If True, the results of packed node transformations will be cached.
  Object? get tree_class => getAttribute("tree_class");

  /// ## tree_class (setter)
  ///
  /// ### python docstring
  ///
  /// Used by the earley parser when ambiguity equals 'resolve' or
  /// 'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
  ///
  /// Parameters:
  ///     tree_class: The tree class to use for construction
  ///     callbacks: A dictionary of rules to functions that output a tree
  ///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
  ///     resolve_ambiguity: If True, ambiguities will be resolved based on
  ///                     priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
  ///     use_cache: If True, the results of packed node transformations will be cached.
  set tree_class(Object? tree_class) => setAttribute("tree_class", tree_class);

  /// ## callbacks (getter)
  ///
  /// ### python docstring
  ///
  /// Used by the earley parser when ambiguity equals 'resolve' or
  /// 'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
  ///
  /// Parameters:
  ///     tree_class: The tree class to use for construction
  ///     callbacks: A dictionary of rules to functions that output a tree
  ///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
  ///     resolve_ambiguity: If True, ambiguities will be resolved based on
  ///                     priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
  ///     use_cache: If True, the results of packed node transformations will be cached.
  Object? get callbacks => getAttribute("callbacks");

  /// ## callbacks (setter)
  ///
  /// ### python docstring
  ///
  /// Used by the earley parser when ambiguity equals 'resolve' or
  /// 'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
  ///
  /// Parameters:
  ///     tree_class: The tree class to use for construction
  ///     callbacks: A dictionary of rules to functions that output a tree
  ///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
  ///     resolve_ambiguity: If True, ambiguities will be resolved based on
  ///                     priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
  ///     use_cache: If True, the results of packed node transformations will be cached.
  set callbacks(Object? callbacks) => setAttribute("callbacks", callbacks);

  /// ## prioritizer (getter)
  ///
  /// ### python docstring
  ///
  /// Used by the earley parser when ambiguity equals 'resolve' or
  /// 'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
  ///
  /// Parameters:
  ///     tree_class: The tree class to use for construction
  ///     callbacks: A dictionary of rules to functions that output a tree
  ///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
  ///     resolve_ambiguity: If True, ambiguities will be resolved based on
  ///                     priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
  ///     use_cache: If True, the results of packed node transformations will be cached.
  Object? get prioritizer => getAttribute("prioritizer");

  /// ## prioritizer (setter)
  ///
  /// ### python docstring
  ///
  /// Used by the earley parser when ambiguity equals 'resolve' or
  /// 'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
  ///
  /// Parameters:
  ///     tree_class: The tree class to use for construction
  ///     callbacks: A dictionary of rules to functions that output a tree
  ///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
  ///     resolve_ambiguity: If True, ambiguities will be resolved based on
  ///                     priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
  ///     use_cache: If True, the results of packed node transformations will be cached.
  set prioritizer(Object? prioritizer) =>
      setAttribute("prioritizer", prioritizer);

  /// ## resolve_ambiguity (getter)
  ///
  /// ### python docstring
  ///
  /// Used by the earley parser when ambiguity equals 'resolve' or
  /// 'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
  ///
  /// Parameters:
  ///     tree_class: The tree class to use for construction
  ///     callbacks: A dictionary of rules to functions that output a tree
  ///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
  ///     resolve_ambiguity: If True, ambiguities will be resolved based on
  ///                     priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
  ///     use_cache: If True, the results of packed node transformations will be cached.
  Object? get resolve_ambiguity => getAttribute("resolve_ambiguity");

  /// ## resolve_ambiguity (setter)
  ///
  /// ### python docstring
  ///
  /// Used by the earley parser when ambiguity equals 'resolve' or
  /// 'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
  ///
  /// Parameters:
  ///     tree_class: The tree class to use for construction
  ///     callbacks: A dictionary of rules to functions that output a tree
  ///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
  ///     resolve_ambiguity: If True, ambiguities will be resolved based on
  ///                     priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
  ///     use_cache: If True, the results of packed node transformations will be cached.
  set resolve_ambiguity(Object? resolve_ambiguity) =>
      setAttribute("resolve_ambiguity", resolve_ambiguity);
}

/// ## GrammarAnalyzer
///
/// ### python source
/// ```py
/// class GrammarAnalyzer:
///     def __init__(self, parser_conf, debug=False, strict=False):
///         self.debug = debug
///         self.strict = strict
///
///         root_rules = {start: Rule(NonTerminal('$root_' + start), [NonTerminal(start), Terminal('$END')])
///                       for start in parser_conf.start}
///
///         rules = parser_conf.rules + list(root_rules.values())
///         self.rules_by_origin = classify(rules, lambda r: r.origin)
///
///         if len(rules) != len(set(rules)):
///             duplicates = [item for item, count in Counter(rules).items() if count > 1]
///             raise GrammarError("Rules defined twice: %s" % ', '.join(str(i) for i in duplicates))
///
///         for r in rules:
///             for sym in r.expansion:
///                 if not (sym.is_term or sym in self.rules_by_origin):
///                     raise GrammarError("Using an undefined rule: %s" % sym)
///
///         self.start_states = {start: self.expand_rule(root_rule.origin)
///                              for start, root_rule in root_rules.items()}
///
///         self.end_states = {start: fzset({RulePtr(root_rule, len(root_rule.expansion))})
///                            for start, root_rule in root_rules.items()}
///
///         lr0_root_rules = {start: Rule(NonTerminal('$root_' + start), [NonTerminal(start)])
///                 for start in parser_conf.start}
///
///         lr0_rules = parser_conf.rules + list(lr0_root_rules.values())
///         assert(len(lr0_rules) == len(set(lr0_rules)))
///
///         self.lr0_rules_by_origin = classify(lr0_rules, lambda r: r.origin)
///
///         # cache RulePtr(r, 0) in r (no duplicate RulePtr objects)
///         self.lr0_start_states = {start: LR0ItemSet([RulePtr(root_rule, 0)], self.expand_rule(root_rule.origin, self.lr0_rules_by_origin))
///                 for start, root_rule in lr0_root_rules.items()}
///
///         self.FIRST, self.FOLLOW, self.NULLABLE = calculate_sets(rules)
///
///     def expand_rule(self, source_rule, rules_by_origin=None):
///         "Returns all init_ptrs accessible by rule (recursive)"
///
///         if rules_by_origin is None:
///             rules_by_origin = self.rules_by_origin
///
///         init_ptrs = set()
///         def _expand_rule(rule):
///             assert not rule.is_term, rule
///
///             for r in rules_by_origin[rule]:
///                 init_ptr = RulePtr(r, 0)
///                 init_ptrs.add(init_ptr)
///
///                 if r.expansion: # if not empty rule
///                     new_r = init_ptr.next
///                     if not new_r.is_term:
///                         yield new_r
///
///         for _ in bfs([source_rule], _expand_rule):
///             pass
///
///         return fzset(init_ptrs)
/// ```
final class GrammarAnalyzer extends PythonClass {
  factory GrammarAnalyzer({
    required Object? parser_conf,
    Object? debug = false,
    Object? strict = false,
  }) =>
      PythonFfi.instance.importClass(
        "lark.tree_matcher",
        "GrammarAnalyzer",
        GrammarAnalyzer.from,
        <Object?>[
          parser_conf,
          debug,
          strict,
        ],
        <String, Object?>{},
      );

  GrammarAnalyzer.from(super.pythonClass) : super.from();

  /// ## expand_rule
  ///
  /// ### python docstring
  ///
  /// Returns all init_ptrs accessible by rule (recursive)
  ///
  /// ### python source
  /// ```py
  /// def expand_rule(self, source_rule, rules_by_origin=None):
  ///         "Returns all init_ptrs accessible by rule (recursive)"
  ///
  ///         if rules_by_origin is None:
  ///             rules_by_origin = self.rules_by_origin
  ///
  ///         init_ptrs = set()
  ///         def _expand_rule(rule):
  ///             assert not rule.is_term, rule
  ///
  ///             for r in rules_by_origin[rule]:
  ///                 init_ptr = RulePtr(r, 0)
  ///                 init_ptrs.add(init_ptr)
  ///
  ///                 if r.expansion: # if not empty rule
  ///                     new_r = init_ptr.next
  ///                     if not new_r.is_term:
  ///                         yield new_r
  ///
  ///         for _ in bfs([source_rule], _expand_rule):
  ///             pass
  ///
  ///         return fzset(init_ptrs)
  /// ```
  Object? expand_rule({
    required Object? source_rule,
    Object? rules_by_origin,
  }) =>
      getFunction("expand_rule").call(
        <Object?>[
          source_rule,
          rules_by_origin,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## debug (getter)
  Object? get debug => getAttribute("debug");

  /// ## debug (setter)
  set debug(Object? debug) => setAttribute("debug", debug);

  /// ## strict (getter)
  Object? get strict => getAttribute("strict");

  /// ## strict (setter)
  set strict(Object? strict) => setAttribute("strict", strict);

  /// ## rules_by_origin (getter)
  Object? get rules_by_origin => getAttribute("rules_by_origin");

  /// ## rules_by_origin (setter)
  set rules_by_origin(Object? rules_by_origin) =>
      setAttribute("rules_by_origin", rules_by_origin);

  /// ## start_states (getter)
  Object? get start_states => getAttribute("start_states");

  /// ## start_states (setter)
  set start_states(Object? start_states) =>
      setAttribute("start_states", start_states);

  /// ## end_states (getter)
  Object? get end_states => getAttribute("end_states");

  /// ## end_states (setter)
  set end_states(Object? end_states) => setAttribute("end_states", end_states);

  /// ## lr0_rules_by_origin (getter)
  Object? get lr0_rules_by_origin => getAttribute("lr0_rules_by_origin");

  /// ## lr0_rules_by_origin (setter)
  set lr0_rules_by_origin(Object? lr0_rules_by_origin) =>
      setAttribute("lr0_rules_by_origin", lr0_rules_by_origin);

  /// ## lr0_start_states (getter)
  Object? get lr0_start_states => getAttribute("lr0_start_states");

  /// ## lr0_start_states (setter)
  set lr0_start_states(Object? lr0_start_states) =>
      setAttribute("lr0_start_states", lr0_start_states);
}

/// ## Item
///
/// ### python docstring
///
/// An Earley Item, the atom of the algorithm.
///
/// ### python source
/// ```py
/// class Item:
///     "An Earley Item, the atom of the algorithm."
///
///     __slots__ = ('s', 'rule', 'ptr', 'start', 'is_complete', 'expect', 'previous', 'node', '_hash')
///     def __init__(self, rule, ptr, start):
///         self.is_complete = len(rule.expansion) == ptr
///         self.rule = rule    # rule
///         self.ptr = ptr      # ptr
///         self.start = start  # j
///         self.node = None    # w
///         if self.is_complete:
///             self.s = rule.origin
///             self.expect = None
///             self.previous = rule.expansion[ptr - 1] if ptr > 0 and len(rule.expansion) else None
///         else:
///             self.s = (rule, ptr)
///             self.expect = rule.expansion[ptr]
///             self.previous = rule.expansion[ptr - 1] if ptr > 0 and len(rule.expansion) else None
///         self._hash = hash((self.s, self.start))
///
///     def advance(self):
///         return Item(self.rule, self.ptr + 1, self.start)
///
///     def __eq__(self, other):
///         return self is other or (self.s == other.s and self.start == other.start)
///
///     def __hash__(self):
///         return self._hash
///
///     def __repr__(self):
///         before = ( expansion.name for expansion in self.rule.expansion[:self.ptr] )
///         after = ( expansion.name for expansion in self.rule.expansion[self.ptr:] )
///         symbol = "{} ::= {}* {}".format(self.rule.origin.name, ' '.join(before), ' '.join(after))
///         return '%s (%d)' % (symbol, self.start)
/// ```
final class Item extends PythonClass {
  factory Item({
    required Object? rule,
    required Object? ptr,
    required Object? start,
  }) =>
      PythonFfi.instance.importClass(
        "lark.tree_matcher",
        "Item",
        Item.from,
        <Object?>[
          rule,
          ptr,
          start,
        ],
        <String, Object?>{},
      );

  Item.from(super.pythonClass) : super.from();

  /// ## advance
  ///
  /// ### python source
  /// ```py
  /// def advance(self):
  ///         return Item(self.rule, self.ptr + 1, self.start)
  /// ```
  Object? advance() => getFunction("advance").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## expect (getter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  Object? get expect => getAttribute("expect");

  /// ## expect (setter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  set expect(Object? expect) => setAttribute("expect", expect);

  /// ## is_complete (getter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  Object? get is_complete => getAttribute("is_complete");

  /// ## is_complete (setter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  set is_complete(Object? is_complete) =>
      setAttribute("is_complete", is_complete);

  /// ## node (getter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  Object? get node => getAttribute("node");

  /// ## node (setter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  set node(Object? node) => setAttribute("node", node);

  /// ## previous (getter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  Object? get previous => getAttribute("previous");

  /// ## previous (setter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  set previous(Object? previous) => setAttribute("previous", previous);

  /// ## ptr (getter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  Object? get ptr => getAttribute("ptr");

  /// ## ptr (setter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  set ptr(Object? ptr) => setAttribute("ptr", ptr);

  /// ## rule (getter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  Object? get rule => getAttribute("rule");

  /// ## rule (setter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  set rule(Object? rule) => setAttribute("rule", rule);

  /// ## s (getter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  Object? get s => getAttribute("s");

  /// ## s (setter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  set s(Object? s) => setAttribute("s", s);

  /// ## start (getter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  Object? get start => getAttribute("start");

  /// ## start (setter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  set start(Object? start) => setAttribute("start", start);
}

/// ## Parser
///
/// ### python source
/// ```py
/// class Parser:
///     lexer_conf: 'LexerConf'
///     parser_conf: 'ParserConf'
///     debug: bool
///
///     def __init__(self, lexer_conf: 'LexerConf', parser_conf: 'ParserConf', term_matcher, resolve_ambiguity=True, debug=False, tree_class=Tree):
///         analysis = GrammarAnalyzer(parser_conf)
///         self.lexer_conf = lexer_conf
///         self.parser_conf = parser_conf
///         self.resolve_ambiguity = resolve_ambiguity
///         self.debug = debug
///         self.tree_class = tree_class
///
///         self.FIRST = analysis.FIRST
///         self.NULLABLE = analysis.NULLABLE
///         self.callbacks = parser_conf.callbacks
///         # TODO add typing info
///         self.predictions = {}   # type: ignore[var-annotated]
///
///         ## These could be moved to the grammar analyzer. Pre-computing these is *much* faster than
///         #  the slow 'isupper' in is_terminal.
///         self.TERMINALS = { sym for r in parser_conf.rules for sym in r.expansion if sym.is_term }
///         self.NON_TERMINALS = { sym for r in parser_conf.rules for sym in r.expansion if not sym.is_term }
///
///         self.forest_sum_visitor = None
///         for rule in parser_conf.rules:
///             if rule.origin not in self.predictions:
///                 self.predictions[rule.origin] = [x.rule for x in analysis.expand_rule(rule.origin)]
///
///             ## Detect if any rules/terminals have priorities set. If the user specified priority = None, then
///             #  the priorities will be stripped from all rules/terminals before they reach us, allowing us to
///             #  skip the extra tree walk. We'll also skip this if the user just didn't specify priorities
///             #  on any rules/terminals.
///             if self.forest_sum_visitor is None and rule.options.priority is not None:
///                 self.forest_sum_visitor = ForestSumVisitor
///
///         # Check terminals for priorities
///         # Ignore terminal priorities if the basic lexer is used
///         if self.lexer_conf.lexer_type != 'basic' and self.forest_sum_visitor is None:
///             for term in self.lexer_conf.terminals:
///                 if term.priority:
///                     self.forest_sum_visitor = ForestSumVisitor
///                     break
///
///         self.term_matcher = term_matcher
///
///
///     def predict_and_complete(self, i, to_scan, columns, transitives):
///         """The core Earley Predictor and Completer.
///
///         At each stage of the input, we handling any completed items (things
///         that matched on the last cycle) and use those to predict what should
///         come next in the input stream. The completions and any predicted
///         non-terminals are recursively processed until we reach a set of,
///         which can be added to the scan list for the next scanner cycle."""
///         # Held Completions (H in E.Scotts paper).
///         node_cache = {}
///         held_completions = {}
///
///         column = columns[i]
///         # R (items) = Ei (column.items)
///         items = deque(column)
///         while items:
///             item = items.pop()    # remove an element, A say, from R
///
///             ### The Earley completer
///             if item.is_complete:   ### (item.s == string)
///                 if item.node is None:
///                     label = (item.s, item.start, i)
///                     item.node = node_cache[label] if label in node_cache else node_cache.setdefault(label, SymbolNode(*label))
///                     item.node.add_family(item.s, item.rule, item.start, None, None)
///
///                 # create_leo_transitives(item.rule.origin, item.start)
///
///                 ###R Joop Leo right recursion Completer
///                 if item.rule.origin in transitives[item.start]:
///                     transitive = transitives[item.start][item.s]
///                     if transitive.previous in transitives[transitive.column]:
///                         root_transitive = transitives[transitive.column][transitive.previous]
///                     else:
///                         root_transitive = transitive
///
///                     new_item = Item(transitive.rule, transitive.ptr, transitive.start)
///                     label = (root_transitive.s, root_transitive.start, i)
///                     new_item.node = node_cache[label] if label in node_cache else node_cache.setdefault(label, SymbolNode(*label))
///                     new_item.node.add_path(root_transitive, item.node)
///                     if new_item.expect in self.TERMINALS:
///                         # Add (B :: aC.B, h, y) to Q
///                         to_scan.add(new_item)
///                     elif new_item not in column:
///                         # Add (B :: aC.B, h, y) to Ei and R
///                         column.add(new_item)
///                         items.append(new_item)
///                 ###R Regular Earley completer
///                 else:
///                     # Empty has 0 length. If we complete an empty symbol in a particular
///                     # parse step, we need to be able to use that same empty symbol to complete
///                     # any predictions that result, that themselves require empty. Avoids
///                     # infinite recursion on empty symbols.
///                     # held_completions is 'H' in E.Scott's paper.
///                     is_empty_item = item.start == i
///                     if is_empty_item:
///                         held_completions[item.rule.origin] = item.node
///
///                     originators = [originator for originator in columns[item.start] if originator.expect is not None and originator.expect == item.s]
///                     for originator in originators:
///                         new_item = originator.advance()
///                         label = (new_item.s, originator.start, i)
///                         new_item.node = node_cache[label] if label in node_cache else node_cache.setdefault(label, SymbolNode(*label))
///                         new_item.node.add_family(new_item.s, new_item.rule, i, originator.node, item.node)
///                         if new_item.expect in self.TERMINALS:
///                             # Add (B :: aC.B, h, y) to Q
///                             to_scan.add(new_item)
///                         elif new_item not in column:
///                             # Add (B :: aC.B, h, y) to Ei and R
///                             column.add(new_item)
///                             items.append(new_item)
///
///             ### The Earley predictor
///             elif item.expect in self.NON_TERMINALS: ### (item.s == lr0)
///                 new_items = []
///                 for rule in self.predictions[item.expect]:
///                     new_item = Item(rule, 0, i)
///                     new_items.append(new_item)
///
///                 # Process any held completions (H).
///                 if item.expect in held_completions:
///                     new_item = item.advance()
///                     label = (new_item.s, item.start, i)
///                     new_item.node = node_cache[label] if label in node_cache else node_cache.setdefault(label, SymbolNode(*label))
///                     new_item.node.add_family(new_item.s, new_item.rule, new_item.start, item.node, held_completions[item.expect])
///                     new_items.append(new_item)
///
///                 for new_item in new_items:
///                     if new_item.expect in self.TERMINALS:
///                         to_scan.add(new_item)
///                     elif new_item not in column:
///                         column.add(new_item)
///                         items.append(new_item)
///
///     def _parse(self, lexer, columns, to_scan, start_symbol=None):
///         def is_quasi_complete(item):
///             if item.is_complete:
///                 return True
///
///             quasi = item.advance()
///             while not quasi.is_complete:
///                 if quasi.expect not in self.NULLABLE:
///                     return False
///                 if quasi.rule.origin == start_symbol and quasi.expect == start_symbol:
///                     return False
///                 quasi = quasi.advance()
///             return True
///
///         # def create_leo_transitives(origin, start):
///         #   ...   # removed at commit 4c1cfb2faf24e8f8bff7112627a00b94d261b420
///
///         def scan(i, token, to_scan):
///             """The core Earley Scanner.
///
///             This is a custom implementation of the scanner that uses the
///             Lark lexer to match tokens. The scan list is built by the
///             Earley predictor, based on the previously completed tokens.
///             This ensures that at each phase of the parse we have a custom
///             lexer context, allowing for more complex ambiguities."""
///             next_to_scan = set()
///             next_set = set()
///             columns.append(next_set)
///             transitives.append({})
///             node_cache = {}
///
///             for item in set(to_scan):
///                 if match(item.expect, token):
///                     new_item = item.advance()
///                     label = (new_item.s, new_item.start, i)
///                     # 'terminals' may not contain token.type when using %declare
///                     # Additionally, token is not always a Token
///                     # For example, it can be a Tree when using TreeMatcher
///                     term = terminals.get(token.type) if isinstance(token, Token) else None
///                     # Set the priority of the token node to 0 so that the
///                     # terminal priorities do not affect the Tree chosen by
///                     # ForestSumVisitor after the basic lexer has already
///                     # "used up" the terminal priorities
///                     token_node = TokenNode(token, term, priority=0)
///                     new_item.node = node_cache[label] if label in node_cache else node_cache.setdefault(label, SymbolNode(*label))
///                     new_item.node.add_family(new_item.s, item.rule, new_item.start, item.node, token_node)
///
///                     if new_item.expect in self.TERMINALS:
///                         # add (B ::= Aai+1.B, h, y) to Q'
///                         next_to_scan.add(new_item)
///                     else:
///                         # add (B ::= Aa+1.B, h, y) to Ei+1
///                         next_set.add(new_item)
///
///             if not next_set and not next_to_scan:
///                 expect = {i.expect.name for i in to_scan}
///                 raise UnexpectedToken(token, expect, considered_rules=set(to_scan), state=frozenset(i.s for i in to_scan))
///
///             return next_to_scan
///
///
///         # Define parser functions
///         match = self.term_matcher
///
///         terminals = self.lexer_conf.terminals_by_name
///
///         # Cache for nodes & tokens created in a particular parse step.
///         transitives = [{}]
///
///         ## The main Earley loop.
///         # Run the Prediction/Completion cycle for any Items in the current Earley set.
///         # Completions will be added to the SPPF tree, and predictions will be recursively
///         # processed down to terminals/empty nodes to be added to the scanner for the next
///         # step.
///         expects = {i.expect for i in to_scan}
///         i = 0
///         for token in lexer.lex(expects):
///             self.predict_and_complete(i, to_scan, columns, transitives)
///
///             to_scan = scan(i, token, to_scan)
///             i += 1
///
///             expects.clear()
///             expects |= {i.expect for i in to_scan}
///
///         self.predict_and_complete(i, to_scan, columns, transitives)
///
///         ## Column is now the final column in the parse.
///         assert i == len(columns)-1
///         return to_scan
///
///     def parse(self, lexer, start):
///         assert start, start
///         start_symbol = NonTerminal(start)
///
///         columns = [set()]
///         to_scan = set()     # The scan buffer. 'Q' in E.Scott's paper.
///
///         ## Predict for the start_symbol.
///         # Add predicted items to the first Earley set (for the predictor) if they
///         # result in a non-terminal, or the scanner if they result in a terminal.
///         for rule in self.predictions[start_symbol]:
///             item = Item(rule, 0, 0)
///             if item.expect in self.TERMINALS:
///                 to_scan.add(item)
///             else:
///                 columns[0].add(item)
///
///         to_scan = self._parse(lexer, columns, to_scan, start_symbol)
///
///         # If the parse was successful, the start
///         # symbol should have been completed in the last step of the Earley cycle, and will be in
///         # this column. Find the item for the start_symbol, which is the root of the SPPF tree.
///         solutions = [n.node for n in columns[-1] if n.is_complete and n.node is not None and n.s == start_symbol and n.start == 0]
///         if not solutions:
///             expected_terminals = [t.expect.name for t in to_scan]
///             raise UnexpectedEOF(expected_terminals, state=frozenset(i.s for i in to_scan))
///
///         if self.debug:
///             from .earley_forest import ForestToPyDotVisitor
///             try:
///                 debug_walker = ForestToPyDotVisitor()
///             except ImportError:
///                 logger.warning("Cannot find dependency 'pydot', will not generate sppf debug image")
///             else:
///                 debug_walker.visit(solutions[0], "sppf.png")
///
///
///         if len(solutions) > 1:
///             assert False, 'Earley should not generate multiple start symbol items!'
///
///         if self.tree_class is not None:
///             # Perform our SPPF -> AST conversion
///             transformer = ForestToParseTree(self.tree_class, self.callbacks, self.forest_sum_visitor and self.forest_sum_visitor(), self.resolve_ambiguity)
///             return transformer.transform(solutions[0])
///
///         # return the root of the SPPF
///         return solutions[0]
/// ```
final class Parser extends PythonClass {
  factory Parser({
    required Object? lexer_conf,
    required Object? parser_conf,
    required Object? term_matcher,
    Object? resolve_ambiguity = true,
    Object? debug = false,
    Object? tree_class,
  }) =>
      PythonFfi.instance.importClass(
        "lark.tree_matcher",
        "Parser",
        Parser.from,
        <Object?>[
          lexer_conf,
          parser_conf,
          term_matcher,
          resolve_ambiguity,
          debug,
          tree_class,
        ],
        <String, Object?>{},
      );

  Parser.from(super.pythonClass) : super.from();

  /// ## parse
  ///
  /// ### python source
  /// ```py
  /// def parse(self, lexer, start):
  ///         assert start, start
  ///         start_symbol = NonTerminal(start)
  ///
  ///         columns = [set()]
  ///         to_scan = set()     # The scan buffer. 'Q' in E.Scott's paper.
  ///
  ///         ## Predict for the start_symbol.
  ///         # Add predicted items to the first Earley set (for the predictor) if they
  ///         # result in a non-terminal, or the scanner if they result in a terminal.
  ///         for rule in self.predictions[start_symbol]:
  ///             item = Item(rule, 0, 0)
  ///             if item.expect in self.TERMINALS:
  ///                 to_scan.add(item)
  ///             else:
  ///                 columns[0].add(item)
  ///
  ///         to_scan = self._parse(lexer, columns, to_scan, start_symbol)
  ///
  ///         # If the parse was successful, the start
  ///         # symbol should have been completed in the last step of the Earley cycle, and will be in
  ///         # this column. Find the item for the start_symbol, which is the root of the SPPF tree.
  ///         solutions = [n.node for n in columns[-1] if n.is_complete and n.node is not None and n.s == start_symbol and n.start == 0]
  ///         if not solutions:
  ///             expected_terminals = [t.expect.name for t in to_scan]
  ///             raise UnexpectedEOF(expected_terminals, state=frozenset(i.s for i in to_scan))
  ///
  ///         if self.debug:
  ///             from .earley_forest import ForestToPyDotVisitor
  ///             try:
  ///                 debug_walker = ForestToPyDotVisitor()
  ///             except ImportError:
  ///                 logger.warning("Cannot find dependency 'pydot', will not generate sppf debug image")
  ///             else:
  ///                 debug_walker.visit(solutions[0], "sppf.png")
  ///
  ///
  ///         if len(solutions) > 1:
  ///             assert False, 'Earley should not generate multiple start symbol items!'
  ///
  ///         if self.tree_class is not None:
  ///             # Perform our SPPF -> AST conversion
  ///             transformer = ForestToParseTree(self.tree_class, self.callbacks, self.forest_sum_visitor and self.forest_sum_visitor(), self.resolve_ambiguity)
  ///             return transformer.transform(solutions[0])
  ///
  ///         # return the root of the SPPF
  ///         return solutions[0]
  /// ```
  Object? parse({
    required Object? lexer,
    required Object? start,
  }) =>
      getFunction("parse").call(
        <Object?>[
          lexer,
          start,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## predict_and_complete
  ///
  /// ### python docstring
  ///
  /// The core Earley Predictor and Completer.
  ///
  /// At each stage of the input, we handling any completed items (things
  /// that matched on the last cycle) and use those to predict what should
  /// come next in the input stream. The completions and any predicted
  /// non-terminals are recursively processed until we reach a set of,
  /// which can be added to the scan list for the next scanner cycle.
  ///
  /// ### python source
  /// ```py
  /// def predict_and_complete(self, i, to_scan, columns, transitives):
  ///         """The core Earley Predictor and Completer.
  ///
  ///         At each stage of the input, we handling any completed items (things
  ///         that matched on the last cycle) and use those to predict what should
  ///         come next in the input stream. The completions and any predicted
  ///         non-terminals are recursively processed until we reach a set of,
  ///         which can be added to the scan list for the next scanner cycle."""
  ///         # Held Completions (H in E.Scotts paper).
  ///         node_cache = {}
  ///         held_completions = {}
  ///
  ///         column = columns[i]
  ///         # R (items) = Ei (column.items)
  ///         items = deque(column)
  ///         while items:
  ///             item = items.pop()    # remove an element, A say, from R
  ///
  ///             ### The Earley completer
  ///             if item.is_complete:   ### (item.s == string)
  ///                 if item.node is None:
  ///                     label = (item.s, item.start, i)
  ///                     item.node = node_cache[label] if label in node_cache else node_cache.setdefault(label, SymbolNode(*label))
  ///                     item.node.add_family(item.s, item.rule, item.start, None, None)
  ///
  ///                 # create_leo_transitives(item.rule.origin, item.start)
  ///
  ///                 ###R Joop Leo right recursion Completer
  ///                 if item.rule.origin in transitives[item.start]:
  ///                     transitive = transitives[item.start][item.s]
  ///                     if transitive.previous in transitives[transitive.column]:
  ///                         root_transitive = transitives[transitive.column][transitive.previous]
  ///                     else:
  ///                         root_transitive = transitive
  ///
  ///                     new_item = Item(transitive.rule, transitive.ptr, transitive.start)
  ///                     label = (root_transitive.s, root_transitive.start, i)
  ///                     new_item.node = node_cache[label] if label in node_cache else node_cache.setdefault(label, SymbolNode(*label))
  ///                     new_item.node.add_path(root_transitive, item.node)
  ///                     if new_item.expect in self.TERMINALS:
  ///                         # Add (B :: aC.B, h, y) to Q
  ///                         to_scan.add(new_item)
  ///                     elif new_item not in column:
  ///                         # Add (B :: aC.B, h, y) to Ei and R
  ///                         column.add(new_item)
  ///                         items.append(new_item)
  ///                 ###R Regular Earley completer
  ///                 else:
  ///                     # Empty has 0 length. If we complete an empty symbol in a particular
  ///                     # parse step, we need to be able to use that same empty symbol to complete
  ///                     # any predictions that result, that themselves require empty. Avoids
  ///                     # infinite recursion on empty symbols.
  ///                     # held_completions is 'H' in E.Scott's paper.
  ///                     is_empty_item = item.start == i
  ///                     if is_empty_item:
  ///                         held_completions[item.rule.origin] = item.node
  ///
  ///                     originators = [originator for originator in columns[item.start] if originator.expect is not None and originator.expect == item.s]
  ///                     for originator in originators:
  ///                         new_item = originator.advance()
  ///                         label = (new_item.s, originator.start, i)
  ///                         new_item.node = node_cache[label] if label in node_cache else node_cache.setdefault(label, SymbolNode(*label))
  ///                         new_item.node.add_family(new_item.s, new_item.rule, i, originator.node, item.node)
  ///                         if new_item.expect in self.TERMINALS:
  ///                             # Add (B :: aC.B, h, y) to Q
  ///                             to_scan.add(new_item)
  ///                         elif new_item not in column:
  ///                             # Add (B :: aC.B, h, y) to Ei and R
  ///                             column.add(new_item)
  ///                             items.append(new_item)
  ///
  ///             ### The Earley predictor
  ///             elif item.expect in self.NON_TERMINALS: ### (item.s == lr0)
  ///                 new_items = []
  ///                 for rule in self.predictions[item.expect]:
  ///                     new_item = Item(rule, 0, i)
  ///                     new_items.append(new_item)
  ///
  ///                 # Process any held completions (H).
  ///                 if item.expect in held_completions:
  ///                     new_item = item.advance()
  ///                     label = (new_item.s, item.start, i)
  ///                     new_item.node = node_cache[label] if label in node_cache else node_cache.setdefault(label, SymbolNode(*label))
  ///                     new_item.node.add_family(new_item.s, new_item.rule, new_item.start, item.node, held_completions[item.expect])
  ///                     new_items.append(new_item)
  ///
  ///                 for new_item in new_items:
  ///                     if new_item.expect in self.TERMINALS:
  ///                         to_scan.add(new_item)
  ///                     elif new_item not in column:
  ///                         column.add(new_item)
  ///                         items.append(new_item)
  /// ```
  Object? predict_and_complete({
    required Object? i,
    required Object? to_scan,
    required Object? columns,
    required Object? transitives,
  }) =>
      getFunction("predict_and_complete").call(
        <Object?>[
          i,
          to_scan,
          columns,
          transitives,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## lexer_conf (getter)
  Object? get lexer_conf => getAttribute("lexer_conf");

  /// ## lexer_conf (setter)
  set lexer_conf(Object? lexer_conf) => setAttribute("lexer_conf", lexer_conf);

  /// ## parser_conf (getter)
  Object? get parser_conf => getAttribute("parser_conf");

  /// ## parser_conf (setter)
  set parser_conf(Object? parser_conf) =>
      setAttribute("parser_conf", parser_conf);

  /// ## resolve_ambiguity (getter)
  Object? get resolve_ambiguity => getAttribute("resolve_ambiguity");

  /// ## resolve_ambiguity (setter)
  set resolve_ambiguity(Object? resolve_ambiguity) =>
      setAttribute("resolve_ambiguity", resolve_ambiguity);

  /// ## debug (getter)
  Object? get debug => getAttribute("debug");

  /// ## debug (setter)
  set debug(Object? debug) => setAttribute("debug", debug);

  /// ## tree_class (getter)
  Object? get tree_class => getAttribute("tree_class");

  /// ## tree_class (setter)
  set tree_class(Object? tree_class) => setAttribute("tree_class", tree_class);

  /// ## FIRST (getter)
  Object? get FIRST => getAttribute("FIRST");

  /// ## FIRST (setter)
  set FIRST(Object? FIRST) => setAttribute("FIRST", FIRST);

  /// ## NULLABLE (getter)
  Object? get NULLABLE => getAttribute("NULLABLE");

  /// ## NULLABLE (setter)
  set NULLABLE(Object? NULLABLE) => setAttribute("NULLABLE", NULLABLE);

  /// ## callbacks (getter)
  Object? get callbacks => getAttribute("callbacks");

  /// ## callbacks (setter)
  set callbacks(Object? callbacks) => setAttribute("callbacks", callbacks);

  /// ## predictions (getter)
  Object? get predictions => getAttribute("predictions");

  /// ## predictions (setter)
  set predictions(Object? predictions) =>
      setAttribute("predictions", predictions);

  /// ## TERMINALS (getter)
  Object? get TERMINALS => getAttribute("TERMINALS");

  /// ## TERMINALS (setter)
  set TERMINALS(Object? TERMINALS) => setAttribute("TERMINALS", TERMINALS);

  /// ## NON_TERMINALS (getter)
  Object? get NON_TERMINALS => getAttribute("NON_TERMINALS");

  /// ## NON_TERMINALS (setter)
  set NON_TERMINALS(Object? NON_TERMINALS) =>
      setAttribute("NON_TERMINALS", NON_TERMINALS);

  /// ## forest_sum_visitor (getter)
  Object? get forest_sum_visitor => getAttribute("forest_sum_visitor");

  /// ## forest_sum_visitor (setter)
  set forest_sum_visitor(Object? forest_sum_visitor) =>
      setAttribute("forest_sum_visitor", forest_sum_visitor);

  /// ## term_matcher (getter)
  Object? get term_matcher => getAttribute("term_matcher");

  /// ## term_matcher (setter)
  set term_matcher(Object? term_matcher) =>
      setAttribute("term_matcher", term_matcher);
}

/// ## SymbolNode
///
/// ### python docstring
///
/// A Symbol Node represents a symbol (or Intermediate LR0).
///
/// Symbol nodes are keyed by the symbol (s). For intermediate nodes
/// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
/// nodes, s will be a string representing the non-terminal origin (i.e.
/// the left hand side of the rule).
///
/// The children of a Symbol or Intermediate Node will always be Packed Nodes;
/// with each Packed Node child representing a single derivation of a production.
///
/// Hence a Symbol Node with a single child is unambiguous.
///
/// Parameters:
///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
///     start: The index of the start of the substring matched by this symbol (inclusive).
///     end: The index of the end of the substring matched by this symbol (exclusive).
///
/// Properties:
///     is_intermediate: True if this node is an intermediate node.
///     priority: The priority of the node's symbol.
///
/// ### python source
/// ```py
/// class SymbolNode(ForestNode):
///     """
///     A Symbol Node represents a symbol (or Intermediate LR0).
///
///     Symbol nodes are keyed by the symbol (s). For intermediate nodes
///     s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
///     nodes, s will be a string representing the non-terminal origin (i.e.
///     the left hand side of the rule).
///
///     The children of a Symbol or Intermediate Node will always be Packed Nodes;
///     with each Packed Node child representing a single derivation of a production.
///
///     Hence a Symbol Node with a single child is unambiguous.
///
///     Parameters:
///         s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
///         start: The index of the start of the substring matched by this symbol (inclusive).
///         end: The index of the end of the substring matched by this symbol (exclusive).
///
///     Properties:
///         is_intermediate: True if this node is an intermediate node.
///         priority: The priority of the node's symbol.
///     """
///     __slots__ = ('s', 'start', 'end', '_children', 'paths', 'paths_loaded', 'priority', 'is_intermediate', '_hash')
///     def __init__(self, s, start, end):
///         self.s = s
///         self.start = start
///         self.end = end
///         self._children = set()
///         self.paths = set()
///         self.paths_loaded = False
///
///         ### We use inf here as it can be safely negated without resorting to conditionals,
///         #   unlike None or float('NaN'), and sorts appropriately.
///         self.priority = float('-inf')
///         self.is_intermediate = isinstance(s, tuple)
///         self._hash = hash((self.s, self.start, self.end))
///
///     def add_family(self, lr0, rule, start, left, right):
///         self._children.add(PackedNode(self, lr0, rule, start, left, right))
///
///     def add_path(self, transitive, node):
///         self.paths.add((transitive, node))
///
///     def load_paths(self):
///         for transitive, node in self.paths:
///             if transitive.next_titem is not None:
///                 vn = SymbolNode(transitive.next_titem.s, transitive.next_titem.start, self.end)
///                 vn.add_path(transitive.next_titem, node)
///                 self.add_family(transitive.reduction.rule.origin, transitive.reduction.rule, transitive.reduction.start, transitive.reduction.node, vn)
///             else:
///                 self.add_family(transitive.reduction.rule.origin, transitive.reduction.rule, transitive.reduction.start, transitive.reduction.node, node)
///         self.paths_loaded = True
///
///     @property
///     def is_ambiguous(self):
///         """Returns True if this node is ambiguous."""
///         return len(self.children) > 1
///
///     @property
///     def children(self):
///         """Returns a list of this node's children sorted from greatest to
///         least priority."""
///         if not self.paths_loaded:
///             self.load_paths()
///         return sorted(self._children, key=attrgetter('sort_key'))
///
///     def __iter__(self):
///         return iter(self._children)
///
///     def __eq__(self, other):
///         if not isinstance(other, SymbolNode):
///             return False
///         return self is other or (type(self.s) == type(other.s) and self.s == other.s and self.start == other.start and self.end is other.end)
///
///     def __hash__(self):
///         return self._hash
///
///     def __repr__(self):
///         if self.is_intermediate:
///             rule = self.s[0]
///             ptr = self.s[1]
///             before = ( expansion.name for expansion in rule.expansion[:ptr] )
///             after = ( expansion.name for expansion in rule.expansion[ptr:] )
///             symbol = "{} ::= {}* {}".format(rule.origin.name, ' '.join(before), ' '.join(after))
///         else:
///             symbol = self.s.name
///         return "({}, {}, {}, {})".format(symbol, self.start, self.end, self.priority)
/// ```
final class SymbolNode extends PythonClass {
  factory SymbolNode({
    required Object? s,
    required Object? start,
    required Object? end,
  }) =>
      PythonFfi.instance.importClass(
        "lark.tree_matcher",
        "SymbolNode",
        SymbolNode.from,
        <Object?>[
          s,
          start,
          end,
        ],
        <String, Object?>{},
      );

  SymbolNode.from(super.pythonClass) : super.from();

  /// ## add_family
  ///
  /// ### python source
  /// ```py
  /// def add_family(self, lr0, rule, start, left, right):
  ///         self._children.add(PackedNode(self, lr0, rule, start, left, right))
  /// ```
  Object? add_family({
    required Object? lr0,
    required Object? rule,
    required Object? start,
    required Object? left,
    required Object? right,
  }) =>
      getFunction("add_family").call(
        <Object?>[
          lr0,
          rule,
          start,
          left,
          right,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## add_path
  ///
  /// ### python source
  /// ```py
  /// def add_path(self, transitive, node):
  ///         self.paths.add((transitive, node))
  /// ```
  Object? add_path({
    required Object? transitive,
    required Object? node,
  }) =>
      getFunction("add_path").call(
        <Object?>[
          transitive,
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## load_paths
  ///
  /// ### python source
  /// ```py
  /// def load_paths(self):
  ///         for transitive, node in self.paths:
  ///             if transitive.next_titem is not None:
  ///                 vn = SymbolNode(transitive.next_titem.s, transitive.next_titem.start, self.end)
  ///                 vn.add_path(transitive.next_titem, node)
  ///                 self.add_family(transitive.reduction.rule.origin, transitive.reduction.rule, transitive.reduction.start, transitive.reduction.node, vn)
  ///             else:
  ///                 self.add_family(transitive.reduction.rule.origin, transitive.reduction.rule, transitive.reduction.start, transitive.reduction.node, node)
  ///         self.paths_loaded = True
  /// ```
  Object? load_paths() => getFunction("load_paths").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## children (getter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  Object? get children => getAttribute("children");

  /// ## children (setter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  set children(Object? children) => setAttribute("children", children);

  /// ## is_ambiguous (getter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  Object? get is_ambiguous => getAttribute("is_ambiguous");

  /// ## is_ambiguous (setter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  set is_ambiguous(Object? is_ambiguous) =>
      setAttribute("is_ambiguous", is_ambiguous);

  /// ## end (getter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  Object? get end => getAttribute("end");

  /// ## end (setter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  set end(Object? end) => setAttribute("end", end);

  /// ## is_intermediate (getter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  Object? get is_intermediate => getAttribute("is_intermediate");

  /// ## is_intermediate (setter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  set is_intermediate(Object? is_intermediate) =>
      setAttribute("is_intermediate", is_intermediate);

  /// ## paths (getter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  Object? get paths => getAttribute("paths");

  /// ## paths (setter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  set paths(Object? paths) => setAttribute("paths", paths);

  /// ## paths_loaded (getter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  Object? get paths_loaded => getAttribute("paths_loaded");

  /// ## paths_loaded (setter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  set paths_loaded(Object? paths_loaded) =>
      setAttribute("paths_loaded", paths_loaded);

  /// ## priority (getter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  Object? get priority => getAttribute("priority");

  /// ## priority (setter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  set priority(Object? priority) => setAttribute("priority", priority);

  /// ## s (getter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  Object? get s => getAttribute("s");

  /// ## s (setter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  set s(Object? s) => setAttribute("s", s);

  /// ## start (getter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  Object? get start => getAttribute("start");

  /// ## start (setter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  set start(Object? start) => setAttribute("start", start);
}

/// ## TokenNode
///
/// ### python docstring
///
/// A Token Node represents a matched terminal and is always a leaf node.
///
/// Parameters:
///     token: The Token associated with this node.
///     term: The TerminalDef matched by the token.
///     priority: The priority of this node.
///
/// ### python source
/// ```py
/// class TokenNode(ForestNode):
///     """
///     A Token Node represents a matched terminal and is always a leaf node.
///
///     Parameters:
///         token: The Token associated with this node.
///         term: The TerminalDef matched by the token.
///         priority: The priority of this node.
///     """
///     __slots__ = ('token', 'term', 'priority', '_hash')
///     def __init__(self, token, term, priority=None):
///         self.token = token
///         self.term = term
///         if priority is not None:
///             self.priority = priority
///         else:
///             self.priority = term.priority if term is not None else 0
///         self._hash = hash(token)
///
///     def __eq__(self, other):
///         if not isinstance(other, TokenNode):
///             return False
///         return self is other or (self.token == other.token)
///
///     def __hash__(self):
///         return self._hash
///
///     def __repr__(self):
///         return repr(self.token)
/// ```
final class TokenNode extends PythonClass {
  factory TokenNode({
    required Object? token,
    required Object? term,
    Object? priority,
  }) =>
      PythonFfi.instance.importClass(
        "lark.tree_matcher",
        "TokenNode",
        TokenNode.from,
        <Object?>[
          token,
          term,
          priority,
        ],
        <String, Object?>{},
      );

  TokenNode.from(super.pythonClass) : super.from();

  /// ## priority (getter)
  ///
  /// ### python docstring
  ///
  /// A Token Node represents a matched terminal and is always a leaf node.
  ///
  /// Parameters:
  ///     token: The Token associated with this node.
  ///     term: The TerminalDef matched by the token.
  ///     priority: The priority of this node.
  Object? get priority => getAttribute("priority");

  /// ## priority (setter)
  ///
  /// ### python docstring
  ///
  /// A Token Node represents a matched terminal and is always a leaf node.
  ///
  /// Parameters:
  ///     token: The Token associated with this node.
  ///     term: The TerminalDef matched by the token.
  ///     priority: The priority of this node.
  set priority(Object? priority) => setAttribute("priority", priority);

  /// ## term (getter)
  ///
  /// ### python docstring
  ///
  /// A Token Node represents a matched terminal and is always a leaf node.
  ///
  /// Parameters:
  ///     token: The Token associated with this node.
  ///     term: The TerminalDef matched by the token.
  ///     priority: The priority of this node.
  Object? get term => getAttribute("term");

  /// ## term (setter)
  ///
  /// ### python docstring
  ///
  /// A Token Node represents a matched terminal and is always a leaf node.
  ///
  /// Parameters:
  ///     token: The Token associated with this node.
  ///     term: The TerminalDef matched by the token.
  ///     priority: The priority of this node.
  set term(Object? term) => setAttribute("term", term);

  /// ## token (getter)
  ///
  /// ### python docstring
  ///
  /// A Token Node represents a matched terminal and is always a leaf node.
  ///
  /// Parameters:
  ///     token: The Token associated with this node.
  ///     term: The TerminalDef matched by the token.
  ///     priority: The priority of this node.
  Object? get token => getAttribute("token");

  /// ## token (setter)
  ///
  /// ### python docstring
  ///
  /// A Token Node represents a matched terminal and is always a leaf node.
  ///
  /// Parameters:
  ///     token: The Token associated with this node.
  ///     term: The TerminalDef matched by the token.
  ///     priority: The priority of this node.
  set token(Object? token) => setAttribute("token", token);
}

/// ## UnexpectedEOF
///
/// ### python docstring
///
/// An exception that is raised by the parser, when the input ends while it still expects a token.
///
/// ### python source
/// ```py
/// class UnexpectedEOF(ParseError, UnexpectedInput):
///     """An exception that is raised by the parser, when the input ends while it still expects a token.
///     """
///     expected: 'List[Token]'
///
///     def __init__(self, expected, state=None, terminals_by_name=None):
///         super(UnexpectedEOF, self).__init__()
///
///         self.expected = expected
///         self.state = state
///         from .lexer import Token
///         self.token = Token("<EOF>", "")  # , line=-1, column=-1, pos_in_stream=-1)
///         self.pos_in_stream = -1
///         self.line = -1
///         self.column = -1
///         self._terminals_by_name = terminals_by_name
///
///
///     def __str__(self):
///         message = "Unexpected end-of-input. "
///         message += self._format_expected(self.expected)
///         return message
/// ```
final class UnexpectedEOF extends PythonClass {
  factory UnexpectedEOF({
    required Object? expected,
    Object? state,
    Object? terminals_by_name,
  }) =>
      PythonFfi.instance.importClass(
        "lark.tree_matcher",
        "UnexpectedEOF",
        UnexpectedEOF.from,
        <Object?>[
          expected,
          state,
          terminals_by_name,
        ],
        <String, Object?>{},
      );

  UnexpectedEOF.from(super.pythonClass) : super.from();

  /// ## get_context
  ///
  /// ### python docstring
  ///
  /// Returns a pretty string pinpointing the error in the text,
  /// with span amount of context characters around it.
  ///
  /// Note:
  ///     The parser doesn't hold a copy of the text it has to parse,
  ///     so you have to provide it again
  ///
  /// ### python source
  /// ```py
  /// def get_context(self, text: str, span: int=40) -> str:
  ///         """Returns a pretty string pinpointing the error in the text,
  ///         with span amount of context characters around it.
  ///
  ///         Note:
  ///             The parser doesn't hold a copy of the text it has to parse,
  ///             so you have to provide it again
  ///         """
  ///         assert self.pos_in_stream is not None, self
  ///         pos = self.pos_in_stream
  ///         start = max(pos - span, 0)
  ///         end = pos + span
  ///         if not isinstance(text, bytes):
  ///             before = text[start:pos].rsplit('\n', 1)[-1]
  ///             after = text[pos:end].split('\n', 1)[0]
  ///             return before + after + '\n' + ' ' * len(before.expandtabs()) + '^\n'
  ///         else:
  ///             before = text[start:pos].rsplit(b'\n', 1)[-1]
  ///             after = text[pos:end].split(b'\n', 1)[0]
  ///             return (before + after + b'\n' + b' ' * len(before.expandtabs()) + b'^\n').decode("ascii", "backslashreplace")
  /// ```
  String get_context({
    required String text,
    int span = 40,
  }) =>
      getFunction("get_context").call(
        <Object?>[
          text,
          span,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## match_examples
  ///
  /// ### python docstring
  ///
  /// Allows you to detect what's wrong in the input text by matching
  /// against example errors.
  ///
  /// Given a parser instance and a dictionary mapping some label with
  /// some malformed syntax examples, it'll return the label for the
  /// example that bests matches the current error. The function will
  /// iterate the dictionary until it finds a matching error, and
  /// return the corresponding value.
  ///
  /// For an example usage, see `examples/error_reporting_lalr.py`
  ///
  /// Parameters:
  ///     parse_fn: parse function (usually ``lark_instance.parse``)
  ///     examples: dictionary of ``{'example_string': value}``.
  ///     use_accepts: Recommended to keep this as ``use_accepts=True``.
  ///
  /// ### python source
  /// ```py
  /// def match_examples(self, parse_fn: 'Callable[[str], Tree]',
  ///                              examples: Union[Mapping[T, Iterable[str]], Iterable[Tuple[T, Iterable[str]]]],
  ///                              token_type_match_fallback: bool=False,
  ///                              use_accepts: bool=True
  ///                          ) -> Optional[T]:
  ///         """Allows you to detect what's wrong in the input text by matching
  ///         against example errors.
  ///
  ///         Given a parser instance and a dictionary mapping some label with
  ///         some malformed syntax examples, it'll return the label for the
  ///         example that bests matches the current error. The function will
  ///         iterate the dictionary until it finds a matching error, and
  ///         return the corresponding value.
  ///
  ///         For an example usage, see `examples/error_reporting_lalr.py`
  ///
  ///         Parameters:
  ///             parse_fn: parse function (usually ``lark_instance.parse``)
  ///             examples: dictionary of ``{'example_string': value}``.
  ///             use_accepts: Recommended to keep this as ``use_accepts=True``.
  ///         """
  ///         assert self.state is not None, "Not supported for this exception"
  ///
  ///         if isinstance(examples, Mapping):
  ///             examples = examples.items()
  ///
  ///         candidate = (None, False)
  ///         for i, (label, example) in enumerate(examples):
  ///             assert not isinstance(example, str), "Expecting a list"
  ///
  ///             for j, malformed in enumerate(example):
  ///                 try:
  ///                     parse_fn(malformed)
  ///                 except UnexpectedInput as ut:
  ///                     if ut.state == self.state:
  ///                         if (
  ///                             use_accepts
  ///                             and isinstance(self, UnexpectedToken)
  ///                             and isinstance(ut, UnexpectedToken)
  ///                             and ut.accepts != self.accepts
  ///                         ):
  ///                             logger.debug("Different accepts with same state[%d]: %s != %s at example [%s][%s]" %
  ///                                          (self.state, self.accepts, ut.accepts, i, j))
  ///                             continue
  ///                         if (
  ///                             isinstance(self, (UnexpectedToken, UnexpectedEOF))
  ///                             and isinstance(ut, (UnexpectedToken, UnexpectedEOF))
  ///                         ):
  ///                             if ut.token == self.token:  # Try exact match first
  ///                                 logger.debug("Exact Match at example [%s][%s]" % (i, j))
  ///                                 return label
  ///
  ///                             if token_type_match_fallback:
  ///                                 # Fallback to token types match
  ///                                 if (ut.token.type == self.token.type) and not candidate[-1]:
  ///                                     logger.debug("Token Type Fallback at example [%s][%s]" % (i, j))
  ///                                     candidate = label, True
  ///
  ///                         if candidate[0] is None:
  ///                             logger.debug("Same State match at example [%s][%s]" % (i, j))
  ///                             candidate = label, False
  ///
  ///         return candidate[0]
  /// ```
  Object? match_examples({
    required Object? parse_fn,
    required Object? examples,
    bool token_type_match_fallback = false,
    bool use_accepts = true,
  }) =>
      getFunction("match_examples").call(
        <Object?>[
          parse_fn,
          examples,
          token_type_match_fallback,
          use_accepts,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the input ends while it still expects a token.
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the input ends while it still expects a token.
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the input ends while it still expects a token.
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the input ends while it still expects a token.
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the input ends while it still expects a token.
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the input ends while it still expects a token.
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);

  /// ## pos_in_stream (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the input ends while it still expects a token.
  Object? get pos_in_stream => getAttribute("pos_in_stream");

  /// ## pos_in_stream (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the input ends while it still expects a token.
  set pos_in_stream(Object? pos_in_stream) =>
      setAttribute("pos_in_stream", pos_in_stream);

  /// ## expected (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the input ends while it still expects a token.
  Object? get expected => getAttribute("expected");

  /// ## expected (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the input ends while it still expects a token.
  set expected(Object? expected) => setAttribute("expected", expected);

  /// ## state (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the input ends while it still expects a token.
  Object? get state => getAttribute("state");

  /// ## state (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the input ends while it still expects a token.
  set state(Object? state) => setAttribute("state", state);

  /// ## token (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the input ends while it still expects a token.
  Object? get token => getAttribute("token");

  /// ## token (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the input ends while it still expects a token.
  set token(Object? token) => setAttribute("token", token);

  /// ## line (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the input ends while it still expects a token.
  Object? get line => getAttribute("line");

  /// ## line (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the input ends while it still expects a token.
  set line(Object? line) => setAttribute("line", line);

  /// ## column (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the input ends while it still expects a token.
  Object? get column => getAttribute("column");

  /// ## column (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the input ends while it still expects a token.
  set column(Object? column) => setAttribute("column", column);
}

/// ## UnexpectedToken
///
/// ### python docstring
///
/// An exception that is raised by the parser, when the token it received
/// doesn't match any valid step forward.
///
/// Parameters:
///     token: The mismatched token
///     expected: The set of expected tokens
///     considered_rules: Which rules were considered, to deduce the expected tokens
///     state: A value representing the parser state. Do not rely on its value or type.
///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
///                         and can be used for debugging and error handling.
///
/// Note: These parameters are available as attributes of the instance.
///
/// ### python source
/// ```py
/// class UnexpectedToken(ParseError, UnexpectedInput):
///     """An exception that is raised by the parser, when the token it received
///     doesn't match any valid step forward.
///
///     Parameters:
///         token: The mismatched token
///         expected: The set of expected tokens
///         considered_rules: Which rules were considered, to deduce the expected tokens
///         state: A value representing the parser state. Do not rely on its value or type.
///         interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
///                             and can be used for debugging and error handling.
///
///     Note: These parameters are available as attributes of the instance.
///     """
///
///     expected: Set[str]
///     considered_rules: Set[str]
///     interactive_parser: 'InteractiveParser'
///
///     def __init__(self, token, expected, considered_rules=None, state=None, interactive_parser=None, terminals_by_name=None, token_history=None):
///         super(UnexpectedToken, self).__init__()
///
///         # TODO considered_rules and expected can be figured out using state
///         self.line = getattr(token, 'line', '?')
///         self.column = getattr(token, 'column', '?')
///         self.pos_in_stream = getattr(token, 'start_pos', None)
///         self.state = state
///
///         self.token = token
///         self.expected = expected  # XXX deprecate? `accepts` is better
///         self._accepts = NO_VALUE
///         self.considered_rules = considered_rules
///         self.interactive_parser = interactive_parser
///         self._terminals_by_name = terminals_by_name
///         self.token_history = token_history
///
///
///     @property
///     def accepts(self) -> Set[str]:
///         if self._accepts is NO_VALUE:
///             self._accepts = self.interactive_parser and self.interactive_parser.accepts()
///         return self._accepts
///
///     def __str__(self):
///         message = ("Unexpected token %r at line %s, column %s.\n%s"
///                    % (self.token, self.line, self.column, self._format_expected(self.accepts or self.expected)))
///         if self.token_history:
///             message += "Previous tokens: %r\n" % self.token_history
///
///         return message
/// ```
final class UnexpectedToken extends PythonClass {
  factory UnexpectedToken({
    required Object? token,
    required Object? expected,
    Object? considered_rules,
    Object? state,
    Object? interactive_parser,
    Object? terminals_by_name,
    Object? token_history,
  }) =>
      PythonFfi.instance.importClass(
        "lark.tree_matcher",
        "UnexpectedToken",
        UnexpectedToken.from,
        <Object?>[
          token,
          expected,
          considered_rules,
          state,
          interactive_parser,
          terminals_by_name,
          token_history,
        ],
        <String, Object?>{},
      );

  UnexpectedToken.from(super.pythonClass) : super.from();

  /// ## get_context
  ///
  /// ### python docstring
  ///
  /// Returns a pretty string pinpointing the error in the text,
  /// with span amount of context characters around it.
  ///
  /// Note:
  ///     The parser doesn't hold a copy of the text it has to parse,
  ///     so you have to provide it again
  ///
  /// ### python source
  /// ```py
  /// def get_context(self, text: str, span: int=40) -> str:
  ///         """Returns a pretty string pinpointing the error in the text,
  ///         with span amount of context characters around it.
  ///
  ///         Note:
  ///             The parser doesn't hold a copy of the text it has to parse,
  ///             so you have to provide it again
  ///         """
  ///         assert self.pos_in_stream is not None, self
  ///         pos = self.pos_in_stream
  ///         start = max(pos - span, 0)
  ///         end = pos + span
  ///         if not isinstance(text, bytes):
  ///             before = text[start:pos].rsplit('\n', 1)[-1]
  ///             after = text[pos:end].split('\n', 1)[0]
  ///             return before + after + '\n' + ' ' * len(before.expandtabs()) + '^\n'
  ///         else:
  ///             before = text[start:pos].rsplit(b'\n', 1)[-1]
  ///             after = text[pos:end].split(b'\n', 1)[0]
  ///             return (before + after + b'\n' + b' ' * len(before.expandtabs()) + b'^\n').decode("ascii", "backslashreplace")
  /// ```
  String get_context({
    required String text,
    int span = 40,
  }) =>
      getFunction("get_context").call(
        <Object?>[
          text,
          span,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## match_examples
  ///
  /// ### python docstring
  ///
  /// Allows you to detect what's wrong in the input text by matching
  /// against example errors.
  ///
  /// Given a parser instance and a dictionary mapping some label with
  /// some malformed syntax examples, it'll return the label for the
  /// example that bests matches the current error. The function will
  /// iterate the dictionary until it finds a matching error, and
  /// return the corresponding value.
  ///
  /// For an example usage, see `examples/error_reporting_lalr.py`
  ///
  /// Parameters:
  ///     parse_fn: parse function (usually ``lark_instance.parse``)
  ///     examples: dictionary of ``{'example_string': value}``.
  ///     use_accepts: Recommended to keep this as ``use_accepts=True``.
  ///
  /// ### python source
  /// ```py
  /// def match_examples(self, parse_fn: 'Callable[[str], Tree]',
  ///                              examples: Union[Mapping[T, Iterable[str]], Iterable[Tuple[T, Iterable[str]]]],
  ///                              token_type_match_fallback: bool=False,
  ///                              use_accepts: bool=True
  ///                          ) -> Optional[T]:
  ///         """Allows you to detect what's wrong in the input text by matching
  ///         against example errors.
  ///
  ///         Given a parser instance and a dictionary mapping some label with
  ///         some malformed syntax examples, it'll return the label for the
  ///         example that bests matches the current error. The function will
  ///         iterate the dictionary until it finds a matching error, and
  ///         return the corresponding value.
  ///
  ///         For an example usage, see `examples/error_reporting_lalr.py`
  ///
  ///         Parameters:
  ///             parse_fn: parse function (usually ``lark_instance.parse``)
  ///             examples: dictionary of ``{'example_string': value}``.
  ///             use_accepts: Recommended to keep this as ``use_accepts=True``.
  ///         """
  ///         assert self.state is not None, "Not supported for this exception"
  ///
  ///         if isinstance(examples, Mapping):
  ///             examples = examples.items()
  ///
  ///         candidate = (None, False)
  ///         for i, (label, example) in enumerate(examples):
  ///             assert not isinstance(example, str), "Expecting a list"
  ///
  ///             for j, malformed in enumerate(example):
  ///                 try:
  ///                     parse_fn(malformed)
  ///                 except UnexpectedInput as ut:
  ///                     if ut.state == self.state:
  ///                         if (
  ///                             use_accepts
  ///                             and isinstance(self, UnexpectedToken)
  ///                             and isinstance(ut, UnexpectedToken)
  ///                             and ut.accepts != self.accepts
  ///                         ):
  ///                             logger.debug("Different accepts with same state[%d]: %s != %s at example [%s][%s]" %
  ///                                          (self.state, self.accepts, ut.accepts, i, j))
  ///                             continue
  ///                         if (
  ///                             isinstance(self, (UnexpectedToken, UnexpectedEOF))
  ///                             and isinstance(ut, (UnexpectedToken, UnexpectedEOF))
  ///                         ):
  ///                             if ut.token == self.token:  # Try exact match first
  ///                                 logger.debug("Exact Match at example [%s][%s]" % (i, j))
  ///                                 return label
  ///
  ///                             if token_type_match_fallback:
  ///                                 # Fallback to token types match
  ///                                 if (ut.token.type == self.token.type) and not candidate[-1]:
  ///                                     logger.debug("Token Type Fallback at example [%s][%s]" % (i, j))
  ///                                     candidate = label, True
  ///
  ///                         if candidate[0] is None:
  ///                             logger.debug("Same State match at example [%s][%s]" % (i, j))
  ///                             candidate = label, False
  ///
  ///         return candidate[0]
  /// ```
  Object? match_examples({
    required Object? parse_fn,
    required Object? examples,
    bool token_type_match_fallback = false,
    bool use_accepts = true,
  }) =>
      getFunction("match_examples").call(
        <Object?>[
          parse_fn,
          examples,
          token_type_match_fallback,
          use_accepts,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## accepts (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get accepts => getAttribute("accepts");

  /// ## accepts (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set accepts(Object? accepts) => setAttribute("accepts", accepts);

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);

  /// ## pos_in_stream (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get pos_in_stream => getAttribute("pos_in_stream");

  /// ## pos_in_stream (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set pos_in_stream(Object? pos_in_stream) =>
      setAttribute("pos_in_stream", pos_in_stream);

  /// ## line (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get line => getAttribute("line");

  /// ## line (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set line(Object? line) => setAttribute("line", line);

  /// ## column (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get column => getAttribute("column");

  /// ## column (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set column(Object? column) => setAttribute("column", column);

  /// ## state (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get state => getAttribute("state");

  /// ## state (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set state(Object? state) => setAttribute("state", state);

  /// ## token (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get token => getAttribute("token");

  /// ## token (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set token(Object? token) => setAttribute("token", token);

  /// ## expected (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get expected => getAttribute("expected");

  /// ## expected (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set expected(Object? expected) => setAttribute("expected", expected);

  /// ## considered_rules (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get considered_rules => getAttribute("considered_rules");

  /// ## considered_rules (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set considered_rules(Object? considered_rules) =>
      setAttribute("considered_rules", considered_rules);

  /// ## interactive_parser (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get interactive_parser => getAttribute("interactive_parser");

  /// ## interactive_parser (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set interactive_parser(Object? interactive_parser) =>
      setAttribute("interactive_parser", interactive_parser);

  /// ## token_history (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get token_history => getAttribute("token_history");

  /// ## token_history (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set token_history(Object? token_history) =>
      setAttribute("token_history", token_history);
}

/// ## tree_matcher
///
/// ### python docstring
///
/// Tree matcher based on Lark grammar
///
/// ### python source
/// ```py
/// """Tree matcher based on Lark grammar"""
///
/// import re
/// from collections import defaultdict
///
/// from . import Tree, Token
/// from .common import ParserConf
/// from .parsers import earley
/// from .grammar import Rule, Terminal, NonTerminal
///
///
/// def is_discarded_terminal(t):
///     return t.is_term and t.filter_out
///
///
/// class _MakeTreeMatch:
///     def __init__(self, name, expansion):
///         self.name = name
///         self.expansion = expansion
///
///     def __call__(self, args):
///         t = Tree(self.name, args)
///         t.meta.match_tree = True
///         t.meta.orig_expansion = self.expansion
///         return t
///
///
/// def _best_from_group(seq, group_key, cmp_key):
///     d = {}
///     for item in seq:
///         key = group_key(item)
///         if key in d:
///             v1 = cmp_key(item)
///             v2 = cmp_key(d[key])
///             if v2 > v1:
///                 d[key] = item
///         else:
///             d[key] = item
///     return list(d.values())
///
///
/// def _best_rules_from_group(rules):
///     rules = _best_from_group(rules, lambda r: r, lambda r: -len(r.expansion))
///     rules.sort(key=lambda r: len(r.expansion))
///     return rules
///
///
/// def _match(term, token):
///     if isinstance(token, Tree):
///         name, _args = parse_rulename(term.name)
///         return token.data == name
///     elif isinstance(token, Token):
///         return term == Terminal(token.type)
///     assert False, (term, token)
///
///
/// def make_recons_rule(origin, expansion, old_expansion):
///     return Rule(origin, expansion, alias=_MakeTreeMatch(origin.name, old_expansion))
///
///
/// def make_recons_rule_to_term(origin, term):
///     return make_recons_rule(origin, [Terminal(term.name)], [term])
///
///
/// def parse_rulename(s):
///     "Parse rule names that may contain a template syntax (like rule{a, b, ...})"
///     name, args_str = re.match(r'(\w+)(?:{(.+)})?', s).groups()
///     args = args_str and [a.strip() for a in args_str.split(',')]
///     return name, args
///
///
///
/// class ChildrenLexer:
///     def __init__(self, children):
///         self.children = children
///
///     def lex(self, parser_state):
///         return self.children
///
/// class TreeMatcher:
///     """Match the elements of a tree node, based on an ontology
///     provided by a Lark grammar.
///
///     Supports templates and inlined rules (`rule{a, b,..}` and `_rule`)
///
///     Initialize with an instance of Lark.
///     """
///
///     def __init__(self, parser):
///         # XXX TODO calling compile twice returns different results!
///         assert not parser.options.maybe_placeholders
///         # XXX TODO: we just ignore the potential existence of a postlexer
///         self.tokens, rules, _extra = parser.grammar.compile(parser.options.start, set())
///
///         self.rules_for_root = defaultdict(list)
///
///         self.rules = list(self._build_recons_rules(rules))
///         self.rules.reverse()
///
///         # Choose the best rule from each group of {rule => [rule.alias]}, since we only really need one derivation.
///         self.rules = _best_rules_from_group(self.rules)
///
///         self.parser = parser
///         self._parser_cache = {}
///
///     def _build_recons_rules(self, rules):
///         "Convert tree-parsing/construction rules to tree-matching rules"
///         expand1s = {r.origin for r in rules if r.options.expand1}
///
///         aliases = defaultdict(list)
///         for r in rules:
///             if r.alias:
///                 aliases[r.origin].append(r.alias)
///
///         rule_names = {r.origin for r in rules}
///         nonterminals = {sym for sym in rule_names
///                         if sym.name.startswith('_') or sym in expand1s or sym in aliases}
///
///         seen = set()
///         for r in rules:
///             recons_exp = [sym if sym in nonterminals else Terminal(sym.name)
///                           for sym in r.expansion if not is_discarded_terminal(sym)]
///
///             # Skip self-recursive constructs
///             if recons_exp == [r.origin] and r.alias is None:
///                 continue
///
///             sym = NonTerminal(r.alias) if r.alias else r.origin
///             rule = make_recons_rule(sym, recons_exp, r.expansion)
///
///             if sym in expand1s and len(recons_exp) != 1:
///                 self.rules_for_root[sym.name].append(rule)
///
///                 if sym.name not in seen:
///                     yield make_recons_rule_to_term(sym, sym)
///                     seen.add(sym.name)
///             else:
///                 if sym.name.startswith('_') or sym in expand1s:
///                     yield rule
///                 else:
///                     self.rules_for_root[sym.name].append(rule)
///
///         for origin, rule_aliases in aliases.items():
///             for alias in rule_aliases:
///                 yield make_recons_rule_to_term(origin, NonTerminal(alias))
///             yield make_recons_rule_to_term(origin, origin)
///
///     def match_tree(self, tree, rulename):
///         """Match the elements of `tree` to the symbols of rule `rulename`.
///
///         Parameters:
///             tree (Tree): the tree node to match
///             rulename (str): The expected full rule name (including template args)
///
///         Returns:
///             Tree: an unreduced tree that matches `rulename`
///
///         Raises:
///             UnexpectedToken: If no match was found.
///
///         Note:
///             It's the callers' responsibility match the tree recursively.
///         """
///         if rulename:
///             # validate
///             name, _args = parse_rulename(rulename)
///             assert tree.data == name
///         else:
///             rulename = tree.data
///
///         # TODO: ambiguity?
///         try:
///             parser = self._parser_cache[rulename]
///         except KeyError:
///             rules = self.rules + _best_rules_from_group(self.rules_for_root[rulename])
///
///             # TODO pass callbacks through dict, instead of alias?
///             callbacks = {rule: rule.alias for rule in rules}
///             conf = ParserConf(rules, callbacks, [rulename])
///             parser = earley.Parser(self.parser.lexer_conf, conf, _match, resolve_ambiguity=True)
///             self._parser_cache[rulename] = parser
///
///         # find a full derivation
///         unreduced_tree = parser.parse(ChildrenLexer(tree.children), rulename)
///         assert unreduced_tree.data == rulename
///         return unreduced_tree
/// ```
final class tree_matcher extends PythonModule {
  tree_matcher.from(super.pythonModule) : super.from();

  static tree_matcher import() => PythonFfi.instance.importModule(
        "lark.tree_matcher",
        tree_matcher.from,
      );

  /// ## is_discarded_terminal
  ///
  /// ### python source
  /// ```py
  /// def is_discarded_terminal(t):
  ///     return t.is_term and t.filter_out
  /// ```
  Object? is_discarded_terminal({
    required Object? t,
  }) =>
      getFunction("is_discarded_terminal").call(
        <Object?>[
          t,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## make_recons_rule
  ///
  /// ### python source
  /// ```py
  /// def make_recons_rule(origin, expansion, old_expansion):
  ///     return Rule(origin, expansion, alias=_MakeTreeMatch(origin.name, old_expansion))
  /// ```
  Object? make_recons_rule({
    required Object? origin,
    required Object? expansion,
    required Object? old_expansion,
  }) =>
      getFunction("make_recons_rule").call(
        <Object?>[
          origin,
          expansion,
          old_expansion,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## make_recons_rule_to_term
  ///
  /// ### python source
  /// ```py
  /// def make_recons_rule_to_term(origin, term):
  ///     return make_recons_rule(origin, [Terminal(term.name)], [term])
  /// ```
  Object? make_recons_rule_to_term({
    required Object? origin,
    required Object? term,
  }) =>
      getFunction("make_recons_rule_to_term").call(
        <Object?>[
          origin,
          term,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## parse_rulename
  ///
  /// ### python docstring
  ///
  /// Parse rule names that may contain a template syntax (like rule{a, b, ...})
  ///
  /// ### python source
  /// ```py
  /// def parse_rulename(s):
  ///     "Parse rule names that may contain a template syntax (like rule{a, b, ...})"
  ///     name, args_str = re.match(r'(\w+)(?:{(.+)})?', s).groups()
  ///     args = args_str and [a.strip() for a in args_str.split(',')]
  ///     return name, args
  /// ```
  Object? parse_rulename({
    required Object? s,
  }) =>
      getFunction("parse_rulename").call(
        <Object?>[
          s,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## earley
  ///
  /// ### python docstring
  ///
  /// This module implements an Earley parser.
  ///
  /// The core Earley algorithm used here is based on Elizabeth Scott's implementation, here:
  ///     https://www.sciencedirect.com/science/article/pii/S1571066108001497
  ///
  /// That is probably the best reference for understanding the algorithm here.
  ///
  /// The Earley parser outputs an SPPF-tree as per that document. The SPPF tree format
  /// is explained here: https://lark-parser.readthedocs.io/en/latest/_static/sppf/sppf.html
  earley get $earley => earley.import();
}

/// ## earley
///
/// ### python docstring
///
/// This module implements an Earley parser.
///
/// The core Earley algorithm used here is based on Elizabeth Scott's implementation, here:
///     https://www.sciencedirect.com/science/article/pii/S1571066108001497
///
/// That is probably the best reference for understanding the algorithm here.
///
/// The Earley parser outputs an SPPF-tree as per that document. The SPPF tree format
/// is explained here: https://lark-parser.readthedocs.io/en/latest/_static/sppf/sppf.html
///
/// ### python source
/// ```py
/// """This module implements an Earley parser.
///
/// The core Earley algorithm used here is based on Elizabeth Scott's implementation, here:
///     https://www.sciencedirect.com/science/article/pii/S1571066108001497
///
/// That is probably the best reference for understanding the algorithm here.
///
/// The Earley parser outputs an SPPF-tree as per that document. The SPPF tree format
/// is explained here: https://lark-parser.readthedocs.io/en/latest/_static/sppf/sppf.html
/// """
///
/// import typing
///
/// from collections import deque
///
/// from ..lexer import Token
/// from ..tree import Tree
/// from ..exceptions import UnexpectedEOF, UnexpectedToken
/// from ..utils import logger
/// from .grammar_analysis import GrammarAnalyzer
/// from ..grammar import NonTerminal
/// from .earley_common import Item
/// from .earley_forest import ForestSumVisitor, SymbolNode, TokenNode, ForestToParseTree
///
/// if typing.TYPE_CHECKING:
///     from ..common import LexerConf, ParserConf
///
/// class Parser:
///     lexer_conf: 'LexerConf'
///     parser_conf: 'ParserConf'
///     debug: bool
///
///     def __init__(self, lexer_conf: 'LexerConf', parser_conf: 'ParserConf', term_matcher, resolve_ambiguity=True, debug=False, tree_class=Tree):
///         analysis = GrammarAnalyzer(parser_conf)
///         self.lexer_conf = lexer_conf
///         self.parser_conf = parser_conf
///         self.resolve_ambiguity = resolve_ambiguity
///         self.debug = debug
///         self.tree_class = tree_class
///
///         self.FIRST = analysis.FIRST
///         self.NULLABLE = analysis.NULLABLE
///         self.callbacks = parser_conf.callbacks
///         # TODO add typing info
///         self.predictions = {}   # type: ignore[var-annotated]
///
///         ## These could be moved to the grammar analyzer. Pre-computing these is *much* faster than
///         #  the slow 'isupper' in is_terminal.
///         self.TERMINALS = { sym for r in parser_conf.rules for sym in r.expansion if sym.is_term }
///         self.NON_TERMINALS = { sym for r in parser_conf.rules for sym in r.expansion if not sym.is_term }
///
///         self.forest_sum_visitor = None
///         for rule in parser_conf.rules:
///             if rule.origin not in self.predictions:
///                 self.predictions[rule.origin] = [x.rule for x in analysis.expand_rule(rule.origin)]
///
///             ## Detect if any rules/terminals have priorities set. If the user specified priority = None, then
///             #  the priorities will be stripped from all rules/terminals before they reach us, allowing us to
///             #  skip the extra tree walk. We'll also skip this if the user just didn't specify priorities
///             #  on any rules/terminals.
///             if self.forest_sum_visitor is None and rule.options.priority is not None:
///                 self.forest_sum_visitor = ForestSumVisitor
///
///         # Check terminals for priorities
///         # Ignore terminal priorities if the basic lexer is used
///         if self.lexer_conf.lexer_type != 'basic' and self.forest_sum_visitor is None:
///             for term in self.lexer_conf.terminals:
///                 if term.priority:
///                     self.forest_sum_visitor = ForestSumVisitor
///                     break
///
///         self.term_matcher = term_matcher
///
///
///     def predict_and_complete(self, i, to_scan, columns, transitives):
///         """The core Earley Predictor and Completer.
///
///         At each stage of the input, we handling any completed items (things
///         that matched on the last cycle) and use those to predict what should
///         come next in the input stream. The completions and any predicted
///         non-terminals are recursively processed until we reach a set of,
///         which can be added to the scan list for the next scanner cycle."""
///         # Held Completions (H in E.Scotts paper).
///         node_cache = {}
///         held_completions = {}
///
///         column = columns[i]
///         # R (items) = Ei (column.items)
///         items = deque(column)
///         while items:
///             item = items.pop()    # remove an element, A say, from R
///
///             ### The Earley completer
///             if item.is_complete:   ### (item.s == string)
///                 if item.node is None:
///                     label = (item.s, item.start, i)
///                     item.node = node_cache[label] if label in node_cache else node_cache.setdefault(label, SymbolNode(*label))
///                     item.node.add_family(item.s, item.rule, item.start, None, None)
///
///                 # create_leo_transitives(item.rule.origin, item.start)
///
///                 ###R Joop Leo right recursion Completer
///                 if item.rule.origin in transitives[item.start]:
///                     transitive = transitives[item.start][item.s]
///                     if transitive.previous in transitives[transitive.column]:
///                         root_transitive = transitives[transitive.column][transitive.previous]
///                     else:
///                         root_transitive = transitive
///
///                     new_item = Item(transitive.rule, transitive.ptr, transitive.start)
///                     label = (root_transitive.s, root_transitive.start, i)
///                     new_item.node = node_cache[label] if label in node_cache else node_cache.setdefault(label, SymbolNode(*label))
///                     new_item.node.add_path(root_transitive, item.node)
///                     if new_item.expect in self.TERMINALS:
///                         # Add (B :: aC.B, h, y) to Q
///                         to_scan.add(new_item)
///                     elif new_item not in column:
///                         # Add (B :: aC.B, h, y) to Ei and R
///                         column.add(new_item)
///                         items.append(new_item)
///                 ###R Regular Earley completer
///                 else:
///                     # Empty has 0 length. If we complete an empty symbol in a particular
///                     # parse step, we need to be able to use that same empty symbol to complete
///                     # any predictions that result, that themselves require empty. Avoids
///                     # infinite recursion on empty symbols.
///                     # held_completions is 'H' in E.Scott's paper.
///                     is_empty_item = item.start == i
///                     if is_empty_item:
///                         held_completions[item.rule.origin] = item.node
///
///                     originators = [originator for originator in columns[item.start] if originator.expect is not None and originator.expect == item.s]
///                     for originator in originators:
///                         new_item = originator.advance()
///                         label = (new_item.s, originator.start, i)
///                         new_item.node = node_cache[label] if label in node_cache else node_cache.setdefault(label, SymbolNode(*label))
///                         new_item.node.add_family(new_item.s, new_item.rule, i, originator.node, item.node)
///                         if new_item.expect in self.TERMINALS:
///                             # Add (B :: aC.B, h, y) to Q
///                             to_scan.add(new_item)
///                         elif new_item not in column:
///                             # Add (B :: aC.B, h, y) to Ei and R
///                             column.add(new_item)
///                             items.append(new_item)
///
///             ### The Earley predictor
///             elif item.expect in self.NON_TERMINALS: ### (item.s == lr0)
///                 new_items = []
///                 for rule in self.predictions[item.expect]:
///                     new_item = Item(rule, 0, i)
///                     new_items.append(new_item)
///
///                 # Process any held completions (H).
///                 if item.expect in held_completions:
///                     new_item = item.advance()
///                     label = (new_item.s, item.start, i)
///                     new_item.node = node_cache[label] if label in node_cache else node_cache.setdefault(label, SymbolNode(*label))
///                     new_item.node.add_family(new_item.s, new_item.rule, new_item.start, item.node, held_completions[item.expect])
///                     new_items.append(new_item)
///
///                 for new_item in new_items:
///                     if new_item.expect in self.TERMINALS:
///                         to_scan.add(new_item)
///                     elif new_item not in column:
///                         column.add(new_item)
///                         items.append(new_item)
///
///     def _parse(self, lexer, columns, to_scan, start_symbol=None):
///         def is_quasi_complete(item):
///             if item.is_complete:
///                 return True
///
///             quasi = item.advance()
///             while not quasi.is_complete:
///                 if quasi.expect not in self.NULLABLE:
///                     return False
///                 if quasi.rule.origin == start_symbol and quasi.expect == start_symbol:
///                     return False
///                 quasi = quasi.advance()
///             return True
///
///         # def create_leo_transitives(origin, start):
///         #   ...   # removed at commit 4c1cfb2faf24e8f8bff7112627a00b94d261b420
///
///         def scan(i, token, to_scan):
///             """The core Earley Scanner.
///
///             This is a custom implementation of the scanner that uses the
///             Lark lexer to match tokens. The scan list is built by the
///             Earley predictor, based on the previously completed tokens.
///             This ensures that at each phase of the parse we have a custom
///             lexer context, allowing for more complex ambiguities."""
///             next_to_scan = set()
///             next_set = set()
///             columns.append(next_set)
///             transitives.append({})
///             node_cache = {}
///
///             for item in set(to_scan):
///                 if match(item.expect, token):
///                     new_item = item.advance()
///                     label = (new_item.s, new_item.start, i)
///                     # 'terminals' may not contain token.type when using %declare
///                     # Additionally, token is not always a Token
///                     # For example, it can be a Tree when using TreeMatcher
///                     term = terminals.get(token.type) if isinstance(token, Token) else None
///                     # Set the priority of the token node to 0 so that the
///                     # terminal priorities do not affect the Tree chosen by
///                     # ForestSumVisitor after the basic lexer has already
///                     # "used up" the terminal priorities
///                     token_node = TokenNode(token, term, priority=0)
///                     new_item.node = node_cache[label] if label in node_cache else node_cache.setdefault(label, SymbolNode(*label))
///                     new_item.node.add_family(new_item.s, item.rule, new_item.start, item.node, token_node)
///
///                     if new_item.expect in self.TERMINALS:
///                         # add (B ::= Aai+1.B, h, y) to Q'
///                         next_to_scan.add(new_item)
///                     else:
///                         # add (B ::= Aa+1.B, h, y) to Ei+1
///                         next_set.add(new_item)
///
///             if not next_set and not next_to_scan:
///                 expect = {i.expect.name for i in to_scan}
///                 raise UnexpectedToken(token, expect, considered_rules=set(to_scan), state=frozenset(i.s for i in to_scan))
///
///             return next_to_scan
///
///
///         # Define parser functions
///         match = self.term_matcher
///
///         terminals = self.lexer_conf.terminals_by_name
///
///         # Cache for nodes & tokens created in a particular parse step.
///         transitives = [{}]
///
///         ## The main Earley loop.
///         # Run the Prediction/Completion cycle for any Items in the current Earley set.
///         # Completions will be added to the SPPF tree, and predictions will be recursively
///         # processed down to terminals/empty nodes to be added to the scanner for the next
///         # step.
///         expects = {i.expect for i in to_scan}
///         i = 0
///         for token in lexer.lex(expects):
///             self.predict_and_complete(i, to_scan, columns, transitives)
///
///             to_scan = scan(i, token, to_scan)
///             i += 1
///
///             expects.clear()
///             expects |= {i.expect for i in to_scan}
///
///         self.predict_and_complete(i, to_scan, columns, transitives)
///
///         ## Column is now the final column in the parse.
///         assert i == len(columns)-1
///         return to_scan
///
///     def parse(self, lexer, start):
///         assert start, start
///         start_symbol = NonTerminal(start)
///
///         columns = [set()]
///         to_scan = set()     # The scan buffer. 'Q' in E.Scott's paper.
///
///         ## Predict for the start_symbol.
///         # Add predicted items to the first Earley set (for the predictor) if they
///         # result in a non-terminal, or the scanner if they result in a terminal.
///         for rule in self.predictions[start_symbol]:
///             item = Item(rule, 0, 0)
///             if item.expect in self.TERMINALS:
///                 to_scan.add(item)
///             else:
///                 columns[0].add(item)
///
///         to_scan = self._parse(lexer, columns, to_scan, start_symbol)
///
///         # If the parse was successful, the start
///         # symbol should have been completed in the last step of the Earley cycle, and will be in
///         # this column. Find the item for the start_symbol, which is the root of the SPPF tree.
///         solutions = [n.node for n in columns[-1] if n.is_complete and n.node is not None and n.s == start_symbol and n.start == 0]
///         if not solutions:
///             expected_terminals = [t.expect.name for t in to_scan]
///             raise UnexpectedEOF(expected_terminals, state=frozenset(i.s for i in to_scan))
///
///         if self.debug:
///             from .earley_forest import ForestToPyDotVisitor
///             try:
///                 debug_walker = ForestToPyDotVisitor()
///             except ImportError:
///                 logger.warning("Cannot find dependency 'pydot', will not generate sppf debug image")
///             else:
///                 debug_walker.visit(solutions[0], "sppf.png")
///
///
///         if len(solutions) > 1:
///             assert False, 'Earley should not generate multiple start symbol items!'
///
///         if self.tree_class is not None:
///             # Perform our SPPF -> AST conversion
///             transformer = ForestToParseTree(self.tree_class, self.callbacks, self.forest_sum_visitor and self.forest_sum_visitor(), self.resolve_ambiguity)
///             return transformer.transform(solutions[0])
///
///         # return the root of the SPPF
///         return solutions[0]
/// ```
final class earley extends PythonModule {
  earley.from(super.pythonModule) : super.from();

  static earley import() => PythonFfi.instance.importModule(
        "lark.parsers.earley",
        earley.from,
      );
}
