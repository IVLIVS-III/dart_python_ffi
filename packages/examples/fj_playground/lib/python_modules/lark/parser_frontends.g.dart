// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library parser_frontends;

import "package:python_ffi/python_ffi.dart";

/// ## BasicLexer
///
/// ### python docstring
///
/// Lexer interface
///
/// Method Signatures:
///     lex(self, lexer_state, parser_state) -> Iterator[Token]
///
/// ### python source
/// ```py
/// class BasicLexer(Lexer):
///     terminals: Collection[TerminalDef]
///     ignore_types: FrozenSet[str]
///     newline_types: FrozenSet[str]
///     user_callbacks: Dict[str, _Callback]
///     callback: Dict[str, _Callback]
///     re: ModuleType
///
///     def __init__(self, conf: 'LexerConf', comparator=None) -> None:
///         terminals = list(conf.terminals)
///         assert all(isinstance(t, TerminalDef) for t in terminals), terminals
///
///         self.re = conf.re_module
///
///         if not conf.skip_validation:
///             # Sanitization
///             terminal_to_regexp = {}
///             for t in terminals:
///                 regexp = t.pattern.to_regexp()
///                 try:
///                     self.re.compile(regexp, conf.g_regex_flags)
///                 except self.re.error:
///                     raise LexError("Cannot compile token %s: %s" % (t.name, t.pattern))
///
///                 if t.pattern.min_width == 0:
///                     raise LexError("Lexer does not allow zero-width terminals. (%s: %s)" % (t.name, t.pattern))
///                 if t.pattern.type == "re":
///                     terminal_to_regexp[t] = regexp
///
///             if not (set(conf.ignore) <= {t.name for t in terminals}):
///                 raise LexError("Ignore terminals are not defined: %s" % (set(conf.ignore) - {t.name for t in terminals}))
///
///             if has_interegular:
///                 _check_regex_collisions(terminal_to_regexp, comparator, conf.strict)
///             elif conf.strict:
///                 raise LexError("interegular must be installed for strict mode. Use `pip install 'lark[interegular]'`.")
///
///         # Init
///         self.newline_types = frozenset(t.name for t in terminals if _regexp_has_newline(t.pattern.to_regexp()))
///         self.ignore_types = frozenset(conf.ignore)
///
///         terminals.sort(key=lambda x: (-x.priority, -x.pattern.max_width, -len(x.pattern.value), x.name))
///         self.terminals = terminals
///         self.user_callbacks = conf.callbacks
///         self.g_regex_flags = conf.g_regex_flags
///         self.use_bytes = conf.use_bytes
///         self.terminals_by_name = conf.terminals_by_name
///
///         self._scanner = None
///
///     def _build_scanner(self):
///         terminals, self.callback = _create_unless(self.terminals, self.g_regex_flags, self.re, self.use_bytes)
///         assert all(self.callback.values())
///
///         for type_, f in self.user_callbacks.items():
///             if type_ in self.callback:
///                 # Already a callback there, probably UnlessCallback
///                 self.callback[type_] = CallChain(self.callback[type_], f, lambda t: t.type == type_)
///             else:
///                 self.callback[type_] = f
///
///         self._scanner = Scanner(terminals, self.g_regex_flags, self.re, self.use_bytes)
///
///     @property
///     def scanner(self):
///         if self._scanner is None:
///             self._build_scanner()
///         return self._scanner
///
///     def match(self, text, pos):
///         return self.scanner.match(text, pos)
///
///     def lex(self, state: LexerState, parser_state: Any) -> Iterator[Token]:
///         with suppress(EOFError):
///             while True:
///                 yield self.next_token(state, parser_state)
///
///     def next_token(self, lex_state: LexerState, parser_state: Any = None) -> Token:
///         line_ctr = lex_state.line_ctr
///         while line_ctr.char_pos < len(lex_state.text):
///             res = self.match(lex_state.text, line_ctr.char_pos)
///             if not res:
///                 allowed = self.scanner.allowed_types - self.ignore_types
///                 if not allowed:
///                     allowed = {"<END-OF-FILE>"}
///                 raise UnexpectedCharacters(lex_state.text, line_ctr.char_pos, line_ctr.line, line_ctr.column,
///                                            allowed=allowed, token_history=lex_state.last_token and [lex_state.last_token],
///                                            state=parser_state, terminals_by_name=self.terminals_by_name)
///
///             value, type_ = res
///
///             if type_ not in self.ignore_types:
///                 t = Token(type_, value, line_ctr.char_pos, line_ctr.line, line_ctr.column)
///                 line_ctr.feed(value, type_ in self.newline_types)
///                 t.end_line = line_ctr.line
///                 t.end_column = line_ctr.column
///                 t.end_pos = line_ctr.char_pos
///                 if t.type in self.callback:
///                     t = self.callback[t.type](t)
///                     if not isinstance(t, Token):
///                         raise LexError("Callbacks must return a token (returned %r)" % t)
///                 lex_state.last_token = t
///                 return t
///             else:
///                 if type_ in self.callback:
///                     t2 = Token(type_, value, line_ctr.char_pos, line_ctr.line, line_ctr.column)
///                     self.callback[type_](t2)
///                 line_ctr.feed(value, type_ in self.newline_types)
///
///         # EOF
///         raise EOFError(self)
/// ```
final class BasicLexer extends PythonClass {
  factory BasicLexer({
    required Object? conf,
    Object? comparator,
  }) =>
      PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "BasicLexer",
        BasicLexer.from,
        <Object?>[
          conf,
          comparator,
        ],
        <String, Object?>{},
      );

  BasicLexer.from(super.pythonClass) : super.from();

  /// ## lex
  ///
  /// ### python source
  /// ```py
  /// def lex(self, state: LexerState, parser_state: Any) -> Iterator[Token]:
  ///         with suppress(EOFError):
  ///             while True:
  ///                 yield self.next_token(state, parser_state)
  /// ```
  Iterator<Token> lex({
    required Object? state,
    required Object? parser_state,
  }) =>
      TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("lex").call(
            <Object?>[
              state,
              parser_state,
            ],
            kwargs: <String, Object?>{},
          ),
        ),
      )
          .transform((e) => Token.from(
                e,
              ))
          .cast<Token>();

  /// ## make_lexer_state
  ///
  /// ### python docstring
  ///
  /// Deprecated
  ///
  /// ### python source
  /// ```py
  /// def make_lexer_state(self, text):
  ///         "Deprecated"
  ///         return LexerState(text)
  /// ```
  Object? make_lexer_state({
    required Object? text,
  }) =>
      getFunction("make_lexer_state").call(
        <Object?>[
          text,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## match
  ///
  /// ### python source
  /// ```py
  /// def match(self, text, pos):
  ///         return self.scanner.match(text, pos)
  /// ```
  Object? match({
    required Object? text,
    required Object? pos,
  }) =>
      getFunction("match").call(
        <Object?>[
          text,
          pos,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## next_token
  ///
  /// ### python source
  /// ```py
  /// def next_token(self, lex_state: LexerState, parser_state: Any = None) -> Token:
  ///         line_ctr = lex_state.line_ctr
  ///         while line_ctr.char_pos < len(lex_state.text):
  ///             res = self.match(lex_state.text, line_ctr.char_pos)
  ///             if not res:
  ///                 allowed = self.scanner.allowed_types - self.ignore_types
  ///                 if not allowed:
  ///                     allowed = {"<END-OF-FILE>"}
  ///                 raise UnexpectedCharacters(lex_state.text, line_ctr.char_pos, line_ctr.line, line_ctr.column,
  ///                                            allowed=allowed, token_history=lex_state.last_token and [lex_state.last_token],
  ///                                            state=parser_state, terminals_by_name=self.terminals_by_name)
  ///
  ///             value, type_ = res
  ///
  ///             if type_ not in self.ignore_types:
  ///                 t = Token(type_, value, line_ctr.char_pos, line_ctr.line, line_ctr.column)
  ///                 line_ctr.feed(value, type_ in self.newline_types)
  ///                 t.end_line = line_ctr.line
  ///                 t.end_column = line_ctr.column
  ///                 t.end_pos = line_ctr.char_pos
  ///                 if t.type in self.callback:
  ///                     t = self.callback[t.type](t)
  ///                     if not isinstance(t, Token):
  ///                         raise LexError("Callbacks must return a token (returned %r)" % t)
  ///                 lex_state.last_token = t
  ///                 return t
  ///             else:
  ///                 if type_ in self.callback:
  ///                     t2 = Token(type_, value, line_ctr.char_pos, line_ctr.line, line_ctr.column)
  ///                     self.callback[type_](t2)
  ///                 line_ctr.feed(value, type_ in self.newline_types)
  ///
  ///         # EOF
  ///         raise EOFError(self)
  /// ```
  Token next_token({
    required Object? lex_state,
    Object? parser_state,
  }) =>
      Token.from(
        getFunction("next_token").call(
          <Object?>[
            lex_state,
            parser_state,
          ],
          kwargs: <String, Object?>{},
        ),
      );

  /// ## scanner (getter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  Object? get scanner => getAttribute("scanner");

  /// ## scanner (setter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  set scanner(Object? scanner) => setAttribute("scanner", scanner);

  /// ## terminals (getter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  Object? get terminals => getAttribute("terminals");

  /// ## terminals (setter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  set terminals(Object? terminals) => setAttribute("terminals", terminals);

  /// ## re (getter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  Object? get re => getAttribute("re");

  /// ## re (setter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  set re(Object? re) => setAttribute("re", re);

  /// ## g_regex_flags (getter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  Object? get g_regex_flags => getAttribute("g_regex_flags");

  /// ## g_regex_flags (setter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  set g_regex_flags(Object? g_regex_flags) =>
      setAttribute("g_regex_flags", g_regex_flags);

  /// ## newline_types (getter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  Object? get newline_types => getAttribute("newline_types");

  /// ## newline_types (setter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  set newline_types(Object? newline_types) =>
      setAttribute("newline_types", newline_types);

  /// ## ignore_types (getter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  Object? get ignore_types => getAttribute("ignore_types");

  /// ## ignore_types (setter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  set ignore_types(Object? ignore_types) =>
      setAttribute("ignore_types", ignore_types);

  /// ## user_callbacks (getter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  Object? get user_callbacks => getAttribute("user_callbacks");

  /// ## user_callbacks (setter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  set user_callbacks(Object? user_callbacks) =>
      setAttribute("user_callbacks", user_callbacks);

  /// ## use_bytes (getter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  Object? get use_bytes => getAttribute("use_bytes");

  /// ## use_bytes (setter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  set use_bytes(Object? use_bytes) => setAttribute("use_bytes", use_bytes);

  /// ## terminals_by_name (getter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  Object? get terminals_by_name => getAttribute("terminals_by_name");

  /// ## terminals_by_name (setter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  set terminals_by_name(Object? terminals_by_name) =>
      setAttribute("terminals_by_name", terminals_by_name);
}

/// ## CYK_FrontEnd
///
/// ### python source
/// ```py
/// class CYK_FrontEnd:
///     def __init__(self, lexer_conf, parser_conf, options=None):
///         self._analysis = GrammarAnalyzer(parser_conf)
///         self.parser = cyk.Parser(parser_conf.rules)
///
///         self.callbacks = parser_conf.callbacks
///
///     def parse(self, lexer_thread, start):
///         tokens = list(lexer_thread.lex(None))
///         tree = self.parser.parse(tokens, start)
///         return self._transform(tree)
///
///     def _transform(self, tree):
///         subtrees = list(tree.iter_subtrees())
///         for subtree in subtrees:
///             subtree.children = [self._apply_callback(c) if isinstance(c, Tree) else c for c in subtree.children]
///
///         return self._apply_callback(tree)
///
///     def _apply_callback(self, tree):
///         return self.callbacks[tree.rule](tree.children)
/// ```
final class CYK_FrontEnd extends PythonClass {
  factory CYK_FrontEnd({
    required Object? lexer_conf,
    required Object? parser_conf,
    Object? options,
  }) =>
      PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "CYK_FrontEnd",
        CYK_FrontEnd.from,
        <Object?>[
          lexer_conf,
          parser_conf,
          options,
        ],
        <String, Object?>{},
      );

  CYK_FrontEnd.from(super.pythonClass) : super.from();

  /// ## parse
  ///
  /// ### python source
  /// ```py
  /// def parse(self, lexer_thread, start):
  ///         tokens = list(lexer_thread.lex(None))
  ///         tree = self.parser.parse(tokens, start)
  ///         return self._transform(tree)
  /// ```
  Object? parse({
    required Object? lexer_thread,
    required Object? start,
  }) =>
      getFunction("parse").call(
        <Object?>[
          lexer_thread,
          start,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## parser (getter)
  Object? get parser => getAttribute("parser");

  /// ## parser (setter)
  set parser(Object? parser) => setAttribute("parser", parser);

  /// ## callbacks (getter)
  Object? get callbacks => getAttribute("callbacks");

  /// ## callbacks (setter)
  set callbacks(Object? callbacks) => setAttribute("callbacks", callbacks);
}

/// ## ConfigurationError
///
/// ### python source
/// ```py
/// class ConfigurationError(LarkError, ValueError):
///     pass
/// ```
final class ConfigurationError extends PythonClass {
  factory ConfigurationError() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "ConfigurationError",
        ConfigurationError.from,
        <Object?>[],
      );

  ConfigurationError.from(super.pythonClass) : super.from();

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

/// ## ContextualLexer
///
/// ### python docstring
///
/// Lexer interface
///
/// Method Signatures:
///     lex(self, lexer_state, parser_state) -> Iterator[Token]
///
/// ### python source
/// ```py
/// class ContextualLexer(Lexer):
///
///     lexers: Dict[str, BasicLexer]
///     root_lexer: BasicLexer
///
///     def __init__(self, conf: 'LexerConf', states: Dict[str, Collection[str]], always_accept: Collection[str]=()) -> None:
///         terminals = list(conf.terminals)
///         terminals_by_name = conf.terminals_by_name
///
///         trad_conf = copy(conf)
///         trad_conf.terminals = terminals
///
///         if has_interegular and not conf.skip_validation:
///             comparator = interegular.Comparator.from_regexes({t: t.pattern.to_regexp() for t in terminals})
///         else:
///             comparator = None
///         lexer_by_tokens: Dict[FrozenSet[str], BasicLexer] = {}
///         self.lexers = {}
///         for state, accepts in states.items():
///             key = frozenset(accepts)
///             try:
///                 lexer = lexer_by_tokens[key]
///             except KeyError:
///                 accepts = set(accepts) | set(conf.ignore) | set(always_accept)
///                 lexer_conf = copy(trad_conf)
///                 lexer_conf.terminals = [terminals_by_name[n] for n in accepts if n in terminals_by_name]
///                 lexer = BasicLexer(lexer_conf, comparator)
///                 lexer_by_tokens[key] = lexer
///
///             self.lexers[state] = lexer
///
///         assert trad_conf.terminals is terminals
///         trad_conf.skip_validation = True  # We don't need to verify all terminals again
///         self.root_lexer = BasicLexer(trad_conf, comparator)
///
///     def lex(self, lexer_state: LexerState, parser_state: Any) -> Iterator[Token]:
///         try:
///             while True:
///                 lexer = self.lexers[parser_state.position]
///                 yield lexer.next_token(lexer_state, parser_state)
///         except EOFError:
///             pass
///         except UnexpectedCharacters as e:
///             # In the contextual lexer, UnexpectedCharacters can mean that the terminal is defined, but not in the current context.
///             # This tests the input against the global context, to provide a nicer error.
///             try:
///                 last_token = lexer_state.last_token  # Save last_token. Calling root_lexer.next_token will change this to the wrong token
///                 token = self.root_lexer.next_token(lexer_state, parser_state)
///                 raise UnexpectedToken(token, e.allowed, state=parser_state, token_history=[last_token], terminals_by_name=self.root_lexer.terminals_by_name)
///             except UnexpectedCharacters:
///                 raise e  # Raise the original UnexpectedCharacters. The root lexer raises it with the wrong expected set.
/// ```
final class ContextualLexer extends PythonClass {
  factory ContextualLexer({
    required Object? conf,
    required Object? states,
    Object? always_accept = const [],
  }) =>
      PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "ContextualLexer",
        ContextualLexer.from,
        <Object?>[
          conf,
          states,
          always_accept,
        ],
        <String, Object?>{},
      );

  ContextualLexer.from(super.pythonClass) : super.from();

  /// ## lex
  ///
  /// ### python source
  /// ```py
  /// def lex(self, lexer_state: LexerState, parser_state: Any) -> Iterator[Token]:
  ///         try:
  ///             while True:
  ///                 lexer = self.lexers[parser_state.position]
  ///                 yield lexer.next_token(lexer_state, parser_state)
  ///         except EOFError:
  ///             pass
  ///         except UnexpectedCharacters as e:
  ///             # In the contextual lexer, UnexpectedCharacters can mean that the terminal is defined, but not in the current context.
  ///             # This tests the input against the global context, to provide a nicer error.
  ///             try:
  ///                 last_token = lexer_state.last_token  # Save last_token. Calling root_lexer.next_token will change this to the wrong token
  ///                 token = self.root_lexer.next_token(lexer_state, parser_state)
  ///                 raise UnexpectedToken(token, e.allowed, state=parser_state, token_history=[last_token], terminals_by_name=self.root_lexer.terminals_by_name)
  ///             except UnexpectedCharacters:
  ///                 raise e  # Raise the original UnexpectedCharacters. The root lexer raises it with the wrong expected set.
  /// ```
  Iterator<Token> lex({
    required Object? lexer_state,
    required Object? parser_state,
  }) =>
      TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("lex").call(
            <Object?>[
              lexer_state,
              parser_state,
            ],
            kwargs: <String, Object?>{},
          ),
        ),
      )
          .transform((e) => Token.from(
                e,
              ))
          .cast<Token>();

  /// ## make_lexer_state
  ///
  /// ### python docstring
  ///
  /// Deprecated
  ///
  /// ### python source
  /// ```py
  /// def make_lexer_state(self, text):
  ///         "Deprecated"
  ///         return LexerState(text)
  /// ```
  Object? make_lexer_state({
    required Object? text,
  }) =>
      getFunction("make_lexer_state").call(
        <Object?>[
          text,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## lexers (getter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  Object? get lexers => getAttribute("lexers");

  /// ## lexers (setter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  set lexers(Object? lexers) => setAttribute("lexers", lexers);

  /// ## root_lexer (getter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  Object? get root_lexer => getAttribute("root_lexer");

  /// ## root_lexer (setter)
  ///
  /// ### python docstring
  ///
  /// Lexer interface
  ///
  /// Method Signatures:
  ///     lex(self, lexer_state, parser_state) -> Iterator[Token]
  set root_lexer(Object? root_lexer) => setAttribute("root_lexer", root_lexer);
}

/// ## EarleyRegexpMatcher
///
/// ### python source
/// ```py
/// class EarleyRegexpMatcher:
///     def __init__(self, lexer_conf):
///         self.regexps = {}
///         for t in lexer_conf.terminals:
///             regexp = t.pattern.to_regexp()
///             try:
///                 width = get_regexp_width(regexp)[0]
///             except ValueError:
///                 raise GrammarError("Bad regexp in token %s: %s" % (t.name, regexp))
///             else:
///                 if width == 0:
///                     raise GrammarError("Dynamic Earley doesn't allow zero-width regexps", t)
///             if lexer_conf.use_bytes:
///                 regexp = regexp.encode('utf-8')
///
///             self.regexps[t.name] = lexer_conf.re_module.compile(regexp, lexer_conf.g_regex_flags)
///
///     def match(self, term, text, index=0):
///         return self.regexps[term.name].match(text, index)
/// ```
final class EarleyRegexpMatcher extends PythonClass {
  factory EarleyRegexpMatcher({
    required Object? lexer_conf,
  }) =>
      PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "EarleyRegexpMatcher",
        EarleyRegexpMatcher.from,
        <Object?>[
          lexer_conf,
        ],
        <String, Object?>{},
      );

  EarleyRegexpMatcher.from(super.pythonClass) : super.from();

  /// ## match
  ///
  /// ### python source
  /// ```py
  /// def match(self, term, text, index=0):
  ///         return self.regexps[term.name].match(text, index)
  /// ```
  Object? match({
    required Object? term,
    required Object? text,
    Object? index = 0,
  }) =>
      getFunction("match").call(
        <Object?>[
          term,
          text,
          index,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## regexps (getter)
  Object? get regexps => getAttribute("regexps");

  /// ## regexps (setter)
  set regexps(Object? regexps) => setAttribute("regexps", regexps);
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
        "lark.parser_frontends",
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
        "lark.parser_frontends",
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
      PythonFfi.instance.importClass(
        "lark.parser_frontends",
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

/// ## Lexer
///
/// ### python docstring
///
/// Lexer interface
///
/// Method Signatures:
///     lex(self, lexer_state, parser_state) -> Iterator[Token]
///
/// ### python source
/// ```py
/// class Lexer(ABC):
///     """Lexer interface
///
///     Method Signatures:
///         lex(self, lexer_state, parser_state) -> Iterator[Token]
///     """
///     @abstractmethod
///     def lex(self, lexer_state: LexerState, parser_state: Any) -> Iterator[Token]:
///         return NotImplemented
///
///     def make_lexer_state(self, text):
///         "Deprecated"
///         return LexerState(text)
/// ```
final class Lexer extends PythonClass {
  factory Lexer() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "Lexer",
        Lexer.from,
        <Object?>[],
      );

  Lexer.from(super.pythonClass) : super.from();

  /// ## lex
  ///
  /// ### python source
  /// ```py
  /// @abstractmethod
  ///     def lex(self, lexer_state: LexerState, parser_state: Any) -> Iterator[Token]:
  ///         return NotImplemented
  /// ```
  Iterator<Token> lex({
    required Object? lexer_state,
    required Object? parser_state,
  }) =>
      TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("lex").call(
            <Object?>[
              lexer_state,
              parser_state,
            ],
            kwargs: <String, Object?>{},
          ),
        ),
      )
          .transform((e) => Token.from(
                e,
              ))
          .cast<Token>();

  /// ## make_lexer_state
  ///
  /// ### python docstring
  ///
  /// Deprecated
  ///
  /// ### python source
  /// ```py
  /// def make_lexer_state(self, text):
  ///         "Deprecated"
  ///         return LexerState(text)
  /// ```
  Object? make_lexer_state({
    required Object? text,
  }) =>
      getFunction("make_lexer_state").call(
        <Object?>[
          text,
        ],
        kwargs: <String, Object?>{},
      );
}

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
  factory LexerConf({
    required Object? terminals,
    required Object? re_module,
    Object? ignore = const [],
    Object? postlex,
    Object? callbacks,
    int g_regex_flags = 0,
    bool skip_validation = false,
    bool use_bytes = false,
    bool strict = false,
  }) =>
      PythonFfi.instance.importClass(
        "lark.parser_frontends",
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
        <String, Object?>{},
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
  Object? get terminals => getAttribute("terminals");

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
  set terminals(Object? terminals) => setAttribute("terminals", terminals);

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
  Object? get terminals_by_name => getAttribute("terminals_by_name");

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
  set terminals_by_name(Object? terminals_by_name) =>
      setAttribute("terminals_by_name", terminals_by_name);

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
  Object? get ignore => getAttribute("ignore");

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
  set ignore(Object? ignore) => setAttribute("ignore", ignore);

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
  Object? get postlex => getAttribute("postlex");

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
  set postlex(Object? postlex) => setAttribute("postlex", postlex);

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
  Object? get g_regex_flags => getAttribute("g_regex_flags");

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
  set g_regex_flags(Object? g_regex_flags) =>
      setAttribute("g_regex_flags", g_regex_flags);

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
  Object? get re_module => getAttribute("re_module");

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
  set re_module(Object? re_module) => setAttribute("re_module", re_module);

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
  Object? get skip_validation => getAttribute("skip_validation");

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
  set skip_validation(Object? skip_validation) =>
      setAttribute("skip_validation", skip_validation);

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
  Object? get use_bytes => getAttribute("use_bytes");

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
  set use_bytes(Object? use_bytes) => setAttribute("use_bytes", use_bytes);

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
  Object? get strict => getAttribute("strict");

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
  set strict(Object? strict) => setAttribute("strict", strict);

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
  Object? get lexer_type => getAttribute("lexer_type");

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
  set lexer_type(Object? lexer_type) => setAttribute("lexer_type", lexer_type);
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
      PythonFfi.instance.importClass(
        "lark.parser_frontends",
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
        "lark.parser_frontends",
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

/// ## ParsingFrontend
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
/// class ParsingFrontend(Serialize):
///     __serialize_fields__ = 'lexer_conf', 'parser_conf', 'parser'
///
///     lexer_conf: LexerConf
///     parser_conf: ParserConf
///     options: Any
///
///     def __init__(self, lexer_conf: LexerConf, parser_conf: ParserConf, options, parser=None):
///         self.parser_conf = parser_conf
///         self.lexer_conf = lexer_conf
///         self.options = options
///
///         # Set-up parser
///         if parser:  # From cache
///             self.parser = parser
///         else:
///             create_parser = _parser_creators.get(parser_conf.parser_type)
///             assert create_parser is not None, "{} is not supported in standalone mode".format(
///                     parser_conf.parser_type
///                 )
///             self.parser = create_parser(lexer_conf, parser_conf, options)
///
///         # Set-up lexer
///         lexer_type = lexer_conf.lexer_type
///         self.skip_lexer = False
///         if lexer_type in ('dynamic', 'dynamic_complete'):
///             assert lexer_conf.postlex is None
///             self.skip_lexer = True
///             return
///
///         if isinstance(lexer_type, type):
///             assert issubclass(lexer_type, Lexer)
///             self.lexer = _wrap_lexer(lexer_type)(lexer_conf)
///         elif isinstance(lexer_type, str):
///             create_lexer = {
///                 'basic': create_basic_lexer,
///                 'contextual': create_contextual_lexer,
///             }[lexer_type]
///             self.lexer = create_lexer(lexer_conf, self.parser, lexer_conf.postlex, options)
///         else:
///             raise TypeError("Bad value for lexer_type: {lexer_type}")
///
///         if lexer_conf.postlex:
///             self.lexer = PostLexConnector(self.lexer, lexer_conf.postlex)
///
///     def _verify_start(self, start=None):
///         if start is None:
///             start_decls = self.parser_conf.start
///             if len(start_decls) > 1:
///                 raise ConfigurationError("Lark initialized with more than 1 possible start rule. Must specify which start rule to parse", start_decls)
///             start ,= start_decls
///         elif start not in self.parser_conf.start:
///             raise ConfigurationError("Unknown start rule %s. Must be one of %r" % (start, self.parser_conf.start))
///         return start
///
///     def _make_lexer_thread(self, text: str):
///         cls = (self.options and self.options._plugins.get('LexerThread')) or LexerThread
///         return text if self.skip_lexer else cls.from_text(self.lexer, text)
///
///     def parse(self, text: str, start=None, on_error=None):
///         chosen_start = self._verify_start(start)
///         kw = {} if on_error is None else {'on_error': on_error}
///         stream = self._make_lexer_thread(text)
///         return self.parser.parse(stream, chosen_start, **kw)
///
///     def parse_interactive(self, text: Optional[str]=None, start=None):
///         # TODO BREAK - Change text from Optional[str] to text: str = ''.
///         #   Would break behavior of exhaust_lexer(), which currently raises TypeError, and after the change would just return []
///         chosen_start = self._verify_start(start)
///         if self.parser_conf.parser_type != 'lalr':
///             raise ConfigurationError("parse_interactive() currently only works with parser='lalr' ")
///         stream = self._make_lexer_thread(text)  # type: ignore[arg-type]
///         return self.parser.parse_interactive(stream, chosen_start)
/// ```
final class ParsingFrontend extends PythonClass {
  factory ParsingFrontend({
    required LexerConf lexer_conf,
    required ParserConf parser_conf,
    required Object? options,
    Object? parser,
  }) =>
      PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "ParsingFrontend",
        ParsingFrontend.from,
        <Object?>[
          lexer_conf,
          parser_conf,
          options,
          parser,
        ],
        <String, Object?>{},
      );

  ParsingFrontend.from(super.pythonClass) : super.from();

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
  /// def parse(self, text: str, start=None, on_error=None):
  ///         chosen_start = self._verify_start(start)
  ///         kw = {} if on_error is None else {'on_error': on_error}
  ///         stream = self._make_lexer_thread(text)
  ///         return self.parser.parse(stream, chosen_start, **kw)
  /// ```
  Object? parse({
    required String text,
    Object? start,
    Object? on_error,
  }) =>
      getFunction("parse").call(
        <Object?>[
          text,
          start,
          on_error,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## parse_interactive
  ///
  /// ### python source
  /// ```py
  /// def parse_interactive(self, text: Optional[str]=None, start=None):
  ///         # TODO BREAK - Change text from Optional[str] to text: str = ''.
  ///         #   Would break behavior of exhaust_lexer(), which currently raises TypeError, and after the change would just return []
  ///         chosen_start = self._verify_start(start)
  ///         if self.parser_conf.parser_type != 'lalr':
  ///             raise ConfigurationError("parse_interactive() currently only works with parser='lalr' ")
  ///         stream = self._make_lexer_thread(text)  # type: ignore[arg-type]
  ///         return self.parser.parse_interactive(stream, chosen_start)
  /// ```
  Object? parse_interactive({
    Object? text,
    Object? start,
  }) =>
      getFunction("parse_interactive").call(
        <Object?>[
          text,
          start,
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

  /// ## lexer_conf (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get lexer_conf => getAttribute("lexer_conf");

  /// ## lexer_conf (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set lexer_conf(Object? lexer_conf) => setAttribute("lexer_conf", lexer_conf);

  /// ## options (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get options => getAttribute("options");

  /// ## options (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set options(Object? options) => setAttribute("options", options);

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

  /// ## skip_lexer (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get skip_lexer => getAttribute("skip_lexer");

  /// ## skip_lexer (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set skip_lexer(Object? skip_lexer) => setAttribute("skip_lexer", skip_lexer);

  /// ## lexer (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get lexer => getAttribute("lexer");

  /// ## lexer (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set lexer(Object? lexer) => setAttribute("lexer", lexer);
}

/// ## PostLexConnector
///
/// ### python source
/// ```py
/// class PostLexConnector:
///     def __init__(self, lexer, postlexer):
///         self.lexer = lexer
///         self.postlexer = postlexer
///
///     def lex(self, lexer_state, parser_state):
///         i = self.lexer.lex(lexer_state, parser_state)
///         return self.postlexer.process(i)
/// ```
final class PostLexConnector extends PythonClass {
  factory PostLexConnector({
    required Object? lexer,
    required Object? postlexer,
  }) =>
      PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "PostLexConnector",
        PostLexConnector.from,
        <Object?>[
          lexer,
          postlexer,
        ],
        <String, Object?>{},
      );

  PostLexConnector.from(super.pythonClass) : super.from();

  /// ## lex
  ///
  /// ### python source
  /// ```py
  /// def lex(self, lexer_state, parser_state):
  ///         i = self.lexer.lex(lexer_state, parser_state)
  ///         return self.postlexer.process(i)
  /// ```
  Object? lex({
    required Object? lexer_state,
    required Object? parser_state,
  }) =>
      getFunction("lex").call(
        <Object?>[
          lexer_state,
          parser_state,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## lexer (getter)
  Object? get lexer => getAttribute("lexer");

  /// ## lexer (setter)
  set lexer(Object? lexer) => setAttribute("lexer", lexer);

  /// ## postlexer (getter)
  Object? get postlexer => getAttribute("postlexer");

  /// ## postlexer (setter)
  set postlexer(Object? postlexer) => setAttribute("postlexer", postlexer);
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
  factory Serialize() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
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
        "lark.parser_frontends",
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
      PythonFfi.instance.importClass(
        "lark.parser_frontends",
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
      PythonFfi.instance.importClass(
        "lark.parser_frontends",
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
      PythonFfi.instance.importClass(
        "lark.parser_frontends",
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
        "lark.parser_frontends",
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

/// ## ParseError
///
/// ### python source
/// ```py
/// class ParseError(LarkError):
///     pass
/// ```
final class ParseError extends PythonClass {
  factory ParseError() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
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
      PythonFfi.instance.importClass(
        "lark.parser_frontends",
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
      PythonFfi.instance.importClass(
        "lark.parser_frontends",
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
      PythonFfi.instance.importClass(
        "lark.parser_frontends",
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
      PythonFfi.instance.importClass(
        "lark.parser_frontends",
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
      PythonFfi.instance.importClass(
        "lark.parser_frontends",
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
        "lark.parser_frontends",
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
        "lark.parser_frontends",
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
      PythonFfi.instance.importClass(
        "lark.parser_frontends",
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
  factory accumulate() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "accumulate",
        accumulate.from,
        <Object?>[],
      );

  accumulate.from(super.pythonClass) : super.from();
}

/// ## chain
final class chain extends PythonClass {
  factory chain() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "chain",
        chain.from,
        <Object?>[],
      );

  chain.from(super.pythonClass) : super.from();
}

/// ## combinations
final class combinations extends PythonClass {
  factory combinations() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "combinations",
        combinations.from,
        <Object?>[],
      );

  combinations.from(super.pythonClass) : super.from();
}

/// ## combinations_with_replacement
final class combinations_with_replacement extends PythonClass {
  factory combinations_with_replacement() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "combinations_with_replacement",
        combinations_with_replacement.from,
        <Object?>[],
      );

  combinations_with_replacement.from(super.pythonClass) : super.from();
}

/// ## compress
final class compress extends PythonClass {
  factory compress() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "compress",
        compress.from,
        <Object?>[],
      );

  compress.from(super.pythonClass) : super.from();
}

/// ## count
final class count extends PythonClass {
  factory count() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "count",
        count.from,
        <Object?>[],
      );

  count.from(super.pythonClass) : super.from();
}

/// ## cycle
final class cycle extends PythonClass {
  factory cycle() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "cycle",
        cycle.from,
        <Object?>[],
      );

  cycle.from(super.pythonClass) : super.from();
}

/// ## dropwhile
final class dropwhile extends PythonClass {
  factory dropwhile() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "dropwhile",
        dropwhile.from,
        <Object?>[],
      );

  dropwhile.from(super.pythonClass) : super.from();
}

/// ## filterfalse
final class filterfalse extends PythonClass {
  factory filterfalse() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "filterfalse",
        filterfalse.from,
        <Object?>[],
      );

  filterfalse.from(super.pythonClass) : super.from();
}

/// ## groupby
final class groupby extends PythonClass {
  factory groupby() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "groupby",
        groupby.from,
        <Object?>[],
      );

  groupby.from(super.pythonClass) : super.from();
}

/// ## islice
final class islice extends PythonClass {
  factory islice() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "islice",
        islice.from,
        <Object?>[],
      );

  islice.from(super.pythonClass) : super.from();
}

/// ## pairwise
final class pairwise extends PythonClass {
  factory pairwise() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "pairwise",
        pairwise.from,
        <Object?>[],
      );

  pairwise.from(super.pythonClass) : super.from();
}

/// ## permutations
final class permutations extends PythonClass {
  factory permutations() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "permutations",
        permutations.from,
        <Object?>[],
      );

  permutations.from(super.pythonClass) : super.from();
}

/// ## product
final class product extends PythonClass {
  factory product() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "product",
        product.from,
        <Object?>[],
      );

  product.from(super.pythonClass) : super.from();
}

/// ## repeat
final class repeat extends PythonClass {
  factory repeat() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "repeat",
        repeat.from,
        <Object?>[],
      );

  repeat.from(super.pythonClass) : super.from();
}

/// ## starmap
final class starmap extends PythonClass {
  factory starmap() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "starmap",
        starmap.from,
        <Object?>[],
      );

  starmap.from(super.pythonClass) : super.from();
}

/// ## takewhile
final class takewhile extends PythonClass {
  factory takewhile() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
        "takewhile",
        takewhile.from,
        <Object?>[],
      );

  takewhile.from(super.pythonClass) : super.from();
}

/// ## zip_longest
final class zip_longest extends PythonClass {
  factory zip_longest() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
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
  factory ForestSumVisitor() => PythonFfi.instance.importClass(
        "lark.parser_frontends",
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
        "lark.parser_frontends",
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
        "lark.parser_frontends",
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
        "lark.parser_frontends",
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
        "lark.parser_frontends",
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
        "lark.parser_frontends",
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
        "lark.parser_frontends",
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
        "lark.parser_frontends",
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
        "lark.parser_frontends",
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
  Null get pos_in_stream => getAttribute("pos_in_stream");

  /// ## pos_in_stream (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set pos_in_stream(Null pos_in_stream) =>
      setAttribute("pos_in_stream", pos_in_stream);
}

/// ## parser_frontends
///
/// ### python source
/// ```py
/// from typing import Any, Callable, Dict, Optional, Collection
///
/// from .exceptions import ConfigurationError, GrammarError, assert_config
/// from .utils import get_regexp_width, Serialize
/// from .parsers.grammar_analysis import GrammarAnalyzer
/// from .lexer import LexerThread, BasicLexer, ContextualLexer, Lexer
/// from .parsers import earley, xearley, cyk
/// from .parsers.lalr_parser import LALR_Parser
/// from .tree import Tree
/// from .common import LexerConf, ParserConf, _ParserArgType, _LexerArgType
///
/// ###{standalone
///
/// def _wrap_lexer(lexer_class):
///     future_interface = getattr(lexer_class, '__future_interface__', False)
///     if future_interface:
///         return lexer_class
///     else:
///         class CustomLexerWrapper(Lexer):
///             def __init__(self, lexer_conf):
///                 self.lexer = lexer_class(lexer_conf)
///             def lex(self, lexer_state, parser_state):
///                 return self.lexer.lex(lexer_state.text)
///         return CustomLexerWrapper
///
///
/// def _deserialize_parsing_frontend(data, memo, lexer_conf, callbacks, options):
///     parser_conf = ParserConf.deserialize(data['parser_conf'], memo)
///     cls = (options and options._plugins.get('LALR_Parser')) or LALR_Parser
///     parser = cls.deserialize(data['parser'], memo, callbacks, options.debug)
///     parser_conf.callbacks = callbacks
///     return ParsingFrontend(lexer_conf, parser_conf, options, parser=parser)
///
///
/// _parser_creators: 'Dict[str, Callable[[LexerConf, Any, Any], Any]]' = {}
///
///
/// class ParsingFrontend(Serialize):
///     __serialize_fields__ = 'lexer_conf', 'parser_conf', 'parser'
///
///     lexer_conf: LexerConf
///     parser_conf: ParserConf
///     options: Any
///
///     def __init__(self, lexer_conf: LexerConf, parser_conf: ParserConf, options, parser=None):
///         self.parser_conf = parser_conf
///         self.lexer_conf = lexer_conf
///         self.options = options
///
///         # Set-up parser
///         if parser:  # From cache
///             self.parser = parser
///         else:
///             create_parser = _parser_creators.get(parser_conf.parser_type)
///             assert create_parser is not None, "{} is not supported in standalone mode".format(
///                     parser_conf.parser_type
///                 )
///             self.parser = create_parser(lexer_conf, parser_conf, options)
///
///         # Set-up lexer
///         lexer_type = lexer_conf.lexer_type
///         self.skip_lexer = False
///         if lexer_type in ('dynamic', 'dynamic_complete'):
///             assert lexer_conf.postlex is None
///             self.skip_lexer = True
///             return
///
///         if isinstance(lexer_type, type):
///             assert issubclass(lexer_type, Lexer)
///             self.lexer = _wrap_lexer(lexer_type)(lexer_conf)
///         elif isinstance(lexer_type, str):
///             create_lexer = {
///                 'basic': create_basic_lexer,
///                 'contextual': create_contextual_lexer,
///             }[lexer_type]
///             self.lexer = create_lexer(lexer_conf, self.parser, lexer_conf.postlex, options)
///         else:
///             raise TypeError("Bad value for lexer_type: {lexer_type}")
///
///         if lexer_conf.postlex:
///             self.lexer = PostLexConnector(self.lexer, lexer_conf.postlex)
///
///     def _verify_start(self, start=None):
///         if start is None:
///             start_decls = self.parser_conf.start
///             if len(start_decls) > 1:
///                 raise ConfigurationError("Lark initialized with more than 1 possible start rule. Must specify which start rule to parse", start_decls)
///             start ,= start_decls
///         elif start not in self.parser_conf.start:
///             raise ConfigurationError("Unknown start rule %s. Must be one of %r" % (start, self.parser_conf.start))
///         return start
///
///     def _make_lexer_thread(self, text: str):
///         cls = (self.options and self.options._plugins.get('LexerThread')) or LexerThread
///         return text if self.skip_lexer else cls.from_text(self.lexer, text)
///
///     def parse(self, text: str, start=None, on_error=None):
///         chosen_start = self._verify_start(start)
///         kw = {} if on_error is None else {'on_error': on_error}
///         stream = self._make_lexer_thread(text)
///         return self.parser.parse(stream, chosen_start, **kw)
///
///     def parse_interactive(self, text: Optional[str]=None, start=None):
///         # TODO BREAK - Change text from Optional[str] to text: str = ''.
///         #   Would break behavior of exhaust_lexer(), which currently raises TypeError, and after the change would just return []
///         chosen_start = self._verify_start(start)
///         if self.parser_conf.parser_type != 'lalr':
///             raise ConfigurationError("parse_interactive() currently only works with parser='lalr' ")
///         stream = self._make_lexer_thread(text)  # type: ignore[arg-type]
///         return self.parser.parse_interactive(stream, chosen_start)
///
///
/// def _validate_frontend_args(parser, lexer) -> None:
///     assert_config(parser, ('lalr', 'earley', 'cyk'))
///     if not isinstance(lexer, type):     # not custom lexer?
///         expected = {
///             'lalr': ('basic', 'contextual'),
///             'earley': ('basic', 'dynamic', 'dynamic_complete'),
///             'cyk': ('basic', ),
///          }[parser]
///         assert_config(lexer, expected, 'Parser %r does not support lexer %%r, expected one of %%s' % parser)
///
///
/// def _get_lexer_callbacks(transformer, terminals):
///     result = {}
///     for terminal in terminals:
///         callback = getattr(transformer, terminal.name, None)
///         if callback is not None:
///             result[terminal.name] = callback
///     return result
///
/// class PostLexConnector:
///     def __init__(self, lexer, postlexer):
///         self.lexer = lexer
///         self.postlexer = postlexer
///
///     def lex(self, lexer_state, parser_state):
///         i = self.lexer.lex(lexer_state, parser_state)
///         return self.postlexer.process(i)
///
///
///
/// def create_basic_lexer(lexer_conf, parser, postlex, options) -> BasicLexer:
///     cls = (options and options._plugins.get('BasicLexer')) or BasicLexer
///     return cls(lexer_conf)
///
/// def create_contextual_lexer(lexer_conf: LexerConf, parser, postlex, options) -> ContextualLexer:
///     cls = (options and options._plugins.get('ContextualLexer')) or ContextualLexer
///     states: Dict[str, Collection[str]] = {idx:list(t.keys()) for idx, t in parser._parse_table.states.items()}
///     always_accept: Collection[str] = postlex.always_accept if postlex else ()
///     return cls(lexer_conf, states, always_accept=always_accept)
///
/// def create_lalr_parser(lexer_conf: LexerConf, parser_conf: ParserConf, options=None) -> LALR_Parser:
///     debug = options.debug if options else False
///     strict = options.strict if options else False
///     cls = (options and options._plugins.get('LALR_Parser')) or LALR_Parser
///     return cls(parser_conf, debug=debug, strict=strict)
///
/// _parser_creators['lalr'] = create_lalr_parser
///
/// ###}
///
/// class EarleyRegexpMatcher:
///     def __init__(self, lexer_conf):
///         self.regexps = {}
///         for t in lexer_conf.terminals:
///             regexp = t.pattern.to_regexp()
///             try:
///                 width = get_regexp_width(regexp)[0]
///             except ValueError:
///                 raise GrammarError("Bad regexp in token %s: %s" % (t.name, regexp))
///             else:
///                 if width == 0:
///                     raise GrammarError("Dynamic Earley doesn't allow zero-width regexps", t)
///             if lexer_conf.use_bytes:
///                 regexp = regexp.encode('utf-8')
///
///             self.regexps[t.name] = lexer_conf.re_module.compile(regexp, lexer_conf.g_regex_flags)
///
///     def match(self, term, text, index=0):
///         return self.regexps[term.name].match(text, index)
///
///
/// def create_earley_parser__dynamic(lexer_conf: LexerConf, parser_conf: ParserConf, **kw):
///     if lexer_conf.callbacks:
///         raise GrammarError("Earley's dynamic lexer doesn't support lexer_callbacks.")
///
///     earley_matcher = EarleyRegexpMatcher(lexer_conf)
///     return xearley.Parser(lexer_conf, parser_conf, earley_matcher.match, **kw)
///
/// def _match_earley_basic(term, token):
///     return term.name == token.type
///
/// def create_earley_parser__basic(lexer_conf: LexerConf, parser_conf: ParserConf, **kw):
///     return earley.Parser(lexer_conf, parser_conf, _match_earley_basic, **kw)
///
/// def create_earley_parser(lexer_conf: LexerConf, parser_conf: ParserConf, options) -> earley.Parser:
///     resolve_ambiguity = options.ambiguity == 'resolve'
///     debug = options.debug if options else False
///     tree_class = options.tree_class or Tree if options.ambiguity != 'forest' else None
///
///     extra = {}
///     if lexer_conf.lexer_type == 'dynamic':
///         f = create_earley_parser__dynamic
///     elif lexer_conf.lexer_type == 'dynamic_complete':
///         extra['complete_lex'] = True
///         f = create_earley_parser__dynamic
///     else:
///         f = create_earley_parser__basic
///
///     return f(lexer_conf, parser_conf, resolve_ambiguity=resolve_ambiguity, debug=debug, tree_class=tree_class, **extra)
///
///
///
/// class CYK_FrontEnd:
///     def __init__(self, lexer_conf, parser_conf, options=None):
///         self._analysis = GrammarAnalyzer(parser_conf)
///         self.parser = cyk.Parser(parser_conf.rules)
///
///         self.callbacks = parser_conf.callbacks
///
///     def parse(self, lexer_thread, start):
///         tokens = list(lexer_thread.lex(None))
///         tree = self.parser.parse(tokens, start)
///         return self._transform(tree)
///
///     def _transform(self, tree):
///         subtrees = list(tree.iter_subtrees())
///         for subtree in subtrees:
///             subtree.children = [self._apply_callback(c) if isinstance(c, Tree) else c for c in subtree.children]
///
///         return self._apply_callback(tree)
///
///     def _apply_callback(self, tree):
///         return self.callbacks[tree.rule](tree.children)
///
///
/// _parser_creators['earley'] = create_earley_parser
/// _parser_creators['cyk'] = CYK_FrontEnd
///
///
/// def _construct_parsing_frontend(
///         parser_type: _ParserArgType,
///         lexer_type: _LexerArgType,
///         lexer_conf,
///         parser_conf,
///         options
/// ):
///     assert isinstance(lexer_conf, LexerConf)
///     assert isinstance(parser_conf, ParserConf)
///     parser_conf.parser_type = parser_type
///     lexer_conf.lexer_type = lexer_type
///     return ParsingFrontend(lexer_conf, parser_conf, options)
/// ```
final class parser_frontends extends PythonModule {
  parser_frontends.from(super.pythonModule) : super.from();

  static parser_frontends import() => PythonFfi.instance.importModule(
        "lark.parser_frontends",
        parser_frontends.from,
      );

  /// ## assert_config
  ///
  /// ### python source
  /// ```py
  /// def assert_config(value, options: Collection, msg='Got %r, expected one of %s'):
  ///     if value not in options:
  ///         raise ConfigurationError(msg % (value, options))
  /// ```
  Object? assert_config({
    required Object? value,
    required Object? options,
    Object? msg = "Got %r, expected one of %s",
  }) =>
      getFunction("assert_config").call(
        <Object?>[
          value,
          options,
          msg,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## create_basic_lexer
  ///
  /// ### python source
  /// ```py
  /// def create_basic_lexer(lexer_conf, parser, postlex, options) -> BasicLexer:
  ///     cls = (options and options._plugins.get('BasicLexer')) or BasicLexer
  ///     return cls(lexer_conf)
  /// ```
  BasicLexer create_basic_lexer({
    required Object? lexer_conf,
    required Object? parser,
    required Object? postlex,
    required Object? options,
  }) =>
      BasicLexer.from(
        getFunction("create_basic_lexer").call(
          <Object?>[
            lexer_conf,
            parser,
            postlex,
            options,
          ],
          kwargs: <String, Object?>{},
        ),
      );

  /// ## create_contextual_lexer
  ///
  /// ### python source
  /// ```py
  /// def create_contextual_lexer(lexer_conf: LexerConf, parser, postlex, options) -> ContextualLexer:
  ///     cls = (options and options._plugins.get('ContextualLexer')) or ContextualLexer
  ///     states: Dict[str, Collection[str]] = {idx:list(t.keys()) for idx, t in parser._parse_table.states.items()}
  ///     always_accept: Collection[str] = postlex.always_accept if postlex else ()
  ///     return cls(lexer_conf, states, always_accept=always_accept)
  /// ```
  ContextualLexer create_contextual_lexer({
    required LexerConf lexer_conf,
    required Object? parser,
    required Object? postlex,
    required Object? options,
  }) =>
      ContextualLexer.from(
        getFunction("create_contextual_lexer").call(
          <Object?>[
            lexer_conf,
            parser,
            postlex,
            options,
          ],
          kwargs: <String, Object?>{},
        ),
      );

  /// ## create_earley_parser
  ///
  /// ### python source
  /// ```py
  /// def create_earley_parser(lexer_conf: LexerConf, parser_conf: ParserConf, options) -> earley.Parser:
  ///     resolve_ambiguity = options.ambiguity == 'resolve'
  ///     debug = options.debug if options else False
  ///     tree_class = options.tree_class or Tree if options.ambiguity != 'forest' else None
  ///
  ///     extra = {}
  ///     if lexer_conf.lexer_type == 'dynamic':
  ///         f = create_earley_parser__dynamic
  ///     elif lexer_conf.lexer_type == 'dynamic_complete':
  ///         extra['complete_lex'] = True
  ///         f = create_earley_parser__dynamic
  ///     else:
  ///         f = create_earley_parser__basic
  ///
  ///     return f(lexer_conf, parser_conf, resolve_ambiguity=resolve_ambiguity, debug=debug, tree_class=tree_class, **extra)
  /// ```
  Parser create_earley_parser({
    required LexerConf lexer_conf,
    required ParserConf parser_conf,
    required Object? options,
  }) =>
      Parser.from(
        getFunction("create_earley_parser").call(
          <Object?>[
            lexer_conf,
            parser_conf,
            options,
          ],
          kwargs: <String, Object?>{},
        ),
      );

  /// ## create_earley_parser__basic
  ///
  /// ### python source
  /// ```py
  /// def create_earley_parser__basic(lexer_conf: LexerConf, parser_conf: ParserConf, **kw):
  ///     return earley.Parser(lexer_conf, parser_conf, _match_earley_basic, **kw)
  /// ```
  Object? create_earley_parser__basic({
    required LexerConf lexer_conf,
    required ParserConf parser_conf,
    Map<String, Object?> kw = const <String, Object?>{},
  }) =>
      getFunction("create_earley_parser__basic").call(
        <Object?>[
          lexer_conf,
          parser_conf,
        ],
        kwargs: <String, Object?>{
          ...kw,
        },
      );

  /// ## create_earley_parser__dynamic
  ///
  /// ### python source
  /// ```py
  /// def create_earley_parser__dynamic(lexer_conf: LexerConf, parser_conf: ParserConf, **kw):
  ///     if lexer_conf.callbacks:
  ///         raise GrammarError("Earley's dynamic lexer doesn't support lexer_callbacks.")
  ///
  ///     earley_matcher = EarleyRegexpMatcher(lexer_conf)
  ///     return xearley.Parser(lexer_conf, parser_conf, earley_matcher.match, **kw)
  /// ```
  Object? create_earley_parser__dynamic({
    required LexerConf lexer_conf,
    required ParserConf parser_conf,
    Map<String, Object?> kw = const <String, Object?>{},
  }) =>
      getFunction("create_earley_parser__dynamic").call(
        <Object?>[
          lexer_conf,
          parser_conf,
        ],
        kwargs: <String, Object?>{
          ...kw,
        },
      );

  /// ## create_lalr_parser
  ///
  /// ### python source
  /// ```py
  /// def create_lalr_parser(lexer_conf: LexerConf, parser_conf: ParserConf, options=None) -> LALR_Parser:
  ///     debug = options.debug if options else False
  ///     strict = options.strict if options else False
  ///     cls = (options and options._plugins.get('LALR_Parser')) or LALR_Parser
  ///     return cls(parser_conf, debug=debug, strict=strict)
  /// ```
  LALR_Parser create_lalr_parser({
    required LexerConf lexer_conf,
    required ParserConf parser_conf,
    Object? options,
  }) =>
      LALR_Parser.from(
        getFunction("create_lalr_parser").call(
          <Object?>[
            lexer_conf,
            parser_conf,
            options,
          ],
          kwargs: <String, Object?>{},
        ),
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

  /// ## cyk
  ///
  /// ### python docstring
  ///
  /// This module implements a CYK parser.
  cyk get $cyk => cyk.import();

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
  xearley get $xearley => xearley.import();

  /// ## Callable (getter)
  Object? get Callable => getAttribute("Callable");

  /// ## Callable (setter)
  set Callable(Object? Callable) => setAttribute("Callable", Callable);

  /// ## Collection (getter)
  Object? get Collection => getAttribute("Collection");

  /// ## Collection (setter)
  set Collection(Object? Collection) => setAttribute("Collection", Collection);

  /// ## Dict (getter)
  Object? get Dict => getAttribute("Dict");

  /// ## Dict (setter)
  set Dict(Object? Dict) => setAttribute("Dict", Dict);

  /// ## Optional (getter)
  Object? get Optional => getAttribute("Optional");

  /// ## Optional (setter)
  set Optional(Object? Optional) => setAttribute("Optional", Optional);
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

  static cyk import() => PythonFfi.instance.importModule(
        "lark.parsers.cyk",
        cyk.from,
      );
}

/// ## itertools
final class itertools extends PythonModule {
  itertools.from(super.pythonModule) : super.from();

  static itertools import() => PythonFfi.instance.importModule(
        "lark.itertools",
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

  static earley import() => PythonFfi.instance.importModule(
        "lark.parsers.earley",
        earley.from,
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

  static xearley import() => PythonFfi.instance.importModule(
        "lark.parsers.xearley",
        xearley.from,
      );
}
