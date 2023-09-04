// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library lexer;

import "package:python_ffi_dart/python_ffi_dart.dart";

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
      PythonFfiDart.instance.importClass(
        "lark.lexer",
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
    required LexerState state,
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
    required LexerState lex_state,
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

/// ## CallChain
///
/// ### python source
/// ```py
/// class CallChain:
///     def __init__(self, callback1, callback2, cond):
///         self.callback1 = callback1
///         self.callback2 = callback2
///         self.cond = cond
///
///     def __call__(self, t):
///         t2 = self.callback1(t)
///         return self.callback2(t) if self.cond(t2) else t2
/// ```
final class CallChain extends PythonClass {
  factory CallChain({
    required Object? callback1,
    required Object? callback2,
    required Object? cond,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lexer",
        "CallChain",
        CallChain.from,
        <Object?>[
          callback1,
          callback2,
          cond,
        ],
        <String, Object?>{},
      );

  CallChain.from(super.pythonClass) : super.from();

  /// ## callback1 (getter)
  Object? get callback1 => getAttribute("callback1");

  /// ## callback1 (setter)
  set callback1(Object? callback1) => setAttribute("callback1", callback1);

  /// ## callback2 (getter)
  Object? get callback2 => getAttribute("callback2");

  /// ## callback2 (setter)
  set callback2(Object? callback2) => setAttribute("callback2", callback2);

  /// ## cond (getter)
  Object? get cond => getAttribute("cond");

  /// ## cond (setter)
  set cond(Object? cond) => setAttribute("cond", cond);
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
      PythonFfiDart.instance.importClass(
        "lark.lexer",
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
    required LexerState lexer_state,
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

/// ## LexError
///
/// ### python source
/// ```py
/// class LexError(LarkError):
///     pass
/// ```
final class LexError extends PythonClass {
  factory LexError() => PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "LexError",
        LexError.from,
        <Object?>[],
      );

  LexError.from(super.pythonClass) : super.from();

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
  factory Lexer() => PythonFfiDart.instance.importClass(
        "lark.lexer",
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
    required LexerState lexer_state,
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

/// ## LexerState
///
/// ### python docstring
///
/// Represents the current state of the lexer as it scans the text
/// (Lexer objects are only instantiated per grammar, not per text)
///
/// ### python source
/// ```py
/// class LexerState:
///     """Represents the current state of the lexer as it scans the text
///     (Lexer objects are only instantiated per grammar, not per text)
///     """
///
///     __slots__ = 'text', 'line_ctr', 'last_token'
///
///     text: str
///     line_ctr: LineCounter
///     last_token: Optional[Token]
///
///     def __init__(self, text: str, line_ctr: Optional[LineCounter]=None, last_token: Optional[Token]=None):
///         self.text = text
///         self.line_ctr = line_ctr or LineCounter(b'\n' if isinstance(text, bytes) else '\n')
///         self.last_token = last_token
///
///     def __eq__(self, other):
///         if not isinstance(other, LexerState):
///             return NotImplemented
///
///         return self.text is other.text and self.line_ctr == other.line_ctr and self.last_token == other.last_token
///
///     def __copy__(self):
///         return type(self)(self.text, copy(self.line_ctr), self.last_token)
/// ```
final class LexerState extends PythonClass {
  factory LexerState({
    required String text,
    Object? line_ctr,
    Object? last_token,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lexer",
        "LexerState",
        LexerState.from,
        <Object?>[
          text,
          line_ctr,
          last_token,
        ],
        <String, Object?>{},
      );

  LexerState.from(super.pythonClass) : super.from();

  /// ## last_token (getter)
  ///
  /// ### python docstring
  ///
  /// Represents the current state of the lexer as it scans the text
  /// (Lexer objects are only instantiated per grammar, not per text)
  Object? get last_token => getAttribute("last_token");

  /// ## last_token (setter)
  ///
  /// ### python docstring
  ///
  /// Represents the current state of the lexer as it scans the text
  /// (Lexer objects are only instantiated per grammar, not per text)
  set last_token(Object? last_token) => setAttribute("last_token", last_token);

  /// ## line_ctr (getter)
  ///
  /// ### python docstring
  ///
  /// Represents the current state of the lexer as it scans the text
  /// (Lexer objects are only instantiated per grammar, not per text)
  Object? get line_ctr => getAttribute("line_ctr");

  /// ## line_ctr (setter)
  ///
  /// ### python docstring
  ///
  /// Represents the current state of the lexer as it scans the text
  /// (Lexer objects are only instantiated per grammar, not per text)
  set line_ctr(Object? line_ctr) => setAttribute("line_ctr", line_ctr);

  /// ## text (getter)
  ///
  /// ### python docstring
  ///
  /// Represents the current state of the lexer as it scans the text
  /// (Lexer objects are only instantiated per grammar, not per text)
  Object? get text => getAttribute("text");

  /// ## text (setter)
  ///
  /// ### python docstring
  ///
  /// Represents the current state of the lexer as it scans the text
  /// (Lexer objects are only instantiated per grammar, not per text)
  set text(Object? text) => setAttribute("text", text);
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
    required LexerState lexer_state,
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

/// ## LineCounter
///
/// ### python source
/// ```py
/// class LineCounter:
///     __slots__ = 'char_pos', 'line', 'column', 'line_start_pos', 'newline_char'
///
///     def __init__(self, newline_char):
///         self.newline_char = newline_char
///         self.char_pos = 0
///         self.line = 1
///         self.column = 1
///         self.line_start_pos = 0
///
///     def __eq__(self, other):
///         if not isinstance(other, LineCounter):
///             return NotImplemented
///
///         return self.char_pos == other.char_pos and self.newline_char == other.newline_char
///
///     def feed(self, token: Token, test_newline=True):
///         """Consume a token and calculate the new line & column.
///
///         As an optional optimization, set test_newline=False if token doesn't contain a newline.
///         """
///         if test_newline:
///             newlines = token.count(self.newline_char)
///             if newlines:
///                 self.line += newlines
///                 self.line_start_pos = self.char_pos + token.rindex(self.newline_char) + 1
///
///         self.char_pos += len(token)
///         self.column = self.char_pos - self.line_start_pos + 1
/// ```
final class LineCounter extends PythonClass {
  factory LineCounter({
    required Object? newline_char,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lexer",
        "LineCounter",
        LineCounter.from,
        <Object?>[
          newline_char,
        ],
        <String, Object?>{},
      );

  LineCounter.from(super.pythonClass) : super.from();

  /// ## feed
  ///
  /// ### python docstring
  ///
  /// Consume a token and calculate the new line & column.
  ///
  /// As an optional optimization, set test_newline=False if token doesn't contain a newline.
  ///
  /// ### python source
  /// ```py
  /// def feed(self, token: Token, test_newline=True):
  ///         """Consume a token and calculate the new line & column.
  ///
  ///         As an optional optimization, set test_newline=False if token doesn't contain a newline.
  ///         """
  ///         if test_newline:
  ///             newlines = token.count(self.newline_char)
  ///             if newlines:
  ///                 self.line += newlines
  ///                 self.line_start_pos = self.char_pos + token.rindex(self.newline_char) + 1
  ///
  ///         self.char_pos += len(token)
  ///         self.column = self.char_pos - self.line_start_pos + 1
  /// ```
  Object? feed({
    required Token token,
    Object? test_newline = true,
  }) =>
      getFunction("feed").call(
        <Object?>[
          token,
          test_newline,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## char_pos (getter)
  Object? get char_pos => getAttribute("char_pos");

  /// ## char_pos (setter)
  set char_pos(Object? char_pos) => setAttribute("char_pos", char_pos);

  /// ## column (getter)
  Object? get column => getAttribute("column");

  /// ## column (setter)
  set column(Object? column) => setAttribute("column", column);

  /// ## line (getter)
  Object? get line => getAttribute("line");

  /// ## line (setter)
  set line(Object? line) => setAttribute("line", line);

  /// ## line_start_pos (getter)
  Object? get line_start_pos => getAttribute("line_start_pos");

  /// ## line_start_pos (setter)
  set line_start_pos(Object? line_start_pos) =>
      setAttribute("line_start_pos", line_start_pos);

  /// ## newline_char (getter)
  Object? get newline_char => getAttribute("newline_char");

  /// ## newline_char (setter)
  set newline_char(Object? newline_char) =>
      setAttribute("newline_char", newline_char);
}

/// ## ModuleType
final class ModuleType extends PythonClass {
  factory ModuleType() => PythonFfiDart.instance.importClass(
        "builtins",
        "ModuleType",
        ModuleType.from,
        <Object?>[],
      );

  ModuleType.from(super.pythonClass) : super.from();
}

/// ## Pattern
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
/// class Pattern(Serialize, ABC):
///
///     value: str
///     flags: Collection[str]
///     raw: Optional[str]
///     type: ClassVar[str]
///
///     def __init__(self, value: str, flags: Collection[str] = (), raw: Optional[str] = None) -> None:
///         self.value = value
///         self.flags = frozenset(flags)
///         self.raw = raw
///
///     def __repr__(self):
///         return repr(self.to_regexp())
///
///     # Pattern Hashing assumes all subclasses have a different priority!
///     def __hash__(self):
///         return hash((type(self), self.value, self.flags))
///
///     def __eq__(self, other):
///         return type(self) == type(other) and self.value == other.value and self.flags == other.flags
///
///     @abstractmethod
///     def to_regexp(self) -> str:
///         raise NotImplementedError()
///
///     @property
///     @abstractmethod
///     def min_width(self) -> int:
///         raise NotImplementedError()
///
///     @property
///     @abstractmethod
///     def max_width(self) -> int:
///         raise NotImplementedError()
///
///     def _get_flags(self, value):
///         for f in self.flags:
///             value = ('(?%s:%s)' % (f, value))
///         return value
/// ```
final class Pattern extends PythonClass {
  factory Pattern({
    required String value,
    Object? flags = const [],
    Object? raw,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lexer",
        "Pattern",
        Pattern.from,
        <Object?>[
          value,
          flags,
          raw,
        ],
        <String, Object?>{},
      );

  Pattern.from(super.pythonClass) : super.from();

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

  /// ## to_regexp
  ///
  /// ### python source
  /// ```py
  /// @abstractmethod
  ///     def to_regexp(self) -> str:
  ///         raise NotImplementedError()
  /// ```
  String to_regexp() => getFunction("to_regexp").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## max_width (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get max_width => getAttribute("max_width");

  /// ## max_width (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set max_width(Object? max_width) => setAttribute("max_width", max_width);

  /// ## min_width (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get min_width => getAttribute("min_width");

  /// ## min_width (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set min_width(Object? min_width) => setAttribute("min_width", min_width);

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

  /// ## value (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get value => getAttribute("value");

  /// ## value (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set value(Object? value) => setAttribute("value", value);

  /// ## flags (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get flags => getAttribute("flags");

  /// ## flags (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set flags(Object? flags) => setAttribute("flags", flags);

  /// ## raw (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get raw => getAttribute("raw");

  /// ## raw (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set raw(Object? raw) => setAttribute("raw", raw);
}

/// ## PatternRE
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
/// class PatternRE(Pattern):
///     __serialize_fields__ = 'value', 'flags', 'raw', '_width'
///
///     type: ClassVar[str] = "re"
///
///     def to_regexp(self) -> str:
///         return self._get_flags(self.value)
///
///     _width = None
///     def _get_width(self):
///         if self._width is None:
///             self._width = get_regexp_width(self.to_regexp())
///         return self._width
///
///     @property
///     def min_width(self) -> int:
///         return self._get_width()[0]
///
///     @property
///     def max_width(self) -> int:
///         return self._get_width()[1]
/// #
/// ```
final class PatternRE extends PythonClass {
  factory PatternRE({
    required String value,
    Object? flags = const [],
    Object? raw,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lexer",
        "PatternRE",
        PatternRE.from,
        <Object?>[
          value,
          flags,
          raw,
        ],
        <String, Object?>{},
      );

  PatternRE.from(super.pythonClass) : super.from();

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

  /// ## to_regexp
  ///
  /// ### python source
  /// ```py
  /// def to_regexp(self) -> str:
  ///         return self._get_flags(self.value)
  /// ```
  String to_regexp() => getFunction("to_regexp").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## max_width (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get max_width => getAttribute("max_width");

  /// ## max_width (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set max_width(Object? max_width) => setAttribute("max_width", max_width);

  /// ## min_width (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get min_width => getAttribute("min_width");

  /// ## min_width (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set min_width(Object? min_width) => setAttribute("min_width", min_width);

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

  /// ## type (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get type => getAttribute("type");

  /// ## type (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set type(Object? type) => setAttribute("type", type);

  /// ## value (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get value => getAttribute("value");

  /// ## value (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set value(Object? value) => setAttribute("value", value);

  /// ## flags (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get flags => getAttribute("flags");

  /// ## flags (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set flags(Object? flags) => setAttribute("flags", flags);

  /// ## raw (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get raw => getAttribute("raw");

  /// ## raw (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set raw(Object? raw) => setAttribute("raw", raw);
}

/// ## PatternStr
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
/// class PatternStr(Pattern):
///     __serialize_fields__ = 'value', 'flags', 'raw'
///
///     type: ClassVar[str] = "str"
///
///     def to_regexp(self) -> str:
///         return self._get_flags(re.escape(self.value))
///
///     @property
///     def min_width(self) -> int:
///         return len(self.value)
///
///     @property
///     def max_width(self) -> int:
///         return len(self.value)
/// ```
final class PatternStr extends PythonClass {
  factory PatternStr({
    required String value,
    Object? flags = const [],
    Object? raw,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lexer",
        "PatternStr",
        PatternStr.from,
        <Object?>[
          value,
          flags,
          raw,
        ],
        <String, Object?>{},
      );

  PatternStr.from(super.pythonClass) : super.from();

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

  /// ## to_regexp
  ///
  /// ### python source
  /// ```py
  /// def to_regexp(self) -> str:
  ///         return self._get_flags(re.escape(self.value))
  /// ```
  String to_regexp() => getFunction("to_regexp").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## max_width (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get max_width => getAttribute("max_width");

  /// ## max_width (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set max_width(Object? max_width) => setAttribute("max_width", max_width);

  /// ## min_width (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get min_width => getAttribute("min_width");

  /// ## min_width (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set min_width(Object? min_width) => setAttribute("min_width", min_width);

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

  /// ## type (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get type => getAttribute("type");

  /// ## type (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set type(Object? type) => setAttribute("type", type);

  /// ## value (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get value => getAttribute("value");

  /// ## value (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set value(Object? value) => setAttribute("value", value);

  /// ## flags (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get flags => getAttribute("flags");

  /// ## flags (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set flags(Object? flags) => setAttribute("flags", flags);

  /// ## raw (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get raw => getAttribute("raw");

  /// ## raw (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set raw(Object? raw) => setAttribute("raw", raw);
}

/// ## Scanner
///
/// ### python source
/// ```py
/// class Scanner:
///     def __init__(self, terminals, g_regex_flags, re_, use_bytes, match_whole=False):
///         self.terminals = terminals
///         self.g_regex_flags = g_regex_flags
///         self.re_ = re_
///         self.use_bytes = use_bytes
///         self.match_whole = match_whole
///
///         self.allowed_types = {t.name for t in self.terminals}
///
///         self._mres = self._build_mres(terminals, len(terminals))
///
///     def _build_mres(self, terminals, max_size):
///         # Python sets an unreasonable group limit (currently 100) in its re module
///         # Worse, the only way to know we reached it is by catching an AssertionError!
///         # This function recursively tries less and less groups until it's successful.
///         postfix = '$' if self.match_whole else ''
///         mres = []
///         while terminals:
///             pattern = u'|'.join(u'(?P<%s>%s)' % (t.name, t.pattern.to_regexp() + postfix) for t in terminals[:max_size])
///             if self.use_bytes:
///                 pattern = pattern.encode('latin-1')
///             try:
///                 mre = self.re_.compile(pattern, self.g_regex_flags)
///             except AssertionError:  # Yes, this is what Python provides us.. :/
///                 return self._build_mres(terminals, max_size // 2)
///
///             mres.append(mre)
///             terminals = terminals[max_size:]
///         return mres
///
///     def match(self, text, pos):
///         for mre in self._mres:
///             m = mre.match(text, pos)
///             if m:
///                 return m.group(0), m.lastgroup
/// ```
final class Scanner extends PythonClass {
  factory Scanner({
    required Object? terminals,
    required Object? g_regex_flags,
    required Object? re_,
    required Object? use_bytes,
    Object? match_whole = false,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lexer",
        "Scanner",
        Scanner.from,
        <Object?>[
          terminals,
          g_regex_flags,
          re_,
          use_bytes,
          match_whole,
        ],
        <String, Object?>{},
      );

  Scanner.from(super.pythonClass) : super.from();

  /// ## match
  ///
  /// ### python source
  /// ```py
  /// def match(self, text, pos):
  ///         for mre in self._mres:
  ///             m = mre.match(text, pos)
  ///             if m:
  ///                 return m.group(0), m.lastgroup
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

  /// ## terminals (getter)
  Object? get terminals => getAttribute("terminals");

  /// ## terminals (setter)
  set terminals(Object? terminals) => setAttribute("terminals", terminals);

  /// ## g_regex_flags (getter)
  Object? get g_regex_flags => getAttribute("g_regex_flags");

  /// ## g_regex_flags (setter)
  set g_regex_flags(Object? g_regex_flags) =>
      setAttribute("g_regex_flags", g_regex_flags);

  /// ## re_ (getter)
  Object? get re_ => getAttribute("re_");

  /// ## re_ (setter)
  set re_(Object? re_) => setAttribute("re_", re_);

  /// ## use_bytes (getter)
  Object? get use_bytes => getAttribute("use_bytes");

  /// ## use_bytes (setter)
  set use_bytes(Object? use_bytes) => setAttribute("use_bytes", use_bytes);

  /// ## match_whole (getter)
  Object? get match_whole => getAttribute("match_whole");

  /// ## match_whole (setter)
  set match_whole(Object? match_whole) =>
      setAttribute("match_whole", match_whole);

  /// ## allowed_types (getter)
  Object? get allowed_types => getAttribute("allowed_types");

  /// ## allowed_types (setter)
  set allowed_types(Object? allowed_types) =>
      setAttribute("allowed_types", allowed_types);
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
  factory TerminalDef({
    required String name,
    required Pattern pattern,
    int priority = 0,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lexer",
        "TerminalDef",
        TerminalDef.from,
        <Object?>[
          name,
          pattern,
          priority,
        ],
        <String, Object?>{},
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

  /// ## user_repr
  ///
  /// ### python source
  /// ```py
  /// def user_repr(self) -> str:
  ///         if self.name.startswith('__'):  # We represent a generated terminal
  ///             return self.pattern.raw or self.name
  ///         else:
  ///             return self.name
  /// ```
  String user_repr() => getFunction("user_repr").call(
        <Object?>[],
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
  Object? get pattern => getAttribute("pattern");

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
  set pattern(Object? pattern) => setAttribute("pattern", pattern);

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
  Object? get priority => getAttribute("priority");

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
  set priority(Object? priority) => setAttribute("priority", priority);
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

/// ## UnlessCallback
///
/// ### python source
/// ```py
/// class UnlessCallback:
///     def __init__(self, scanner):
///         self.scanner = scanner
///
///     def __call__(self, t):
///         res = self.scanner.match(t.value, 0)
///         if res:
///             _value, t.type = res
///         return t
/// ```
final class UnlessCallback extends PythonClass {
  factory UnlessCallback({
    required Object? scanner,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lexer",
        "UnlessCallback",
        UnlessCallback.from,
        <Object?>[
          scanner,
        ],
        <String, Object?>{},
      );

  UnlessCallback.from(super.pythonClass) : super.from();

  /// ## scanner (getter)
  Object? get scanner => getAttribute("scanner");

  /// ## scanner (setter)
  set scanner(Object? scanner) => setAttribute("scanner", scanner);
}

/// ## lexer
///
/// ### python source
/// ```py
/// # Lexer Implementation
///
/// from abc import abstractmethod, ABC
/// import re
/// from contextlib import suppress
/// from typing import (
///     TypeVar, Type, Dict, Iterator, Collection, Callable, Optional, FrozenSet, Any,
///     ClassVar, TYPE_CHECKING, overload
/// )
/// from types import ModuleType
/// import warnings
/// try:
///     import interegular
/// except ImportError:
///     pass
/// if TYPE_CHECKING:
///     from .common import LexerConf
///
/// from .utils import classify, get_regexp_width, Serialize, logger
/// from .exceptions import UnexpectedCharacters, LexError, UnexpectedToken
/// from .grammar import TOKEN_DEFAULT_PRIORITY
///
///
/// ###{standalone
/// from copy import copy
///
/// try:  # For the standalone parser, we need to make sure that has_interegular is False to avoid NameErrors later on
///     has_interegular = bool(interegular)
/// except NameError:
///     has_interegular = False
///
/// class Pattern(Serialize, ABC):
///
///     value: str
///     flags: Collection[str]
///     raw: Optional[str]
///     type: ClassVar[str]
///
///     def __init__(self, value: str, flags: Collection[str] = (), raw: Optional[str] = None) -> None:
///         self.value = value
///         self.flags = frozenset(flags)
///         self.raw = raw
///
///     def __repr__(self):
///         return repr(self.to_regexp())
///
///     # Pattern Hashing assumes all subclasses have a different priority!
///     def __hash__(self):
///         return hash((type(self), self.value, self.flags))
///
///     def __eq__(self, other):
///         return type(self) == type(other) and self.value == other.value and self.flags == other.flags
///
///     @abstractmethod
///     def to_regexp(self) -> str:
///         raise NotImplementedError()
///
///     @property
///     @abstractmethod
///     def min_width(self) -> int:
///         raise NotImplementedError()
///
///     @property
///     @abstractmethod
///     def max_width(self) -> int:
///         raise NotImplementedError()
///
///     def _get_flags(self, value):
///         for f in self.flags:
///             value = ('(?%s:%s)' % (f, value))
///         return value
///
///
/// class PatternStr(Pattern):
///     __serialize_fields__ = 'value', 'flags', 'raw'
///
///     type: ClassVar[str] = "str"
///
///     def to_regexp(self) -> str:
///         return self._get_flags(re.escape(self.value))
///
///     @property
///     def min_width(self) -> int:
///         return len(self.value)
///
///     @property
///     def max_width(self) -> int:
///         return len(self.value)
///
///
/// class PatternRE(Pattern):
///     __serialize_fields__ = 'value', 'flags', 'raw', '_width'
///
///     type: ClassVar[str] = "re"
///
///     def to_regexp(self) -> str:
///         return self._get_flags(self.value)
///
///     _width = None
///     def _get_width(self):
///         if self._width is None:
///             self._width = get_regexp_width(self.to_regexp())
///         return self._width
///
///     @property
///     def min_width(self) -> int:
///         return self._get_width()[0]
///
///     @property
///     def max_width(self) -> int:
///         return self._get_width()[1]
///
///
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
///
/// _T = TypeVar('_T', bound="Token")
///
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
///
///
/// class LineCounter:
///     __slots__ = 'char_pos', 'line', 'column', 'line_start_pos', 'newline_char'
///
///     def __init__(self, newline_char):
///         self.newline_char = newline_char
///         self.char_pos = 0
///         self.line = 1
///         self.column = 1
///         self.line_start_pos = 0
///
///     def __eq__(self, other):
///         if not isinstance(other, LineCounter):
///             return NotImplemented
///
///         return self.char_pos == other.char_pos and self.newline_char == other.newline_char
///
///     def feed(self, token: Token, test_newline=True):
///         """Consume a token and calculate the new line & column.
///
///         As an optional optimization, set test_newline=False if token doesn't contain a newline.
///         """
///         if test_newline:
///             newlines = token.count(self.newline_char)
///             if newlines:
///                 self.line += newlines
///                 self.line_start_pos = self.char_pos + token.rindex(self.newline_char) + 1
///
///         self.char_pos += len(token)
///         self.column = self.char_pos - self.line_start_pos + 1
///
///
/// class UnlessCallback:
///     def __init__(self, scanner):
///         self.scanner = scanner
///
///     def __call__(self, t):
///         res = self.scanner.match(t.value, 0)
///         if res:
///             _value, t.type = res
///         return t
///
///
/// class CallChain:
///     def __init__(self, callback1, callback2, cond):
///         self.callback1 = callback1
///         self.callback2 = callback2
///         self.cond = cond
///
///     def __call__(self, t):
///         t2 = self.callback1(t)
///         return self.callback2(t) if self.cond(t2) else t2
///
///
/// def _get_match(re_, regexp, s, flags):
///     m = re_.match(regexp, s, flags)
///     if m:
///         return m.group(0)
///
/// def _create_unless(terminals, g_regex_flags, re_, use_bytes):
///     tokens_by_type = classify(terminals, lambda t: type(t.pattern))
///     assert len(tokens_by_type) <= 2, tokens_by_type.keys()
///     embedded_strs = set()
///     callback = {}
///     for retok in tokens_by_type.get(PatternRE, []):
///         unless = []
///         for strtok in tokens_by_type.get(PatternStr, []):
///             if strtok.priority != retok.priority:
///                 continue
///             s = strtok.pattern.value
///             if s == _get_match(re_, retok.pattern.to_regexp(), s, g_regex_flags):
///                 unless.append(strtok)
///                 if strtok.pattern.flags <= retok.pattern.flags:
///                     embedded_strs.add(strtok)
///         if unless:
///             callback[retok.name] = UnlessCallback(Scanner(unless, g_regex_flags, re_, match_whole=True, use_bytes=use_bytes))
///
///     new_terminals = [t for t in terminals if t not in embedded_strs]
///     return new_terminals, callback
///
///
/// class Scanner:
///     def __init__(self, terminals, g_regex_flags, re_, use_bytes, match_whole=False):
///         self.terminals = terminals
///         self.g_regex_flags = g_regex_flags
///         self.re_ = re_
///         self.use_bytes = use_bytes
///         self.match_whole = match_whole
///
///         self.allowed_types = {t.name for t in self.terminals}
///
///         self._mres = self._build_mres(terminals, len(terminals))
///
///     def _build_mres(self, terminals, max_size):
///         # Python sets an unreasonable group limit (currently 100) in its re module
///         # Worse, the only way to know we reached it is by catching an AssertionError!
///         # This function recursively tries less and less groups until it's successful.
///         postfix = '$' if self.match_whole else ''
///         mres = []
///         while terminals:
///             pattern = u'|'.join(u'(?P<%s>%s)' % (t.name, t.pattern.to_regexp() + postfix) for t in terminals[:max_size])
///             if self.use_bytes:
///                 pattern = pattern.encode('latin-1')
///             try:
///                 mre = self.re_.compile(pattern, self.g_regex_flags)
///             except AssertionError:  # Yes, this is what Python provides us.. :/
///                 return self._build_mres(terminals, max_size // 2)
///
///             mres.append(mre)
///             terminals = terminals[max_size:]
///         return mres
///
///     def match(self, text, pos):
///         for mre in self._mres:
///             m = mre.match(text, pos)
///             if m:
///                 return m.group(0), m.lastgroup
///
///
/// def _regexp_has_newline(r: str):
///     r"""Expressions that may indicate newlines in a regexp:
///         - newlines (\n)
///         - escaped newline (\\n)
///         - anything but ([^...])
///         - any-char (.) when the flag (?s) exists
///         - spaces (\s)
///     """
///     return '\n' in r or '\\n' in r or '\\s' in r or '[^' in r or ('(?s' in r and '.' in r)
///
///
/// class LexerState:
///     """Represents the current state of the lexer as it scans the text
///     (Lexer objects are only instantiated per grammar, not per text)
///     """
///
///     __slots__ = 'text', 'line_ctr', 'last_token'
///
///     text: str
///     line_ctr: LineCounter
///     last_token: Optional[Token]
///
///     def __init__(self, text: str, line_ctr: Optional[LineCounter]=None, last_token: Optional[Token]=None):
///         self.text = text
///         self.line_ctr = line_ctr or LineCounter(b'\n' if isinstance(text, bytes) else '\n')
///         self.last_token = last_token
///
///     def __eq__(self, other):
///         if not isinstance(other, LexerState):
///             return NotImplemented
///
///         return self.text is other.text and self.line_ctr == other.line_ctr and self.last_token == other.last_token
///
///     def __copy__(self):
///         return type(self)(self.text, copy(self.line_ctr), self.last_token)
///
///
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
///
///
/// _Callback = Callable[[Token], Token]
///
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
///
///
/// def _check_regex_collisions(terminal_to_regexp: Dict[TerminalDef, str], comparator, strict_mode, max_collisions_to_show=8):
///     if not comparator:
///         comparator = interegular.Comparator.from_regexes(terminal_to_regexp)
///
///     # When in strict mode, we only ever try to provide one example, so taking
///     # a long time for that should be fine
///     max_time = 2 if strict_mode else 0.2
///
///     # We don't want to show too many collisions.
///     if comparator.count_marked_pairs() >= max_collisions_to_show:
///         return
///     for group in classify(terminal_to_regexp, lambda t: t.priority).values():
///         for a, b in comparator.check(group, skip_marked=True):
///             assert a.priority == b.priority
///             # Mark this pair to not repeat warnings when multiple different BasicLexers see the same collision
///             comparator.mark(a, b)
///
///             # Notify the user
///             message = f"Collision between Terminals {a.name} and {b.name}. "
///             try:
///                 example = comparator.get_example_overlap(a, b, max_time).format_multiline()
///             except ValueError:
///                 # Couldn't find an example within max_time steps.
///                 example = "No example could be found fast enough. However, the collision does still exists"
///             if strict_mode:
///                 raise LexError(f"{message}\n{example}")
///             logger.warning("%s The lexer will choose between them arbitrarily.\n%s", message, example)
///             if comparator.count_marked_pairs() >= max_collisions_to_show:
///                 logger.warning("Found 8 regex collisions, will not check for more.")
///                 return
///
///
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
///
///
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
///
/// ###}
/// ```
final class lexer extends PythonModule {
  lexer.from(super.pythonModule) : super.from();

  static lexer import() => PythonFfiDart.instance.importModule(
        "lark.lexer",
        lexer.from,
      );

  /// ## TOKEN_DEFAULT_PRIORITY (getter)
  Object? get TOKEN_DEFAULT_PRIORITY => getAttribute("TOKEN_DEFAULT_PRIORITY");

  /// ## TOKEN_DEFAULT_PRIORITY (setter)
  set TOKEN_DEFAULT_PRIORITY(Object? TOKEN_DEFAULT_PRIORITY) =>
      setAttribute("TOKEN_DEFAULT_PRIORITY", TOKEN_DEFAULT_PRIORITY);

  /// ## TYPE_CHECKING (getter)
  Object? get TYPE_CHECKING => getAttribute("TYPE_CHECKING");

  /// ## TYPE_CHECKING (setter)
  set TYPE_CHECKING(Object? TYPE_CHECKING) =>
      setAttribute("TYPE_CHECKING", TYPE_CHECKING);

  /// ## has_interegular (getter)
  Object? get has_interegular => getAttribute("has_interegular");

  /// ## has_interegular (setter)
  set has_interegular(Object? has_interegular) =>
      setAttribute("has_interegular", has_interegular);
}
