// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library lalr_analysis;

import "package:python_ffi_dart/python_ffi_dart.dart";

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
      PythonFfiDart.instance.importClass(
        "lark.grammar",
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
      PythonFfiDart.instance.importClass(
        "lark.grammar",
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
