// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library xearley;

import "package:python_ffi/python_ffi.dart";

/// ## BaseParser
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
final class BaseParser extends PythonClass {
  factory BaseParser({
    required Object? lexer_conf,
    required Object? parser_conf,
    required Object? term_matcher,
    Object? resolve_ambiguity = true,
    Object? debug = false,
    Object? tree_class,
  }) =>
      PythonFfi.instance.importClass(
        "lark.parsers.xearley",
        "BaseParser",
        BaseParser.from,
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

  BaseParser.from(super.pythonClass) : super.from();

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

/// ## Parser
///
/// ### python source
/// ```py
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
final class Parser extends PythonClass {
  factory Parser({
    required Object? lexer_conf,
    required Object? parser_conf,
    required Object? term_matcher,
    Object? resolve_ambiguity = true,
    Object? complete_lex = false,
    Object? debug = false,
    Object? tree_class,
  }) =>
      PythonFfi.instance.importClass(
        "lark.parsers.xearley",
        "Parser",
        Parser.from,
        <Object?>[
          lexer_conf,
          parser_conf,
          term_matcher,
          resolve_ambiguity,
          complete_lex,
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

  /// ## ignore (getter)
  Object? get ignore => getAttribute("ignore");

  /// ## ignore (setter)
  set ignore(Object? ignore) => setAttribute("ignore", ignore);

  /// ## complete_lex (getter)
  Object? get complete_lex => getAttribute("complete_lex");

  /// ## complete_lex (setter)
  set complete_lex(Object? complete_lex) =>
      setAttribute("complete_lex", complete_lex);
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
        "lark.parsers.xearley",
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
        "lark.parsers.xearley",
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
        "lark.parsers.xearley",
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
        "lark.parsers.xearley",
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
        "lark.parsers.xearley",
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
      PythonFfi.instance.importClass(
        "lark.parsers.xearley",
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

  static xearley import() => PythonFfi.instance.importModule(
        "lark.parsers.xearley",
        xearley.from,
      );
}
