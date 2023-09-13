// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library lark;

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
        "lark.lark",
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

/// ## ConfigurationError
///
/// ### python source
/// ```py
/// class ConfigurationError(LarkError, ValueError):
///     pass
/// ```
final class ConfigurationError extends PythonClass {
  factory ConfigurationError() => PythonFfiDart.instance.importClass(
        "lark.lark",
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
        "lark.lark",
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

/// ## FromPackageLoader
///
/// ### python docstring
///
/// Provides a simple way of creating custom import loaders that load from packages via ``pkgutil.get_data`` instead of using `open`.
/// This allows them to be compatible even from within zip files.
///
/// Relative imports are handled, so you can just freely use them.
///
/// pkg_name: The name of the package. You can probably provide `__name__` most of the time
/// search_paths: All the path that will be search on absolute imports.
///
/// ### python source
/// ```py
/// class FromPackageLoader:
///     """
///     Provides a simple way of creating custom import loaders that load from packages via ``pkgutil.get_data`` instead of using `open`.
///     This allows them to be compatible even from within zip files.
///
///     Relative imports are handled, so you can just freely use them.
///
///     pkg_name: The name of the package. You can probably provide `__name__` most of the time
///     search_paths: All the path that will be search on absolute imports.
///     """
///
///     pkg_name: str
///     search_paths: Sequence[str]
///
///     def __init__(self, pkg_name: str, search_paths: Sequence[str]=("", )) -> None:
///         self.pkg_name = pkg_name
///         self.search_paths = search_paths
///
///     def __repr__(self):
///         return "%s(%r, %r)" % (type(self).__name__, self.pkg_name, self.search_paths)
///
///     def __call__(self, base_path: Union[None, str, PackageResource], grammar_path: str) -> Tuple[PackageResource, str]:
///         if base_path is None:
///             to_try = self.search_paths
///         else:
///             # Check whether or not the importing grammar was loaded by this module.
///             if not isinstance(base_path, PackageResource) or base_path.pkg_name != self.pkg_name:
///                 # Technically false, but FileNotFound doesn't exist in python2.7, and this message should never reach the end user anyway
///                 raise IOError()
///             to_try = [base_path.path]
///
///         err = None
///         for path in to_try:
///             full_path = os.path.join(path, grammar_path)
///             try:
///                 text: Optional[bytes] = pkgutil.get_data(self.pkg_name, full_path)
///             except IOError as e:
///                 err = e
///                 continue
///             else:
///                 return PackageResource(self.pkg_name, full_path), (text.decode() if text else '')
///
///         raise IOError('Cannot find grammar in given paths') from err
/// ```
final class FromPackageLoader extends PythonClass {
  factory FromPackageLoader({
    required String pkg_name,
    Object? search_paths = const [""],
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lark",
        "FromPackageLoader",
        FromPackageLoader.from,
        <Object?>[
          pkg_name,
          search_paths,
        ],
        <String, Object?>{},
      );

  FromPackageLoader.from(super.pythonClass) : super.from();

  /// ## pkg_name (getter)
  ///
  /// ### python docstring
  ///
  /// Provides a simple way of creating custom import loaders that load from packages via ``pkgutil.get_data`` instead of using `open`.
  /// This allows them to be compatible even from within zip files.
  ///
  /// Relative imports are handled, so you can just freely use them.
  ///
  /// pkg_name: The name of the package. You can probably provide `__name__` most of the time
  /// search_paths: All the path that will be search on absolute imports.
  Object? get pkg_name => getAttribute("pkg_name");

  /// ## pkg_name (setter)
  ///
  /// ### python docstring
  ///
  /// Provides a simple way of creating custom import loaders that load from packages via ``pkgutil.get_data`` instead of using `open`.
  /// This allows them to be compatible even from within zip files.
  ///
  /// Relative imports are handled, so you can just freely use them.
  ///
  /// pkg_name: The name of the package. You can probably provide `__name__` most of the time
  /// search_paths: All the path that will be search on absolute imports.
  set pkg_name(Object? pkg_name) => setAttribute("pkg_name", pkg_name);

  /// ## search_paths (getter)
  ///
  /// ### python docstring
  ///
  /// Provides a simple way of creating custom import loaders that load from packages via ``pkgutil.get_data`` instead of using `open`.
  /// This allows them to be compatible even from within zip files.
  ///
  /// Relative imports are handled, so you can just freely use them.
  ///
  /// pkg_name: The name of the package. You can probably provide `__name__` most of the time
  /// search_paths: All the path that will be search on absolute imports.
  Object? get search_paths => getAttribute("search_paths");

  /// ## search_paths (setter)
  ///
  /// ### python docstring
  ///
  /// Provides a simple way of creating custom import loaders that load from packages via ``pkgutil.get_data`` instead of using `open`.
  /// This allows them to be compatible even from within zip files.
  ///
  /// Relative imports are handled, so you can just freely use them.
  ///
  /// pkg_name: The name of the package. You can probably provide `__name__` most of the time
  /// search_paths: All the path that will be search on absolute imports.
  set search_paths(Object? search_paths) =>
      setAttribute("search_paths", search_paths);
}

/// ## Grammar
///
/// ### python source
/// ```py
/// class Grammar:
///
///     term_defs: List[Tuple[str, Tuple[Tree, int]]]
///     rule_defs: List[Tuple[str, Tuple[str, ...], Tree, RuleOptions]]
///     ignore: List[str]
///
///     def __init__(self, rule_defs: List[Tuple[str, Tuple[str, ...], Tree, RuleOptions]], term_defs: List[Tuple[str, Tuple[Tree, int]]], ignore: List[str]) -> None:
///         self.term_defs = term_defs
///         self.rule_defs = rule_defs
///         self.ignore = ignore
///
///     def compile(self, start, terminals_to_keep):
///         # We change the trees in-place (to support huge grammars)
///         # So deepcopy allows calling compile more than once.
///         term_defs = [(n, (nr_deepcopy_tree(t), p)) for n, (t, p) in self.term_defs]
///         rule_defs = [(n, p, nr_deepcopy_tree(t), o) for n, p, t, o in self.rule_defs]
///
///         # ===================
///         #  Compile Terminals
///         # ===================
///
///         # Convert terminal-trees to strings/regexps
///
///         for name, (term_tree, priority) in term_defs:
///             if term_tree is None:  # Terminal added through %declare
///                 continue
///             expansions = list(term_tree.find_data('expansion'))
///             if len(expansions) == 1 and not expansions[0].children:
///                 raise GrammarError("Terminals cannot be empty (%s)" % name)
///
///         transformer = PrepareLiterals() * TerminalTreeToPattern()
///         terminals = [TerminalDef(name, transformer.transform(term_tree), priority)
///                      for name, (term_tree, priority) in term_defs if term_tree]
///
///         # =================
///         #  Compile Rules
///         # =================
///
///         # 1. Pre-process terminals
///         anon_tokens_transf = PrepareAnonTerminals(terminals)
///         transformer = PrepareLiterals() * ValidateSymbols() * anon_tokens_transf  # Adds to terminals
///
///         # 2. Inline Templates
///
///         transformer *= ApplyTemplates(rule_defs)
///
///         # 3. Convert EBNF to BNF (and apply step 1 & 2)
///         ebnf_to_bnf = EBNF_to_BNF()
///         rules = []
///         i = 0
///         while i < len(rule_defs):  # We have to do it like this because rule_defs might grow due to templates
///             name, params, rule_tree, options = rule_defs[i]
///             i += 1
///             if len(params) != 0:  # Dont transform templates
///                 continue
///             rule_options = RuleOptions(keep_all_tokens=True) if options and options.keep_all_tokens else None
///             ebnf_to_bnf.rule_options = rule_options
///             ebnf_to_bnf.prefix = name
///             anon_tokens_transf.rule_options = rule_options
///             tree = transformer.transform(rule_tree)
///             res = ebnf_to_bnf.transform(tree)
///             rules.append((name, res, options))
///         rules += ebnf_to_bnf.new_rules
///
///         assert len(rules) == len({name for name, _t, _o in rules}), "Whoops, name collision"
///
///         # 4. Compile tree to Rule objects
///         rule_tree_to_text = RuleTreeToText()
///
///         simplify_rule = SimplifyRule_Visitor()
///         compiled_rules = []
///         for rule_content in rules:
///             name, tree, options = rule_content
///             simplify_rule.visit(tree)
///             expansions = rule_tree_to_text.transform(tree)
///
///             for i, (expansion, alias) in enumerate(expansions):
///                 if alias and name.startswith('_'):
///                     raise GrammarError("Rule %s is marked for expansion (it starts with an underscore) and isn't allowed to have aliases (alias=%s)"% (name, alias))
///
///                 empty_indices = [x==_EMPTY for x in expansion]
///                 if any(empty_indices):
///                     exp_options = copy(options) or RuleOptions()
///                     exp_options.empty_indices = empty_indices
///                     expansion = [x for x in expansion if x!=_EMPTY]
///                 else:
///                     exp_options = options
///
///                 for sym in expansion:
///                     assert isinstance(sym, Symbol)
///                     if sym.is_term and exp_options and exp_options.keep_all_tokens:
///                         sym.filter_out = False
///                 rule = Rule(NonTerminal(name), expansion, i, alias, exp_options)
///                 compiled_rules.append(rule)
///
///         # Remove duplicates of empty rules, throw error for non-empty duplicates
///         if len(set(compiled_rules)) != len(compiled_rules):
///             duplicates = classify(compiled_rules, lambda x: x)
///             for dups in duplicates.values():
///                 if len(dups) > 1:
///                     if dups[0].expansion:
///                         raise GrammarError("Rules defined twice: %s\n\n(Might happen due to colliding expansion of optionals: [] or ?)"
///                                            % ''.join('\n  * %s' % i for i in dups))
///
///                     # Empty rule; assert all other attributes are equal
///                     assert len({(r.alias, r.order, r.options) for r in dups}) == len(dups)
///
///             # Remove duplicates
///             compiled_rules = list(set(compiled_rules))
///
///         # Filter out unused rules
///         while True:
///             c = len(compiled_rules)
///             used_rules = {s for r in compiled_rules
///                             for s in r.expansion
///                             if isinstance(s, NonTerminal)
///                             and s != r.origin}
///             used_rules |= {NonTerminal(s) for s in start}
///             compiled_rules, unused = classify_bool(compiled_rules, lambda r: r.origin in used_rules)
///             for r in unused:
///                 logger.debug("Unused rule: %s", r)
///             if len(compiled_rules) == c:
///                 break
///
///         # Filter out unused terminals
///         if terminals_to_keep != '*':
///             used_terms = {t.name for r in compiled_rules
///                                  for t in r.expansion
///                                  if isinstance(t, Terminal)}
///             terminals, unused = classify_bool(terminals, lambda t: t.name in used_terms or t.name in self.ignore or t.name in terminals_to_keep)
///             if unused:
///                 logger.debug("Unused terminals: %s", [t.name for t in unused])
///
///         return terminals, compiled_rules, self.ignore
/// ```
final class Grammar extends PythonClass {
  factory Grammar({
    required Object? rule_defs,
    required Object? term_defs,
    required Object? ignore,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lark",
        "Grammar",
        Grammar.from,
        <Object?>[
          rule_defs,
          term_defs,
          ignore,
        ],
        <String, Object?>{},
      );

  Grammar.from(super.pythonClass) : super.from();

  /// ## compile
  ///
  /// ### python source
  /// ```py
  /// def compile(self, start, terminals_to_keep):
  ///         # We change the trees in-place (to support huge grammars)
  ///         # So deepcopy allows calling compile more than once.
  ///         term_defs = [(n, (nr_deepcopy_tree(t), p)) for n, (t, p) in self.term_defs]
  ///         rule_defs = [(n, p, nr_deepcopy_tree(t), o) for n, p, t, o in self.rule_defs]
  ///
  ///         # ===================
  ///         #  Compile Terminals
  ///         # ===================
  ///
  ///         # Convert terminal-trees to strings/regexps
  ///
  ///         for name, (term_tree, priority) in term_defs:
  ///             if term_tree is None:  # Terminal added through %declare
  ///                 continue
  ///             expansions = list(term_tree.find_data('expansion'))
  ///             if len(expansions) == 1 and not expansions[0].children:
  ///                 raise GrammarError("Terminals cannot be empty (%s)" % name)
  ///
  ///         transformer = PrepareLiterals() * TerminalTreeToPattern()
  ///         terminals = [TerminalDef(name, transformer.transform(term_tree), priority)
  ///                      for name, (term_tree, priority) in term_defs if term_tree]
  ///
  ///         # =================
  ///         #  Compile Rules
  ///         # =================
  ///
  ///         # 1. Pre-process terminals
  ///         anon_tokens_transf = PrepareAnonTerminals(terminals)
  ///         transformer = PrepareLiterals() * ValidateSymbols() * anon_tokens_transf  # Adds to terminals
  ///
  ///         # 2. Inline Templates
  ///
  ///         transformer *= ApplyTemplates(rule_defs)
  ///
  ///         # 3. Convert EBNF to BNF (and apply step 1 & 2)
  ///         ebnf_to_bnf = EBNF_to_BNF()
  ///         rules = []
  ///         i = 0
  ///         while i < len(rule_defs):  # We have to do it like this because rule_defs might grow due to templates
  ///             name, params, rule_tree, options = rule_defs[i]
  ///             i += 1
  ///             if len(params) != 0:  # Dont transform templates
  ///                 continue
  ///             rule_options = RuleOptions(keep_all_tokens=True) if options and options.keep_all_tokens else None
  ///             ebnf_to_bnf.rule_options = rule_options
  ///             ebnf_to_bnf.prefix = name
  ///             anon_tokens_transf.rule_options = rule_options
  ///             tree = transformer.transform(rule_tree)
  ///             res = ebnf_to_bnf.transform(tree)
  ///             rules.append((name, res, options))
  ///         rules += ebnf_to_bnf.new_rules
  ///
  ///         assert len(rules) == len({name for name, _t, _o in rules}), "Whoops, name collision"
  ///
  ///         # 4. Compile tree to Rule objects
  ///         rule_tree_to_text = RuleTreeToText()
  ///
  ///         simplify_rule = SimplifyRule_Visitor()
  ///         compiled_rules = []
  ///         for rule_content in rules:
  ///             name, tree, options = rule_content
  ///             simplify_rule.visit(tree)
  ///             expansions = rule_tree_to_text.transform(tree)
  ///
  ///             for i, (expansion, alias) in enumerate(expansions):
  ///                 if alias and name.startswith('_'):
  ///                     raise GrammarError("Rule %s is marked for expansion (it starts with an underscore) and isn't allowed to have aliases (alias=%s)"% (name, alias))
  ///
  ///                 empty_indices = [x==_EMPTY for x in expansion]
  ///                 if any(empty_indices):
  ///                     exp_options = copy(options) or RuleOptions()
  ///                     exp_options.empty_indices = empty_indices
  ///                     expansion = [x for x in expansion if x!=_EMPTY]
  ///                 else:
  ///                     exp_options = options
  ///
  ///                 for sym in expansion:
  ///                     assert isinstance(sym, Symbol)
  ///                     if sym.is_term and exp_options and exp_options.keep_all_tokens:
  ///                         sym.filter_out = False
  ///                 rule = Rule(NonTerminal(name), expansion, i, alias, exp_options)
  ///                 compiled_rules.append(rule)
  ///
  ///         # Remove duplicates of empty rules, throw error for non-empty duplicates
  ///         if len(set(compiled_rules)) != len(compiled_rules):
  ///             duplicates = classify(compiled_rules, lambda x: x)
  ///             for dups in duplicates.values():
  ///                 if len(dups) > 1:
  ///                     if dups[0].expansion:
  ///                         raise GrammarError("Rules defined twice: %s\n\n(Might happen due to colliding expansion of optionals: [] or ?)"
  ///                                            % ''.join('\n  * %s' % i for i in dups))
  ///
  ///                     # Empty rule; assert all other attributes are equal
  ///                     assert len({(r.alias, r.order, r.options) for r in dups}) == len(dups)
  ///
  ///             # Remove duplicates
  ///             compiled_rules = list(set(compiled_rules))
  ///
  ///         # Filter out unused rules
  ///         while True:
  ///             c = len(compiled_rules)
  ///             used_rules = {s for r in compiled_rules
  ///                             for s in r.expansion
  ///                             if isinstance(s, NonTerminal)
  ///                             and s != r.origin}
  ///             used_rules |= {NonTerminal(s) for s in start}
  ///             compiled_rules, unused = classify_bool(compiled_rules, lambda r: r.origin in used_rules)
  ///             for r in unused:
  ///                 logger.debug("Unused rule: %s", r)
  ///             if len(compiled_rules) == c:
  ///                 break
  ///
  ///         # Filter out unused terminals
  ///         if terminals_to_keep != '*':
  ///             used_terms = {t.name for r in compiled_rules
  ///                                  for t in r.expansion
  ///                                  if isinstance(t, Terminal)}
  ///             terminals, unused = classify_bool(terminals, lambda t: t.name in used_terms or t.name in self.ignore or t.name in terminals_to_keep)
  ///             if unused:
  ///                 logger.debug("Unused terminals: %s", [t.name for t in unused])
  ///
  ///         return terminals, compiled_rules, self.ignore
  /// ```
  Object? compile({
    required Object? start,
    required Object? terminals_to_keep,
  }) =>
      getFunction("compile").call(
        <Object?>[
          start,
          terminals_to_keep,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## term_defs (getter)
  Object? get term_defs => getAttribute("term_defs");

  /// ## term_defs (setter)
  set term_defs(Object? term_defs) => setAttribute("term_defs", term_defs);

  /// ## rule_defs (getter)
  Object? get rule_defs => getAttribute("rule_defs");

  /// ## rule_defs (setter)
  set rule_defs(Object? rule_defs) => setAttribute("rule_defs", rule_defs);

  /// ## ignore (getter)
  Object? get ignore => getAttribute("ignore");

  /// ## ignore (setter)
  set ignore(Object? ignore) => setAttribute("ignore", ignore);
}

/// ## Lark
///
/// ### python docstring
///
/// Main interface for the library.
///
/// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
///
/// Parameters:
///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
///     options: a dictionary controlling various aspects of Lark.
///
/// Example:
///     >>> Lark(r'''start: "foo" ''')
///     Lark(...)
///
///
///
/// **===  General Options  ===**
///
/// start
///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
/// debug
///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
/// strict
///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
/// transformer
///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
/// propagate_positions
///         Propagates positional attributes into the 'meta' attribute of all tree branches.
///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
///                           container_line, container_column, container_end_line, container_end_column)
///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
/// maybe_placeholders
///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
///         (default= ``True``)
/// cache
///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
///
///         - When ``False``, does nothing (default)
///         - When ``True``, caches to a temporary file in the local directory
///         - When given a string, caches to the path pointed by the string
/// regex
///         When True, uses the ``regex`` module instead of the stdlib ``re``.
/// g_regex_flags
///         Flags that are applied to all terminals (both regex and strings)
/// keep_all_tokens
///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
/// tree_class
///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
///
/// **=== Algorithm Options ===**
///
/// parser
///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
///         (there is also a "cyk" option for legacy)
/// lexer
///         Decides whether or not to use a lexer stage
///
///         - "auto" (default): Choose for me based on the parser
///         - "basic": Use a basic lexer
///         - "contextual": Stronger lexer (only works with parser="lalr")
///         - "dynamic": Flexible and powerful (only with parser="earley")
///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
/// ambiguity
///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
///
///         - "resolve": The parser will automatically choose the simplest derivation
///           (it chooses consistently: greedy for tokens, non-greedy for rules)
///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
///         - "forest": The parser will return the root of the shared packed parse forest.
///
/// **=== Misc. / Domain Specific Options ===**
///
/// postlex
///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
/// priority
///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
/// lexer_callbacks
///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
/// use_bytes
///         Accept an input of type ``bytes`` instead of ``str``.
/// edit_terminals
///         A callback for editing the terminals before parse.
/// import_paths
///         A List of either paths or loader functions to specify from where grammars are imported
/// source_path
///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
/// **=== End of Options ===**
///
/// ### python source
/// ```py
/// class Lark(Serialize):
///     """Main interface for the library.
///
///     It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
///
///     Parameters:
///         grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
///         options: a dictionary controlling various aspects of Lark.
///
///     Example:
///         >>> Lark(r'''start: "foo" ''')
///         Lark(...)
///     """
///
///     source_path: str
///     source_grammar: str
///     grammar: 'Grammar'
///     options: LarkOptions
///     lexer: Lexer
///     parser: 'ParsingFrontend'
///     terminals: Collection[TerminalDef]
///
///     def __init__(self, grammar: 'Union[Grammar, str, IO[str]]', **options) -> None:
///         self.options = LarkOptions(options)
///         re_module: types.ModuleType
///
///         # Set regex or re module
///         use_regex = self.options.regex
///         if use_regex:
///             if _has_regex:
///                 re_module = regex
///             else:
///                 raise ImportError('`regex` module must be installed if calling `Lark(regex=True)`.')
///         else:
///             re_module = re
///
///         # Some, but not all file-like objects have a 'name' attribute
///         if self.options.source_path is None:
///             try:
///                 self.source_path = grammar.name  # type: ignore[union-attr]
///             except AttributeError:
///                 self.source_path = '<string>'
///         else:
///             self.source_path = self.options.source_path
///
///         # Drain file-like objects to get their contents
///         try:
///             read = grammar.read  # type: ignore[union-attr]
///         except AttributeError:
///             pass
///         else:
///             grammar = read()
///
///         cache_fn = None
///         cache_sha256 = None
///         if isinstance(grammar, str):
///             self.source_grammar = grammar
///             if self.options.use_bytes:
///                 if not isascii(grammar):
///                     raise ConfigurationError("Grammar must be ascii only, when use_bytes=True")
///
///             if self.options.cache:
///                 if self.options.parser != 'lalr':
///                     raise ConfigurationError("cache only works with parser='lalr' for now")
///
///                 unhashable = ('transformer', 'postlex', 'lexer_callbacks', 'edit_terminals', '_plugins')
///                 options_str = ''.join(k+str(v) for k, v in options.items() if k not in unhashable)
///                 from . import __version__
///                 s = grammar + options_str + __version__ + str(sys.version_info[:2])
///                 cache_sha256 = sha256_digest(s)
///
///                 if isinstance(self.options.cache, str):
///                     cache_fn = self.options.cache
///                 else:
///                     if self.options.cache is not True:
///                         raise ConfigurationError("cache argument must be bool or str")
///
///                     try:
///                         username = getpass.getuser()
///                     except Exception:
///                         # The exception raised may be ImportError or OSError in
///                         # the future.  For the cache, we don't care about the
///                         # specific reason - we just want a username.
///                         username = "unknown"
///
///                     cache_fn = tempfile.gettempdir() + "/.lark_cache_%s_%s_%s_%s.tmp" % (username, cache_sha256, *sys.version_info[:2])
///
///                 old_options = self.options
///                 try:
///                     with FS.open(cache_fn, 'rb') as f:
///                         logger.debug('Loading grammar from cache: %s', cache_fn)
///                         # Remove options that aren't relevant for loading from cache
///                         for name in (set(options) - _LOAD_ALLOWED_OPTIONS):
///                             del options[name]
///                         file_sha256 = f.readline().rstrip(b'\n')
///                         cached_used_files = pickle.load(f)
///                         if file_sha256 == cache_sha256.encode('utf8') and verify_used_files(cached_used_files):
///                             cached_parser_data = pickle.load(f)
///                             self._load(cached_parser_data, **options)
///                             return
///                 except FileNotFoundError:
///                     # The cache file doesn't exist; parse and compose the grammar as normal
///                     pass
///                 except Exception: # We should probably narrow done which errors we catch here.
///                     logger.exception("Failed to load Lark from cache: %r. We will try to carry on.", cache_fn)
///
///                     # In theory, the Lark instance might have been messed up by the call to `_load`.
///                     # In practice the only relevant thing that might have been overwritten should be `options`
///                     self.options = old_options
///
///
///             # Parse the grammar file and compose the grammars
///             self.grammar, used_files = load_grammar(grammar, self.source_path, self.options.import_paths, self.options.keep_all_tokens)
///         else:
///             assert isinstance(grammar, Grammar)
///             self.grammar = grammar
///
///
///         if self.options.lexer == 'auto':
///             if self.options.parser == 'lalr':
///                 self.options.lexer = 'contextual'
///             elif self.options.parser == 'earley':
///                 if self.options.postlex is not None:
///                     logger.info("postlex can't be used with the dynamic lexer, so we use 'basic' instead. "
///                                 "Consider using lalr with contextual instead of earley")
///                     self.options.lexer = 'basic'
///                 else:
///                     self.options.lexer = 'dynamic'
///             elif self.options.parser == 'cyk':
///                 self.options.lexer = 'basic'
///             else:
///                 assert False, self.options.parser
///         lexer = self.options.lexer
///         if isinstance(lexer, type):
///             assert issubclass(lexer, Lexer)     # XXX Is this really important? Maybe just ensure interface compliance
///         else:
///             assert_config(lexer, ('basic', 'contextual', 'dynamic', 'dynamic_complete'))
///             if self.options.postlex is not None and 'dynamic' in lexer:
///                 raise ConfigurationError("Can't use postlex with a dynamic lexer. Use basic or contextual instead")
///
///         if self.options.ambiguity == 'auto':
///             if self.options.parser == 'earley':
///                 self.options.ambiguity = 'resolve'
///         else:
///             assert_config(self.options.parser, ('earley', 'cyk'), "%r doesn't support disambiguation. Use one of these parsers instead: %s")
///
///         if self.options.priority == 'auto':
///             self.options.priority = 'normal'
///
///         if self.options.priority not in _VALID_PRIORITY_OPTIONS:
///             raise ConfigurationError("invalid priority option: %r. Must be one of %r" % (self.options.priority, _VALID_PRIORITY_OPTIONS))
///         if self.options.ambiguity not in _VALID_AMBIGUITY_OPTIONS:
///             raise ConfigurationError("invalid ambiguity option: %r. Must be one of %r" % (self.options.ambiguity, _VALID_AMBIGUITY_OPTIONS))
///
///         if self.options.parser is None:
///             terminals_to_keep = '*'
///         elif self.options.postlex is not None:
///             terminals_to_keep = set(self.options.postlex.always_accept)
///         else:
///             terminals_to_keep = set()
///
///         # Compile the EBNF grammar into BNF
///         self.terminals, self.rules, self.ignore_tokens = self.grammar.compile(self.options.start, terminals_to_keep)
///
///         if self.options.edit_terminals:
///             for t in self.terminals:
///                 self.options.edit_terminals(t)
///
///         self._terminals_dict = {t.name: t for t in self.terminals}
///
///         # If the user asked to invert the priorities, negate them all here.
///         if self.options.priority == 'invert':
///             for rule in self.rules:
///                 if rule.options.priority is not None:
///                     rule.options.priority = -rule.options.priority
///             for term in self.terminals:
///                 term.priority = -term.priority
///         # Else, if the user asked to disable priorities, strip them from the
///         # rules and terminals. This allows the Earley parsers to skip an extra forest walk
///         # for improved performance, if you don't need them (or didn't specify any).
///         elif self.options.priority is None:
///             for rule in self.rules:
///                 if rule.options.priority is not None:
///                     rule.options.priority = None
///             for term in self.terminals:
///                 term.priority = 0
///
///         # TODO Deprecate lexer_callbacks?
///         self.lexer_conf = LexerConf(
///                 self.terminals, re_module, self.ignore_tokens, self.options.postlex,
///                 self.options.lexer_callbacks, self.options.g_regex_flags, use_bytes=self.options.use_bytes, strict=self.options.strict
///             )
///
///         if self.options.parser:
///             self.parser = self._build_parser()
///         elif lexer:
///             self.lexer = self._build_lexer()
///
///         if cache_fn:
///             logger.debug('Saving grammar to cache: %s', cache_fn)
///             try:
///                 with FS.open(cache_fn, 'wb') as f:
///                     assert cache_sha256 is not None
///                     f.write(cache_sha256.encode('utf8') + b'\n')
///                     pickle.dump(used_files, f)
///                     self.save(f, _LOAD_ALLOWED_OPTIONS)
///             except IOError as e:
///                 logger.exception("Failed to save Lark to cache: %r.", cache_fn, e)
///
///     if __doc__:
///         __doc__ += "\n\n" + LarkOptions.OPTIONS_DOC
///
///     __serialize_fields__ = 'parser', 'rules', 'options'
///
///     def _build_lexer(self, dont_ignore: bool=False) -> BasicLexer:
///         lexer_conf = self.lexer_conf
///         if dont_ignore:
///             from copy import copy
///             lexer_conf = copy(lexer_conf)
///             lexer_conf.ignore = ()
///         return BasicLexer(lexer_conf)
///
///     def _prepare_callbacks(self) -> None:
///         self._callbacks = {}
///         # we don't need these callbacks if we aren't building a tree
///         if self.options.ambiguity != 'forest':
///             self._parse_tree_builder = ParseTreeBuilder(
///                     self.rules,
///                     self.options.tree_class or Tree,
///                     self.options.propagate_positions,
///                     self.options.parser != 'lalr' and self.options.ambiguity == 'explicit',
///                     self.options.maybe_placeholders
///                 )
///             self._callbacks = self._parse_tree_builder.create_callback(self.options.transformer)
///         self._callbacks.update(_get_lexer_callbacks(self.options.transformer, self.terminals))
///
///     def _build_parser(self) -> "ParsingFrontend":
///         self._prepare_callbacks()
///         _validate_frontend_args(self.options.parser, self.options.lexer)
///         parser_conf = ParserConf(self.rules, self._callbacks, self.options.start)
///         return _construct_parsing_frontend(
///             self.options.parser,
///             self.options.lexer,
///             self.lexer_conf,
///             parser_conf,
///             options=self.options
///         )
///
///     def save(self, f, exclude_options: Collection[str] = ()) -> None:
///         """Saves the instance into the given file object
///
///         Useful for caching and multiprocessing.
///         """
///         data, m = self.memo_serialize([TerminalDef, Rule])
///         if exclude_options:
///             data["options"] = {n: v for n, v in data["options"].items() if n not in exclude_options}
///         pickle.dump({'data': data, 'memo': m}, f, protocol=pickle.HIGHEST_PROTOCOL)
///
///     @classmethod
///     def load(cls: Type[_T], f) -> _T:
///         """Loads an instance from the given file object
///
///         Useful for caching and multiprocessing.
///         """
///         inst = cls.__new__(cls)
///         return inst._load(f)
///
///     def _deserialize_lexer_conf(self, data: Dict[str, Any], memo: Dict[int, Union[TerminalDef, Rule]], options: LarkOptions) -> LexerConf:
///         lexer_conf = LexerConf.deserialize(data['lexer_conf'], memo)
///         lexer_conf.callbacks = options.lexer_callbacks or {}
///         lexer_conf.re_module = regex if options.regex else re
///         lexer_conf.use_bytes = options.use_bytes
///         lexer_conf.g_regex_flags = options.g_regex_flags
///         lexer_conf.skip_validation = True
///         lexer_conf.postlex = options.postlex
///         return lexer_conf
///
///     def _load(self: _T, f: Any, **kwargs) -> _T:
///         if isinstance(f, dict):
///             d = f
///         else:
///             d = pickle.load(f)
///         memo_json = d['memo']
///         data = d['data']
///
///         assert memo_json
///         memo = SerializeMemoizer.deserialize(memo_json, {'Rule': Rule, 'TerminalDef': TerminalDef}, {})
///         options = dict(data['options'])
///         if (set(kwargs) - _LOAD_ALLOWED_OPTIONS) & set(LarkOptions._defaults):
///             raise ConfigurationError("Some options are not allowed when loading a Parser: {}"
///                              .format(set(kwargs) - _LOAD_ALLOWED_OPTIONS))
///         options.update(kwargs)
///         self.options = LarkOptions.deserialize(options, memo)
///         self.rules = [Rule.deserialize(r, memo) for r in data['rules']]
///         self.source_path = '<deserialized>'
///         _validate_frontend_args(self.options.parser, self.options.lexer)
///         self.lexer_conf = self._deserialize_lexer_conf(data['parser'], memo, self.options)
///         self.terminals = self.lexer_conf.terminals
///         self._prepare_callbacks()
///         self._terminals_dict = {t.name: t for t in self.terminals}
///         self.parser = _deserialize_parsing_frontend(
///             data['parser'],
///             memo,
///             self.lexer_conf,
///             self._callbacks,
///             self.options,  # Not all, but multiple attributes are used
///         )
///         return self
///
///     @classmethod
///     def _load_from_dict(cls, data, memo, **kwargs):
///         inst = cls.__new__(cls)
///         return inst._load({'data': data, 'memo': memo}, **kwargs)
///
///     @classmethod
///     def open(cls: Type[_T], grammar_filename: str, rel_to: Optional[str]=None, **options) -> _T:
///         """Create an instance of Lark with the grammar given by its filename
///
///         If ``rel_to`` is provided, the function will find the grammar filename in relation to it.
///
///         Example:
///
///             >>> Lark.open("grammar_file.lark", rel_to=__file__, parser="lalr")
///             Lark(...)
///
///         """
///         if rel_to:
///             basepath = os.path.dirname(rel_to)
///             grammar_filename = os.path.join(basepath, grammar_filename)
///         with open(grammar_filename, encoding='utf8') as f:
///             return cls(f, **options)
///
///     @classmethod
///     def open_from_package(cls: Type[_T], package: str, grammar_path: str, search_paths: 'Sequence[str]'=[""], **options) -> _T:
///         """Create an instance of Lark with the grammar loaded from within the package `package`.
///         This allows grammar loading from zipapps.
///
///         Imports in the grammar will use the `package` and `search_paths` provided, through `FromPackageLoader`
///
///         Example:
///
///             Lark.open_from_package(__name__, "example.lark", ("grammars",), parser=...)
///         """
///         package_loader = FromPackageLoader(package, search_paths)
///         full_path, text = package_loader(None, grammar_path)
///         options.setdefault('source_path', full_path)
///         options.setdefault('import_paths', [])
///         options['import_paths'].append(package_loader)
///         return cls(text, **options)
///
///     def __repr__(self):
///         return 'Lark(open(%r), parser=%r, lexer=%r, ...)' % (self.source_path, self.options.parser, self.options.lexer)
///
///
///     def lex(self, text: str, dont_ignore: bool=False) -> Iterator[Token]:
///         """Only lex (and postlex) the text, without parsing it. Only relevant when lexer='basic'
///
///         When dont_ignore=True, the lexer will return all tokens, even those marked for %ignore.
///
///         :raises UnexpectedCharacters: In case the lexer cannot find a suitable match.
///         """
///         lexer: Lexer
///         if not hasattr(self, 'lexer') or dont_ignore:
///             lexer = self._build_lexer(dont_ignore)
///         else:
///             lexer = self.lexer
///         lexer_thread = LexerThread.from_text(lexer, text)
///         stream = lexer_thread.lex(None)
///         if self.options.postlex:
///             return self.options.postlex.process(stream)
///         return stream
///
///     def get_terminal(self, name: str) -> TerminalDef:
///         """Get information about a terminal"""
///         return self._terminals_dict[name]
///
///     def parse_interactive(self, text: Optional[str]=None, start: Optional[str]=None) -> 'InteractiveParser':
///         """Start an interactive parsing session.
///
///         Parameters:
///             text (str, optional): Text to be parsed. Required for ``resume_parse()``.
///             start (str, optional): Start symbol
///
///         Returns:
///             A new InteractiveParser instance.
///
///         See Also: ``Lark.parse()``
///         """
///         return self.parser.parse_interactive(text, start=start)
///
///     def parse(self, text: str, start: Optional[str]=None, on_error: 'Optional[Callable[[UnexpectedInput], bool]]'=None) -> 'ParseTree':
///         """Parse the given text, according to the options provided.
///
///         Parameters:
///             text (str): Text to be parsed.
///             start (str, optional): Required if Lark was given multiple possible start symbols (using the start option).
///             on_error (function, optional): if provided, will be called on UnexpectedToken error. Return true to resume parsing.
///                 LALR only. See examples/advanced/error_handling.py for an example of how to use on_error.
///
///         Returns:
///             If a transformer is supplied to ``__init__``, returns whatever is the
///             result of the transformation. Otherwise, returns a Tree instance.
///
///         :raises UnexpectedInput: On a parse error, one of these sub-exceptions will rise:
///                 ``UnexpectedCharacters``, ``UnexpectedToken``, or ``UnexpectedEOF``.
///                 For convenience, these sub-exceptions also inherit from ``ParserError`` and ``LexerError``.
///
///         """
///         return self.parser.parse(text, start=start, on_error=on_error)
/// ```
final class Lark extends PythonClass {
  factory Lark({
    required Object? grammar,
    Map<String, Object?> options = const <String, Object?>{},
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lark",
        "Lark",
        Lark.from,
        <Object?>[
          grammar,
        ],
        <String, Object?>{
          ...options,
        },
      );

  Lark.from(super.pythonClass) : super.from();

  /// ## get_terminal
  ///
  /// ### python docstring
  ///
  /// Get information about a terminal
  ///
  /// ### python source
  /// ```py
  /// def get_terminal(self, name: str) -> TerminalDef:
  ///         """Get information about a terminal"""
  ///         return self._terminals_dict[name]
  /// ```
  TerminalDef get_terminal({
    required String name,
  }) =>
      TerminalDef.from(
        getFunction("get_terminal").call(
          <Object?>[
            name,
          ],
          kwargs: <String, Object?>{},
        ),
      );

  /// ## lex
  ///
  /// ### python docstring
  ///
  /// Only lex (and postlex) the text, without parsing it. Only relevant when lexer='basic'
  ///
  /// When dont_ignore=True, the lexer will return all tokens, even those marked for %ignore.
  ///
  /// :raises UnexpectedCharacters: In case the lexer cannot find a suitable match.
  ///
  /// ### python source
  /// ```py
  /// def lex(self, text: str, dont_ignore: bool=False) -> Iterator[Token]:
  ///         """Only lex (and postlex) the text, without parsing it. Only relevant when lexer='basic'
  ///
  ///         When dont_ignore=True, the lexer will return all tokens, even those marked for %ignore.
  ///
  ///         :raises UnexpectedCharacters: In case the lexer cannot find a suitable match.
  ///         """
  ///         lexer: Lexer
  ///         if not hasattr(self, 'lexer') or dont_ignore:
  ///             lexer = self._build_lexer(dont_ignore)
  ///         else:
  ///             lexer = self.lexer
  ///         lexer_thread = LexerThread.from_text(lexer, text)
  ///         stream = lexer_thread.lex(None)
  ///         if self.options.postlex:
  ///             return self.options.postlex.process(stream)
  ///         return stream
  /// ```
  Iterator<Token> lex({
    required String text,
    bool dont_ignore = false,
  }) =>
      TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("lex").call(
            <Object?>[
              text,
              dont_ignore,
            ],
            kwargs: <String, Object?>{},
          ),
        ),
      )
          .transform((e) => Token.from(
                e,
              ))
          .cast<Token>();

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
  /// ### python docstring
  ///
  /// Parse the given text, according to the options provided.
  ///
  /// Parameters:
  ///     text (str): Text to be parsed.
  ///     start (str, optional): Required if Lark was given multiple possible start symbols (using the start option).
  ///     on_error (function, optional): if provided, will be called on UnexpectedToken error. Return true to resume parsing.
  ///         LALR only. See examples/advanced/error_handling.py for an example of how to use on_error.
  ///
  /// Returns:
  ///     If a transformer is supplied to ``__init__``, returns whatever is the
  ///     result of the transformation. Otherwise, returns a Tree instance.
  ///
  /// :raises UnexpectedInput: On a parse error, one of these sub-exceptions will rise:
  ///         ``UnexpectedCharacters``, ``UnexpectedToken``, or ``UnexpectedEOF``.
  ///         For convenience, these sub-exceptions also inherit from ``ParserError`` and ``LexerError``.
  ///
  /// ### python source
  /// ```py
  /// def parse(self, text: str, start: Optional[str]=None, on_error: 'Optional[Callable[[UnexpectedInput], bool]]'=None) -> 'ParseTree':
  ///         """Parse the given text, according to the options provided.
  ///
  ///         Parameters:
  ///             text (str): Text to be parsed.
  ///             start (str, optional): Required if Lark was given multiple possible start symbols (using the start option).
  ///             on_error (function, optional): if provided, will be called on UnexpectedToken error. Return true to resume parsing.
  ///                 LALR only. See examples/advanced/error_handling.py for an example of how to use on_error.
  ///
  ///         Returns:
  ///             If a transformer is supplied to ``__init__``, returns whatever is the
  ///             result of the transformation. Otherwise, returns a Tree instance.
  ///
  ///         :raises UnexpectedInput: On a parse error, one of these sub-exceptions will rise:
  ///                 ``UnexpectedCharacters``, ``UnexpectedToken``, or ``UnexpectedEOF``.
  ///                 For convenience, these sub-exceptions also inherit from ``ParserError`` and ``LexerError``.
  ///
  ///         """
  ///         return self.parser.parse(text, start=start, on_error=on_error)
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
  /// ### python docstring
  ///
  /// Start an interactive parsing session.
  ///
  /// Parameters:
  ///     text (str, optional): Text to be parsed. Required for ``resume_parse()``.
  ///     start (str, optional): Start symbol
  ///
  /// Returns:
  ///     A new InteractiveParser instance.
  ///
  /// See Also: ``Lark.parse()``
  ///
  /// ### python source
  /// ```py
  /// def parse_interactive(self, text: Optional[str]=None, start: Optional[str]=None) -> 'InteractiveParser':
  ///         """Start an interactive parsing session.
  ///
  ///         Parameters:
  ///             text (str, optional): Text to be parsed. Required for ``resume_parse()``.
  ///             start (str, optional): Start symbol
  ///
  ///         Returns:
  ///             A new InteractiveParser instance.
  ///
  ///         See Also: ``Lark.parse()``
  ///         """
  ///         return self.parser.parse_interactive(text, start=start)
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

  /// ## save
  ///
  /// ### python docstring
  ///
  /// Saves the instance into the given file object
  ///
  /// Useful for caching and multiprocessing.
  ///
  /// ### python source
  /// ```py
  /// def save(self, f, exclude_options: Collection[str] = ()) -> None:
  ///         """Saves the instance into the given file object
  ///
  ///         Useful for caching and multiprocessing.
  ///         """
  ///         data, m = self.memo_serialize([TerminalDef, Rule])
  ///         if exclude_options:
  ///             data["options"] = {n: v for n, v in data["options"].items() if n not in exclude_options}
  ///         pickle.dump({'data': data, 'memo': m}, f, protocol=pickle.HIGHEST_PROTOCOL)
  /// ```
  Null save({
    required Object? f,
    Object? exclude_options = const [],
  }) =>
      getFunction("save").call(
        <Object?>[
          f,
          exclude_options,
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
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## load (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get load => getAttribute("load");

  /// ## load (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set load(Object? load) => setAttribute("load", load);

  /// ## open (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get open => getAttribute("open");

  /// ## open (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set open(Object? open) => setAttribute("open", open);

  /// ## open_from_package (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get open_from_package => getAttribute("open_from_package");

  /// ## open_from_package (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set open_from_package(Object? open_from_package) =>
      setAttribute("open_from_package", open_from_package);

  /// ## options (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get options => getAttribute("options");

  /// ## options (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set options(Object? options) => setAttribute("options", options);

  /// ## source_path (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get source_path => getAttribute("source_path");

  /// ## source_path (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set source_path(Object? source_path) =>
      setAttribute("source_path", source_path);

  /// ## source_grammar (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get source_grammar => getAttribute("source_grammar");

  /// ## source_grammar (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set source_grammar(Object? source_grammar) =>
      setAttribute("source_grammar", source_grammar);

  /// ## parser (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get parser => getAttribute("parser");

  /// ## parser (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set parser(Object? parser) => setAttribute("parser", parser);

  /// ## grammar (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get grammar => getAttribute("grammar");

  /// ## grammar (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set grammar(Object? grammar) => setAttribute("grammar", grammar);

  /// ## lexer (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get lexer => getAttribute("lexer");

  /// ## lexer (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set lexer(Object? lexer) => setAttribute("lexer", lexer);

  /// ## lexer_conf (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get lexer_conf => getAttribute("lexer_conf");

  /// ## lexer_conf (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set lexer_conf(Object? lexer_conf) => setAttribute("lexer_conf", lexer_conf);
}

/// ## LarkOptions
///
/// ### python docstring
///
/// Specifies the options for Lark
///
///
/// **===  General Options  ===**
///
/// start
///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
/// debug
///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
/// strict
///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
/// transformer
///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
/// propagate_positions
///         Propagates positional attributes into the 'meta' attribute of all tree branches.
///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
///                           container_line, container_column, container_end_line, container_end_column)
///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
/// maybe_placeholders
///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
///         (default= ``True``)
/// cache
///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
///
///         - When ``False``, does nothing (default)
///         - When ``True``, caches to a temporary file in the local directory
///         - When given a string, caches to the path pointed by the string
/// regex
///         When True, uses the ``regex`` module instead of the stdlib ``re``.
/// g_regex_flags
///         Flags that are applied to all terminals (both regex and strings)
/// keep_all_tokens
///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
/// tree_class
///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
///
/// **=== Algorithm Options ===**
///
/// parser
///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
///         (there is also a "cyk" option for legacy)
/// lexer
///         Decides whether or not to use a lexer stage
///
///         - "auto" (default): Choose for me based on the parser
///         - "basic": Use a basic lexer
///         - "contextual": Stronger lexer (only works with parser="lalr")
///         - "dynamic": Flexible and powerful (only with parser="earley")
///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
/// ambiguity
///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
///
///         - "resolve": The parser will automatically choose the simplest derivation
///           (it chooses consistently: greedy for tokens, non-greedy for rules)
///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
///         - "forest": The parser will return the root of the shared packed parse forest.
///
/// **=== Misc. / Domain Specific Options ===**
///
/// postlex
///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
/// priority
///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
/// lexer_callbacks
///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
/// use_bytes
///         Accept an input of type ``bytes`` instead of ``str``.
/// edit_terminals
///         A callback for editing the terminals before parse.
/// import_paths
///         A List of either paths or loader functions to specify from where grammars are imported
/// source_path
///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
/// **=== End of Options ===**
///
/// ### python source
/// ```py
/// class LarkOptions(Serialize):
///     """Specifies the options for Lark
///
///     """
///
///     start: List[str]
///     debug: bool
///     strict: bool
///     transformer: 'Optional[Transformer]'
///     propagate_positions: Union[bool, str]
///     maybe_placeholders: bool
///     cache: Union[bool, str]
///     regex: bool
///     g_regex_flags: int
///     keep_all_tokens: bool
///     tree_class: Any
///     parser: _ParserArgType
///     lexer: _LexerArgType
///     ambiguity: 'Literal["auto", "resolve", "explicit", "forest"]'
///     postlex: Optional[PostLex]
///     priority: 'Optional[Literal["auto", "normal", "invert"]]'
///     lexer_callbacks: Dict[str, Callable[[Token], Token]]
///     use_bytes: bool
///     edit_terminals: Optional[Callable[[TerminalDef], TerminalDef]]
///     import_paths: 'List[Union[str, Callable[[Union[None, str, PackageResource], str], Tuple[str, str]]]]'
///     source_path: Optional[str]
///
///     OPTIONS_DOC = """
///     **===  General Options  ===**
///
///     start
///             The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
///     debug
///             Display debug information and extra warnings. Use only when debugging (Default: ``False``)
///             When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
///     strict
///             Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
///     transformer
///             Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
///     propagate_positions
///             Propagates positional attributes into the 'meta' attribute of all tree branches.
///             Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
///                               container_line, container_column, container_end_line, container_end_column)
///             Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
///     maybe_placeholders
///             When ``True``, the ``[]`` operator returns ``None`` when not matched.
///             When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
///             (default= ``True``)
///     cache
///             Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
///
///             - When ``False``, does nothing (default)
///             - When ``True``, caches to a temporary file in the local directory
///             - When given a string, caches to the path pointed by the string
///     regex
///             When True, uses the ``regex`` module instead of the stdlib ``re``.
///     g_regex_flags
///             Flags that are applied to all terminals (both regex and strings)
///     keep_all_tokens
///             Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
///     tree_class
///             Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
///
///     **=== Algorithm Options ===**
///
///     parser
///             Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
///             (there is also a "cyk" option for legacy)
///     lexer
///             Decides whether or not to use a lexer stage
///
///             - "auto" (default): Choose for me based on the parser
///             - "basic": Use a basic lexer
///             - "contextual": Stronger lexer (only works with parser="lalr")
///             - "dynamic": Flexible and powerful (only with parser="earley")
///             - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
///     ambiguity
///             Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
///
///             - "resolve": The parser will automatically choose the simplest derivation
///               (it chooses consistently: greedy for tokens, non-greedy for rules)
///             - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
///             - "forest": The parser will return the root of the shared packed parse forest.
///
///     **=== Misc. / Domain Specific Options ===**
///
///     postlex
///             Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
///     priority
///             How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
///     lexer_callbacks
///             Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
///     use_bytes
///             Accept an input of type ``bytes`` instead of ``str``.
///     edit_terminals
///             A callback for editing the terminals before parse.
///     import_paths
///             A List of either paths or loader functions to specify from where grammars are imported
///     source_path
///             Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
///     **=== End of Options ===**
///     """
///     if __doc__:
///         __doc__ += OPTIONS_DOC
///
///
///     # Adding a new option needs to be done in multiple places:
///     # - In the dictionary below. This is the primary truth of which options `Lark.__init__` accepts
///     # - In the docstring above. It is used both for the docstring of `LarkOptions` and `Lark`, and in readthedocs
///     # - As an attribute of `LarkOptions` above
///     # - Potentially in `_LOAD_ALLOWED_OPTIONS` below this class, when the option doesn't change how the grammar is loaded
///     # - Potentially in `lark.tools.__init__`, if it makes sense, and it can easily be passed as a cmd argument
///     _defaults: Dict[str, Any] = {
///         'debug': False,
///         'strict': False,
///         'keep_all_tokens': False,
///         'tree_class': None,
///         'cache': False,
///         'postlex': None,
///         'parser': 'earley',
///         'lexer': 'auto',
///         'transformer': None,
///         'start': 'start',
///         'priority': 'auto',
///         'ambiguity': 'auto',
///         'regex': False,
///         'propagate_positions': False,
///         'lexer_callbacks': {},
///         'maybe_placeholders': True,
///         'edit_terminals': None,
///         'g_regex_flags': 0,
///         'use_bytes': False,
///         'import_paths': [],
///         'source_path': None,
///         '_plugins': {},
///     }
///
///     def __init__(self, options_dict: Dict[str, Any]) -> None:
///         o = dict(options_dict)
///
///         options = {}
///         for name, default in self._defaults.items():
///             if name in o:
///                 value = o.pop(name)
///                 if isinstance(default, bool) and name not in ('cache', 'use_bytes', 'propagate_positions'):
///                     value = bool(value)
///             else:
///                 value = default
///
///             options[name] = value
///
///         if isinstance(options['start'], str):
///             options['start'] = [options['start']]
///
///         self.__dict__['options'] = options
///
///
///         assert_config(self.parser, ('earley', 'lalr', 'cyk', None))
///
///         if self.parser == 'earley' and self.transformer:
///             raise ConfigurationError('Cannot specify an embedded transformer when using the Earley algorithm. '
///                              'Please use your transformer on the resulting parse tree, or use a different algorithm (i.e. LALR)')
///
///         if o:
///             raise ConfigurationError("Unknown options: %s" % o.keys())
///
///     def __getattr__(self, name: str) -> Any:
///         try:
///             return self.__dict__['options'][name]
///         except KeyError as e:
///             raise AttributeError(e)
///
///     def __setattr__(self, name: str, value: str) -> None:
///         assert_config(name, self.options.keys(), "%r isn't a valid option. Expected one of: %s")
///         self.options[name] = value
///
///     def serialize(self, memo = None) -> Dict[str, Any]:
///         return self.options
///
///     @classmethod
///     def deserialize(cls, data: Dict[str, Any], memo: Dict[int, Union[TerminalDef, Rule]]) -> "LarkOptions":
///         return cls(data)
/// ```
final class LarkOptions extends PythonClass {
  factory LarkOptions({
    required Object? options_dict,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lark",
        "LarkOptions",
        LarkOptions.from,
        <Object?>[
          options_dict,
        ],
        <String, Object?>{},
      );

  LarkOptions.from(super.pythonClass) : super.from();

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
  ///         return self.options
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
  /// Specifies the options for Lark
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  ///
  /// ### python docstring
  ///
  /// Specifies the options for Lark
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## OPTIONS_DOC (getter)
  ///
  /// ### python docstring
  ///
  /// Specifies the options for Lark
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get OPTIONS_DOC => getAttribute("OPTIONS_DOC");

  /// ## OPTIONS_DOC (setter)
  ///
  /// ### python docstring
  ///
  /// Specifies the options for Lark
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set OPTIONS_DOC(Object? OPTIONS_DOC) =>
      setAttribute("OPTIONS_DOC", OPTIONS_DOC);
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
        "lark.lark",
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
      PythonFfiDart.instance.importClass(
        "lark.lark",
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
      PythonFfiDart.instance.importClass(
        "lark.lark",
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

/// ## PackageResource
///
/// ### python docstring
///
/// PackageResource(pkg_name, path)
final class PackageResource extends PythonClass {
  factory PackageResource() => PythonFfiDart.instance.importClass(
        "lark.lark",
        "PackageResource",
        PackageResource.from,
        <Object?>[],
      );

  PackageResource.from(super.pythonClass) : super.from();

  /// ## path (getter)
  ///
  /// ### python docstring
  ///
  /// PackageResource(pkg_name, path)
  Object? get path => getAttribute("path");

  /// ## path (setter)
  ///
  /// ### python docstring
  ///
  /// PackageResource(pkg_name, path)
  set path(Object? path) => setAttribute("path", path);

  /// ## pkg_name (getter)
  ///
  /// ### python docstring
  ///
  /// PackageResource(pkg_name, path)
  Object? get pkg_name => getAttribute("pkg_name");

  /// ## pkg_name (setter)
  ///
  /// ### python docstring
  ///
  /// PackageResource(pkg_name, path)
  set pkg_name(Object? pkg_name) => setAttribute("pkg_name", pkg_name);

  /// ## count (getter)
  ///
  /// ### python docstring
  ///
  /// PackageResource(pkg_name, path)
  Object? get count => getAttribute("count");

  /// ## count (setter)
  ///
  /// ### python docstring
  ///
  /// PackageResource(pkg_name, path)
  set count(Object? count) => setAttribute("count", count);

  /// ## index (getter)
  ///
  /// ### python docstring
  ///
  /// PackageResource(pkg_name, path)
  Object? get index => getAttribute("index");

  /// ## index (setter)
  ///
  /// ### python docstring
  ///
  /// PackageResource(pkg_name, path)
  set index(Object? index) => setAttribute("index", index);
}

/// ## ParseTreeBuilder
///
/// ### python source
/// ```py
/// class ParseTreeBuilder:
///     def __init__(self, rules, tree_class, propagate_positions=False, ambiguous=False, maybe_placeholders=False):
///         self.tree_class = tree_class
///         self.propagate_positions = propagate_positions
///         self.ambiguous = ambiguous
///         self.maybe_placeholders = maybe_placeholders
///
///         self.rule_builders = list(self._init_builders(rules))
///
///     def _init_builders(self, rules):
///         propagate_positions = make_propagate_positions(self.propagate_positions)
///
///         for rule in rules:
///             options = rule.options
///             keep_all_tokens = options.keep_all_tokens
///             expand_single_child = options.expand1
///
///             wrapper_chain = list(filter(None, [
///                 (expand_single_child and not rule.alias) and ExpandSingleChild,
///                 maybe_create_child_filter(rule.expansion, keep_all_tokens, self.ambiguous, options.empty_indices if self.maybe_placeholders else None),
///                 propagate_positions,
///                 self.ambiguous and maybe_create_ambiguous_expander(self.tree_class, rule.expansion, keep_all_tokens),
///                 self.ambiguous and partial(AmbiguousIntermediateExpander, self.tree_class)
///             ]))
///
///             yield rule, wrapper_chain
///
///     def create_callback(self, transformer=None):
///         callbacks = {}
///
///         default_handler = getattr(transformer, '__default__', None)
///         if default_handler:
///             def default_callback(data, children):
///                 return default_handler(data, children, None)
///         else:
///             default_callback = self.tree_class
///
///         for rule, wrapper_chain in self.rule_builders:
///
///             user_callback_name = rule.alias or rule.options.template_source or rule.origin.name
///             try:
///                 f = getattr(transformer, user_callback_name)
///                 wrapper = getattr(f, 'visit_wrapper', None)
///                 if wrapper is not None:
///                     f = apply_visit_wrapper(f, user_callback_name, wrapper)
///                 elif isinstance(transformer, Transformer_InPlace):
///                     f = inplace_transformer(f)
///             except AttributeError:
///                 f = partial(default_callback, user_callback_name)
///
///             for w in wrapper_chain:
///                 f = w(f)
///
///             if rule in callbacks:
///                 raise GrammarError("Rule '%s' already exists" % (rule,))
///
///             callbacks[rule] = f
///
///         return callbacks
/// ```
final class ParseTreeBuilder extends PythonClass {
  factory ParseTreeBuilder({
    required Object? rules,
    required Object? tree_class,
    Object? propagate_positions = false,
    Object? ambiguous = false,
    Object? maybe_placeholders = false,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lark",
        "ParseTreeBuilder",
        ParseTreeBuilder.from,
        <Object?>[
          rules,
          tree_class,
          propagate_positions,
          ambiguous,
          maybe_placeholders,
        ],
        <String, Object?>{},
      );

  ParseTreeBuilder.from(super.pythonClass) : super.from();

  /// ## create_callback
  ///
  /// ### python source
  /// ```py
  /// def create_callback(self, transformer=None):
  ///         callbacks = {}
  ///
  ///         default_handler = getattr(transformer, '__default__', None)
  ///         if default_handler:
  ///             def default_callback(data, children):
  ///                 return default_handler(data, children, None)
  ///         else:
  ///             default_callback = self.tree_class
  ///
  ///         for rule, wrapper_chain in self.rule_builders:
  ///
  ///             user_callback_name = rule.alias or rule.options.template_source or rule.origin.name
  ///             try:
  ///                 f = getattr(transformer, user_callback_name)
  ///                 wrapper = getattr(f, 'visit_wrapper', None)
  ///                 if wrapper is not None:
  ///                     f = apply_visit_wrapper(f, user_callback_name, wrapper)
  ///                 elif isinstance(transformer, Transformer_InPlace):
  ///                     f = inplace_transformer(f)
  ///             except AttributeError:
  ///                 f = partial(default_callback, user_callback_name)
  ///
  ///             for w in wrapper_chain:
  ///                 f = w(f)
  ///
  ///             if rule in callbacks:
  ///                 raise GrammarError("Rule '%s' already exists" % (rule,))
  ///
  ///             callbacks[rule] = f
  ///
  ///         return callbacks
  /// ```
  Object? create_callback({
    Object? transformer,
  }) =>
      getFunction("create_callback").call(
        <Object?>[
          transformer,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## tree_class (getter)
  Object? get tree_class => getAttribute("tree_class");

  /// ## tree_class (setter)
  set tree_class(Object? tree_class) => setAttribute("tree_class", tree_class);

  /// ## propagate_positions (getter)
  Object? get propagate_positions => getAttribute("propagate_positions");

  /// ## propagate_positions (setter)
  set propagate_positions(Object? propagate_positions) =>
      setAttribute("propagate_positions", propagate_positions);

  /// ## ambiguous (getter)
  Object? get ambiguous => getAttribute("ambiguous");

  /// ## ambiguous (setter)
  set ambiguous(Object? ambiguous) => setAttribute("ambiguous", ambiguous);

  /// ## maybe_placeholders (getter)
  Object? get maybe_placeholders => getAttribute("maybe_placeholders");

  /// ## maybe_placeholders (setter)
  set maybe_placeholders(Object? maybe_placeholders) =>
      setAttribute("maybe_placeholders", maybe_placeholders);

  /// ## rule_builders (getter)
  Object? get rule_builders => getAttribute("rule_builders");

  /// ## rule_builders (setter)
  set rule_builders(Object? rule_builders) =>
      setAttribute("rule_builders", rule_builders);
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
      PythonFfiDart.instance.importClass(
        "lark.lark",
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

/// ## PostLex
///
/// ### python docstring
///
/// Helper class that provides a standard way to create an ABC using
/// inheritance.
///
/// ### python source
/// ```py
/// class PostLex(ABC):
///     @abstractmethod
///     def process(self, stream: Iterator[Token]) -> Iterator[Token]:
///         return stream
///
///     always_accept: Iterable[str] = ()
/// ```
final class PostLex extends PythonClass {
  factory PostLex() => PythonFfiDart.instance.importClass(
        "lark.lark",
        "PostLex",
        PostLex.from,
        <Object?>[],
      );

  PostLex.from(super.pythonClass) : super.from();

  /// ## process
  ///
  /// ### python source
  /// ```py
  /// @abstractmethod
  ///     def process(self, stream: Iterator[Token]) -> Iterator[Token]:
  ///         return stream
  /// ```
  Iterator<Token> process({
    required Iterator<Token> stream,
  }) =>
      TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("process").call(
            <Object?>[
              stream,
            ],
            kwargs: <String, Object?>{},
          ),
        ),
      )
          .transform((e) => Token.from(
                e,
              ))
          .cast<Token>();

  /// ## always_accept (getter)
  ///
  /// ### python docstring
  ///
  /// Helper class that provides a standard way to create an ABC using
  /// inheritance.
  Object? get always_accept => getAttribute("always_accept");

  /// ## always_accept (setter)
  ///
  /// ### python docstring
  ///
  /// Helper class that provides a standard way to create an ABC using
  /// inheritance.
  set always_accept(Object? always_accept) =>
      setAttribute("always_accept", always_accept);
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
        "lark.lark",
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
        "lark.lark",
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
        "lark.lark",
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
    required Object? pattern,
    int priority = 0,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lark",
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
        "lark.lark",
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
        "lark.lark",
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
        "lark.lark",
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

/// ## lark
///
/// ### python source
/// ```py
/// from abc import ABC, abstractmethod
/// import getpass
/// import sys, os, pickle
/// import tempfile
/// import types
/// import re
/// from typing import (
///     TypeVar, Type, List, Dict, Iterator, Callable, Union, Optional, Sequence,
///     Tuple, Iterable, IO, Any, TYPE_CHECKING, Collection
/// )
/// if TYPE_CHECKING:
///     from .parsers.lalr_interactive_parser import InteractiveParser
///     from .tree import ParseTree
///     from .visitors import Transformer
///     if sys.version_info >= (3, 8):
///         from typing import Literal
///     else:
///         from typing_extensions import Literal
///     from .parser_frontends import ParsingFrontend
///
/// from .exceptions import ConfigurationError, assert_config, UnexpectedInput
/// from .utils import Serialize, SerializeMemoizer, FS, isascii, logger
/// from .load_grammar import load_grammar, FromPackageLoader, Grammar, verify_used_files, PackageResource, sha256_digest
/// from .tree import Tree
/// from .common import LexerConf, ParserConf, _ParserArgType, _LexerArgType
///
/// from .lexer import Lexer, BasicLexer, TerminalDef, LexerThread, Token
/// from .parse_tree_builder import ParseTreeBuilder
/// from .parser_frontends import _validate_frontend_args, _get_lexer_callbacks, _deserialize_parsing_frontend, _construct_parsing_frontend
/// from .grammar import Rule
///
///
/// try:
///     import regex
///     _has_regex = True
/// except ImportError:
///     _has_regex = False
///
///
/// ###{standalone
///
///
/// class PostLex(ABC):
///     @abstractmethod
///     def process(self, stream: Iterator[Token]) -> Iterator[Token]:
///         return stream
///
///     always_accept: Iterable[str] = ()
///
/// class LarkOptions(Serialize):
///     """Specifies the options for Lark
///
///     """
///
///     start: List[str]
///     debug: bool
///     strict: bool
///     transformer: 'Optional[Transformer]'
///     propagate_positions: Union[bool, str]
///     maybe_placeholders: bool
///     cache: Union[bool, str]
///     regex: bool
///     g_regex_flags: int
///     keep_all_tokens: bool
///     tree_class: Any
///     parser: _ParserArgType
///     lexer: _LexerArgType
///     ambiguity: 'Literal["auto", "resolve", "explicit", "forest"]'
///     postlex: Optional[PostLex]
///     priority: 'Optional[Literal["auto", "normal", "invert"]]'
///     lexer_callbacks: Dict[str, Callable[[Token], Token]]
///     use_bytes: bool
///     edit_terminals: Optional[Callable[[TerminalDef], TerminalDef]]
///     import_paths: 'List[Union[str, Callable[[Union[None, str, PackageResource], str], Tuple[str, str]]]]'
///     source_path: Optional[str]
///
///     OPTIONS_DOC = """
///     **===  General Options  ===**
///
///     start
///             The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
///     debug
///             Display debug information and extra warnings. Use only when debugging (Default: ``False``)
///             When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
///     strict
///             Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
///     transformer
///             Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
///     propagate_positions
///             Propagates positional attributes into the 'meta' attribute of all tree branches.
///             Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
///                               container_line, container_column, container_end_line, container_end_column)
///             Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
///     maybe_placeholders
///             When ``True``, the ``[]`` operator returns ``None`` when not matched.
///             When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
///             (default= ``True``)
///     cache
///             Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
///
///             - When ``False``, does nothing (default)
///             - When ``True``, caches to a temporary file in the local directory
///             - When given a string, caches to the path pointed by the string
///     regex
///             When True, uses the ``regex`` module instead of the stdlib ``re``.
///     g_regex_flags
///             Flags that are applied to all terminals (both regex and strings)
///     keep_all_tokens
///             Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
///     tree_class
///             Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
///
///     **=== Algorithm Options ===**
///
///     parser
///             Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
///             (there is also a "cyk" option for legacy)
///     lexer
///             Decides whether or not to use a lexer stage
///
///             - "auto" (default): Choose for me based on the parser
///             - "basic": Use a basic lexer
///             - "contextual": Stronger lexer (only works with parser="lalr")
///             - "dynamic": Flexible and powerful (only with parser="earley")
///             - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
///     ambiguity
///             Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
///
///             - "resolve": The parser will automatically choose the simplest derivation
///               (it chooses consistently: greedy for tokens, non-greedy for rules)
///             - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
///             - "forest": The parser will return the root of the shared packed parse forest.
///
///     **=== Misc. / Domain Specific Options ===**
///
///     postlex
///             Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
///     priority
///             How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
///     lexer_callbacks
///             Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
///     use_bytes
///             Accept an input of type ``bytes`` instead of ``str``.
///     edit_terminals
///             A callback for editing the terminals before parse.
///     import_paths
///             A List of either paths or loader functions to specify from where grammars are imported
///     source_path
///             Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
///     **=== End of Options ===**
///     """
///     if __doc__:
///         __doc__ += OPTIONS_DOC
///
///
///     # Adding a new option needs to be done in multiple places:
///     # - In the dictionary below. This is the primary truth of which options `Lark.__init__` accepts
///     # - In the docstring above. It is used both for the docstring of `LarkOptions` and `Lark`, and in readthedocs
///     # - As an attribute of `LarkOptions` above
///     # - Potentially in `_LOAD_ALLOWED_OPTIONS` below this class, when the option doesn't change how the grammar is loaded
///     # - Potentially in `lark.tools.__init__`, if it makes sense, and it can easily be passed as a cmd argument
///     _defaults: Dict[str, Any] = {
///         'debug': False,
///         'strict': False,
///         'keep_all_tokens': False,
///         'tree_class': None,
///         'cache': False,
///         'postlex': None,
///         'parser': 'earley',
///         'lexer': 'auto',
///         'transformer': None,
///         'start': 'start',
///         'priority': 'auto',
///         'ambiguity': 'auto',
///         'regex': False,
///         'propagate_positions': False,
///         'lexer_callbacks': {},
///         'maybe_placeholders': True,
///         'edit_terminals': None,
///         'g_regex_flags': 0,
///         'use_bytes': False,
///         'import_paths': [],
///         'source_path': None,
///         '_plugins': {},
///     }
///
///     def __init__(self, options_dict: Dict[str, Any]) -> None:
///         o = dict(options_dict)
///
///         options = {}
///         for name, default in self._defaults.items():
///             if name in o:
///                 value = o.pop(name)
///                 if isinstance(default, bool) and name not in ('cache', 'use_bytes', 'propagate_positions'):
///                     value = bool(value)
///             else:
///                 value = default
///
///             options[name] = value
///
///         if isinstance(options['start'], str):
///             options['start'] = [options['start']]
///
///         self.__dict__['options'] = options
///
///
///         assert_config(self.parser, ('earley', 'lalr', 'cyk', None))
///
///         if self.parser == 'earley' and self.transformer:
///             raise ConfigurationError('Cannot specify an embedded transformer when using the Earley algorithm. '
///                              'Please use your transformer on the resulting parse tree, or use a different algorithm (i.e. LALR)')
///
///         if o:
///             raise ConfigurationError("Unknown options: %s" % o.keys())
///
///     def __getattr__(self, name: str) -> Any:
///         try:
///             return self.__dict__['options'][name]
///         except KeyError as e:
///             raise AttributeError(e)
///
///     def __setattr__(self, name: str, value: str) -> None:
///         assert_config(name, self.options.keys(), "%r isn't a valid option. Expected one of: %s")
///         self.options[name] = value
///
///     def serialize(self, memo = None) -> Dict[str, Any]:
///         return self.options
///
///     @classmethod
///     def deserialize(cls, data: Dict[str, Any], memo: Dict[int, Union[TerminalDef, Rule]]) -> "LarkOptions":
///         return cls(data)
///
///
/// # Options that can be passed to the Lark parser, even when it was loaded from cache/standalone.
/// # These options are only used outside of `load_grammar`.
/// _LOAD_ALLOWED_OPTIONS = {'postlex', 'transformer', 'lexer_callbacks', 'use_bytes', 'debug', 'g_regex_flags', 'regex', 'propagate_positions', 'tree_class', '_plugins'}
///
/// _VALID_PRIORITY_OPTIONS = ('auto', 'normal', 'invert', None)
/// _VALID_AMBIGUITY_OPTIONS = ('auto', 'resolve', 'explicit', 'forest')
///
///
/// _T = TypeVar('_T', bound="Lark")
///
/// class Lark(Serialize):
///     """Main interface for the library.
///
///     It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
///
///     Parameters:
///         grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
///         options: a dictionary controlling various aspects of Lark.
///
///     Example:
///         >>> Lark(r'''start: "foo" ''')
///         Lark(...)
///     """
///
///     source_path: str
///     source_grammar: str
///     grammar: 'Grammar'
///     options: LarkOptions
///     lexer: Lexer
///     parser: 'ParsingFrontend'
///     terminals: Collection[TerminalDef]
///
///     def __init__(self, grammar: 'Union[Grammar, str, IO[str]]', **options) -> None:
///         self.options = LarkOptions(options)
///         re_module: types.ModuleType
///
///         # Set regex or re module
///         use_regex = self.options.regex
///         if use_regex:
///             if _has_regex:
///                 re_module = regex
///             else:
///                 raise ImportError('`regex` module must be installed if calling `Lark(regex=True)`.')
///         else:
///             re_module = re
///
///         # Some, but not all file-like objects have a 'name' attribute
///         if self.options.source_path is None:
///             try:
///                 self.source_path = grammar.name  # type: ignore[union-attr]
///             except AttributeError:
///                 self.source_path = '<string>'
///         else:
///             self.source_path = self.options.source_path
///
///         # Drain file-like objects to get their contents
///         try:
///             read = grammar.read  # type: ignore[union-attr]
///         except AttributeError:
///             pass
///         else:
///             grammar = read()
///
///         cache_fn = None
///         cache_sha256 = None
///         if isinstance(grammar, str):
///             self.source_grammar = grammar
///             if self.options.use_bytes:
///                 if not isascii(grammar):
///                     raise ConfigurationError("Grammar must be ascii only, when use_bytes=True")
///
///             if self.options.cache:
///                 if self.options.parser != 'lalr':
///                     raise ConfigurationError("cache only works with parser='lalr' for now")
///
///                 unhashable = ('transformer', 'postlex', 'lexer_callbacks', 'edit_terminals', '_plugins')
///                 options_str = ''.join(k+str(v) for k, v in options.items() if k not in unhashable)
///                 from . import __version__
///                 s = grammar + options_str + __version__ + str(sys.version_info[:2])
///                 cache_sha256 = sha256_digest(s)
///
///                 if isinstance(self.options.cache, str):
///                     cache_fn = self.options.cache
///                 else:
///                     if self.options.cache is not True:
///                         raise ConfigurationError("cache argument must be bool or str")
///
///                     try:
///                         username = getpass.getuser()
///                     except Exception:
///                         # The exception raised may be ImportError or OSError in
///                         # the future.  For the cache, we don't care about the
///                         # specific reason - we just want a username.
///                         username = "unknown"
///
///                     cache_fn = tempfile.gettempdir() + "/.lark_cache_%s_%s_%s_%s.tmp" % (username, cache_sha256, *sys.version_info[:2])
///
///                 old_options = self.options
///                 try:
///                     with FS.open(cache_fn, 'rb') as f:
///                         logger.debug('Loading grammar from cache: %s', cache_fn)
///                         # Remove options that aren't relevant for loading from cache
///                         for name in (set(options) - _LOAD_ALLOWED_OPTIONS):
///                             del options[name]
///                         file_sha256 = f.readline().rstrip(b'\n')
///                         cached_used_files = pickle.load(f)
///                         if file_sha256 == cache_sha256.encode('utf8') and verify_used_files(cached_used_files):
///                             cached_parser_data = pickle.load(f)
///                             self._load(cached_parser_data, **options)
///                             return
///                 except FileNotFoundError:
///                     # The cache file doesn't exist; parse and compose the grammar as normal
///                     pass
///                 except Exception: # We should probably narrow done which errors we catch here.
///                     logger.exception("Failed to load Lark from cache: %r. We will try to carry on.", cache_fn)
///
///                     # In theory, the Lark instance might have been messed up by the call to `_load`.
///                     # In practice the only relevant thing that might have been overwritten should be `options`
///                     self.options = old_options
///
///
///             # Parse the grammar file and compose the grammars
///             self.grammar, used_files = load_grammar(grammar, self.source_path, self.options.import_paths, self.options.keep_all_tokens)
///         else:
///             assert isinstance(grammar, Grammar)
///             self.grammar = grammar
///
///
///         if self.options.lexer == 'auto':
///             if self.options.parser == 'lalr':
///                 self.options.lexer = 'contextual'
///             elif self.options.parser == 'earley':
///                 if self.options.postlex is not None:
///                     logger.info("postlex can't be used with the dynamic lexer, so we use 'basic' instead. "
///                                 "Consider using lalr with contextual instead of earley")
///                     self.options.lexer = 'basic'
///                 else:
///                     self.options.lexer = 'dynamic'
///             elif self.options.parser == 'cyk':
///                 self.options.lexer = 'basic'
///             else:
///                 assert False, self.options.parser
///         lexer = self.options.lexer
///         if isinstance(lexer, type):
///             assert issubclass(lexer, Lexer)     # XXX Is this really important? Maybe just ensure interface compliance
///         else:
///             assert_config(lexer, ('basic', 'contextual', 'dynamic', 'dynamic_complete'))
///             if self.options.postlex is not None and 'dynamic' in lexer:
///                 raise ConfigurationError("Can't use postlex with a dynamic lexer. Use basic or contextual instead")
///
///         if self.options.ambiguity == 'auto':
///             if self.options.parser == 'earley':
///                 self.options.ambiguity = 'resolve'
///         else:
///             assert_config(self.options.parser, ('earley', 'cyk'), "%r doesn't support disambiguation. Use one of these parsers instead: %s")
///
///         if self.options.priority == 'auto':
///             self.options.priority = 'normal'
///
///         if self.options.priority not in _VALID_PRIORITY_OPTIONS:
///             raise ConfigurationError("invalid priority option: %r. Must be one of %r" % (self.options.priority, _VALID_PRIORITY_OPTIONS))
///         if self.options.ambiguity not in _VALID_AMBIGUITY_OPTIONS:
///             raise ConfigurationError("invalid ambiguity option: %r. Must be one of %r" % (self.options.ambiguity, _VALID_AMBIGUITY_OPTIONS))
///
///         if self.options.parser is None:
///             terminals_to_keep = '*'
///         elif self.options.postlex is not None:
///             terminals_to_keep = set(self.options.postlex.always_accept)
///         else:
///             terminals_to_keep = set()
///
///         # Compile the EBNF grammar into BNF
///         self.terminals, self.rules, self.ignore_tokens = self.grammar.compile(self.options.start, terminals_to_keep)
///
///         if self.options.edit_terminals:
///             for t in self.terminals:
///                 self.options.edit_terminals(t)
///
///         self._terminals_dict = {t.name: t for t in self.terminals}
///
///         # If the user asked to invert the priorities, negate them all here.
///         if self.options.priority == 'invert':
///             for rule in self.rules:
///                 if rule.options.priority is not None:
///                     rule.options.priority = -rule.options.priority
///             for term in self.terminals:
///                 term.priority = -term.priority
///         # Else, if the user asked to disable priorities, strip them from the
///         # rules and terminals. This allows the Earley parsers to skip an extra forest walk
///         # for improved performance, if you don't need them (or didn't specify any).
///         elif self.options.priority is None:
///             for rule in self.rules:
///                 if rule.options.priority is not None:
///                     rule.options.priority = None
///             for term in self.terminals:
///                 term.priority = 0
///
///         # TODO Deprecate lexer_callbacks?
///         self.lexer_conf = LexerConf(
///                 self.terminals, re_module, self.ignore_tokens, self.options.postlex,
///                 self.options.lexer_callbacks, self.options.g_regex_flags, use_bytes=self.options.use_bytes, strict=self.options.strict
///             )
///
///         if self.options.parser:
///             self.parser = self._build_parser()
///         elif lexer:
///             self.lexer = self._build_lexer()
///
///         if cache_fn:
///             logger.debug('Saving grammar to cache: %s', cache_fn)
///             try:
///                 with FS.open(cache_fn, 'wb') as f:
///                     assert cache_sha256 is not None
///                     f.write(cache_sha256.encode('utf8') + b'\n')
///                     pickle.dump(used_files, f)
///                     self.save(f, _LOAD_ALLOWED_OPTIONS)
///             except IOError as e:
///                 logger.exception("Failed to save Lark to cache: %r.", cache_fn, e)
///
///     if __doc__:
///         __doc__ += "\n\n" + LarkOptions.OPTIONS_DOC
///
///     __serialize_fields__ = 'parser', 'rules', 'options'
///
///     def _build_lexer(self, dont_ignore: bool=False) -> BasicLexer:
///         lexer_conf = self.lexer_conf
///         if dont_ignore:
///             from copy import copy
///             lexer_conf = copy(lexer_conf)
///             lexer_conf.ignore = ()
///         return BasicLexer(lexer_conf)
///
///     def _prepare_callbacks(self) -> None:
///         self._callbacks = {}
///         # we don't need these callbacks if we aren't building a tree
///         if self.options.ambiguity != 'forest':
///             self._parse_tree_builder = ParseTreeBuilder(
///                     self.rules,
///                     self.options.tree_class or Tree,
///                     self.options.propagate_positions,
///                     self.options.parser != 'lalr' and self.options.ambiguity == 'explicit',
///                     self.options.maybe_placeholders
///                 )
///             self._callbacks = self._parse_tree_builder.create_callback(self.options.transformer)
///         self._callbacks.update(_get_lexer_callbacks(self.options.transformer, self.terminals))
///
///     def _build_parser(self) -> "ParsingFrontend":
///         self._prepare_callbacks()
///         _validate_frontend_args(self.options.parser, self.options.lexer)
///         parser_conf = ParserConf(self.rules, self._callbacks, self.options.start)
///         return _construct_parsing_frontend(
///             self.options.parser,
///             self.options.lexer,
///             self.lexer_conf,
///             parser_conf,
///             options=self.options
///         )
///
///     def save(self, f, exclude_options: Collection[str] = ()) -> None:
///         """Saves the instance into the given file object
///
///         Useful for caching and multiprocessing.
///         """
///         data, m = self.memo_serialize([TerminalDef, Rule])
///         if exclude_options:
///             data["options"] = {n: v for n, v in data["options"].items() if n not in exclude_options}
///         pickle.dump({'data': data, 'memo': m}, f, protocol=pickle.HIGHEST_PROTOCOL)
///
///     @classmethod
///     def load(cls: Type[_T], f) -> _T:
///         """Loads an instance from the given file object
///
///         Useful for caching and multiprocessing.
///         """
///         inst = cls.__new__(cls)
///         return inst._load(f)
///
///     def _deserialize_lexer_conf(self, data: Dict[str, Any], memo: Dict[int, Union[TerminalDef, Rule]], options: LarkOptions) -> LexerConf:
///         lexer_conf = LexerConf.deserialize(data['lexer_conf'], memo)
///         lexer_conf.callbacks = options.lexer_callbacks or {}
///         lexer_conf.re_module = regex if options.regex else re
///         lexer_conf.use_bytes = options.use_bytes
///         lexer_conf.g_regex_flags = options.g_regex_flags
///         lexer_conf.skip_validation = True
///         lexer_conf.postlex = options.postlex
///         return lexer_conf
///
///     def _load(self: _T, f: Any, **kwargs) -> _T:
///         if isinstance(f, dict):
///             d = f
///         else:
///             d = pickle.load(f)
///         memo_json = d['memo']
///         data = d['data']
///
///         assert memo_json
///         memo = SerializeMemoizer.deserialize(memo_json, {'Rule': Rule, 'TerminalDef': TerminalDef}, {})
///         options = dict(data['options'])
///         if (set(kwargs) - _LOAD_ALLOWED_OPTIONS) & set(LarkOptions._defaults):
///             raise ConfigurationError("Some options are not allowed when loading a Parser: {}"
///                              .format(set(kwargs) - _LOAD_ALLOWED_OPTIONS))
///         options.update(kwargs)
///         self.options = LarkOptions.deserialize(options, memo)
///         self.rules = [Rule.deserialize(r, memo) for r in data['rules']]
///         self.source_path = '<deserialized>'
///         _validate_frontend_args(self.options.parser, self.options.lexer)
///         self.lexer_conf = self._deserialize_lexer_conf(data['parser'], memo, self.options)
///         self.terminals = self.lexer_conf.terminals
///         self._prepare_callbacks()
///         self._terminals_dict = {t.name: t for t in self.terminals}
///         self.parser = _deserialize_parsing_frontend(
///             data['parser'],
///             memo,
///             self.lexer_conf,
///             self._callbacks,
///             self.options,  # Not all, but multiple attributes are used
///         )
///         return self
///
///     @classmethod
///     def _load_from_dict(cls, data, memo, **kwargs):
///         inst = cls.__new__(cls)
///         return inst._load({'data': data, 'memo': memo}, **kwargs)
///
///     @classmethod
///     def open(cls: Type[_T], grammar_filename: str, rel_to: Optional[str]=None, **options) -> _T:
///         """Create an instance of Lark with the grammar given by its filename
///
///         If ``rel_to`` is provided, the function will find the grammar filename in relation to it.
///
///         Example:
///
///             >>> Lark.open("grammar_file.lark", rel_to=__file__, parser="lalr")
///             Lark(...)
///
///         """
///         if rel_to:
///             basepath = os.path.dirname(rel_to)
///             grammar_filename = os.path.join(basepath, grammar_filename)
///         with open(grammar_filename, encoding='utf8') as f:
///             return cls(f, **options)
///
///     @classmethod
///     def open_from_package(cls: Type[_T], package: str, grammar_path: str, search_paths: 'Sequence[str]'=[""], **options) -> _T:
///         """Create an instance of Lark with the grammar loaded from within the package `package`.
///         This allows grammar loading from zipapps.
///
///         Imports in the grammar will use the `package` and `search_paths` provided, through `FromPackageLoader`
///
///         Example:
///
///             Lark.open_from_package(__name__, "example.lark", ("grammars",), parser=...)
///         """
///         package_loader = FromPackageLoader(package, search_paths)
///         full_path, text = package_loader(None, grammar_path)
///         options.setdefault('source_path', full_path)
///         options.setdefault('import_paths', [])
///         options['import_paths'].append(package_loader)
///         return cls(text, **options)
///
///     def __repr__(self):
///         return 'Lark(open(%r), parser=%r, lexer=%r, ...)' % (self.source_path, self.options.parser, self.options.lexer)
///
///
///     def lex(self, text: str, dont_ignore: bool=False) -> Iterator[Token]:
///         """Only lex (and postlex) the text, without parsing it. Only relevant when lexer='basic'
///
///         When dont_ignore=True, the lexer will return all tokens, even those marked for %ignore.
///
///         :raises UnexpectedCharacters: In case the lexer cannot find a suitable match.
///         """
///         lexer: Lexer
///         if not hasattr(self, 'lexer') or dont_ignore:
///             lexer = self._build_lexer(dont_ignore)
///         else:
///             lexer = self.lexer
///         lexer_thread = LexerThread.from_text(lexer, text)
///         stream = lexer_thread.lex(None)
///         if self.options.postlex:
///             return self.options.postlex.process(stream)
///         return stream
///
///     def get_terminal(self, name: str) -> TerminalDef:
///         """Get information about a terminal"""
///         return self._terminals_dict[name]
///
///     def parse_interactive(self, text: Optional[str]=None, start: Optional[str]=None) -> 'InteractiveParser':
///         """Start an interactive parsing session.
///
///         Parameters:
///             text (str, optional): Text to be parsed. Required for ``resume_parse()``.
///             start (str, optional): Start symbol
///
///         Returns:
///             A new InteractiveParser instance.
///
///         See Also: ``Lark.parse()``
///         """
///         return self.parser.parse_interactive(text, start=start)
///
///     def parse(self, text: str, start: Optional[str]=None, on_error: 'Optional[Callable[[UnexpectedInput], bool]]'=None) -> 'ParseTree':
///         """Parse the given text, according to the options provided.
///
///         Parameters:
///             text (str): Text to be parsed.
///             start (str, optional): Required if Lark was given multiple possible start symbols (using the start option).
///             on_error (function, optional): if provided, will be called on UnexpectedToken error. Return true to resume parsing.
///                 LALR only. See examples/advanced/error_handling.py for an example of how to use on_error.
///
///         Returns:
///             If a transformer is supplied to ``__init__``, returns whatever is the
///             result of the transformation. Otherwise, returns a Tree instance.
///
///         :raises UnexpectedInput: On a parse error, one of these sub-exceptions will rise:
///                 ``UnexpectedCharacters``, ``UnexpectedToken``, or ``UnexpectedEOF``.
///                 For convenience, these sub-exceptions also inherit from ``ParserError`` and ``LexerError``.
///
///         """
///         return self.parser.parse(text, start=start, on_error=on_error)
///
///
/// ###}
/// ```
final class lark extends PythonModule {
  lark.from(super.pythonModule) : super.from();

  static lark import() => PythonFfiDart.instance.importModule(
        "lark.lark",
        lark.from,
      );

  /// ## abstractmethod
  ///
  /// ### python docstring
  ///
  /// A decorator indicating abstract methods.
  ///
  /// Requires that the metaclass is ABCMeta or derived from it.  A
  /// class that has a metaclass derived from ABCMeta cannot be
  /// instantiated unless all of its abstract methods are overridden.
  /// The abstract methods can be called using any of the normal
  /// 'super' call mechanisms.  abstractmethod() may be used to declare
  /// abstract methods for properties and descriptors.
  ///
  /// Usage:
  ///
  ///     class C(metaclass=ABCMeta):
  ///         @abstractmethod
  ///         def my_abstract_method(self, ...):
  ///             ...
  Object? abstractmethod({
    required Object? funcobj,
  }) =>
      getFunction("abstractmethod").call(
        <Object?>[
          funcobj,
        ],
        kwargs: <String, Object?>{},
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

  /// ## load_grammar
  ///
  /// ### python source
  /// ```py
  /// def load_grammar(grammar, source, import_paths, global_keep_all_tokens):
  ///     builder = GrammarBuilder(global_keep_all_tokens, import_paths)
  ///     builder.load_grammar(grammar, source)
  ///     return builder.build(), builder.used_files
  /// ```
  Object? load_grammar({
    required Object? grammar,
    required Object? source,
    required Object? import_paths,
    required Object? global_keep_all_tokens,
  }) =>
      getFunction("load_grammar").call(
        <Object?>[
          grammar,
          source,
          import_paths,
          global_keep_all_tokens,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## sha256_digest
  ///
  /// ### python docstring
  ///
  /// Get the sha256 digest of a string
  ///
  /// Supports the `usedforsecurity` argument for Python 3.9+ to allow running on
  /// a FIPS-enabled system.
  ///
  /// ### python source
  /// ```py
  /// def sha256_digest(s: str) -> str:
  ///     """Get the sha256 digest of a string
  ///
  ///     Supports the `usedforsecurity` argument for Python 3.9+ to allow running on
  ///     a FIPS-enabled system.
  ///     """
  ///     if sys.version_info >= (3, 9):
  ///         return hashlib.sha256(s.encode('utf8'), usedforsecurity=False).hexdigest()
  ///     else:
  ///         return hashlib.sha256(s.encode('utf8')).hexdigest()
  /// ```
  String sha256_digest({
    required String s,
  }) =>
      getFunction("sha256_digest").call(
        <Object?>[
          s,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## verify_used_files
  ///
  /// ### python source
  /// ```py
  /// def verify_used_files(file_hashes):
  ///     for path, old in file_hashes.items():
  ///         text = None
  ///         if isinstance(path, str) and os.path.exists(path):
  ///             with open(path, encoding='utf8') as f:
  ///                 text = f.read()
  ///         elif isinstance(path, PackageResource):
  ///             with suppress(IOError):
  ///                 text = pkgutil.get_data(*path).decode('utf-8')
  ///         if text is None: # We don't know how to load the path. ignore it.
  ///             continue
  ///
  ///         current = sha256_digest(text)
  ///         if old != current:
  ///             logger.info("File %r changed, rebuilding Parser" % path)
  ///             return False
  ///     return True
  /// ```
  Object? verify_used_files({
    required Object? file_hashes,
  }) =>
      getFunction("verify_used_files").call(
        <Object?>[
          file_hashes,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## sys
  sys get $sys => sys.import();

  /// ## logger (getter)
  Object? get logger => getAttribute("logger");

  /// ## logger (setter)
  set logger(Object? logger) => setAttribute("logger", logger);

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

  /// ## TYPE_CHECKING (getter)
  Object? get TYPE_CHECKING => getAttribute("TYPE_CHECKING");

  /// ## TYPE_CHECKING (setter)
  set TYPE_CHECKING(Object? TYPE_CHECKING) =>
      setAttribute("TYPE_CHECKING", TYPE_CHECKING);
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
