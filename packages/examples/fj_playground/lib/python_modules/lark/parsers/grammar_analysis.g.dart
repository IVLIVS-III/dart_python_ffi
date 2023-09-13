// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library grammar_analysis;

import "package:python_ffi/python_ffi.dart";

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
        "lark.parsers.grammar_analysis",
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

/// ## GrammarError
///
/// ### python source
/// ```py
/// class GrammarError(LarkError):
///     pass
/// ```
final class GrammarError extends PythonClass {
  factory GrammarError() => PythonFfi.instance.importClass(
        "lark.parsers.grammar_analysis",
        "GrammarError",
        GrammarError.from,
        <Object?>[],
      );

  GrammarError.from(super.pythonClass) : super.from();

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

/// ## LR0ItemSet
///
/// ### python source
/// ```py
/// class LR0ItemSet:
///     __slots__ = ('kernel', 'closure', 'transitions', 'lookaheads')
///
///     def __init__(self, kernel, closure):
///         self.kernel = fzset(kernel)
///         self.closure = fzset(closure)
///         self.transitions = {}
///         self.lookaheads = defaultdict(set)
///
///     def __repr__(self):
///         return '{%s | %s}' % (', '.join([repr(r) for r in self.kernel]), ', '.join([repr(r) for r in self.closure]))
/// ```
final class LR0ItemSet extends PythonClass {
  factory LR0ItemSet({
    required Object? kernel,
    required Object? closure,
  }) =>
      PythonFfi.instance.importClass(
        "lark.parsers.grammar_analysis",
        "LR0ItemSet",
        LR0ItemSet.from,
        <Object?>[
          kernel,
          closure,
        ],
        <String, Object?>{},
      );

  LR0ItemSet.from(super.pythonClass) : super.from();

  /// ## closure (getter)
  Object? get closure => getAttribute("closure");

  /// ## closure (setter)
  set closure(Object? closure) => setAttribute("closure", closure);

  /// ## kernel (getter)
  Object? get kernel => getAttribute("kernel");

  /// ## kernel (setter)
  set kernel(Object? kernel) => setAttribute("kernel", kernel);

  /// ## lookaheads (getter)
  Object? get lookaheads => getAttribute("lookaheads");

  /// ## lookaheads (setter)
  set lookaheads(Object? lookaheads) => setAttribute("lookaheads", lookaheads);

  /// ## transitions (getter)
  Object? get transitions => getAttribute("transitions");

  /// ## transitions (setter)
  set transitions(Object? transitions) =>
      setAttribute("transitions", transitions);
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
        "lark.parsers.grammar_analysis",
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
        "lark.parsers.grammar_analysis",
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

/// ## RulePtr
///
/// ### python source
/// ```py
/// class RulePtr:
///     __slots__ = ('rule', 'index')
///
///     def __init__(self, rule, index):
///         assert isinstance(rule, Rule)
///         assert index <= len(rule.expansion)
///         self.rule = rule
///         self.index = index
///
///     def __repr__(self):
///         before = [x.name for x in self.rule.expansion[:self.index]]
///         after = [x.name for x in self.rule.expansion[self.index:]]
///         return '<%s : %s * %s>' % (self.rule.origin.name, ' '.join(before), ' '.join(after))
///
///     @property
///     def next(self):
///         return self.rule.expansion[self.index]
///
///     def advance(self, sym):
///         assert self.next == sym
///         return RulePtr(self.rule, self.index+1)
///
///     @property
///     def is_satisfied(self):
///         return self.index == len(self.rule.expansion)
///
///     def __eq__(self, other):
///         return self.rule == other.rule and self.index == other.index
///     def __hash__(self):
///         return hash((self.rule, self.index))
/// ```
final class RulePtr extends PythonClass {
  factory RulePtr({
    required Object? rule,
    required Object? index,
  }) =>
      PythonFfi.instance.importClass(
        "lark.parsers.grammar_analysis",
        "RulePtr",
        RulePtr.from,
        <Object?>[
          rule,
          index,
        ],
        <String, Object?>{},
      );

  RulePtr.from(super.pythonClass) : super.from();

  /// ## advance
  ///
  /// ### python source
  /// ```py
  /// def advance(self, sym):
  ///         assert self.next == sym
  ///         return RulePtr(self.rule, self.index+1)
  /// ```
  Object? advance({
    required Object? sym,
  }) =>
      getFunction("advance").call(
        <Object?>[
          sym,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## is_satisfied (getter)
  Object? get is_satisfied => getAttribute("is_satisfied");

  /// ## is_satisfied (setter)
  set is_satisfied(Object? is_satisfied) =>
      setAttribute("is_satisfied", is_satisfied);

  /// ## next (getter)
  Object? get next => getAttribute("next");

  /// ## next (setter)
  set next(Object? next) => setAttribute("next", next);

  /// ## index (getter)
  Object? get index => getAttribute("index");

  /// ## index (setter)
  set index(Object? index) => setAttribute("index", index);

  /// ## rule (getter)
  Object? get rule => getAttribute("rule");

  /// ## rule (setter)
  set rule(Object? rule) => setAttribute("rule", rule);
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
        "lark.parsers.grammar_analysis",
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

/// ## fzset
///
/// ### python source
/// ```py
/// class fzset(frozenset):
///     def __repr__(self):
///         return '{%s}' % ', '.join(map(repr, self))
/// ```
final class fzset extends PythonClass {
  factory fzset() => PythonFfi.instance.importClass(
        "lark.parsers.grammar_analysis",
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

/// ## grammar_analysis
///
/// ### python source
/// ```py
/// from collections import Counter, defaultdict
///
/// from ..utils import bfs, fzset, classify
/// from ..exceptions import GrammarError
/// from ..grammar import Rule, Terminal, NonTerminal
///
///
/// class RulePtr:
///     __slots__ = ('rule', 'index')
///
///     def __init__(self, rule, index):
///         assert isinstance(rule, Rule)
///         assert index <= len(rule.expansion)
///         self.rule = rule
///         self.index = index
///
///     def __repr__(self):
///         before = [x.name for x in self.rule.expansion[:self.index]]
///         after = [x.name for x in self.rule.expansion[self.index:]]
///         return '<%s : %s * %s>' % (self.rule.origin.name, ' '.join(before), ' '.join(after))
///
///     @property
///     def next(self):
///         return self.rule.expansion[self.index]
///
///     def advance(self, sym):
///         assert self.next == sym
///         return RulePtr(self.rule, self.index+1)
///
///     @property
///     def is_satisfied(self):
///         return self.index == len(self.rule.expansion)
///
///     def __eq__(self, other):
///         return self.rule == other.rule and self.index == other.index
///     def __hash__(self):
///         return hash((self.rule, self.index))
///
///
/// # state generation ensures no duplicate LR0ItemSets
/// class LR0ItemSet:
///     __slots__ = ('kernel', 'closure', 'transitions', 'lookaheads')
///
///     def __init__(self, kernel, closure):
///         self.kernel = fzset(kernel)
///         self.closure = fzset(closure)
///         self.transitions = {}
///         self.lookaheads = defaultdict(set)
///
///     def __repr__(self):
///         return '{%s | %s}' % (', '.join([repr(r) for r in self.kernel]), ', '.join([repr(r) for r in self.closure]))
///
///
/// def update_set(set1, set2):
///     if not set2 or set1 > set2:
///         return False
///
///     copy = set(set1)
///     set1 |= set2
///     return set1 != copy
///
/// def calculate_sets(rules):
///     """Calculate FOLLOW sets.
///
///     Adapted from: http://lara.epfl.ch/w/cc09:algorithm_for_first_and_follow_sets"""
///     symbols = {sym for rule in rules for sym in rule.expansion} | {rule.origin for rule in rules}
///
///     # foreach grammar rule X ::= Y(1) ... Y(k)
///     # if k=0 or {Y(1),...,Y(k)} subset of NULLABLE then
///     #   NULLABLE = NULLABLE union {X}
///     # for i = 1 to k
///     #   if i=1 or {Y(1),...,Y(i-1)} subset of NULLABLE then
///     #     FIRST(X) = FIRST(X) union FIRST(Y(i))
///     #   for j = i+1 to k
///     #     if i=k or {Y(i+1),...Y(k)} subset of NULLABLE then
///     #       FOLLOW(Y(i)) = FOLLOW(Y(i)) union FOLLOW(X)
///     #     if i+1=j or {Y(i+1),...,Y(j-1)} subset of NULLABLE then
///     #       FOLLOW(Y(i)) = FOLLOW(Y(i)) union FIRST(Y(j))
///     # until none of NULLABLE,FIRST,FOLLOW changed in last iteration
///
///     NULLABLE = set()
///     FIRST = {}
///     FOLLOW = {}
///     for sym in symbols:
///         FIRST[sym]={sym} if sym.is_term else set()
///         FOLLOW[sym]=set()
///
///     # Calculate NULLABLE and FIRST
///     changed = True
///     while changed:
///         changed = False
///
///         for rule in rules:
///             if set(rule.expansion) <= NULLABLE:
///                 if update_set(NULLABLE, {rule.origin}):
///                     changed = True
///
///             for i, sym in enumerate(rule.expansion):
///                 if set(rule.expansion[:i]) <= NULLABLE:
///                     if update_set(FIRST[rule.origin], FIRST[sym]):
///                         changed = True
///                 else:
///                     break
///
///     # Calculate FOLLOW
///     changed = True
///     while changed:
///         changed = False
///
///         for rule in rules:
///             for i, sym in enumerate(rule.expansion):
///                 if i==len(rule.expansion)-1 or set(rule.expansion[i+1:]) <= NULLABLE:
///                     if update_set(FOLLOW[sym], FOLLOW[rule.origin]):
///                         changed = True
///
///                 for j in range(i+1, len(rule.expansion)):
///                     if set(rule.expansion[i+1:j]) <= NULLABLE:
///                         if update_set(FOLLOW[sym], FIRST[rule.expansion[j]]):
///                             changed = True
///
///     return FIRST, FOLLOW, NULLABLE
///
///
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
final class grammar_analysis extends PythonModule {
  grammar_analysis.from(super.pythonModule) : super.from();

  static grammar_analysis import() => PythonFfi.instance.importModule(
        "lark.parsers.grammar_analysis",
        grammar_analysis.from,
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

  /// ## calculate_sets
  ///
  /// ### python docstring
  ///
  /// Calculate FOLLOW sets.
  ///
  /// Adapted from: http://lara.epfl.ch/w/cc09:algorithm_for_first_and_follow_sets
  ///
  /// ### python source
  /// ```py
  /// def calculate_sets(rules):
  ///     """Calculate FOLLOW sets.
  ///
  ///     Adapted from: http://lara.epfl.ch/w/cc09:algorithm_for_first_and_follow_sets"""
  ///     symbols = {sym for rule in rules for sym in rule.expansion} | {rule.origin for rule in rules}
  ///
  ///     # foreach grammar rule X ::= Y(1) ... Y(k)
  ///     # if k=0 or {Y(1),...,Y(k)} subset of NULLABLE then
  ///     #   NULLABLE = NULLABLE union {X}
  ///     # for i = 1 to k
  ///     #   if i=1 or {Y(1),...,Y(i-1)} subset of NULLABLE then
  ///     #     FIRST(X) = FIRST(X) union FIRST(Y(i))
  ///     #   for j = i+1 to k
  ///     #     if i=k or {Y(i+1),...Y(k)} subset of NULLABLE then
  ///     #       FOLLOW(Y(i)) = FOLLOW(Y(i)) union FOLLOW(X)
  ///     #     if i+1=j or {Y(i+1),...,Y(j-1)} subset of NULLABLE then
  ///     #       FOLLOW(Y(i)) = FOLLOW(Y(i)) union FIRST(Y(j))
  ///     # until none of NULLABLE,FIRST,FOLLOW changed in last iteration
  ///
  ///     NULLABLE = set()
  ///     FIRST = {}
  ///     FOLLOW = {}
  ///     for sym in symbols:
  ///         FIRST[sym]={sym} if sym.is_term else set()
  ///         FOLLOW[sym]=set()
  ///
  ///     # Calculate NULLABLE and FIRST
  ///     changed = True
  ///     while changed:
  ///         changed = False
  ///
  ///         for rule in rules:
  ///             if set(rule.expansion) <= NULLABLE:
  ///                 if update_set(NULLABLE, {rule.origin}):
  ///                     changed = True
  ///
  ///             for i, sym in enumerate(rule.expansion):
  ///                 if set(rule.expansion[:i]) <= NULLABLE:
  ///                     if update_set(FIRST[rule.origin], FIRST[sym]):
  ///                         changed = True
  ///                 else:
  ///                     break
  ///
  ///     # Calculate FOLLOW
  ///     changed = True
  ///     while changed:
  ///         changed = False
  ///
  ///         for rule in rules:
  ///             for i, sym in enumerate(rule.expansion):
  ///                 if i==len(rule.expansion)-1 or set(rule.expansion[i+1:]) <= NULLABLE:
  ///                     if update_set(FOLLOW[sym], FOLLOW[rule.origin]):
  ///                         changed = True
  ///
  ///                 for j in range(i+1, len(rule.expansion)):
  ///                     if set(rule.expansion[i+1:j]) <= NULLABLE:
  ///                         if update_set(FOLLOW[sym], FIRST[rule.expansion[j]]):
  ///                             changed = True
  ///
  ///     return FIRST, FOLLOW, NULLABLE
  /// ```
  Object? calculate_sets({
    required Object? rules,
  }) =>
      getFunction("calculate_sets").call(
        <Object?>[
          rules,
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

  /// ## update_set
  ///
  /// ### python source
  /// ```py
  /// def update_set(set1, set2):
  ///     if not set2 or set1 > set2:
  ///         return False
  ///
  ///     copy = set(set1)
  ///     set1 |= set2
  ///     return set1 != copy
  /// ```
  Object? update_set({
    required Object? set1,
    required Object? set2,
  }) =>
      getFunction("update_set").call(
        <Object?>[
          set1,
          set2,
        ],
        kwargs: <String, Object?>{},
      );
}
