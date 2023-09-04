// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library parsers;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## CnfWrapper
///
/// ### python docstring
///
/// CNF wrapper for grammar.
///
/// Validates that the input grammar is CNF and provides helper data structures.
///
/// ### python source
/// ```py
/// class CnfWrapper:
///     """CNF wrapper for grammar.
///
///   Validates that the input grammar is CNF and provides helper data structures.
///   """
///
///     def __init__(self, grammar):
///         super(CnfWrapper, self).__init__()
///         self.grammar = grammar
///         self.rules = grammar.rules
///         self.terminal_rules = defaultdict(list)
///         self.nonterminal_rules = defaultdict(list)
///         for r in self.rules:
///             # Validate that the grammar is CNF and populate auxiliary data structures.
///             assert isinstance(r.lhs, NT), r
///             if len(r.rhs) not in [1, 2]:
///                 raise ParseError("CYK doesn't support empty rules")
///             if len(r.rhs) == 1 and isinstance(r.rhs[0], T):
///                 self.terminal_rules[r.rhs[0]].append(r)
///             elif len(r.rhs) == 2 and all(isinstance(x, NT) for x in r.rhs):
///                 self.nonterminal_rules[tuple(r.rhs)].append(r)
///             else:
///                 assert False, r
///
///     def __eq__(self, other):
///         return self.grammar == other.grammar
///
///     def __repr__(self):
///         return repr(self.grammar)
/// ```
final class CnfWrapper extends PythonClass {
  factory CnfWrapper({
    required Object? grammar,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.cyk",
        "CnfWrapper",
        CnfWrapper.from,
        <Object?>[
          grammar,
        ],
        <String, Object?>{},
      );

  CnfWrapper.from(super.pythonClass) : super.from();

  /// ## grammar (getter)
  ///
  /// ### python docstring
  ///
  /// CNF wrapper for grammar.
  ///
  /// Validates that the input grammar is CNF and provides helper data structures.
  Object? get grammar => getAttribute("grammar");

  /// ## grammar (setter)
  ///
  /// ### python docstring
  ///
  /// CNF wrapper for grammar.
  ///
  /// Validates that the input grammar is CNF and provides helper data structures.
  set grammar(Object? grammar) => setAttribute("grammar", grammar);

  /// ## rules (getter)
  ///
  /// ### python docstring
  ///
  /// CNF wrapper for grammar.
  ///
  /// Validates that the input grammar is CNF and provides helper data structures.
  Object? get rules => getAttribute("rules");

  /// ## rules (setter)
  ///
  /// ### python docstring
  ///
  /// CNF wrapper for grammar.
  ///
  /// Validates that the input grammar is CNF and provides helper data structures.
  set rules(Object? rules) => setAttribute("rules", rules);

  /// ## terminal_rules (getter)
  ///
  /// ### python docstring
  ///
  /// CNF wrapper for grammar.
  ///
  /// Validates that the input grammar is CNF and provides helper data structures.
  Object? get terminal_rules => getAttribute("terminal_rules");

  /// ## terminal_rules (setter)
  ///
  /// ### python docstring
  ///
  /// CNF wrapper for grammar.
  ///
  /// Validates that the input grammar is CNF and provides helper data structures.
  set terminal_rules(Object? terminal_rules) =>
      setAttribute("terminal_rules", terminal_rules);

  /// ## nonterminal_rules (getter)
  ///
  /// ### python docstring
  ///
  /// CNF wrapper for grammar.
  ///
  /// Validates that the input grammar is CNF and provides helper data structures.
  Object? get nonterminal_rules => getAttribute("nonterminal_rules");

  /// ## nonterminal_rules (setter)
  ///
  /// ### python docstring
  ///
  /// CNF wrapper for grammar.
  ///
  /// Validates that the input grammar is CNF and provides helper data structures.
  set nonterminal_rules(Object? nonterminal_rules) =>
      setAttribute("nonterminal_rules", nonterminal_rules);
}

/// ## Grammar
///
/// ### python docstring
///
/// Context-free grammar.
///
/// ### python source
/// ```py
/// class Grammar:
///     """Context-free grammar."""
///
///     def __init__(self, rules):
///         self.rules = frozenset(rules)
///
///     def __eq__(self, other):
///         return self.rules == other.rules
///
///     def __str__(self):
///         return '\n' + '\n'.join(sorted(repr(x) for x in self.rules)) + '\n'
///
///     def __repr__(self):
///         return str(self)
/// ```
final class Grammar extends PythonClass {
  factory Grammar({
    required Object? rules,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.cyk",
        "Grammar",
        Grammar.from,
        <Object?>[
          rules,
        ],
        <String, Object?>{},
      );

  Grammar.from(super.pythonClass) : super.from();

  /// ## rules (getter)
  ///
  /// ### python docstring
  ///
  /// Context-free grammar.
  Object? get rules => getAttribute("rules");

  /// ## rules (setter)
  ///
  /// ### python docstring
  ///
  /// Context-free grammar.
  set rules(Object? rules) => setAttribute("rules", rules);
}

/// ## NT
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
final class NT extends PythonClass {
  factory NT({
    required String name,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.grammar",
        "NT",
        NT.from,
        <Object?>[
          name,
        ],
        <String, Object?>{},
      );

  NT.from(super.pythonClass) : super.from();

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

/// ## ParseError
///
/// ### python source
/// ```py
/// class ParseError(LarkError):
///     pass
/// ```
final class ParseError extends PythonClass {
  factory ParseError() => PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "ParseError",
        ParseError.from,
        <Object?>[],
      );

  ParseError.from(super.pythonClass) : super.from();

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

/// ## Parser
///
/// ### python docstring
///
/// Parser wrapper.
///
/// ### python source
/// ```py
/// class Parser:
///     """Parser wrapper."""
///
///     def __init__(self, rules):
///         super(Parser, self).__init__()
///         self.orig_rules = {rule: rule for rule in rules}
///         rules = [self._to_rule(rule) for rule in rules]
///         self.grammar = to_cnf(Grammar(rules))
///
///     def _to_rule(self, lark_rule):
///         """Converts a lark rule, (lhs, rhs, callback, options), to a Rule."""
///         assert isinstance(lark_rule.origin, NT)
///         assert all(isinstance(x, Symbol) for x in lark_rule.expansion)
///         return Rule(
///             lark_rule.origin, lark_rule.expansion,
///             weight=lark_rule.options.priority if lark_rule.options.priority else 0,
///             alias=lark_rule)
///
///     def parse(self, tokenized, start):  # pylint: disable=invalid-name
///         """Parses input, which is a list of tokens."""
///         assert start
///         start = NT(start)
///
///         table, trees = _parse(tokenized, self.grammar)
///         # Check if the parse succeeded.
///         if all(r.lhs != start for r in table[(0, len(tokenized) - 1)]):
///             raise ParseError('Parsing failed.')
///         parse = trees[(0, len(tokenized) - 1)][start]
///         return self._to_tree(revert_cnf(parse))
///
///     def _to_tree(self, rule_node):
///         """Converts a RuleNode parse tree to a lark Tree."""
///         orig_rule = self.orig_rules[rule_node.rule.alias]
///         children = []
///         for child in rule_node.children:
///             if isinstance(child, RuleNode):
///                 children.append(self._to_tree(child))
///             else:
///                 assert isinstance(child.name, Token)
///                 children.append(child.name)
///         t = Tree(orig_rule.origin, children)
///         t.rule=orig_rule
///         return t
/// ```
final class Parser extends PythonClass {
  factory Parser({
    required Object? rules,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.cyk",
        "Parser",
        Parser.from,
        <Object?>[
          rules,
        ],
        <String, Object?>{},
      );

  Parser.from(super.pythonClass) : super.from();

  /// ## parse
  ///
  /// ### python docstring
  ///
  /// Parses input, which is a list of tokens.
  ///
  /// ### python source
  /// ```py
  /// def parse(self, tokenized, start):  # pylint: disable=invalid-name
  ///         """Parses input, which is a list of tokens."""
  ///         assert start
  ///         start = NT(start)
  ///
  ///         table, trees = _parse(tokenized, self.grammar)
  ///         # Check if the parse succeeded.
  ///         if all(r.lhs != start for r in table[(0, len(tokenized) - 1)]):
  ///             raise ParseError('Parsing failed.')
  ///         parse = trees[(0, len(tokenized) - 1)][start]
  ///         return self._to_tree(revert_cnf(parse))
  /// ```
  Object? parse({
    required Object? tokenized,
    required Object? start,
  }) =>
      getFunction("parse").call(
        <Object?>[
          tokenized,
          start,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## orig_rules (getter)
  ///
  /// ### python docstring
  ///
  /// Parser wrapper.
  Object? get orig_rules => getAttribute("orig_rules");

  /// ## orig_rules (setter)
  ///
  /// ### python docstring
  ///
  /// Parser wrapper.
  set orig_rules(Object? orig_rules) => setAttribute("orig_rules", orig_rules);

  /// ## grammar (getter)
  ///
  /// ### python docstring
  ///
  /// Parser wrapper.
  Object? get grammar => getAttribute("grammar");

  /// ## grammar (setter)
  ///
  /// ### python docstring
  ///
  /// Parser wrapper.
  set grammar(Object? grammar) => setAttribute("grammar", grammar);
}

/// ## Rule
///
/// ### python docstring
///
/// Context-free grammar rule.
///
/// ### python source
/// ```py
/// class Rule:
///     """Context-free grammar rule."""
///
///     def __init__(self, lhs, rhs, weight, alias):
///         super(Rule, self).__init__()
///         assert isinstance(lhs, NT), lhs
///         assert all(isinstance(x, NT) or isinstance(x, T) for x in rhs), rhs
///         self.lhs = lhs
///         self.rhs = rhs
///         self.weight = weight
///         self.alias = alias
///
///     def __str__(self):
///         return '%s -> %s' % (str(self.lhs), ' '.join(str(x) for x in self.rhs))
///
///     def __repr__(self):
///         return str(self)
///
///     def __hash__(self):
///         return hash((self.lhs, tuple(self.rhs)))
///
///     def __eq__(self, other):
///         return self.lhs == other.lhs and self.rhs == other.rhs
///
///     def __ne__(self, other):
///         return not (self == other)
/// ```
final class Rule extends PythonClass {
  factory Rule({
    required Object? lhs,
    required Object? rhs,
    required Object? weight,
    required Object? alias,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.cyk",
        "Rule",
        Rule.from,
        <Object?>[
          lhs,
          rhs,
          weight,
          alias,
        ],
        <String, Object?>{},
      );

  Rule.from(super.pythonClass) : super.from();

  /// ## lhs (getter)
  ///
  /// ### python docstring
  ///
  /// Context-free grammar rule.
  Object? get lhs => getAttribute("lhs");

  /// ## lhs (setter)
  ///
  /// ### python docstring
  ///
  /// Context-free grammar rule.
  set lhs(Object? lhs) => setAttribute("lhs", lhs);

  /// ## rhs (getter)
  ///
  /// ### python docstring
  ///
  /// Context-free grammar rule.
  Object? get rhs => getAttribute("rhs");

  /// ## rhs (setter)
  ///
  /// ### python docstring
  ///
  /// Context-free grammar rule.
  set rhs(Object? rhs) => setAttribute("rhs", rhs);

  /// ## weight (getter)
  ///
  /// ### python docstring
  ///
  /// Context-free grammar rule.
  Object? get weight => getAttribute("weight");

  /// ## weight (setter)
  ///
  /// ### python docstring
  ///
  /// Context-free grammar rule.
  set weight(Object? weight) => setAttribute("weight", weight);

  /// ## alias (getter)
  ///
  /// ### python docstring
  ///
  /// Context-free grammar rule.
  Object? get alias => getAttribute("alias");

  /// ## alias (setter)
  ///
  /// ### python docstring
  ///
  /// Context-free grammar rule.
  set alias(Object? alias) => setAttribute("alias", alias);
}

/// ## RuleNode
///
/// ### python docstring
///
/// A node in the parse tree, which also contains the full rhs rule.
///
/// ### python source
/// ```py
/// class RuleNode:
///     """A node in the parse tree, which also contains the full rhs rule."""
///
///     def __init__(self, rule, children, weight=0):
///         self.rule = rule
///         self.children = children
///         self.weight = weight
///
///     def __repr__(self):
///         return 'RuleNode(%s, [%s])' % (repr(self.rule.lhs), ', '.join(str(x) for x in self.children))
/// ```
final class RuleNode extends PythonClass {
  factory RuleNode({
    required Object? rule,
    required Object? children,
    Object? weight = 0,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.cyk",
        "RuleNode",
        RuleNode.from,
        <Object?>[
          rule,
          children,
          weight,
        ],
        <String, Object?>{},
      );

  RuleNode.from(super.pythonClass) : super.from();

  /// ## rule (getter)
  ///
  /// ### python docstring
  ///
  /// A node in the parse tree, which also contains the full rhs rule.
  Object? get rule => getAttribute("rule");

  /// ## rule (setter)
  ///
  /// ### python docstring
  ///
  /// A node in the parse tree, which also contains the full rhs rule.
  set rule(Object? rule) => setAttribute("rule", rule);

  /// ## children (getter)
  ///
  /// ### python docstring
  ///
  /// A node in the parse tree, which also contains the full rhs rule.
  Object? get children => getAttribute("children");

  /// ## children (setter)
  ///
  /// ### python docstring
  ///
  /// A node in the parse tree, which also contains the full rhs rule.
  set children(Object? children) => setAttribute("children", children);

  /// ## weight (getter)
  ///
  /// ### python docstring
  ///
  /// A node in the parse tree, which also contains the full rhs rule.
  Object? get weight => getAttribute("weight");

  /// ## weight (setter)
  ///
  /// ### python docstring
  ///
  /// A node in the parse tree, which also contains the full rhs rule.
  set weight(Object? weight) => setAttribute("weight", weight);
}

/// ## Symbol
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
/// class Symbol(Serialize):
///     __slots__ = ('name',)
///
///     name: str
///     is_term: ClassVar[bool] = NotImplemented
///
///     def __init__(self, name: str) -> None:
///         self.name = name
///
///     def __eq__(self, other):
///         assert isinstance(other, Symbol), other
///         return self.is_term == other.is_term and self.name == other.name
///
///     def __ne__(self, other):
///         return not (self == other)
///
///     def __hash__(self):
///         return hash(self.name)
///
///     def __repr__(self):
///         return '%s(%r)' % (type(self).__name__, self.name)
///
///     fullrepr = property(__repr__)
///
///     def renamed(self, f):
///         return type(self)(f(self.name))
/// ```
final class $Symbol extends PythonClass {
  factory $Symbol({
    required String name,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.grammar",
        "Symbol",
        $Symbol.from,
        <Object?>[
          name,
        ],
        <String, Object?>{},
      );

  $Symbol.from(super.pythonClass) : super.from();

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

/// ## T
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
final class T extends PythonClass {
  factory T({
    required Object? name,
    Object? filter_out = false,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.grammar",
        "T",
        T.from,
        <Object?>[
          name,
          filter_out,
        ],
        <String, Object?>{},
      );

  T.from(super.pythonClass) : super.from();

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
  factory Token() => PythonFfiDart.instance.importClass(
        "lark.lexer",
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
      PythonFfiDart.instance.importClass(
        "lark.tree",
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

/// ## UnitSkipRule
///
/// ### python docstring
///
/// A rule that records NTs that were skipped during transformation.
///
/// ### python source
/// ```py
/// class UnitSkipRule(Rule):
///     """A rule that records NTs that were skipped during transformation."""
///
///     def __init__(self, lhs, rhs, skipped_rules, weight, alias):
///         super(UnitSkipRule, self).__init__(lhs, rhs, weight, alias)
///         self.skipped_rules = skipped_rules
///
///     def __eq__(self, other):
///         return isinstance(other, type(self)) and self.skipped_rules == other.skipped_rules
///
///     __hash__ = Rule.__hash__
/// ```
final class UnitSkipRule extends PythonClass {
  factory UnitSkipRule({
    required Object? lhs,
    required Object? rhs,
    required Object? skipped_rules,
    required Object? weight,
    required Object? alias,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.cyk",
        "UnitSkipRule",
        UnitSkipRule.from,
        <Object?>[
          lhs,
          rhs,
          skipped_rules,
          weight,
          alias,
        ],
        <String, Object?>{},
      );

  UnitSkipRule.from(super.pythonClass) : super.from();

  /// ## skipped_rules (getter)
  ///
  /// ### python docstring
  ///
  /// A rule that records NTs that were skipped during transformation.
  Object? get skipped_rules => getAttribute("skipped_rules");

  /// ## skipped_rules (setter)
  ///
  /// ### python docstring
  ///
  /// A rule that records NTs that were skipped during transformation.
  set skipped_rules(Object? skipped_rules) =>
      setAttribute("skipped_rules", skipped_rules);
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
  factory ForestSumVisitor() => PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
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
      PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
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
      PythonFfiDart.instance.importClass(
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
      PythonFfiDart.instance.importClass(
        "lark.parsers.earley_common",
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
      PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
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
      PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
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
      PythonFfiDart.instance.importClass(
        "lark.exceptions",
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
      PythonFfiDart.instance.importClass(
        "lark.exceptions",
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

/// ## AmbiguousIntermediateExpander
///
/// ### python docstring
///
/// Propagate ambiguous intermediate nodes and their derivations up to the
/// current rule.
///
/// In general, converts
///
/// rule
///   _iambig
///     _inter
///       someChildren1
///       ...
///     _inter
///       someChildren2
///       ...
///   someChildren3
///   ...
///
/// to
///
/// _ambig
///   rule
///     someChildren1
///     ...
///     someChildren3
///     ...
///   rule
///     someChildren2
///     ...
///     someChildren3
///     ...
///   rule
///     childrenFromNestedIambigs
///     ...
///     someChildren3
///     ...
///   ...
///
/// propagating up any nested '_iambig' nodes along the way.
///
/// ### python source
/// ```py
/// class AmbiguousIntermediateExpander:
///     """
///     Propagate ambiguous intermediate nodes and their derivations up to the
///     current rule.
///
///     In general, converts
///
///     rule
///       _iambig
///         _inter
///           someChildren1
///           ...
///         _inter
///           someChildren2
///           ...
///       someChildren3
///       ...
///
///     to
///
///     _ambig
///       rule
///         someChildren1
///         ...
///         someChildren3
///         ...
///       rule
///         someChildren2
///         ...
///         someChildren3
///         ...
///       rule
///         childrenFromNestedIambigs
///         ...
///         someChildren3
///         ...
///       ...
///
///     propagating up any nested '_iambig' nodes along the way.
///     """
///
///     def __init__(self, tree_class, node_builder):
///         self.node_builder = node_builder
///         self.tree_class = tree_class
///
///     def __call__(self, children):
///         def _is_iambig_tree(child):
///             return hasattr(child, 'data') and child.data == '_iambig'
///
///         def _collapse_iambig(children):
///             """
///             Recursively flatten the derivations of the parent of an '_iambig'
///             node. Returns a list of '_inter' nodes guaranteed not
///             to contain any nested '_iambig' nodes, or None if children does
///             not contain an '_iambig' node.
///             """
///
///             # Due to the structure of the SPPF,
///             # an '_iambig' node can only appear as the first child
///             if children and _is_iambig_tree(children[0]):
///                 iambig_node = children[0]
///                 result = []
///                 for grandchild in iambig_node.children:
///                     collapsed = _collapse_iambig(grandchild.children)
///                     if collapsed:
///                         for child in collapsed:
///                             child.children += children[1:]
///                         result += collapsed
///                     else:
///                         new_tree = self.tree_class('_inter', grandchild.children + children[1:])
///                         result.append(new_tree)
///                 return result
///
///         collapsed = _collapse_iambig(children)
///         if collapsed:
///             processed_nodes = [self.node_builder(c.children) for c in collapsed]
///             return self.tree_class('_ambig', processed_nodes)
///
///         return self.node_builder(children)
/// ```
final class AmbiguousIntermediateExpander extends PythonClass {
  factory AmbiguousIntermediateExpander({
    required Object? tree_class,
    required Object? node_builder,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parse_tree_builder",
        "AmbiguousIntermediateExpander",
        AmbiguousIntermediateExpander.from,
        <Object?>[
          tree_class,
          node_builder,
        ],
        <String, Object?>{},
      );

  AmbiguousIntermediateExpander.from(super.pythonClass) : super.from();

  /// ## node_builder (getter)
  ///
  /// ### python docstring
  ///
  /// Propagate ambiguous intermediate nodes and their derivations up to the
  /// current rule.
  ///
  /// In general, converts
  ///
  /// rule
  ///   _iambig
  ///     _inter
  ///       someChildren1
  ///       ...
  ///     _inter
  ///       someChildren2
  ///       ...
  ///   someChildren3
  ///   ...
  ///
  /// to
  ///
  /// _ambig
  ///   rule
  ///     someChildren1
  ///     ...
  ///     someChildren3
  ///     ...
  ///   rule
  ///     someChildren2
  ///     ...
  ///     someChildren3
  ///     ...
  ///   rule
  ///     childrenFromNestedIambigs
  ///     ...
  ///     someChildren3
  ///     ...
  ///   ...
  ///
  /// propagating up any nested '_iambig' nodes along the way.
  Object? get node_builder => getAttribute("node_builder");

  /// ## node_builder (setter)
  ///
  /// ### python docstring
  ///
  /// Propagate ambiguous intermediate nodes and their derivations up to the
  /// current rule.
  ///
  /// In general, converts
  ///
  /// rule
  ///   _iambig
  ///     _inter
  ///       someChildren1
  ///       ...
  ///     _inter
  ///       someChildren2
  ///       ...
  ///   someChildren3
  ///   ...
  ///
  /// to
  ///
  /// _ambig
  ///   rule
  ///     someChildren1
  ///     ...
  ///     someChildren3
  ///     ...
  ///   rule
  ///     someChildren2
  ///     ...
  ///     someChildren3
  ///     ...
  ///   rule
  ///     childrenFromNestedIambigs
  ///     ...
  ///     someChildren3
  ///     ...
  ///   ...
  ///
  /// propagating up any nested '_iambig' nodes along the way.
  set node_builder(Object? node_builder) =>
      setAttribute("node_builder", node_builder);

  /// ## tree_class (getter)
  ///
  /// ### python docstring
  ///
  /// Propagate ambiguous intermediate nodes and their derivations up to the
  /// current rule.
  ///
  /// In general, converts
  ///
  /// rule
  ///   _iambig
  ///     _inter
  ///       someChildren1
  ///       ...
  ///     _inter
  ///       someChildren2
  ///       ...
  ///   someChildren3
  ///   ...
  ///
  /// to
  ///
  /// _ambig
  ///   rule
  ///     someChildren1
  ///     ...
  ///     someChildren3
  ///     ...
  ///   rule
  ///     someChildren2
  ///     ...
  ///     someChildren3
  ///     ...
  ///   rule
  ///     childrenFromNestedIambigs
  ///     ...
  ///     someChildren3
  ///     ...
  ///   ...
  ///
  /// propagating up any nested '_iambig' nodes along the way.
  Object? get tree_class => getAttribute("tree_class");

  /// ## tree_class (setter)
  ///
  /// ### python docstring
  ///
  /// Propagate ambiguous intermediate nodes and their derivations up to the
  /// current rule.
  ///
  /// In general, converts
  ///
  /// rule
  ///   _iambig
  ///     _inter
  ///       someChildren1
  ///       ...
  ///     _inter
  ///       someChildren2
  ///       ...
  ///   someChildren3
  ///   ...
  ///
  /// to
  ///
  /// _ambig
  ///   rule
  ///     someChildren1
  ///     ...
  ///     someChildren3
  ///     ...
  ///   rule
  ///     someChildren2
  ///     ...
  ///     someChildren3
  ///     ...
  ///   rule
  ///     childrenFromNestedIambigs
  ///     ...
  ///     someChildren3
  ///     ...
  ///   ...
  ///
  /// propagating up any nested '_iambig' nodes along the way.
  set tree_class(Object? tree_class) => setAttribute("tree_class", tree_class);
}

/// ## ForestNode
///
/// ### python source
/// ```py
/// class ForestNode:
///     pass
/// ```
final class ForestNode extends PythonClass {
  factory ForestNode() => PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
        "ForestNode",
        ForestNode.from,
        <Object?>[],
      );

  ForestNode.from(super.pythonClass) : super.from();
}

/// ## ForestToPyDotVisitor
///
/// ### python docstring
///
/// A Forest visitor which writes the SPPF to a PNG.
///
/// The SPPF can get really large, really quickly because
/// of the amount of meta-data it stores, so this is probably
/// only useful for trivial trees and learning how the SPPF
/// is structured.
///
/// ### python source
/// ```py
/// class ForestToPyDotVisitor(ForestVisitor):
///     """
///     A Forest visitor which writes the SPPF to a PNG.
///
///     The SPPF can get really large, really quickly because
///     of the amount of meta-data it stores, so this is probably
///     only useful for trivial trees and learning how the SPPF
///     is structured.
///     """
///     def __init__(self, rankdir="TB"):
///         super(ForestToPyDotVisitor, self).__init__(single_visit=True)
///         self.pydot = import_module('pydot')
///         self.graph = self.pydot.Dot(graph_type='digraph', rankdir=rankdir)
///
///     def visit(self, root, filename):
///         super(ForestToPyDotVisitor, self).visit(root)
///         try:
///             self.graph.write_png(filename)
///         except FileNotFoundError as e:
///             logger.error("Could not write png: ", e)
///
///     def visit_token_node(self, node):
///         graph_node_id = str(id(node))
///         graph_node_label = "\"{}\"".format(node.value.replace('"', '\\"'))
///         graph_node_color = 0x808080
///         graph_node_style = "\"filled,rounded\""
///         graph_node_shape = "diamond"
///         graph_node = self.pydot.Node(graph_node_id, style=graph_node_style, fillcolor="#{:06x}".format(graph_node_color), shape=graph_node_shape, label=graph_node_label)
///         self.graph.add_node(graph_node)
///
///     def visit_packed_node_in(self, node):
///         graph_node_id = str(id(node))
///         graph_node_label = repr(node)
///         graph_node_color = 0x808080
///         graph_node_style = "filled"
///         graph_node_shape = "diamond"
///         graph_node = self.pydot.Node(graph_node_id, style=graph_node_style, fillcolor="#{:06x}".format(graph_node_color), shape=graph_node_shape, label=graph_node_label)
///         self.graph.add_node(graph_node)
///         yield node.left
///         yield node.right
///
///     def visit_packed_node_out(self, node):
///         graph_node_id = str(id(node))
///         graph_node = self.graph.get_node(graph_node_id)[0]
///         for child in [node.left, node.right]:
///             if child is not None:
///                 child_graph_node_id = str(id(child.token if isinstance(child, TokenNode) else child))
///                 child_graph_node = self.graph.get_node(child_graph_node_id)[0]
///                 self.graph.add_edge(self.pydot.Edge(graph_node, child_graph_node))
///             else:
///                 #### Try and be above the Python object ID range; probably impl. specific, but maybe this is okay.
///                 child_graph_node_id = str(randint(100000000000000000000000000000,123456789012345678901234567890))
///                 child_graph_node_style = "invis"
///                 child_graph_node = self.pydot.Node(child_graph_node_id, style=child_graph_node_style, label="None")
///                 child_edge_style = "invis"
///                 self.graph.add_node(child_graph_node)
///                 self.graph.add_edge(self.pydot.Edge(graph_node, child_graph_node, style=child_edge_style))
///
///     def visit_symbol_node_in(self, node):
///         graph_node_id = str(id(node))
///         graph_node_label = repr(node)
///         graph_node_color = 0x808080
///         graph_node_style = "\"filled\""
///         if node.is_intermediate:
///             graph_node_shape = "ellipse"
///         else:
///             graph_node_shape = "rectangle"
///         graph_node = self.pydot.Node(graph_node_id, style=graph_node_style, fillcolor="#{:06x}".format(graph_node_color), shape=graph_node_shape, label=graph_node_label)
///         self.graph.add_node(graph_node)
///         return iter(node.children)
///
///     def visit_symbol_node_out(self, node):
///         graph_node_id = str(id(node))
///         graph_node = self.graph.get_node(graph_node_id)[0]
///         for child in node.children:
///             child_graph_node_id = str(id(child))
///             child_graph_node = self.graph.get_node(child_graph_node_id)[0]
///             self.graph.add_edge(self.pydot.Edge(graph_node, child_graph_node))
/// ```
final class ForestToPyDotVisitor extends PythonClass {
  factory ForestToPyDotVisitor({
    Object? rankdir = "TB",
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
        "ForestToPyDotVisitor",
        ForestToPyDotVisitor.from,
        <Object?>[
          rankdir,
        ],
        <String, Object?>{},
      );

  ForestToPyDotVisitor.from(super.pythonClass) : super.from();

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
  /// def visit(self, root, filename):
  ///         super(ForestToPyDotVisitor, self).visit(root)
  ///         try:
  ///             self.graph.write_png(filename)
  ///         except FileNotFoundError as e:
  ///             logger.error("Could not write png: ", e)
  /// ```
  Object? visit({
    required Object? root,
    required Object? filename,
  }) =>
      getFunction("visit").call(
        <Object?>[
          root,
          filename,
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
  ///         graph_node_id = str(id(node))
  ///         graph_node_label = repr(node)
  ///         graph_node_color = 0x808080
  ///         graph_node_style = "filled"
  ///         graph_node_shape = "diamond"
  ///         graph_node = self.pydot.Node(graph_node_id, style=graph_node_style, fillcolor="#{:06x}".format(graph_node_color), shape=graph_node_shape, label=graph_node_label)
  ///         self.graph.add_node(graph_node)
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
  ///         graph_node_id = str(id(node))
  ///         graph_node = self.graph.get_node(graph_node_id)[0]
  ///         for child in [node.left, node.right]:
  ///             if child is not None:
  ///                 child_graph_node_id = str(id(child.token if isinstance(child, TokenNode) else child))
  ///                 child_graph_node = self.graph.get_node(child_graph_node_id)[0]
  ///                 self.graph.add_edge(self.pydot.Edge(graph_node, child_graph_node))
  ///             else:
  ///                 #### Try and be above the Python object ID range; probably impl. specific, but maybe this is okay.
  ///                 child_graph_node_id = str(randint(100000000000000000000000000000,123456789012345678901234567890))
  ///                 child_graph_node_style = "invis"
  ///                 child_graph_node = self.pydot.Node(child_graph_node_id, style=child_graph_node_style, label="None")
  ///                 child_edge_style = "invis"
  ///                 self.graph.add_node(child_graph_node)
  ///                 self.graph.add_edge(self.pydot.Edge(graph_node, child_graph_node, style=child_edge_style))
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
  ///         graph_node_id = str(id(node))
  ///         graph_node_label = repr(node)
  ///         graph_node_color = 0x808080
  ///         graph_node_style = "\"filled\""
  ///         if node.is_intermediate:
  ///             graph_node_shape = "ellipse"
  ///         else:
  ///             graph_node_shape = "rectangle"
  ///         graph_node = self.pydot.Node(graph_node_id, style=graph_node_style, fillcolor="#{:06x}".format(graph_node_color), shape=graph_node_shape, label=graph_node_label)
  ///         self.graph.add_node(graph_node)
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
  ///         graph_node_id = str(id(node))
  ///         graph_node = self.graph.get_node(graph_node_id)[0]
  ///         for child in node.children:
  ///             child_graph_node_id = str(id(child))
  ///             child_graph_node = self.graph.get_node(child_graph_node_id)[0]
  ///             self.graph.add_edge(self.pydot.Edge(graph_node, child_graph_node))
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
  ///         graph_node_id = str(id(node))
  ///         graph_node_label = "\"{}\"".format(node.value.replace('"', '\\"'))
  ///         graph_node_color = 0x808080
  ///         graph_node_style = "\"filled,rounded\""
  ///         graph_node_shape = "diamond"
  ///         graph_node = self.pydot.Node(graph_node_id, style=graph_node_style, fillcolor="#{:06x}".format(graph_node_color), shape=graph_node_shape, label=graph_node_label)
  ///         self.graph.add_node(graph_node)
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

  /// ## pydot (getter)
  ///
  /// ### python docstring
  ///
  /// A Forest visitor which writes the SPPF to a PNG.
  ///
  /// The SPPF can get really large, really quickly because
  /// of the amount of meta-data it stores, so this is probably
  /// only useful for trivial trees and learning how the SPPF
  /// is structured.
  Object? get pydot => getAttribute("pydot");

  /// ## pydot (setter)
  ///
  /// ### python docstring
  ///
  /// A Forest visitor which writes the SPPF to a PNG.
  ///
  /// The SPPF can get really large, really quickly because
  /// of the amount of meta-data it stores, so this is probably
  /// only useful for trivial trees and learning how the SPPF
  /// is structured.
  set pydot(Object? pydot) => setAttribute("pydot", pydot);

  /// ## graph (getter)
  ///
  /// ### python docstring
  ///
  /// A Forest visitor which writes the SPPF to a PNG.
  ///
  /// The SPPF can get really large, really quickly because
  /// of the amount of meta-data it stores, so this is probably
  /// only useful for trivial trees and learning how the SPPF
  /// is structured.
  Object? get graph => getAttribute("graph");

  /// ## graph (setter)
  ///
  /// ### python docstring
  ///
  /// A Forest visitor which writes the SPPF to a PNG.
  ///
  /// The SPPF can get really large, really quickly because
  /// of the amount of meta-data it stores, so this is probably
  /// only useful for trivial trees and learning how the SPPF
  /// is structured.
  set graph(Object? graph) => setAttribute("graph", graph);
}

/// ## ForestTransformer
///
/// ### python docstring
///
/// The base class for a bottom-up forest transformation. Most users will
/// want to use ``TreeForestTransformer`` instead as it has a friendlier
/// interface and covers most use cases.
///
/// Transformations are applied via inheritance and overriding of the
/// ``transform*node`` methods.
///
/// ``transform_token_node`` receives a ``Token`` as an argument.
/// All other methods receive the node that is being transformed and
/// a list of the results of the transformations of that node's children.
/// The return value of these methods are the resulting transformations.
///
/// If ``Discard`` is raised in a node's transformation, no data from that node
/// will be passed to its parent's transformation.
///
/// ### python source
/// ```py
/// class ForestTransformer(ForestVisitor):
///     """The base class for a bottom-up forest transformation. Most users will
///     want to use ``TreeForestTransformer`` instead as it has a friendlier
///     interface and covers most use cases.
///
///     Transformations are applied via inheritance and overriding of the
///     ``transform*node`` methods.
///
///     ``transform_token_node`` receives a ``Token`` as an argument.
///     All other methods receive the node that is being transformed and
///     a list of the results of the transformations of that node's children.
///     The return value of these methods are the resulting transformations.
///
///     If ``Discard`` is raised in a node's transformation, no data from that node
///     will be passed to its parent's transformation.
///     """
///
///     def __init__(self):
///         super(ForestTransformer, self).__init__()
///         # results of transformations
///         self.data = dict()
///         # used to track parent nodes
///         self.node_stack = deque()
///
///     def transform(self, root):
///         """Perform a transformation on an SPPF."""
///         self.node_stack.append('result')
///         self.data['result'] = []
///         self.visit(root)
///         assert len(self.data['result']) <= 1
///         if self.data['result']:
///             return self.data['result'][0]
///
///     def transform_symbol_node(self, node, data):
///         """Transform a symbol node."""
///         return node
///
///     def transform_intermediate_node(self, node, data):
///         """Transform an intermediate node."""
///         return node
///
///     def transform_packed_node(self, node, data):
///         """Transform a packed node."""
///         return node
///
///     def transform_token_node(self, node):
///         """Transform a ``Token``."""
///         return node
///
///     def visit_symbol_node_in(self, node):
///         self.node_stack.append(id(node))
///         self.data[id(node)] = []
///         return node.children
///
///     def visit_packed_node_in(self, node):
///         self.node_stack.append(id(node))
///         self.data[id(node)] = []
///         return node.children
///
///     def visit_token_node(self, node):
///         transformed = self.transform_token_node(node)
///         if transformed is not Discard:
///             self.data[self.node_stack[-1]].append(transformed)
///
///     def _visit_node_out_helper(self, node, method):
///         self.node_stack.pop()
///         transformed = method(node, self.data[id(node)])
///         if transformed is not Discard:
///             self.data[self.node_stack[-1]].append(transformed)
///         del self.data[id(node)]
///
///     def visit_symbol_node_out(self, node):
///         self._visit_node_out_helper(node, self.transform_symbol_node)
///
///     def visit_intermediate_node_out(self, node):
///         self._visit_node_out_helper(node, self.transform_intermediate_node)
///
///     def visit_packed_node_out(self, node):
///         self._visit_node_out_helper(node, self.transform_packed_node)
/// ```
final class ForestTransformer extends PythonClass {
  factory ForestTransformer() => PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
        "ForestTransformer",
        ForestTransformer.from,
        <Object?>[],
        <String, Object?>{},
      );

  ForestTransformer.from(super.pythonClass) : super.from();

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
  ///         """Transform an intermediate node."""
  ///         return node
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
  ///         """Transform a packed node."""
  ///         return node
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
  ///         """Transform a symbol node."""
  ///         return node
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
  ///         self.node_stack.append(id(node))
  ///         self.data[id(node)] = []
  ///         return node.children
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
  ///         self._visit_node_out_helper(node, self.transform_packed_node)
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
  ///         self.node_stack.append(id(node))
  ///         self.data[id(node)] = []
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

  /// ## data (getter)
  ///
  /// ### python docstring
  ///
  /// The base class for a bottom-up forest transformation. Most users will
  /// want to use ``TreeForestTransformer`` instead as it has a friendlier
  /// interface and covers most use cases.
  ///
  /// Transformations are applied via inheritance and overriding of the
  /// ``transform*node`` methods.
  ///
  /// ``transform_token_node`` receives a ``Token`` as an argument.
  /// All other methods receive the node that is being transformed and
  /// a list of the results of the transformations of that node's children.
  /// The return value of these methods are the resulting transformations.
  ///
  /// If ``Discard`` is raised in a node's transformation, no data from that node
  /// will be passed to its parent's transformation.
  Object? get data => getAttribute("data");

  /// ## data (setter)
  ///
  /// ### python docstring
  ///
  /// The base class for a bottom-up forest transformation. Most users will
  /// want to use ``TreeForestTransformer`` instead as it has a friendlier
  /// interface and covers most use cases.
  ///
  /// Transformations are applied via inheritance and overriding of the
  /// ``transform*node`` methods.
  ///
  /// ``transform_token_node`` receives a ``Token`` as an argument.
  /// All other methods receive the node that is being transformed and
  /// a list of the results of the transformations of that node's children.
  /// The return value of these methods are the resulting transformations.
  ///
  /// If ``Discard`` is raised in a node's transformation, no data from that node
  /// will be passed to its parent's transformation.
  set data(Object? data) => setAttribute("data", data);

  /// ## node_stack (getter)
  ///
  /// ### python docstring
  ///
  /// The base class for a bottom-up forest transformation. Most users will
  /// want to use ``TreeForestTransformer`` instead as it has a friendlier
  /// interface and covers most use cases.
  ///
  /// Transformations are applied via inheritance and overriding of the
  /// ``transform*node`` methods.
  ///
  /// ``transform_token_node`` receives a ``Token`` as an argument.
  /// All other methods receive the node that is being transformed and
  /// a list of the results of the transformations of that node's children.
  /// The return value of these methods are the resulting transformations.
  ///
  /// If ``Discard`` is raised in a node's transformation, no data from that node
  /// will be passed to its parent's transformation.
  Object? get node_stack => getAttribute("node_stack");

  /// ## node_stack (setter)
  ///
  /// ### python docstring
  ///
  /// The base class for a bottom-up forest transformation. Most users will
  /// want to use ``TreeForestTransformer`` instead as it has a friendlier
  /// interface and covers most use cases.
  ///
  /// Transformations are applied via inheritance and overriding of the
  /// ``transform*node`` methods.
  ///
  /// ``transform_token_node`` receives a ``Token`` as an argument.
  /// All other methods receive the node that is being transformed and
  /// a list of the results of the transformations of that node's children.
  /// The return value of these methods are the resulting transformations.
  ///
  /// If ``Discard`` is raised in a node's transformation, no data from that node
  /// will be passed to its parent's transformation.
  set node_stack(Object? node_stack) => setAttribute("node_stack", node_stack);
}

/// ## ForestVisitor
///
/// ### python docstring
///
/// An abstract base class for building forest visitors.
///
/// This class performs a controllable depth-first walk of an SPPF.
/// The visitor will not enter cycles and will backtrack if one is encountered.
/// Subclasses are notified of cycles through the ``on_cycle`` method.
///
/// Behavior for visit events is defined by overriding the
/// ``visit*node*`` functions.
///
/// The walk is controlled by the return values of the ``visit*node_in``
/// methods. Returning a node(s) will schedule them to be visited. The visitor
/// will begin to backtrack if no nodes are returned.
///
/// Parameters:
///     single_visit: If ``True``, non-Token nodes will only be visited once.
///
/// ### python source
/// ```py
/// class ForestVisitor:
///     """
///     An abstract base class for building forest visitors.
///
///     This class performs a controllable depth-first walk of an SPPF.
///     The visitor will not enter cycles and will backtrack if one is encountered.
///     Subclasses are notified of cycles through the ``on_cycle`` method.
///
///     Behavior for visit events is defined by overriding the
///     ``visit*node*`` functions.
///
///     The walk is controlled by the return values of the ``visit*node_in``
///     methods. Returning a node(s) will schedule them to be visited. The visitor
///     will begin to backtrack if no nodes are returned.
///
///     Parameters:
///         single_visit: If ``True``, non-Token nodes will only be visited once.
///     """
///
///     def __init__(self, single_visit=False):
///         self.single_visit = single_visit
///
///     def visit_token_node(self, node):
///         """Called when a ``Token`` is visited. ``Token`` nodes are always leaves."""
///         pass
///
///     def visit_symbol_node_in(self, node):
///         """Called when a symbol node is visited. Nodes that are returned
///         will be scheduled to be visited. If ``visit_intermediate_node_in``
///         is not implemented, this function will be called for intermediate
///         nodes as well."""
///         pass
///
///     def visit_symbol_node_out(self, node):
///         """Called after all nodes returned from a corresponding ``visit_symbol_node_in``
///         call have been visited. If ``visit_intermediate_node_out``
///         is not implemented, this function will be called for intermediate
///         nodes as well."""
///         pass
///
///     def visit_packed_node_in(self, node):
///         """Called when a packed node is visited. Nodes that are returned
///         will be scheduled to be visited. """
///         pass
///
///     def visit_packed_node_out(self, node):
///         """Called after all nodes returned from a corresponding ``visit_packed_node_in``
///         call have been visited."""
///         pass
///
///     def on_cycle(self, node, path):
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
///
///     def get_cycle_in_path(self, node, path):
///         """A utility function for use in ``on_cycle`` to obtain a slice of
///         ``path`` that only contains the nodes that make up the cycle."""
///         index = len(path) - 1
///         while id(path[index]) != id(node):
///             index -= 1
///         return path[index:]
///
///     def visit(self, root):
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
final class ForestVisitor extends PythonClass {
  factory ForestVisitor({
    Object? single_visit = false,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
        "ForestVisitor",
        ForestVisitor.from,
        <Object?>[
          single_visit,
        ],
        <String, Object?>{},
      );

  ForestVisitor.from(super.pythonClass) : super.from();

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
  ///         """Called when a packed node is visited. Nodes that are returned
  ///         will be scheduled to be visited. """
  ///         pass
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
  ///         """Called after all nodes returned from a corresponding ``visit_packed_node_in``
  ///         call have been visited."""
  ///         pass
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
  ///         """Called when a symbol node is visited. Nodes that are returned
  ///         will be scheduled to be visited. If ``visit_intermediate_node_in``
  ///         is not implemented, this function will be called for intermediate
  ///         nodes as well."""
  ///         pass
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
  ///         """Called after all nodes returned from a corresponding ``visit_symbol_node_in``
  ///         call have been visited. If ``visit_intermediate_node_out``
  ///         is not implemented, this function will be called for intermediate
  ///         nodes as well."""
  ///         pass
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

  /// ## single_visit (getter)
  ///
  /// ### python docstring
  ///
  /// An abstract base class for building forest visitors.
  ///
  /// This class performs a controllable depth-first walk of an SPPF.
  /// The visitor will not enter cycles and will backtrack if one is encountered.
  /// Subclasses are notified of cycles through the ``on_cycle`` method.
  ///
  /// Behavior for visit events is defined by overriding the
  /// ``visit*node*`` functions.
  ///
  /// The walk is controlled by the return values of the ``visit*node_in``
  /// methods. Returning a node(s) will schedule them to be visited. The visitor
  /// will begin to backtrack if no nodes are returned.
  ///
  /// Parameters:
  ///     single_visit: If ``True``, non-Token nodes will only be visited once.
  Object? get single_visit => getAttribute("single_visit");

  /// ## single_visit (setter)
  ///
  /// ### python docstring
  ///
  /// An abstract base class for building forest visitors.
  ///
  /// This class performs a controllable depth-first walk of an SPPF.
  /// The visitor will not enter cycles and will backtrack if one is encountered.
  /// Subclasses are notified of cycles through the ``on_cycle`` method.
  ///
  /// Behavior for visit events is defined by overriding the
  /// ``visit*node*`` functions.
  ///
  /// The walk is controlled by the return values of the ``visit*node_in``
  /// methods. Returning a node(s) will schedule them to be visited. The visitor
  /// will begin to backtrack if no nodes are returned.
  ///
  /// Parameters:
  ///     single_visit: If ``True``, non-Token nodes will only be visited once.
  set single_visit(Object? single_visit) =>
      setAttribute("single_visit", single_visit);
}

/// ## PackedData
///
/// ### python docstring
///
/// Used in transformationss of packed nodes to distinguish the data
/// that comes from the left child and the right child.
///
/// ### python source
/// ```py
/// class PackedData():
///     """Used in transformationss of packed nodes to distinguish the data
///     that comes from the left child and the right child.
///     """
///
///     class _NoData():
///         pass
///
///     NO_DATA = _NoData()
///
///     def __init__(self, node, data):
///         self.left = self.NO_DATA
///         self.right = self.NO_DATA
///         if data:
///             if node.left is not None:
///                 self.left = data[0]
///                 if len(data) > 1:
///                     self.right = data[1]
///             else:
///                 self.right = data[0]
/// ```
final class PackedData extends PythonClass {
  factory PackedData({
    required Object? node,
    required Object? data,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
        "PackedData",
        PackedData.from,
        <Object?>[
          node,
          data,
        ],
        <String, Object?>{},
      );

  PackedData.from(super.pythonClass) : super.from();

  /// ## NO_DATA (getter)
  ///
  /// ### python docstring
  ///
  /// Used in transformationss of packed nodes to distinguish the data
  /// that comes from the left child and the right child.
  Object? get NO_DATA => getAttribute("NO_DATA");

  /// ## NO_DATA (setter)
  ///
  /// ### python docstring
  ///
  /// Used in transformationss of packed nodes to distinguish the data
  /// that comes from the left child and the right child.
  set NO_DATA(Object? NO_DATA) => setAttribute("NO_DATA", NO_DATA);

  /// ## left (getter)
  ///
  /// ### python docstring
  ///
  /// Used in transformationss of packed nodes to distinguish the data
  /// that comes from the left child and the right child.
  Object? get left => getAttribute("left");

  /// ## left (setter)
  ///
  /// ### python docstring
  ///
  /// Used in transformationss of packed nodes to distinguish the data
  /// that comes from the left child and the right child.
  set left(Object? left) => setAttribute("left", left);

  /// ## right (getter)
  ///
  /// ### python docstring
  ///
  /// Used in transformationss of packed nodes to distinguish the data
  /// that comes from the left child and the right child.
  Object? get right => getAttribute("right");

  /// ## right (setter)
  ///
  /// ### python docstring
  ///
  /// Used in transformationss of packed nodes to distinguish the data
  /// that comes from the left child and the right child.
  set right(Object? right) => setAttribute("right", right);
}

/// ## PackedNode
///
/// ### python docstring
///
/// A Packed Node represents a single derivation in a symbol node.
///
/// Parameters:
///     rule: The rule associated with this node.
///     parent: The parent of this node.
///     left: The left child of this node. ``None`` if one does not exist.
///     right: The right child of this node. ``None`` if one does not exist.
///     priority: The priority of this node.
///
/// ### python source
/// ```py
/// class PackedNode(ForestNode):
///     """
///     A Packed Node represents a single derivation in a symbol node.
///
///     Parameters:
///         rule: The rule associated with this node.
///         parent: The parent of this node.
///         left: The left child of this node. ``None`` if one does not exist.
///         right: The right child of this node. ``None`` if one does not exist.
///         priority: The priority of this node.
///     """
///     __slots__ = ('parent', 's', 'rule', 'start', 'left', 'right', 'priority', '_hash')
///     def __init__(self, parent, s, rule, start, left, right):
///         self.parent = parent
///         self.s = s
///         self.start = start
///         self.rule = rule
///         self.left = left
///         self.right = right
///         self.priority = float('-inf')
///         self._hash = hash((self.left, self.right))
///
///     @property
///     def is_empty(self):
///         return self.left is None and self.right is None
///
///     @property
///     def sort_key(self):
///         """
///         Used to sort PackedNode children of SymbolNodes.
///         A SymbolNode has multiple PackedNodes if it matched
///         ambiguously. Hence, we use the sort order to identify
///         the order in which ambiguous children should be considered.
///         """
///         return self.is_empty, -self.priority, self.rule.order
///
///     @property
///     def children(self):
///         """Returns a list of this node's children."""
///         return [x for x in [self.left, self.right] if x is not None]
///
///     def __iter__(self):
///         yield self.left
///         yield self.right
///
///     def __eq__(self, other):
///         if not isinstance(other, PackedNode):
///             return False
///         return self is other or (self.left == other.left and self.right == other.right)
///
///     def __hash__(self):
///         return self._hash
///
///     def __repr__(self):
///         if isinstance(self.s, tuple):
///             rule = self.s[0]
///             ptr = self.s[1]
///             before = ( expansion.name for expansion in rule.expansion[:ptr] )
///             after = ( expansion.name for expansion in rule.expansion[ptr:] )
///             symbol = "{} ::= {}* {}".format(rule.origin.name, ' '.join(before), ' '.join(after))
///         else:
///             symbol = self.s.name
///         return "({}, {}, {}, {})".format(symbol, self.start, self.priority, self.rule.order)
/// ```
final class PackedNode extends PythonClass {
  factory PackedNode({
    required Object? parent,
    required Object? s,
    required Object? rule,
    required Object? start,
    required Object? left,
    required Object? right,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
        "PackedNode",
        PackedNode.from,
        <Object?>[
          parent,
          s,
          rule,
          start,
          left,
          right,
        ],
        <String, Object?>{},
      );

  PackedNode.from(super.pythonClass) : super.from();

  /// ## children (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get children => getAttribute("children");

  /// ## children (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set children(Object? children) => setAttribute("children", children);

  /// ## is_empty (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get is_empty => getAttribute("is_empty");

  /// ## is_empty (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set is_empty(Object? is_empty) => setAttribute("is_empty", is_empty);

  /// ## sort_key (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get sort_key => getAttribute("sort_key");

  /// ## sort_key (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set sort_key(Object? sort_key) => setAttribute("sort_key", sort_key);

  /// ## left (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get left => getAttribute("left");

  /// ## left (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set left(Object? left) => setAttribute("left", left);

  /// ## parent (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get parent => getAttribute("parent");

  /// ## parent (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set parent(Object? parent) => setAttribute("parent", parent);

  /// ## priority (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get priority => getAttribute("priority");

  /// ## priority (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set priority(Object? priority) => setAttribute("priority", priority);

  /// ## right (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get right => getAttribute("right");

  /// ## right (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set right(Object? right) => setAttribute("right", right);

  /// ## rule (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get rule => getAttribute("rule");

  /// ## rule (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set rule(Object? rule) => setAttribute("rule", rule);

  /// ## s (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get s => getAttribute("s");

  /// ## s (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set s(Object? s) => setAttribute("s", s);

  /// ## start (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get start => getAttribute("start");

  /// ## start (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set start(Object? start) => setAttribute("start", start);
}

/// ## TreeForestTransformer
///
/// ### python docstring
///
/// A ``ForestTransformer`` with a tree ``Transformer``-like interface.
/// By default, it will construct a tree.
///
/// Methods provided via inheritance are called based on the rule/symbol
/// names of nodes in the forest.
///
/// Methods that act on rules will receive a list of the results of the
/// transformations of the rule's children. By default, trees and tokens.
///
/// Methods that act on tokens will receive a token.
///
/// Alternatively, methods that act on rules may be annotated with
/// ``handles_ambiguity``. In this case, the function will receive a list
/// of all the transformations of all the derivations of the rule.
/// By default, a list of trees where each tree.data is equal to the
/// rule name or one of its aliases.
///
/// Non-tree transformations are made possible by override of
/// ``__default__``, ``__default_token__``, and ``__default_ambig__``.
///
/// Note:
///     Tree shaping features such as inlined rules and token filtering are
///     not built into the transformation. Positions are also not propagated.
///
/// Parameters:
///     tree_class: The tree class to use for construction
///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of nodes in the SPPF.
///     resolve_ambiguity: If True, ambiguities will be resolved based on priorities.
///     use_cache (bool): If True, caches the results of some transformations,
///                       potentially improving performance when ``resolve_ambiguity==False``.
///                       Only use if you know what you are doing: i.e. All transformation
///                       functions are pure and referentially transparent.
///
/// ### python source
/// ```py
/// class TreeForestTransformer(ForestToParseTree):
///     """A ``ForestTransformer`` with a tree ``Transformer``-like interface.
///     By default, it will construct a tree.
///
///     Methods provided via inheritance are called based on the rule/symbol
///     names of nodes in the forest.
///
///     Methods that act on rules will receive a list of the results of the
///     transformations of the rule's children. By default, trees and tokens.
///
///     Methods that act on tokens will receive a token.
///
///     Alternatively, methods that act on rules may be annotated with
///     ``handles_ambiguity``. In this case, the function will receive a list
///     of all the transformations of all the derivations of the rule.
///     By default, a list of trees where each tree.data is equal to the
///     rule name or one of its aliases.
///
///     Non-tree transformations are made possible by override of
///     ``__default__``, ``__default_token__``, and ``__default_ambig__``.
///
///     Note:
///         Tree shaping features such as inlined rules and token filtering are
///         not built into the transformation. Positions are also not propagated.
///
///     Parameters:
///         tree_class: The tree class to use for construction
///         prioritizer: A ``ForestVisitor`` that manipulates the priorities of nodes in the SPPF.
///         resolve_ambiguity: If True, ambiguities will be resolved based on priorities.
///         use_cache (bool): If True, caches the results of some transformations,
///                           potentially improving performance when ``resolve_ambiguity==False``.
///                           Only use if you know what you are doing: i.e. All transformation
///                           functions are pure and referentially transparent.
///     """
///
///     def __init__(self, tree_class=Tree, prioritizer=ForestSumVisitor(), resolve_ambiguity=True, use_cache=False):
///         super(TreeForestTransformer, self).__init__(tree_class, dict(), prioritizer, resolve_ambiguity, use_cache)
///
///     def __default__(self, name, data):
///         """Default operation on tree (for override).
///
///         Returns a tree with name with data as children.
///         """
///         return self.tree_class(name, data)
///
///     def __default_ambig__(self, name, data):
///         """Default operation on ambiguous rule (for override).
///
///         Wraps data in an '_ambig_' node if it contains more than
///         one element.
///         """
///         if len(data) > 1:
///             return self.tree_class('_ambig', data)
///         elif data:
///             return data[0]
///         return Discard
///
///     def __default_token__(self, node):
///         """Default operation on ``Token`` (for override).
///
///         Returns ``node``.
///         """
///         return node
///
///     def transform_token_node(self, node):
///         return getattr(self, node.type, self.__default_token__)(node)
///
///     def _call_rule_func(self, node, data):
///         name = node.rule.alias or node.rule.options.template_source or node.rule.origin.name
///         user_func = getattr(self, name, self.__default__)
///         if user_func == self.__default__ or hasattr(user_func, 'handles_ambiguity'):
///             user_func = partial(self.__default__, name)
///         if not self.resolve_ambiguity:
///             wrapper = partial(AmbiguousIntermediateExpander, self.tree_class)
///             user_func = wrapper(user_func)
///         return user_func(data)
///
///     def _call_ambig_func(self, node, data):
///         name = node.s.name
///         user_func = getattr(self, name, self.__default_ambig__)
///         if user_func == self.__default_ambig__ or not hasattr(user_func, 'handles_ambiguity'):
///             user_func = partial(self.__default_ambig__, name)
///         return user_func(data)
/// ```
final class TreeForestTransformer extends PythonClass {
  factory TreeForestTransformer({
    Object? tree_class,
    Object? prioritizer,
    Object? resolve_ambiguity = true,
    Object? use_cache = false,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
        "TreeForestTransformer",
        TreeForestTransformer.from,
        <Object?>[
          tree_class,
          prioritizer,
          resolve_ambiguity,
          use_cache,
        ],
        <String, Object?>{},
      );

  TreeForestTransformer.from(super.pythonClass) : super.from();

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
  ///         return getattr(self, node.type, self.__default_token__)(node)
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
}

/// ## GrammarError
///
/// ### python source
/// ```py
/// class GrammarError(LarkError):
///     pass
/// ```
final class GrammarError extends PythonClass {
  factory GrammarError() => PythonFfiDart.instance.importClass(
        "lark.exceptions",
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
      PythonFfiDart.instance.importClass(
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
      PythonFfiDart.instance.importClass(
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

/// ## Action
///
/// ### python source
/// ```py
/// class Action:
///     def __init__(self, name):
///         self.name = name
///     def __str__(self):
///         return self.name
///     def __repr__(self):
///         return str(self)
/// ```
final class Action extends PythonClass {
  factory Action({
    required Object? name,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.lalr_analysis",
        "Action",
        Action.from,
        <Object?>[
          name,
        ],
        <String, Object?>{},
      );

  Action.from(super.pythonClass) : super.from();

  /// ## name (getter)
  Object? get name => getAttribute("name");

  /// ## name (setter)
  set name(Object? name) => setAttribute("name", name);
}

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

/// ## IntParseTable
///
/// ### python source
/// ```py
/// class IntParseTable(ParseTable):
///
///     @classmethod
///     def from_ParseTable(cls, parse_table):
///         enum = list(parse_table.states)
///         state_to_idx = {s:i for i,s in enumerate(enum)}
///         int_states = {}
///
///         for s, la in parse_table.states.items():
///             la = {k:(v[0], state_to_idx[v[1]]) if v[0] is Shift else v
///                   for k,v in la.items()}
///             int_states[ state_to_idx[s] ] = la
///
///
///         start_states = {start:state_to_idx[s] for start, s in parse_table.start_states.items()}
///         end_states = {start:state_to_idx[s] for start, s in parse_table.end_states.items()}
///         return cls(int_states, start_states, end_states)
/// ```
final class IntParseTable extends PythonClass {
  factory IntParseTable({
    required Object? states,
    required Object? start_states,
    required Object? end_states,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.lalr_analysis",
        "IntParseTable",
        IntParseTable.from,
        <Object?>[
          states,
          start_states,
          end_states,
        ],
        <String, Object?>{},
      );

  IntParseTable.from(super.pythonClass) : super.from();

  /// ## serialize
  ///
  /// ### python source
  /// ```py
  /// def serialize(self, memo):
  ///         tokens = Enumerator()
  ///
  ///         states = {
  ///             state: {tokens.get(token): ((1, arg.serialize(memo)) if action is Reduce else (0, arg))
  ///                     for token, (action, arg) in actions.items()}
  ///             for state, actions in self.states.items()
  ///         }
  ///
  ///         return {
  ///             'tokens': tokens.reversed(),
  ///             'states': states,
  ///             'start_states': self.start_states,
  ///             'end_states': self.end_states,
  ///         }
  /// ```
  Object? serialize({
    required Object? memo,
  }) =>
      getFunction("serialize").call(
        <Object?>[
          memo,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## deserialize (getter)
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## from_ParseTable (getter)
  Object? get from_ParseTable => getAttribute("from_ParseTable");

  /// ## from_ParseTable (setter)
  set from_ParseTable(Object? from_ParseTable) =>
      setAttribute("from_ParseTable", from_ParseTable);

  /// ## states (getter)
  Object? get states => getAttribute("states");

  /// ## states (setter)
  set states(Object? states) => setAttribute("states", states);

  /// ## start_states (getter)
  Object? get start_states => getAttribute("start_states");

  /// ## start_states (setter)
  set start_states(Object? start_states) =>
      setAttribute("start_states", start_states);

  /// ## end_states (getter)
  Object? get end_states => getAttribute("end_states");

  /// ## end_states (setter)
  set end_states(Object? end_states) => setAttribute("end_states", end_states);
}

/// ## LALR_Analyzer
///
/// ### python source
/// ```py
/// class LALR_Analyzer(GrammarAnalyzer):
///     def __init__(self, parser_conf, debug=False, strict=False):
///         GrammarAnalyzer.__init__(self, parser_conf, debug, strict)
///         self.nonterminal_transitions = []
///         self.directly_reads = defaultdict(set)
///         self.reads = defaultdict(set)
///         self.includes = defaultdict(set)
///         self.lookback = defaultdict(set)
///
///
///     def compute_lr0_states(self):
///         self.lr0_states = set()
///         # map of kernels to LR0ItemSets
///         cache = {}
///
///         def step(state):
///             _, unsat = classify_bool(state.closure, lambda rp: rp.is_satisfied)
///
///             d = classify(unsat, lambda rp: rp.next)
///             for sym, rps in d.items():
///                 kernel = fzset({rp.advance(sym) for rp in rps})
///                 new_state = cache.get(kernel, None)
///                 if new_state is None:
///                     closure = set(kernel)
///                     for rp in kernel:
///                         if not rp.is_satisfied and not rp.next.is_term:
///                             closure |= self.expand_rule(rp.next, self.lr0_rules_by_origin)
///                     new_state = LR0ItemSet(kernel, closure)
///                     cache[kernel] = new_state
///
///                 state.transitions[sym] = new_state
///                 yield new_state
///
///             self.lr0_states.add(state)
///
///         for _ in bfs(self.lr0_start_states.values(), step):
///             pass
///
///     def compute_reads_relations(self):
///         # handle start state
///         for root in self.lr0_start_states.values():
///             assert(len(root.kernel) == 1)
///             for rp in root.kernel:
///                 assert(rp.index == 0)
///                 self.directly_reads[(root, rp.next)] = set([ Terminal('$END') ])
///
///         for state in self.lr0_states:
///             seen = set()
///             for rp in state.closure:
///                 if rp.is_satisfied:
///                     continue
///                 s = rp.next
///                 # if s is a not a nonterminal
///                 if s not in self.lr0_rules_by_origin:
///                     continue
///                 if s in seen:
///                     continue
///                 seen.add(s)
///                 nt = (state, s)
///                 self.nonterminal_transitions.append(nt)
///                 dr = self.directly_reads[nt]
///                 r = self.reads[nt]
///                 next_state = state.transitions[s]
///                 for rp2 in next_state.closure:
///                     if rp2.is_satisfied:
///                         continue
///                     s2 = rp2.next
///                     # if s2 is a terminal
///                     if s2 not in self.lr0_rules_by_origin:
///                         dr.add(s2)
///                     if s2 in self.NULLABLE:
///                         r.add((next_state, s2))
///
///     def compute_includes_lookback(self):
///         for nt in self.nonterminal_transitions:
///             state, nonterminal = nt
///             includes = []
///             lookback = self.lookback[nt]
///             for rp in state.closure:
///                 if rp.rule.origin != nonterminal:
///                     continue
///                 # traverse the states for rp(.rule)
///                 state2 = state
///                 for i in range(rp.index, len(rp.rule.expansion)):
///                     s = rp.rule.expansion[i]
///                     nt2 = (state2, s)
///                     state2 = state2.transitions[s]
///                     if nt2 not in self.reads:
///                         continue
///                     for j in range(i + 1, len(rp.rule.expansion)):
///                         if rp.rule.expansion[j] not in self.NULLABLE:
///                             break
///                     else:
///                         includes.append(nt2)
///                 # state2 is at the final state for rp.rule
///                 if rp.index == 0:
///                     for rp2 in state2.closure:
///                         if (rp2.rule == rp.rule) and rp2.is_satisfied:
///                             lookback.add((state2, rp2.rule))
///             for nt2 in includes:
///                 self.includes[nt2].add(nt)
///
///     def compute_lookaheads(self):
///         read_sets = digraph(self.nonterminal_transitions, self.reads, self.directly_reads)
///         follow_sets = digraph(self.nonterminal_transitions, self.includes, read_sets)
///
///         for nt, lookbacks in self.lookback.items():
///             for state, rule in lookbacks:
///                 for s in follow_sets[nt]:
///                     state.lookaheads[s].add(rule)
///
///     def compute_lalr1_states(self):
///         m = {}
///         reduce_reduce = []
///         for state in self.lr0_states:
///             actions = {la: (Shift, next_state.closure) for la, next_state in state.transitions.items()}
///             for la, rules in state.lookaheads.items():
///                 if len(rules) > 1:
///                     # Try to resolve conflict based on priority
///                     p = [(r.options.priority or 0, r) for r in rules]
///                     p.sort(key=lambda r: r[0], reverse=True)
///                     best, second_best = p[:2]
///                     if best[0] > second_best[0]:
///                         rules = [best[1]]
///                     else:
///                         reduce_reduce.append((state, la, rules))
///                         continue
///
///                 rule ,= rules
///                 if la in actions:
///                     if self.strict:
///                         raise GrammarError(f"Shift/Reduce conflict for terminal {la.name}. [strict-mode]\n ")
///                     elif self.debug:
///                         logger.warning('Shift/Reduce conflict for terminal %s: (resolving as shift)', la.name)
///                         logger.warning(' * %s', rule)
///                     else:
///                         logger.debug('Shift/Reduce conflict for terminal %s: (resolving as shift)', la.name)
///                         logger.debug(' * %s', rule)
///                 else:
///                     actions[la] = (Reduce, list(rules)[0])
///             m[state] = { k.name: v for k, v in actions.items() }
///
///         if reduce_reduce:
///             msgs = []
///             for state, la, rules in reduce_reduce:
///                 msg = 'Reduce/Reduce collision in %s between the following rules: %s' % (la, ''.join([ '\n\t- ' + str(r) for r in rules ]))
///                 if self.debug:
///                     msg += '\n    collision occurred in state: {%s\n    }' % ''.join(['\n\t' + str(x) for x in state.closure])
///                 msgs.append(msg)
///             raise GrammarError('\n\n'.join(msgs))
///
///         states = { k.closure: v for k, v in m.items() }
///
///         # compute end states
///         end_states = {}
///         for state in states:
///             for rp in state:
///                 for start in self.lr0_start_states:
///                     if rp.rule.origin.name == ('$root_' + start) and rp.is_satisfied:
///                         assert(start not in end_states)
///                         end_states[start] = state
///
///         _parse_table = ParseTable(states, { start: state.closure for start, state in self.lr0_start_states.items() }, end_states)
///
///         if self.debug:
///             self.parse_table = _parse_table
///         else:
///             self.parse_table = IntParseTable.from_ParseTable(_parse_table)
///
///     def compute_lalr(self):
///         self.compute_lr0_states()
///         self.compute_reads_relations()
///         self.compute_includes_lookback()
///         self.compute_lookaheads()
///         self.compute_lalr1_states()
/// ```
final class LALR_Analyzer extends PythonClass {
  factory LALR_Analyzer({
    required Object? parser_conf,
    Object? debug = false,
    Object? strict = false,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.lalr_analysis",
        "LALR_Analyzer",
        LALR_Analyzer.from,
        <Object?>[
          parser_conf,
          debug,
          strict,
        ],
        <String, Object?>{},
      );

  LALR_Analyzer.from(super.pythonClass) : super.from();

  /// ## compute_includes_lookback
  ///
  /// ### python source
  /// ```py
  /// def compute_includes_lookback(self):
  ///         for nt in self.nonterminal_transitions:
  ///             state, nonterminal = nt
  ///             includes = []
  ///             lookback = self.lookback[nt]
  ///             for rp in state.closure:
  ///                 if rp.rule.origin != nonterminal:
  ///                     continue
  ///                 # traverse the states for rp(.rule)
  ///                 state2 = state
  ///                 for i in range(rp.index, len(rp.rule.expansion)):
  ///                     s = rp.rule.expansion[i]
  ///                     nt2 = (state2, s)
  ///                     state2 = state2.transitions[s]
  ///                     if nt2 not in self.reads:
  ///                         continue
  ///                     for j in range(i + 1, len(rp.rule.expansion)):
  ///                         if rp.rule.expansion[j] not in self.NULLABLE:
  ///                             break
  ///                     else:
  ///                         includes.append(nt2)
  ///                 # state2 is at the final state for rp.rule
  ///                 if rp.index == 0:
  ///                     for rp2 in state2.closure:
  ///                         if (rp2.rule == rp.rule) and rp2.is_satisfied:
  ///                             lookback.add((state2, rp2.rule))
  ///             for nt2 in includes:
  ///                 self.includes[nt2].add(nt)
  /// ```
  Object? compute_includes_lookback() =>
      getFunction("compute_includes_lookback").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## compute_lalr
  ///
  /// ### python source
  /// ```py
  /// def compute_lalr(self):
  ///         self.compute_lr0_states()
  ///         self.compute_reads_relations()
  ///         self.compute_includes_lookback()
  ///         self.compute_lookaheads()
  ///         self.compute_lalr1_states()
  /// ```
  Object? compute_lalr() => getFunction("compute_lalr").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## compute_lalr1_states
  ///
  /// ### python source
  /// ```py
  /// def compute_lalr1_states(self):
  ///         m = {}
  ///         reduce_reduce = []
  ///         for state in self.lr0_states:
  ///             actions = {la: (Shift, next_state.closure) for la, next_state in state.transitions.items()}
  ///             for la, rules in state.lookaheads.items():
  ///                 if len(rules) > 1:
  ///                     # Try to resolve conflict based on priority
  ///                     p = [(r.options.priority or 0, r) for r in rules]
  ///                     p.sort(key=lambda r: r[0], reverse=True)
  ///                     best, second_best = p[:2]
  ///                     if best[0] > second_best[0]:
  ///                         rules = [best[1]]
  ///                     else:
  ///                         reduce_reduce.append((state, la, rules))
  ///                         continue
  ///
  ///                 rule ,= rules
  ///                 if la in actions:
  ///                     if self.strict:
  ///                         raise GrammarError(f"Shift/Reduce conflict for terminal {la.name}. [strict-mode]\n ")
  ///                     elif self.debug:
  ///                         logger.warning('Shift/Reduce conflict for terminal %s: (resolving as shift)', la.name)
  ///                         logger.warning(' * %s', rule)
  ///                     else:
  ///                         logger.debug('Shift/Reduce conflict for terminal %s: (resolving as shift)', la.name)
  ///                         logger.debug(' * %s', rule)
  ///                 else:
  ///                     actions[la] = (Reduce, list(rules)[0])
  ///             m[state] = { k.name: v for k, v in actions.items() }
  ///
  ///         if reduce_reduce:
  ///             msgs = []
  ///             for state, la, rules in reduce_reduce:
  ///                 msg = 'Reduce/Reduce collision in %s between the following rules: %s' % (la, ''.join([ '\n\t- ' + str(r) for r in rules ]))
  ///                 if self.debug:
  ///                     msg += '\n    collision occurred in state: {%s\n    }' % ''.join(['\n\t' + str(x) for x in state.closure])
  ///                 msgs.append(msg)
  ///             raise GrammarError('\n\n'.join(msgs))
  ///
  ///         states = { k.closure: v for k, v in m.items() }
  ///
  ///         # compute end states
  ///         end_states = {}
  ///         for state in states:
  ///             for rp in state:
  ///                 for start in self.lr0_start_states:
  ///                     if rp.rule.origin.name == ('$root_' + start) and rp.is_satisfied:
  ///                         assert(start not in end_states)
  ///                         end_states[start] = state
  ///
  ///         _parse_table = ParseTable(states, { start: state.closure for start, state in self.lr0_start_states.items() }, end_states)
  ///
  ///         if self.debug:
  ///             self.parse_table = _parse_table
  ///         else:
  ///             self.parse_table = IntParseTable.from_ParseTable(_parse_table)
  /// ```
  Object? compute_lalr1_states() => getFunction("compute_lalr1_states").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## compute_lookaheads
  ///
  /// ### python source
  /// ```py
  /// def compute_lookaheads(self):
  ///         read_sets = digraph(self.nonterminal_transitions, self.reads, self.directly_reads)
  ///         follow_sets = digraph(self.nonterminal_transitions, self.includes, read_sets)
  ///
  ///         for nt, lookbacks in self.lookback.items():
  ///             for state, rule in lookbacks:
  ///                 for s in follow_sets[nt]:
  ///                     state.lookaheads[s].add(rule)
  /// ```
  Object? compute_lookaheads() => getFunction("compute_lookaheads").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## compute_lr0_states
  ///
  /// ### python source
  /// ```py
  /// def compute_lr0_states(self):
  ///         self.lr0_states = set()
  ///         # map of kernels to LR0ItemSets
  ///         cache = {}
  ///
  ///         def step(state):
  ///             _, unsat = classify_bool(state.closure, lambda rp: rp.is_satisfied)
  ///
  ///             d = classify(unsat, lambda rp: rp.next)
  ///             for sym, rps in d.items():
  ///                 kernel = fzset({rp.advance(sym) for rp in rps})
  ///                 new_state = cache.get(kernel, None)
  ///                 if new_state is None:
  ///                     closure = set(kernel)
  ///                     for rp in kernel:
  ///                         if not rp.is_satisfied and not rp.next.is_term:
  ///                             closure |= self.expand_rule(rp.next, self.lr0_rules_by_origin)
  ///                     new_state = LR0ItemSet(kernel, closure)
  ///                     cache[kernel] = new_state
  ///
  ///                 state.transitions[sym] = new_state
  ///                 yield new_state
  ///
  ///             self.lr0_states.add(state)
  ///
  ///         for _ in bfs(self.lr0_start_states.values(), step):
  ///             pass
  /// ```
  Object? compute_lr0_states() => getFunction("compute_lr0_states").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## compute_reads_relations
  ///
  /// ### python source
  /// ```py
  /// def compute_reads_relations(self):
  ///         # handle start state
  ///         for root in self.lr0_start_states.values():
  ///             assert(len(root.kernel) == 1)
  ///             for rp in root.kernel:
  ///                 assert(rp.index == 0)
  ///                 self.directly_reads[(root, rp.next)] = set([ Terminal('$END') ])
  ///
  ///         for state in self.lr0_states:
  ///             seen = set()
  ///             for rp in state.closure:
  ///                 if rp.is_satisfied:
  ///                     continue
  ///                 s = rp.next
  ///                 # if s is a not a nonterminal
  ///                 if s not in self.lr0_rules_by_origin:
  ///                     continue
  ///                 if s in seen:
  ///                     continue
  ///                 seen.add(s)
  ///                 nt = (state, s)
  ///                 self.nonterminal_transitions.append(nt)
  ///                 dr = self.directly_reads[nt]
  ///                 r = self.reads[nt]
  ///                 next_state = state.transitions[s]
  ///                 for rp2 in next_state.closure:
  ///                     if rp2.is_satisfied:
  ///                         continue
  ///                     s2 = rp2.next
  ///                     # if s2 is a terminal
  ///                     if s2 not in self.lr0_rules_by_origin:
  ///                         dr.add(s2)
  ///                     if s2 in self.NULLABLE:
  ///                         r.add((next_state, s2))
  /// ```
  Object? compute_reads_relations() =>
      getFunction("compute_reads_relations").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

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

  /// ## nonterminal_transitions (getter)
  Object? get nonterminal_transitions =>
      getAttribute("nonterminal_transitions");

  /// ## nonterminal_transitions (setter)
  set nonterminal_transitions(Object? nonterminal_transitions) =>
      setAttribute("nonterminal_transitions", nonterminal_transitions);

  /// ## directly_reads (getter)
  Object? get directly_reads => getAttribute("directly_reads");

  /// ## directly_reads (setter)
  set directly_reads(Object? directly_reads) =>
      setAttribute("directly_reads", directly_reads);

  /// ## reads (getter)
  Object? get reads => getAttribute("reads");

  /// ## reads (setter)
  set reads(Object? reads) => setAttribute("reads", reads);

  /// ## includes (getter)
  Object? get includes => getAttribute("includes");

  /// ## includes (setter)
  set includes(Object? includes) => setAttribute("includes", includes);

  /// ## lookback (getter)
  Object? get lookback => getAttribute("lookback");

  /// ## lookback (setter)
  set lookback(Object? lookback) => setAttribute("lookback", lookback);
}

/// ## ParseTable
///
/// ### python source
/// ```py
/// class ParseTable:
///     def __init__(self, states, start_states, end_states):
///         self.states = states
///         self.start_states = start_states
///         self.end_states = end_states
///
///     def serialize(self, memo):
///         tokens = Enumerator()
///
///         states = {
///             state: {tokens.get(token): ((1, arg.serialize(memo)) if action is Reduce else (0, arg))
///                     for token, (action, arg) in actions.items()}
///             for state, actions in self.states.items()
///         }
///
///         return {
///             'tokens': tokens.reversed(),
///             'states': states,
///             'start_states': self.start_states,
///             'end_states': self.end_states,
///         }
///
///     @classmethod
///     def deserialize(cls, data, memo):
///         tokens = data['tokens']
///         states = {
///             state: {tokens[token]: ((Reduce, Rule.deserialize(arg, memo)) if action==1 else (Shift, arg))
///                     for token, (action, arg) in actions.items()}
///             for state, actions in data['states'].items()
///         }
///         return cls(states, data['start_states'], data['end_states'])
/// ```
final class ParseTable extends PythonClass {
  factory ParseTable({
    required Object? states,
    required Object? start_states,
    required Object? end_states,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.lalr_analysis",
        "ParseTable",
        ParseTable.from,
        <Object?>[
          states,
          start_states,
          end_states,
        ],
        <String, Object?>{},
      );

  ParseTable.from(super.pythonClass) : super.from();

  /// ## serialize
  ///
  /// ### python source
  /// ```py
  /// def serialize(self, memo):
  ///         tokens = Enumerator()
  ///
  ///         states = {
  ///             state: {tokens.get(token): ((1, arg.serialize(memo)) if action is Reduce else (0, arg))
  ///                     for token, (action, arg) in actions.items()}
  ///             for state, actions in self.states.items()
  ///         }
  ///
  ///         return {
  ///             'tokens': tokens.reversed(),
  ///             'states': states,
  ///             'start_states': self.start_states,
  ///             'end_states': self.end_states,
  ///         }
  /// ```
  Object? serialize({
    required Object? memo,
  }) =>
      getFunction("serialize").call(
        <Object?>[
          memo,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## deserialize (getter)
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## states (getter)
  Object? get states => getAttribute("states");

  /// ## states (setter)
  set states(Object? states) => setAttribute("states", states);

  /// ## start_states (getter)
  Object? get start_states => getAttribute("start_states");

  /// ## start_states (setter)
  set start_states(Object? start_states) =>
      setAttribute("start_states", start_states);

  /// ## end_states (getter)
  Object? get end_states => getAttribute("end_states");

  /// ## end_states (setter)
  set end_states(Object? end_states) => setAttribute("end_states", end_states);
}

/// ## ImmutableInteractiveParser
///
/// ### python docstring
///
/// Same as ``InteractiveParser``, but operations create a new instance instead
/// of changing it in-place.
///
/// ### python source
/// ```py
/// class ImmutableInteractiveParser(InteractiveParser):
///     """Same as ``InteractiveParser``, but operations create a new instance instead
///     of changing it in-place.
///     """
///
///     result = None
///
///     def __hash__(self):
///         return hash((self.parser_state, self.lexer_thread))
///
///     def feed_token(self, token):
///         c = copy(self)
///         c.result = InteractiveParser.feed_token(c, token)
///         return c
///
///     def exhaust_lexer(self):
///         """Try to feed the rest of the lexer state into the parser.
///
///         Note that this returns a new ImmutableInteractiveParser and does not feed an '$END' Token"""
///         cursor = self.as_mutable()
///         cursor.exhaust_lexer()
///         return cursor.as_immutable()
///
///     def as_mutable(self):
///         """Convert to an ``InteractiveParser``."""
///         p = copy(self)
///         return InteractiveParser(p.parser, p.parser_state, p.lexer_thread)
/// ```
final class ImmutableInteractiveParser extends PythonClass {
  factory ImmutableInteractiveParser({
    required Object? parser,
    required Object? parser_state,
    required LexerThread lexer_thread,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.lalr_interactive_parser",
        "ImmutableInteractiveParser",
        ImmutableInteractiveParser.from,
        <Object?>[
          parser,
          parser_state,
          lexer_thread,
        ],
        <String, Object?>{},
      );

  ImmutableInteractiveParser.from(super.pythonClass) : super.from();

  /// ## accepts
  ///
  /// ### python docstring
  ///
  /// Returns the set of possible tokens that will advance the parser into a new valid state.
  ///
  /// ### python source
  /// ```py
  /// def accepts(self):
  ///         """Returns the set of possible tokens that will advance the parser into a new valid state."""
  ///         accepts = set()
  ///         for t in self.choices():
  ///             if t.isupper(): # is terminal?
  ///                 new_cursor = copy(self)
  ///                 try:
  ///                     new_cursor.feed_token(self.lexer_thread._Token(t, ''))
  ///                 except UnexpectedToken:
  ///                     pass
  ///                 else:
  ///                     accepts.add(t)
  ///         return accepts
  /// ```
  Object? accepts() => getFunction("accepts").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## as_immutable
  ///
  /// ### python docstring
  ///
  /// Convert to an ``ImmutableInteractiveParser``.
  ///
  /// ### python source
  /// ```py
  /// def as_immutable(self):
  ///         """Convert to an ``ImmutableInteractiveParser``."""
  ///         p = copy(self)
  ///         return ImmutableInteractiveParser(p.parser, p.parser_state, p.lexer_thread)
  /// ```
  Object? as_immutable() => getFunction("as_immutable").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## as_mutable
  ///
  /// ### python docstring
  ///
  /// Convert to an ``InteractiveParser``.
  ///
  /// ### python source
  /// ```py
  /// def as_mutable(self):
  ///         """Convert to an ``InteractiveParser``."""
  ///         p = copy(self)
  ///         return InteractiveParser(p.parser, p.parser_state, p.lexer_thread)
  /// ```
  Object? as_mutable() => getFunction("as_mutable").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## choices
  ///
  /// ### python docstring
  ///
  /// Returns a dictionary of token types, matched to their action in the parser.
  ///
  /// Only returns token types that are accepted by the current state.
  ///
  /// Updated by ``feed_token()``.
  ///
  /// ### python source
  /// ```py
  /// def choices(self):
  ///         """Returns a dictionary of token types, matched to their action in the parser.
  ///
  ///         Only returns token types that are accepted by the current state.
  ///
  ///         Updated by ``feed_token()``.
  ///         """
  ///         return self.parser_state.parse_conf.parse_table.states[self.parser_state.position]
  /// ```
  Object? choices() => getFunction("choices").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## copy
  ///
  /// ### python source
  /// ```py
  /// def copy(self):
  ///         return copy(self)
  /// ```
  Object? copy() => getFunction("copy").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## exhaust_lexer
  ///
  /// ### python docstring
  ///
  /// Try to feed the rest of the lexer state into the parser.
  ///
  /// Note that this returns a new ImmutableInteractiveParser and does not feed an '$END' Token
  ///
  /// ### python source
  /// ```py
  /// def exhaust_lexer(self):
  ///         """Try to feed the rest of the lexer state into the parser.
  ///
  ///         Note that this returns a new ImmutableInteractiveParser and does not feed an '$END' Token"""
  ///         cursor = self.as_mutable()
  ///         cursor.exhaust_lexer()
  ///         return cursor.as_immutable()
  /// ```
  Object? exhaust_lexer() => getFunction("exhaust_lexer").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## feed_eof
  ///
  /// ### python docstring
  ///
  /// Feed a '$END' Token. Borrows from 'last_token' if given.
  ///
  /// ### python source
  /// ```py
  /// def feed_eof(self, last_token=None):
  ///         """Feed a '$END' Token. Borrows from 'last_token' if given."""
  ///         eof = Token.new_borrow_pos('$END', '', last_token) if last_token is not None else self.lexer_thread._Token('$END', '', 0, 1, 1)
  ///         return self.feed_token(eof)
  /// ```
  Object? feed_eof({
    Object? last_token,
  }) =>
      getFunction("feed_eof").call(
        <Object?>[
          last_token,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## feed_token
  ///
  /// ### python docstring
  ///
  /// Feed the parser with a token, and advance it to the next state, as if it received it from the lexer.
  ///
  /// Note that ``token`` has to be an instance of ``Token``.
  ///
  /// ### python source
  /// ```py
  /// def feed_token(self, token):
  ///         c = copy(self)
  ///         c.result = InteractiveParser.feed_token(c, token)
  ///         return c
  /// ```
  Object? feed_token({
    required Object? token,
  }) =>
      getFunction("feed_token").call(
        <Object?>[
          token,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## iter_parse
  ///
  /// ### python docstring
  ///
  /// Step through the different stages of the parse, by reading tokens from the lexer
  /// and feeding them to the parser, one per iteration.
  ///
  /// Returns an iterator of the tokens it encounters.
  ///
  /// When the parse is over, the resulting tree can be found in ``InteractiveParser.result``.
  ///
  /// ### python source
  /// ```py
  /// def iter_parse(self) -> Iterator[Token]:
  ///         """Step through the different stages of the parse, by reading tokens from the lexer
  ///         and feeding them to the parser, one per iteration.
  ///
  ///         Returns an iterator of the tokens it encounters.
  ///
  ///         When the parse is over, the resulting tree can be found in ``InteractiveParser.result``.
  ///         """
  ///         for token in self.lexer_thread.lex(self.parser_state):
  ///             yield token
  ///             self.result = self.feed_token(token)
  /// ```
  Iterator<Token> iter_parse() => TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("iter_parse").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ),
      )
          .transform((e) => Token.from(
                e,
              ))
          .cast<Token>();

  /// ## pretty
  ///
  /// ### python docstring
  ///
  /// Print the output of ``choices()`` in a way that's easier to read.
  ///
  /// ### python source
  /// ```py
  /// def pretty(self):
  ///         """Print the output of ``choices()`` in a way that's easier to read."""
  ///         out = ["Parser choices:"]
  ///         for k, v in self.choices().items():
  ///             out.append('\t- %s -> %r' % (k, v))
  ///         out.append('stack size: %s' % len(self.parser_state.state_stack))
  ///         return '\n'.join(out)
  /// ```
  Object? pretty() => getFunction("pretty").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## resume_parse
  ///
  /// ### python docstring
  ///
  /// Resume automated parsing from the current state.
  ///
  /// ### python source
  /// ```py
  /// def resume_parse(self):
  ///         """Resume automated parsing from the current state.
  ///         """
  ///         return self.parser.parse_from_state(self.parser_state, last_token=self.lexer_thread.state.last_token)
  /// ```
  Object? resume_parse() => getFunction("resume_parse").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## lexer_state (getter)
  ///
  /// ### python docstring
  ///
  /// Same as ``InteractiveParser``, but operations create a new instance instead
  /// of changing it in-place.
  Object? get lexer_state => getAttribute("lexer_state");

  /// ## lexer_state (setter)
  ///
  /// ### python docstring
  ///
  /// Same as ``InteractiveParser``, but operations create a new instance instead
  /// of changing it in-place.
  set lexer_state(Object? lexer_state) =>
      setAttribute("lexer_state", lexer_state);

  /// ## result (getter)
  ///
  /// ### python docstring
  ///
  /// Same as ``InteractiveParser``, but operations create a new instance instead
  /// of changing it in-place.
  Object? get result => getAttribute("result");

  /// ## result (setter)
  ///
  /// ### python docstring
  ///
  /// Same as ``InteractiveParser``, but operations create a new instance instead
  /// of changing it in-place.
  set result(Object? result) => setAttribute("result", result);

  /// ## parser (getter)
  ///
  /// ### python docstring
  ///
  /// Same as ``InteractiveParser``, but operations create a new instance instead
  /// of changing it in-place.
  Object? get parser => getAttribute("parser");

  /// ## parser (setter)
  ///
  /// ### python docstring
  ///
  /// Same as ``InteractiveParser``, but operations create a new instance instead
  /// of changing it in-place.
  set parser(Object? parser) => setAttribute("parser", parser);

  /// ## parser_state (getter)
  ///
  /// ### python docstring
  ///
  /// Same as ``InteractiveParser``, but operations create a new instance instead
  /// of changing it in-place.
  Object? get parser_state => getAttribute("parser_state");

  /// ## parser_state (setter)
  ///
  /// ### python docstring
  ///
  /// Same as ``InteractiveParser``, but operations create a new instance instead
  /// of changing it in-place.
  set parser_state(Object? parser_state) =>
      setAttribute("parser_state", parser_state);

  /// ## lexer_thread (getter)
  ///
  /// ### python docstring
  ///
  /// Same as ``InteractiveParser``, but operations create a new instance instead
  /// of changing it in-place.
  Object? get lexer_thread => getAttribute("lexer_thread");

  /// ## lexer_thread (setter)
  ///
  /// ### python docstring
  ///
  /// Same as ``InteractiveParser``, but operations create a new instance instead
  /// of changing it in-place.
  set lexer_thread(Object? lexer_thread) =>
      setAttribute("lexer_thread", lexer_thread);
}

/// ## InteractiveParser
///
/// ### python docstring
///
/// InteractiveParser gives you advanced control over parsing and error handling when parsing with LALR.
///
/// For a simpler interface, see the ``on_error`` argument to ``Lark.parse()``.
///
/// ### python source
/// ```py
/// class InteractiveParser:
///     """InteractiveParser gives you advanced control over parsing and error handling when parsing with LALR.
///
///     For a simpler interface, see the ``on_error`` argument to ``Lark.parse()``.
///     """
///     def __init__(self, parser, parser_state, lexer_thread: LexerThread):
///         self.parser = parser
///         self.parser_state = parser_state
///         self.lexer_thread = lexer_thread
///         self.result = None
///
///     @property
///     def lexer_state(self) -> LexerThread:
///         warnings.warn("lexer_state will be removed in subsequent releases. Use lexer_thread instead.", DeprecationWarning)
///         return self.lexer_thread
///
///     def feed_token(self, token: Token):
///         """Feed the parser with a token, and advance it to the next state, as if it received it from the lexer.
///
///         Note that ``token`` has to be an instance of ``Token``.
///         """
///         return self.parser_state.feed_token(token, token.type == '$END')
///
///     def iter_parse(self) -> Iterator[Token]:
///         """Step through the different stages of the parse, by reading tokens from the lexer
///         and feeding them to the parser, one per iteration.
///
///         Returns an iterator of the tokens it encounters.
///
///         When the parse is over, the resulting tree can be found in ``InteractiveParser.result``.
///         """
///         for token in self.lexer_thread.lex(self.parser_state):
///             yield token
///             self.result = self.feed_token(token)
///
///     def exhaust_lexer(self) -> List[Token]:
///         """Try to feed the rest of the lexer state into the interactive parser.
///
///         Note that this modifies the instance in place and does not feed an '$END' Token
///         """
///         return list(self.iter_parse())
///
///
///     def feed_eof(self, last_token=None):
///         """Feed a '$END' Token. Borrows from 'last_token' if given."""
///         eof = Token.new_borrow_pos('$END', '', last_token) if last_token is not None else self.lexer_thread._Token('$END', '', 0, 1, 1)
///         return self.feed_token(eof)
///
///
///     def __copy__(self):
///         """Create a new interactive parser with a separate state.
///
///         Calls to feed_token() won't affect the old instance, and vice-versa.
///         """
///         return type(self)(
///             self.parser,
///             copy(self.parser_state),
///             copy(self.lexer_thread),
///         )
///
///     def copy(self):
///         return copy(self)
///
///     def __eq__(self, other):
///         if not isinstance(other, InteractiveParser):
///             return False
///
///         return self.parser_state == other.parser_state and self.lexer_thread == other.lexer_thread
///
///     def as_immutable(self):
///         """Convert to an ``ImmutableInteractiveParser``."""
///         p = copy(self)
///         return ImmutableInteractiveParser(p.parser, p.parser_state, p.lexer_thread)
///
///     def pretty(self):
///         """Print the output of ``choices()`` in a way that's easier to read."""
///         out = ["Parser choices:"]
///         for k, v in self.choices().items():
///             out.append('\t- %s -> %r' % (k, v))
///         out.append('stack size: %s' % len(self.parser_state.state_stack))
///         return '\n'.join(out)
///
///     def choices(self):
///         """Returns a dictionary of token types, matched to their action in the parser.
///
///         Only returns token types that are accepted by the current state.
///
///         Updated by ``feed_token()``.
///         """
///         return self.parser_state.parse_conf.parse_table.states[self.parser_state.position]
///
///     def accepts(self):
///         """Returns the set of possible tokens that will advance the parser into a new valid state."""
///         accepts = set()
///         for t in self.choices():
///             if t.isupper(): # is terminal?
///                 new_cursor = copy(self)
///                 try:
///                     new_cursor.feed_token(self.lexer_thread._Token(t, ''))
///                 except UnexpectedToken:
///                     pass
///                 else:
///                     accepts.add(t)
///         return accepts
///
///     def resume_parse(self):
///         """Resume automated parsing from the current state.
///         """
///         return self.parser.parse_from_state(self.parser_state, last_token=self.lexer_thread.state.last_token)
/// ```
final class InteractiveParser extends PythonClass {
  factory InteractiveParser({
    required Object? parser,
    required Object? parser_state,
    required LexerThread lexer_thread,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.lalr_interactive_parser",
        "InteractiveParser",
        InteractiveParser.from,
        <Object?>[
          parser,
          parser_state,
          lexer_thread,
        ],
        <String, Object?>{},
      );

  InteractiveParser.from(super.pythonClass) : super.from();

  /// ## accepts
  ///
  /// ### python docstring
  ///
  /// Returns the set of possible tokens that will advance the parser into a new valid state.
  ///
  /// ### python source
  /// ```py
  /// def accepts(self):
  ///         """Returns the set of possible tokens that will advance the parser into a new valid state."""
  ///         accepts = set()
  ///         for t in self.choices():
  ///             if t.isupper(): # is terminal?
  ///                 new_cursor = copy(self)
  ///                 try:
  ///                     new_cursor.feed_token(self.lexer_thread._Token(t, ''))
  ///                 except UnexpectedToken:
  ///                     pass
  ///                 else:
  ///                     accepts.add(t)
  ///         return accepts
  /// ```
  Object? accepts() => getFunction("accepts").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## as_immutable
  ///
  /// ### python docstring
  ///
  /// Convert to an ``ImmutableInteractiveParser``.
  ///
  /// ### python source
  /// ```py
  /// def as_immutable(self):
  ///         """Convert to an ``ImmutableInteractiveParser``."""
  ///         p = copy(self)
  ///         return ImmutableInteractiveParser(p.parser, p.parser_state, p.lexer_thread)
  /// ```
  Object? as_immutable() => getFunction("as_immutable").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## choices
  ///
  /// ### python docstring
  ///
  /// Returns a dictionary of token types, matched to their action in the parser.
  ///
  /// Only returns token types that are accepted by the current state.
  ///
  /// Updated by ``feed_token()``.
  ///
  /// ### python source
  /// ```py
  /// def choices(self):
  ///         """Returns a dictionary of token types, matched to their action in the parser.
  ///
  ///         Only returns token types that are accepted by the current state.
  ///
  ///         Updated by ``feed_token()``.
  ///         """
  ///         return self.parser_state.parse_conf.parse_table.states[self.parser_state.position]
  /// ```
  Object? choices() => getFunction("choices").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## copy
  ///
  /// ### python source
  /// ```py
  /// def copy(self):
  ///         return copy(self)
  /// ```
  Object? copy() => getFunction("copy").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## exhaust_lexer
  ///
  /// ### python docstring
  ///
  /// Try to feed the rest of the lexer state into the interactive parser.
  ///
  /// Note that this modifies the instance in place and does not feed an '$END' Token
  ///
  /// ### python source
  /// ```py
  /// def exhaust_lexer(self) -> List[Token]:
  ///         """Try to feed the rest of the lexer state into the interactive parser.
  ///
  ///         Note that this modifies the instance in place and does not feed an '$END' Token
  ///         """
  ///         return list(self.iter_parse())
  /// ```
  Object? exhaust_lexer() => getFunction("exhaust_lexer").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## feed_eof
  ///
  /// ### python docstring
  ///
  /// Feed a '$END' Token. Borrows from 'last_token' if given.
  ///
  /// ### python source
  /// ```py
  /// def feed_eof(self, last_token=None):
  ///         """Feed a '$END' Token. Borrows from 'last_token' if given."""
  ///         eof = Token.new_borrow_pos('$END', '', last_token) if last_token is not None else self.lexer_thread._Token('$END', '', 0, 1, 1)
  ///         return self.feed_token(eof)
  /// ```
  Object? feed_eof({
    Object? last_token,
  }) =>
      getFunction("feed_eof").call(
        <Object?>[
          last_token,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## feed_token
  ///
  /// ### python docstring
  ///
  /// Feed the parser with a token, and advance it to the next state, as if it received it from the lexer.
  ///
  /// Note that ``token`` has to be an instance of ``Token``.
  ///
  /// ### python source
  /// ```py
  /// def feed_token(self, token: Token):
  ///         """Feed the parser with a token, and advance it to the next state, as if it received it from the lexer.
  ///
  ///         Note that ``token`` has to be an instance of ``Token``.
  ///         """
  ///         return self.parser_state.feed_token(token, token.type == '$END')
  /// ```
  Object? feed_token({
    required Token token,
  }) =>
      getFunction("feed_token").call(
        <Object?>[
          token,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## iter_parse
  ///
  /// ### python docstring
  ///
  /// Step through the different stages of the parse, by reading tokens from the lexer
  /// and feeding them to the parser, one per iteration.
  ///
  /// Returns an iterator of the tokens it encounters.
  ///
  /// When the parse is over, the resulting tree can be found in ``InteractiveParser.result``.
  ///
  /// ### python source
  /// ```py
  /// def iter_parse(self) -> Iterator[Token]:
  ///         """Step through the different stages of the parse, by reading tokens from the lexer
  ///         and feeding them to the parser, one per iteration.
  ///
  ///         Returns an iterator of the tokens it encounters.
  ///
  ///         When the parse is over, the resulting tree can be found in ``InteractiveParser.result``.
  ///         """
  ///         for token in self.lexer_thread.lex(self.parser_state):
  ///             yield token
  ///             self.result = self.feed_token(token)
  /// ```
  Iterator<Token> iter_parse() => TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("iter_parse").call(
            <Object?>[],
            kwargs: <String, Object?>{},
          ),
        ),
      )
          .transform((e) => Token.from(
                e,
              ))
          .cast<Token>();

  /// ## pretty
  ///
  /// ### python docstring
  ///
  /// Print the output of ``choices()`` in a way that's easier to read.
  ///
  /// ### python source
  /// ```py
  /// def pretty(self):
  ///         """Print the output of ``choices()`` in a way that's easier to read."""
  ///         out = ["Parser choices:"]
  ///         for k, v in self.choices().items():
  ///             out.append('\t- %s -> %r' % (k, v))
  ///         out.append('stack size: %s' % len(self.parser_state.state_stack))
  ///         return '\n'.join(out)
  /// ```
  Object? pretty() => getFunction("pretty").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## resume_parse
  ///
  /// ### python docstring
  ///
  /// Resume automated parsing from the current state.
  ///
  /// ### python source
  /// ```py
  /// def resume_parse(self):
  ///         """Resume automated parsing from the current state.
  ///         """
  ///         return self.parser.parse_from_state(self.parser_state, last_token=self.lexer_thread.state.last_token)
  /// ```
  Object? resume_parse() => getFunction("resume_parse").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## lexer_state (getter)
  ///
  /// ### python docstring
  ///
  /// InteractiveParser gives you advanced control over parsing and error handling when parsing with LALR.
  ///
  /// For a simpler interface, see the ``on_error`` argument to ``Lark.parse()``.
  Object? get lexer_state => getAttribute("lexer_state");

  /// ## lexer_state (setter)
  ///
  /// ### python docstring
  ///
  /// InteractiveParser gives you advanced control over parsing and error handling when parsing with LALR.
  ///
  /// For a simpler interface, see the ``on_error`` argument to ``Lark.parse()``.
  set lexer_state(Object? lexer_state) =>
      setAttribute("lexer_state", lexer_state);

  /// ## parser (getter)
  ///
  /// ### python docstring
  ///
  /// InteractiveParser gives you advanced control over parsing and error handling when parsing with LALR.
  ///
  /// For a simpler interface, see the ``on_error`` argument to ``Lark.parse()``.
  Object? get parser => getAttribute("parser");

  /// ## parser (setter)
  ///
  /// ### python docstring
  ///
  /// InteractiveParser gives you advanced control over parsing and error handling when parsing with LALR.
  ///
  /// For a simpler interface, see the ``on_error`` argument to ``Lark.parse()``.
  set parser(Object? parser) => setAttribute("parser", parser);

  /// ## parser_state (getter)
  ///
  /// ### python docstring
  ///
  /// InteractiveParser gives you advanced control over parsing and error handling when parsing with LALR.
  ///
  /// For a simpler interface, see the ``on_error`` argument to ``Lark.parse()``.
  Object? get parser_state => getAttribute("parser_state");

  /// ## parser_state (setter)
  ///
  /// ### python docstring
  ///
  /// InteractiveParser gives you advanced control over parsing and error handling when parsing with LALR.
  ///
  /// For a simpler interface, see the ``on_error`` argument to ``Lark.parse()``.
  set parser_state(Object? parser_state) =>
      setAttribute("parser_state", parser_state);

  /// ## lexer_thread (getter)
  ///
  /// ### python docstring
  ///
  /// InteractiveParser gives you advanced control over parsing and error handling when parsing with LALR.
  ///
  /// For a simpler interface, see the ``on_error`` argument to ``Lark.parse()``.
  Object? get lexer_thread => getAttribute("lexer_thread");

  /// ## lexer_thread (setter)
  ///
  /// ### python docstring
  ///
  /// InteractiveParser gives you advanced control over parsing and error handling when parsing with LALR.
  ///
  /// For a simpler interface, see the ``on_error`` argument to ``Lark.parse()``.
  set lexer_thread(Object? lexer_thread) =>
      setAttribute("lexer_thread", lexer_thread);

  /// ## result (getter)
  ///
  /// ### python docstring
  ///
  /// InteractiveParser gives you advanced control over parsing and error handling when parsing with LALR.
  ///
  /// For a simpler interface, see the ``on_error`` argument to ``Lark.parse()``.
  Object? get result => getAttribute("result");

  /// ## result (setter)
  ///
  /// ### python docstring
  ///
  /// InteractiveParser gives you advanced control over parsing and error handling when parsing with LALR.
  ///
  /// For a simpler interface, see the ``on_error`` argument to ``Lark.parse()``.
  set result(Object? result) => setAttribute("result", result);
}

/// ## LexerThread
///
/// ### python docstring
///
/// A thread that ties a lexer instance and a lexer state, to be used by the parser
///
/// ### python source
/// ```py
/// class LexerThread:
///     """A thread that ties a lexer instance and a lexer state, to be used by the parser
///     """
///
///     def __init__(self, lexer: 'Lexer', lexer_state: LexerState):
///         self.lexer = lexer
///         self.state = lexer_state
///
///     @classmethod
///     def from_text(cls, lexer: 'Lexer', text: str):
///         return cls(lexer, LexerState(text))
///
///     def lex(self, parser_state):
///         return self.lexer.lex(self.state, parser_state)
///
///     def __copy__(self):
///         return type(self)(self.lexer, copy(self.state))
///
///     _Token = Token
/// ```
final class LexerThread extends PythonClass {
  factory LexerThread({
    required Object? lexer,
    required Object? lexer_state,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lexer",
        "LexerThread",
        LexerThread.from,
        <Object?>[
          lexer,
          lexer_state,
        ],
        <String, Object?>{},
      );

  LexerThread.from(super.pythonClass) : super.from();

  /// ## lex
  ///
  /// ### python source
  /// ```py
  /// def lex(self, parser_state):
  ///         return self.lexer.lex(self.state, parser_state)
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

  /// ## from_text (getter)
  ///
  /// ### python docstring
  ///
  /// A thread that ties a lexer instance and a lexer state, to be used by the parser
  Object? get from_text => getAttribute("from_text");

  /// ## from_text (setter)
  ///
  /// ### python docstring
  ///
  /// A thread that ties a lexer instance and a lexer state, to be used by the parser
  set from_text(Object? from_text) => setAttribute("from_text", from_text);

  /// ## lexer (getter)
  ///
  /// ### python docstring
  ///
  /// A thread that ties a lexer instance and a lexer state, to be used by the parser
  Object? get lexer => getAttribute("lexer");

  /// ## lexer (setter)
  ///
  /// ### python docstring
  ///
  /// A thread that ties a lexer instance and a lexer state, to be used by the parser
  set lexer(Object? lexer) => setAttribute("lexer", lexer);

  /// ## state (getter)
  ///
  /// ### python docstring
  ///
  /// A thread that ties a lexer instance and a lexer state, to be used by the parser
  Object? get state => getAttribute("state");

  /// ## state (setter)
  ///
  /// ### python docstring
  ///
  /// A thread that ties a lexer instance and a lexer state, to be used by the parser
  set state(Object? state) => setAttribute("state", state);
}

/// ## LALR_Parser
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
/// class LALR_Parser(Serialize):
///     def __init__(self, parser_conf, debug=False, strict=False):
///         analysis = LALR_Analyzer(parser_conf, debug=debug, strict=strict)
///         analysis.compute_lalr()
///         callbacks = parser_conf.callbacks
///
///         self._parse_table = analysis.parse_table
///         self.parser_conf = parser_conf
///         self.parser = _Parser(analysis.parse_table, callbacks, debug)
///
///     @classmethod
///     def deserialize(cls, data, memo, callbacks, debug=False):
///         inst = cls.__new__(cls)
///         inst._parse_table = IntParseTable.deserialize(data, memo)
///         inst.parser = _Parser(inst._parse_table, callbacks, debug)
///         return inst
///
///     def serialize(self, memo: Any = None) -> Dict[str, Any]:
///         return self._parse_table.serialize(memo)
///
///     def parse_interactive(self, lexer, start):
///         return self.parser.parse(lexer, start, start_interactive=True)
///
///     def parse(self, lexer, start, on_error=None):
///         try:
///             return self.parser.parse(lexer, start)
///         except UnexpectedInput as e:
///             if on_error is None:
///                 raise
///
///             while True:
///                 if isinstance(e, UnexpectedCharacters):
///                     s = e.interactive_parser.lexer_thread.state
///                     p = s.line_ctr.char_pos
///
///                 if not on_error(e):
///                     raise e
///
///                 if isinstance(e, UnexpectedCharacters):
///                     # If user didn't change the character position, then we should
///                     if p == s.line_ctr.char_pos:
///                         s.line_ctr.feed(s.text[p:p+1])
///
///                 try:
///                     return e.interactive_parser.resume_parse()
///                 except UnexpectedToken as e2:
///                     if (isinstance(e, UnexpectedToken)
///                         and e.token.type == e2.token.type == '$END'
///                         and e.interactive_parser == e2.interactive_parser):
///                         # Prevent infinite loop
///                         raise e2
///                     e = e2
///                 except UnexpectedCharacters as e2:
///                     e = e2
/// ```
final class LALR_Parser extends PythonClass {
  factory LALR_Parser({
    required Object? parser_conf,
    Object? debug = false,
    Object? strict = false,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.lalr_parser",
        "LALR_Parser",
        LALR_Parser.from,
        <Object?>[
          parser_conf,
          debug,
          strict,
        ],
        <String, Object?>{},
      );

  LALR_Parser.from(super.pythonClass) : super.from();

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

  /// ## parse
  ///
  /// ### python source
  /// ```py
  /// def parse(self, lexer, start, on_error=None):
  ///         try:
  ///             return self.parser.parse(lexer, start)
  ///         except UnexpectedInput as e:
  ///             if on_error is None:
  ///                 raise
  ///
  ///             while True:
  ///                 if isinstance(e, UnexpectedCharacters):
  ///                     s = e.interactive_parser.lexer_thread.state
  ///                     p = s.line_ctr.char_pos
  ///
  ///                 if not on_error(e):
  ///                     raise e
  ///
  ///                 if isinstance(e, UnexpectedCharacters):
  ///                     # If user didn't change the character position, then we should
  ///                     if p == s.line_ctr.char_pos:
  ///                         s.line_ctr.feed(s.text[p:p+1])
  ///
  ///                 try:
  ///                     return e.interactive_parser.resume_parse()
  ///                 except UnexpectedToken as e2:
  ///                     if (isinstance(e, UnexpectedToken)
  ///                         and e.token.type == e2.token.type == '$END'
  ///                         and e.interactive_parser == e2.interactive_parser):
  ///                         # Prevent infinite loop
  ///                         raise e2
  ///                     e = e2
  ///                 except UnexpectedCharacters as e2:
  ///                     e = e2
  /// ```
  Object? parse({
    required Object? lexer,
    required Object? start,
    Object? on_error,
  }) =>
      getFunction("parse").call(
        <Object?>[
          lexer,
          start,
          on_error,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## parse_interactive
  ///
  /// ### python source
  /// ```py
  /// def parse_interactive(self, lexer, start):
  ///         return self.parser.parse(lexer, start, start_interactive=True)
  /// ```
  Object? parse_interactive({
    required Object? lexer,
    required Object? start,
  }) =>
      getFunction("parse_interactive").call(
        <Object?>[
          lexer,
          start,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## serialize
  ///
  /// ### python source
  /// ```py
  /// def serialize(self, memo: Any = None) -> Dict[str, Any]:
  ///         return self._parse_table.serialize(memo)
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

  /// ## parser_conf (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get parser_conf => getAttribute("parser_conf");

  /// ## parser_conf (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set parser_conf(Object? parser_conf) =>
      setAttribute("parser_conf", parser_conf);

  /// ## parser (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get parser => getAttribute("parser");

  /// ## parser (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set parser(Object? parser) => setAttribute("parser", parser);
}

/// ## ParseConf
///
/// ### python source
/// ```py
/// class ParseConf:
///     __slots__ = 'parse_table', 'callbacks', 'start', 'start_state', 'end_state', 'states'
///
///     def __init__(self, parse_table, callbacks, start):
///         self.parse_table = parse_table
///
///         self.start_state = self.parse_table.start_states[start]
///         self.end_state = self.parse_table.end_states[start]
///         self.states = self.parse_table.states
///
///         self.callbacks = callbacks
///         self.start = start
/// ```
final class ParseConf extends PythonClass {
  factory ParseConf({
    required Object? parse_table,
    required Object? callbacks,
    required Object? start,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.lalr_parser",
        "ParseConf",
        ParseConf.from,
        <Object?>[
          parse_table,
          callbacks,
          start,
        ],
        <String, Object?>{},
      );

  ParseConf.from(super.pythonClass) : super.from();

  /// ## callbacks (getter)
  Object? get callbacks => getAttribute("callbacks");

  /// ## callbacks (setter)
  set callbacks(Object? callbacks) => setAttribute("callbacks", callbacks);

  /// ## end_state (getter)
  Object? get end_state => getAttribute("end_state");

  /// ## end_state (setter)
  set end_state(Object? end_state) => setAttribute("end_state", end_state);

  /// ## parse_table (getter)
  Object? get parse_table => getAttribute("parse_table");

  /// ## parse_table (setter)
  set parse_table(Object? parse_table) =>
      setAttribute("parse_table", parse_table);

  /// ## start (getter)
  Object? get start => getAttribute("start");

  /// ## start (setter)
  set start(Object? start) => setAttribute("start", start);

  /// ## start_state (getter)
  Object? get start_state => getAttribute("start_state");

  /// ## start_state (setter)
  set start_state(Object? start_state) =>
      setAttribute("start_state", start_state);

  /// ## states (getter)
  Object? get states => getAttribute("states");

  /// ## states (setter)
  set states(Object? states) => setAttribute("states", states);
}

/// ## ParserState
///
/// ### python source
/// ```py
/// class ParserState:
///     __slots__ = 'parse_conf', 'lexer', 'state_stack', 'value_stack'
///
///     def __init__(self, parse_conf, lexer, state_stack=None, value_stack=None):
///         self.parse_conf = parse_conf
///         self.lexer = lexer
///         self.state_stack = state_stack or [self.parse_conf.start_state]
///         self.value_stack = value_stack or []
///
///     @property
///     def position(self):
///         return self.state_stack[-1]
///
///     # Necessary for match_examples() to work
///     def __eq__(self, other):
///         if not isinstance(other, ParserState):
///             return NotImplemented
///         return len(self.state_stack) == len(other.state_stack) and self.position == other.position
///
///     def __copy__(self):
///         return type(self)(
///             self.parse_conf,
///             self.lexer, # XXX copy
///             copy(self.state_stack),
///             deepcopy(self.value_stack),
///         )
///
///     def copy(self):
///         return copy(self)
///
///     def feed_token(self, token, is_end=False):
///         state_stack = self.state_stack
///         value_stack = self.value_stack
///         states = self.parse_conf.states
///         end_state = self.parse_conf.end_state
///         callbacks = self.parse_conf.callbacks
///
///         while True:
///             state = state_stack[-1]
///             try:
///                 action, arg = states[state][token.type]
///             except KeyError:
///                 expected = {s for s in states[state].keys() if s.isupper()}
///                 raise UnexpectedToken(token, expected, state=self, interactive_parser=None)
///
///             assert arg != end_state
///
///             if action is Shift:
///                 # shift once and return
///                 assert not is_end
///                 state_stack.append(arg)
///                 value_stack.append(token if token.type not in callbacks else callbacks[token.type](token))
///                 return
///             else:
///                 # reduce+shift as many times as necessary
///                 rule = arg
///                 size = len(rule.expansion)
///                 if size:
///                     s = value_stack[-size:]
///                     del state_stack[-size:]
///                     del value_stack[-size:]
///                 else:
///                     s = []
///
///                 value = callbacks[rule](s)
///
///                 _action, new_state = states[state_stack[-1]][rule.origin.name]
///                 assert _action is Shift
///                 state_stack.append(new_state)
///                 value_stack.append(value)
///
///                 if is_end and state_stack[-1] == end_state:
///                     return value_stack[-1]
/// ```
final class ParserState extends PythonClass {
  factory ParserState({
    required Object? parse_conf,
    required Object? lexer,
    Object? state_stack,
    Object? value_stack,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.lalr_parser",
        "ParserState",
        ParserState.from,
        <Object?>[
          parse_conf,
          lexer,
          state_stack,
          value_stack,
        ],
        <String, Object?>{},
      );

  ParserState.from(super.pythonClass) : super.from();

  /// ## copy
  ///
  /// ### python source
  /// ```py
  /// def copy(self):
  ///         return copy(self)
  /// ```
  Object? copy() => getFunction("copy").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## feed_token
  ///
  /// ### python source
  /// ```py
  /// def feed_token(self, token, is_end=False):
  ///         state_stack = self.state_stack
  ///         value_stack = self.value_stack
  ///         states = self.parse_conf.states
  ///         end_state = self.parse_conf.end_state
  ///         callbacks = self.parse_conf.callbacks
  ///
  ///         while True:
  ///             state = state_stack[-1]
  ///             try:
  ///                 action, arg = states[state][token.type]
  ///             except KeyError:
  ///                 expected = {s for s in states[state].keys() if s.isupper()}
  ///                 raise UnexpectedToken(token, expected, state=self, interactive_parser=None)
  ///
  ///             assert arg != end_state
  ///
  ///             if action is Shift:
  ///                 # shift once and return
  ///                 assert not is_end
  ///                 state_stack.append(arg)
  ///                 value_stack.append(token if token.type not in callbacks else callbacks[token.type](token))
  ///                 return
  ///             else:
  ///                 # reduce+shift as many times as necessary
  ///                 rule = arg
  ///                 size = len(rule.expansion)
  ///                 if size:
  ///                     s = value_stack[-size:]
  ///                     del state_stack[-size:]
  ///                     del value_stack[-size:]
  ///                 else:
  ///                     s = []
  ///
  ///                 value = callbacks[rule](s)
  ///
  ///                 _action, new_state = states[state_stack[-1]][rule.origin.name]
  ///                 assert _action is Shift
  ///                 state_stack.append(new_state)
  ///                 value_stack.append(value)
  ///
  ///                 if is_end and state_stack[-1] == end_state:
  ///                     return value_stack[-1]
  /// ```
  Object? feed_token({
    required Object? token,
    Object? is_end = false,
  }) =>
      getFunction("feed_token").call(
        <Object?>[
          token,
          is_end,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## position (getter)
  Object? get position => getAttribute("position");

  /// ## position (setter)
  set position(Object? position) => setAttribute("position", position);

  /// ## lexer (getter)
  Object? get lexer => getAttribute("lexer");

  /// ## lexer (setter)
  set lexer(Object? lexer) => setAttribute("lexer", lexer);

  /// ## parse_conf (getter)
  Object? get parse_conf => getAttribute("parse_conf");

  /// ## parse_conf (setter)
  set parse_conf(Object? parse_conf) => setAttribute("parse_conf", parse_conf);

  /// ## state_stack (getter)
  Object? get state_stack => getAttribute("state_stack");

  /// ## state_stack (setter)
  set state_stack(Object? state_stack) =>
      setAttribute("state_stack", state_stack);

  /// ## value_stack (getter)
  Object? get value_stack => getAttribute("value_stack");

  /// ## value_stack (setter)
  set value_stack(Object? value_stack) =>
      setAttribute("value_stack", value_stack);
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

/// ## UnexpectedCharacters
///
/// ### python docstring
///
/// An exception that is raised by the lexer, when it cannot match the next
/// string of characters to any of its terminals.
///
/// ### python source
/// ```py
/// class UnexpectedCharacters(LexError, UnexpectedInput):
///     """An exception that is raised by the lexer, when it cannot match the next
///     string of characters to any of its terminals.
///     """
///
///     allowed: Set[str]
///     considered_tokens: Set[Any]
///
///     def __init__(self, seq, lex_pos, line, column, allowed=None, considered_tokens=None, state=None, token_history=None,
///                  terminals_by_name=None, considered_rules=None):
///         super(UnexpectedCharacters, self).__init__()
///
///         # TODO considered_tokens and allowed can be figured out using state
///         self.line = line
///         self.column = column
///         self.pos_in_stream = lex_pos
///         self.state = state
///         self._terminals_by_name = terminals_by_name
///
///         self.allowed = allowed
///         self.considered_tokens = considered_tokens
///         self.considered_rules = considered_rules
///         self.token_history = token_history
///
///         if isinstance(seq, bytes):
///             self.char = seq[lex_pos:lex_pos + 1].decode("ascii", "backslashreplace")
///         else:
///             self.char = seq[lex_pos]
///         self._context = self.get_context(seq)
///
///
///     def __str__(self):
///         message = "No terminal matches '%s' in the current parser context, at line %d col %d" % (self.char, self.line, self.column)
///         message += '\n\n' + self._context
///         if self.allowed:
///             message += self._format_expected(self.allowed)
///         if self.token_history:
///             message += '\nPrevious tokens: %s\n' % ', '.join(repr(t) for t in self.token_history)
///         return message
/// ```
final class UnexpectedCharacters extends PythonClass {
  factory UnexpectedCharacters({
    required Object? seq,
    required Object? lex_pos,
    required Object? line,
    required Object? column,
    Object? allowed,
    Object? considered_tokens,
    Object? state,
    Object? token_history,
    Object? terminals_by_name,
    Object? considered_rules,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "UnexpectedCharacters",
        UnexpectedCharacters.from,
        <Object?>[
          seq,
          lex_pos,
          line,
          column,
          allowed,
          considered_tokens,
          state,
          token_history,
          terminals_by_name,
          considered_rules,
        ],
        <String, Object?>{},
      );

  UnexpectedCharacters.from(super.pythonClass) : super.from();

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
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);

  /// ## pos_in_stream (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get pos_in_stream => getAttribute("pos_in_stream");

  /// ## pos_in_stream (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set pos_in_stream(Object? pos_in_stream) =>
      setAttribute("pos_in_stream", pos_in_stream);

  /// ## line (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get line => getAttribute("line");

  /// ## line (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set line(Object? line) => setAttribute("line", line);

  /// ## column (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get column => getAttribute("column");

  /// ## column (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set column(Object? column) => setAttribute("column", column);

  /// ## state (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get state => getAttribute("state");

  /// ## state (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set state(Object? state) => setAttribute("state", state);

  /// ## allowed (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get allowed => getAttribute("allowed");

  /// ## allowed (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set allowed(Object? allowed) => setAttribute("allowed", allowed);

  /// ## considered_tokens (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get considered_tokens => getAttribute("considered_tokens");

  /// ## considered_tokens (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set considered_tokens(Object? considered_tokens) =>
      setAttribute("considered_tokens", considered_tokens);

  /// ## considered_rules (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get considered_rules => getAttribute("considered_rules");

  /// ## considered_rules (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set considered_rules(Object? considered_rules) =>
      setAttribute("considered_rules", considered_rules);

  /// ## token_history (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get token_history => getAttribute("token_history");

  /// ## token_history (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set token_history(Object? token_history) =>
      setAttribute("token_history", token_history);

  /// ## char (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get char => getAttribute("char");

  /// ## char (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set char(Object? char) => setAttribute("char", char);
}

/// ## UnexpectedInput
///
/// ### python docstring
///
/// UnexpectedInput Error.
///
/// Used as a base class for the following exceptions:
///
/// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
/// - ``UnexpectedToken``: The parser received an unexpected token
/// - ``UnexpectedEOF``: The parser expected a token, but the input ended
///
/// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
///
/// ### python source
/// ```py
/// class UnexpectedInput(LarkError):
///     """UnexpectedInput Error.
///
///     Used as a base class for the following exceptions:
///
///     - ``UnexpectedCharacters``: The lexer encountered an unexpected string
///     - ``UnexpectedToken``: The parser received an unexpected token
///     - ``UnexpectedEOF``: The parser expected a token, but the input ended
///
///     After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
///     """
///     line: int
///     column: int
///     pos_in_stream = None
///     state: Any
///     _terminals_by_name = None
///
///     def get_context(self, text: str, span: int=40) -> str:
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
///
///     def match_examples(self, parse_fn: 'Callable[[str], Tree]',
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
///
///     def _format_expected(self, expected):
///         if self._terminals_by_name:
///             d = self._terminals_by_name
///             expected = [d[t_name].user_repr() if t_name in d else t_name for t_name in expected]
///         return "Expected one of: \n\t* %s\n" % '\n\t* '.join(expected)
/// ```
final class UnexpectedInput extends PythonClass {
  factory UnexpectedInput() => PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "UnexpectedInput",
        UnexpectedInput.from,
        <Object?>[],
      );

  UnexpectedInput.from(super.pythonClass) : super.from();

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
  /// UnexpectedInput Error.
  ///
  /// Used as a base class for the following exceptions:
  ///
  /// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
  /// - ``UnexpectedToken``: The parser received an unexpected token
  /// - ``UnexpectedEOF``: The parser expected a token, but the input ended
  ///
  /// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// UnexpectedInput Error.
  ///
  /// Used as a base class for the following exceptions:
  ///
  /// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
  /// - ``UnexpectedToken``: The parser received an unexpected token
  /// - ``UnexpectedEOF``: The parser expected a token, but the input ended
  ///
  /// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// UnexpectedInput Error.
  ///
  /// Used as a base class for the following exceptions:
  ///
  /// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
  /// - ``UnexpectedToken``: The parser received an unexpected token
  /// - ``UnexpectedEOF``: The parser expected a token, but the input ended
  ///
  /// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// UnexpectedInput Error.
  ///
  /// Used as a base class for the following exceptions:
  ///
  /// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
  /// - ``UnexpectedToken``: The parser received an unexpected token
  /// - ``UnexpectedEOF``: The parser expected a token, but the input ended
  ///
  /// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// UnexpectedInput Error.
  ///
  /// Used as a base class for the following exceptions:
  ///
  /// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
  /// - ``UnexpectedToken``: The parser received an unexpected token
  /// - ``UnexpectedEOF``: The parser expected a token, but the input ended
  ///
  /// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// UnexpectedInput Error.
  ///
  /// Used as a base class for the following exceptions:
  ///
  /// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
  /// - ``UnexpectedToken``: The parser received an unexpected token
  /// - ``UnexpectedEOF``: The parser expected a token, but the input ended
  ///
  /// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);

  /// ## pos_in_stream (getter)
  ///
  /// ### python docstring
  ///
  /// UnexpectedInput Error.
  ///
  /// Used as a base class for the following exceptions:
  ///
  /// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
  /// - ``UnexpectedToken``: The parser received an unexpected token
  /// - ``UnexpectedEOF``: The parser expected a token, but the input ended
  ///
  /// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
  Null get pos_in_stream => getAttribute("pos_in_stream");

  /// ## pos_in_stream (setter)
  ///
  /// ### python docstring
  ///
  /// UnexpectedInput Error.
  ///
  /// Used as a base class for the following exceptions:
  ///
  /// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
  /// - ``UnexpectedToken``: The parser received an unexpected token
  /// - ``UnexpectedEOF``: The parser expected a token, but the input ended
  ///
  /// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
  set pos_in_stream(Null pos_in_stream) =>
      setAttribute("pos_in_stream", pos_in_stream);
}

/// ## parsers
final class parsers extends PythonModule {
  parsers.from(super.pythonModule) : super.from();

  static parsers import() => PythonFfiDart.instance.importModule(
        "lark.parsers",
        parsers.from,
      );
}

/// ## cyk
///
/// ### python docstring
///
/// This module implements a CYK parser.
///
/// ### python source
/// ```py
/// """This module implements a CYK parser."""
///
/// # Author: https://github.com/ehudt (2018)
/// #
/// # Adapted by Erez
///
///
/// from collections import defaultdict
/// import itertools
///
/// from ..exceptions import ParseError
/// from ..lexer import Token
/// from ..tree import Tree
/// from ..grammar import Terminal as T, NonTerminal as NT, Symbol
///
/// def match(t, s):
///     assert isinstance(t, T)
///     return t.name == s.type
///
///
/// class Rule:
///     """Context-free grammar rule."""
///
///     def __init__(self, lhs, rhs, weight, alias):
///         super(Rule, self).__init__()
///         assert isinstance(lhs, NT), lhs
///         assert all(isinstance(x, NT) or isinstance(x, T) for x in rhs), rhs
///         self.lhs = lhs
///         self.rhs = rhs
///         self.weight = weight
///         self.alias = alias
///
///     def __str__(self):
///         return '%s -> %s' % (str(self.lhs), ' '.join(str(x) for x in self.rhs))
///
///     def __repr__(self):
///         return str(self)
///
///     def __hash__(self):
///         return hash((self.lhs, tuple(self.rhs)))
///
///     def __eq__(self, other):
///         return self.lhs == other.lhs and self.rhs == other.rhs
///
///     def __ne__(self, other):
///         return not (self == other)
///
///
/// class Grammar:
///     """Context-free grammar."""
///
///     def __init__(self, rules):
///         self.rules = frozenset(rules)
///
///     def __eq__(self, other):
///         return self.rules == other.rules
///
///     def __str__(self):
///         return '\n' + '\n'.join(sorted(repr(x) for x in self.rules)) + '\n'
///
///     def __repr__(self):
///         return str(self)
///
///
/// # Parse tree data structures
/// class RuleNode:
///     """A node in the parse tree, which also contains the full rhs rule."""
///
///     def __init__(self, rule, children, weight=0):
///         self.rule = rule
///         self.children = children
///         self.weight = weight
///
///     def __repr__(self):
///         return 'RuleNode(%s, [%s])' % (repr(self.rule.lhs), ', '.join(str(x) for x in self.children))
///
///
///
/// class Parser:
///     """Parser wrapper."""
///
///     def __init__(self, rules):
///         super(Parser, self).__init__()
///         self.orig_rules = {rule: rule for rule in rules}
///         rules = [self._to_rule(rule) for rule in rules]
///         self.grammar = to_cnf(Grammar(rules))
///
///     def _to_rule(self, lark_rule):
///         """Converts a lark rule, (lhs, rhs, callback, options), to a Rule."""
///         assert isinstance(lark_rule.origin, NT)
///         assert all(isinstance(x, Symbol) for x in lark_rule.expansion)
///         return Rule(
///             lark_rule.origin, lark_rule.expansion,
///             weight=lark_rule.options.priority if lark_rule.options.priority else 0,
///             alias=lark_rule)
///
///     def parse(self, tokenized, start):  # pylint: disable=invalid-name
///         """Parses input, which is a list of tokens."""
///         assert start
///         start = NT(start)
///
///         table, trees = _parse(tokenized, self.grammar)
///         # Check if the parse succeeded.
///         if all(r.lhs != start for r in table[(0, len(tokenized) - 1)]):
///             raise ParseError('Parsing failed.')
///         parse = trees[(0, len(tokenized) - 1)][start]
///         return self._to_tree(revert_cnf(parse))
///
///     def _to_tree(self, rule_node):
///         """Converts a RuleNode parse tree to a lark Tree."""
///         orig_rule = self.orig_rules[rule_node.rule.alias]
///         children = []
///         for child in rule_node.children:
///             if isinstance(child, RuleNode):
///                 children.append(self._to_tree(child))
///             else:
///                 assert isinstance(child.name, Token)
///                 children.append(child.name)
///         t = Tree(orig_rule.origin, children)
///         t.rule=orig_rule
///         return t
///
///
/// def print_parse(node, indent=0):
///     if isinstance(node, RuleNode):
///         print(' ' * (indent * 2) + str(node.rule.lhs))
///         for child in node.children:
///             print_parse(child, indent + 1)
///     else:
///         print(' ' * (indent * 2) + str(node.s))
///
///
/// def _parse(s, g):
///     """Parses sentence 's' using CNF grammar 'g'."""
///     # The CYK table. Indexed with a 2-tuple: (start pos, end pos)
///     table = defaultdict(set)
///     # Top-level structure is similar to the CYK table. Each cell is a dict from
///     # rule name to the best (lightest) tree for that rule.
///     trees = defaultdict(dict)
///     # Populate base case with existing terminal production rules
///     for i, w in enumerate(s):
///         for terminal, rules in g.terminal_rules.items():
///             if match(terminal, w):
///                 for rule in rules:
///                     table[(i, i)].add(rule)
///                     if (rule.lhs not in trees[(i, i)] or
///                         rule.weight < trees[(i, i)][rule.lhs].weight):
///                         trees[(i, i)][rule.lhs] = RuleNode(rule, [T(w)], weight=rule.weight)
///
///     # Iterate over lengths of sub-sentences
///     for l in range(2, len(s) + 1):
///         # Iterate over sub-sentences with the given length
///         for i in range(len(s) - l + 1):
///             # Choose partition of the sub-sentence in [1, l)
///             for p in range(i + 1, i + l):
///                 span1 = (i, p - 1)
///                 span2 = (p, i + l - 1)
///                 for r1, r2 in itertools.product(table[span1], table[span2]):
///                     for rule in g.nonterminal_rules.get((r1.lhs, r2.lhs), []):
///                         table[(i, i + l - 1)].add(rule)
///                         r1_tree = trees[span1][r1.lhs]
///                         r2_tree = trees[span2][r2.lhs]
///                         rule_total_weight = rule.weight + r1_tree.weight + r2_tree.weight
///                         if (rule.lhs not in trees[(i, i + l - 1)]
///                             or rule_total_weight < trees[(i, i + l - 1)][rule.lhs].weight):
///                             trees[(i, i + l - 1)][rule.lhs] = RuleNode(rule, [r1_tree, r2_tree], weight=rule_total_weight)
///     return table, trees
///
///
/// # This section implements context-free grammar converter to Chomsky normal form.
/// # It also implements a conversion of parse trees from its CNF to the original
/// # grammar.
/// # Overview:
/// # Applies the following operations in this order:
/// # * TERM: Eliminates non-solitary terminals from all rules
/// # * BIN: Eliminates rules with more than 2 symbols on their right-hand-side.
/// # * UNIT: Eliminates non-terminal unit rules
/// #
/// # The following grammar characteristics aren't featured:
/// # * Start symbol appears on RHS
/// # * Empty rules (epsilon rules)
///
///
/// class CnfWrapper:
///     """CNF wrapper for grammar.
///
///   Validates that the input grammar is CNF and provides helper data structures.
///   """
///
///     def __init__(self, grammar):
///         super(CnfWrapper, self).__init__()
///         self.grammar = grammar
///         self.rules = grammar.rules
///         self.terminal_rules = defaultdict(list)
///         self.nonterminal_rules = defaultdict(list)
///         for r in self.rules:
///             # Validate that the grammar is CNF and populate auxiliary data structures.
///             assert isinstance(r.lhs, NT), r
///             if len(r.rhs) not in [1, 2]:
///                 raise ParseError("CYK doesn't support empty rules")
///             if len(r.rhs) == 1 and isinstance(r.rhs[0], T):
///                 self.terminal_rules[r.rhs[0]].append(r)
///             elif len(r.rhs) == 2 and all(isinstance(x, NT) for x in r.rhs):
///                 self.nonterminal_rules[tuple(r.rhs)].append(r)
///             else:
///                 assert False, r
///
///     def __eq__(self, other):
///         return self.grammar == other.grammar
///
///     def __repr__(self):
///         return repr(self.grammar)
///
///
/// class UnitSkipRule(Rule):
///     """A rule that records NTs that were skipped during transformation."""
///
///     def __init__(self, lhs, rhs, skipped_rules, weight, alias):
///         super(UnitSkipRule, self).__init__(lhs, rhs, weight, alias)
///         self.skipped_rules = skipped_rules
///
///     def __eq__(self, other):
///         return isinstance(other, type(self)) and self.skipped_rules == other.skipped_rules
///
///     __hash__ = Rule.__hash__
///
///
/// def build_unit_skiprule(unit_rule, target_rule):
///     skipped_rules = []
///     if isinstance(unit_rule, UnitSkipRule):
///         skipped_rules += unit_rule.skipped_rules
///     skipped_rules.append(target_rule)
///     if isinstance(target_rule, UnitSkipRule):
///         skipped_rules += target_rule.skipped_rules
///     return UnitSkipRule(unit_rule.lhs, target_rule.rhs, skipped_rules,
///                       weight=unit_rule.weight + target_rule.weight, alias=unit_rule.alias)
///
///
/// def get_any_nt_unit_rule(g):
///     """Returns a non-terminal unit rule from 'g', or None if there is none."""
///     for rule in g.rules:
///         if len(rule.rhs) == 1 and isinstance(rule.rhs[0], NT):
///             return rule
///     return None
///
///
/// def _remove_unit_rule(g, rule):
///     """Removes 'rule' from 'g' without changing the language produced by 'g'."""
///     new_rules = [x for x in g.rules if x != rule]
///     refs = [x for x in g.rules if x.lhs == rule.rhs[0]]
///     new_rules += [build_unit_skiprule(rule, ref) for ref in refs]
///     return Grammar(new_rules)
///
///
/// def _split(rule):
///     """Splits a rule whose len(rhs) > 2 into shorter rules."""
///     rule_str = str(rule.lhs) + '__' + '_'.join(str(x) for x in rule.rhs)
///     rule_name = '__SP_%s' % (rule_str) + '_%d'
///     yield Rule(rule.lhs, [rule.rhs[0], NT(rule_name % 1)], weight=rule.weight, alias=rule.alias)
///     for i in range(1, len(rule.rhs) - 2):
///         yield Rule(NT(rule_name % i), [rule.rhs[i], NT(rule_name % (i + 1))], weight=0, alias='Split')
///     yield Rule(NT(rule_name % (len(rule.rhs) - 2)), rule.rhs[-2:], weight=0, alias='Split')
///
///
/// def _term(g):
///     """Applies the TERM rule on 'g' (see top comment)."""
///     all_t = {x for rule in g.rules for x in rule.rhs if isinstance(x, T)}
///     t_rules = {t: Rule(NT('__T_%s' % str(t)), [t], weight=0, alias='Term') for t in all_t}
///     new_rules = []
///     for rule in g.rules:
///         if len(rule.rhs) > 1 and any(isinstance(x, T) for x in rule.rhs):
///             new_rhs = [t_rules[x].lhs if isinstance(x, T) else x for x in rule.rhs]
///             new_rules.append(Rule(rule.lhs, new_rhs, weight=rule.weight, alias=rule.alias))
///             new_rules.extend(v for k, v in t_rules.items() if k in rule.rhs)
///         else:
///             new_rules.append(rule)
///     return Grammar(new_rules)
///
///
/// def _bin(g):
///     """Applies the BIN rule to 'g' (see top comment)."""
///     new_rules = []
///     for rule in g.rules:
///         if len(rule.rhs) > 2:
///             new_rules += _split(rule)
///         else:
///             new_rules.append(rule)
///     return Grammar(new_rules)
///
///
/// def _unit(g):
///     """Applies the UNIT rule to 'g' (see top comment)."""
///     nt_unit_rule = get_any_nt_unit_rule(g)
///     while nt_unit_rule:
///         g = _remove_unit_rule(g, nt_unit_rule)
///         nt_unit_rule = get_any_nt_unit_rule(g)
///     return g
///
///
/// def to_cnf(g):
///     """Creates a CNF grammar from a general context-free grammar 'g'."""
///     g = _unit(_bin(_term(g)))
///     return CnfWrapper(g)
///
///
/// def unroll_unit_skiprule(lhs, orig_rhs, skipped_rules, children, weight, alias):
///     if not skipped_rules:
///         return RuleNode(Rule(lhs, orig_rhs, weight=weight, alias=alias), children, weight=weight)
///     else:
///         weight = weight - skipped_rules[0].weight
///         return RuleNode(
///             Rule(lhs, [skipped_rules[0].lhs], weight=weight, alias=alias), [
///                 unroll_unit_skiprule(skipped_rules[0].lhs, orig_rhs,
///                                 skipped_rules[1:], children,
///                                 skipped_rules[0].weight, skipped_rules[0].alias)
///             ], weight=weight)
///
///
/// def revert_cnf(node):
///     """Reverts a parse tree (RuleNode) to its original non-CNF form (Node)."""
///     if isinstance(node, T):
///         return node
///     # Reverts TERM rule.
///     if node.rule.lhs.name.startswith('__T_'):
///         return node.children[0]
///     else:
///         children = []
///         for child in map(revert_cnf, node.children):
///             # Reverts BIN rule.
///             if isinstance(child, RuleNode) and child.rule.lhs.name.startswith('__SP_'):
///                 children += child.children
///             else:
///                 children.append(child)
///         # Reverts UNIT rule.
///         if isinstance(node.rule, UnitSkipRule):
///             return unroll_unit_skiprule(node.rule.lhs, node.rule.rhs,
///                                     node.rule.skipped_rules, children,
///                                     node.rule.weight, node.rule.alias)
///         else:
///             return RuleNode(node.rule, children)
/// ```
final class cyk extends PythonModule {
  cyk.from(super.pythonModule) : super.from();

  static cyk import() => PythonFfiDart.instance.importModule(
        "lark.parsers.cyk",
        cyk.from,
      );

  /// ## build_unit_skiprule
  ///
  /// ### python source
  /// ```py
  /// def build_unit_skiprule(unit_rule, target_rule):
  ///     skipped_rules = []
  ///     if isinstance(unit_rule, UnitSkipRule):
  ///         skipped_rules += unit_rule.skipped_rules
  ///     skipped_rules.append(target_rule)
  ///     if isinstance(target_rule, UnitSkipRule):
  ///         skipped_rules += target_rule.skipped_rules
  ///     return UnitSkipRule(unit_rule.lhs, target_rule.rhs, skipped_rules,
  ///                       weight=unit_rule.weight + target_rule.weight, alias=unit_rule.alias)
  /// ```
  Object? build_unit_skiprule({
    required Object? unit_rule,
    required Object? target_rule,
  }) =>
      getFunction("build_unit_skiprule").call(
        <Object?>[
          unit_rule,
          target_rule,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## get_any_nt_unit_rule
  ///
  /// ### python docstring
  ///
  /// Returns a non-terminal unit rule from 'g', or None if there is none.
  ///
  /// ### python source
  /// ```py
  /// def get_any_nt_unit_rule(g):
  ///     """Returns a non-terminal unit rule from 'g', or None if there is none."""
  ///     for rule in g.rules:
  ///         if len(rule.rhs) == 1 and isinstance(rule.rhs[0], NT):
  ///             return rule
  ///     return None
  /// ```
  Object? get_any_nt_unit_rule({
    required Object? g,
  }) =>
      getFunction("get_any_nt_unit_rule").call(
        <Object?>[
          g,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## match
  ///
  /// ### python source
  /// ```py
  /// def match(t, s):
  ///     assert isinstance(t, T)
  ///     return t.name == s.type
  /// ```
  Object? match({
    required Object? t,
    required Object? s,
  }) =>
      getFunction("match").call(
        <Object?>[
          t,
          s,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## print_parse
  ///
  /// ### python source
  /// ```py
  /// def print_parse(node, indent=0):
  ///     if isinstance(node, RuleNode):
  ///         print(' ' * (indent * 2) + str(node.rule.lhs))
  ///         for child in node.children:
  ///             print_parse(child, indent + 1)
  ///     else:
  ///         print(' ' * (indent * 2) + str(node.s))
  /// ```
  Object? print_parse({
    required Object? node,
    Object? indent = 0,
  }) =>
      getFunction("print_parse").call(
        <Object?>[
          node,
          indent,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## revert_cnf
  ///
  /// ### python docstring
  ///
  /// Reverts a parse tree (RuleNode) to its original non-CNF form (Node).
  ///
  /// ### python source
  /// ```py
  /// def revert_cnf(node):
  ///     """Reverts a parse tree (RuleNode) to its original non-CNF form (Node)."""
  ///     if isinstance(node, T):
  ///         return node
  ///     # Reverts TERM rule.
  ///     if node.rule.lhs.name.startswith('__T_'):
  ///         return node.children[0]
  ///     else:
  ///         children = []
  ///         for child in map(revert_cnf, node.children):
  ///             # Reverts BIN rule.
  ///             if isinstance(child, RuleNode) and child.rule.lhs.name.startswith('__SP_'):
  ///                 children += child.children
  ///             else:
  ///                 children.append(child)
  ///         # Reverts UNIT rule.
  ///         if isinstance(node.rule, UnitSkipRule):
  ///             return unroll_unit_skiprule(node.rule.lhs, node.rule.rhs,
  ///                                     node.rule.skipped_rules, children,
  ///                                     node.rule.weight, node.rule.alias)
  ///         else:
  ///             return RuleNode(node.rule, children)
  /// ```
  Object? revert_cnf({
    required Object? node,
  }) =>
      getFunction("revert_cnf").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## to_cnf
  ///
  /// ### python docstring
  ///
  /// Creates a CNF grammar from a general context-free grammar 'g'.
  ///
  /// ### python source
  /// ```py
  /// def to_cnf(g):
  ///     """Creates a CNF grammar from a general context-free grammar 'g'."""
  ///     g = _unit(_bin(_term(g)))
  ///     return CnfWrapper(g)
  /// ```
  Object? to_cnf({
    required Object? g,
  }) =>
      getFunction("to_cnf").call(
        <Object?>[
          g,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## unroll_unit_skiprule
  ///
  /// ### python source
  /// ```py
  /// def unroll_unit_skiprule(lhs, orig_rhs, skipped_rules, children, weight, alias):
  ///     if not skipped_rules:
  ///         return RuleNode(Rule(lhs, orig_rhs, weight=weight, alias=alias), children, weight=weight)
  ///     else:
  ///         weight = weight - skipped_rules[0].weight
  ///         return RuleNode(
  ///             Rule(lhs, [skipped_rules[0].lhs], weight=weight, alias=alias), [
  ///                 unroll_unit_skiprule(skipped_rules[0].lhs, orig_rhs,
  ///                                 skipped_rules[1:], children,
  ///                                 skipped_rules[0].weight, skipped_rules[0].alias)
  ///             ], weight=weight)
  /// ```
  Object? unroll_unit_skiprule({
    required Object? lhs,
    required Object? orig_rhs,
    required Object? skipped_rules,
    required Object? children,
    required Object? weight,
    required Object? alias,
  }) =>
      getFunction("unroll_unit_skiprule").call(
        <Object?>[
          lhs,
          orig_rhs,
          skipped_rules,
          children,
          weight,
          alias,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## itertools
final class itertools extends PythonModule {
  itertools.from(super.pythonModule) : super.from();

  static itertools import() => PythonFfiDart.instance.importModule(
        "itertools",
        itertools.from,
      );
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

  static earley import() => PythonFfiDart.instance.importModule(
        "lark.parsers.earley",
        earley.from,
      );
}

/// ## earley_common
///
/// ### python docstring
///
/// This module implements useful building blocks for the Earley parser
///
/// ### python source
/// ```py
/// """This module implements useful building blocks for the Earley parser
/// """
///
///
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
///
///
/// # class TransitiveItem(Item):
/// #   ...   # removed at commit 4c1cfb2faf24e8f8bff7112627a00b94d261b420
/// ```
final class earley_common extends PythonModule {
  earley_common.from(super.pythonModule) : super.from();

  static earley_common import() => PythonFfiDart.instance.importModule(
        "lark.parsers.earley_common",
        earley_common.from,
      );
}

/// ## earley_forest
///
/// ### python docstring
///
/// "This module implements an SPPF implementation
///
/// This is used as the primary output mechanism for the Earley parser
/// in order to store complex ambiguities.
///
/// Full reference and more details is here:
/// https://web.archive.org/web/20190616123959/http://www.bramvandersanden.com/post/2014/06/shared-packed-parse-forest/
///
/// ### python source
/// ```py
/// """"This module implements an SPPF implementation
///
/// This is used as the primary output mechanism for the Earley parser
/// in order to store complex ambiguities.
///
/// Full reference and more details is here:
/// https://web.archive.org/web/20190616123959/http://www.bramvandersanden.com/post/2014/06/shared-packed-parse-forest/
/// """
///
/// from random import randint
/// from collections import deque
/// from operator import attrgetter
/// from importlib import import_module
/// from functools import partial
///
/// from ..parse_tree_builder import AmbiguousIntermediateExpander
/// from ..visitors import Discard
/// from ..utils import logger
/// from ..tree import Tree
///
/// class ForestNode:
///     pass
///
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
///
/// class PackedNode(ForestNode):
///     """
///     A Packed Node represents a single derivation in a symbol node.
///
///     Parameters:
///         rule: The rule associated with this node.
///         parent: The parent of this node.
///         left: The left child of this node. ``None`` if one does not exist.
///         right: The right child of this node. ``None`` if one does not exist.
///         priority: The priority of this node.
///     """
///     __slots__ = ('parent', 's', 'rule', 'start', 'left', 'right', 'priority', '_hash')
///     def __init__(self, parent, s, rule, start, left, right):
///         self.parent = parent
///         self.s = s
///         self.start = start
///         self.rule = rule
///         self.left = left
///         self.right = right
///         self.priority = float('-inf')
///         self._hash = hash((self.left, self.right))
///
///     @property
///     def is_empty(self):
///         return self.left is None and self.right is None
///
///     @property
///     def sort_key(self):
///         """
///         Used to sort PackedNode children of SymbolNodes.
///         A SymbolNode has multiple PackedNodes if it matched
///         ambiguously. Hence, we use the sort order to identify
///         the order in which ambiguous children should be considered.
///         """
///         return self.is_empty, -self.priority, self.rule.order
///
///     @property
///     def children(self):
///         """Returns a list of this node's children."""
///         return [x for x in [self.left, self.right] if x is not None]
///
///     def __iter__(self):
///         yield self.left
///         yield self.right
///
///     def __eq__(self, other):
///         if not isinstance(other, PackedNode):
///             return False
///         return self is other or (self.left == other.left and self.right == other.right)
///
///     def __hash__(self):
///         return self._hash
///
///     def __repr__(self):
///         if isinstance(self.s, tuple):
///             rule = self.s[0]
///             ptr = self.s[1]
///             before = ( expansion.name for expansion in rule.expansion[:ptr] )
///             after = ( expansion.name for expansion in rule.expansion[ptr:] )
///             symbol = "{} ::= {}* {}".format(rule.origin.name, ' '.join(before), ' '.join(after))
///         else:
///             symbol = self.s.name
///         return "({}, {}, {}, {})".format(symbol, self.start, self.priority, self.rule.order)
///
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
///
/// class ForestVisitor:
///     """
///     An abstract base class for building forest visitors.
///
///     This class performs a controllable depth-first walk of an SPPF.
///     The visitor will not enter cycles and will backtrack if one is encountered.
///     Subclasses are notified of cycles through the ``on_cycle`` method.
///
///     Behavior for visit events is defined by overriding the
///     ``visit*node*`` functions.
///
///     The walk is controlled by the return values of the ``visit*node_in``
///     methods. Returning a node(s) will schedule them to be visited. The visitor
///     will begin to backtrack if no nodes are returned.
///
///     Parameters:
///         single_visit: If ``True``, non-Token nodes will only be visited once.
///     """
///
///     def __init__(self, single_visit=False):
///         self.single_visit = single_visit
///
///     def visit_token_node(self, node):
///         """Called when a ``Token`` is visited. ``Token`` nodes are always leaves."""
///         pass
///
///     def visit_symbol_node_in(self, node):
///         """Called when a symbol node is visited. Nodes that are returned
///         will be scheduled to be visited. If ``visit_intermediate_node_in``
///         is not implemented, this function will be called for intermediate
///         nodes as well."""
///         pass
///
///     def visit_symbol_node_out(self, node):
///         """Called after all nodes returned from a corresponding ``visit_symbol_node_in``
///         call have been visited. If ``visit_intermediate_node_out``
///         is not implemented, this function will be called for intermediate
///         nodes as well."""
///         pass
///
///     def visit_packed_node_in(self, node):
///         """Called when a packed node is visited. Nodes that are returned
///         will be scheduled to be visited. """
///         pass
///
///     def visit_packed_node_out(self, node):
///         """Called after all nodes returned from a corresponding ``visit_packed_node_in``
///         call have been visited."""
///         pass
///
///     def on_cycle(self, node, path):
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
///
///     def get_cycle_in_path(self, node, path):
///         """A utility function for use in ``on_cycle`` to obtain a slice of
///         ``path`` that only contains the nodes that make up the cycle."""
///         index = len(path) - 1
///         while id(path[index]) != id(node):
///             index -= 1
///         return path[index:]
///
///     def visit(self, root):
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
///
/// class ForestTransformer(ForestVisitor):
///     """The base class for a bottom-up forest transformation. Most users will
///     want to use ``TreeForestTransformer`` instead as it has a friendlier
///     interface and covers most use cases.
///
///     Transformations are applied via inheritance and overriding of the
///     ``transform*node`` methods.
///
///     ``transform_token_node`` receives a ``Token`` as an argument.
///     All other methods receive the node that is being transformed and
///     a list of the results of the transformations of that node's children.
///     The return value of these methods are the resulting transformations.
///
///     If ``Discard`` is raised in a node's transformation, no data from that node
///     will be passed to its parent's transformation.
///     """
///
///     def __init__(self):
///         super(ForestTransformer, self).__init__()
///         # results of transformations
///         self.data = dict()
///         # used to track parent nodes
///         self.node_stack = deque()
///
///     def transform(self, root):
///         """Perform a transformation on an SPPF."""
///         self.node_stack.append('result')
///         self.data['result'] = []
///         self.visit(root)
///         assert len(self.data['result']) <= 1
///         if self.data['result']:
///             return self.data['result'][0]
///
///     def transform_symbol_node(self, node, data):
///         """Transform a symbol node."""
///         return node
///
///     def transform_intermediate_node(self, node, data):
///         """Transform an intermediate node."""
///         return node
///
///     def transform_packed_node(self, node, data):
///         """Transform a packed node."""
///         return node
///
///     def transform_token_node(self, node):
///         """Transform a ``Token``."""
///         return node
///
///     def visit_symbol_node_in(self, node):
///         self.node_stack.append(id(node))
///         self.data[id(node)] = []
///         return node.children
///
///     def visit_packed_node_in(self, node):
///         self.node_stack.append(id(node))
///         self.data[id(node)] = []
///         return node.children
///
///     def visit_token_node(self, node):
///         transformed = self.transform_token_node(node)
///         if transformed is not Discard:
///             self.data[self.node_stack[-1]].append(transformed)
///
///     def _visit_node_out_helper(self, node, method):
///         self.node_stack.pop()
///         transformed = method(node, self.data[id(node)])
///         if transformed is not Discard:
///             self.data[self.node_stack[-1]].append(transformed)
///         del self.data[id(node)]
///
///     def visit_symbol_node_out(self, node):
///         self._visit_node_out_helper(node, self.transform_symbol_node)
///
///     def visit_intermediate_node_out(self, node):
///         self._visit_node_out_helper(node, self.transform_intermediate_node)
///
///     def visit_packed_node_out(self, node):
///         self._visit_node_out_helper(node, self.transform_packed_node)
///
///
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
///
/// class PackedData():
///     """Used in transformationss of packed nodes to distinguish the data
///     that comes from the left child and the right child.
///     """
///
///     class _NoData():
///         pass
///
///     NO_DATA = _NoData()
///
///     def __init__(self, node, data):
///         self.left = self.NO_DATA
///         self.right = self.NO_DATA
///         if data:
///             if node.left is not None:
///                 self.left = data[0]
///                 if len(data) > 1:
///                     self.right = data[1]
///             else:
///                 self.right = data[0]
///
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
///
/// def handles_ambiguity(func):
///     """Decorator for methods of subclasses of ``TreeForestTransformer``.
///     Denotes that the method should receive a list of transformed derivations."""
///     func.handles_ambiguity = True
///     return func
///
/// class TreeForestTransformer(ForestToParseTree):
///     """A ``ForestTransformer`` with a tree ``Transformer``-like interface.
///     By default, it will construct a tree.
///
///     Methods provided via inheritance are called based on the rule/symbol
///     names of nodes in the forest.
///
///     Methods that act on rules will receive a list of the results of the
///     transformations of the rule's children. By default, trees and tokens.
///
///     Methods that act on tokens will receive a token.
///
///     Alternatively, methods that act on rules may be annotated with
///     ``handles_ambiguity``. In this case, the function will receive a list
///     of all the transformations of all the derivations of the rule.
///     By default, a list of trees where each tree.data is equal to the
///     rule name or one of its aliases.
///
///     Non-tree transformations are made possible by override of
///     ``__default__``, ``__default_token__``, and ``__default_ambig__``.
///
///     Note:
///         Tree shaping features such as inlined rules and token filtering are
///         not built into the transformation. Positions are also not propagated.
///
///     Parameters:
///         tree_class: The tree class to use for construction
///         prioritizer: A ``ForestVisitor`` that manipulates the priorities of nodes in the SPPF.
///         resolve_ambiguity: If True, ambiguities will be resolved based on priorities.
///         use_cache (bool): If True, caches the results of some transformations,
///                           potentially improving performance when ``resolve_ambiguity==False``.
///                           Only use if you know what you are doing: i.e. All transformation
///                           functions are pure and referentially transparent.
///     """
///
///     def __init__(self, tree_class=Tree, prioritizer=ForestSumVisitor(), resolve_ambiguity=True, use_cache=False):
///         super(TreeForestTransformer, self).__init__(tree_class, dict(), prioritizer, resolve_ambiguity, use_cache)
///
///     def __default__(self, name, data):
///         """Default operation on tree (for override).
///
///         Returns a tree with name with data as children.
///         """
///         return self.tree_class(name, data)
///
///     def __default_ambig__(self, name, data):
///         """Default operation on ambiguous rule (for override).
///
///         Wraps data in an '_ambig_' node if it contains more than
///         one element.
///         """
///         if len(data) > 1:
///             return self.tree_class('_ambig', data)
///         elif data:
///             return data[0]
///         return Discard
///
///     def __default_token__(self, node):
///         """Default operation on ``Token`` (for override).
///
///         Returns ``node``.
///         """
///         return node
///
///     def transform_token_node(self, node):
///         return getattr(self, node.type, self.__default_token__)(node)
///
///     def _call_rule_func(self, node, data):
///         name = node.rule.alias or node.rule.options.template_source or node.rule.origin.name
///         user_func = getattr(self, name, self.__default__)
///         if user_func == self.__default__ or hasattr(user_func, 'handles_ambiguity'):
///             user_func = partial(self.__default__, name)
///         if not self.resolve_ambiguity:
///             wrapper = partial(AmbiguousIntermediateExpander, self.tree_class)
///             user_func = wrapper(user_func)
///         return user_func(data)
///
///     def _call_ambig_func(self, node, data):
///         name = node.s.name
///         user_func = getattr(self, name, self.__default_ambig__)
///         if user_func == self.__default_ambig__ or not hasattr(user_func, 'handles_ambiguity'):
///             user_func = partial(self.__default_ambig__, name)
///         return user_func(data)
///
/// class ForestToPyDotVisitor(ForestVisitor):
///     """
///     A Forest visitor which writes the SPPF to a PNG.
///
///     The SPPF can get really large, really quickly because
///     of the amount of meta-data it stores, so this is probably
///     only useful for trivial trees and learning how the SPPF
///     is structured.
///     """
///     def __init__(self, rankdir="TB"):
///         super(ForestToPyDotVisitor, self).__init__(single_visit=True)
///         self.pydot = import_module('pydot')
///         self.graph = self.pydot.Dot(graph_type='digraph', rankdir=rankdir)
///
///     def visit(self, root, filename):
///         super(ForestToPyDotVisitor, self).visit(root)
///         try:
///             self.graph.write_png(filename)
///         except FileNotFoundError as e:
///             logger.error("Could not write png: ", e)
///
///     def visit_token_node(self, node):
///         graph_node_id = str(id(node))
///         graph_node_label = "\"{}\"".format(node.value.replace('"', '\\"'))
///         graph_node_color = 0x808080
///         graph_node_style = "\"filled,rounded\""
///         graph_node_shape = "diamond"
///         graph_node = self.pydot.Node(graph_node_id, style=graph_node_style, fillcolor="#{:06x}".format(graph_node_color), shape=graph_node_shape, label=graph_node_label)
///         self.graph.add_node(graph_node)
///
///     def visit_packed_node_in(self, node):
///         graph_node_id = str(id(node))
///         graph_node_label = repr(node)
///         graph_node_color = 0x808080
///         graph_node_style = "filled"
///         graph_node_shape = "diamond"
///         graph_node = self.pydot.Node(graph_node_id, style=graph_node_style, fillcolor="#{:06x}".format(graph_node_color), shape=graph_node_shape, label=graph_node_label)
///         self.graph.add_node(graph_node)
///         yield node.left
///         yield node.right
///
///     def visit_packed_node_out(self, node):
///         graph_node_id = str(id(node))
///         graph_node = self.graph.get_node(graph_node_id)[0]
///         for child in [node.left, node.right]:
///             if child is not None:
///                 child_graph_node_id = str(id(child.token if isinstance(child, TokenNode) else child))
///                 child_graph_node = self.graph.get_node(child_graph_node_id)[0]
///                 self.graph.add_edge(self.pydot.Edge(graph_node, child_graph_node))
///             else:
///                 #### Try and be above the Python object ID range; probably impl. specific, but maybe this is okay.
///                 child_graph_node_id = str(randint(100000000000000000000000000000,123456789012345678901234567890))
///                 child_graph_node_style = "invis"
///                 child_graph_node = self.pydot.Node(child_graph_node_id, style=child_graph_node_style, label="None")
///                 child_edge_style = "invis"
///                 self.graph.add_node(child_graph_node)
///                 self.graph.add_edge(self.pydot.Edge(graph_node, child_graph_node, style=child_edge_style))
///
///     def visit_symbol_node_in(self, node):
///         graph_node_id = str(id(node))
///         graph_node_label = repr(node)
///         graph_node_color = 0x808080
///         graph_node_style = "\"filled\""
///         if node.is_intermediate:
///             graph_node_shape = "ellipse"
///         else:
///             graph_node_shape = "rectangle"
///         graph_node = self.pydot.Node(graph_node_id, style=graph_node_style, fillcolor="#{:06x}".format(graph_node_color), shape=graph_node_shape, label=graph_node_label)
///         self.graph.add_node(graph_node)
///         return iter(node.children)
///
///     def visit_symbol_node_out(self, node):
///         graph_node_id = str(id(node))
///         graph_node = self.graph.get_node(graph_node_id)[0]
///         for child in node.children:
///             child_graph_node_id = str(id(child))
///             child_graph_node = self.graph.get_node(child_graph_node_id)[0]
///             self.graph.add_edge(self.pydot.Edge(graph_node, child_graph_node))
/// ```
final class earley_forest extends PythonModule {
  earley_forest.from(super.pythonModule) : super.from();

  static earley_forest import() => PythonFfiDart.instance.importModule(
        "lark.parsers.earley_forest",
        earley_forest.from,
      );

  /// ## handles_ambiguity
  ///
  /// ### python docstring
  ///
  /// Decorator for methods of subclasses of ``TreeForestTransformer``.
  /// Denotes that the method should receive a list of transformed derivations.
  ///
  /// ### python source
  /// ```py
  /// def handles_ambiguity(func):
  ///     """Decorator for methods of subclasses of ``TreeForestTransformer``.
  ///     Denotes that the method should receive a list of transformed derivations."""
  ///     func.handles_ambiguity = True
  ///     return func
  /// ```
  Object? handles_ambiguity({
    required Object? func,
  }) =>
      getFunction("handles_ambiguity").call(
        <Object?>[
          func,
        ],
        kwargs: <String, Object?>{},
      );
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

  static grammar_analysis import() => PythonFfiDart.instance.importModule(
        "lark.parsers.grammar_analysis",
        grammar_analysis.from,
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

/// ## lalr_analysis
///
/// ### python docstring
///
/// This module builds a LALR(1) transition-table for lalr_parser.py
///
/// For now, shift/reduce conflicts are automatically resolved as shifts.
///
/// ### python source
/// ```py
/// """This module builds a LALR(1) transition-table for lalr_parser.py
///
/// For now, shift/reduce conflicts are automatically resolved as shifts.
/// """
///
/// # Author: Erez Shinan (2017)
/// # Email : erezshin@gmail.com
///
/// from collections import defaultdict
///
/// from ..utils import classify, classify_bool, bfs, fzset, Enumerator, logger
/// from ..exceptions import GrammarError
///
/// from .grammar_analysis import GrammarAnalyzer, Terminal, LR0ItemSet
/// from ..grammar import Rule
///
/// ###{standalone
///
/// class Action:
///     def __init__(self, name):
///         self.name = name
///     def __str__(self):
///         return self.name
///     def __repr__(self):
///         return str(self)
///
/// Shift = Action('Shift')
/// Reduce = Action('Reduce')
///
///
/// class ParseTable:
///     def __init__(self, states, start_states, end_states):
///         self.states = states
///         self.start_states = start_states
///         self.end_states = end_states
///
///     def serialize(self, memo):
///         tokens = Enumerator()
///
///         states = {
///             state: {tokens.get(token): ((1, arg.serialize(memo)) if action is Reduce else (0, arg))
///                     for token, (action, arg) in actions.items()}
///             for state, actions in self.states.items()
///         }
///
///         return {
///             'tokens': tokens.reversed(),
///             'states': states,
///             'start_states': self.start_states,
///             'end_states': self.end_states,
///         }
///
///     @classmethod
///     def deserialize(cls, data, memo):
///         tokens = data['tokens']
///         states = {
///             state: {tokens[token]: ((Reduce, Rule.deserialize(arg, memo)) if action==1 else (Shift, arg))
///                     for token, (action, arg) in actions.items()}
///             for state, actions in data['states'].items()
///         }
///         return cls(states, data['start_states'], data['end_states'])
///
///
/// class IntParseTable(ParseTable):
///
///     @classmethod
///     def from_ParseTable(cls, parse_table):
///         enum = list(parse_table.states)
///         state_to_idx = {s:i for i,s in enumerate(enum)}
///         int_states = {}
///
///         for s, la in parse_table.states.items():
///             la = {k:(v[0], state_to_idx[v[1]]) if v[0] is Shift else v
///                   for k,v in la.items()}
///             int_states[ state_to_idx[s] ] = la
///
///
///         start_states = {start:state_to_idx[s] for start, s in parse_table.start_states.items()}
///         end_states = {start:state_to_idx[s] for start, s in parse_table.end_states.items()}
///         return cls(int_states, start_states, end_states)
///
/// ###}
///
///
/// # digraph and traverse, see The Theory and Practice of Compiler Writing
///
/// # computes F(x) = G(x) union (union { G(y) | x R y })
/// # X: nodes
/// # R: relation (function mapping node -> list of nodes that satisfy the relation)
/// # G: set valued function
/// def digraph(X, R, G):
///     F = {}
///     S = []
///     N = dict.fromkeys(X, 0)
///     for x in X:
///         # this is always true for the first iteration, but N[x] may be updated in traverse below
///         if N[x] == 0:
///             traverse(x, S, N, X, R, G, F)
///     return F
///
/// # x: single node
/// # S: stack
/// # N: weights
/// # X: nodes
/// # R: relation (see above)
/// # G: set valued function
/// # F: set valued function we are computing (map of input -> output)
/// def traverse(x, S, N, X, R, G, F):
///     S.append(x)
///     d = len(S)
///     N[x] = d
///     F[x] = G[x]
///     for y in R[x]:
///         if N[y] == 0:
///             traverse(y, S, N, X, R, G, F)
///         n_x = N[x]
///         assert(n_x > 0)
///         n_y = N[y]
///         assert(n_y != 0)
///         if (n_y > 0) and (n_y < n_x):
///             N[x] = n_y
///         F[x].update(F[y])
///     if N[x] == d:
///         f_x = F[x]
///         while True:
///             z = S.pop()
///             N[z] = -1
///             F[z] = f_x
///             if z == x:
///                 break
///
///
/// class LALR_Analyzer(GrammarAnalyzer):
///     def __init__(self, parser_conf, debug=False, strict=False):
///         GrammarAnalyzer.__init__(self, parser_conf, debug, strict)
///         self.nonterminal_transitions = []
///         self.directly_reads = defaultdict(set)
///         self.reads = defaultdict(set)
///         self.includes = defaultdict(set)
///         self.lookback = defaultdict(set)
///
///
///     def compute_lr0_states(self):
///         self.lr0_states = set()
///         # map of kernels to LR0ItemSets
///         cache = {}
///
///         def step(state):
///             _, unsat = classify_bool(state.closure, lambda rp: rp.is_satisfied)
///
///             d = classify(unsat, lambda rp: rp.next)
///             for sym, rps in d.items():
///                 kernel = fzset({rp.advance(sym) for rp in rps})
///                 new_state = cache.get(kernel, None)
///                 if new_state is None:
///                     closure = set(kernel)
///                     for rp in kernel:
///                         if not rp.is_satisfied and not rp.next.is_term:
///                             closure |= self.expand_rule(rp.next, self.lr0_rules_by_origin)
///                     new_state = LR0ItemSet(kernel, closure)
///                     cache[kernel] = new_state
///
///                 state.transitions[sym] = new_state
///                 yield new_state
///
///             self.lr0_states.add(state)
///
///         for _ in bfs(self.lr0_start_states.values(), step):
///             pass
///
///     def compute_reads_relations(self):
///         # handle start state
///         for root in self.lr0_start_states.values():
///             assert(len(root.kernel) == 1)
///             for rp in root.kernel:
///                 assert(rp.index == 0)
///                 self.directly_reads[(root, rp.next)] = set([ Terminal('$END') ])
///
///         for state in self.lr0_states:
///             seen = set()
///             for rp in state.closure:
///                 if rp.is_satisfied:
///                     continue
///                 s = rp.next
///                 # if s is a not a nonterminal
///                 if s not in self.lr0_rules_by_origin:
///                     continue
///                 if s in seen:
///                     continue
///                 seen.add(s)
///                 nt = (state, s)
///                 self.nonterminal_transitions.append(nt)
///                 dr = self.directly_reads[nt]
///                 r = self.reads[nt]
///                 next_state = state.transitions[s]
///                 for rp2 in next_state.closure:
///                     if rp2.is_satisfied:
///                         continue
///                     s2 = rp2.next
///                     # if s2 is a terminal
///                     if s2 not in self.lr0_rules_by_origin:
///                         dr.add(s2)
///                     if s2 in self.NULLABLE:
///                         r.add((next_state, s2))
///
///     def compute_includes_lookback(self):
///         for nt in self.nonterminal_transitions:
///             state, nonterminal = nt
///             includes = []
///             lookback = self.lookback[nt]
///             for rp in state.closure:
///                 if rp.rule.origin != nonterminal:
///                     continue
///                 # traverse the states for rp(.rule)
///                 state2 = state
///                 for i in range(rp.index, len(rp.rule.expansion)):
///                     s = rp.rule.expansion[i]
///                     nt2 = (state2, s)
///                     state2 = state2.transitions[s]
///                     if nt2 not in self.reads:
///                         continue
///                     for j in range(i + 1, len(rp.rule.expansion)):
///                         if rp.rule.expansion[j] not in self.NULLABLE:
///                             break
///                     else:
///                         includes.append(nt2)
///                 # state2 is at the final state for rp.rule
///                 if rp.index == 0:
///                     for rp2 in state2.closure:
///                         if (rp2.rule == rp.rule) and rp2.is_satisfied:
///                             lookback.add((state2, rp2.rule))
///             for nt2 in includes:
///                 self.includes[nt2].add(nt)
///
///     def compute_lookaheads(self):
///         read_sets = digraph(self.nonterminal_transitions, self.reads, self.directly_reads)
///         follow_sets = digraph(self.nonterminal_transitions, self.includes, read_sets)
///
///         for nt, lookbacks in self.lookback.items():
///             for state, rule in lookbacks:
///                 for s in follow_sets[nt]:
///                     state.lookaheads[s].add(rule)
///
///     def compute_lalr1_states(self):
///         m = {}
///         reduce_reduce = []
///         for state in self.lr0_states:
///             actions = {la: (Shift, next_state.closure) for la, next_state in state.transitions.items()}
///             for la, rules in state.lookaheads.items():
///                 if len(rules) > 1:
///                     # Try to resolve conflict based on priority
///                     p = [(r.options.priority or 0, r) for r in rules]
///                     p.sort(key=lambda r: r[0], reverse=True)
///                     best, second_best = p[:2]
///                     if best[0] > second_best[0]:
///                         rules = [best[1]]
///                     else:
///                         reduce_reduce.append((state, la, rules))
///                         continue
///
///                 rule ,= rules
///                 if la in actions:
///                     if self.strict:
///                         raise GrammarError(f"Shift/Reduce conflict for terminal {la.name}. [strict-mode]\n ")
///                     elif self.debug:
///                         logger.warning('Shift/Reduce conflict for terminal %s: (resolving as shift)', la.name)
///                         logger.warning(' * %s', rule)
///                     else:
///                         logger.debug('Shift/Reduce conflict for terminal %s: (resolving as shift)', la.name)
///                         logger.debug(' * %s', rule)
///                 else:
///                     actions[la] = (Reduce, list(rules)[0])
///             m[state] = { k.name: v for k, v in actions.items() }
///
///         if reduce_reduce:
///             msgs = []
///             for state, la, rules in reduce_reduce:
///                 msg = 'Reduce/Reduce collision in %s between the following rules: %s' % (la, ''.join([ '\n\t- ' + str(r) for r in rules ]))
///                 if self.debug:
///                     msg += '\n    collision occurred in state: {%s\n    }' % ''.join(['\n\t' + str(x) for x in state.closure])
///                 msgs.append(msg)
///             raise GrammarError('\n\n'.join(msgs))
///
///         states = { k.closure: v for k, v in m.items() }
///
///         # compute end states
///         end_states = {}
///         for state in states:
///             for rp in state:
///                 for start in self.lr0_start_states:
///                     if rp.rule.origin.name == ('$root_' + start) and rp.is_satisfied:
///                         assert(start not in end_states)
///                         end_states[start] = state
///
///         _parse_table = ParseTable(states, { start: state.closure for start, state in self.lr0_start_states.items() }, end_states)
///
///         if self.debug:
///             self.parse_table = _parse_table
///         else:
///             self.parse_table = IntParseTable.from_ParseTable(_parse_table)
///
///     def compute_lalr(self):
///         self.compute_lr0_states()
///         self.compute_reads_relations()
///         self.compute_includes_lookback()
///         self.compute_lookaheads()
///         self.compute_lalr1_states()
/// ```
final class lalr_analysis extends PythonModule {
  lalr_analysis.from(super.pythonModule) : super.from();

  static lalr_analysis import() => PythonFfiDart.instance.importModule(
        "lark.parsers.lalr_analysis",
        lalr_analysis.from,
      );

  /// ## digraph
  ///
  /// ### python source
  /// ```py
  /// def digraph(X, R, G):
  ///     F = {}
  ///     S = []
  ///     N = dict.fromkeys(X, 0)
  ///     for x in X:
  ///         # this is always true for the first iteration, but N[x] may be updated in traverse below
  ///         if N[x] == 0:
  ///             traverse(x, S, N, X, R, G, F)
  ///     return F
  /// ```
  Object? digraph({
    required Object? X,
    required Object? R,
    required Object? G,
  }) =>
      getFunction("digraph").call(
        <Object?>[
          X,
          R,
          G,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## traverse
  ///
  /// ### python source
  /// ```py
  /// def traverse(x, S, N, X, R, G, F):
  ///     S.append(x)
  ///     d = len(S)
  ///     N[x] = d
  ///     F[x] = G[x]
  ///     for y in R[x]:
  ///         if N[y] == 0:
  ///             traverse(y, S, N, X, R, G, F)
  ///         n_x = N[x]
  ///         assert(n_x > 0)
  ///         n_y = N[y]
  ///         assert(n_y != 0)
  ///         if (n_y > 0) and (n_y < n_x):
  ///             N[x] = n_y
  ///         F[x].update(F[y])
  ///     if N[x] == d:
  ///         f_x = F[x]
  ///         while True:
  ///             z = S.pop()
  ///             N[z] = -1
  ///             F[z] = f_x
  ///             if z == x:
  ///                 break
  /// ```
  Object? traverse({
    required Object? x,
    required Object? S,
    required Object? N,
    required Object? X,
    required Object? R,
    required Object? G,
    required Object? F,
  }) =>
      getFunction("traverse").call(
        <Object?>[
          x,
          S,
          N,
          X,
          R,
          G,
          F,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## Reduce (getter)
  ///
  /// ### python docstring
  ///
  /// This module builds a LALR(1) transition-table for lalr_parser.py
  ///
  /// For now, shift/reduce conflicts are automatically resolved as shifts.
  Object? get Reduce => getAttribute("Reduce");

  /// ## Reduce (setter)
  ///
  /// ### python docstring
  ///
  /// This module builds a LALR(1) transition-table for lalr_parser.py
  ///
  /// For now, shift/reduce conflicts are automatically resolved as shifts.
  set Reduce(Object? Reduce) => setAttribute("Reduce", Reduce);

  /// ## Shift (getter)
  ///
  /// ### python docstring
  ///
  /// This module builds a LALR(1) transition-table for lalr_parser.py
  ///
  /// For now, shift/reduce conflicts are automatically resolved as shifts.
  Object? get Shift => getAttribute("Shift");

  /// ## Shift (setter)
  ///
  /// ### python docstring
  ///
  /// This module builds a LALR(1) transition-table for lalr_parser.py
  ///
  /// For now, shift/reduce conflicts are automatically resolved as shifts.
  set Shift(Object? Shift) => setAttribute("Shift", Shift);
}

/// ## lalr_interactive_parser
///
/// ### python source
/// ```py
/// # This module provides a LALR interactive parser, which is used for debugging and error handling
///
/// from typing import Iterator, List
/// from copy import copy
/// import warnings
///
/// from lark.exceptions import UnexpectedToken
/// from lark.lexer import Token, LexerThread
///
///
/// class InteractiveParser:
///     """InteractiveParser gives you advanced control over parsing and error handling when parsing with LALR.
///
///     For a simpler interface, see the ``on_error`` argument to ``Lark.parse()``.
///     """
///     def __init__(self, parser, parser_state, lexer_thread: LexerThread):
///         self.parser = parser
///         self.parser_state = parser_state
///         self.lexer_thread = lexer_thread
///         self.result = None
///
///     @property
///     def lexer_state(self) -> LexerThread:
///         warnings.warn("lexer_state will be removed in subsequent releases. Use lexer_thread instead.", DeprecationWarning)
///         return self.lexer_thread
///
///     def feed_token(self, token: Token):
///         """Feed the parser with a token, and advance it to the next state, as if it received it from the lexer.
///
///         Note that ``token`` has to be an instance of ``Token``.
///         """
///         return self.parser_state.feed_token(token, token.type == '$END')
///
///     def iter_parse(self) -> Iterator[Token]:
///         """Step through the different stages of the parse, by reading tokens from the lexer
///         and feeding them to the parser, one per iteration.
///
///         Returns an iterator of the tokens it encounters.
///
///         When the parse is over, the resulting tree can be found in ``InteractiveParser.result``.
///         """
///         for token in self.lexer_thread.lex(self.parser_state):
///             yield token
///             self.result = self.feed_token(token)
///
///     def exhaust_lexer(self) -> List[Token]:
///         """Try to feed the rest of the lexer state into the interactive parser.
///
///         Note that this modifies the instance in place and does not feed an '$END' Token
///         """
///         return list(self.iter_parse())
///
///
///     def feed_eof(self, last_token=None):
///         """Feed a '$END' Token. Borrows from 'last_token' if given."""
///         eof = Token.new_borrow_pos('$END', '', last_token) if last_token is not None else self.lexer_thread._Token('$END', '', 0, 1, 1)
///         return self.feed_token(eof)
///
///
///     def __copy__(self):
///         """Create a new interactive parser with a separate state.
///
///         Calls to feed_token() won't affect the old instance, and vice-versa.
///         """
///         return type(self)(
///             self.parser,
///             copy(self.parser_state),
///             copy(self.lexer_thread),
///         )
///
///     def copy(self):
///         return copy(self)
///
///     def __eq__(self, other):
///         if not isinstance(other, InteractiveParser):
///             return False
///
///         return self.parser_state == other.parser_state and self.lexer_thread == other.lexer_thread
///
///     def as_immutable(self):
///         """Convert to an ``ImmutableInteractiveParser``."""
///         p = copy(self)
///         return ImmutableInteractiveParser(p.parser, p.parser_state, p.lexer_thread)
///
///     def pretty(self):
///         """Print the output of ``choices()`` in a way that's easier to read."""
///         out = ["Parser choices:"]
///         for k, v in self.choices().items():
///             out.append('\t- %s -> %r' % (k, v))
///         out.append('stack size: %s' % len(self.parser_state.state_stack))
///         return '\n'.join(out)
///
///     def choices(self):
///         """Returns a dictionary of token types, matched to their action in the parser.
///
///         Only returns token types that are accepted by the current state.
///
///         Updated by ``feed_token()``.
///         """
///         return self.parser_state.parse_conf.parse_table.states[self.parser_state.position]
///
///     def accepts(self):
///         """Returns the set of possible tokens that will advance the parser into a new valid state."""
///         accepts = set()
///         for t in self.choices():
///             if t.isupper(): # is terminal?
///                 new_cursor = copy(self)
///                 try:
///                     new_cursor.feed_token(self.lexer_thread._Token(t, ''))
///                 except UnexpectedToken:
///                     pass
///                 else:
///                     accepts.add(t)
///         return accepts
///
///     def resume_parse(self):
///         """Resume automated parsing from the current state.
///         """
///         return self.parser.parse_from_state(self.parser_state, last_token=self.lexer_thread.state.last_token)
///
///
///
/// class ImmutableInteractiveParser(InteractiveParser):
///     """Same as ``InteractiveParser``, but operations create a new instance instead
///     of changing it in-place.
///     """
///
///     result = None
///
///     def __hash__(self):
///         return hash((self.parser_state, self.lexer_thread))
///
///     def feed_token(self, token):
///         c = copy(self)
///         c.result = InteractiveParser.feed_token(c, token)
///         return c
///
///     def exhaust_lexer(self):
///         """Try to feed the rest of the lexer state into the parser.
///
///         Note that this returns a new ImmutableInteractiveParser and does not feed an '$END' Token"""
///         cursor = self.as_mutable()
///         cursor.exhaust_lexer()
///         return cursor.as_immutable()
///
///     def as_mutable(self):
///         """Convert to an ``InteractiveParser``."""
///         p = copy(self)
///         return InteractiveParser(p.parser, p.parser_state, p.lexer_thread)
/// ```
final class lalr_interactive_parser extends PythonModule {
  lalr_interactive_parser.from(super.pythonModule) : super.from();

  static lalr_interactive_parser import() =>
      PythonFfiDart.instance.importModule(
        "lark.parsers.lalr_interactive_parser",
        lalr_interactive_parser.from,
      );
}

/// ## lalr_parser
///
/// ### python docstring
///
/// This module implements a LALR(1) Parser
///
/// ### python source
/// ```py
/// """This module implements a LALR(1) Parser
/// """
/// # Author: Erez Shinan (2017)
/// # Email : erezshin@gmail.com
/// from copy import deepcopy, copy
/// from typing import Dict, Any
/// from ..lexer import Token
/// from ..utils import Serialize
///
/// from .lalr_analysis import LALR_Analyzer, Shift, IntParseTable
/// from .lalr_interactive_parser import InteractiveParser
/// from lark.exceptions import UnexpectedCharacters, UnexpectedInput, UnexpectedToken
///
/// ###{standalone
///
/// class LALR_Parser(Serialize):
///     def __init__(self, parser_conf, debug=False, strict=False):
///         analysis = LALR_Analyzer(parser_conf, debug=debug, strict=strict)
///         analysis.compute_lalr()
///         callbacks = parser_conf.callbacks
///
///         self._parse_table = analysis.parse_table
///         self.parser_conf = parser_conf
///         self.parser = _Parser(analysis.parse_table, callbacks, debug)
///
///     @classmethod
///     def deserialize(cls, data, memo, callbacks, debug=False):
///         inst = cls.__new__(cls)
///         inst._parse_table = IntParseTable.deserialize(data, memo)
///         inst.parser = _Parser(inst._parse_table, callbacks, debug)
///         return inst
///
///     def serialize(self, memo: Any = None) -> Dict[str, Any]:
///         return self._parse_table.serialize(memo)
///
///     def parse_interactive(self, lexer, start):
///         return self.parser.parse(lexer, start, start_interactive=True)
///
///     def parse(self, lexer, start, on_error=None):
///         try:
///             return self.parser.parse(lexer, start)
///         except UnexpectedInput as e:
///             if on_error is None:
///                 raise
///
///             while True:
///                 if isinstance(e, UnexpectedCharacters):
///                     s = e.interactive_parser.lexer_thread.state
///                     p = s.line_ctr.char_pos
///
///                 if not on_error(e):
///                     raise e
///
///                 if isinstance(e, UnexpectedCharacters):
///                     # If user didn't change the character position, then we should
///                     if p == s.line_ctr.char_pos:
///                         s.line_ctr.feed(s.text[p:p+1])
///
///                 try:
///                     return e.interactive_parser.resume_parse()
///                 except UnexpectedToken as e2:
///                     if (isinstance(e, UnexpectedToken)
///                         and e.token.type == e2.token.type == '$END'
///                         and e.interactive_parser == e2.interactive_parser):
///                         # Prevent infinite loop
///                         raise e2
///                     e = e2
///                 except UnexpectedCharacters as e2:
///                     e = e2
///
///
/// class ParseConf:
///     __slots__ = 'parse_table', 'callbacks', 'start', 'start_state', 'end_state', 'states'
///
///     def __init__(self, parse_table, callbacks, start):
///         self.parse_table = parse_table
///
///         self.start_state = self.parse_table.start_states[start]
///         self.end_state = self.parse_table.end_states[start]
///         self.states = self.parse_table.states
///
///         self.callbacks = callbacks
///         self.start = start
///
///
/// class ParserState:
///     __slots__ = 'parse_conf', 'lexer', 'state_stack', 'value_stack'
///
///     def __init__(self, parse_conf, lexer, state_stack=None, value_stack=None):
///         self.parse_conf = parse_conf
///         self.lexer = lexer
///         self.state_stack = state_stack or [self.parse_conf.start_state]
///         self.value_stack = value_stack or []
///
///     @property
///     def position(self):
///         return self.state_stack[-1]
///
///     # Necessary for match_examples() to work
///     def __eq__(self, other):
///         if not isinstance(other, ParserState):
///             return NotImplemented
///         return len(self.state_stack) == len(other.state_stack) and self.position == other.position
///
///     def __copy__(self):
///         return type(self)(
///             self.parse_conf,
///             self.lexer, # XXX copy
///             copy(self.state_stack),
///             deepcopy(self.value_stack),
///         )
///
///     def copy(self):
///         return copy(self)
///
///     def feed_token(self, token, is_end=False):
///         state_stack = self.state_stack
///         value_stack = self.value_stack
///         states = self.parse_conf.states
///         end_state = self.parse_conf.end_state
///         callbacks = self.parse_conf.callbacks
///
///         while True:
///             state = state_stack[-1]
///             try:
///                 action, arg = states[state][token.type]
///             except KeyError:
///                 expected = {s for s in states[state].keys() if s.isupper()}
///                 raise UnexpectedToken(token, expected, state=self, interactive_parser=None)
///
///             assert arg != end_state
///
///             if action is Shift:
///                 # shift once and return
///                 assert not is_end
///                 state_stack.append(arg)
///                 value_stack.append(token if token.type not in callbacks else callbacks[token.type](token))
///                 return
///             else:
///                 # reduce+shift as many times as necessary
///                 rule = arg
///                 size = len(rule.expansion)
///                 if size:
///                     s = value_stack[-size:]
///                     del state_stack[-size:]
///                     del value_stack[-size:]
///                 else:
///                     s = []
///
///                 value = callbacks[rule](s)
///
///                 _action, new_state = states[state_stack[-1]][rule.origin.name]
///                 assert _action is Shift
///                 state_stack.append(new_state)
///                 value_stack.append(value)
///
///                 if is_end and state_stack[-1] == end_state:
///                     return value_stack[-1]
///
/// class _Parser:
///     def __init__(self, parse_table, callbacks, debug=False):
///         self.parse_table = parse_table
///         self.callbacks = callbacks
///         self.debug = debug
///
///     def parse(self, lexer, start, value_stack=None, state_stack=None, start_interactive=False):
///         parse_conf = ParseConf(self.parse_table, self.callbacks, start)
///         parser_state = ParserState(parse_conf, lexer, state_stack, value_stack)
///         if start_interactive:
///             return InteractiveParser(self, parser_state, parser_state.lexer)
///         return self.parse_from_state(parser_state)
///
///
///     def parse_from_state(self, state, last_token=None):
///         """Run the main LALR parser loop
///
///         Parameters:
///             state (ParseState) - the initial state. Changed in-place.
///             last_token (optional, Token) - Used only for line information in case of an empty lexer.
///         """
///         try:
///             token = last_token
///             for token in state.lexer.lex(state):
///                 state.feed_token(token)
///
///             end_token = Token.new_borrow_pos('$END', '', token) if token else Token('$END', '', 0, 1, 1)
///             return state.feed_token(end_token, True)
///         except UnexpectedInput as e:
///             try:
///                 e.interactive_parser = InteractiveParser(self, state, state.lexer)
///             except NameError:
///                 pass
///             raise e
///         except Exception as e:
///             if self.debug:
///                 print("")
///                 print("STATE STACK DUMP")
///                 print("----------------")
///                 for i, s in enumerate(state.state_stack):
///                     print('%d)' % i , s)
///                 print("")
///
///             raise
/// ###}
/// ```
final class lalr_parser extends PythonModule {
  lalr_parser.from(super.pythonModule) : super.from();

  static lalr_parser import() => PythonFfiDart.instance.importModule(
        "lark.parsers.lalr_parser",
        lalr_parser.from,
      );
}

/// ## xearley
///
/// ### python docstring
///
/// This module implements an experimental Earley parser with a dynamic lexer
///
/// The core Earley algorithm used here is based on Elizabeth Scott's implementation, here:
///     https://www.sciencedirect.com/science/article/pii/S1571066108001497
///
/// That is probably the best reference for understanding the algorithm here.
///
/// The Earley parser outputs an SPPF-tree as per that document. The SPPF tree format
/// is better documented here:
///     http://www.bramvandersanden.com/post/2014/06/shared-packed-parse-forest/
///
/// Instead of running a lexer beforehand, or using a costy char-by-char method, this parser
/// uses regular expressions by necessity, achieving high-performance while maintaining all of
/// Earley's power in parsing any CFG.
///
/// ### python source
/// ```py
/// """This module implements an experimental Earley parser with a dynamic lexer
///
/// The core Earley algorithm used here is based on Elizabeth Scott's implementation, here:
///     https://www.sciencedirect.com/science/article/pii/S1571066108001497
///
/// That is probably the best reference for understanding the algorithm here.
///
/// The Earley parser outputs an SPPF-tree as per that document. The SPPF tree format
/// is better documented here:
///     http://www.bramvandersanden.com/post/2014/06/shared-packed-parse-forest/
///
/// Instead of running a lexer beforehand, or using a costy char-by-char method, this parser
/// uses regular expressions by necessity, achieving high-performance while maintaining all of
/// Earley's power in parsing any CFG.
/// """
///
/// from collections import defaultdict
///
/// from ..tree import Tree
/// from ..exceptions import UnexpectedCharacters
/// from ..lexer import Token
/// from ..grammar import Terminal
/// from .earley import Parser as BaseParser
/// from .earley_forest import SymbolNode, TokenNode
///
///
/// class Parser(BaseParser):
///     def __init__(self, lexer_conf, parser_conf, term_matcher, resolve_ambiguity=True, complete_lex = False, debug=False, tree_class=Tree):
///         BaseParser.__init__(self, lexer_conf, parser_conf, term_matcher, resolve_ambiguity, debug, tree_class)
///         self.ignore = [Terminal(t) for t in lexer_conf.ignore]
///         self.complete_lex = complete_lex
///
///     def _parse(self, stream, columns, to_scan, start_symbol=None):
///
///         def scan(i, to_scan):
///             """The core Earley Scanner.
///
///             This is a custom implementation of the scanner that uses the
///             Lark lexer to match tokens. The scan list is built by the
///             Earley predictor, based on the previously completed tokens.
///             This ensures that at each phase of the parse we have a custom
///             lexer context, allowing for more complex ambiguities."""
///
///             node_cache = {}
///
///             # 1) Loop the expectations and ask the lexer to match.
///             # Since regexp is forward looking on the input stream, and we only
///             # want to process tokens when we hit the point in the stream at which
///             # they complete, we push all tokens into a buffer (delayed_matches), to
///             # be held possibly for a later parse step when we reach the point in the
///             # input stream at which they complete.
///             for item in set(to_scan):
///                 m = match(item.expect, stream, i)
///                 if m:
///                     t = Token(item.expect.name, m.group(0), i, text_line, text_column)
///                     delayed_matches[m.end()].append( (item, i, t) )
///
///                     if self.complete_lex:
///                         s = m.group(0)
///                         for j in range(1, len(s)):
///                             m = match(item.expect, s[:-j])
///                             if m:
///                                 t = Token(item.expect.name, m.group(0), i, text_line, text_column)
///                                 delayed_matches[i+m.end()].append( (item, i, t) )
///
///                     # XXX The following 3 lines were commented out for causing a bug. See issue #768
///                     # # Remove any items that successfully matched in this pass from the to_scan buffer.
///                     # # This ensures we don't carry over tokens that already matched, if we're ignoring below.
///                     # to_scan.remove(item)
///
///             # 3) Process any ignores. This is typically used for e.g. whitespace.
///             # We carry over any unmatched items from the to_scan buffer to be matched again after
///             # the ignore. This should allow us to use ignored symbols in non-terminals to implement
///             # e.g. mandatory spacing.
///             for x in self.ignore:
///                 m = match(x, stream, i)
///                 if m:
///                     # Carry over any items still in the scan buffer, to past the end of the ignored items.
///                     delayed_matches[m.end()].extend([(item, i, None) for item in to_scan ])
///
///                     # If we're ignoring up to the end of the file, # carry over the start symbol if it already completed.
///                     delayed_matches[m.end()].extend([(item, i, None) for item in columns[i] if item.is_complete and item.s == start_symbol])
///
///             next_to_scan = set()
///             next_set = set()
///             columns.append(next_set)
///             transitives.append({})
///
///             ## 4) Process Tokens from delayed_matches.
///             # This is the core of the Earley scanner. Create an SPPF node for each Token,
///             # and create the symbol node in the SPPF tree. Advance the item that completed,
///             # and add the resulting new item to either the Earley set (for processing by the
///             # completer/predictor) or the to_scan buffer for the next parse step.
///             for item, start, token in delayed_matches[i+1]:
///                 if token is not None:
///                     token.end_line = text_line
///                     token.end_column = text_column + 1
///                     token.end_pos = i + 1
///
///                     new_item = item.advance()
///                     label = (new_item.s, new_item.start, i)
///                     token_node = TokenNode(token, terminals[token.type])
///                     new_item.node = node_cache[label] if label in node_cache else node_cache.setdefault(label, SymbolNode(*label))
///                     new_item.node.add_family(new_item.s, item.rule, new_item.start, item.node, token_node)
///                 else:
///                     new_item = item
///
///                 if new_item.expect in self.TERMINALS:
///                     # add (B ::= Aai+1.B, h, y) to Q'
///                     next_to_scan.add(new_item)
///                 else:
///                     # add (B ::= Aa+1.B, h, y) to Ei+1
///                     next_set.add(new_item)
///
///             del delayed_matches[i+1]    # No longer needed, so unburden memory
///
///             if not next_set and not delayed_matches and not next_to_scan:
///                 considered_rules = list(sorted(to_scan, key=lambda key: key.rule.origin.name))
///                 raise UnexpectedCharacters(stream, i, text_line, text_column, {item.expect.name for item in to_scan},
///                                            set(to_scan), state=frozenset(i.s for i in to_scan),
///                                            considered_rules=considered_rules
///                                            )
///
///             return next_to_scan
///
///
///         delayed_matches = defaultdict(list)
///         match = self.term_matcher
///         terminals = self.lexer_conf.terminals_by_name
///
///         # Cache for nodes & tokens created in a particular parse step.
///         transitives = [{}]
///
///         text_line = 1
///         text_column = 1
///
///         ## The main Earley loop.
///         # Run the Prediction/Completion cycle for any Items in the current Earley set.
///         # Completions will be added to the SPPF tree, and predictions will be recursively
///         # processed down to terminals/empty nodes to be added to the scanner for the next
///         # step.
///         i = 0
///         for token in stream:
///             self.predict_and_complete(i, to_scan, columns, transitives)
///
///             to_scan = scan(i, to_scan)
///
///             if token == '\n':
///                 text_line += 1
///                 text_column = 1
///             else:
///                 text_column += 1
///             i += 1
///
///         self.predict_and_complete(i, to_scan, columns, transitives)
///
///         ## Column is now the final column in the parse.
///         assert i == len(columns)-1
///         return to_scan
/// ```
final class xearley extends PythonModule {
  xearley.from(super.pythonModule) : super.from();

  static xearley import() => PythonFfiDart.instance.importModule(
        "lark.parsers.xearley",
        xearley.from,
      );
}
