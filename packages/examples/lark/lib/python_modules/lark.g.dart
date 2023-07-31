// ignore_for_file: camel_case_types, non_constant_identifier_names

library lark;

import "package:python_ffi_dart/python_ffi_dart.dart";

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
/// transformer
///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
/// propagate_positions
///         Propagates (line, column, end_line, end_column) attributes into all tree branches.
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
///         cache_md5 = None
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
///                 cache_md5 = md5_digest(s)
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
///                     cache_fn = tempfile.gettempdir() + "/.lark_cache_%s_%s_%s_%s.tmp" % (username, cache_md5, *sys.version_info[:2])
///
///                 old_options = self.options
///                 try:
///                     with FS.open(cache_fn, 'rb') as f:
///                         logger.debug('Loading grammar from cache: %s', cache_fn)
///                         # Remove options that aren't relevant for loading from cache
///                         for name in (set(options) - _LOAD_ALLOWED_OPTIONS):
///                             del options[name]
///                         file_md5 = f.readline().rstrip(b'\n')
///                         cached_used_files = pickle.load(f)
///                         if file_md5 == cache_md5.encode('utf8') and verify_used_files(cached_used_files):
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
///                 self.options.lexer_callbacks, self.options.g_regex_flags, use_bytes=self.options.use_bytes
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
///                     assert cache_md5 is not None
///                     f.write(cache_md5.encode('utf8') + b'\n')
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
  Object? get_terminal({
    required Object? name,
  }) =>
      getFunction("get_terminal").call(
        <Object?>[
          name,
        ],
        kwargs: <String, Object?>{},
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
  Object? lex({
    required Object? text,
    Object? dont_ignore = false,
  }) =>
      getFunction("lex").call(
        <Object?>[
          text,
          dont_ignore,
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
    required Object? text,
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
  Object? save({
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
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## load (getter)
  ///
  /// ### python docstring
  ///
  /// Loads an instance from the given file object
  ///
  /// Useful for caching and multiprocessing.
  Object? get load => getAttribute("load");

  /// ## load (setter)
  ///
  /// ### python docstring
  ///
  /// Loads an instance from the given file object
  ///
  /// Useful for caching and multiprocessing.
  set load(Object? load) => setAttribute("load", load);

  /// ## open (getter)
  ///
  /// ### python docstring
  ///
  /// Create an instance of Lark with the grammar given by its filename
  ///
  /// If ``rel_to`` is provided, the function will find the grammar filename in relation to it.
  ///
  /// Example:
  ///
  ///     >>> Lark.open("grammar_file.lark", rel_to=__file__, parser="lalr")
  ///     Lark(...)
  Object? get open => getAttribute("open");

  /// ## open (setter)
  ///
  /// ### python docstring
  ///
  /// Create an instance of Lark with the grammar given by its filename
  ///
  /// If ``rel_to`` is provided, the function will find the grammar filename in relation to it.
  ///
  /// Example:
  ///
  ///     >>> Lark.open("grammar_file.lark", rel_to=__file__, parser="lalr")
  ///     Lark(...)
  set open(Object? open) => setAttribute("open", open);

  /// ## open_from_package (getter)
  ///
  /// ### python docstring
  ///
  /// Create an instance of Lark with the grammar loaded from within the package `package`.
  /// This allows grammar loading from zipapps.
  ///
  /// Imports in the grammar will use the `package` and `search_paths` provided, through `FromPackageLoader`
  ///
  /// Example:
  ///
  ///     Lark.open_from_package(__name__, "example.lark", ("grammars",), parser=...)
  Object? get open_from_package => getAttribute("open_from_package");

  /// ## open_from_package (setter)
  ///
  /// ### python docstring
  ///
  /// Create an instance of Lark with the grammar loaded from within the package `package`.
  /// This allows grammar loading from zipapps.
  ///
  /// Imports in the grammar will use the `package` and `search_paths` provided, through `FromPackageLoader`
  ///
  /// Example:
  ///
  ///     Lark.open_from_package(__name__, "example.lark", ("grammars",), parser=...)
  set open_from_package(Object? open_from_package) =>
      setAttribute("open_from_package", open_from_package);

  /// ## options (getter)
  Object? get options => getAttribute("options");

  /// ## options (setter)
  set options(Object? options) => setAttribute("options", options);

  /// ## source_path (getter)
  Object? get source_path => getAttribute("source_path");

  /// ## source_path (setter)
  set source_path(Object? source_path) =>
      setAttribute("source_path", source_path);

  /// ## source_grammar (getter)
  Object? get source_grammar => getAttribute("source_grammar");

  /// ## source_grammar (setter)
  set source_grammar(Object? source_grammar) =>
      setAttribute("source_grammar", source_grammar);

  /// ## parser (getter)
  Object? get parser => getAttribute("parser");

  /// ## parser (setter)
  set parser(Object? parser) => setAttribute("parser", parser);

  /// ## grammar (getter)
  Object? get grammar => getAttribute("grammar");

  /// ## grammar (setter)
  set grammar(Object? grammar) => setAttribute("grammar", grammar);

  /// ## lexer (getter)
  Object? get lexer => getAttribute("lexer");

  /// ## lexer (setter)
  set lexer(Object? lexer) => setAttribute("lexer", lexer);

  /// ## lexer_conf (getter)
  Object? get lexer_conf => getAttribute("lexer_conf");

  /// ## lexer_conf (setter)
  set lexer_conf(Object? lexer_conf) => setAttribute("lexer_conf", lexer_conf);
}

/// ## LarkError
///
/// ### python source
/// ```py
/// class LarkError(Exception):
///     pass
/// ```
final class LarkError extends PythonClass {
  factory LarkError() => PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "LarkError",
        LarkError.from,
        <Object?>[],
      );

  LarkError.from(super.pythonClass) : super.from();

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
///         cls,
///         type: str,
///         value: Any,
///         start_pos: Optional[int]=None,
///         line: Optional[int]=None,
///         column: Optional[int]=None,
///         end_line: Optional[int]=None,
///         end_column: Optional[int]=None,
///         end_pos: Optional[int]=None
///     ) -> 'Token':
///         ...
///
///     @overload
///     def __new__(
///         cls,
///         type_: str,
///         value: Any,
///         start_pos: Optional[int]=None,
///         line: Optional[int]=None,
///         column: Optional[int]=None,
///         end_line: Optional[int]=None,
///         end_column: Optional[int]=None,
///         end_pos: Optional[int]=None
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
///     def update(self, type: Optional[str]=None, value: Optional[Any]=None) -> 'Token':
///         ...
///
///     @overload
///     def update(self, type_: Optional[str]=None, value: Optional[Any]=None) -> 'Token':
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
///     def _future_update(self, type: Optional[str]=None, value: Optional[Any]=None) -> 'Token':
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
  Object? get column => getAttribute("column");

  /// ## column (setter)
  set column(Object? column) => setAttribute("column", column);

  /// ## end_column (getter)
  Object? get end_column => getAttribute("end_column");

  /// ## end_column (setter)
  set end_column(Object? end_column) => setAttribute("end_column", end_column);

  /// ## end_line (getter)
  Object? get end_line => getAttribute("end_line");

  /// ## end_line (setter)
  set end_line(Object? end_line) => setAttribute("end_line", end_line);

  /// ## end_pos (getter)
  Object? get end_pos => getAttribute("end_pos");

  /// ## end_pos (setter)
  set end_pos(Object? end_pos) => setAttribute("end_pos", end_pos);

  /// ## line (getter)
  Object? get line => getAttribute("line");

  /// ## line (setter)
  set line(Object? line) => setAttribute("line", line);

  /// ## start_pos (getter)
  Object? get start_pos => getAttribute("start_pos");

  /// ## start_pos (setter)
  set start_pos(Object? start_pos) => setAttribute("start_pos", start_pos);

  /// ## type (getter)
  Object? get type => getAttribute("type");

  /// ## type (setter)
  set type(Object? type) => setAttribute("type", type);

  /// ## value (getter)
  Object? get value => getAttribute("value");

  /// ## value (setter)
  set value(Object? value) => setAttribute("value", value);

  /// ## capitalize (getter)
  Object? get capitalize => getAttribute("capitalize");

  /// ## capitalize (setter)
  set capitalize(Object? capitalize) => setAttribute("capitalize", capitalize);

  /// ## casefold (getter)
  Object? get casefold => getAttribute("casefold");

  /// ## casefold (setter)
  set casefold(Object? casefold) => setAttribute("casefold", casefold);

  /// ## center (getter)
  Object? get center => getAttribute("center");

  /// ## center (setter)
  set center(Object? center) => setAttribute("center", center);

  /// ## count (getter)
  Object? get count => getAttribute("count");

  /// ## count (setter)
  set count(Object? count) => setAttribute("count", count);

  /// ## encode (getter)
  Object? get encode => getAttribute("encode");

  /// ## encode (setter)
  set encode(Object? encode) => setAttribute("encode", encode);

  /// ## endswith (getter)
  Object? get endswith => getAttribute("endswith");

  /// ## endswith (setter)
  set endswith(Object? endswith) => setAttribute("endswith", endswith);

  /// ## expandtabs (getter)
  Object? get expandtabs => getAttribute("expandtabs");

  /// ## expandtabs (setter)
  set expandtabs(Object? expandtabs) => setAttribute("expandtabs", expandtabs);

  /// ## find (getter)
  Object? get find => getAttribute("find");

  /// ## find (setter)
  set find(Object? find) => setAttribute("find", find);

  /// ## format (getter)
  Object? get format => getAttribute("format");

  /// ## format (setter)
  set format(Object? format) => setAttribute("format", format);

  /// ## format_map (getter)
  Object? get format_map => getAttribute("format_map");

  /// ## format_map (setter)
  set format_map(Object? format_map) => setAttribute("format_map", format_map);

  /// ## index (getter)
  Object? get index => getAttribute("index");

  /// ## index (setter)
  set index(Object? index) => setAttribute("index", index);

  /// ## isalnum (getter)
  Object? get isalnum => getAttribute("isalnum");

  /// ## isalnum (setter)
  set isalnum(Object? isalnum) => setAttribute("isalnum", isalnum);

  /// ## isalpha (getter)
  Object? get isalpha => getAttribute("isalpha");

  /// ## isalpha (setter)
  set isalpha(Object? isalpha) => setAttribute("isalpha", isalpha);

  /// ## isascii (getter)
  Object? get isascii => getAttribute("isascii");

  /// ## isascii (setter)
  set isascii(Object? isascii) => setAttribute("isascii", isascii);

  /// ## isdecimal (getter)
  Object? get isdecimal => getAttribute("isdecimal");

  /// ## isdecimal (setter)
  set isdecimal(Object? isdecimal) => setAttribute("isdecimal", isdecimal);

  /// ## isdigit (getter)
  Object? get isdigit => getAttribute("isdigit");

  /// ## isdigit (setter)
  set isdigit(Object? isdigit) => setAttribute("isdigit", isdigit);

  /// ## isidentifier (getter)
  Object? get isidentifier => getAttribute("isidentifier");

  /// ## isidentifier (setter)
  set isidentifier(Object? isidentifier) =>
      setAttribute("isidentifier", isidentifier);

  /// ## islower (getter)
  Object? get islower => getAttribute("islower");

  /// ## islower (setter)
  set islower(Object? islower) => setAttribute("islower", islower);

  /// ## isnumeric (getter)
  Object? get isnumeric => getAttribute("isnumeric");

  /// ## isnumeric (setter)
  set isnumeric(Object? isnumeric) => setAttribute("isnumeric", isnumeric);

  /// ## isprintable (getter)
  Object? get isprintable => getAttribute("isprintable");

  /// ## isprintable (setter)
  set isprintable(Object? isprintable) =>
      setAttribute("isprintable", isprintable);

  /// ## isspace (getter)
  Object? get isspace => getAttribute("isspace");

  /// ## isspace (setter)
  set isspace(Object? isspace) => setAttribute("isspace", isspace);

  /// ## istitle (getter)
  Object? get istitle => getAttribute("istitle");

  /// ## istitle (setter)
  set istitle(Object? istitle) => setAttribute("istitle", istitle);

  /// ## isupper (getter)
  Object? get isupper => getAttribute("isupper");

  /// ## isupper (setter)
  set isupper(Object? isupper) => setAttribute("isupper", isupper);

  /// ## join (getter)
  Object? get join => getAttribute("join");

  /// ## join (setter)
  set join(Object? join) => setAttribute("join", join);

  /// ## ljust (getter)
  Object? get ljust => getAttribute("ljust");

  /// ## ljust (setter)
  set ljust(Object? ljust) => setAttribute("ljust", ljust);

  /// ## lower (getter)
  Object? get lower => getAttribute("lower");

  /// ## lower (setter)
  set lower(Object? lower) => setAttribute("lower", lower);

  /// ## lstrip (getter)
  Object? get lstrip => getAttribute("lstrip");

  /// ## lstrip (setter)
  set lstrip(Object? lstrip) => setAttribute("lstrip", lstrip);

  /// ## new_borrow_pos (getter)
  Object? get new_borrow_pos => getAttribute("new_borrow_pos");

  /// ## new_borrow_pos (setter)
  set new_borrow_pos(Object? new_borrow_pos) =>
      setAttribute("new_borrow_pos", new_borrow_pos);

  /// ## partition (getter)
  Object? get partition => getAttribute("partition");

  /// ## partition (setter)
  set partition(Object? partition) => setAttribute("partition", partition);

  /// ## removeprefix (getter)
  Object? get removeprefix => getAttribute("removeprefix");

  /// ## removeprefix (setter)
  set removeprefix(Object? removeprefix) =>
      setAttribute("removeprefix", removeprefix);

  /// ## removesuffix (getter)
  Object? get removesuffix => getAttribute("removesuffix");

  /// ## removesuffix (setter)
  set removesuffix(Object? removesuffix) =>
      setAttribute("removesuffix", removesuffix);

  /// ## replace (getter)
  Object? get replace => getAttribute("replace");

  /// ## replace (setter)
  set replace(Object? replace) => setAttribute("replace", replace);

  /// ## rfind (getter)
  Object? get rfind => getAttribute("rfind");

  /// ## rfind (setter)
  set rfind(Object? rfind) => setAttribute("rfind", rfind);

  /// ## rindex (getter)
  Object? get rindex => getAttribute("rindex");

  /// ## rindex (setter)
  set rindex(Object? rindex) => setAttribute("rindex", rindex);

  /// ## rjust (getter)
  Object? get rjust => getAttribute("rjust");

  /// ## rjust (setter)
  set rjust(Object? rjust) => setAttribute("rjust", rjust);

  /// ## rpartition (getter)
  Object? get rpartition => getAttribute("rpartition");

  /// ## rpartition (setter)
  set rpartition(Object? rpartition) => setAttribute("rpartition", rpartition);

  /// ## rsplit (getter)
  Object? get rsplit => getAttribute("rsplit");

  /// ## rsplit (setter)
  set rsplit(Object? rsplit) => setAttribute("rsplit", rsplit);

  /// ## rstrip (getter)
  Object? get rstrip => getAttribute("rstrip");

  /// ## rstrip (setter)
  set rstrip(Object? rstrip) => setAttribute("rstrip", rstrip);

  /// ## split (getter)
  Object? get split => getAttribute("split");

  /// ## split (setter)
  set split(Object? split) => setAttribute("split", split);

  /// ## splitlines (getter)
  Object? get splitlines => getAttribute("splitlines");

  /// ## splitlines (setter)
  set splitlines(Object? splitlines) => setAttribute("splitlines", splitlines);

  /// ## startswith (getter)
  Object? get startswith => getAttribute("startswith");

  /// ## startswith (setter)
  set startswith(Object? startswith) => setAttribute("startswith", startswith);

  /// ## strip (getter)
  Object? get strip => getAttribute("strip");

  /// ## strip (setter)
  set strip(Object? strip) => setAttribute("strip", strip);

  /// ## swapcase (getter)
  Object? get swapcase => getAttribute("swapcase");

  /// ## swapcase (setter)
  set swapcase(Object? swapcase) => setAttribute("swapcase", swapcase);

  /// ## title (getter)
  Object? get title => getAttribute("title");

  /// ## title (setter)
  set title(Object? title) => setAttribute("title", title);

  /// ## translate (getter)
  Object? get translate => getAttribute("translate");

  /// ## translate (setter)
  set translate(Object? translate) => setAttribute("translate", translate);

  /// ## upper (getter)
  Object? get upper => getAttribute("upper");

  /// ## upper (setter)
  set upper(Object? upper) => setAttribute("upper", upper);

  /// ## zfill (getter)
  Object? get zfill => getAttribute("zfill");

  /// ## zfill (setter)
  set zfill(Object? zfill) => setAttribute("zfill", zfill);
}

/// ## Transformer
///
/// ### python docstring
///
/// Transformers work bottom-up (or depth-first), starting with visiting the leaves and working
/// their way up until ending at the root of the tree.
///
/// For each node visited, the transformer will call the appropriate method (callbacks), according to the
/// node's ``data``, and use the returned value to replace the node, thereby creating a new tree structure.
///
/// Transformers can be used to implement map & reduce patterns. Because nodes are reduced from leaf to root,
/// at any point the callbacks may assume the children have already been transformed (if applicable).
///
/// If the transformer cannot find a method with the right name, it will instead call ``__default__``, which by
/// default creates a copy of the node.
///
/// To discard a node, return Discard (``lark.visitors.Discard``).
///
/// ``Transformer`` can do anything ``Visitor`` can do, but because it reconstructs the tree,
/// it is slightly less efficient.
///
/// A transformer without methods essentially performs a non-memoized partial deepcopy.
///
/// All these classes implement the transformer interface:
///
/// - ``Transformer`` - Recursively transforms the tree. This is the one you probably want.
/// - ``Transformer_InPlace`` - Non-recursive. Changes the tree in-place instead of returning new instances
/// - ``Transformer_InPlaceRecursive`` - Recursive. Changes the tree in-place instead of returning new instances
///
/// Parameters:
///     visit_tokens (bool, optional): Should the transformer visit tokens in addition to rules.
///                                    Setting this to ``False`` is slightly faster. Defaults to ``True``.
///                                    (For processing ignored tokens, use the ``lexer_callbacks`` options)
///
/// ### python source
/// ```py
/// class Transformer(_Decoratable, ABC, Generic[_Leaf_T, _Return_T]):
///     """Transformers work bottom-up (or depth-first), starting with visiting the leaves and working
///     their way up until ending at the root of the tree.
///
///     For each node visited, the transformer will call the appropriate method (callbacks), according to the
///     node's ``data``, and use the returned value to replace the node, thereby creating a new tree structure.
///
///     Transformers can be used to implement map & reduce patterns. Because nodes are reduced from leaf to root,
///     at any point the callbacks may assume the children have already been transformed (if applicable).
///
///     If the transformer cannot find a method with the right name, it will instead call ``__default__``, which by
///     default creates a copy of the node.
///
///     To discard a node, return Discard (``lark.visitors.Discard``).
///
///     ``Transformer`` can do anything ``Visitor`` can do, but because it reconstructs the tree,
///     it is slightly less efficient.
///
///     A transformer without methods essentially performs a non-memoized partial deepcopy.
///
///     All these classes implement the transformer interface:
///
///     - ``Transformer`` - Recursively transforms the tree. This is the one you probably want.
///     - ``Transformer_InPlace`` - Non-recursive. Changes the tree in-place instead of returning new instances
///     - ``Transformer_InPlaceRecursive`` - Recursive. Changes the tree in-place instead of returning new instances
///
///     Parameters:
///         visit_tokens (bool, optional): Should the transformer visit tokens in addition to rules.
///                                        Setting this to ``False`` is slightly faster. Defaults to ``True``.
///                                        (For processing ignored tokens, use the ``lexer_callbacks`` options)
///
///     """
///     __visit_tokens__ = True   # For backwards compatibility
///
///     def __init__(self,  visit_tokens: bool=True) -> None:
///         self.__visit_tokens__ = visit_tokens
///
///     def _call_userfunc(self, tree, new_children=None):
///         # Assumes tree is already transformed
///         children = new_children if new_children is not None else tree.children
///         try:
///             f = getattr(self, tree.data)
///         except AttributeError:
///             return self.__default__(tree.data, children, tree.meta)
///         else:
///             try:
///                 wrapper = getattr(f, 'visit_wrapper', None)
///                 if wrapper is not None:
///                     return f.visit_wrapper(f, tree.data, children, tree.meta)
///                 else:
///                     return f(children)
///             except GrammarError:
///                 raise
///             except Exception as e:
///                 raise VisitError(tree.data, tree, e)
///
///     def _call_userfunc_token(self, token):
///         try:
///             f = getattr(self, token.type)
///         except AttributeError:
///             return self.__default_token__(token)
///         else:
///             try:
///                 return f(token)
///             except GrammarError:
///                 raise
///             except Exception as e:
///                 raise VisitError(token.type, token, e)
///
///     def _transform_children(self, children):
///         for c in children:
///             if isinstance(c, Tree):
///                 res = self._transform_tree(c)
///             elif self.__visit_tokens__ and isinstance(c, Token):
///                 res = self._call_userfunc_token(c)
///             else:
///                 res = c
///
///             if res is not Discard:
///                 yield res
///
///     def _transform_tree(self, tree):
///         children = list(self._transform_children(tree.children))
///         return self._call_userfunc(tree, children)
///
///     def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         "Transform the given tree, and return the final result"
///         return self._transform_tree(tree)
///
///     def __mul__(
///             self: 'Transformer[_Leaf_T, Tree[_Leaf_U]]',
///             other: 'Union[Transformer[_Leaf_U, _Return_V], TransformerChain[_Leaf_U, _Return_V,]]'
///     ) -> 'TransformerChain[_Leaf_T, _Return_V]':
///         """Chain two transformers together, returning a new transformer.
///         """
///         return TransformerChain(self, other)
///
///     def __default__(self, data, children, meta):
///         """Default function that is called if there is no attribute matching ``data``
///
///         Can be overridden. Defaults to creating a new copy of the tree node (i.e. ``return Tree(data, children, meta)``)
///         """
///         return Tree(data, children, meta)
///
///     def __default_token__(self, token):
///         """Default function that is called if there is no attribute matching ``token.type``
///
///         Can be overridden. Defaults to returning the token as-is.
///         """
///         return token
/// ```
final class Transformer extends PythonClass {
  factory Transformer({
    Object? visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.visitors",
        "Transformer",
        Transformer.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  Transformer.from(super.pythonClass) : super.from();

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         "Transform the given tree, and return the final result"
  ///         return self._transform_tree(tree)
  /// ```
  Object? transform({
    required Object? tree,
  }) =>
      getFunction("transform").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## Transformer_NonRecursive
///
/// ### python docstring
///
/// Same as Transformer but non-recursive.
///
/// Like Transformer, it doesn't change the original tree.
///
/// Useful for huge trees.
///
/// ### python source
/// ```py
/// class Transformer_NonRecursive(Transformer):
///     """Same as Transformer but non-recursive.
///
///     Like Transformer, it doesn't change the original tree.
///
///     Useful for huge trees.
///     """
///
///     def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         # Tree to postfix
///         rev_postfix = []
///         q: List[Branch[_Leaf_T]] = [tree]
///         while q:
///             t = q.pop()
///             rev_postfix.append(t)
///             if isinstance(t, Tree):
///                 q += t.children
///
///         # Postfix to tree
///         stack: List = []
///         for x in reversed(rev_postfix):
///             if isinstance(x, Tree):
///                 size = len(x.children)
///                 if size:
///                     args = stack[-size:]
///                     del stack[-size:]
///                 else:
///                     args = []
///
///                 res = self._call_userfunc(x, args)
///                 if res is not Discard:
///                     stack.append(res)
///
///             elif self.__visit_tokens__ and isinstance(x, Token):
///                 res = self._call_userfunc_token(x)
///                 if res is not Discard:
///                     stack.append(res)
///             else:
///                 stack.append(x)
///
///         result, = stack  # We should have only one tree remaining
///         # There are no guarantees on the type of the value produced by calling a user func for a
///         # child will produce. This means type system can't statically know that the final result is
///         # _Return_T. As a result a cast is required.
///         return cast(_Return_T, result)
/// ```
final class Transformer_NonRecursive extends PythonClass {
  factory Transformer_NonRecursive({
    Object? visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.visitors",
        "Transformer_NonRecursive",
        Transformer_NonRecursive.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  Transformer_NonRecursive.from(super.pythonClass) : super.from();

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         # Tree to postfix
  ///         rev_postfix = []
  ///         q: List[Branch[_Leaf_T]] = [tree]
  ///         while q:
  ///             t = q.pop()
  ///             rev_postfix.append(t)
  ///             if isinstance(t, Tree):
  ///                 q += t.children
  ///
  ///         # Postfix to tree
  ///         stack: List = []
  ///         for x in reversed(rev_postfix):
  ///             if isinstance(x, Tree):
  ///                 size = len(x.children)
  ///                 if size:
  ///                     args = stack[-size:]
  ///                     del stack[-size:]
  ///                 else:
  ///                     args = []
  ///
  ///                 res = self._call_userfunc(x, args)
  ///                 if res is not Discard:
  ///                     stack.append(res)
  ///
  ///             elif self.__visit_tokens__ and isinstance(x, Token):
  ///                 res = self._call_userfunc_token(x)
  ///                 if res is not Discard:
  ///                     stack.append(res)
  ///             else:
  ///                 stack.append(x)
  ///
  ///         result, = stack  # We should have only one tree remaining
  ///         # There are no guarantees on the type of the value produced by calling a user func for a
  ///         # child will produce. This means type system can't statically know that the final result is
  ///         # _Return_T. As a result a cast is required.
  ///         return cast(_Return_T, result)
  /// ```
  Object? transform({
    required Object? tree,
  }) =>
      getFunction("transform").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );
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
///         meta attributes: line, column, start_pos, end_line, end_column, end_pos
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
///             meta attributes: line, column, start_pos, end_line, end_column, end_pos
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
///     def __rich__(self, parent:'rich.tree.Tree'=None) -> 'rich.tree.Tree':
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
    required Object? data,
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
    required Object? data,
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
  Object? pretty({
    Object? indent_str = "  ",
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
  Object? scan_values({
    required Object? pred,
  }) =>
      getFunction("scan_values").call(
        <Object?>[
          pred,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set
  ///
  /// ### python source
  /// ```py
  /// def set(self, data: str, children: 'List[Branch[_Leaf_T]]') -> None:
  ///         self.data = data
  ///         self.children = children
  /// ```
  Object? $set({
    required Object? data,
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
  Object? get meta => getAttribute("meta");

  /// ## meta (setter)
  set meta(Object? meta) => setAttribute("meta", meta);

  /// ## data (getter)
  Object? get data => getAttribute("data");

  /// ## data (setter)
  set data(Object? data) => setAttribute("data", data);

  /// ## children (getter)
  Object? get children => getAttribute("children");

  /// ## children (setter)
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
  Object? get_context({
    required Object? text,
    Object? span = 40,
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
    Object? token_type_match_fallback = false,
    Object? use_accepts = true,
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

  /// ## pos_in_stream (getter)
  Object? get pos_in_stream => getAttribute("pos_in_stream");

  /// ## pos_in_stream (setter)
  set pos_in_stream(Object? pos_in_stream) =>
      setAttribute("pos_in_stream", pos_in_stream);

  /// ## line (getter)
  Object? get line => getAttribute("line");

  /// ## line (setter)
  set line(Object? line) => setAttribute("line", line);

  /// ## column (getter)
  Object? get column => getAttribute("column");

  /// ## column (setter)
  set column(Object? column) => setAttribute("column", column);

  /// ## state (getter)
  Object? get state => getAttribute("state");

  /// ## state (setter)
  set state(Object? state) => setAttribute("state", state);

  /// ## allowed (getter)
  Object? get allowed => getAttribute("allowed");

  /// ## allowed (setter)
  set allowed(Object? allowed) => setAttribute("allowed", allowed);

  /// ## considered_tokens (getter)
  Object? get considered_tokens => getAttribute("considered_tokens");

  /// ## considered_tokens (setter)
  set considered_tokens(Object? considered_tokens) =>
      setAttribute("considered_tokens", considered_tokens);

  /// ## considered_rules (getter)
  Object? get considered_rules => getAttribute("considered_rules");

  /// ## considered_rules (setter)
  set considered_rules(Object? considered_rules) =>
      setAttribute("considered_rules", considered_rules);

  /// ## token_history (getter)
  Object? get token_history => getAttribute("token_history");

  /// ## token_history (setter)
  set token_history(Object? token_history) =>
      setAttribute("token_history", token_history);

  /// ## char (getter)
  Object? get char => getAttribute("char");

  /// ## char (setter)
  set char(Object? char) => setAttribute("char", char);
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
  Object? get_context({
    required Object? text,
    Object? span = 40,
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
    Object? token_type_match_fallback = false,
    Object? use_accepts = true,
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

  /// ## pos_in_stream (getter)
  Object? get pos_in_stream => getAttribute("pos_in_stream");

  /// ## pos_in_stream (setter)
  set pos_in_stream(Object? pos_in_stream) =>
      setAttribute("pos_in_stream", pos_in_stream);

  /// ## expected (getter)
  Object? get expected => getAttribute("expected");

  /// ## expected (setter)
  set expected(Object? expected) => setAttribute("expected", expected);

  /// ## state (getter)
  Object? get state => getAttribute("state");

  /// ## state (setter)
  set state(Object? state) => setAttribute("state", state);

  /// ## token (getter)
  Object? get token => getAttribute("token");

  /// ## token (setter)
  set token(Object? token) => setAttribute("token", token);

  /// ## line (getter)
  Object? get line => getAttribute("line");

  /// ## line (setter)
  set line(Object? line) => setAttribute("line", line);

  /// ## column (getter)
  Object? get column => getAttribute("column");

  /// ## column (setter)
  set column(Object? column) => setAttribute("column", column);
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
  Object? get_context({
    required Object? text,
    Object? span = 40,
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
    Object? token_type_match_fallback = false,
    Object? use_accepts = true,
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

  /// ## pos_in_stream (getter)
  Object? get pos_in_stream => getAttribute("pos_in_stream");

  /// ## pos_in_stream (setter)
  set pos_in_stream(Object? pos_in_stream) =>
      setAttribute("pos_in_stream", pos_in_stream);
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
///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failture,
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
///         interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failture,
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
  Object? get_context({
    required Object? text,
    Object? span = 40,
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
    Object? token_type_match_fallback = false,
    Object? use_accepts = true,
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
  Object? get accepts => getAttribute("accepts");

  /// ## accepts (setter)
  set accepts(Object? accepts) => setAttribute("accepts", accepts);

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

  /// ## pos_in_stream (getter)
  Object? get pos_in_stream => getAttribute("pos_in_stream");

  /// ## pos_in_stream (setter)
  set pos_in_stream(Object? pos_in_stream) =>
      setAttribute("pos_in_stream", pos_in_stream);

  /// ## line (getter)
  Object? get line => getAttribute("line");

  /// ## line (setter)
  set line(Object? line) => setAttribute("line", line);

  /// ## column (getter)
  Object? get column => getAttribute("column");

  /// ## column (setter)
  set column(Object? column) => setAttribute("column", column);

  /// ## state (getter)
  Object? get state => getAttribute("state");

  /// ## state (setter)
  set state(Object? state) => setAttribute("state", state);

  /// ## token (getter)
  Object? get token => getAttribute("token");

  /// ## token (setter)
  set token(Object? token) => setAttribute("token", token);

  /// ## expected (getter)
  Object? get expected => getAttribute("expected");

  /// ## expected (setter)
  set expected(Object? expected) => setAttribute("expected", expected);

  /// ## considered_rules (getter)
  Object? get considered_rules => getAttribute("considered_rules");

  /// ## considered_rules (setter)
  set considered_rules(Object? considered_rules) =>
      setAttribute("considered_rules", considered_rules);

  /// ## interactive_parser (getter)
  Object? get interactive_parser => getAttribute("interactive_parser");

  /// ## interactive_parser (setter)
  set interactive_parser(Object? interactive_parser) =>
      setAttribute("interactive_parser", interactive_parser);

  /// ## token_history (getter)
  Object? get token_history => getAttribute("token_history");

  /// ## token_history (setter)
  set token_history(Object? token_history) =>
      setAttribute("token_history", token_history);
}

/// ## Visitor
///
/// ### python docstring
///
/// Tree visitor, non-recursive (can handle huge trees).
///
/// Visiting a node calls its methods (provided by the user via inheritance) according to ``tree.data``
///
/// ### python source
/// ```py
/// class Visitor(VisitorBase, ABC, Generic[_Leaf_T]):
///     """Tree visitor, non-recursive (can handle huge trees).
///
///     Visiting a node calls its methods (provided by the user via inheritance) according to ``tree.data``
///     """
///
///     def visit(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
///         "Visits the tree, starting with the leaves and finally the root (bottom-up)"
///         for subtree in tree.iter_subtrees():
///             self._call_userfunc(subtree)
///         return tree
///
///     def visit_topdown(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
///         "Visit the tree, starting at the root, and ending at the leaves (top-down)"
///         for subtree in tree.iter_subtrees_topdown():
///             self._call_userfunc(subtree)
///         return tree
/// ```
final class Visitor extends PythonClass {
  factory Visitor() => PythonFfiDart.instance.importClass(
        "lark.visitors",
        "Visitor",
        Visitor.from,
        <Object?>[],
      );

  Visitor.from(super.pythonClass) : super.from();

  /// ## visit
  ///
  /// ### python docstring
  ///
  /// Visits the tree, starting with the leaves and finally the root (bottom-up)
  ///
  /// ### python source
  /// ```py
  /// def visit(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
  ///         "Visits the tree, starting with the leaves and finally the root (bottom-up)"
  ///         for subtree in tree.iter_subtrees():
  ///             self._call_userfunc(subtree)
  ///         return tree
  /// ```
  Object? visit({
    required Object? tree,
  }) =>
      getFunction("visit").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_topdown
  ///
  /// ### python docstring
  ///
  /// Visit the tree, starting at the root, and ending at the leaves (top-down)
  ///
  /// ### python source
  /// ```py
  /// def visit_topdown(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
  ///         "Visit the tree, starting at the root, and ending at the leaves (top-down)"
  ///         for subtree in tree.iter_subtrees_topdown():
  ///             self._call_userfunc(subtree)
  ///         return tree
  /// ```
  Object? visit_topdown({
    required Object? tree,
  }) =>
      getFunction("visit_topdown").call(
        <Object?>[
          tree,
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
///
///     def __init__(self, terminals: Collection[TerminalDef], re_module: ModuleType, ignore: Collection[str]=(), postlex: 'Optional[PostLex]'=None, callbacks: Optional[Dict[str, _Callback]]=None, g_regex_flags: int=0, skip_validation: bool=False, use_bytes: bool=False):
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
    Object? g_regex_flags = 0,
    Object? skip_validation = false,
    Object? use_bytes = false,
  }) =>
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
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## terminals (getter)
  Object? get terminals => getAttribute("terminals");

  /// ## terminals (setter)
  set terminals(Object? terminals) => setAttribute("terminals", terminals);

  /// ## terminals_by_name (getter)
  Object? get terminals_by_name => getAttribute("terminals_by_name");

  /// ## terminals_by_name (setter)
  set terminals_by_name(Object? terminals_by_name) =>
      setAttribute("terminals_by_name", terminals_by_name);

  /// ## ignore (getter)
  Object? get ignore => getAttribute("ignore");

  /// ## ignore (setter)
  set ignore(Object? ignore) => setAttribute("ignore", ignore);

  /// ## postlex (getter)
  Object? get postlex => getAttribute("postlex");

  /// ## postlex (setter)
  set postlex(Object? postlex) => setAttribute("postlex", postlex);

  /// ## callbacks (getter)
  Object? get callbacks => getAttribute("callbacks");

  /// ## callbacks (setter)
  set callbacks(Object? callbacks) => setAttribute("callbacks", callbacks);

  /// ## g_regex_flags (getter)
  Object? get g_regex_flags => getAttribute("g_regex_flags");

  /// ## g_regex_flags (setter)
  set g_regex_flags(Object? g_regex_flags) =>
      setAttribute("g_regex_flags", g_regex_flags);

  /// ## re_module (getter)
  Object? get re_module => getAttribute("re_module");

  /// ## re_module (setter)
  set re_module(Object? re_module) => setAttribute("re_module", re_module);

  /// ## skip_validation (getter)
  Object? get skip_validation => getAttribute("skip_validation");

  /// ## skip_validation (setter)
  set skip_validation(Object? skip_validation) =>
      setAttribute("skip_validation", skip_validation);

  /// ## use_bytes (getter)
  Object? get use_bytes => getAttribute("use_bytes");

  /// ## use_bytes (setter)
  set use_bytes(Object? use_bytes) => setAttribute("use_bytes", use_bytes);

  /// ## lexer_type (getter)
  Object? get lexer_type => getAttribute("lexer_type");

  /// ## lexer_type (setter)
  set lexer_type(Object? lexer_type) => setAttribute("lexer_type", lexer_type);
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
        "lark.common",
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
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## rules (getter)
  Object? get rules => getAttribute("rules");

  /// ## rules (setter)
  set rules(Object? rules) => setAttribute("rules", rules);

  /// ## callbacks (getter)
  Object? get callbacks => getAttribute("callbacks");

  /// ## callbacks (setter)
  set callbacks(Object? callbacks) => setAttribute("callbacks", callbacks);

  /// ## start (getter)
  Object? get start => getAttribute("start");

  /// ## start (setter)
  set start(Object? start) => setAttribute("start", start);

  /// ## parser_type (getter)
  Object? get parser_type => getAttribute("parser_type");

  /// ## parser_type (setter)
  set parser_type(Object? parser_type) =>
      setAttribute("parser_type", parser_type);
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
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
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
///     def __init__(self, name: str, pattern: Pattern, priority: int=TOKEN_DEFAULT_PRIORITY) -> None:
///         assert isinstance(pattern, Pattern), pattern
///         self.name = name
///         self.pattern = pattern
///         self.priority = priority
///
///     def __repr__(self):
///         return '%s(%r, %r)' % (type(self).__name__, self.name, self.pattern)
///
///     def user_repr(self) -> str:
///         if self.name.startswith('__'): # We represent a generated terminal
///             return self.pattern.raw or self.name
///         else:
///             return self.name
/// ```
final class TerminalDef extends PythonClass {
  factory TerminalDef({
    required Object? name,
    required Object? pattern,
    Object? priority = 0,
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
  ///         if self.name.startswith('__'): # We represent a generated terminal
  ///             return self.pattern.raw or self.name
  ///         else:
  ///             return self.name
  /// ```
  Object? user_repr() => getFunction("user_repr").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## deserialize (getter)
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## name (getter)
  Object? get name => getAttribute("name");

  /// ## name (setter)
  set name(Object? name) => setAttribute("name", name);

  /// ## pattern (getter)
  Object? get pattern => getAttribute("pattern");

  /// ## pattern (setter)
  set pattern(Object? pattern) => setAttribute("pattern", pattern);

  /// ## priority (getter)
  Object? get priority => getAttribute("priority");

  /// ## priority (setter)
  set priority(Object? priority) => setAttribute("priority", priority);
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
        "lark.exceptions",
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

/// ## MissingVariableError
///
/// ### python source
/// ```py
/// class MissingVariableError(LarkError):
///     pass
/// ```
final class MissingVariableError extends PythonClass {
  factory MissingVariableError() => PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "MissingVariableError",
        MissingVariableError.from,
        <Object?>[],
      );

  MissingVariableError.from(super.pythonClass) : super.from();

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

/// ## VisitError
///
/// ### python docstring
///
/// VisitError is raised when visitors are interrupted by an exception
///
/// It provides the following attributes for inspection:
///
/// Parameters:
///     rule: the name of the visit rule that failed
///     obj: the tree-node or token that was being processed
///     orig_exc: the exception that cause it to fail
///
/// Note: These parameters are available as attributes
///
/// ### python source
/// ```py
/// class VisitError(LarkError):
///     """VisitError is raised when visitors are interrupted by an exception
///
///     It provides the following attributes for inspection:
///
///     Parameters:
///         rule: the name of the visit rule that failed
///         obj: the tree-node or token that was being processed
///         orig_exc: the exception that cause it to fail
///
///     Note: These parameters are available as attributes
///     """
///
///     obj: 'Union[Tree, Token]'
///     orig_exc: Exception
///
///     def __init__(self, rule, obj, orig_exc):
///         message = 'Error trying to process rule "%s":\n\n%s' % (rule, orig_exc)
///         super(VisitError, self).__init__(message)
///
///         self.rule = rule
///         self.obj = obj
///         self.orig_exc = orig_exc
/// ```
final class VisitError extends PythonClass {
  factory VisitError({
    required Object? rule,
    required Object? obj,
    required Object? orig_exc,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "VisitError",
        VisitError.from,
        <Object?>[
          rule,
          obj,
          orig_exc,
        ],
        <String, Object?>{},
      );

  VisitError.from(super.pythonClass) : super.from();

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

  /// ## rule (getter)
  Object? get rule => getAttribute("rule");

  /// ## rule (setter)
  set rule(Object? rule) => setAttribute("rule", rule);

  /// ## obj (getter)
  Object? get obj => getAttribute("obj");

  /// ## obj (setter)
  set obj(Object? obj) => setAttribute("obj", obj);

  /// ## orig_exc (getter)
  Object? get orig_exc => getAttribute("orig_exc");

  /// ## orig_exc (setter)
  set orig_exc(Object? orig_exc) => setAttribute("orig_exc", orig_exc);
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
    required Object? name,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.grammar",
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
  Object? get fullrepr => getAttribute("fullrepr");

  /// ## fullrepr (setter)
  set fullrepr(Object? fullrepr) => setAttribute("fullrepr", fullrepr);

  /// ## deserialize (getter)
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## is_term (getter)
  Object? get is_term => getAttribute("is_term");

  /// ## is_term (setter)
  set is_term(Object? is_term) => setAttribute("is_term", is_term);

  /// ## name (getter)
  Object? get name => getAttribute("name");

  /// ## name (setter)
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
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## alias (getter)
  Object? get alias => getAttribute("alias");

  /// ## alias (setter)
  set alias(Object? alias) => setAttribute("alias", alias);

  /// ## expansion (getter)
  Object? get expansion => getAttribute("expansion");

  /// ## expansion (setter)
  set expansion(Object? expansion) => setAttribute("expansion", expansion);

  /// ## options (getter)
  Object? get options => getAttribute("options");

  /// ## options (setter)
  set options(Object? options) => setAttribute("options", options);

  /// ## order (getter)
  Object? get order => getAttribute("order");

  /// ## order (setter)
  set order(Object? order) => setAttribute("order", order);

  /// ## origin (getter)
  Object? get origin => getAttribute("origin");

  /// ## origin (setter)
  set origin(Object? origin) => setAttribute("origin", origin);
}

/// ## RuleOptions
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
/// class RuleOptions(Serialize):
///     __serialize_fields__ = 'keep_all_tokens', 'expand1', 'priority', 'template_source', 'empty_indices'
///
///     keep_all_tokens: bool
///     expand1: bool
///     priority: Optional[int]
///     template_source: Optional[str]
///     empty_indices: Tuple[bool, ...]
///
///     def __init__(self, keep_all_tokens: bool=False, expand1: bool=False, priority: Optional[int]=None, template_source: Optional[str]=None, empty_indices: Tuple[bool, ...]=()) -> None:
///         self.keep_all_tokens = keep_all_tokens
///         self.expand1 = expand1
///         self.priority = priority
///         self.template_source = template_source
///         self.empty_indices = empty_indices
///
///     def __repr__(self):
///         return 'RuleOptions(%r, %r, %r, %r)' % (
///             self.keep_all_tokens,
///             self.expand1,
///             self.priority,
///             self.template_source
///         )
/// ```
final class RuleOptions extends PythonClass {
  factory RuleOptions({
    Object? keep_all_tokens = false,
    Object? expand1 = false,
    Object? priority,
    Object? template_source,
    Object? empty_indices = const [],
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.grammar",
        "RuleOptions",
        RuleOptions.from,
        <Object?>[
          keep_all_tokens,
          expand1,
          priority,
          template_source,
          empty_indices,
        ],
        <String, Object?>{},
      );

  RuleOptions.from(super.pythonClass) : super.from();

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
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## keep_all_tokens (getter)
  Object? get keep_all_tokens => getAttribute("keep_all_tokens");

  /// ## keep_all_tokens (setter)
  set keep_all_tokens(Object? keep_all_tokens) =>
      setAttribute("keep_all_tokens", keep_all_tokens);

  /// ## expand1 (getter)
  Object? get expand1 => getAttribute("expand1");

  /// ## expand1 (setter)
  set expand1(Object? expand1) => setAttribute("expand1", expand1);

  /// ## priority (getter)
  Object? get priority => getAttribute("priority");

  /// ## priority (setter)
  set priority(Object? priority) => setAttribute("priority", priority);

  /// ## template_source (getter)
  Object? get template_source => getAttribute("template_source");

  /// ## template_source (setter)
  set template_source(Object? template_source) =>
      setAttribute("template_source", template_source);

  /// ## empty_indices (getter)
  Object? get empty_indices => getAttribute("empty_indices");

  /// ## empty_indices (setter)
  set empty_indices(Object? empty_indices) =>
      setAttribute("empty_indices", empty_indices);
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
    required Object? name,
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
  Object? get fullrepr => getAttribute("fullrepr");

  /// ## fullrepr (setter)
  set fullrepr(Object? fullrepr) => setAttribute("fullrepr", fullrepr);

  /// ## is_term (getter)
  Object? get is_term => getAttribute("is_term");

  /// ## is_term (setter)
  set is_term(Object? is_term) => setAttribute("is_term", is_term);

  /// ## deserialize (getter)
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## name (getter)
  Object? get name => getAttribute("name");

  /// ## name (setter)
  set name(Object? name) => setAttribute("name", name);
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
  Object? get fullrepr => getAttribute("fullrepr");

  /// ## fullrepr (setter)
  set fullrepr(Object? fullrepr) => setAttribute("fullrepr", fullrepr);

  /// ## deserialize (getter)
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## is_term (getter)
  Object? get is_term => getAttribute("is_term");

  /// ## is_term (setter)
  set is_term(Object? is_term) => setAttribute("is_term", is_term);

  /// ## name (getter)
  Object? get name => getAttribute("name");

  /// ## name (setter)
  set name(Object? name) => setAttribute("name", name);

  /// ## filter_out (getter)
  Object? get filter_out => getAttribute("filter_out");

  /// ## filter_out (setter)
  set filter_out(Object? filter_out) => setAttribute("filter_out", filter_out);
}

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
///
///     terminals: Collection[TerminalDef]
///     ignore_types: FrozenSet[str]
///     newline_types: FrozenSet[str]
///     user_callbacks: Dict[str, _Callback]
///     callback: Dict[str, _Callback]
///     re: ModuleType
///
///     def __init__(self, conf: 'LexerConf') -> None:
///         terminals = list(conf.terminals)
///         assert all(isinstance(t, TerminalDef) for t in terminals), terminals
///
///         self.re = conf.re_module
///
///         if not conf.skip_validation:
///             # Sanitization
///             for t in terminals:
///                 try:
///                     self.re.compile(t.pattern.to_regexp(), conf.g_regex_flags)
///                 except self.re.error:
///                     raise LexError("Cannot compile token %s: %s" % (t.name, t.pattern))
///
///                 if t.pattern.min_width == 0:
///                     raise LexError("Lexer does not allow zero-width terminals. (%s: %s)" % (t.name, t.pattern))
///
///             if not (set(conf.ignore) <= {t.name for t in terminals}):
///                 raise LexError("Ignore terminals are not defined: %s" % (set(conf.ignore) - {t.name for t in terminals}))
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
///     def next_token(self, lex_state: LexerState, parser_state: Any=None) -> Token:
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
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lexer",
        "BasicLexer",
        BasicLexer.from,
        <Object?>[
          conf,
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
  Object? lex({
    required Object? state,
    required Object? parser_state,
  }) =>
      getFunction("lex").call(
        <Object?>[
          state,
          parser_state,
        ],
        kwargs: <String, Object?>{},
      );

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
  /// def next_token(self, lex_state: LexerState, parser_state: Any=None) -> Token:
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
  Object? next_token({
    required Object? lex_state,
    Object? parser_state,
  }) =>
      getFunction("next_token").call(
        <Object?>[
          lex_state,
          parser_state,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## scanner (getter)
  Object? get scanner => getAttribute("scanner");

  /// ## scanner (setter)
  set scanner(Object? scanner) => setAttribute("scanner", scanner);

  /// ## terminals (getter)
  Object? get terminals => getAttribute("terminals");

  /// ## terminals (setter)
  set terminals(Object? terminals) => setAttribute("terminals", terminals);

  /// ## re (getter)
  Object? get re => getAttribute("re");

  /// ## re (setter)
  set re(Object? re) => setAttribute("re", re);

  /// ## g_regex_flags (getter)
  Object? get g_regex_flags => getAttribute("g_regex_flags");

  /// ## g_regex_flags (setter)
  set g_regex_flags(Object? g_regex_flags) =>
      setAttribute("g_regex_flags", g_regex_flags);

  /// ## newline_types (getter)
  Object? get newline_types => getAttribute("newline_types");

  /// ## newline_types (setter)
  set newline_types(Object? newline_types) =>
      setAttribute("newline_types", newline_types);

  /// ## ignore_types (getter)
  Object? get ignore_types => getAttribute("ignore_types");

  /// ## ignore_types (setter)
  set ignore_types(Object? ignore_types) =>
      setAttribute("ignore_types", ignore_types);

  /// ## user_callbacks (getter)
  Object? get user_callbacks => getAttribute("user_callbacks");

  /// ## user_callbacks (setter)
  set user_callbacks(Object? user_callbacks) =>
      setAttribute("user_callbacks", user_callbacks);

  /// ## use_bytes (getter)
  Object? get use_bytes => getAttribute("use_bytes");

  /// ## use_bytes (setter)
  set use_bytes(Object? use_bytes) => setAttribute("use_bytes", use_bytes);

  /// ## terminals_by_name (getter)
  Object? get terminals_by_name => getAttribute("terminals_by_name");

  /// ## terminals_by_name (setter)
  set terminals_by_name(Object? terminals_by_name) =>
      setAttribute("terminals_by_name", terminals_by_name);
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
    required Object? pkg_name,
    Object? search_paths = const [""],
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
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
  Object? get pkg_name => getAttribute("pkg_name");

  /// ## pkg_name (setter)
  set pkg_name(Object? pkg_name) => setAttribute("pkg_name", pkg_name);

  /// ## search_paths (getter)
  Object? get search_paths => getAttribute("search_paths");

  /// ## search_paths (setter)
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
        "lark.load_grammar",
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
/// transformer
///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
/// propagate_positions
///         Propagates (line, column, end_line, end_column) attributes into all tree branches.
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
///     transformer
///             Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
///     propagate_positions
///             Propagates (line, column, end_line, end_column) attributes into all tree branches.
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
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## OPTIONS_DOC (getter)
  Object? get OPTIONS_DOC => getAttribute("OPTIONS_DOC");

  /// ## OPTIONS_DOC (setter)
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
  Object? get from_text => getAttribute("from_text");

  /// ## from_text (setter)
  set from_text(Object? from_text) => setAttribute("from_text", from_text);

  /// ## lexer (getter)
  Object? get lexer => getAttribute("lexer");

  /// ## lexer (setter)
  set lexer(Object? lexer) => setAttribute("lexer", lexer);

  /// ## state (getter)
  Object? get state => getAttribute("state");

  /// ## state (setter)
  set state(Object? state) => setAttribute("state", state);
}

/// ## PackageResource
///
/// ### python docstring
///
/// PackageResource(pkg_name, path)
final class PackageResource extends PythonClass {
  factory PackageResource() => PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "PackageResource",
        PackageResource.from,
        <Object?>[],
      );

  PackageResource.from(super.pythonClass) : super.from();

  /// ## path (getter)
  ///
  /// ### python docstring
  ///
  /// Alias for field number 1
  Object? get path => getAttribute("path");

  /// ## path (setter)
  ///
  /// ### python docstring
  ///
  /// Alias for field number 1
  set path(Object? path) => setAttribute("path", path);

  /// ## pkg_name (getter)
  ///
  /// ### python docstring
  ///
  /// Alias for field number 0
  Object? get pkg_name => getAttribute("pkg_name");

  /// ## pkg_name (setter)
  ///
  /// ### python docstring
  ///
  /// Alias for field number 0
  set pkg_name(Object? pkg_name) => setAttribute("pkg_name", pkg_name);

  /// ## count (getter)
  Object? get count => getAttribute("count");

  /// ## count (setter)
  set count(Object? count) => setAttribute("count", count);

  /// ## index (getter)
  Object? get index => getAttribute("index");

  /// ## index (setter)
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
        "lark.parse_tree_builder",
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
  Object? process({
    required Object? stream,
  }) =>
      getFunction("process").call(
        <Object?>[
          stream,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## always_accept (getter)
  Object? get always_accept => getAttribute("always_accept");

  /// ## always_accept (setter)
  set always_accept(Object? always_accept) =>
      setAttribute("always_accept", always_accept);
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
  Object? in_types({
    required Object? value,
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
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## types_to_memoize (getter)
  Object? get types_to_memoize => getAttribute("types_to_memoize");

  /// ## types_to_memoize (setter)
  set types_to_memoize(Object? types_to_memoize) =>
      setAttribute("types_to_memoize", types_to_memoize);

  /// ## memoized (getter)
  Object? get memoized => getAttribute("memoized");

  /// ## memoized (setter)
  set memoized(Object? memoized) => setAttribute("memoized", memoized);
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
///                 lexer = BasicLexer(lexer_conf)
///                 lexer_by_tokens[key] = lexer
///
///             self.lexers[state] = lexer
///
///         assert trad_conf.terminals is terminals
///         self.root_lexer = BasicLexer(trad_conf)
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
  Object? get lexers => getAttribute("lexers");

  /// ## lexers (setter)
  set lexers(Object? lexers) => setAttribute("lexers", lexers);

  /// ## root_lexer (getter)
  Object? get root_lexer => getAttribute("root_lexer");

  /// ## root_lexer (setter)
  set root_lexer(Object? root_lexer) => setAttribute("root_lexer", root_lexer);
}

/// ## LexerState
///
/// ### python docstring
///
/// Represents the current state of the lexer as it scans the text
/// (Lexer objects are only instanciated per grammar, not per text)
///
/// ### python source
/// ```py
/// class LexerState:
///     """Represents the current state of the lexer as it scans the text
///     (Lexer objects are only instanciated per grammar, not per text)
///     """
///
///     __slots__ = 'text', 'line_ctr', 'last_token'
///
///     def __init__(self, text, line_ctr=None, last_token=None):
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
    required Object? text,
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
  Object? get last_token => getAttribute("last_token");

  /// ## last_token (setter)
  set last_token(Object? last_token) => setAttribute("last_token", last_token);

  /// ## line_ctr (getter)
  Object? get line_ctr => getAttribute("line_ctr");

  /// ## line_ctr (setter)
  set line_ctr(Object? line_ctr) => setAttribute("line_ctr", line_ctr);

  /// ## text (getter)
  Object? get text => getAttribute("text");

  /// ## text (setter)
  set text(Object? text) => setAttribute("text", text);
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
    required Object? token,
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
///     def __init__(self, value: str, flags: Collection[str]=(), raw: Optional[str]=None) -> None:
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
    required Object? value,
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
  Object? to_regexp() => getFunction("to_regexp").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## max_width (getter)
  Object? get max_width => getAttribute("max_width");

  /// ## max_width (setter)
  set max_width(Object? max_width) => setAttribute("max_width", max_width);

  /// ## min_width (getter)
  Object? get min_width => getAttribute("min_width");

  /// ## min_width (setter)
  set min_width(Object? min_width) => setAttribute("min_width", min_width);

  /// ## deserialize (getter)
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## value (getter)
  Object? get value => getAttribute("value");

  /// ## value (setter)
  set value(Object? value) => setAttribute("value", value);

  /// ## flags (getter)
  Object? get flags => getAttribute("flags");

  /// ## flags (setter)
  set flags(Object? flags) => setAttribute("flags", flags);

  /// ## raw (getter)
  Object? get raw => getAttribute("raw");

  /// ## raw (setter)
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
///     __serialize_fields__ = 'value', 'flags', '_width'
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
/// ```
final class PatternRE extends PythonClass {
  factory PatternRE({
    required Object? value,
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
  Object? to_regexp() => getFunction("to_regexp").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## max_width (getter)
  Object? get max_width => getAttribute("max_width");

  /// ## max_width (setter)
  set max_width(Object? max_width) => setAttribute("max_width", max_width);

  /// ## min_width (getter)
  Object? get min_width => getAttribute("min_width");

  /// ## min_width (setter)
  set min_width(Object? min_width) => setAttribute("min_width", min_width);

  /// ## deserialize (getter)
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## type (getter)
  Object? get type => getAttribute("type");

  /// ## type (setter)
  set type(Object? type) => setAttribute("type", type);

  /// ## value (getter)
  Object? get value => getAttribute("value");

  /// ## value (setter)
  set value(Object? value) => setAttribute("value", value);

  /// ## flags (getter)
  Object? get flags => getAttribute("flags");

  /// ## flags (setter)
  set flags(Object? flags) => setAttribute("flags", flags);

  /// ## raw (getter)
  Object? get raw => getAttribute("raw");

  /// ## raw (setter)
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
///     __serialize_fields__ = 'value', 'flags'
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
    required Object? value,
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
  Object? to_regexp() => getFunction("to_regexp").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## max_width (getter)
  Object? get max_width => getAttribute("max_width");

  /// ## max_width (setter)
  set max_width(Object? max_width) => setAttribute("max_width", max_width);

  /// ## min_width (getter)
  Object? get min_width => getAttribute("min_width");

  /// ## min_width (setter)
  set min_width(Object? min_width) => setAttribute("min_width", min_width);

  /// ## deserialize (getter)
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## type (getter)
  Object? get type => getAttribute("type");

  /// ## type (setter)
  set type(Object? type) => setAttribute("type", type);

  /// ## value (getter)
  Object? get value => getAttribute("value");

  /// ## value (setter)
  set value(Object? value) => setAttribute("value", value);

  /// ## flags (getter)
  Object? get flags => getAttribute("flags");

  /// ## flags (setter)
  set flags(Object? flags) => setAttribute("flags", flags);

  /// ## raw (getter)
  Object? get raw => getAttribute("raw");

  /// ## raw (setter)
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
///                 return self._build_mres(terminals, max_size//2)
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

/// ## ApplyTemplates
///
/// ### python docstring
///
/// Apply the templates, creating new rules that represent the used templates
///
/// ### python source
/// ```py
/// class ApplyTemplates(Transformer_InPlace):
///     """Apply the templates, creating new rules that represent the used templates"""
///
///     def __init__(self, rule_defs):
///         self.rule_defs = rule_defs
///         self.replacer = _ReplaceSymbols()
///         self.created_templates = set()
///
///     def template_usage(self, c):
///         name = c[0].name
///         args = c[1:]
///         result_name = "%s{%s}" % (name, ",".join(a.name for a in args))
///         if result_name not in self.created_templates:
///             self.created_templates.add(result_name)
///             (_n, params, tree, options) ,= (t for t in self.rule_defs if t[0] == name)
///             assert len(params) == len(args), args
///             result_tree = deepcopy(tree)
///             self.replacer.names = dict(zip(params, args))
///             self.replacer.transform(result_tree)
///             self.rule_defs.append((result_name, [], result_tree, deepcopy(options)))
///         return NonTerminal(result_name)
/// ```
final class ApplyTemplates extends PythonClass {
  factory ApplyTemplates({
    required Object? rule_defs,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "ApplyTemplates",
        ApplyTemplates.from,
        <Object?>[
          rule_defs,
        ],
        <String, Object?>{},
      );

  ApplyTemplates.from(super.pythonClass) : super.from();

  /// ## template_usage
  ///
  /// ### python source
  /// ```py
  /// def template_usage(self, c):
  ///         name = c[0].name
  ///         args = c[1:]
  ///         result_name = "%s{%s}" % (name, ",".join(a.name for a in args))
  ///         if result_name not in self.created_templates:
  ///             self.created_templates.add(result_name)
  ///             (_n, params, tree, options) ,= (t for t in self.rule_defs if t[0] == name)
  ///             assert len(params) == len(args), args
  ///             result_tree = deepcopy(tree)
  ///             self.replacer.names = dict(zip(params, args))
  ///             self.replacer.transform(result_tree)
  ///             self.rule_defs.append((result_name, [], result_tree, deepcopy(options)))
  ///         return NonTerminal(result_name)
  /// ```
  Object? template_usage({
    required Object? c,
  }) =>
      getFunction("template_usage").call(
        <Object?>[
          c,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         for subtree in tree.iter_subtrees():
  ///             subtree.children = list(self._transform_children(subtree.children))
  ///
  ///         return self._transform_tree(tree)
  /// ```
  Object? transform({
    required Object? tree,
  }) =>
      getFunction("transform").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## rule_defs (getter)
  Object? get rule_defs => getAttribute("rule_defs");

  /// ## rule_defs (setter)
  set rule_defs(Object? rule_defs) => setAttribute("rule_defs", rule_defs);

  /// ## replacer (getter)
  Object? get replacer => getAttribute("replacer");

  /// ## replacer (setter)
  set replacer(Object? replacer) => setAttribute("replacer", replacer);

  /// ## created_templates (getter)
  Object? get created_templates => getAttribute("created_templates");

  /// ## created_templates (setter)
  set created_templates(Object? created_templates) =>
      setAttribute("created_templates", created_templates);
}

/// ## Definition
///
/// ### python source
/// ```py
/// class Definition:
///     def __init__(self, is_term, tree, params=(), options=None):
///         self.is_term = is_term
///         self.tree = tree
///         self.params = tuple(params)
///         self.options = options
/// ```
final class Definition extends PythonClass {
  factory Definition({
    required Object? is_term,
    required Object? tree,
    Object? params = const [],
    Object? options,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "Definition",
        Definition.from,
        <Object?>[
          is_term,
          tree,
          params,
          options,
        ],
        <String, Object?>{},
      );

  Definition.from(super.pythonClass) : super.from();

  /// ## is_term (getter)
  Object? get is_term => getAttribute("is_term");

  /// ## is_term (setter)
  set is_term(Object? is_term) => setAttribute("is_term", is_term);

  /// ## tree (getter)
  Object? get tree => getAttribute("tree");

  /// ## tree (setter)
  set tree(Object? tree) => setAttribute("tree", tree);

  /// ## params (getter)
  Object? get params => getAttribute("params");

  /// ## params (setter)
  set params(Object? params) => setAttribute("params", params);

  /// ## options (getter)
  Object? get options => getAttribute("options");

  /// ## options (setter)
  set options(Object? options) => setAttribute("options", options);
}

/// ## EBNF_to_BNF
///
/// ### python docstring
///
/// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
///
/// Useful for huge trees. Conservative in memory.
///
/// ### python source
/// ```py
/// @inline_args
/// class EBNF_to_BNF(Transformer_InPlace):
///     def __init__(self):
///         self.new_rules = []
///         self.rules_cache = {}
///         self.prefix = 'anon'
///         self.i = 0
///         self.rule_options = None
///
///     def _name_rule(self, inner):
///         new_name = '__%s_%s_%d' % (self.prefix, inner, self.i)
///         self.i += 1
///         return new_name
///
///     def _add_rule(self, key, name, expansions):
///         t = NonTerminal(name)
///         self.new_rules.append((name, expansions, self.rule_options))
///         self.rules_cache[key] = t
///         return t
///
///     def _add_recurse_rule(self, type_, expr):
///         try:
///             return self.rules_cache[expr]
///         except KeyError:
///             new_name = self._name_rule(type_)
///             t = NonTerminal(new_name)
///             tree = ST('expansions', [
///                 ST('expansion', [expr]),
///                 ST('expansion', [t, expr])
///             ])
///             return self._add_rule(expr, new_name, tree)
///
///     def _add_repeat_rule(self, a, b, target, atom):
///         """Generate a rule that repeats target ``a`` times, and repeats atom ``b`` times.
///
///         When called recursively (into target), it repeats atom for x(n) times, where:
///             x(0) = 1
///             x(n) = a(n) * x(n-1) + b
///
///         Example rule when a=3, b=4:
///
///             new_rule: target target target atom atom atom atom
///
///         """
///         key = (a, b, target, atom)
///         try:
///             return self.rules_cache[key]
///         except KeyError:
///             new_name = self._name_rule('repeat_a%d_b%d' % (a, b))
///             tree = ST('expansions', [ST('expansion', [target] * a + [atom] * b)])
///             return self._add_rule(key, new_name, tree)
///
///     def _add_repeat_opt_rule(self, a, b, target, target_opt, atom):
///         """Creates a rule that matches atom 0 to (a*n+b)-1 times.
///
///         When target matches n times atom, and target_opt 0 to n-1 times target_opt,
///
///         First we generate target * i followed by target_opt, for i from 0 to a-1
///         These match 0 to n*a - 1 times atom
///
///         Then we generate target * a followed by atom * i, for i from 0 to b-1
///         These match n*a to n*a + b-1 times atom
///
///         The created rule will not have any shift/reduce conflicts so that it can be used with lalr
///
///         Example rule when a=3, b=4:
///
///             new_rule: target_opt
///                     | target target_opt
///                     | target target target_opt
///
///                     | target target target
///                     | target target target atom
///                     | target target target atom atom
///                     | target target target atom atom atom
///
///         """
///         key = (a, b, target, atom, "opt")
///         try:
///             return self.rules_cache[key]
///         except KeyError:
///             new_name = self._name_rule('repeat_a%d_b%d_opt' % (a, b))
///             tree = ST('expansions', [
///                 ST('expansion', [target]*i + [target_opt]) for i in range(a)
///             ] + [
///                 ST('expansion', [target]*a + [atom]*i) for i in range(b)
///             ])
///             return self._add_rule(key, new_name, tree)
///
///     def _generate_repeats(self, rule, mn, mx):
///         """Generates a rule tree that repeats ``rule`` exactly between ``mn`` to ``mx`` times.
///         """
///         # For a small number of repeats, we can take the naive approach
///         if mx < REPEAT_BREAK_THRESHOLD:
///             return ST('expansions', [ST('expansion', [rule] * n) for n in range(mn, mx + 1)])
///
///         # For large repeat values, we break the repetition into sub-rules.
///         # We treat ``rule~mn..mx`` as ``rule~mn rule~0..(diff=mx-mn)``.
///         # We then use small_factors to split up mn and diff up into values [(a, b), ...]
///         # This values are used with the help of _add_repeat_rule and _add_repeat_rule_opt
///         # to generate a complete rule/expression that matches the corresponding number of repeats
///         mn_target = rule
///         for a, b in small_factors(mn, SMALL_FACTOR_THRESHOLD):
///             mn_target = self._add_repeat_rule(a, b, mn_target, rule)
///         if mx == mn:
///             return mn_target
///
///         diff = mx - mn + 1  # We add one because _add_repeat_opt_rule generates rules that match one less
///         diff_factors = small_factors(diff, SMALL_FACTOR_THRESHOLD)
///         diff_target = rule  # Match rule 1 times
///         diff_opt_target = ST('expansion', [])  # match rule 0 times (e.g. up to 1 -1 times)
///         for a, b in diff_factors[:-1]:
///             diff_opt_target = self._add_repeat_opt_rule(a, b, diff_target, diff_opt_target, rule)
///             diff_target = self._add_repeat_rule(a, b, diff_target, rule)
///
///         a, b = diff_factors[-1]
///         diff_opt_target = self._add_repeat_opt_rule(a, b, diff_target, diff_opt_target, rule)
///
///         return ST('expansions', [ST('expansion', [mn_target] + [diff_opt_target])])
///
///     def expr(self, rule, op, *args):
///         if op.value == '?':
///             empty = ST('expansion', [])
///             return ST('expansions', [rule, empty])
///         elif op.value == '+':
///             # a : b c+ d
///             #   -->
///             # a : b _c d
///             # _c : _c c | c;
///             return self._add_recurse_rule('plus', rule)
///         elif op.value == '*':
///             # a : b c* d
///             #   -->
///             # a : b _c? d
///             # _c : _c c | c;
///             new_name = self._add_recurse_rule('star', rule)
///             return ST('expansions', [new_name, ST('expansion', [])])
///         elif op.value == '~':
///             if len(args) == 1:
///                 mn = mx = int(args[0])
///             else:
///                 mn, mx = map(int, args)
///                 if mx < mn or mn < 0:
///                     raise GrammarError("Bad Range for %s (%d..%d isn't allowed)" % (rule, mn, mx))
///
///             return self._generate_repeats(rule, mn, mx)
///
///         assert False, op
///
///     def maybe(self, rule):
///         keep_all_tokens = self.rule_options and self.rule_options.keep_all_tokens
///         rule_size = FindRuleSize(keep_all_tokens).transform(rule)
///         empty = ST('expansion', [_EMPTY] * rule_size)
///         return ST('expansions', [rule, empty])
/// ```
final class EBNF_to_BNF extends PythonClass {
  factory EBNF_to_BNF() => PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "EBNF_to_BNF",
        EBNF_to_BNF.from,
        <Object?>[],
        <String, Object?>{},
      );

  EBNF_to_BNF.from(super.pythonClass) : super.from();

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         for subtree in tree.iter_subtrees():
  ///             subtree.children = list(self._transform_children(subtree.children))
  ///
  ///         return self._transform_tree(tree)
  /// ```
  Object? transform({
    required Object? tree,
  }) =>
      getFunction("transform").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expr (getter)
  Object? get expr => getAttribute("expr");

  /// ## expr (setter)
  set expr(Object? expr) => setAttribute("expr", expr);

  /// ## maybe (getter)
  Object? get maybe => getAttribute("maybe");

  /// ## maybe (setter)
  set maybe(Object? maybe) => setAttribute("maybe", maybe);

  /// ## new_rules (getter)
  Object? get new_rules => getAttribute("new_rules");

  /// ## new_rules (setter)
  set new_rules(Object? new_rules) => setAttribute("new_rules", new_rules);

  /// ## rules_cache (getter)
  Object? get rules_cache => getAttribute("rules_cache");

  /// ## rules_cache (setter)
  set rules_cache(Object? rules_cache) =>
      setAttribute("rules_cache", rules_cache);

  /// ## prefix (getter)
  Object? get prefix => getAttribute("prefix");

  /// ## prefix (setter)
  set prefix(Object? prefix) => setAttribute("prefix", prefix);

  /// ## i (getter)
  Object? get i => getAttribute("i");

  /// ## i (setter)
  set i(Object? i) => setAttribute("i", i);

  /// ## rule_options (getter)
  Object? get rule_options => getAttribute("rule_options");

  /// ## rule_options (setter)
  set rule_options(Object? rule_options) =>
      setAttribute("rule_options", rule_options);
}

/// ## FindRuleSize
///
/// ### python docstring
///
/// Transformers work bottom-up (or depth-first), starting with visiting the leaves and working
/// their way up until ending at the root of the tree.
///
/// For each node visited, the transformer will call the appropriate method (callbacks), according to the
/// node's ``data``, and use the returned value to replace the node, thereby creating a new tree structure.
///
/// Transformers can be used to implement map & reduce patterns. Because nodes are reduced from leaf to root,
/// at any point the callbacks may assume the children have already been transformed (if applicable).
///
/// If the transformer cannot find a method with the right name, it will instead call ``__default__``, which by
/// default creates a copy of the node.
///
/// To discard a node, return Discard (``lark.visitors.Discard``).
///
/// ``Transformer`` can do anything ``Visitor`` can do, but because it reconstructs the tree,
/// it is slightly less efficient.
///
/// A transformer without methods essentially performs a non-memoized partial deepcopy.
///
/// All these classes implement the transformer interface:
///
/// - ``Transformer`` - Recursively transforms the tree. This is the one you probably want.
/// - ``Transformer_InPlace`` - Non-recursive. Changes the tree in-place instead of returning new instances
/// - ``Transformer_InPlaceRecursive`` - Recursive. Changes the tree in-place instead of returning new instances
///
/// Parameters:
///     visit_tokens (bool, optional): Should the transformer visit tokens in addition to rules.
///                                    Setting this to ``False`` is slightly faster. Defaults to ``True``.
///                                    (For processing ignored tokens, use the ``lexer_callbacks`` options)
///
/// ### python source
/// ```py
/// class FindRuleSize(Transformer):
///     def __init__(self, keep_all_tokens):
///         self.keep_all_tokens = keep_all_tokens
///
///     def _will_not_get_removed(self, sym):
///         if isinstance(sym, NonTerminal):
///             return not sym.name.startswith('_')
///         if isinstance(sym, Terminal):
///             return self.keep_all_tokens or not sym.filter_out
///         if sym is _EMPTY:
///             return False
///         assert False, sym
///
///     def _args_as_int(self, args):
///         for a in args:
///             if isinstance(a, int):
///                 yield a
///             elif isinstance(a, Symbol):
///                 yield 1 if self._will_not_get_removed(a) else 0
///             else:
///                 assert False
///
///     def expansion(self, args):
///         return sum(self._args_as_int(args))
///
///     def expansions(self, args):
///         return max(self._args_as_int(args))
/// ```
final class FindRuleSize extends PythonClass {
  factory FindRuleSize({
    required Object? keep_all_tokens,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "FindRuleSize",
        FindRuleSize.from,
        <Object?>[
          keep_all_tokens,
        ],
        <String, Object?>{},
      );

  FindRuleSize.from(super.pythonClass) : super.from();

  /// ## expansion
  ///
  /// ### python source
  /// ```py
  /// def expansion(self, args):
  ///         return sum(self._args_as_int(args))
  /// ```
  Object? expansion({
    required Object? args,
  }) =>
      getFunction("expansion").call(
        <Object?>[
          args,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expansions
  ///
  /// ### python source
  /// ```py
  /// def expansions(self, args):
  ///         return max(self._args_as_int(args))
  /// ```
  Object? expansions({
    required Object? args,
  }) =>
      getFunction("expansions").call(
        <Object?>[
          args,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         "Transform the given tree, and return the final result"
  ///         return self._transform_tree(tree)
  /// ```
  Object? transform({
    required Object? tree,
  }) =>
      getFunction("transform").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## keep_all_tokens (getter)
  Object? get keep_all_tokens => getAttribute("keep_all_tokens");

  /// ## keep_all_tokens (setter)
  set keep_all_tokens(Object? keep_all_tokens) =>
      setAttribute("keep_all_tokens", keep_all_tokens);
}

/// ## GrammarBuilder
///
/// ### python source
/// ```py
/// class GrammarBuilder:
///
///     global_keep_all_tokens: bool
///     import_paths: List[Union[str, Callable]]
///     used_files: Dict[str, str]
///
///     _definitions: Dict[str, Definition]
///     _ignore_names: List[str]
///
///     def __init__(self, global_keep_all_tokens: bool=False, import_paths: Optional[List[Union[str, Callable]]]=None, used_files: Optional[Dict[str, str]]=None) -> None:
///         self.global_keep_all_tokens = global_keep_all_tokens
///         self.import_paths = import_paths or []
///         self.used_files = used_files or {}
///
///         self._definitions: Dict[str, Definition] = {}
///         self._ignore_names: List[str] = []
///
///     def _grammar_error(self, is_term, msg, *names):
///         args = {}
///         for i, name in enumerate(names, start=1):
///             postfix = '' if i == 1 else str(i)
///             args['name' + postfix] = name
///             args['type' + postfix] = lowercase_type = ("rule", "terminal")[is_term]
///             args['Type' + postfix] = lowercase_type.title()
///         raise GrammarError(msg.format(**args))
///
///     def _check_options(self, is_term, options):
///         if is_term:
///             if options is None:
///                 options = 1
///             elif not isinstance(options, int):
///                 raise GrammarError("Terminal require a single int as 'options' (e.g. priority), got %s" % (type(options),))
///         else:
///             if options is None:
///                 options = RuleOptions()
///             elif not isinstance(options, RuleOptions):
///                 raise GrammarError("Rules require a RuleOptions instance as 'options'")
///             if self.global_keep_all_tokens:
///                 options.keep_all_tokens = True
///         return options
///
///
///     def _define(self, name, is_term, exp, params=(), options=None, *, override=False):
///         if name in self._definitions:
///             if not override:
///                 self._grammar_error(is_term, "{Type} '{name}' defined more than once", name)
///         elif override:
///             self._grammar_error(is_term, "Cannot override a nonexisting {type} {name}", name)
///
///         if name.startswith('__'):
///             self._grammar_error(is_term, 'Names starting with double-underscore are reserved (Error at {name})', name)
///
///         self._definitions[name] = Definition(is_term, exp, params, self._check_options(is_term, options))
///
///     def _extend(self, name, is_term, exp, params=(), options=None):
///         if name not in self._definitions:
///             self._grammar_error(is_term, "Can't extend {type} {name} as it wasn't defined before", name)
///
///         d = self._definitions[name]
///
///         if is_term != d.is_term:
///             self._grammar_error(is_term, "Cannot extend {type} {name} - one is a terminal, while the other is not.", name)
///         if tuple(params) != d.params:
///             self._grammar_error(is_term, "Cannot extend {type} with different parameters: {name}", name)
///
///         if d.tree is None:
///             self._grammar_error(is_term, "Can't extend {type} {name} - it is abstract.", name)
///
///         # TODO: think about what to do with 'options'
///         base = d.tree
///
///         assert isinstance(base, Tree) and base.data == 'expansions'
///         base.children.insert(0, exp)
///
///     def _ignore(self, exp_or_name):
///         if isinstance(exp_or_name, str):
///             self._ignore_names.append(exp_or_name)
///         else:
///             assert isinstance(exp_or_name, Tree)
///             t = exp_or_name
///             if t.data == 'expansions' and len(t.children) == 1:
///                 t2 ,= t.children
///                 if t2.data=='expansion' and len(t2.children) == 1:
///                     item ,= t2.children
///                     if item.data == 'value':
///                         item ,= item.children
///                         if isinstance(item, Terminal):
///                             # Keep terminal name, no need to create a new definition
///                             self._ignore_names.append(item.name)
///                             return
///
///             name = '__IGNORE_%d'% len(self._ignore_names)
///             self._ignore_names.append(name)
///             self._definitions[name] = Definition(True, t, options=TOKEN_DEFAULT_PRIORITY)
///
///     def _unpack_import(self, stmt, grammar_name):
///         if len(stmt.children) > 1:
///             path_node, arg1 = stmt.children
///         else:
///             path_node, = stmt.children
///             arg1 = None
///
///         if isinstance(arg1, Tree):  # Multi import
///             dotted_path = tuple(path_node.children)
///             names = arg1.children
///             aliases = dict(zip(names, names))  # Can't have aliased multi import, so all aliases will be the same as names
///         else:  # Single import
///             dotted_path = tuple(path_node.children[:-1])
///             if not dotted_path:
///                 name ,= path_node.children
///                 raise GrammarError("Nothing was imported from grammar `%s`" % name)
///             name = path_node.children[-1]  # Get name from dotted path
///             aliases = {name.value: (arg1 or name).value}  # Aliases if exist
///
///         if path_node.data == 'import_lib':  # Import from library
///             base_path = None
///         else:  # Relative import
///             if grammar_name == '<string>':  # Import relative to script file path if grammar is coded in script
///                 try:
///                     base_file = os.path.abspath(sys.modules['__main__'].__file__)
///                 except AttributeError:
///                     base_file = None
///             else:
///                 base_file = grammar_name  # Import relative to grammar file path if external grammar file
///             if base_file:
///                 if isinstance(base_file, PackageResource):
///                     base_path = PackageResource(base_file.pkg_name, os.path.split(base_file.path)[0])
///                 else:
///                     base_path = os.path.split(base_file)[0]
///             else:
///                 base_path = os.path.abspath(os.path.curdir)
///
///         return dotted_path, base_path, aliases
///
///     def _unpack_definition(self, tree, mangle):
///
///         if tree.data == 'rule':
///             name, params, exp, opts = _make_rule_tuple(*tree.children)
///             is_term = False
///         else:
///             name = tree.children[0].value
///             params = ()     # TODO terminal templates
///             opts = int(tree.children[1]) if len(tree.children) == 3 else TOKEN_DEFAULT_PRIORITY # priority
///             exp = tree.children[-1]
///             is_term = True
///
///         if mangle is not None:
///             params = tuple(mangle(p) for p in params)
///             name = mangle(name)
///
///         exp = _mangle_definition_tree(exp, mangle)
///         return name, is_term, exp, params, opts
///
///
///     def load_grammar(self, grammar_text: str, grammar_name: str="<?>", mangle: Optional[Callable[[str], str]]=None) -> None:
///         tree = _parse_grammar(grammar_text, grammar_name)
///
///         imports: Dict[Tuple[str, ...], Tuple[Optional[str], Dict[str, str]]] = {}
///
///         for stmt in tree.children:
///             if stmt.data == 'import':
///                 dotted_path, base_path, aliases = self._unpack_import(stmt, grammar_name)
///                 try:
///                     import_base_path, import_aliases = imports[dotted_path]
///                     assert base_path == import_base_path, 'Inconsistent base_path for %s.' % '.'.join(dotted_path)
///                     import_aliases.update(aliases)
///                 except KeyError:
///                     imports[dotted_path] = base_path, aliases
///
///         for dotted_path, (base_path, aliases) in imports.items():
///             self.do_import(dotted_path, base_path, aliases, mangle)
///
///         for stmt in tree.children:
///             if stmt.data in ('term', 'rule'):
///                 self._define(*self._unpack_definition(stmt, mangle))
///             elif stmt.data == 'override':
///                 r ,= stmt.children
///                 self._define(*self._unpack_definition(r, mangle), override=True)
///             elif stmt.data == 'extend':
///                 r ,= stmt.children
///                 self._extend(*self._unpack_definition(r, mangle))
///             elif stmt.data == 'ignore':
///                 # if mangle is not None, we shouldn't apply ignore, since we aren't in a toplevel grammar
///                 if mangle is None:
///                     self._ignore(*stmt.children)
///             elif stmt.data == 'declare':
///                 for symbol in stmt.children:
///                     assert isinstance(symbol, Symbol), symbol
///                     is_term = isinstance(symbol, Terminal)
///                     if mangle is None:
///                         name = symbol.name
///                     else:
///                         name = mangle(symbol.name)
///                     self._define(name, is_term, None)
///             elif stmt.data == 'import':
///                 pass
///             else:
///                 assert False, stmt
///
///
///         term_defs = { name: d.tree
///             for name, d in self._definitions.items()
///             if d.is_term
///         }
///         resolve_term_references(term_defs)
///
///
///     def _remove_unused(self, used):
///         def rule_dependencies(symbol):
///             try:
///                 d = self._definitions[symbol]
///             except KeyError:
///                 return []
///             if d.is_term:
///                 return []
///             return _find_used_symbols(d.tree) - set(d.params)
///
///         _used = set(bfs(used, rule_dependencies))
///         self._definitions = {k: v for k, v in self._definitions.items() if k in _used}
///
///
///     def do_import(self, dotted_path: Tuple[str, ...], base_path: Optional[str], aliases: Dict[str, str], base_mangle: Optional[Callable[[str], str]]=None) -> None:
///         assert dotted_path
///         mangle = _get_mangle('__'.join(dotted_path), aliases, base_mangle)
///         grammar_path = os.path.join(*dotted_path) + EXT
///         to_try = self.import_paths + ([base_path] if base_path is not None else []) + [stdlib_loader]
///         for source in to_try:
///             try:
///                 if callable(source):
///                     joined_path, text = source(base_path, grammar_path)
///                 else:
///                     joined_path = os.path.join(source, grammar_path)
///                     with open(joined_path, encoding='utf8') as f:
///                         text = f.read()
///             except IOError:
///                 continue
///             else:
///                 h = md5_digest(text)
///                 if self.used_files.get(joined_path, h) != h:
///                     raise RuntimeError("Grammar file was changed during importing")
///                 self.used_files[joined_path] = h
///
///                 gb = GrammarBuilder(self.global_keep_all_tokens, self.import_paths, self.used_files)
///                 gb.load_grammar(text, joined_path, mangle)
///                 gb._remove_unused(map(mangle, aliases))
///                 for name in gb._definitions:
///                     if name in self._definitions:
///                         raise GrammarError("Cannot import '%s' from '%s': Symbol already defined." % (name, grammar_path))
///
///                 self._definitions.update(**gb._definitions)
///                 break
///         else:
///             # Search failed. Make Python throw a nice error.
///             open(grammar_path, encoding='utf8')
///             assert False, "Couldn't import grammar %s, but a corresponding file was found at a place where lark doesn't search for it" % (dotted_path,)
///
///
///     def validate(self) -> None:
///         for name, d in self._definitions.items():
///             params = d.params
///             exp = d.tree
///
///             for i, p in enumerate(params):
///                 if p in self._definitions:
///                     raise GrammarError("Template Parameter conflicts with rule %s (in template %s)" % (p, name))
///                 if p in params[:i]:
///                     raise GrammarError("Duplicate Template Parameter %s (in template %s)" % (p, name))
///
///             if exp is None: # Remaining checks don't apply to abstract rules/terminals (created with %declare)
///                 continue
///
///             for temp in exp.find_data('template_usage'):
///                 sym = temp.children[0].name
///                 args = temp.children[1:]
///                 if sym not in params:
///                     if sym not in self._definitions:
///                         self._grammar_error(d.is_term, "Template '%s' used but not defined (in {type} {name})" % sym, name)
///                     if len(args) != len(self._definitions[sym].params):
///                         expected, actual = len(self._definitions[sym].params), len(args)
///                         self._grammar_error(d.is_term, "Wrong number of template arguments used for {name} "
///                                             "(expected %s, got %s) (in {type2} {name2})" % (expected, actual), sym, name)
///
///             for sym in _find_used_symbols(exp):
///                 if sym not in self._definitions and sym not in params:
///                     self._grammar_error(d.is_term, "{Type} '{name}' used but not defined (in {type2} {name2})", sym, name)
///
///         if not set(self._definitions).issuperset(self._ignore_names):
///             raise GrammarError("Terminals %s were marked to ignore but were not defined!" % (set(self._ignore_names) - set(self._definitions)))
///
///     def build(self) -> Grammar:
///         self.validate()
///         rule_defs = []
///         term_defs = []
///         for name, d in self._definitions.items():
///             (params, exp, options) = d.params, d.tree, d.options
///             if d.is_term:
///                 assert len(params) == 0
///                 term_defs.append((name, (exp, options)))
///             else:
///                 rule_defs.append((name, params, exp, options))
///         # resolve_term_references(term_defs)
///         return Grammar(rule_defs, term_defs, self._ignore_names)
/// ```
final class GrammarBuilder extends PythonClass {
  factory GrammarBuilder({
    Object? global_keep_all_tokens = false,
    Object? import_paths,
    Object? used_files,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "GrammarBuilder",
        GrammarBuilder.from,
        <Object?>[
          global_keep_all_tokens,
          import_paths,
          used_files,
        ],
        <String, Object?>{},
      );

  GrammarBuilder.from(super.pythonClass) : super.from();

  /// ## build
  ///
  /// ### python source
  /// ```py
  /// def build(self) -> Grammar:
  ///         self.validate()
  ///         rule_defs = []
  ///         term_defs = []
  ///         for name, d in self._definitions.items():
  ///             (params, exp, options) = d.params, d.tree, d.options
  ///             if d.is_term:
  ///                 assert len(params) == 0
  ///                 term_defs.append((name, (exp, options)))
  ///             else:
  ///                 rule_defs.append((name, params, exp, options))
  ///         # resolve_term_references(term_defs)
  ///         return Grammar(rule_defs, term_defs, self._ignore_names)
  /// ```
  Object? build() => getFunction("build").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## do_import
  ///
  /// ### python source
  /// ```py
  /// def do_import(self, dotted_path: Tuple[str, ...], base_path: Optional[str], aliases: Dict[str, str], base_mangle: Optional[Callable[[str], str]]=None) -> None:
  ///         assert dotted_path
  ///         mangle = _get_mangle('__'.join(dotted_path), aliases, base_mangle)
  ///         grammar_path = os.path.join(*dotted_path) + EXT
  ///         to_try = self.import_paths + ([base_path] if base_path is not None else []) + [stdlib_loader]
  ///         for source in to_try:
  ///             try:
  ///                 if callable(source):
  ///                     joined_path, text = source(base_path, grammar_path)
  ///                 else:
  ///                     joined_path = os.path.join(source, grammar_path)
  ///                     with open(joined_path, encoding='utf8') as f:
  ///                         text = f.read()
  ///             except IOError:
  ///                 continue
  ///             else:
  ///                 h = md5_digest(text)
  ///                 if self.used_files.get(joined_path, h) != h:
  ///                     raise RuntimeError("Grammar file was changed during importing")
  ///                 self.used_files[joined_path] = h
  ///
  ///                 gb = GrammarBuilder(self.global_keep_all_tokens, self.import_paths, self.used_files)
  ///                 gb.load_grammar(text, joined_path, mangle)
  ///                 gb._remove_unused(map(mangle, aliases))
  ///                 for name in gb._definitions:
  ///                     if name in self._definitions:
  ///                         raise GrammarError("Cannot import '%s' from '%s': Symbol already defined." % (name, grammar_path))
  ///
  ///                 self._definitions.update(**gb._definitions)
  ///                 break
  ///         else:
  ///             # Search failed. Make Python throw a nice error.
  ///             open(grammar_path, encoding='utf8')
  ///             assert False, "Couldn't import grammar %s, but a corresponding file was found at a place where lark doesn't search for it" % (dotted_path,)
  /// ```
  Object? do_import({
    required Object? dotted_path,
    required Object? base_path,
    required Object? aliases,
    Object? base_mangle,
  }) =>
      getFunction("do_import").call(
        <Object?>[
          dotted_path,
          base_path,
          aliases,
          base_mangle,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## load_grammar
  ///
  /// ### python source
  /// ```py
  /// def load_grammar(self, grammar_text: str, grammar_name: str="<?>", mangle: Optional[Callable[[str], str]]=None) -> None:
  ///         tree = _parse_grammar(grammar_text, grammar_name)
  ///
  ///         imports: Dict[Tuple[str, ...], Tuple[Optional[str], Dict[str, str]]] = {}
  ///
  ///         for stmt in tree.children:
  ///             if stmt.data == 'import':
  ///                 dotted_path, base_path, aliases = self._unpack_import(stmt, grammar_name)
  ///                 try:
  ///                     import_base_path, import_aliases = imports[dotted_path]
  ///                     assert base_path == import_base_path, 'Inconsistent base_path for %s.' % '.'.join(dotted_path)
  ///                     import_aliases.update(aliases)
  ///                 except KeyError:
  ///                     imports[dotted_path] = base_path, aliases
  ///
  ///         for dotted_path, (base_path, aliases) in imports.items():
  ///             self.do_import(dotted_path, base_path, aliases, mangle)
  ///
  ///         for stmt in tree.children:
  ///             if stmt.data in ('term', 'rule'):
  ///                 self._define(*self._unpack_definition(stmt, mangle))
  ///             elif stmt.data == 'override':
  ///                 r ,= stmt.children
  ///                 self._define(*self._unpack_definition(r, mangle), override=True)
  ///             elif stmt.data == 'extend':
  ///                 r ,= stmt.children
  ///                 self._extend(*self._unpack_definition(r, mangle))
  ///             elif stmt.data == 'ignore':
  ///                 # if mangle is not None, we shouldn't apply ignore, since we aren't in a toplevel grammar
  ///                 if mangle is None:
  ///                     self._ignore(*stmt.children)
  ///             elif stmt.data == 'declare':
  ///                 for symbol in stmt.children:
  ///                     assert isinstance(symbol, Symbol), symbol
  ///                     is_term = isinstance(symbol, Terminal)
  ///                     if mangle is None:
  ///                         name = symbol.name
  ///                     else:
  ///                         name = mangle(symbol.name)
  ///                     self._define(name, is_term, None)
  ///             elif stmt.data == 'import':
  ///                 pass
  ///             else:
  ///                 assert False, stmt
  ///
  ///
  ///         term_defs = { name: d.tree
  ///             for name, d in self._definitions.items()
  ///             if d.is_term
  ///         }
  ///         resolve_term_references(term_defs)
  /// ```
  Object? load_grammar({
    required Object? grammar_text,
    Object? grammar_name = "<?>",
    Object? mangle,
  }) =>
      getFunction("load_grammar").call(
        <Object?>[
          grammar_text,
          grammar_name,
          mangle,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## validate
  ///
  /// ### python source
  /// ```py
  /// def validate(self) -> None:
  ///         for name, d in self._definitions.items():
  ///             params = d.params
  ///             exp = d.tree
  ///
  ///             for i, p in enumerate(params):
  ///                 if p in self._definitions:
  ///                     raise GrammarError("Template Parameter conflicts with rule %s (in template %s)" % (p, name))
  ///                 if p in params[:i]:
  ///                     raise GrammarError("Duplicate Template Parameter %s (in template %s)" % (p, name))
  ///
  ///             if exp is None: # Remaining checks don't apply to abstract rules/terminals (created with %declare)
  ///                 continue
  ///
  ///             for temp in exp.find_data('template_usage'):
  ///                 sym = temp.children[0].name
  ///                 args = temp.children[1:]
  ///                 if sym not in params:
  ///                     if sym not in self._definitions:
  ///                         self._grammar_error(d.is_term, "Template '%s' used but not defined (in {type} {name})" % sym, name)
  ///                     if len(args) != len(self._definitions[sym].params):
  ///                         expected, actual = len(self._definitions[sym].params), len(args)
  ///                         self._grammar_error(d.is_term, "Wrong number of template arguments used for {name} "
  ///                                             "(expected %s, got %s) (in {type2} {name2})" % (expected, actual), sym, name)
  ///
  ///             for sym in _find_used_symbols(exp):
  ///                 if sym not in self._definitions and sym not in params:
  ///                     self._grammar_error(d.is_term, "{Type} '{name}' used but not defined (in {type2} {name2})", sym, name)
  ///
  ///         if not set(self._definitions).issuperset(self._ignore_names):
  ///             raise GrammarError("Terminals %s were marked to ignore but were not defined!" % (set(self._ignore_names) - set(self._definitions)))
  /// ```
  Object? validate() => getFunction("validate").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## global_keep_all_tokens (getter)
  Object? get global_keep_all_tokens => getAttribute("global_keep_all_tokens");

  /// ## global_keep_all_tokens (setter)
  set global_keep_all_tokens(Object? global_keep_all_tokens) =>
      setAttribute("global_keep_all_tokens", global_keep_all_tokens);

  /// ## import_paths (getter)
  Object? get import_paths => getAttribute("import_paths");

  /// ## import_paths (setter)
  set import_paths(Object? import_paths) =>
      setAttribute("import_paths", import_paths);

  /// ## used_files (getter)
  Object? get used_files => getAttribute("used_files");

  /// ## used_files (setter)
  set used_files(Object? used_files) => setAttribute("used_files", used_files);
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
///     def __init__(self, lexer_conf, parser_conf, options, parser=None):
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
///         try:
///             create_lexer = {
///                 'basic': create_basic_lexer,
///                 'contextual': create_contextual_lexer,
///             }[lexer_type]
///         except KeyError:
///             assert issubclass(lexer_type, Lexer), lexer_type
///             self.lexer = _wrap_lexer(lexer_type)(lexer_conf)
///         else:
///             self.lexer = create_lexer(lexer_conf, self.parser, lexer_conf.postlex, options)
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
///     def _make_lexer_thread(self, text):
///         cls = (self.options and self.options._plugins.get('LexerThread')) or LexerThread
///         return text if self.skip_lexer else cls.from_text(self.lexer, text)
///
///     def parse(self, text, start=None, on_error=None):
///         chosen_start = self._verify_start(start)
///         kw = {} if on_error is None else {'on_error': on_error}
///         stream = self._make_lexer_thread(text)
///         return self.parser.parse(stream, chosen_start, **kw)
///
///     def parse_interactive(self, text=None, start=None):
///         chosen_start = self._verify_start(start)
///         if self.parser_conf.parser_type != 'lalr':
///             raise ConfigurationError("parse_interactive() currently only works with parser='lalr' ")
///         stream = self._make_lexer_thread(text)
///         return self.parser.parse_interactive(stream, chosen_start)
/// ```
final class ParsingFrontend extends PythonClass {
  factory ParsingFrontend({
    required Object? lexer_conf,
    required Object? parser_conf,
    required Object? options,
    Object? parser,
  }) =>
      PythonFfiDart.instance.importClass(
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
  /// def parse(self, text, start=None, on_error=None):
  ///         chosen_start = self._verify_start(start)
  ///         kw = {} if on_error is None else {'on_error': on_error}
  ///         stream = self._make_lexer_thread(text)
  ///         return self.parser.parse(stream, chosen_start, **kw)
  /// ```
  Object? parse({
    required Object? text,
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
  /// def parse_interactive(self, text=None, start=None):
  ///         chosen_start = self._verify_start(start)
  ///         if self.parser_conf.parser_type != 'lalr':
  ///             raise ConfigurationError("parse_interactive() currently only works with parser='lalr' ")
  ///         stream = self._make_lexer_thread(text)
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
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## parser_conf (getter)
  Object? get parser_conf => getAttribute("parser_conf");

  /// ## parser_conf (setter)
  set parser_conf(Object? parser_conf) =>
      setAttribute("parser_conf", parser_conf);

  /// ## lexer_conf (getter)
  Object? get lexer_conf => getAttribute("lexer_conf");

  /// ## lexer_conf (setter)
  set lexer_conf(Object? lexer_conf) => setAttribute("lexer_conf", lexer_conf);

  /// ## options (getter)
  Object? get options => getAttribute("options");

  /// ## options (setter)
  set options(Object? options) => setAttribute("options", options);

  /// ## parser (getter)
  Object? get parser => getAttribute("parser");

  /// ## parser (setter)
  set parser(Object? parser) => setAttribute("parser", parser);

  /// ## skip_lexer (getter)
  Object? get skip_lexer => getAttribute("skip_lexer");

  /// ## skip_lexer (setter)
  set skip_lexer(Object? skip_lexer) => setAttribute("skip_lexer", skip_lexer);

  /// ## lexer (getter)
  Object? get lexer => getAttribute("lexer");

  /// ## lexer (setter)
  set lexer(Object? lexer) => setAttribute("lexer", lexer);
}

/// ## PrepareAnonTerminals
///
/// ### python docstring
///
/// Create a unique list of anonymous terminals. Attempt to give meaningful names to them when we add them
///
/// ### python source
/// ```py
/// class PrepareAnonTerminals(Transformer_InPlace):
///     """Create a unique list of anonymous terminals. Attempt to give meaningful names to them when we add them"""
///
///     def __init__(self, terminals):
///         self.terminals = terminals
///         self.term_set = {td.name for td in self.terminals}
///         self.term_reverse = {td.pattern: td for td in terminals}
///         self.i = 0
///         self.rule_options = None
///
///     @inline_args
///     def pattern(self, p):
///         value = p.value
///         if p in self.term_reverse and p.flags != self.term_reverse[p].pattern.flags:
///             raise GrammarError(u'Conflicting flags for the same terminal: %s' % p)
///
///         term_name = None
///
///         if isinstance(p, PatternStr):
///             try:
///                 # If already defined, use the user-defined terminal name
///                 term_name = self.term_reverse[p].name
///             except KeyError:
///                 # Try to assign an indicative anon-terminal name
///                 try:
///                     term_name = _TERMINAL_NAMES[value]
///                 except KeyError:
///                     if value and is_id_continue(value) and is_id_start(value[0]) and value.upper() not in self.term_set:
///                         term_name = value.upper()
///
///                 if term_name in self.term_set:
///                     term_name = None
///
///         elif isinstance(p, PatternRE):
///             if p in self.term_reverse:  # Kind of a weird placement.name
///                 term_name = self.term_reverse[p].name
///         else:
///             assert False, p
///
///         if term_name is None:
///             term_name = '__ANON_%d' % self.i
///             self.i += 1
///
///         if term_name not in self.term_set:
///             assert p not in self.term_reverse
///             self.term_set.add(term_name)
///             termdef = TerminalDef(term_name, p)
///             self.term_reverse[p] = termdef
///             self.terminals.append(termdef)
///
///         filter_out = False if self.rule_options and self.rule_options.keep_all_tokens else isinstance(p, PatternStr)
///
///         return Terminal(term_name, filter_out=filter_out)
/// ```
final class PrepareAnonTerminals extends PythonClass {
  factory PrepareAnonTerminals({
    required Object? terminals,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "PrepareAnonTerminals",
        PrepareAnonTerminals.from,
        <Object?>[
          terminals,
        ],
        <String, Object?>{},
      );

  PrepareAnonTerminals.from(super.pythonClass) : super.from();

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         for subtree in tree.iter_subtrees():
  ///             subtree.children = list(self._transform_children(subtree.children))
  ///
  ///         return self._transform_tree(tree)
  /// ```
  Object? transform({
    required Object? tree,
  }) =>
      getFunction("transform").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## pattern (getter)
  Object? get pattern => getAttribute("pattern");

  /// ## pattern (setter)
  set pattern(Object? pattern) => setAttribute("pattern", pattern);

  /// ## terminals (getter)
  Object? get terminals => getAttribute("terminals");

  /// ## terminals (setter)
  set terminals(Object? terminals) => setAttribute("terminals", terminals);

  /// ## term_set (getter)
  Object? get term_set => getAttribute("term_set");

  /// ## term_set (setter)
  set term_set(Object? term_set) => setAttribute("term_set", term_set);

  /// ## term_reverse (getter)
  Object? get term_reverse => getAttribute("term_reverse");

  /// ## term_reverse (setter)
  set term_reverse(Object? term_reverse) =>
      setAttribute("term_reverse", term_reverse);

  /// ## i (getter)
  Object? get i => getAttribute("i");

  /// ## i (setter)
  set i(Object? i) => setAttribute("i", i);

  /// ## rule_options (getter)
  Object? get rule_options => getAttribute("rule_options");

  /// ## rule_options (setter)
  set rule_options(Object? rule_options) =>
      setAttribute("rule_options", rule_options);
}

/// ## PrepareGrammar
///
/// ### python docstring
///
/// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
///
/// Useful for huge trees. Conservative in memory.
///
/// ### python source
/// ```py
/// @inline_args
/// class PrepareGrammar(Transformer_InPlace):
///     def terminal(self, name):
///         return Terminal(str(name), filter_out=name.startswith('_'))
///
///     def nonterminal(self, name):
///         return NonTerminal(name.value)
/// ```
final class PrepareGrammar extends PythonClass {
  factory PrepareGrammar({
    Object? visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "PrepareGrammar",
        PrepareGrammar.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  PrepareGrammar.from(super.pythonClass) : super.from();

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         for subtree in tree.iter_subtrees():
  ///             subtree.children = list(self._transform_children(subtree.children))
  ///
  ///         return self._transform_tree(tree)
  /// ```
  Object? transform({
    required Object? tree,
  }) =>
      getFunction("transform").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## nonterminal (getter)
  Object? get nonterminal => getAttribute("nonterminal");

  /// ## nonterminal (setter)
  set nonterminal(Object? nonterminal) =>
      setAttribute("nonterminal", nonterminal);

  /// ## terminal (getter)
  Object? get terminal => getAttribute("terminal");

  /// ## terminal (setter)
  set terminal(Object? terminal) => setAttribute("terminal", terminal);
}

/// ## PrepareLiterals
///
/// ### python docstring
///
/// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
///
/// Useful for huge trees. Conservative in memory.
///
/// ### python source
/// ```py
/// @inline_args
/// class PrepareLiterals(Transformer_InPlace):
///     def literal(self, literal):
///         return ST('pattern', [_literal_to_pattern(literal)])
///
///     def range(self, start, end):
///         assert start.type == end.type == 'STRING'
///         start = start.value[1:-1]
///         end = end.value[1:-1]
///         assert len(eval_escaping(start)) == len(eval_escaping(end)) == 1
///         regexp = '[%s-%s]' % (start, end)
///         return ST('pattern', [PatternRE(regexp)])
/// ```
final class PrepareLiterals extends PythonClass {
  factory PrepareLiterals({
    Object? visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "PrepareLiterals",
        PrepareLiterals.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  PrepareLiterals.from(super.pythonClass) : super.from();

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         for subtree in tree.iter_subtrees():
  ///             subtree.children = list(self._transform_children(subtree.children))
  ///
  ///         return self._transform_tree(tree)
  /// ```
  Object? transform({
    required Object? tree,
  }) =>
      getFunction("transform").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## literal (getter)
  Object? get literal => getAttribute("literal");

  /// ## literal (setter)
  set literal(Object? literal) => setAttribute("literal", literal);

  /// ## range (getter)
  Object? get range => getAttribute("range");

  /// ## range (setter)
  set range(Object? range) => setAttribute("range", range);
}

/// ## RuleTreeToText
///
/// ### python docstring
///
/// Transformers work bottom-up (or depth-first), starting with visiting the leaves and working
/// their way up until ending at the root of the tree.
///
/// For each node visited, the transformer will call the appropriate method (callbacks), according to the
/// node's ``data``, and use the returned value to replace the node, thereby creating a new tree structure.
///
/// Transformers can be used to implement map & reduce patterns. Because nodes are reduced from leaf to root,
/// at any point the callbacks may assume the children have already been transformed (if applicable).
///
/// If the transformer cannot find a method with the right name, it will instead call ``__default__``, which by
/// default creates a copy of the node.
///
/// To discard a node, return Discard (``lark.visitors.Discard``).
///
/// ``Transformer`` can do anything ``Visitor`` can do, but because it reconstructs the tree,
/// it is slightly less efficient.
///
/// A transformer without methods essentially performs a non-memoized partial deepcopy.
///
/// All these classes implement the transformer interface:
///
/// - ``Transformer`` - Recursively transforms the tree. This is the one you probably want.
/// - ``Transformer_InPlace`` - Non-recursive. Changes the tree in-place instead of returning new instances
/// - ``Transformer_InPlaceRecursive`` - Recursive. Changes the tree in-place instead of returning new instances
///
/// Parameters:
///     visit_tokens (bool, optional): Should the transformer visit tokens in addition to rules.
///                                    Setting this to ``False`` is slightly faster. Defaults to ``True``.
///                                    (For processing ignored tokens, use the ``lexer_callbacks`` options)
///
/// ### python source
/// ```py
/// class RuleTreeToText(Transformer):
///     def expansions(self, x):
///         return x
///
///     def expansion(self, symbols):
///         return symbols, None
///
///     def alias(self, x):
///         (expansion, _alias), alias = x
///         assert _alias is None, (alias, expansion, '-', _alias)  # Double alias not allowed
///         return expansion, alias.name
/// ```
final class RuleTreeToText extends PythonClass {
  factory RuleTreeToText({
    Object? visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "RuleTreeToText",
        RuleTreeToText.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  RuleTreeToText.from(super.pythonClass) : super.from();

  /// ## alias
  ///
  /// ### python source
  /// ```py
  /// def alias(self, x):
  ///         (expansion, _alias), alias = x
  ///         assert _alias is None, (alias, expansion, '-', _alias)  # Double alias not allowed
  ///         return expansion, alias.name
  /// ```
  Object? alias({
    required Object? x,
  }) =>
      getFunction("alias").call(
        <Object?>[
          x,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expansion
  ///
  /// ### python source
  /// ```py
  /// def expansion(self, symbols):
  ///         return symbols, None
  /// ```
  Object? expansion({
    required Object? symbols,
  }) =>
      getFunction("expansion").call(
        <Object?>[
          symbols,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expansions
  ///
  /// ### python source
  /// ```py
  /// def expansions(self, x):
  ///         return x
  /// ```
  Object? expansions({
    required Object? x,
  }) =>
      getFunction("expansions").call(
        <Object?>[
          x,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         "Transform the given tree, and return the final result"
  ///         return self._transform_tree(tree)
  /// ```
  Object? transform({
    required Object? tree,
  }) =>
      getFunction("transform").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## ST
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
///         meta attributes: line, column, start_pos, end_line, end_column, end_pos
///
/// ### python source
/// ```py
/// class SlottedTree(Tree):
///     __slots__ = 'data', 'children', 'rule', '_meta'
/// ```
final class ST extends PythonClass {
  factory ST({
    required Object? data,
    required Object? children,
    Object? meta,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.tree",
        "ST",
        ST.from,
        <Object?>[
          data,
          children,
          meta,
        ],
        <String, Object?>{},
      );

  ST.from(super.pythonClass) : super.from();

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
    required Object? data,
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
  Object? pretty({
    Object? indent_str = "  ",
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
  Object? scan_values({
    required Object? pred,
  }) =>
      getFunction("scan_values").call(
        <Object?>[
          pred,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set
  ///
  /// ### python source
  /// ```py
  /// def set(self, data: str, children: 'List[Branch[_Leaf_T]]') -> None:
  ///         self.data = data
  ///         self.children = children
  /// ```
  Object? $set({
    required Object? data,
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
  Object? get meta => getAttribute("meta");

  /// ## meta (setter)
  set meta(Object? meta) => setAttribute("meta", meta);

  /// ## rule (getter)
  Object? get rule => getAttribute("rule");

  /// ## rule (setter)
  set rule(Object? rule) => setAttribute("rule", rule);

  /// ## children (getter)
  Object? get children => getAttribute("children");

  /// ## children (setter)
  set children(Object? children) => setAttribute("children", children);

  /// ## data (getter)
  Object? get data => getAttribute("data");

  /// ## data (setter)
  set data(Object? data) => setAttribute("data", data);
}

/// ## SimplifyRule_Visitor
///
/// ### python docstring
///
/// Tree visitor, non-recursive (can handle huge trees).
///
/// Visiting a node calls its methods (provided by the user via inheritance) according to ``tree.data``
///
/// ### python source
/// ```py
/// class SimplifyRule_Visitor(Visitor):
///
///     @staticmethod
///     def _flatten(tree):
///         while tree.expand_kids_by_data(tree.data):
///             pass
///
///     def expansion(self, tree):
///         # rules_list unpacking
///         # a : b (c|d) e
///         #  -->
///         # a : b c e | b d e
///         #
///         # In AST terms:
///         # expansion(b, expansions(c, d), e)
///         #   -->
///         # expansions( expansion(b, c, e), expansion(b, d, e) )
///
///         self._flatten(tree)
///
///         for i, child in enumerate(tree.children):
///             if isinstance(child, Tree) and child.data == 'expansions':
///                 tree.data = 'expansions'
///                 tree.children = [self.visit(ST('expansion', [option if i == j else other
///                                                              for j, other in enumerate(tree.children)]))
///                                  for option in dedup_list(child.children)]
///                 self._flatten(tree)
///                 break
///
///     def alias(self, tree):
///         rule, alias_name = tree.children
///         if rule.data == 'expansions':
///             aliases = []
///             for child in tree.children[0].children:
///                 aliases.append(ST('alias', [child, alias_name]))
///             tree.data = 'expansions'
///             tree.children = aliases
///
///     def expansions(self, tree):
///         self._flatten(tree)
///         # Ensure all children are unique
///         if len(set(tree.children)) != len(tree.children):
///             tree.children = dedup_list(tree.children)   # dedup is expensive, so try to minimize its use
/// ```
final class SimplifyRule_Visitor extends PythonClass {
  factory SimplifyRule_Visitor() => PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "SimplifyRule_Visitor",
        SimplifyRule_Visitor.from,
        <Object?>[],
      );

  SimplifyRule_Visitor.from(super.pythonClass) : super.from();

  /// ## alias
  ///
  /// ### python source
  /// ```py
  /// def alias(self, tree):
  ///         rule, alias_name = tree.children
  ///         if rule.data == 'expansions':
  ///             aliases = []
  ///             for child in tree.children[0].children:
  ///                 aliases.append(ST('alias', [child, alias_name]))
  ///             tree.data = 'expansions'
  ///             tree.children = aliases
  /// ```
  Object? alias({
    required Object? tree,
  }) =>
      getFunction("alias").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expansion
  ///
  /// ### python source
  /// ```py
  /// def expansion(self, tree):
  ///         # rules_list unpacking
  ///         # a : b (c|d) e
  ///         #  -->
  ///         # a : b c e | b d e
  ///         #
  ///         # In AST terms:
  ///         # expansion(b, expansions(c, d), e)
  ///         #   -->
  ///         # expansions( expansion(b, c, e), expansion(b, d, e) )
  ///
  ///         self._flatten(tree)
  ///
  ///         for i, child in enumerate(tree.children):
  ///             if isinstance(child, Tree) and child.data == 'expansions':
  ///                 tree.data = 'expansions'
  ///                 tree.children = [self.visit(ST('expansion', [option if i == j else other
  ///                                                              for j, other in enumerate(tree.children)]))
  ///                                  for option in dedup_list(child.children)]
  ///                 self._flatten(tree)
  ///                 break
  /// ```
  Object? expansion({
    required Object? tree,
  }) =>
      getFunction("expansion").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expansions
  ///
  /// ### python source
  /// ```py
  /// def expansions(self, tree):
  ///         self._flatten(tree)
  ///         # Ensure all children are unique
  ///         if len(set(tree.children)) != len(tree.children):
  ///             tree.children = dedup_list(tree.children)   # dedup is expensive, so try to minimize its use
  /// ```
  Object? expansions({
    required Object? tree,
  }) =>
      getFunction("expansions").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit
  ///
  /// ### python docstring
  ///
  /// Visits the tree, starting with the leaves and finally the root (bottom-up)
  ///
  /// ### python source
  /// ```py
  /// def visit(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
  ///         "Visits the tree, starting with the leaves and finally the root (bottom-up)"
  ///         for subtree in tree.iter_subtrees():
  ///             self._call_userfunc(subtree)
  ///         return tree
  /// ```
  Object? visit({
    required Object? tree,
  }) =>
      getFunction("visit").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_topdown
  ///
  /// ### python docstring
  ///
  /// Visit the tree, starting at the root, and ending at the leaves (top-down)
  ///
  /// ### python source
  /// ```py
  /// def visit_topdown(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
  ///         "Visit the tree, starting at the root, and ending at the leaves (top-down)"
  ///         for subtree in tree.iter_subtrees_topdown():
  ///             self._call_userfunc(subtree)
  ///         return tree
  /// ```
  Object? visit_topdown({
    required Object? tree,
  }) =>
      getFunction("visit_topdown").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## TerminalTreeToPattern
///
/// ### python docstring
///
/// Same as Transformer but non-recursive.
///
/// Like Transformer, it doesn't change the original tree.
///
/// Useful for huge trees.
///
/// ### python source
/// ```py
/// class TerminalTreeToPattern(Transformer_NonRecursive):
///     def pattern(self, ps):
///         p ,= ps
///         return p
///
///     def expansion(self, items):
///         assert items
///         if len(items) == 1:
///             return items[0]
///
///         pattern = ''.join(i.to_regexp() for i in items)
///         return _make_joined_pattern(pattern, {i.flags for i in items})
///
///     def expansions(self, exps):
///         if len(exps) == 1:
///             return exps[0]
///
///         # Do a bit of sorting to make sure that the longest option is returned
///         # (Python's re module otherwise prefers just 'l' when given (l|ll) and both could match)
///         exps.sort(key=lambda x: (-x.max_width, -x.min_width, -len(x.value)))
///
///         pattern = '(?:%s)' % ('|'.join(i.to_regexp() for i in exps))
///         return _make_joined_pattern(pattern, {i.flags for i in exps})
///
///     def expr(self, args):
///         inner, op = args[:2]
///         if op == '~':
///             if len(args) == 3:
///                 op = "{%d}" % int(args[2])
///             else:
///                 mn, mx = map(int, args[2:])
///                 if mx < mn:
///                     raise GrammarError("Bad Range for %s (%d..%d isn't allowed)" % (inner, mn, mx))
///                 op = "{%d,%d}" % (mn, mx)
///         else:
///             assert len(args) == 2
///         return PatternRE('(?:%s)%s' % (inner.to_regexp(), op), inner.flags)
///
///     def maybe(self, expr):
///         return self.expr(expr + ['?'])
///
///     def alias(self, t):
///         raise GrammarError("Aliasing not allowed in terminals (You used -> in the wrong place)")
///
///     def value(self, v):
///         return v[0]
/// ```
final class TerminalTreeToPattern extends PythonClass {
  factory TerminalTreeToPattern({
    Object? visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "TerminalTreeToPattern",
        TerminalTreeToPattern.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  TerminalTreeToPattern.from(super.pythonClass) : super.from();

  /// ## alias
  ///
  /// ### python source
  /// ```py
  /// def alias(self, t):
  ///         raise GrammarError("Aliasing not allowed in terminals (You used -> in the wrong place)")
  /// ```
  Object? alias({
    required Object? t,
  }) =>
      getFunction("alias").call(
        <Object?>[
          t,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expansion
  ///
  /// ### python source
  /// ```py
  /// def expansion(self, items):
  ///         assert items
  ///         if len(items) == 1:
  ///             return items[0]
  ///
  ///         pattern = ''.join(i.to_regexp() for i in items)
  ///         return _make_joined_pattern(pattern, {i.flags for i in items})
  /// ```
  Object? expansion({
    required Object? items,
  }) =>
      getFunction("expansion").call(
        <Object?>[
          items,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expansions
  ///
  /// ### python source
  /// ```py
  /// def expansions(self, exps):
  ///         if len(exps) == 1:
  ///             return exps[0]
  ///
  ///         # Do a bit of sorting to make sure that the longest option is returned
  ///         # (Python's re module otherwise prefers just 'l' when given (l|ll) and both could match)
  ///         exps.sort(key=lambda x: (-x.max_width, -x.min_width, -len(x.value)))
  ///
  ///         pattern = '(?:%s)' % ('|'.join(i.to_regexp() for i in exps))
  ///         return _make_joined_pattern(pattern, {i.flags for i in exps})
  /// ```
  Object? expansions({
    required Object? exps,
  }) =>
      getFunction("expansions").call(
        <Object?>[
          exps,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expr
  ///
  /// ### python source
  /// ```py
  /// def expr(self, args):
  ///         inner, op = args[:2]
  ///         if op == '~':
  ///             if len(args) == 3:
  ///                 op = "{%d}" % int(args[2])
  ///             else:
  ///                 mn, mx = map(int, args[2:])
  ///                 if mx < mn:
  ///                     raise GrammarError("Bad Range for %s (%d..%d isn't allowed)" % (inner, mn, mx))
  ///                 op = "{%d,%d}" % (mn, mx)
  ///         else:
  ///             assert len(args) == 2
  ///         return PatternRE('(?:%s)%s' % (inner.to_regexp(), op), inner.flags)
  /// ```
  Object? expr({
    required Object? args,
  }) =>
      getFunction("expr").call(
        <Object?>[
          args,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## maybe
  ///
  /// ### python source
  /// ```py
  /// def maybe(self, expr):
  ///         return self.expr(expr + ['?'])
  /// ```
  Object? maybe({
    required Object? expr,
  }) =>
      getFunction("maybe").call(
        <Object?>[
          expr,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## pattern
  ///
  /// ### python source
  /// ```py
  /// def pattern(self, ps):
  ///         p ,= ps
  ///         return p
  /// ```
  Object? pattern({
    required Object? ps,
  }) =>
      getFunction("pattern").call(
        <Object?>[
          ps,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         # Tree to postfix
  ///         rev_postfix = []
  ///         q: List[Branch[_Leaf_T]] = [tree]
  ///         while q:
  ///             t = q.pop()
  ///             rev_postfix.append(t)
  ///             if isinstance(t, Tree):
  ///                 q += t.children
  ///
  ///         # Postfix to tree
  ///         stack: List = []
  ///         for x in reversed(rev_postfix):
  ///             if isinstance(x, Tree):
  ///                 size = len(x.children)
  ///                 if size:
  ///                     args = stack[-size:]
  ///                     del stack[-size:]
  ///                 else:
  ///                     args = []
  ///
  ///                 res = self._call_userfunc(x, args)
  ///                 if res is not Discard:
  ///                     stack.append(res)
  ///
  ///             elif self.__visit_tokens__ and isinstance(x, Token):
  ///                 res = self._call_userfunc_token(x)
  ///                 if res is not Discard:
  ///                     stack.append(res)
  ///             else:
  ///                 stack.append(x)
  ///
  ///         result, = stack  # We should have only one tree remaining
  ///         # There are no guarantees on the type of the value produced by calling a user func for a
  ///         # child will produce. This means type system can't statically know that the final result is
  ///         # _Return_T. As a result a cast is required.
  ///         return cast(_Return_T, result)
  /// ```
  Object? transform({
    required Object? tree,
  }) =>
      getFunction("transform").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## value
  ///
  /// ### python source
  /// ```py
  /// def value(self, v):
  ///         return v[0]
  /// ```
  Object? value({
    required Object? v,
  }) =>
      getFunction("value").call(
        <Object?>[
          v,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## Transformer_InPlace
///
/// ### python docstring
///
/// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
///
/// Useful for huge trees. Conservative in memory.
///
/// ### python source
/// ```py
/// class Transformer_InPlace(Transformer):
///     """Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
///
///     Useful for huge trees. Conservative in memory.
///     """
///     def _transform_tree(self, tree):           # Cancel recursion
///         return self._call_userfunc(tree)
///
///     def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         for subtree in tree.iter_subtrees():
///             subtree.children = list(self._transform_children(subtree.children))
///
///         return self._transform_tree(tree)
/// ```
final class Transformer_InPlace extends PythonClass {
  factory Transformer_InPlace({
    Object? visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.visitors",
        "Transformer_InPlace",
        Transformer_InPlace.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  Transformer_InPlace.from(super.pythonClass) : super.from();

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         for subtree in tree.iter_subtrees():
  ///             subtree.children = list(self._transform_children(subtree.children))
  ///
  ///         return self._transform_tree(tree)
  /// ```
  Object? transform({
    required Object? tree,
  }) =>
      getFunction("transform").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## ValidateSymbols
///
/// ### python docstring
///
/// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
///
/// Useful for huge trees. Conservative in memory.
///
/// ### python source
/// ```py
/// class ValidateSymbols(Transformer_InPlace):
///     def value(self, v):
///         v ,= v
///         assert isinstance(v, (Tree, Symbol))
///         return v
/// ```
final class ValidateSymbols extends PythonClass {
  factory ValidateSymbols({
    Object? visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "ValidateSymbols",
        ValidateSymbols.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  ValidateSymbols.from(super.pythonClass) : super.from();

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         for subtree in tree.iter_subtrees():
  ///             subtree.children = list(self._transform_children(subtree.children))
  ///
  ///         return self._transform_tree(tree)
  /// ```
  Object? transform({
    required Object? tree,
  }) =>
      getFunction("transform").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## value
  ///
  /// ### python source
  /// ```py
  /// def value(self, v):
  ///         v ,= v
  ///         assert isinstance(v, (Tree, Symbol))
  ///         return v
  /// ```
  Object? value({
    required Object? v,
  }) =>
      getFunction("value").call(
        <Object?>[
          v,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## AmbiguousExpander
///
/// ### python docstring
///
/// Deal with the case where we're expanding children ('_rule') into a parent but the children
/// are ambiguous. i.e. (parent->_ambig->_expand_this_rule). In this case, make the parent itself
/// ambiguous with as many copies as there are ambiguous children, and then copy the ambiguous children
/// into the right parents in the right places, essentially shifting the ambiguity up the tree.
///
/// ### python source
/// ```py
/// class AmbiguousExpander:
///     """Deal with the case where we're expanding children ('_rule') into a parent but the children
///        are ambiguous. i.e. (parent->_ambig->_expand_this_rule). In this case, make the parent itself
///        ambiguous with as many copies as there are ambiguous children, and then copy the ambiguous children
///        into the right parents in the right places, essentially shifting the ambiguity up the tree."""
///     def __init__(self, to_expand, tree_class, node_builder):
///         self.node_builder = node_builder
///         self.tree_class = tree_class
///         self.to_expand = to_expand
///
///     def __call__(self, children):
///         def _is_ambig_tree(t):
///             return hasattr(t, 'data') and t.data == '_ambig'
///
///         # -- When we're repeatedly expanding ambiguities we can end up with nested ambiguities.
///         #    All children of an _ambig node should be a derivation of that ambig node, hence
///         #    it is safe to assume that if we see an _ambig node nested within an ambig node
///         #    it is safe to simply expand it into the parent _ambig node as an alternative derivation.
///         ambiguous = []
///         for i, child in enumerate(children):
///             if _is_ambig_tree(child):
///                 if i in self.to_expand:
///                     ambiguous.append(i)
///
///                 child.expand_kids_by_data('_ambig')
///
///         if not ambiguous:
///             return self.node_builder(children)
///
///         expand = [child.children if i in ambiguous else (child,) for i, child in enumerate(children)]
///         return self.tree_class('_ambig', [self.node_builder(list(f)) for f in product(*expand)])
/// ```
final class AmbiguousExpander extends PythonClass {
  factory AmbiguousExpander({
    required Object? to_expand,
    required Object? tree_class,
    required Object? node_builder,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parse_tree_builder",
        "AmbiguousExpander",
        AmbiguousExpander.from,
        <Object?>[
          to_expand,
          tree_class,
          node_builder,
        ],
        <String, Object?>{},
      );

  AmbiguousExpander.from(super.pythonClass) : super.from();

  /// ## node_builder (getter)
  Object? get node_builder => getAttribute("node_builder");

  /// ## node_builder (setter)
  set node_builder(Object? node_builder) =>
      setAttribute("node_builder", node_builder);

  /// ## tree_class (getter)
  Object? get tree_class => getAttribute("tree_class");

  /// ## tree_class (setter)
  set tree_class(Object? tree_class) => setAttribute("tree_class", tree_class);

  /// ## to_expand (getter)
  Object? get to_expand => getAttribute("to_expand");

  /// ## to_expand (setter)
  set to_expand(Object? to_expand) => setAttribute("to_expand", to_expand);
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
  Object? get node_builder => getAttribute("node_builder");

  /// ## node_builder (setter)
  set node_builder(Object? node_builder) =>
      setAttribute("node_builder", node_builder);

  /// ## tree_class (getter)
  Object? get tree_class => getAttribute("tree_class");

  /// ## tree_class (setter)
  set tree_class(Object? tree_class) => setAttribute("tree_class", tree_class);
}

/// ## ChildFilter
///
/// ### python source
/// ```py
/// class ChildFilter:
///     def __init__(self, to_include, append_none, node_builder):
///         self.node_builder = node_builder
///         self.to_include = to_include
///         self.append_none = append_none
///
///     def __call__(self, children):
///         filtered = []
///
///         for i, to_expand, add_none in self.to_include:
///             if add_none:
///                 filtered += [None] * add_none
///             if to_expand:
///                 filtered += children[i].children
///             else:
///                 filtered.append(children[i])
///
///         if self.append_none:
///             filtered += [None] * self.append_none
///
///         return self.node_builder(filtered)
/// ```
final class ChildFilter extends PythonClass {
  factory ChildFilter({
    required Object? to_include,
    required Object? append_none,
    required Object? node_builder,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parse_tree_builder",
        "ChildFilter",
        ChildFilter.from,
        <Object?>[
          to_include,
          append_none,
          node_builder,
        ],
        <String, Object?>{},
      );

  ChildFilter.from(super.pythonClass) : super.from();

  /// ## node_builder (getter)
  Object? get node_builder => getAttribute("node_builder");

  /// ## node_builder (setter)
  set node_builder(Object? node_builder) =>
      setAttribute("node_builder", node_builder);

  /// ## to_include (getter)
  Object? get to_include => getAttribute("to_include");

  /// ## to_include (setter)
  set to_include(Object? to_include) => setAttribute("to_include", to_include);

  /// ## append_none (getter)
  Object? get append_none => getAttribute("append_none");

  /// ## append_none (setter)
  set append_none(Object? append_none) =>
      setAttribute("append_none", append_none);
}

/// ## ChildFilterLALR
///
/// ### python docstring
///
/// Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)
///
/// ### python source
/// ```py
/// class ChildFilterLALR(ChildFilter):
///     """Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)"""
///
///     def __call__(self, children):
///         filtered = []
///         for i, to_expand, add_none in self.to_include:
///             if add_none:
///                 filtered += [None] * add_none
///             if to_expand:
///                 if filtered:
///                     filtered += children[i].children
///                 else:   # Optimize for left-recursion
///                     filtered = children[i].children
///             else:
///                 filtered.append(children[i])
///
///         if self.append_none:
///             filtered += [None] * self.append_none
///
///         return self.node_builder(filtered)
/// ```
final class ChildFilterLALR extends PythonClass {
  factory ChildFilterLALR({
    required Object? to_include,
    required Object? append_none,
    required Object? node_builder,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parse_tree_builder",
        "ChildFilterLALR",
        ChildFilterLALR.from,
        <Object?>[
          to_include,
          append_none,
          node_builder,
        ],
        <String, Object?>{},
      );

  ChildFilterLALR.from(super.pythonClass) : super.from();

  /// ## node_builder (getter)
  Object? get node_builder => getAttribute("node_builder");

  /// ## node_builder (setter)
  set node_builder(Object? node_builder) =>
      setAttribute("node_builder", node_builder);

  /// ## to_include (getter)
  Object? get to_include => getAttribute("to_include");

  /// ## to_include (setter)
  set to_include(Object? to_include) => setAttribute("to_include", to_include);

  /// ## append_none (getter)
  Object? get append_none => getAttribute("append_none");

  /// ## append_none (setter)
  set append_none(Object? append_none) =>
      setAttribute("append_none", append_none);
}

/// ## ChildFilterLALR_NoPlaceholders
///
/// ### python docstring
///
/// Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)
///
/// ### python source
/// ```py
/// class ChildFilterLALR_NoPlaceholders(ChildFilter):
///     "Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)"
///     def __init__(self, to_include, node_builder):
///         self.node_builder = node_builder
///         self.to_include = to_include
///
///     def __call__(self, children):
///         filtered = []
///         for i, to_expand in self.to_include:
///             if to_expand:
///                 if filtered:
///                     filtered += children[i].children
///                 else:   # Optimize for left-recursion
///                     filtered = children[i].children
///             else:
///                 filtered.append(children[i])
///         return self.node_builder(filtered)
/// ```
final class ChildFilterLALR_NoPlaceholders extends PythonClass {
  factory ChildFilterLALR_NoPlaceholders({
    required Object? to_include,
    required Object? node_builder,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parse_tree_builder",
        "ChildFilterLALR_NoPlaceholders",
        ChildFilterLALR_NoPlaceholders.from,
        <Object?>[
          to_include,
          node_builder,
        ],
        <String, Object?>{},
      );

  ChildFilterLALR_NoPlaceholders.from(super.pythonClass) : super.from();

  /// ## node_builder (getter)
  Object? get node_builder => getAttribute("node_builder");

  /// ## node_builder (setter)
  set node_builder(Object? node_builder) =>
      setAttribute("node_builder", node_builder);

  /// ## to_include (getter)
  Object? get to_include => getAttribute("to_include");

  /// ## to_include (setter)
  set to_include(Object? to_include) => setAttribute("to_include", to_include);
}

/// ## ExpandSingleChild
///
/// ### python source
/// ```py
/// class ExpandSingleChild:
///     def __init__(self, node_builder):
///         self.node_builder = node_builder
///
///     def __call__(self, children):
///         if len(children) == 1:
///             return children[0]
///         else:
///             return self.node_builder(children)
/// ```
final class ExpandSingleChild extends PythonClass {
  factory ExpandSingleChild({
    required Object? node_builder,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parse_tree_builder",
        "ExpandSingleChild",
        ExpandSingleChild.from,
        <Object?>[
          node_builder,
        ],
        <String, Object?>{},
      );

  ExpandSingleChild.from(super.pythonClass) : super.from();

  /// ## node_builder (getter)
  Object? get node_builder => getAttribute("node_builder");

  /// ## node_builder (setter)
  set node_builder(Object? node_builder) =>
      setAttribute("node_builder", node_builder);
}

/// ## PropagatePositions
///
/// ### python source
/// ```py
/// class PropagatePositions:
///     def __init__(self, node_builder, node_filter=None):
///         self.node_builder = node_builder
///         self.node_filter = node_filter
///
///     def __call__(self, children):
///         res = self.node_builder(children)
///
///         if isinstance(res, Tree):
///             # Calculate positions while the tree is streaming, according to the rule:
///             # - nodes start at the start of their first child's container,
///             #   and end at the end of their last child's container.
///             # Containers are nodes that take up space in text, but have been inlined in the tree.
///
///             res_meta = res.meta
///
///             first_meta = self._pp_get_meta(children)
///             if first_meta is not None:
///                 if not hasattr(res_meta, 'line'):
///                     # meta was already set, probably because the rule has been inlined (e.g. `?rule`)
///                     res_meta.line = getattr(first_meta, 'container_line', first_meta.line)
///                     res_meta.column = getattr(first_meta, 'container_column', first_meta.column)
///                     res_meta.start_pos = getattr(first_meta, 'container_start_pos', first_meta.start_pos)
///                     res_meta.empty = False
///
///                 res_meta.container_line = getattr(first_meta, 'container_line', first_meta.line)
///                 res_meta.container_column = getattr(first_meta, 'container_column', first_meta.column)
///
///             last_meta = self._pp_get_meta(reversed(children))
///             if last_meta is not None:
///                 if not hasattr(res_meta, 'end_line'):
///                     res_meta.end_line = getattr(last_meta, 'container_end_line', last_meta.end_line)
///                     res_meta.end_column = getattr(last_meta, 'container_end_column', last_meta.end_column)
///                     res_meta.end_pos = getattr(last_meta, 'container_end_pos', last_meta.end_pos)
///                     res_meta.empty = False
///
///                 res_meta.container_end_line = getattr(last_meta, 'container_end_line', last_meta.end_line)
///                 res_meta.container_end_column = getattr(last_meta, 'container_end_column', last_meta.end_column)
///
///         return res
///
///     def _pp_get_meta(self, children):
///         for c in children:
///             if self.node_filter is not None and not self.node_filter(c):
///                 continue
///             if isinstance(c, Tree):
///                 if not c.meta.empty:
///                     return c.meta
///             elif isinstance(c, Token):
///                 return c
///             elif hasattr(c, '__lark_meta__'):
///                 return c.__lark_meta__()
/// ```
final class PropagatePositions extends PythonClass {
  factory PropagatePositions({
    required Object? node_builder,
    Object? node_filter,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parse_tree_builder",
        "PropagatePositions",
        PropagatePositions.from,
        <Object?>[
          node_builder,
          node_filter,
        ],
        <String, Object?>{},
      );

  PropagatePositions.from(super.pythonClass) : super.from();

  /// ## node_builder (getter)
  Object? get node_builder => getAttribute("node_builder");

  /// ## node_builder (setter)
  set node_builder(Object? node_builder) =>
      setAttribute("node_builder", node_builder);

  /// ## node_filter (getter)
  Object? get node_filter => getAttribute("node_filter");

  /// ## node_filter (setter)
  set node_filter(Object? node_filter) =>
      setAttribute("node_filter", node_filter);
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
      PythonFfiDart.instance.importClass(
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
      PythonFfiDart.instance.importClass(
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
///     def __init__(self, parser_conf, debug=False):
///         self.debug = debug
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
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.grammar_analysis",
        "GrammarAnalyzer",
        GrammarAnalyzer.from,
        <Object?>[
          parser_conf,
          debug,
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
///     def __init__(self, parser_conf, debug=False):
///         analysis = LALR_Analyzer(parser_conf, debug=debug)
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
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.lalr_parser",
        "LALR_Parser",
        LALR_Parser.from,
        <Object?>[
          parser_conf,
          debug,
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
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## parser_conf (getter)
  Object? get parser_conf => getAttribute("parser_conf");

  /// ## parser_conf (setter)
  set parser_conf(Object? parser_conf) =>
      setAttribute("parser_conf", parser_conf);

  /// ## parser (getter)
  Object? get parser => getAttribute("parser");

  /// ## parser (setter)
  set parser(Object? parser) => setAttribute("parser", parser);
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
      PythonFfiDart.instance.importClass(
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
  Object? get grammar => getAttribute("grammar");

  /// ## grammar (setter)
  set grammar(Object? grammar) => setAttribute("grammar", grammar);

  /// ## rules (getter)
  Object? get rules => getAttribute("rules");

  /// ## rules (setter)
  set rules(Object? rules) => setAttribute("rules", rules);

  /// ## terminal_rules (getter)
  Object? get terminal_rules => getAttribute("terminal_rules");

  /// ## terminal_rules (setter)
  set terminal_rules(Object? terminal_rules) =>
      setAttribute("terminal_rules", terminal_rules);

  /// ## nonterminal_rules (getter)
  Object? get nonterminal_rules => getAttribute("nonterminal_rules");

  /// ## nonterminal_rules (setter)
  set nonterminal_rules(Object? nonterminal_rules) =>
      setAttribute("nonterminal_rules", nonterminal_rules);
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
  Object? get orig_rules => getAttribute("orig_rules");

  /// ## orig_rules (setter)
  set orig_rules(Object? orig_rules) => setAttribute("orig_rules", orig_rules);

  /// ## grammar (getter)
  Object? get grammar => getAttribute("grammar");

  /// ## grammar (setter)
  set grammar(Object? grammar) => setAttribute("grammar", grammar);
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
  Object? get rule => getAttribute("rule");

  /// ## rule (setter)
  set rule(Object? rule) => setAttribute("rule", rule);

  /// ## children (getter)
  Object? get children => getAttribute("children");

  /// ## children (setter)
  set children(Object? children) => setAttribute("children", children);

  /// ## weight (getter)
  Object? get weight => getAttribute("weight");

  /// ## weight (setter)
  set weight(Object? weight) => setAttribute("weight", weight);
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
  Object? get skipped_rules => getAttribute("skipped_rules");

  /// ## skipped_rules (setter)
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

/// ## xrange
final class xrange extends PythonClass {
  factory xrange() => PythonFfiDart.instance.importClass(
        "builtins",
        "xrange",
        xrange.from,
        <Object?>[],
      );

  xrange.from(super.pythonClass) : super.from();

  /// ## start (getter)
  Object? get start => getAttribute("start");

  /// ## start (setter)
  set start(Object? start) => setAttribute("start", start);

  /// ## step (getter)
  Object? get step => getAttribute("step");

  /// ## step (setter)
  set step(Object? step) => setAttribute("step", step);

  /// ## stop (getter)
  Object? get stop => getAttribute("stop");

  /// ## stop (setter)
  set stop(Object? stop) => setAttribute("stop", stop);

  /// ## count (getter)
  Object? get count => getAttribute("count");

  /// ## count (setter)
  set count(Object? count) => setAttribute("count", count);

  /// ## index (getter)
  Object? get index => getAttribute("index");

  /// ## index (setter)
  set index(Object? index) => setAttribute("index", index);
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
  Object? get tree_class => getAttribute("tree_class");

  /// ## tree_class (setter)
  set tree_class(Object? tree_class) => setAttribute("tree_class", tree_class);

  /// ## callbacks (getter)
  Object? get callbacks => getAttribute("callbacks");

  /// ## callbacks (setter)
  set callbacks(Object? callbacks) => setAttribute("callbacks", callbacks);

  /// ## prioritizer (getter)
  Object? get prioritizer => getAttribute("prioritizer");

  /// ## prioritizer (setter)
  set prioritizer(Object? prioritizer) =>
      setAttribute("prioritizer", prioritizer);

  /// ## resolve_ambiguity (getter)
  Object? get resolve_ambiguity => getAttribute("resolve_ambiguity");

  /// ## resolve_ambiguity (setter)
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
  Object? get expect => getAttribute("expect");

  /// ## expect (setter)
  set expect(Object? expect) => setAttribute("expect", expect);

  /// ## is_complete (getter)
  Object? get is_complete => getAttribute("is_complete");

  /// ## is_complete (setter)
  set is_complete(Object? is_complete) =>
      setAttribute("is_complete", is_complete);

  /// ## node (getter)
  Object? get node => getAttribute("node");

  /// ## node (setter)
  set node(Object? node) => setAttribute("node", node);

  /// ## previous (getter)
  Object? get previous => getAttribute("previous");

  /// ## previous (setter)
  set previous(Object? previous) => setAttribute("previous", previous);

  /// ## ptr (getter)
  Object? get ptr => getAttribute("ptr");

  /// ## ptr (setter)
  set ptr(Object? ptr) => setAttribute("ptr", ptr);

  /// ## rule (getter)
  Object? get rule => getAttribute("rule");

  /// ## rule (setter)
  set rule(Object? rule) => setAttribute("rule", rule);

  /// ## s (getter)
  Object? get s => getAttribute("s");

  /// ## s (setter)
  set s(Object? s) => setAttribute("s", s);

  /// ## start (getter)
  Object? get start => getAttribute("start");

  /// ## start (setter)
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
///         if not self.paths_loaded: self.load_paths()
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
  /// Returns a list of this node's children sorted from greatest to
  /// least priority.
  Object? get children => getAttribute("children");

  /// ## children (setter)
  ///
  /// ### python docstring
  ///
  /// Returns a list of this node's children sorted from greatest to
  /// least priority.
  set children(Object? children) => setAttribute("children", children);

  /// ## is_ambiguous (getter)
  ///
  /// ### python docstring
  ///
  /// Returns True if this node is ambiguous.
  Object? get is_ambiguous => getAttribute("is_ambiguous");

  /// ## is_ambiguous (setter)
  ///
  /// ### python docstring
  ///
  /// Returns True if this node is ambiguous.
  set is_ambiguous(Object? is_ambiguous) =>
      setAttribute("is_ambiguous", is_ambiguous);

  /// ## end (getter)
  Object? get end => getAttribute("end");

  /// ## end (setter)
  set end(Object? end) => setAttribute("end", end);

  /// ## is_intermediate (getter)
  Object? get is_intermediate => getAttribute("is_intermediate");

  /// ## is_intermediate (setter)
  set is_intermediate(Object? is_intermediate) =>
      setAttribute("is_intermediate", is_intermediate);

  /// ## paths (getter)
  Object? get paths => getAttribute("paths");

  /// ## paths (setter)
  set paths(Object? paths) => setAttribute("paths", paths);

  /// ## paths_loaded (getter)
  Object? get paths_loaded => getAttribute("paths_loaded");

  /// ## paths_loaded (setter)
  set paths_loaded(Object? paths_loaded) =>
      setAttribute("paths_loaded", paths_loaded);

  /// ## priority (getter)
  Object? get priority => getAttribute("priority");

  /// ## priority (setter)
  set priority(Object? priority) => setAttribute("priority", priority);

  /// ## s (getter)
  Object? get s => getAttribute("s");

  /// ## s (setter)
  set s(Object? s) => setAttribute("s", s);

  /// ## start (getter)
  Object? get start => getAttribute("start");

  /// ## start (setter)
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
  Object? get priority => getAttribute("priority");

  /// ## priority (setter)
  set priority(Object? priority) => setAttribute("priority", priority);

  /// ## term (getter)
  Object? get term => getAttribute("term");

  /// ## term (setter)
  set term(Object? term) => setAttribute("term", term);

  /// ## token (getter)
  Object? get token => getAttribute("token");

  /// ## token (setter)
  set token(Object? token) => setAttribute("token", token);
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
  Object? get pydot => getAttribute("pydot");

  /// ## pydot (setter)
  set pydot(Object? pydot) => setAttribute("pydot", pydot);

  /// ## graph (getter)
  Object? get graph => getAttribute("graph");

  /// ## graph (setter)
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
  Object? get data => getAttribute("data");

  /// ## data (setter)
  set data(Object? data) => setAttribute("data", data);

  /// ## node_stack (getter)
  Object? get node_stack => getAttribute("node_stack");

  /// ## node_stack (setter)
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
  Object? get single_visit => getAttribute("single_visit");

  /// ## single_visit (setter)
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
  Object? get NO_DATA => getAttribute("NO_DATA");

  /// ## NO_DATA (setter)
  set NO_DATA(Object? NO_DATA) => setAttribute("NO_DATA", NO_DATA);

  /// ## left (getter)
  Object? get left => getAttribute("left");

  /// ## left (setter)
  set left(Object? left) => setAttribute("left", left);

  /// ## right (getter)
  Object? get right => getAttribute("right");

  /// ## right (setter)
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
  /// Returns a list of this node's children.
  Object? get children => getAttribute("children");

  /// ## children (setter)
  ///
  /// ### python docstring
  ///
  /// Returns a list of this node's children.
  set children(Object? children) => setAttribute("children", children);

  /// ## is_empty (getter)
  Object? get is_empty => getAttribute("is_empty");

  /// ## is_empty (setter)
  set is_empty(Object? is_empty) => setAttribute("is_empty", is_empty);

  /// ## sort_key (getter)
  ///
  /// ### python docstring
  ///
  /// Used to sort PackedNode children of SymbolNodes.
  /// A SymbolNode has multiple PackedNodes if it matched
  /// ambiguously. Hence, we use the sort order to identify
  /// the order in which ambiguous children should be considered.
  Object? get sort_key => getAttribute("sort_key");

  /// ## sort_key (setter)
  ///
  /// ### python docstring
  ///
  /// Used to sort PackedNode children of SymbolNodes.
  /// A SymbolNode has multiple PackedNodes if it matched
  /// ambiguously. Hence, we use the sort order to identify
  /// the order in which ambiguous children should be considered.
  set sort_key(Object? sort_key) => setAttribute("sort_key", sort_key);

  /// ## left (getter)
  Object? get left => getAttribute("left");

  /// ## left (setter)
  set left(Object? left) => setAttribute("left", left);

  /// ## parent (getter)
  Object? get parent => getAttribute("parent");

  /// ## parent (setter)
  set parent(Object? parent) => setAttribute("parent", parent);

  /// ## priority (getter)
  Object? get priority => getAttribute("priority");

  /// ## priority (setter)
  set priority(Object? priority) => setAttribute("priority", priority);

  /// ## right (getter)
  Object? get right => getAttribute("right");

  /// ## right (setter)
  set right(Object? right) => setAttribute("right", right);

  /// ## rule (getter)
  Object? get rule => getAttribute("rule");

  /// ## rule (setter)
  set rule(Object? rule) => setAttribute("rule", rule);

  /// ## s (getter)
  Object? get s => getAttribute("s");

  /// ## s (setter)
  set s(Object? s) => setAttribute("s", s);

  /// ## start (getter)
  Object? get start => getAttribute("start");

  /// ## start (setter)
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
  Object? $get({
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
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);
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
///     def __init__(self, parser_conf, debug=False):
///         GrammarAnalyzer.__init__(self, parser_conf, debug)
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
///                         if not rp.rule.expansion[j] in self.NULLABLE:
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
///             actions = {}
///             for la, next_state in state.transitions.items():
///                 actions[la] = (Shift, next_state.closure)
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
///                 if la in actions:
///                     if self.debug:
///                         logger.warning('Shift/Reduce conflict for terminal %s: (resolving as shift)', la.name)
///                         logger.warning(' * %s', list(rules)[0])
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
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.lalr_analysis",
        "LALR_Analyzer",
        LALR_Analyzer.from,
        <Object?>[
          parser_conf,
          debug,
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
  ///                         if not rp.rule.expansion[j] in self.NULLABLE:
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
  ///             actions = {}
  ///             for la, next_state in state.transitions.items():
  ///                 actions[la] = (Shift, next_state.closure)
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
  ///                 if la in actions:
  ///                     if self.debug:
  ///                         logger.warning('Shift/Reduce conflict for terminal %s: (resolving as shift)', la.name)
  ///                         logger.warning(' * %s', list(rules)[0])
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
    required Object? lexer_thread,
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
  Object? iter_parse() => getFunction("iter_parse").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

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
  ///         return self.parser.parse_from_state(self.parser_state, last_token=self.lexer_state.state.last_token)
  /// ```
  Object? resume_parse() => getFunction("resume_parse").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## lexer_state (getter)
  Object? get lexer_state => getAttribute("lexer_state");

  /// ## lexer_state (setter)
  set lexer_state(Object? lexer_state) =>
      setAttribute("lexer_state", lexer_state);

  /// ## result (getter)
  Object? get result => getAttribute("result");

  /// ## result (setter)
  set result(Object? result) => setAttribute("result", result);

  /// ## parser (getter)
  Object? get parser => getAttribute("parser");

  /// ## parser (setter)
  set parser(Object? parser) => setAttribute("parser", parser);

  /// ## parser_state (getter)
  Object? get parser_state => getAttribute("parser_state");

  /// ## parser_state (setter)
  set parser_state(Object? parser_state) =>
      setAttribute("parser_state", parser_state);

  /// ## lexer_thread (getter)
  Object? get lexer_thread => getAttribute("lexer_thread");

  /// ## lexer_thread (setter)
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
///         return self.parser.parse_from_state(self.parser_state, last_token=self.lexer_state.state.last_token)
/// ```
final class InteractiveParser extends PythonClass {
  factory InteractiveParser({
    required Object? parser,
    required Object? parser_state,
    required Object? lexer_thread,
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
  Object? iter_parse() => getFunction("iter_parse").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

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
  ///         return self.parser.parse_from_state(self.parser_state, last_token=self.lexer_state.state.last_token)
  /// ```
  Object? resume_parse() => getFunction("resume_parse").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## lexer_state (getter)
  Object? get lexer_state => getAttribute("lexer_state");

  /// ## lexer_state (setter)
  set lexer_state(Object? lexer_state) =>
      setAttribute("lexer_state", lexer_state);

  /// ## parser (getter)
  Object? get parser => getAttribute("parser");

  /// ## parser (setter)
  set parser(Object? parser) => setAttribute("parser", parser);

  /// ## parser_state (getter)
  Object? get parser_state => getAttribute("parser_state");

  /// ## parser_state (setter)
  set parser_state(Object? parser_state) =>
      setAttribute("parser_state", parser_state);

  /// ## lexer_thread (getter)
  Object? get lexer_thread => getAttribute("lexer_thread");

  /// ## lexer_thread (setter)
  set lexer_thread(Object? lexer_thread) =>
      setAttribute("lexer_thread", lexer_thread);

  /// ## result (getter)
  Object? get result => getAttribute("result");

  /// ## result (setter)
  set result(Object? result) => setAttribute("result", result);
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

/// ## Meta
///
/// ### python source
/// ```py
/// class Meta:
///
///     empty: bool
///     line: int
///     column: int
///     start_pos: int
///     end_line: int
///     end_column: int
///     end_pos: int
///     orig_expansion: 'List[TerminalDef]'
///     match_tree: bool
///
///     def __init__(self):
///         self.empty = True
/// ```
final class Meta extends PythonClass {
  factory Meta() => PythonFfiDart.instance.importClass(
        "lark.tree",
        "Meta",
        Meta.from,
        <Object?>[],
        <String, Object?>{},
      );

  Meta.from(super.pythonClass) : super.from();

  /// ## empty (getter)
  Object? get empty => getAttribute("empty");

  /// ## empty (setter)
  set empty(Object? empty) => setAttribute("empty", empty);
}

/// ## UCD
final class UCD extends PythonClass {
  factory UCD() => PythonFfiDart.instance.importClass(
        "unicodedata",
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

/// ## CollapseAmbiguities
///
/// ### python docstring
///
/// Transforms a tree that contains any number of _ambig nodes into a list of trees,
/// each one containing an unambiguous tree.
///
/// The length of the resulting list is the product of the length of all _ambig nodes.
///
/// Warning: This may quickly explode for highly ambiguous trees.
///
/// ### python source
/// ```py
/// class CollapseAmbiguities(Transformer):
///     """
///     Transforms a tree that contains any number of _ambig nodes into a list of trees,
///     each one containing an unambiguous tree.
///
///     The length of the resulting list is the product of the length of all _ambig nodes.
///
///     Warning: This may quickly explode for highly ambiguous trees.
///
///     """
///     def _ambig(self, options):
///         return sum(options, [])
///
///     def __default__(self, data, children_lists, meta):
///         return [Tree(data, children, meta) for children in combine_alternatives(children_lists)]
///
///     def __default_token__(self, t):
///         return [t]
/// ```
final class CollapseAmbiguities extends PythonClass {
  factory CollapseAmbiguities({
    Object? visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.visitors",
        "CollapseAmbiguities",
        CollapseAmbiguities.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  CollapseAmbiguities.from(super.pythonClass) : super.from();

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         "Transform the given tree, and return the final result"
  ///         return self._transform_tree(tree)
  /// ```
  Object? transform({
    required Object? tree,
  }) =>
      getFunction("transform").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## InlineTransformer
///
/// ### python docstring
///
/// Transformers work bottom-up (or depth-first), starting with visiting the leaves and working
/// their way up until ending at the root of the tree.
///
/// For each node visited, the transformer will call the appropriate method (callbacks), according to the
/// node's ``data``, and use the returned value to replace the node, thereby creating a new tree structure.
///
/// Transformers can be used to implement map & reduce patterns. Because nodes are reduced from leaf to root,
/// at any point the callbacks may assume the children have already been transformed (if applicable).
///
/// If the transformer cannot find a method with the right name, it will instead call ``__default__``, which by
/// default creates a copy of the node.
///
/// To discard a node, return Discard (``lark.visitors.Discard``).
///
/// ``Transformer`` can do anything ``Visitor`` can do, but because it reconstructs the tree,
/// it is slightly less efficient.
///
/// A transformer without methods essentially performs a non-memoized partial deepcopy.
///
/// All these classes implement the transformer interface:
///
/// - ``Transformer`` - Recursively transforms the tree. This is the one you probably want.
/// - ``Transformer_InPlace`` - Non-recursive. Changes the tree in-place instead of returning new instances
/// - ``Transformer_InPlaceRecursive`` - Recursive. Changes the tree in-place instead of returning new instances
///
/// Parameters:
///     visit_tokens (bool, optional): Should the transformer visit tokens in addition to rules.
///                                    Setting this to ``False`` is slightly faster. Defaults to ``True``.
///                                    (For processing ignored tokens, use the ``lexer_callbacks`` options)
///
/// ### python source
/// ```py
/// class InlineTransformer(Transformer):   # XXX Deprecated
///     def _call_userfunc(self, tree, new_children=None):
///         # Assumes tree is already transformed
///         children = new_children if new_children is not None else tree.children
///         try:
///             f = getattr(self, tree.data)
///         except AttributeError:
///             return self.__default__(tree.data, children, tree.meta)
///         else:
///             return f(*children)
/// ```
final class InlineTransformer extends PythonClass {
  factory InlineTransformer({
    Object? visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.visitors",
        "InlineTransformer",
        InlineTransformer.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  InlineTransformer.from(super.pythonClass) : super.from();

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         "Transform the given tree, and return the final result"
  ///         return self._transform_tree(tree)
  /// ```
  Object? transform({
    required Object? tree,
  }) =>
      getFunction("transform").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## Interpreter
///
/// ### python docstring
///
/// Interpreter walks the tree starting at the root.
///
/// Visits the tree, starting with the root and finally the leaves (top-down)
///
/// For each tree node, it calls its methods (provided by user via inheritance) according to ``tree.data``.
///
/// Unlike ``Transformer`` and ``Visitor``, the Interpreter doesn't automatically visit its sub-branches.
/// The user has to explicitly call ``visit``, ``visit_children``, or use the ``@visit_children_decor``.
/// This allows the user to implement branching and loops.
///
/// ### python source
/// ```py
/// class Interpreter(_Decoratable, ABC, Generic[_Leaf_T, _Return_T]):
///     """Interpreter walks the tree starting at the root.
///
///     Visits the tree, starting with the root and finally the leaves (top-down)
///
///     For each tree node, it calls its methods (provided by user via inheritance) according to ``tree.data``.
///
///     Unlike ``Transformer`` and ``Visitor``, the Interpreter doesn't automatically visit its sub-branches.
///     The user has to explicitly call ``visit``, ``visit_children``, or use the ``@visit_children_decor``.
///     This allows the user to implement branching and loops.
///     """
///
///     def visit(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         # There are no guarantees on the type of the value produced by calling a user func for a
///         # child will produce. So only annotate the public method and use an internal method when
///         # visiting child trees.
///         return self._visit_tree(tree)
///
///     def _visit_tree(self, tree: Tree[_Leaf_T]):
///         f = getattr(self, tree.data)
///         wrapper = getattr(f, 'visit_wrapper', None)
///         if wrapper is not None:
///             return f.visit_wrapper(f, tree.data, tree.children, tree.meta)
///         else:
///             return f(tree)
///
///     def visit_children(self, tree: Tree[_Leaf_T]) -> List:
///         return [self._visit_tree(child) if isinstance(child, Tree) else child
///                 for child in tree.children]
///
///     def __getattr__(self, name):
///         return self.__default__
///
///     def __default__(self, tree):
///         return self.visit_children(tree)
/// ```
final class Interpreter extends PythonClass {
  factory Interpreter() => PythonFfiDart.instance.importClass(
        "lark.visitors",
        "Interpreter",
        Interpreter.from,
        <Object?>[],
      );

  Interpreter.from(super.pythonClass) : super.from();

  /// ## visit
  ///
  /// ### python source
  /// ```py
  /// def visit(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         # There are no guarantees on the type of the value produced by calling a user func for a
  ///         # child will produce. So only annotate the public method and use an internal method when
  ///         # visiting child trees.
  ///         return self._visit_tree(tree)
  /// ```
  Object? visit({
    required Object? tree,
  }) =>
      getFunction("visit").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_children
  ///
  /// ### python source
  /// ```py
  /// def visit_children(self, tree: Tree[_Leaf_T]) -> List:
  ///         return [self._visit_tree(child) if isinstance(child, Tree) else child
  ///                 for child in tree.children]
  /// ```
  Object? visit_children({
    required Object? tree,
  }) =>
      getFunction("visit_children").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## TransformerChain
///
/// ### python docstring
///
/// Abstract base class for generic types.
///
/// A generic type is typically declared by inheriting from
/// this class parameterized with one or more type variables.
/// For example, a generic mapping type might be defined as::
///
///   class Mapping(Generic[KT, VT]):
///       def __getitem__(self, key: KT) -> VT:
///           ...
///       # Etc.
///
/// This class can then be used as follows::
///
///   def lookup_name(mapping: Mapping[KT, VT], key: KT, default: VT) -> VT:
///       try:
///           return mapping[key]
///       except KeyError:
///           return default
///
/// ### python source
/// ```py
/// class TransformerChain(Generic[_Leaf_T, _Return_T]):
///
///     transformers: 'Tuple[Union[Transformer, TransformerChain], ...]'
///
///     def __init__(self, *transformers: 'Union[Transformer, TransformerChain]') -> None:
///         self.transformers = transformers
///
///     def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         for t in self.transformers:
///             tree = t.transform(tree)
///         return cast(_Return_T, tree)
///
///     def __mul__(
///             self: 'TransformerChain[_Leaf_T, Tree[_Leaf_U]]',
///             other: 'Union[Transformer[_Leaf_U, _Return_V], TransformerChain[_Leaf_U, _Return_V]]'
///     ) -> 'TransformerChain[_Leaf_T, _Return_V]':
///         return TransformerChain(*self.transformers + (other,))
/// ```
final class TransformerChain extends PythonClass {
  factory TransformerChain({
    List<Object?> transformers = const <Object?>[],
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.visitors",
        "TransformerChain",
        TransformerChain.from,
        <Object?>[
          ...transformers,
        ],
        <String, Object?>{},
      );

  TransformerChain.from(super.pythonClass) : super.from();

  /// ## transform
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         for t in self.transformers:
  ///             tree = t.transform(tree)
  ///         return cast(_Return_T, tree)
  /// ```
  Object? transform({
    required Object? tree,
  }) =>
      getFunction("transform").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transformers (getter)
  Object? get transformers => getAttribute("transformers");

  /// ## transformers (setter)
  set transformers(Object? transformers) =>
      setAttribute("transformers", transformers);
}

/// ## Transformer_InPlaceRecursive
///
/// ### python docstring
///
/// Same as Transformer, recursive, but changes the tree in-place instead of returning new instances
///
/// ### python source
/// ```py
/// class Transformer_InPlaceRecursive(Transformer):
///     "Same as Transformer, recursive, but changes the tree in-place instead of returning new instances"
///     def _transform_tree(self, tree):
///         tree.children = list(self._transform_children(tree.children))
///         return self._call_userfunc(tree)
/// ```
final class Transformer_InPlaceRecursive extends PythonClass {
  factory Transformer_InPlaceRecursive({
    Object? visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.visitors",
        "Transformer_InPlaceRecursive",
        Transformer_InPlaceRecursive.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  Transformer_InPlaceRecursive.from(super.pythonClass) : super.from();

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         "Transform the given tree, and return the final result"
  ///         return self._transform_tree(tree)
  /// ```
  Object? transform({
    required Object? tree,
  }) =>
      getFunction("transform").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## VisitorBase
///
/// ### python source
/// ```py
/// class VisitorBase:
///     def _call_userfunc(self, tree):
///         return getattr(self, tree.data, self.__default__)(tree)
///
///     def __default__(self, tree):
///         """Default function that is called if there is no attribute matching ``tree.data``
///
///         Can be overridden. Defaults to doing nothing.
///         """
///         return tree
///
///     def __class_getitem__(cls, _):
///         return cls
/// ```
final class VisitorBase extends PythonClass {
  factory VisitorBase() => PythonFfiDart.instance.importClass(
        "lark.visitors",
        "VisitorBase",
        VisitorBase.from,
        <Object?>[],
      );

  VisitorBase.from(super.pythonClass) : super.from();
}

/// ## Visitor_Recursive
///
/// ### python docstring
///
/// Bottom-up visitor, recursive.
///
/// Visiting a node calls its methods (provided by the user via inheritance) according to ``tree.data``
///
/// Slightly faster than the non-recursive version.
///
/// ### python source
/// ```py
/// class Visitor_Recursive(VisitorBase, Generic[_Leaf_T]):
///     """Bottom-up visitor, recursive.
///
///     Visiting a node calls its methods (provided by the user via inheritance) according to ``tree.data``
///
///     Slightly faster than the non-recursive version.
///     """
///
///     def visit(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
///         "Visits the tree, starting with the leaves and finally the root (bottom-up)"
///         for child in tree.children:
///             if isinstance(child, Tree):
///                 self.visit(child)
///
///         self._call_userfunc(tree)
///         return tree
///
///     def visit_topdown(self,tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
///         "Visit the tree, starting at the root, and ending at the leaves (top-down)"
///         self._call_userfunc(tree)
///
///         for child in tree.children:
///             if isinstance(child, Tree):
///                 self.visit_topdown(child)
///
///         return tree
/// ```
final class Visitor_Recursive extends PythonClass {
  factory Visitor_Recursive() => PythonFfiDart.instance.importClass(
        "lark.visitors",
        "Visitor_Recursive",
        Visitor_Recursive.from,
        <Object?>[],
      );

  Visitor_Recursive.from(super.pythonClass) : super.from();

  /// ## visit
  ///
  /// ### python docstring
  ///
  /// Visits the tree, starting with the leaves and finally the root (bottom-up)
  ///
  /// ### python source
  /// ```py
  /// def visit(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
  ///         "Visits the tree, starting with the leaves and finally the root (bottom-up)"
  ///         for child in tree.children:
  ///             if isinstance(child, Tree):
  ///                 self.visit(child)
  ///
  ///         self._call_userfunc(tree)
  ///         return tree
  /// ```
  Object? visit({
    required Object? tree,
  }) =>
      getFunction("visit").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_topdown
  ///
  /// ### python docstring
  ///
  /// Visit the tree, starting at the root, and ending at the leaves (top-down)
  ///
  /// ### python source
  /// ```py
  /// def visit_topdown(self,tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
  ///         "Visit the tree, starting at the root, and ending at the leaves (top-down)"
  ///         self._call_userfunc(tree)
  ///
  ///         for child in tree.children:
  ///             if isinstance(child, Tree):
  ///                 self.visit_topdown(child)
  ///
  ///         return tree
  /// ```
  Object? visit_topdown({
    required Object? tree,
  }) =>
      getFunction("visit_topdown").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## lark
///
/// ### python source
/// ```py
/// from .exceptions import (
///     GrammarError,
///     LarkError,
///     LexError,
///     ParseError,
///     UnexpectedCharacters,
///     UnexpectedEOF,
///     UnexpectedInput,
///     UnexpectedToken,
/// )
/// from .lark import Lark
/// from .lexer import Token
/// from .tree import ParseTree, Tree
/// from .utils import logger
/// from .visitors import Discard, Transformer, Transformer_NonRecursive, Visitor, v_args
///
/// __version__: str = "1.1.5"
///
/// __all__ = (
///     "GrammarError",
///     "LarkError",
///     "LexError",
///     "ParseError",
///     "UnexpectedCharacters",
///     "UnexpectedEOF",
///     "UnexpectedInput",
///     "UnexpectedToken",
///     "Lark",
///     "Token",
///     "ParseTree",
///     "Tree",
///     "logger",
///     "Discard",
///     "Transformer",
///     "Transformer_NonRecursive",
///     "Visitor",
///     "v_args",
/// )
/// ```
final class lark extends PythonModule {
  lark.from(super.pythonModule) : super.from();

  static lark import() => PythonFfiDart.instance.importModule(
        "lark",
        lark.from,
      );
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
///
///     def __init__(self, terminals: Collection[TerminalDef], re_module: ModuleType, ignore: Collection[str]=(), postlex: 'Optional[PostLex]'=None, callbacks: Optional[Dict[str, _Callback]]=None, g_regex_flags: int=0, skip_validation: bool=False, use_bytes: bool=False):
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

  static common import() => PythonFfiDart.instance.importModule(
        "lark.common",
        common.from,
      );

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
        "sys",
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
  Object? get pycache_prefix => getAttribute("pycache_prefix");

  /// ## pycache_prefix (setter)
  set pycache_prefix(Object? pycache_prefix) =>
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

/// ## exceptions
///
/// ### python source
/// ```py
/// from .utils import logger, NO_VALUE
/// from typing import Mapping, Iterable, Callable, Union, TypeVar, Tuple, Any, List, Set, Optional, Collection, TYPE_CHECKING
///
/// if TYPE_CHECKING:
///     from .lexer import Token
///     from .parsers.lalr_interactive_parser import InteractiveParser
///     from .tree import Tree
///
/// ###{standalone
///
/// class LarkError(Exception):
///     pass
///
///
/// class ConfigurationError(LarkError, ValueError):
///     pass
///
///
/// def assert_config(value, options: Collection, msg='Got %r, expected one of %s'):
///     if value not in options:
///         raise ConfigurationError(msg % (value, options))
///
///
/// class GrammarError(LarkError):
///     pass
///
///
/// class ParseError(LarkError):
///     pass
///
///
/// class LexError(LarkError):
///     pass
///
/// T = TypeVar('T')
///
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
///
///
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
///
///
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
///
///
/// class UnexpectedToken(ParseError, UnexpectedInput):
///     """An exception that is raised by the parser, when the token it received
///     doesn't match any valid step forward.
///
///     Parameters:
///         token: The mismatched token
///         expected: The set of expected tokens
///         considered_rules: Which rules were considered, to deduce the expected tokens
///         state: A value representing the parser state. Do not rely on its value or type.
///         interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failture,
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
///
///
///
/// class VisitError(LarkError):
///     """VisitError is raised when visitors are interrupted by an exception
///
///     It provides the following attributes for inspection:
///
///     Parameters:
///         rule: the name of the visit rule that failed
///         obj: the tree-node or token that was being processed
///         orig_exc: the exception that cause it to fail
///
///     Note: These parameters are available as attributes
///     """
///
///     obj: 'Union[Tree, Token]'
///     orig_exc: Exception
///
///     def __init__(self, rule, obj, orig_exc):
///         message = 'Error trying to process rule "%s":\n\n%s' % (rule, orig_exc)
///         super(VisitError, self).__init__(message)
///
///         self.rule = rule
///         self.obj = obj
///         self.orig_exc = orig_exc
///
///
/// class MissingVariableError(LarkError):
///     pass
///
/// ###}
/// ```
final class exceptions extends PythonModule {
  exceptions.from(super.pythonModule) : super.from();

  static exceptions import() => PythonFfiDart.instance.importModule(
        "lark.exceptions",
        exceptions.from,
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

  /// ## T (getter)
  ///
  /// ### python docstring
  ///
  /// Type variable.
  ///
  /// Usage::
  ///
  ///   T = TypeVar('T')  # Can be anything
  ///   A = TypeVar('A', str, bytes)  # Must be str or bytes
  ///
  /// Type variables exist primarily for the benefit of static type
  /// checkers.  They serve as the parameters for generic types as well
  /// as for generic function definitions.  See class Generic for more
  /// information on generic types.  Generic functions work as follows:
  ///
  ///   def repeat(x: T, n: int) -> List[T]:
  ///       '''Return a list containing n references to x.'''
  ///       return [x]*n
  ///
  ///   def longest(x: A, y: A) -> A:
  ///       '''Return the longest of two strings.'''
  ///       return x if len(x) >= len(y) else y
  ///
  /// The latter example's signature is essentially the overloading
  /// of (str, str) -> str and (bytes, bytes) -> bytes.  Also note
  /// that if the arguments are instances of some subclass of str,
  /// the return type is still plain str.
  ///
  /// At runtime, isinstance(x, T) and issubclass(C, T) will raise TypeError.
  ///
  /// Type variables defined with covariant=True or contravariant=True
  /// can be used to declare covariant or contravariant generic types.
  /// See PEP 484 for more details. By default generic types are invariant
  /// in all type variables.
  ///
  /// Type variables can be introspected. e.g.:
  ///
  ///   T.__name__ == 'T'
  ///   T.__constraints__ == ()
  ///   T.__covariant__ == False
  ///   T.__contravariant__ = False
  ///   A.__constraints__ == (str, bytes)
  ///
  /// Note that only type variables defined in global scope can be pickled.
  Object? get T => getAttribute("T");

  /// ## T (setter)
  ///
  /// ### python docstring
  ///
  /// Type variable.
  ///
  /// Usage::
  ///
  ///   T = TypeVar('T')  # Can be anything
  ///   A = TypeVar('A', str, bytes)  # Must be str or bytes
  ///
  /// Type variables exist primarily for the benefit of static type
  /// checkers.  They serve as the parameters for generic types as well
  /// as for generic function definitions.  See class Generic for more
  /// information on generic types.  Generic functions work as follows:
  ///
  ///   def repeat(x: T, n: int) -> List[T]:
  ///       '''Return a list containing n references to x.'''
  ///       return [x]*n
  ///
  ///   def longest(x: A, y: A) -> A:
  ///       '''Return the longest of two strings.'''
  ///       return x if len(x) >= len(y) else y
  ///
  /// The latter example's signature is essentially the overloading
  /// of (str, str) -> str and (bytes, bytes) -> bytes.  Also note
  /// that if the arguments are instances of some subclass of str,
  /// the return type is still plain str.
  ///
  /// At runtime, isinstance(x, T) and issubclass(C, T) will raise TypeError.
  ///
  /// Type variables defined with covariant=True or contravariant=True
  /// can be used to declare covariant or contravariant generic types.
  /// See PEP 484 for more details. By default generic types are invariant
  /// in all type variables.
  ///
  /// Type variables can be introspected. e.g.:
  ///
  ///   T.__name__ == 'T'
  ///   T.__constraints__ == ()
  ///   T.__covariant__ == False
  ///   T.__contravariant__ = False
  ///   A.__constraints__ == (str, bytes)
  ///
  /// Note that only type variables defined in global scope can be pickled.
  set T(Object? T) => setAttribute("T", T);

  /// ## TYPE_CHECKING (getter)
  Object? get TYPE_CHECKING => getAttribute("TYPE_CHECKING");

  /// ## TYPE_CHECKING (setter)
  set TYPE_CHECKING(Object? TYPE_CHECKING) =>
      setAttribute("TYPE_CHECKING", TYPE_CHECKING);
}

/// ## grammar
///
/// ### python source
/// ```py
/// from typing import Optional, Tuple, ClassVar
///
/// from .utils import Serialize
///
/// ###{standalone
/// TOKEN_DEFAULT_PRIORITY = 0
///
///
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
///
///
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
///
///
/// class NonTerminal(Symbol):
///     __serialize_fields__ = 'name',
///
///     is_term: ClassVar[bool] = False
///
///
/// class RuleOptions(Serialize):
///     __serialize_fields__ = 'keep_all_tokens', 'expand1', 'priority', 'template_source', 'empty_indices'
///
///     keep_all_tokens: bool
///     expand1: bool
///     priority: Optional[int]
///     template_source: Optional[str]
///     empty_indices: Tuple[bool, ...]
///
///     def __init__(self, keep_all_tokens: bool=False, expand1: bool=False, priority: Optional[int]=None, template_source: Optional[str]=None, empty_indices: Tuple[bool, ...]=()) -> None:
///         self.keep_all_tokens = keep_all_tokens
///         self.expand1 = expand1
///         self.priority = priority
///         self.template_source = template_source
///         self.empty_indices = empty_indices
///
///     def __repr__(self):
///         return 'RuleOptions(%r, %r, %r, %r)' % (
///             self.keep_all_tokens,
///             self.expand1,
///             self.priority,
///             self.template_source
///         )
///
///
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
///
///
/// ###}
/// ```
final class grammar extends PythonModule {
  grammar.from(super.pythonModule) : super.from();

  static grammar import() => PythonFfiDart.instance.importModule(
        "lark.grammar",
        grammar.from,
      );

  /// ## TOKEN_DEFAULT_PRIORITY (getter)
  Object? get TOKEN_DEFAULT_PRIORITY => getAttribute("TOKEN_DEFAULT_PRIORITY");

  /// ## TOKEN_DEFAULT_PRIORITY (setter)
  set TOKEN_DEFAULT_PRIORITY(Object? TOKEN_DEFAULT_PRIORITY) =>
      setAttribute("TOKEN_DEFAULT_PRIORITY", TOKEN_DEFAULT_PRIORITY);
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
///     TypeVar, Type, List, Dict, Iterator, Collection, Callable, Optional, FrozenSet, Any,
///     Pattern as REPattern, ClassVar, TYPE_CHECKING, overload
/// )
/// from types import ModuleType
/// import warnings
/// if TYPE_CHECKING:
///     from .common import LexerConf
///
/// from .utils import classify, get_regexp_width, Serialize
/// from .exceptions import UnexpectedCharacters, LexError, UnexpectedToken
/// from .grammar import TOKEN_DEFAULT_PRIORITY
///
/// ###{standalone
/// from copy import copy
///
///
/// class Pattern(Serialize, ABC):
///
///     value: str
///     flags: Collection[str]
///     raw: Optional[str]
///     type: ClassVar[str]
///
///     def __init__(self, value: str, flags: Collection[str]=(), raw: Optional[str]=None) -> None:
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
///     __serialize_fields__ = 'value', 'flags'
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
///     __serialize_fields__ = 'value', 'flags', '_width'
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
///     def __init__(self, name: str, pattern: Pattern, priority: int=TOKEN_DEFAULT_PRIORITY) -> None:
///         assert isinstance(pattern, Pattern), pattern
///         self.name = name
///         self.pattern = pattern
///         self.priority = priority
///
///     def __repr__(self):
///         return '%s(%r, %r)' % (type(self).__name__, self.name, self.pattern)
///
///     def user_repr(self) -> str:
///         if self.name.startswith('__'): # We represent a generated terminal
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
///         cls,
///         type: str,
///         value: Any,
///         start_pos: Optional[int]=None,
///         line: Optional[int]=None,
///         column: Optional[int]=None,
///         end_line: Optional[int]=None,
///         end_column: Optional[int]=None,
///         end_pos: Optional[int]=None
///     ) -> 'Token':
///         ...
///
///     @overload
///     def __new__(
///         cls,
///         type_: str,
///         value: Any,
///         start_pos: Optional[int]=None,
///         line: Optional[int]=None,
///         column: Optional[int]=None,
///         end_line: Optional[int]=None,
///         end_column: Optional[int]=None,
///         end_pos: Optional[int]=None
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
///     def update(self, type: Optional[str]=None, value: Optional[Any]=None) -> 'Token':
///         ...
///
///     @overload
///     def update(self, type_: Optional[str]=None, value: Optional[Any]=None) -> 'Token':
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
///     def _future_update(self, type: Optional[str]=None, value: Optional[Any]=None) -> 'Token':
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
///                 return self._build_mres(terminals, max_size//2)
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
///     (Lexer objects are only instanciated per grammar, not per text)
///     """
///
///     __slots__ = 'text', 'line_ctr', 'last_token'
///
///     def __init__(self, text, line_ctr=None, last_token=None):
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
/// class BasicLexer(Lexer):
///
///     terminals: Collection[TerminalDef]
///     ignore_types: FrozenSet[str]
///     newline_types: FrozenSet[str]
///     user_callbacks: Dict[str, _Callback]
///     callback: Dict[str, _Callback]
///     re: ModuleType
///
///     def __init__(self, conf: 'LexerConf') -> None:
///         terminals = list(conf.terminals)
///         assert all(isinstance(t, TerminalDef) for t in terminals), terminals
///
///         self.re = conf.re_module
///
///         if not conf.skip_validation:
///             # Sanitization
///             for t in terminals:
///                 try:
///                     self.re.compile(t.pattern.to_regexp(), conf.g_regex_flags)
///                 except self.re.error:
///                     raise LexError("Cannot compile token %s: %s" % (t.name, t.pattern))
///
///                 if t.pattern.min_width == 0:
///                     raise LexError("Lexer does not allow zero-width terminals. (%s: %s)" % (t.name, t.pattern))
///
///             if not (set(conf.ignore) <= {t.name for t in terminals}):
///                 raise LexError("Ignore terminals are not defined: %s" % (set(conf.ignore) - {t.name for t in terminals}))
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
///     def next_token(self, lex_state: LexerState, parser_state: Any=None) -> Token:
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
///                 lexer = BasicLexer(lexer_conf)
///                 lexer_by_tokens[key] = lexer
///
///             self.lexers[state] = lexer
///
///         assert trad_conf.terminals is terminals
///         self.root_lexer = BasicLexer(trad_conf)
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
}

/// ## load_grammar
///
/// ### python docstring
///
/// Parses and creates Grammar objects
///
/// ### python source
/// ```py
/// """Parses and creates Grammar objects"""
/// import hashlib
/// import os.path
/// import sys
/// from collections import namedtuple
/// from copy import copy, deepcopy
/// import pkgutil
/// from ast import literal_eval
/// from contextlib import suppress
/// from typing import List, Tuple, Union, Callable, Dict, Optional, Sequence
///
/// from .utils import bfs, logger, classify_bool, is_id_continue, is_id_start, bfs_all_unique, small_factors
/// from .lexer import Token, TerminalDef, PatternStr, PatternRE
///
/// from .parse_tree_builder import ParseTreeBuilder
/// from .parser_frontends import ParsingFrontend
/// from .common import LexerConf, ParserConf
/// from .grammar import RuleOptions, Rule, Terminal, NonTerminal, Symbol, TOKEN_DEFAULT_PRIORITY
/// from .utils import classify, dedup_list
/// from .exceptions import GrammarError, UnexpectedCharacters, UnexpectedToken, ParseError, UnexpectedInput
///
/// from .tree import Tree, SlottedTree as ST
/// from .visitors import Transformer, Visitor, v_args, Transformer_InPlace, Transformer_NonRecursive
/// inline_args = v_args(inline=True)
///
/// __path__ = os.path.dirname(__file__)
/// IMPORT_PATHS = ['grammars']
///
/// EXT = '.lark'
///
/// _RE_FLAGS = 'imslux'
///
/// _EMPTY = Symbol('__empty__')
///
/// _TERMINAL_NAMES = {
///     '.' : 'DOT',
///     ',' : 'COMMA',
///     ':' : 'COLON',
///     ';' : 'SEMICOLON',
///     '+' : 'PLUS',
///     '-' : 'MINUS',
///     '*' : 'STAR',
///     '/' : 'SLASH',
///     '\\' : 'BACKSLASH',
///     '|' : 'VBAR',
///     '?' : 'QMARK',
///     '!' : 'BANG',
///     '@' : 'AT',
///     '#' : 'HASH',
///     '$' : 'DOLLAR',
///     '%' : 'PERCENT',
///     '^' : 'CIRCUMFLEX',
///     '&' : 'AMPERSAND',
///     '_' : 'UNDERSCORE',
///     '<' : 'LESSTHAN',
///     '>' : 'MORETHAN',
///     '=' : 'EQUAL',
///     '"' : 'DBLQUOTE',
///     '\'' : 'QUOTE',
///     '`' : 'BACKQUOTE',
///     '~' : 'TILDE',
///     '(' : 'LPAR',
///     ')' : 'RPAR',
///     '{' : 'LBRACE',
///     '}' : 'RBRACE',
///     '[' : 'LSQB',
///     ']' : 'RSQB',
///     '\n' : 'NEWLINE',
///     '\r\n' : 'CRLF',
///     '\t' : 'TAB',
///     ' ' : 'SPACE',
/// }
///
/// # Grammar Parser
/// TERMINALS = {
///     '_LPAR': r'\(',
///     '_RPAR': r'\)',
///     '_LBRA': r'\[',
///     '_RBRA': r'\]',
///     '_LBRACE': r'\{',
///     '_RBRACE': r'\}',
///     'OP': '[+*]|[?](?![a-z])',
///     '_COLON': ':',
///     '_COMMA': ',',
///     '_OR': r'\|',
///     '_DOT': r'\.(?!\.)',
///     '_DOTDOT': r'\.\.',
///     'TILDE': '~',
///     'RULE_MODIFIERS': '(!|![?]?|[?]!?)(?=[_a-z])',
///     'RULE': '_?[a-z][_a-z0-9]*',
///     'TERMINAL': '_?[A-Z][_A-Z0-9]*',
///     'STRING': r'"(\\"|\\\\|[^"\n])*?"i?',
///     'REGEXP': r'/(?!/)(\\/|\\\\|[^/])*?/[%s]*' % _RE_FLAGS,
///     '_NL': r'(\r?\n)+\s*',
///     '_NL_OR': r'(\r?\n)+\s*\|',
///     'WS': r'[ \t]+',
///     'COMMENT': r'\s*//[^\n]*',
///     'BACKSLASH': r'\\[ ]*\n',
///     '_TO': '->',
///     '_IGNORE': r'%ignore',
///     '_OVERRIDE': r'%override',
///     '_DECLARE': r'%declare',
///     '_EXTEND': r'%extend',
///     '_IMPORT': r'%import',
///     'NUMBER': r'[+-]?\d+',
/// }
///
/// RULES = {
///     'start': ['_list'],
///     '_list':  ['_item', '_list _item'],
///     '_item':  ['rule', 'term', 'ignore', 'import', 'declare', 'override', 'extend', '_NL'],
///
///     'rule': ['rule_modifiers RULE template_params priority _COLON expansions _NL'],
///     'rule_modifiers': ['RULE_MODIFIERS',
///                        ''],
///     'priority': ['_DOT NUMBER',
///                  ''],
///     'template_params': ['_LBRACE _template_params _RBRACE',
///                         ''],
///     '_template_params': ['RULE',
///                          '_template_params _COMMA RULE'],
///     'expansions': ['_expansions'],
///     '_expansions': ['alias',
///                     '_expansions _OR alias',
///                     '_expansions _NL_OR alias'],
///
///     '?alias':     ['expansion _TO nonterminal', 'expansion'],
///     'expansion': ['_expansion'],
///
///     '_expansion': ['', '_expansion expr'],
///
///     '?expr': ['atom',
///               'atom OP',
///               'atom TILDE NUMBER',
///               'atom TILDE NUMBER _DOTDOT NUMBER',
///               ],
///
///     '?atom': ['_LPAR expansions _RPAR',
///               'maybe',
///               'value'],
///
///     'value': ['terminal',
///               'nonterminal',
///               'literal',
///               'range',
///               'template_usage'],
///
///     'terminal': ['TERMINAL'],
///     'nonterminal': ['RULE'],
///
///     '?name': ['RULE', 'TERMINAL'],
///     '?symbol': ['terminal', 'nonterminal'],
///
///     'maybe': ['_LBRA expansions _RBRA'],
///     'range': ['STRING _DOTDOT STRING'],
///
///     'template_usage': ['nonterminal _LBRACE _template_args _RBRACE'],
///     '_template_args': ['value',
///                        '_template_args _COMMA value'],
///
///     'term': ['TERMINAL _COLON expansions _NL',
///              'TERMINAL _DOT NUMBER _COLON expansions _NL'],
///     'override': ['_OVERRIDE rule',
///                  '_OVERRIDE term'],
///     'extend': ['_EXTEND rule',
///                '_EXTEND term'],
///     'ignore': ['_IGNORE expansions _NL'],
///     'declare': ['_DECLARE _declare_args _NL'],
///     'import': ['_IMPORT _import_path _NL',
///                '_IMPORT _import_path _LPAR name_list _RPAR _NL',
///                '_IMPORT _import_path _TO name _NL'],
///
///     '_import_path': ['import_lib', 'import_rel'],
///     'import_lib': ['_import_args'],
///     'import_rel': ['_DOT _import_args'],
///     '_import_args': ['name', '_import_args _DOT name'],
///
///     'name_list': ['_name_list'],
///     '_name_list': ['name', '_name_list _COMMA name'],
///
///     '_declare_args': ['symbol', '_declare_args symbol'],
///     'literal': ['REGEXP', 'STRING'],
/// }
///
///
/// # Value 5 keeps the number of states in the lalr parser somewhat minimal
/// # It isn't optimal, but close to it. See PR #949
/// SMALL_FACTOR_THRESHOLD = 5
/// # The Threshold whether repeat via ~ are split up into different rules
/// # 50 is chosen since it keeps the number of states low and therefore lalr analysis time low,
/// # while not being to overaggressive and unnecessarily creating rules that might create shift/reduce conflicts.
/// # (See PR #949)
/// REPEAT_BREAK_THRESHOLD = 50
///
///
/// class FindRuleSize(Transformer):
///     def __init__(self, keep_all_tokens):
///         self.keep_all_tokens = keep_all_tokens
///
///     def _will_not_get_removed(self, sym):
///         if isinstance(sym, NonTerminal):
///             return not sym.name.startswith('_')
///         if isinstance(sym, Terminal):
///             return self.keep_all_tokens or not sym.filter_out
///         if sym is _EMPTY:
///             return False
///         assert False, sym
///
///     def _args_as_int(self, args):
///         for a in args:
///             if isinstance(a, int):
///                 yield a
///             elif isinstance(a, Symbol):
///                 yield 1 if self._will_not_get_removed(a) else 0
///             else:
///                 assert False
///
///     def expansion(self, args):
///         return sum(self._args_as_int(args))
///
///     def expansions(self, args):
///         return max(self._args_as_int(args))
///
///
/// @inline_args
/// class EBNF_to_BNF(Transformer_InPlace):
///     def __init__(self):
///         self.new_rules = []
///         self.rules_cache = {}
///         self.prefix = 'anon'
///         self.i = 0
///         self.rule_options = None
///
///     def _name_rule(self, inner):
///         new_name = '__%s_%s_%d' % (self.prefix, inner, self.i)
///         self.i += 1
///         return new_name
///
///     def _add_rule(self, key, name, expansions):
///         t = NonTerminal(name)
///         self.new_rules.append((name, expansions, self.rule_options))
///         self.rules_cache[key] = t
///         return t
///
///     def _add_recurse_rule(self, type_, expr):
///         try:
///             return self.rules_cache[expr]
///         except KeyError:
///             new_name = self._name_rule(type_)
///             t = NonTerminal(new_name)
///             tree = ST('expansions', [
///                 ST('expansion', [expr]),
///                 ST('expansion', [t, expr])
///             ])
///             return self._add_rule(expr, new_name, tree)
///
///     def _add_repeat_rule(self, a, b, target, atom):
///         """Generate a rule that repeats target ``a`` times, and repeats atom ``b`` times.
///
///         When called recursively (into target), it repeats atom for x(n) times, where:
///             x(0) = 1
///             x(n) = a(n) * x(n-1) + b
///
///         Example rule when a=3, b=4:
///
///             new_rule: target target target atom atom atom atom
///
///         """
///         key = (a, b, target, atom)
///         try:
///             return self.rules_cache[key]
///         except KeyError:
///             new_name = self._name_rule('repeat_a%d_b%d' % (a, b))
///             tree = ST('expansions', [ST('expansion', [target] * a + [atom] * b)])
///             return self._add_rule(key, new_name, tree)
///
///     def _add_repeat_opt_rule(self, a, b, target, target_opt, atom):
///         """Creates a rule that matches atom 0 to (a*n+b)-1 times.
///
///         When target matches n times atom, and target_opt 0 to n-1 times target_opt,
///
///         First we generate target * i followed by target_opt, for i from 0 to a-1
///         These match 0 to n*a - 1 times atom
///
///         Then we generate target * a followed by atom * i, for i from 0 to b-1
///         These match n*a to n*a + b-1 times atom
///
///         The created rule will not have any shift/reduce conflicts so that it can be used with lalr
///
///         Example rule when a=3, b=4:
///
///             new_rule: target_opt
///                     | target target_opt
///                     | target target target_opt
///
///                     | target target target
///                     | target target target atom
///                     | target target target atom atom
///                     | target target target atom atom atom
///
///         """
///         key = (a, b, target, atom, "opt")
///         try:
///             return self.rules_cache[key]
///         except KeyError:
///             new_name = self._name_rule('repeat_a%d_b%d_opt' % (a, b))
///             tree = ST('expansions', [
///                 ST('expansion', [target]*i + [target_opt]) for i in range(a)
///             ] + [
///                 ST('expansion', [target]*a + [atom]*i) for i in range(b)
///             ])
///             return self._add_rule(key, new_name, tree)
///
///     def _generate_repeats(self, rule, mn, mx):
///         """Generates a rule tree that repeats ``rule`` exactly between ``mn`` to ``mx`` times.
///         """
///         # For a small number of repeats, we can take the naive approach
///         if mx < REPEAT_BREAK_THRESHOLD:
///             return ST('expansions', [ST('expansion', [rule] * n) for n in range(mn, mx + 1)])
///
///         # For large repeat values, we break the repetition into sub-rules.
///         # We treat ``rule~mn..mx`` as ``rule~mn rule~0..(diff=mx-mn)``.
///         # We then use small_factors to split up mn and diff up into values [(a, b), ...]
///         # This values are used with the help of _add_repeat_rule and _add_repeat_rule_opt
///         # to generate a complete rule/expression that matches the corresponding number of repeats
///         mn_target = rule
///         for a, b in small_factors(mn, SMALL_FACTOR_THRESHOLD):
///             mn_target = self._add_repeat_rule(a, b, mn_target, rule)
///         if mx == mn:
///             return mn_target
///
///         diff = mx - mn + 1  # We add one because _add_repeat_opt_rule generates rules that match one less
///         diff_factors = small_factors(diff, SMALL_FACTOR_THRESHOLD)
///         diff_target = rule  # Match rule 1 times
///         diff_opt_target = ST('expansion', [])  # match rule 0 times (e.g. up to 1 -1 times)
///         for a, b in diff_factors[:-1]:
///             diff_opt_target = self._add_repeat_opt_rule(a, b, diff_target, diff_opt_target, rule)
///             diff_target = self._add_repeat_rule(a, b, diff_target, rule)
///
///         a, b = diff_factors[-1]
///         diff_opt_target = self._add_repeat_opt_rule(a, b, diff_target, diff_opt_target, rule)
///
///         return ST('expansions', [ST('expansion', [mn_target] + [diff_opt_target])])
///
///     def expr(self, rule, op, *args):
///         if op.value == '?':
///             empty = ST('expansion', [])
///             return ST('expansions', [rule, empty])
///         elif op.value == '+':
///             # a : b c+ d
///             #   -->
///             # a : b _c d
///             # _c : _c c | c;
///             return self._add_recurse_rule('plus', rule)
///         elif op.value == '*':
///             # a : b c* d
///             #   -->
///             # a : b _c? d
///             # _c : _c c | c;
///             new_name = self._add_recurse_rule('star', rule)
///             return ST('expansions', [new_name, ST('expansion', [])])
///         elif op.value == '~':
///             if len(args) == 1:
///                 mn = mx = int(args[0])
///             else:
///                 mn, mx = map(int, args)
///                 if mx < mn or mn < 0:
///                     raise GrammarError("Bad Range for %s (%d..%d isn't allowed)" % (rule, mn, mx))
///
///             return self._generate_repeats(rule, mn, mx)
///
///         assert False, op
///
///     def maybe(self, rule):
///         keep_all_tokens = self.rule_options and self.rule_options.keep_all_tokens
///         rule_size = FindRuleSize(keep_all_tokens).transform(rule)
///         empty = ST('expansion', [_EMPTY] * rule_size)
///         return ST('expansions', [rule, empty])
///
///
/// class SimplifyRule_Visitor(Visitor):
///
///     @staticmethod
///     def _flatten(tree):
///         while tree.expand_kids_by_data(tree.data):
///             pass
///
///     def expansion(self, tree):
///         # rules_list unpacking
///         # a : b (c|d) e
///         #  -->
///         # a : b c e | b d e
///         #
///         # In AST terms:
///         # expansion(b, expansions(c, d), e)
///         #   -->
///         # expansions( expansion(b, c, e), expansion(b, d, e) )
///
///         self._flatten(tree)
///
///         for i, child in enumerate(tree.children):
///             if isinstance(child, Tree) and child.data == 'expansions':
///                 tree.data = 'expansions'
///                 tree.children = [self.visit(ST('expansion', [option if i == j else other
///                                                              for j, other in enumerate(tree.children)]))
///                                  for option in dedup_list(child.children)]
///                 self._flatten(tree)
///                 break
///
///     def alias(self, tree):
///         rule, alias_name = tree.children
///         if rule.data == 'expansions':
///             aliases = []
///             for child in tree.children[0].children:
///                 aliases.append(ST('alias', [child, alias_name]))
///             tree.data = 'expansions'
///             tree.children = aliases
///
///     def expansions(self, tree):
///         self._flatten(tree)
///         # Ensure all children are unique
///         if len(set(tree.children)) != len(tree.children):
///             tree.children = dedup_list(tree.children)   # dedup is expensive, so try to minimize its use
///
///
/// class RuleTreeToText(Transformer):
///     def expansions(self, x):
///         return x
///
///     def expansion(self, symbols):
///         return symbols, None
///
///     def alias(self, x):
///         (expansion, _alias), alias = x
///         assert _alias is None, (alias, expansion, '-', _alias)  # Double alias not allowed
///         return expansion, alias.name
///
///
/// class PrepareAnonTerminals(Transformer_InPlace):
///     """Create a unique list of anonymous terminals. Attempt to give meaningful names to them when we add them"""
///
///     def __init__(self, terminals):
///         self.terminals = terminals
///         self.term_set = {td.name for td in self.terminals}
///         self.term_reverse = {td.pattern: td for td in terminals}
///         self.i = 0
///         self.rule_options = None
///
///     @inline_args
///     def pattern(self, p):
///         value = p.value
///         if p in self.term_reverse and p.flags != self.term_reverse[p].pattern.flags:
///             raise GrammarError(u'Conflicting flags for the same terminal: %s' % p)
///
///         term_name = None
///
///         if isinstance(p, PatternStr):
///             try:
///                 # If already defined, use the user-defined terminal name
///                 term_name = self.term_reverse[p].name
///             except KeyError:
///                 # Try to assign an indicative anon-terminal name
///                 try:
///                     term_name = _TERMINAL_NAMES[value]
///                 except KeyError:
///                     if value and is_id_continue(value) and is_id_start(value[0]) and value.upper() not in self.term_set:
///                         term_name = value.upper()
///
///                 if term_name in self.term_set:
///                     term_name = None
///
///         elif isinstance(p, PatternRE):
///             if p in self.term_reverse:  # Kind of a weird placement.name
///                 term_name = self.term_reverse[p].name
///         else:
///             assert False, p
///
///         if term_name is None:
///             term_name = '__ANON_%d' % self.i
///             self.i += 1
///
///         if term_name not in self.term_set:
///             assert p not in self.term_reverse
///             self.term_set.add(term_name)
///             termdef = TerminalDef(term_name, p)
///             self.term_reverse[p] = termdef
///             self.terminals.append(termdef)
///
///         filter_out = False if self.rule_options and self.rule_options.keep_all_tokens else isinstance(p, PatternStr)
///
///         return Terminal(term_name, filter_out=filter_out)
///
///
/// class _ReplaceSymbols(Transformer_InPlace):
///     """Helper for ApplyTemplates"""
///
///     def __init__(self):
///         self.names = {}
///
///     def value(self, c):
///         if len(c) == 1 and isinstance(c[0], Symbol) and c[0].name in self.names:
///             return self.names[c[0].name]
///         return self.__default__('value', c, None)
///
///     def template_usage(self, c):
///         name = c[0].name
///         if name in self.names:
///             return self.__default__('template_usage', [self.names[name]] + c[1:], None)
///         return self.__default__('template_usage', c, None)
///
///
/// class ApplyTemplates(Transformer_InPlace):
///     """Apply the templates, creating new rules that represent the used templates"""
///
///     def __init__(self, rule_defs):
///         self.rule_defs = rule_defs
///         self.replacer = _ReplaceSymbols()
///         self.created_templates = set()
///
///     def template_usage(self, c):
///         name = c[0].name
///         args = c[1:]
///         result_name = "%s{%s}" % (name, ",".join(a.name for a in args))
///         if result_name not in self.created_templates:
///             self.created_templates.add(result_name)
///             (_n, params, tree, options) ,= (t for t in self.rule_defs if t[0] == name)
///             assert len(params) == len(args), args
///             result_tree = deepcopy(tree)
///             self.replacer.names = dict(zip(params, args))
///             self.replacer.transform(result_tree)
///             self.rule_defs.append((result_name, [], result_tree, deepcopy(options)))
///         return NonTerminal(result_name)
///
///
/// def _rfind(s, choices):
///     return max(s.rfind(c) for c in choices)
///
///
/// def eval_escaping(s):
///     w = ''
///     i = iter(s)
///     for n in i:
///         w += n
///         if n == '\\':
///             try:
///                 n2 = next(i)
///             except StopIteration:
///                 raise GrammarError("Literal ended unexpectedly (bad escaping): `%r`" % s)
///             if n2 == '\\':
///                 w += '\\\\'
///             elif n2 not in 'Uuxnftr':
///                 w += '\\'
///             w += n2
///     w = w.replace('\\"', '"').replace("'", "\\'")
///
///     to_eval = "u'''%s'''" % w
///     try:
///         s = literal_eval(to_eval)
///     except SyntaxError as e:
///         raise GrammarError(s, e)
///
///     return s
///
///
/// def _literal_to_pattern(literal):
///     assert isinstance(literal, Token)
///     v = literal.value
///     flag_start = _rfind(v, '/"')+1
///     assert flag_start > 0
///     flags = v[flag_start:]
///     assert all(f in _RE_FLAGS for f in flags), flags
///
///     if literal.type == 'STRING' and '\n' in v:
///         raise GrammarError('You cannot put newlines in string literals')
///
///     if literal.type == 'REGEXP' and '\n' in v and 'x' not in flags:
///         raise GrammarError('You can only use newlines in regular expressions '
///                            'with the `x` (verbose) flag')
///
///     v = v[:flag_start]
///     assert v[0] == v[-1] and v[0] in '"/'
///     x = v[1:-1]
///
///     s = eval_escaping(x)
///
///     if s == "":
///         raise GrammarError("Empty terminals are not allowed (%s)" % literal)
///
///     if literal.type == 'STRING':
///         s = s.replace('\\\\', '\\')
///         return PatternStr(s, flags, raw=literal.value)
///     elif literal.type == 'REGEXP':
///         return PatternRE(s, flags, raw=literal.value)
///     else:
///         assert False, 'Invariant failed: literal.type not in ["STRING", "REGEXP"]'
///
///
/// @inline_args
/// class PrepareLiterals(Transformer_InPlace):
///     def literal(self, literal):
///         return ST('pattern', [_literal_to_pattern(literal)])
///
///     def range(self, start, end):
///         assert start.type == end.type == 'STRING'
///         start = start.value[1:-1]
///         end = end.value[1:-1]
///         assert len(eval_escaping(start)) == len(eval_escaping(end)) == 1
///         regexp = '[%s-%s]' % (start, end)
///         return ST('pattern', [PatternRE(regexp)])
///
///
/// def _make_joined_pattern(regexp, flags_set):
///     return PatternRE(regexp, ())
///
/// class TerminalTreeToPattern(Transformer_NonRecursive):
///     def pattern(self, ps):
///         p ,= ps
///         return p
///
///     def expansion(self, items):
///         assert items
///         if len(items) == 1:
///             return items[0]
///
///         pattern = ''.join(i.to_regexp() for i in items)
///         return _make_joined_pattern(pattern, {i.flags for i in items})
///
///     def expansions(self, exps):
///         if len(exps) == 1:
///             return exps[0]
///
///         # Do a bit of sorting to make sure that the longest option is returned
///         # (Python's re module otherwise prefers just 'l' when given (l|ll) and both could match)
///         exps.sort(key=lambda x: (-x.max_width, -x.min_width, -len(x.value)))
///
///         pattern = '(?:%s)' % ('|'.join(i.to_regexp() for i in exps))
///         return _make_joined_pattern(pattern, {i.flags for i in exps})
///
///     def expr(self, args):
///         inner, op = args[:2]
///         if op == '~':
///             if len(args) == 3:
///                 op = "{%d}" % int(args[2])
///             else:
///                 mn, mx = map(int, args[2:])
///                 if mx < mn:
///                     raise GrammarError("Bad Range for %s (%d..%d isn't allowed)" % (inner, mn, mx))
///                 op = "{%d,%d}" % (mn, mx)
///         else:
///             assert len(args) == 2
///         return PatternRE('(?:%s)%s' % (inner.to_regexp(), op), inner.flags)
///
///     def maybe(self, expr):
///         return self.expr(expr + ['?'])
///
///     def alias(self, t):
///         raise GrammarError("Aliasing not allowed in terminals (You used -> in the wrong place)")
///
///     def value(self, v):
///         return v[0]
///
///
/// class ValidateSymbols(Transformer_InPlace):
///     def value(self, v):
///         v ,= v
///         assert isinstance(v, (Tree, Symbol))
///         return v
///
///
/// def nr_deepcopy_tree(t):
///     """Deepcopy tree `t` without recursion"""
///     return Transformer_NonRecursive(False).transform(t)
///
///
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
///
///
/// PackageResource = namedtuple('PackageResource', 'pkg_name path')
///
///
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
///
///
/// stdlib_loader = FromPackageLoader('lark', IMPORT_PATHS)
///
///
///
/// def resolve_term_references(term_dict):
///     # TODO Solve with transitive closure (maybe)
///
///     while True:
///         changed = False
///         for name, token_tree in term_dict.items():
///             if token_tree is None:  # Terminal added through %declare
///                 continue
///             for exp in token_tree.find_data('value'):
///                 item ,= exp.children
///                 if isinstance(item, NonTerminal):
///                     raise GrammarError("Rules aren't allowed inside terminals (%s in %s)" % (item, name))
///                 elif isinstance(item, Terminal):
///                     try:
///                         term_value = term_dict[item.name]
///                     except KeyError:
///                         raise GrammarError("Terminal used but not defined: %s" % item.name)
///                     assert term_value is not None
///                     exp.children[0] = term_value
///                     changed = True
///                 else:
///                     assert isinstance(item, Tree)
///         if not changed:
///             break
///
///     for name, term in term_dict.items():
///         if term:    # Not just declared
///             for child in term.children:
///                 ids = [id(x) for x in child.iter_subtrees()]
///                 if id(term) in ids:
///                     raise GrammarError("Recursion in terminal '%s' (recursion is only allowed in rules, not terminals)" % name)
///
///
///
/// def symbol_from_strcase(s):
///     assert isinstance(s, str)
///     return Terminal(s, filter_out=s.startswith('_')) if s.isupper() else NonTerminal(s)
///
/// @inline_args
/// class PrepareGrammar(Transformer_InPlace):
///     def terminal(self, name):
///         return Terminal(str(name), filter_out=name.startswith('_'))
///
///     def nonterminal(self, name):
///         return NonTerminal(name.value)
///
///
/// def _find_used_symbols(tree):
///     assert tree.data == 'expansions'
///     return {t.name for x in tree.find_data('expansion')
///             for t in x.scan_values(lambda t: isinstance(t, Symbol))}
///
///
/// def _get_parser():
///     try:
///         return _get_parser.cache
///     except AttributeError:
///         terminals = [TerminalDef(name, PatternRE(value)) for name, value in TERMINALS.items()]
///
///         rules = [(name.lstrip('?'), x, RuleOptions(expand1=name.startswith('?')))
///                 for name, x in RULES.items()]
///         rules = [Rule(NonTerminal(r), [symbol_from_strcase(s) for s in x.split()], i, None, o)
///                  for r, xs, o in rules for i, x in enumerate(xs)]
///
///         callback = ParseTreeBuilder(rules, ST).create_callback()
///         import re
///         lexer_conf = LexerConf(terminals, re, ['WS', 'COMMENT', 'BACKSLASH'])
///         parser_conf = ParserConf(rules, callback, ['start'])
///         lexer_conf.lexer_type = 'basic'
///         parser_conf.parser_type = 'lalr'
///         _get_parser.cache = ParsingFrontend(lexer_conf, parser_conf, None)
///         return _get_parser.cache
///
/// GRAMMAR_ERRORS = [
///         ('Incorrect type of value', ['a: 1\n']),
///         ('Unclosed parenthesis', ['a: (\n']),
///         ('Unmatched closing parenthesis', ['a: )\n', 'a: [)\n', 'a: (]\n']),
///         ('Expecting rule or terminal definition (missing colon)', ['a\n', 'A\n', 'a->\n', 'A->\n', 'a A\n']),
///         ('Illegal name for rules or terminals', ['Aa:\n']),
///         ('Alias expects lowercase name', ['a: -> "a"\n']),
///         ('Unexpected colon', ['a::\n', 'a: b:\n', 'a: B:\n', 'a: "a":\n']),
///         ('Misplaced operator', ['a: b??', 'a: b(?)', 'a:+\n', 'a:?\n', 'a:*\n', 'a:|*\n']),
///         ('Expecting option ("|") or a new rule or terminal definition', ['a:a\n()\n']),
///         ('Terminal names cannot contain dots', ['A.B\n']),
///         ('Expecting rule or terminal definition', ['"a"\n']),
///         ('%import expects a name', ['%import "a"\n']),
///         ('%ignore expects a value', ['%ignore %import\n']),
///     ]
///
/// def _translate_parser_exception(parse, e):
///         error = e.match_examples(parse, GRAMMAR_ERRORS, use_accepts=True)
///         if error:
///             return error
///         elif 'STRING' in e.expected:
///             return "Expecting a value"
///
/// def _parse_grammar(text, name, start='start'):
///     try:
///         tree = _get_parser().parse(text + '\n', start)
///     except UnexpectedCharacters as e:
///         context = e.get_context(text)
///         raise GrammarError("Unexpected input at line %d column %d in %s: \n\n%s" %
///                            (e.line, e.column, name, context))
///     except UnexpectedToken as e:
///         context = e.get_context(text)
///         error = _translate_parser_exception(_get_parser().parse, e)
///         if error:
///             raise GrammarError("%s, at line %s column %s\n\n%s" % (error, e.line, e.column, context))
///         raise
///
///     return PrepareGrammar().transform(tree)
///
///
/// def _error_repr(error):
///     if isinstance(error, UnexpectedToken):
///         error2 = _translate_parser_exception(_get_parser().parse, error)
///         if error2:
///             return error2
///         expected = ', '.join(error.accepts or error.expected)
///         return "Unexpected token %r. Expected one of: {%s}" % (str(error.token), expected)
///     else:
///         return str(error)
///
/// def _search_interactive_parser(interactive_parser, predicate):
///     def expand(node):
///         path, p = node
///         for choice in p.choices():
///             t = Token(choice, '')
///             try:
///                 new_p = p.feed_token(t)
///             except ParseError:    # Illegal
///                 pass
///             else:
///                 yield path + (choice,), new_p
///
///     for path, p in bfs_all_unique([((), interactive_parser)], expand):
///         if predicate(p):
///             return path, p
///
/// def find_grammar_errors(text: str, start: str='start') -> List[Tuple[UnexpectedInput, str]]:
///     errors = []
///     def on_error(e):
///         errors.append((e, _error_repr(e)))
///
///         # recover to a new line
///         token_path, _ = _search_interactive_parser(e.interactive_parser.as_immutable(), lambda p: '_NL' in p.choices())
///         for token_type in token_path:
///             e.interactive_parser.feed_token(Token(token_type, ''))
///         e.interactive_parser.feed_token(Token('_NL', '\n'))
///         return True
///
///     _tree = _get_parser().parse(text + '\n', start, on_error=on_error)
///
///     errors_by_line = classify(errors, lambda e: e[0].line)
///     errors = [el[0] for el in errors_by_line.values()]      # already sorted
///
///     for e in errors:
///         e[0].interactive_parser = None
///     return errors
///
///
/// def _get_mangle(prefix, aliases, base_mangle=None):
///     def mangle(s):
///         if s in aliases:
///             s = aliases[s]
///         else:
///             if s[0] == '_':
///                 s = '_%s__%s' % (prefix, s[1:])
///             else:
///                 s = '%s__%s' % (prefix, s)
///         if base_mangle is not None:
///             s = base_mangle(s)
///         return s
///     return mangle
///
/// def _mangle_definition_tree(exp, mangle):
///     if mangle is None:
///         return exp
///     exp = deepcopy(exp) # TODO: is this needed?
///     for t in exp.iter_subtrees():
///         for i, c in enumerate(t.children):
///             if isinstance(c, Symbol):
///                 t.children[i] = c.renamed(mangle)
///
///     return exp
///
/// def _make_rule_tuple(modifiers_tree, name, params, priority_tree, expansions):
///     if modifiers_tree.children:
///         m ,= modifiers_tree.children
///         expand1 = '?' in m
///         if expand1 and name.startswith('_'):
///             raise GrammarError("Inlined rules (_rule) cannot use the ?rule modifier.")
///         keep_all_tokens = '!' in m
///     else:
///         keep_all_tokens = False
///         expand1 = False
///
///     if priority_tree.children:
///         p ,= priority_tree.children
///         priority = int(p)
///     else:
///         priority = None
///
///     if params is not None:
///         params = [t.value for t in params.children]  # For the grammar parser
///
///     return name, params, expansions, RuleOptions(keep_all_tokens, expand1, priority=priority,
///                                                  template_source=(name if params else None))
///
///
/// class Definition:
///     def __init__(self, is_term, tree, params=(), options=None):
///         self.is_term = is_term
///         self.tree = tree
///         self.params = tuple(params)
///         self.options = options
///
/// class GrammarBuilder:
///
///     global_keep_all_tokens: bool
///     import_paths: List[Union[str, Callable]]
///     used_files: Dict[str, str]
///
///     _definitions: Dict[str, Definition]
///     _ignore_names: List[str]
///
///     def __init__(self, global_keep_all_tokens: bool=False, import_paths: Optional[List[Union[str, Callable]]]=None, used_files: Optional[Dict[str, str]]=None) -> None:
///         self.global_keep_all_tokens = global_keep_all_tokens
///         self.import_paths = import_paths or []
///         self.used_files = used_files or {}
///
///         self._definitions: Dict[str, Definition] = {}
///         self._ignore_names: List[str] = []
///
///     def _grammar_error(self, is_term, msg, *names):
///         args = {}
///         for i, name in enumerate(names, start=1):
///             postfix = '' if i == 1 else str(i)
///             args['name' + postfix] = name
///             args['type' + postfix] = lowercase_type = ("rule", "terminal")[is_term]
///             args['Type' + postfix] = lowercase_type.title()
///         raise GrammarError(msg.format(**args))
///
///     def _check_options(self, is_term, options):
///         if is_term:
///             if options is None:
///                 options = 1
///             elif not isinstance(options, int):
///                 raise GrammarError("Terminal require a single int as 'options' (e.g. priority), got %s" % (type(options),))
///         else:
///             if options is None:
///                 options = RuleOptions()
///             elif not isinstance(options, RuleOptions):
///                 raise GrammarError("Rules require a RuleOptions instance as 'options'")
///             if self.global_keep_all_tokens:
///                 options.keep_all_tokens = True
///         return options
///
///
///     def _define(self, name, is_term, exp, params=(), options=None, *, override=False):
///         if name in self._definitions:
///             if not override:
///                 self._grammar_error(is_term, "{Type} '{name}' defined more than once", name)
///         elif override:
///             self._grammar_error(is_term, "Cannot override a nonexisting {type} {name}", name)
///
///         if name.startswith('__'):
///             self._grammar_error(is_term, 'Names starting with double-underscore are reserved (Error at {name})', name)
///
///         self._definitions[name] = Definition(is_term, exp, params, self._check_options(is_term, options))
///
///     def _extend(self, name, is_term, exp, params=(), options=None):
///         if name not in self._definitions:
///             self._grammar_error(is_term, "Can't extend {type} {name} as it wasn't defined before", name)
///
///         d = self._definitions[name]
///
///         if is_term != d.is_term:
///             self._grammar_error(is_term, "Cannot extend {type} {name} - one is a terminal, while the other is not.", name)
///         if tuple(params) != d.params:
///             self._grammar_error(is_term, "Cannot extend {type} with different parameters: {name}", name)
///
///         if d.tree is None:
///             self._grammar_error(is_term, "Can't extend {type} {name} - it is abstract.", name)
///
///         # TODO: think about what to do with 'options'
///         base = d.tree
///
///         assert isinstance(base, Tree) and base.data == 'expansions'
///         base.children.insert(0, exp)
///
///     def _ignore(self, exp_or_name):
///         if isinstance(exp_or_name, str):
///             self._ignore_names.append(exp_or_name)
///         else:
///             assert isinstance(exp_or_name, Tree)
///             t = exp_or_name
///             if t.data == 'expansions' and len(t.children) == 1:
///                 t2 ,= t.children
///                 if t2.data=='expansion' and len(t2.children) == 1:
///                     item ,= t2.children
///                     if item.data == 'value':
///                         item ,= item.children
///                         if isinstance(item, Terminal):
///                             # Keep terminal name, no need to create a new definition
///                             self._ignore_names.append(item.name)
///                             return
///
///             name = '__IGNORE_%d'% len(self._ignore_names)
///             self._ignore_names.append(name)
///             self._definitions[name] = Definition(True, t, options=TOKEN_DEFAULT_PRIORITY)
///
///     def _unpack_import(self, stmt, grammar_name):
///         if len(stmt.children) > 1:
///             path_node, arg1 = stmt.children
///         else:
///             path_node, = stmt.children
///             arg1 = None
///
///         if isinstance(arg1, Tree):  # Multi import
///             dotted_path = tuple(path_node.children)
///             names = arg1.children
///             aliases = dict(zip(names, names))  # Can't have aliased multi import, so all aliases will be the same as names
///         else:  # Single import
///             dotted_path = tuple(path_node.children[:-1])
///             if not dotted_path:
///                 name ,= path_node.children
///                 raise GrammarError("Nothing was imported from grammar `%s`" % name)
///             name = path_node.children[-1]  # Get name from dotted path
///             aliases = {name.value: (arg1 or name).value}  # Aliases if exist
///
///         if path_node.data == 'import_lib':  # Import from library
///             base_path = None
///         else:  # Relative import
///             if grammar_name == '<string>':  # Import relative to script file path if grammar is coded in script
///                 try:
///                     base_file = os.path.abspath(sys.modules['__main__'].__file__)
///                 except AttributeError:
///                     base_file = None
///             else:
///                 base_file = grammar_name  # Import relative to grammar file path if external grammar file
///             if base_file:
///                 if isinstance(base_file, PackageResource):
///                     base_path = PackageResource(base_file.pkg_name, os.path.split(base_file.path)[0])
///                 else:
///                     base_path = os.path.split(base_file)[0]
///             else:
///                 base_path = os.path.abspath(os.path.curdir)
///
///         return dotted_path, base_path, aliases
///
///     def _unpack_definition(self, tree, mangle):
///
///         if tree.data == 'rule':
///             name, params, exp, opts = _make_rule_tuple(*tree.children)
///             is_term = False
///         else:
///             name = tree.children[0].value
///             params = ()     # TODO terminal templates
///             opts = int(tree.children[1]) if len(tree.children) == 3 else TOKEN_DEFAULT_PRIORITY # priority
///             exp = tree.children[-1]
///             is_term = True
///
///         if mangle is not None:
///             params = tuple(mangle(p) for p in params)
///             name = mangle(name)
///
///         exp = _mangle_definition_tree(exp, mangle)
///         return name, is_term, exp, params, opts
///
///
///     def load_grammar(self, grammar_text: str, grammar_name: str="<?>", mangle: Optional[Callable[[str], str]]=None) -> None:
///         tree = _parse_grammar(grammar_text, grammar_name)
///
///         imports: Dict[Tuple[str, ...], Tuple[Optional[str], Dict[str, str]]] = {}
///
///         for stmt in tree.children:
///             if stmt.data == 'import':
///                 dotted_path, base_path, aliases = self._unpack_import(stmt, grammar_name)
///                 try:
///                     import_base_path, import_aliases = imports[dotted_path]
///                     assert base_path == import_base_path, 'Inconsistent base_path for %s.' % '.'.join(dotted_path)
///                     import_aliases.update(aliases)
///                 except KeyError:
///                     imports[dotted_path] = base_path, aliases
///
///         for dotted_path, (base_path, aliases) in imports.items():
///             self.do_import(dotted_path, base_path, aliases, mangle)
///
///         for stmt in tree.children:
///             if stmt.data in ('term', 'rule'):
///                 self._define(*self._unpack_definition(stmt, mangle))
///             elif stmt.data == 'override':
///                 r ,= stmt.children
///                 self._define(*self._unpack_definition(r, mangle), override=True)
///             elif stmt.data == 'extend':
///                 r ,= stmt.children
///                 self._extend(*self._unpack_definition(r, mangle))
///             elif stmt.data == 'ignore':
///                 # if mangle is not None, we shouldn't apply ignore, since we aren't in a toplevel grammar
///                 if mangle is None:
///                     self._ignore(*stmt.children)
///             elif stmt.data == 'declare':
///                 for symbol in stmt.children:
///                     assert isinstance(symbol, Symbol), symbol
///                     is_term = isinstance(symbol, Terminal)
///                     if mangle is None:
///                         name = symbol.name
///                     else:
///                         name = mangle(symbol.name)
///                     self._define(name, is_term, None)
///             elif stmt.data == 'import':
///                 pass
///             else:
///                 assert False, stmt
///
///
///         term_defs = { name: d.tree
///             for name, d in self._definitions.items()
///             if d.is_term
///         }
///         resolve_term_references(term_defs)
///
///
///     def _remove_unused(self, used):
///         def rule_dependencies(symbol):
///             try:
///                 d = self._definitions[symbol]
///             except KeyError:
///                 return []
///             if d.is_term:
///                 return []
///             return _find_used_symbols(d.tree) - set(d.params)
///
///         _used = set(bfs(used, rule_dependencies))
///         self._definitions = {k: v for k, v in self._definitions.items() if k in _used}
///
///
///     def do_import(self, dotted_path: Tuple[str, ...], base_path: Optional[str], aliases: Dict[str, str], base_mangle: Optional[Callable[[str], str]]=None) -> None:
///         assert dotted_path
///         mangle = _get_mangle('__'.join(dotted_path), aliases, base_mangle)
///         grammar_path = os.path.join(*dotted_path) + EXT
///         to_try = self.import_paths + ([base_path] if base_path is not None else []) + [stdlib_loader]
///         for source in to_try:
///             try:
///                 if callable(source):
///                     joined_path, text = source(base_path, grammar_path)
///                 else:
///                     joined_path = os.path.join(source, grammar_path)
///                     with open(joined_path, encoding='utf8') as f:
///                         text = f.read()
///             except IOError:
///                 continue
///             else:
///                 h = md5_digest(text)
///                 if self.used_files.get(joined_path, h) != h:
///                     raise RuntimeError("Grammar file was changed during importing")
///                 self.used_files[joined_path] = h
///
///                 gb = GrammarBuilder(self.global_keep_all_tokens, self.import_paths, self.used_files)
///                 gb.load_grammar(text, joined_path, mangle)
///                 gb._remove_unused(map(mangle, aliases))
///                 for name in gb._definitions:
///                     if name in self._definitions:
///                         raise GrammarError("Cannot import '%s' from '%s': Symbol already defined." % (name, grammar_path))
///
///                 self._definitions.update(**gb._definitions)
///                 break
///         else:
///             # Search failed. Make Python throw a nice error.
///             open(grammar_path, encoding='utf8')
///             assert False, "Couldn't import grammar %s, but a corresponding file was found at a place where lark doesn't search for it" % (dotted_path,)
///
///
///     def validate(self) -> None:
///         for name, d in self._definitions.items():
///             params = d.params
///             exp = d.tree
///
///             for i, p in enumerate(params):
///                 if p in self._definitions:
///                     raise GrammarError("Template Parameter conflicts with rule %s (in template %s)" % (p, name))
///                 if p in params[:i]:
///                     raise GrammarError("Duplicate Template Parameter %s (in template %s)" % (p, name))
///
///             if exp is None: # Remaining checks don't apply to abstract rules/terminals (created with %declare)
///                 continue
///
///             for temp in exp.find_data('template_usage'):
///                 sym = temp.children[0].name
///                 args = temp.children[1:]
///                 if sym not in params:
///                     if sym not in self._definitions:
///                         self._grammar_error(d.is_term, "Template '%s' used but not defined (in {type} {name})" % sym, name)
///                     if len(args) != len(self._definitions[sym].params):
///                         expected, actual = len(self._definitions[sym].params), len(args)
///                         self._grammar_error(d.is_term, "Wrong number of template arguments used for {name} "
///                                             "(expected %s, got %s) (in {type2} {name2})" % (expected, actual), sym, name)
///
///             for sym in _find_used_symbols(exp):
///                 if sym not in self._definitions and sym not in params:
///                     self._grammar_error(d.is_term, "{Type} '{name}' used but not defined (in {type2} {name2})", sym, name)
///
///         if not set(self._definitions).issuperset(self._ignore_names):
///             raise GrammarError("Terminals %s were marked to ignore but were not defined!" % (set(self._ignore_names) - set(self._definitions)))
///
///     def build(self) -> Grammar:
///         self.validate()
///         rule_defs = []
///         term_defs = []
///         for name, d in self._definitions.items():
///             (params, exp, options) = d.params, d.tree, d.options
///             if d.is_term:
///                 assert len(params) == 0
///                 term_defs.append((name, (exp, options)))
///             else:
///                 rule_defs.append((name, params, exp, options))
///         # resolve_term_references(term_defs)
///         return Grammar(rule_defs, term_defs, self._ignore_names)
///
///
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
///         current = md5_digest(text)
///         if old != current:
///             logger.info("File %r changed, rebuilding Parser" % path)
///             return False
///     return True
///
/// def list_grammar_imports(grammar, import_paths=[]):
///     "Returns a list of paths to the lark grammars imported by the given grammar (recursively)"
///     builder = GrammarBuilder(False, import_paths)
///     builder.load_grammar(grammar, '<string>')
///     return list(builder.used_files.keys())
///
/// def load_grammar(grammar, source, import_paths, global_keep_all_tokens):
///     builder = GrammarBuilder(global_keep_all_tokens, import_paths)
///     builder.load_grammar(grammar, source)
///     return builder.build(), builder.used_files
///
///
/// def md5_digest(s: str) -> str:
///     """Get the md5 digest of a string
///
///     Supports the `usedforsecurity` argument for Python 3.9+ to allow running on
///     a FIPS-enabled system.
///     """
///     if sys.version_info >= (3, 9):
///         return hashlib.md5(s.encode('utf8'), usedforsecurity=False).hexdigest()
///     else:
///         return hashlib.md5(s.encode('utf8')).hexdigest()
/// ```
final class load_grammar extends PythonModule {
  load_grammar.from(super.pythonModule) : super.from();

  static load_grammar import() => PythonFfiDart.instance.importModule(
        "lark.load_grammar",
        load_grammar.from,
      );

  /// ## eval_escaping
  ///
  /// ### python source
  /// ```py
  /// def eval_escaping(s):
  ///     w = ''
  ///     i = iter(s)
  ///     for n in i:
  ///         w += n
  ///         if n == '\\':
  ///             try:
  ///                 n2 = next(i)
  ///             except StopIteration:
  ///                 raise GrammarError("Literal ended unexpectedly (bad escaping): `%r`" % s)
  ///             if n2 == '\\':
  ///                 w += '\\\\'
  ///             elif n2 not in 'Uuxnftr':
  ///                 w += '\\'
  ///             w += n2
  ///     w = w.replace('\\"', '"').replace("'", "\\'")
  ///
  ///     to_eval = "u'''%s'''" % w
  ///     try:
  ///         s = literal_eval(to_eval)
  ///     except SyntaxError as e:
  ///         raise GrammarError(s, e)
  ///
  ///     return s
  /// ```
  Object? eval_escaping({
    required Object? s,
  }) =>
      getFunction("eval_escaping").call(
        <Object?>[
          s,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## find_grammar_errors
  ///
  /// ### python source
  /// ```py
  /// def find_grammar_errors(text: str, start: str='start') -> List[Tuple[UnexpectedInput, str]]:
  ///     errors = []
  ///     def on_error(e):
  ///         errors.append((e, _error_repr(e)))
  ///
  ///         # recover to a new line
  ///         token_path, _ = _search_interactive_parser(e.interactive_parser.as_immutable(), lambda p: '_NL' in p.choices())
  ///         for token_type in token_path:
  ///             e.interactive_parser.feed_token(Token(token_type, ''))
  ///         e.interactive_parser.feed_token(Token('_NL', '\n'))
  ///         return True
  ///
  ///     _tree = _get_parser().parse(text + '\n', start, on_error=on_error)
  ///
  ///     errors_by_line = classify(errors, lambda e: e[0].line)
  ///     errors = [el[0] for el in errors_by_line.values()]      # already sorted
  ///
  ///     for e in errors:
  ///         e[0].interactive_parser = None
  ///     return errors
  /// ```
  Object? find_grammar_errors({
    required Object? text,
    Object? start = "start",
  }) =>
      getFunction("find_grammar_errors").call(
        <Object?>[
          text,
          start,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## list_grammar_imports
  ///
  /// ### python docstring
  ///
  /// Returns a list of paths to the lark grammars imported by the given grammar (recursively)
  ///
  /// ### python source
  /// ```py
  /// def list_grammar_imports(grammar, import_paths=[]):
  ///     "Returns a list of paths to the lark grammars imported by the given grammar (recursively)"
  ///     builder = GrammarBuilder(False, import_paths)
  ///     builder.load_grammar(grammar, '<string>')
  ///     return list(builder.used_files.keys())
  /// ```
  Object? list_grammar_imports({
    required Object? grammar,
    Object? import_paths = const [],
  }) =>
      getFunction("list_grammar_imports").call(
        <Object?>[
          grammar,
          import_paths,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## md5_digest
  ///
  /// ### python docstring
  ///
  /// Get the md5 digest of a string
  ///
  /// Supports the `usedforsecurity` argument for Python 3.9+ to allow running on
  /// a FIPS-enabled system.
  ///
  /// ### python source
  /// ```py
  /// def md5_digest(s: str) -> str:
  ///     """Get the md5 digest of a string
  ///
  ///     Supports the `usedforsecurity` argument for Python 3.9+ to allow running on
  ///     a FIPS-enabled system.
  ///     """
  ///     if sys.version_info >= (3, 9):
  ///         return hashlib.md5(s.encode('utf8'), usedforsecurity=False).hexdigest()
  ///     else:
  ///         return hashlib.md5(s.encode('utf8')).hexdigest()
  /// ```
  Object? md5_digest({
    required Object? s,
  }) =>
      getFunction("md5_digest").call(
        <Object?>[
          s,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## nr_deepcopy_tree
  ///
  /// ### python docstring
  ///
  /// Deepcopy tree `t` without recursion
  ///
  /// ### python source
  /// ```py
  /// def nr_deepcopy_tree(t):
  ///     """Deepcopy tree `t` without recursion"""
  ///     return Transformer_NonRecursive(False).transform(t)
  /// ```
  Object? nr_deepcopy_tree({
    required Object? t,
  }) =>
      getFunction("nr_deepcopy_tree").call(
        <Object?>[
          t,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## resolve_term_references
  ///
  /// ### python source
  /// ```py
  /// def resolve_term_references(term_dict):
  ///     # TODO Solve with transitive closure (maybe)
  ///
  ///     while True:
  ///         changed = False
  ///         for name, token_tree in term_dict.items():
  ///             if token_tree is None:  # Terminal added through %declare
  ///                 continue
  ///             for exp in token_tree.find_data('value'):
  ///                 item ,= exp.children
  ///                 if isinstance(item, NonTerminal):
  ///                     raise GrammarError("Rules aren't allowed inside terminals (%s in %s)" % (item, name))
  ///                 elif isinstance(item, Terminal):
  ///                     try:
  ///                         term_value = term_dict[item.name]
  ///                     except KeyError:
  ///                         raise GrammarError("Terminal used but not defined: %s" % item.name)
  ///                     assert term_value is not None
  ///                     exp.children[0] = term_value
  ///                     changed = True
  ///                 else:
  ///                     assert isinstance(item, Tree)
  ///         if not changed:
  ///             break
  ///
  ///     for name, term in term_dict.items():
  ///         if term:    # Not just declared
  ///             for child in term.children:
  ///                 ids = [id(x) for x in child.iter_subtrees()]
  ///                 if id(term) in ids:
  ///                     raise GrammarError("Recursion in terminal '%s' (recursion is only allowed in rules, not terminals)" % name)
  /// ```
  Object? resolve_term_references({
    required Object? term_dict,
  }) =>
      getFunction("resolve_term_references").call(
        <Object?>[
          term_dict,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## symbol_from_strcase
  ///
  /// ### python source
  /// ```py
  /// def symbol_from_strcase(s):
  ///     assert isinstance(s, str)
  ///     return Terminal(s, filter_out=s.startswith('_')) if s.isupper() else NonTerminal(s)
  /// ```
  Object? symbol_from_strcase({
    required Object? s,
  }) =>
      getFunction("symbol_from_strcase").call(
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
  ///         current = md5_digest(text)
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

  /// ## stdlib_loader (getter)
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
  Object? get stdlib_loader => getAttribute("stdlib_loader");

  /// ## stdlib_loader (setter)
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
  set stdlib_loader(Object? stdlib_loader) =>
      setAttribute("stdlib_loader", stdlib_loader);

  /// ## EXT (getter)
  Object? get EXT => getAttribute("EXT");

  /// ## EXT (setter)
  set EXT(Object? EXT) => setAttribute("EXT", EXT);

  /// ## GRAMMAR_ERRORS (getter)
  Object? get GRAMMAR_ERRORS => getAttribute("GRAMMAR_ERRORS");

  /// ## GRAMMAR_ERRORS (setter)
  set GRAMMAR_ERRORS(Object? GRAMMAR_ERRORS) =>
      setAttribute("GRAMMAR_ERRORS", GRAMMAR_ERRORS);

  /// ## IMPORT_PATHS (getter)
  Object? get IMPORT_PATHS => getAttribute("IMPORT_PATHS");

  /// ## IMPORT_PATHS (setter)
  set IMPORT_PATHS(Object? IMPORT_PATHS) =>
      setAttribute("IMPORT_PATHS", IMPORT_PATHS);

  /// ## REPEAT_BREAK_THRESHOLD (getter)
  Object? get REPEAT_BREAK_THRESHOLD => getAttribute("REPEAT_BREAK_THRESHOLD");

  /// ## REPEAT_BREAK_THRESHOLD (setter)
  set REPEAT_BREAK_THRESHOLD(Object? REPEAT_BREAK_THRESHOLD) =>
      setAttribute("REPEAT_BREAK_THRESHOLD", REPEAT_BREAK_THRESHOLD);

  /// ## RULES (getter)
  Object? get RULES => getAttribute("RULES");

  /// ## RULES (setter)
  set RULES(Object? RULES) => setAttribute("RULES", RULES);

  /// ## SMALL_FACTOR_THRESHOLD (getter)
  Object? get SMALL_FACTOR_THRESHOLD => getAttribute("SMALL_FACTOR_THRESHOLD");

  /// ## SMALL_FACTOR_THRESHOLD (setter)
  set SMALL_FACTOR_THRESHOLD(Object? SMALL_FACTOR_THRESHOLD) =>
      setAttribute("SMALL_FACTOR_THRESHOLD", SMALL_FACTOR_THRESHOLD);

  /// ## TERMINALS (getter)
  Object? get TERMINALS => getAttribute("TERMINALS");

  /// ## TERMINALS (setter)
  set TERMINALS(Object? TERMINALS) => setAttribute("TERMINALS", TERMINALS);

  /// ## TOKEN_DEFAULT_PRIORITY (getter)
  Object? get TOKEN_DEFAULT_PRIORITY => getAttribute("TOKEN_DEFAULT_PRIORITY");

  /// ## TOKEN_DEFAULT_PRIORITY (setter)
  set TOKEN_DEFAULT_PRIORITY(Object? TOKEN_DEFAULT_PRIORITY) =>
      setAttribute("TOKEN_DEFAULT_PRIORITY", TOKEN_DEFAULT_PRIORITY);
}

/// ## parse_tree_builder
///
/// ### python source
/// ```py
/// from typing import List
///
/// from .exceptions import GrammarError, ConfigurationError
/// from .lexer import Token
/// from .tree import Tree
/// from .visitors import Transformer_InPlace
/// from .visitors import _vargs_meta, _vargs_meta_inline
///
/// ###{standalone
/// from functools import partial, wraps
/// from itertools import product
///
///
/// class ExpandSingleChild:
///     def __init__(self, node_builder):
///         self.node_builder = node_builder
///
///     def __call__(self, children):
///         if len(children) == 1:
///             return children[0]
///         else:
///             return self.node_builder(children)
///
///
///
/// class PropagatePositions:
///     def __init__(self, node_builder, node_filter=None):
///         self.node_builder = node_builder
///         self.node_filter = node_filter
///
///     def __call__(self, children):
///         res = self.node_builder(children)
///
///         if isinstance(res, Tree):
///             # Calculate positions while the tree is streaming, according to the rule:
///             # - nodes start at the start of their first child's container,
///             #   and end at the end of their last child's container.
///             # Containers are nodes that take up space in text, but have been inlined in the tree.
///
///             res_meta = res.meta
///
///             first_meta = self._pp_get_meta(children)
///             if first_meta is not None:
///                 if not hasattr(res_meta, 'line'):
///                     # meta was already set, probably because the rule has been inlined (e.g. `?rule`)
///                     res_meta.line = getattr(first_meta, 'container_line', first_meta.line)
///                     res_meta.column = getattr(first_meta, 'container_column', first_meta.column)
///                     res_meta.start_pos = getattr(first_meta, 'container_start_pos', first_meta.start_pos)
///                     res_meta.empty = False
///
///                 res_meta.container_line = getattr(first_meta, 'container_line', first_meta.line)
///                 res_meta.container_column = getattr(first_meta, 'container_column', first_meta.column)
///
///             last_meta = self._pp_get_meta(reversed(children))
///             if last_meta is not None:
///                 if not hasattr(res_meta, 'end_line'):
///                     res_meta.end_line = getattr(last_meta, 'container_end_line', last_meta.end_line)
///                     res_meta.end_column = getattr(last_meta, 'container_end_column', last_meta.end_column)
///                     res_meta.end_pos = getattr(last_meta, 'container_end_pos', last_meta.end_pos)
///                     res_meta.empty = False
///
///                 res_meta.container_end_line = getattr(last_meta, 'container_end_line', last_meta.end_line)
///                 res_meta.container_end_column = getattr(last_meta, 'container_end_column', last_meta.end_column)
///
///         return res
///
///     def _pp_get_meta(self, children):
///         for c in children:
///             if self.node_filter is not None and not self.node_filter(c):
///                 continue
///             if isinstance(c, Tree):
///                 if not c.meta.empty:
///                     return c.meta
///             elif isinstance(c, Token):
///                 return c
///             elif hasattr(c, '__lark_meta__'):
///                 return c.__lark_meta__()
///
/// def make_propagate_positions(option):
///     if callable(option):
///         return partial(PropagatePositions, node_filter=option)
///     elif option is True:
///         return PropagatePositions
///     elif option is False:
///         return None
///
///     raise ConfigurationError('Invalid option for propagate_positions: %r' % option)
///
///
/// class ChildFilter:
///     def __init__(self, to_include, append_none, node_builder):
///         self.node_builder = node_builder
///         self.to_include = to_include
///         self.append_none = append_none
///
///     def __call__(self, children):
///         filtered = []
///
///         for i, to_expand, add_none in self.to_include:
///             if add_none:
///                 filtered += [None] * add_none
///             if to_expand:
///                 filtered += children[i].children
///             else:
///                 filtered.append(children[i])
///
///         if self.append_none:
///             filtered += [None] * self.append_none
///
///         return self.node_builder(filtered)
///
///
/// class ChildFilterLALR(ChildFilter):
///     """Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)"""
///
///     def __call__(self, children):
///         filtered = []
///         for i, to_expand, add_none in self.to_include:
///             if add_none:
///                 filtered += [None] * add_none
///             if to_expand:
///                 if filtered:
///                     filtered += children[i].children
///                 else:   # Optimize for left-recursion
///                     filtered = children[i].children
///             else:
///                 filtered.append(children[i])
///
///         if self.append_none:
///             filtered += [None] * self.append_none
///
///         return self.node_builder(filtered)
///
///
/// class ChildFilterLALR_NoPlaceholders(ChildFilter):
///     "Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)"
///     def __init__(self, to_include, node_builder):
///         self.node_builder = node_builder
///         self.to_include = to_include
///
///     def __call__(self, children):
///         filtered = []
///         for i, to_expand in self.to_include:
///             if to_expand:
///                 if filtered:
///                     filtered += children[i].children
///                 else:   # Optimize for left-recursion
///                     filtered = children[i].children
///             else:
///                 filtered.append(children[i])
///         return self.node_builder(filtered)
///
///
/// def _should_expand(sym):
///     return not sym.is_term and sym.name.startswith('_')
///
///
/// def maybe_create_child_filter(expansion, keep_all_tokens, ambiguous, _empty_indices: List[bool]):
///     # Prepare empty_indices as: How many Nones to insert at each index?
///     if _empty_indices:
///         assert _empty_indices.count(False) == len(expansion)
///         s = ''.join(str(int(b)) for b in _empty_indices)
///         empty_indices = [len(ones) for ones in s.split('0')]
///         assert len(empty_indices) == len(expansion)+1, (empty_indices, len(expansion))
///     else:
///         empty_indices = [0] * (len(expansion)+1)
///
///     to_include = []
///     nones_to_add = 0
///     for i, sym in enumerate(expansion):
///         nones_to_add += empty_indices[i]
///         if keep_all_tokens or not (sym.is_term and sym.filter_out):
///             to_include.append((i, _should_expand(sym), nones_to_add))
///             nones_to_add = 0
///
///     nones_to_add += empty_indices[len(expansion)]
///
///     if _empty_indices or len(to_include) < len(expansion) or any(to_expand for i, to_expand,_ in to_include):
///         if _empty_indices or ambiguous:
///             return partial(ChildFilter if ambiguous else ChildFilterLALR, to_include, nones_to_add)
///         else:
///             # LALR without placeholders
///             return partial(ChildFilterLALR_NoPlaceholders, [(i, x) for i,x,_ in to_include])
///
///
/// class AmbiguousExpander:
///     """Deal with the case where we're expanding children ('_rule') into a parent but the children
///        are ambiguous. i.e. (parent->_ambig->_expand_this_rule). In this case, make the parent itself
///        ambiguous with as many copies as there are ambiguous children, and then copy the ambiguous children
///        into the right parents in the right places, essentially shifting the ambiguity up the tree."""
///     def __init__(self, to_expand, tree_class, node_builder):
///         self.node_builder = node_builder
///         self.tree_class = tree_class
///         self.to_expand = to_expand
///
///     def __call__(self, children):
///         def _is_ambig_tree(t):
///             return hasattr(t, 'data') and t.data == '_ambig'
///
///         # -- When we're repeatedly expanding ambiguities we can end up with nested ambiguities.
///         #    All children of an _ambig node should be a derivation of that ambig node, hence
///         #    it is safe to assume that if we see an _ambig node nested within an ambig node
///         #    it is safe to simply expand it into the parent _ambig node as an alternative derivation.
///         ambiguous = []
///         for i, child in enumerate(children):
///             if _is_ambig_tree(child):
///                 if i in self.to_expand:
///                     ambiguous.append(i)
///
///                 child.expand_kids_by_data('_ambig')
///
///         if not ambiguous:
///             return self.node_builder(children)
///
///         expand = [child.children if i in ambiguous else (child,) for i, child in enumerate(children)]
///         return self.tree_class('_ambig', [self.node_builder(list(f)) for f in product(*expand)])
///
///
/// def maybe_create_ambiguous_expander(tree_class, expansion, keep_all_tokens):
///     to_expand = [i for i, sym in enumerate(expansion)
///                  if keep_all_tokens or ((not (sym.is_term and sym.filter_out)) and _should_expand(sym))]
///     if to_expand:
///         return partial(AmbiguousExpander, to_expand, tree_class)
///
///
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
///
///
///
/// def inplace_transformer(func):
///     @wraps(func)
///     def f(children):
///         # function name in a Transformer is a rule name.
///         tree = Tree(func.__name__, children)
///         return func(tree)
///     return f
///
///
/// def apply_visit_wrapper(func, name, wrapper):
///     if wrapper is _vargs_meta or wrapper is _vargs_meta_inline:
///         raise NotImplementedError("Meta args not supported for internal transformer")
///
///     @wraps(func)
///     def f(children):
///         return wrapper(func, name, children, None)
///     return f
///
///
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
///
/// ###}
/// ```
final class parse_tree_builder extends PythonModule {
  parse_tree_builder.from(super.pythonModule) : super.from();

  static parse_tree_builder import() => PythonFfiDart.instance.importModule(
        "lark.parse_tree_builder",
        parse_tree_builder.from,
      );

  /// ## apply_visit_wrapper
  ///
  /// ### python source
  /// ```py
  /// def apply_visit_wrapper(func, name, wrapper):
  ///     if wrapper is _vargs_meta or wrapper is _vargs_meta_inline:
  ///         raise NotImplementedError("Meta args not supported for internal transformer")
  ///
  ///     @wraps(func)
  ///     def f(children):
  ///         return wrapper(func, name, children, None)
  ///     return f
  /// ```
  Object? apply_visit_wrapper({
    required Object? func,
    required Object? name,
    required Object? wrapper,
  }) =>
      getFunction("apply_visit_wrapper").call(
        <Object?>[
          func,
          name,
          wrapper,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## inplace_transformer
  ///
  /// ### python source
  /// ```py
  /// def inplace_transformer(func):
  ///     @wraps(func)
  ///     def f(children):
  ///         # function name in a Transformer is a rule name.
  ///         tree = Tree(func.__name__, children)
  ///         return func(tree)
  ///     return f
  /// ```
  Object? inplace_transformer({
    required Object? func,
  }) =>
      getFunction("inplace_transformer").call(
        <Object?>[
          func,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## make_propagate_positions
  ///
  /// ### python source
  /// ```py
  /// def make_propagate_positions(option):
  ///     if callable(option):
  ///         return partial(PropagatePositions, node_filter=option)
  ///     elif option is True:
  ///         return PropagatePositions
  ///     elif option is False:
  ///         return None
  ///
  ///     raise ConfigurationError('Invalid option for propagate_positions: %r' % option)
  /// ```
  Object? make_propagate_positions({
    required Object? option,
  }) =>
      getFunction("make_propagate_positions").call(
        <Object?>[
          option,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## maybe_create_ambiguous_expander
  ///
  /// ### python source
  /// ```py
  /// def maybe_create_ambiguous_expander(tree_class, expansion, keep_all_tokens):
  ///     to_expand = [i for i, sym in enumerate(expansion)
  ///                  if keep_all_tokens or ((not (sym.is_term and sym.filter_out)) and _should_expand(sym))]
  ///     if to_expand:
  ///         return partial(AmbiguousExpander, to_expand, tree_class)
  /// ```
  Object? maybe_create_ambiguous_expander({
    required Object? tree_class,
    required Object? expansion,
    required Object? keep_all_tokens,
  }) =>
      getFunction("maybe_create_ambiguous_expander").call(
        <Object?>[
          tree_class,
          expansion,
          keep_all_tokens,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## maybe_create_child_filter
  ///
  /// ### python source
  /// ```py
  /// def maybe_create_child_filter(expansion, keep_all_tokens, ambiguous, _empty_indices: List[bool]):
  ///     # Prepare empty_indices as: How many Nones to insert at each index?
  ///     if _empty_indices:
  ///         assert _empty_indices.count(False) == len(expansion)
  ///         s = ''.join(str(int(b)) for b in _empty_indices)
  ///         empty_indices = [len(ones) for ones in s.split('0')]
  ///         assert len(empty_indices) == len(expansion)+1, (empty_indices, len(expansion))
  ///     else:
  ///         empty_indices = [0] * (len(expansion)+1)
  ///
  ///     to_include = []
  ///     nones_to_add = 0
  ///     for i, sym in enumerate(expansion):
  ///         nones_to_add += empty_indices[i]
  ///         if keep_all_tokens or not (sym.is_term and sym.filter_out):
  ///             to_include.append((i, _should_expand(sym), nones_to_add))
  ///             nones_to_add = 0
  ///
  ///     nones_to_add += empty_indices[len(expansion)]
  ///
  ///     if _empty_indices or len(to_include) < len(expansion) or any(to_expand for i, to_expand,_ in to_include):
  ///         if _empty_indices or ambiguous:
  ///             return partial(ChildFilter if ambiguous else ChildFilterLALR, to_include, nones_to_add)
  ///         else:
  ///             # LALR without placeholders
  ///             return partial(ChildFilterLALR_NoPlaceholders, [(i, x) for i,x,_ in to_include])
  /// ```
  Object? maybe_create_child_filter({
    required Object? expansion,
    required Object? keep_all_tokens,
    required Object? ambiguous,
    required Object? $_empty_indices,
  }) =>
      getFunction("maybe_create_child_filter").call(
        <Object?>[
          expansion,
          keep_all_tokens,
          ambiguous,
          $_empty_indices,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## parser_frontends
///
/// ### python source
/// ```py
/// from typing import Any, Callable, Dict, Tuple
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
///     def __init__(self, lexer_conf, parser_conf, options, parser=None):
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
///         try:
///             create_lexer = {
///                 'basic': create_basic_lexer,
///                 'contextual': create_contextual_lexer,
///             }[lexer_type]
///         except KeyError:
///             assert issubclass(lexer_type, Lexer), lexer_type
///             self.lexer = _wrap_lexer(lexer_type)(lexer_conf)
///         else:
///             self.lexer = create_lexer(lexer_conf, self.parser, lexer_conf.postlex, options)
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
///     def _make_lexer_thread(self, text):
///         cls = (self.options and self.options._plugins.get('LexerThread')) or LexerThread
///         return text if self.skip_lexer else cls.from_text(self.lexer, text)
///
///     def parse(self, text, start=None, on_error=None):
///         chosen_start = self._verify_start(start)
///         kw = {} if on_error is None else {'on_error': on_error}
///         stream = self._make_lexer_thread(text)
///         return self.parser.parse(stream, chosen_start, **kw)
///
///     def parse_interactive(self, text=None, start=None):
///         chosen_start = self._verify_start(start)
///         if self.parser_conf.parser_type != 'lalr':
///             raise ConfigurationError("parse_interactive() currently only works with parser='lalr' ")
///         stream = self._make_lexer_thread(text)
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
/// def create_basic_lexer(lexer_conf, parser, postlex, options):
///     cls = (options and options._plugins.get('BasicLexer')) or BasicLexer
///     return cls(lexer_conf)
///
/// def create_contextual_lexer(lexer_conf, parser, postlex, options):
///     cls = (options and options._plugins.get('ContextualLexer')) or ContextualLexer
///     states = {idx:list(t.keys()) for idx, t in parser._parse_table.states.items()}
///     always_accept = postlex.always_accept if postlex else ()
///     return cls(lexer_conf, states, always_accept=always_accept)
///
/// def create_lalr_parser(lexer_conf, parser_conf, options=None):
///     debug = options.debug if options else False
///     cls = (options and options._plugins.get('LALR_Parser')) or LALR_Parser
///     return cls(parser_conf, debug=debug)
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
/// def create_earley_parser__dynamic(lexer_conf, parser_conf, options=None, **kw):
///     if lexer_conf.callbacks:
///         raise GrammarError("Earley's dynamic lexer doesn't support lexer_callbacks.")
///
///     earley_matcher = EarleyRegexpMatcher(lexer_conf)
///     return xearley.Parser(lexer_conf, parser_conf, earley_matcher.match, **kw)
///
/// def _match_earley_basic(term, token):
///     return term.name == token.type
///
/// def create_earley_parser__basic(lexer_conf, parser_conf, options, **kw):
///     return earley.Parser(lexer_conf, parser_conf, _match_earley_basic, **kw)
///
/// def create_earley_parser(lexer_conf, parser_conf, options):
///     resolve_ambiguity = options.ambiguity == 'resolve'
///     debug = options.debug if options else False
///     tree_class = options.tree_class or Tree if options.ambiguity != 'forest' else None
///
///     extra = {}
///     if lexer_conf.lexer_type == 'dynamic':
///         f = create_earley_parser__dynamic
///     elif lexer_conf.lexer_type == 'dynamic_complete':
///         extra['complete_lex'] =True
///         f = create_earley_parser__dynamic
///     else:
///         f = create_earley_parser__basic
///
///     return f(lexer_conf, parser_conf, options, resolve_ambiguity=resolve_ambiguity, debug=debug, tree_class=tree_class, **extra)
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

  static parser_frontends import() => PythonFfiDart.instance.importModule(
        "lark.parser_frontends",
        parser_frontends.from,
      );

  /// ## create_basic_lexer
  ///
  /// ### python source
  /// ```py
  /// def create_basic_lexer(lexer_conf, parser, postlex, options):
  ///     cls = (options and options._plugins.get('BasicLexer')) or BasicLexer
  ///     return cls(lexer_conf)
  /// ```
  Object? create_basic_lexer({
    required Object? lexer_conf,
    required Object? parser,
    required Object? postlex,
    required Object? options,
  }) =>
      getFunction("create_basic_lexer").call(
        <Object?>[
          lexer_conf,
          parser,
          postlex,
          options,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## create_contextual_lexer
  ///
  /// ### python source
  /// ```py
  /// def create_contextual_lexer(lexer_conf, parser, postlex, options):
  ///     cls = (options and options._plugins.get('ContextualLexer')) or ContextualLexer
  ///     states = {idx:list(t.keys()) for idx, t in parser._parse_table.states.items()}
  ///     always_accept = postlex.always_accept if postlex else ()
  ///     return cls(lexer_conf, states, always_accept=always_accept)
  /// ```
  Object? create_contextual_lexer({
    required Object? lexer_conf,
    required Object? parser,
    required Object? postlex,
    required Object? options,
  }) =>
      getFunction("create_contextual_lexer").call(
        <Object?>[
          lexer_conf,
          parser,
          postlex,
          options,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## create_earley_parser
  ///
  /// ### python source
  /// ```py
  /// def create_earley_parser(lexer_conf, parser_conf, options):
  ///     resolve_ambiguity = options.ambiguity == 'resolve'
  ///     debug = options.debug if options else False
  ///     tree_class = options.tree_class or Tree if options.ambiguity != 'forest' else None
  ///
  ///     extra = {}
  ///     if lexer_conf.lexer_type == 'dynamic':
  ///         f = create_earley_parser__dynamic
  ///     elif lexer_conf.lexer_type == 'dynamic_complete':
  ///         extra['complete_lex'] =True
  ///         f = create_earley_parser__dynamic
  ///     else:
  ///         f = create_earley_parser__basic
  ///
  ///     return f(lexer_conf, parser_conf, options, resolve_ambiguity=resolve_ambiguity, debug=debug, tree_class=tree_class, **extra)
  /// ```
  Object? create_earley_parser({
    required Object? lexer_conf,
    required Object? parser_conf,
    required Object? options,
  }) =>
      getFunction("create_earley_parser").call(
        <Object?>[
          lexer_conf,
          parser_conf,
          options,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## create_earley_parser__basic
  ///
  /// ### python source
  /// ```py
  /// def create_earley_parser__basic(lexer_conf, parser_conf, options, **kw):
  ///     return earley.Parser(lexer_conf, parser_conf, _match_earley_basic, **kw)
  /// ```
  Object? create_earley_parser__basic({
    required Object? lexer_conf,
    required Object? parser_conf,
    required Object? options,
    Map<String, Object?> kw = const <String, Object?>{},
  }) =>
      getFunction("create_earley_parser__basic").call(
        <Object?>[
          lexer_conf,
          parser_conf,
          options,
        ],
        kwargs: <String, Object?>{
          ...kw,
        },
      );

  /// ## create_earley_parser__dynamic
  ///
  /// ### python source
  /// ```py
  /// def create_earley_parser__dynamic(lexer_conf, parser_conf, options=None, **kw):
  ///     if lexer_conf.callbacks:
  ///         raise GrammarError("Earley's dynamic lexer doesn't support lexer_callbacks.")
  ///
  ///     earley_matcher = EarleyRegexpMatcher(lexer_conf)
  ///     return xearley.Parser(lexer_conf, parser_conf, earley_matcher.match, **kw)
  /// ```
  Object? create_earley_parser__dynamic({
    required Object? lexer_conf,
    required Object? parser_conf,
    Object? options,
    Map<String, Object?> kw = const <String, Object?>{},
  }) =>
      getFunction("create_earley_parser__dynamic").call(
        <Object?>[
          lexer_conf,
          parser_conf,
          options,
        ],
        kwargs: <String, Object?>{
          ...kw,
        },
      );

  /// ## create_lalr_parser
  ///
  /// ### python source
  /// ```py
  /// def create_lalr_parser(lexer_conf, parser_conf, options=None):
  ///     debug = options.debug if options else False
  ///     cls = (options and options._plugins.get('LALR_Parser')) or LALR_Parser
  ///     return cls(parser_conf, debug=debug)
  /// ```
  Object? create_lalr_parser({
    required Object? lexer_conf,
    required Object? parser_conf,
    Object? options,
  }) =>
      getFunction("create_lalr_parser").call(
        <Object?>[
          lexer_conf,
          parser_conf,
          options,
        ],
        kwargs: <String, Object?>{},
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
/// try:
///     xrange
/// except NameError:
///     xrange = range
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
///     for l in xrange(2, len(s) + 1):
///         # Iterate over sub-sentences with the given length
///         for i in xrange(len(s) - l + 1):
///             # Choose partition of the sub-sentence in [1, l)
///             for p in xrange(i + 1, i + l):
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
///     """Removes 'rule' from 'g' without changing the langugage produced by 'g'."""
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
///     for i in xrange(1, len(rule.rhs) - 2):
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
/// class Parser:
///     def __init__(self, lexer_conf, parser_conf, term_matcher, resolve_ambiguity=True, debug=False, tree_class=Tree):
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
///         self.predictions = {}
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

/// ## parsers
final class parsers extends PythonModule {
  parsers.from(super.pythonModule) : super.from();

  static parsers import() => PythonFfiDart.instance.importModule(
        "lark.parsers",
        parsers.from,
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
/// from ..lexer import Token
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
///         if not self.paths_loaded: self.load_paths()
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
///     def __init__(self, parser_conf, debug=False):
///         self.debug = debug
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
///     N = {}
///     for x in X:
///         N[x] = 0
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
///     def __init__(self, parser_conf, debug=False):
///         GrammarAnalyzer.__init__(self, parser_conf, debug)
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
///                         if not rp.rule.expansion[j] in self.NULLABLE:
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
///             actions = {}
///             for la, next_state in state.transitions.items():
///                 actions[la] = (Shift, next_state.closure)
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
///                 if la in actions:
///                     if self.debug:
///                         logger.warning('Shift/Reduce conflict for terminal %s: (resolving as shift)', la.name)
///                         logger.warning(' * %s', list(rules)[0])
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
  ///     N = {}
  ///     for x in X:
  ///         N[x] = 0
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
  Object? get Reduce => getAttribute("Reduce");

  /// ## Reduce (setter)
  set Reduce(Object? Reduce) => setAttribute("Reduce", Reduce);

  /// ## Shift (getter)
  Object? get Shift => getAttribute("Shift");

  /// ## Shift (setter)
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
///         return self.parser.parse_from_state(self.parser_state, last_token=self.lexer_state.state.last_token)
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
/// from .lalr_analysis import LALR_Analyzer, Shift, Reduce, IntParseTable
/// from .lalr_interactive_parser import InteractiveParser
/// from lark.exceptions import UnexpectedCharacters, UnexpectedInput, UnexpectedToken
///
/// ###{standalone
///
/// class LALR_Parser(Serialize):
///     def __init__(self, parser_conf, debug=False):
///         analysis = LALR_Analyzer(parser_conf, debug=debug)
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

/// ## tree
///
/// ### python source
/// ```py
/// import sys
/// from copy import deepcopy
///
/// from typing import List, Callable, Iterator, Union, Optional, Generic, TypeVar, Any, TYPE_CHECKING
///
/// if TYPE_CHECKING:
///     from .lexer import TerminalDef, Token
///     import rich
///     if sys.version_info >= (3, 8):
///         from typing import Literal
///     else:
///         from typing_extensions import Literal
///
/// ###{standalone
/// from collections import OrderedDict
///
/// class Meta:
///
///     empty: bool
///     line: int
///     column: int
///     start_pos: int
///     end_line: int
///     end_column: int
///     end_pos: int
///     orig_expansion: 'List[TerminalDef]'
///     match_tree: bool
///
///     def __init__(self):
///         self.empty = True
///
///
/// _Leaf_T = TypeVar("_Leaf_T")
/// Branch = Union[_Leaf_T, 'Tree[_Leaf_T]']
///
///
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
///             meta attributes: line, column, start_pos, end_line, end_column, end_pos
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
///     def __rich__(self, parent:'rich.tree.Tree'=None) -> 'rich.tree.Tree':
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
///
///
/// ParseTree = Tree['Token']
///
///
/// class SlottedTree(Tree):
///     __slots__ = 'data', 'children', 'rule', '_meta'
///
///
/// def pydot__tree_to_png(tree: Tree, filename: str, rankdir: 'Literal["TB", "LR", "BT", "RL"]'="LR", **kwargs) -> None:
///     graph = pydot__tree_to_graph(tree, rankdir, **kwargs)
///     graph.write_png(filename)
///
///
/// def pydot__tree_to_dot(tree: Tree, filename, rankdir="LR", **kwargs):
///     graph = pydot__tree_to_graph(tree, rankdir, **kwargs)
///     graph.write(filename)
///
///
/// def pydot__tree_to_graph(tree: Tree, rankdir="LR", **kwargs):
///     """Creates a colorful image that represents the tree (data+children, without meta)
///
///     Possible values for `rankdir` are "TB", "LR", "BT", "RL", corresponding to
///     directed graphs drawn from top to bottom, from left to right, from bottom to
///     top, and from right to left, respectively.
///
///     `kwargs` can be any graph attribute (e. g. `dpi=200`). For a list of
///     possible attributes, see https://www.graphviz.org/doc/info/attrs.html.
///     """
///
///     import pydot  # type: ignore[import]
///     graph = pydot.Dot(graph_type='digraph', rankdir=rankdir, **kwargs)
///
///     i = [0]
///
///     def new_leaf(leaf):
///         node = pydot.Node(i[0], label=repr(leaf))
///         i[0] += 1
///         graph.add_node(node)
///         return node
///
///     def _to_pydot(subtree):
///         color = hash(subtree.data) & 0xffffff
///         color |= 0x808080
///
///         subnodes = [_to_pydot(child) if isinstance(child, Tree) else new_leaf(child)
///                     for child in subtree.children]
///         node = pydot.Node(i[0], style="filled", fillcolor="#%x" % color, label=subtree.data)
///         i[0] += 1
///         graph.add_node(node)
///
///         for subnode in subnodes:
///             graph.add_edge(pydot.Edge(node, subnode))
///
///         return node
///
///     _to_pydot(tree)
///     return graph
/// ```
final class tree extends PythonModule {
  tree.from(super.pythonModule) : super.from();

  static tree import() => PythonFfiDart.instance.importModule(
        "lark.tree",
        tree.from,
      );

  /// ## pydot__tree_to_dot
  ///
  /// ### python source
  /// ```py
  /// def pydot__tree_to_dot(tree: Tree, filename, rankdir="LR", **kwargs):
  ///     graph = pydot__tree_to_graph(tree, rankdir, **kwargs)
  ///     graph.write(filename)
  /// ```
  Object? pydot__tree_to_dot({
    required Object? tree,
    required Object? filename,
    Object? rankdir = "LR",
    Map<String, Object?> kwargs = const <String, Object?>{},
  }) =>
      getFunction("pydot__tree_to_dot").call(
        <Object?>[
          tree,
          filename,
          rankdir,
        ],
        kwargs: <String, Object?>{
          ...kwargs,
        },
      );

  /// ## pydot__tree_to_graph
  ///
  /// ### python docstring
  ///
  /// Creates a colorful image that represents the tree (data+children, without meta)
  ///
  /// Possible values for `rankdir` are "TB", "LR", "BT", "RL", corresponding to
  /// directed graphs drawn from top to bottom, from left to right, from bottom to
  /// top, and from right to left, respectively.
  ///
  /// `kwargs` can be any graph attribute (e. g. `dpi=200`). For a list of
  /// possible attributes, see https://www.graphviz.org/doc/info/attrs.html.
  ///
  /// ### python source
  /// ```py
  /// def pydot__tree_to_graph(tree: Tree, rankdir="LR", **kwargs):
  ///     """Creates a colorful image that represents the tree (data+children, without meta)
  ///
  ///     Possible values for `rankdir` are "TB", "LR", "BT", "RL", corresponding to
  ///     directed graphs drawn from top to bottom, from left to right, from bottom to
  ///     top, and from right to left, respectively.
  ///
  ///     `kwargs` can be any graph attribute (e. g. `dpi=200`). For a list of
  ///     possible attributes, see https://www.graphviz.org/doc/info/attrs.html.
  ///     """
  ///
  ///     import pydot  # type: ignore[import]
  ///     graph = pydot.Dot(graph_type='digraph', rankdir=rankdir, **kwargs)
  ///
  ///     i = [0]
  ///
  ///     def new_leaf(leaf):
  ///         node = pydot.Node(i[0], label=repr(leaf))
  ///         i[0] += 1
  ///         graph.add_node(node)
  ///         return node
  ///
  ///     def _to_pydot(subtree):
  ///         color = hash(subtree.data) & 0xffffff
  ///         color |= 0x808080
  ///
  ///         subnodes = [_to_pydot(child) if isinstance(child, Tree) else new_leaf(child)
  ///                     for child in subtree.children]
  ///         node = pydot.Node(i[0], style="filled", fillcolor="#%x" % color, label=subtree.data)
  ///         i[0] += 1
  ///         graph.add_node(node)
  ///
  ///         for subnode in subnodes:
  ///             graph.add_edge(pydot.Edge(node, subnode))
  ///
  ///         return node
  ///
  ///     _to_pydot(tree)
  ///     return graph
  /// ```
  Object? pydot__tree_to_graph({
    required Object? tree,
    Object? rankdir = "LR",
    Map<String, Object?> kwargs = const <String, Object?>{},
  }) =>
      getFunction("pydot__tree_to_graph").call(
        <Object?>[
          tree,
          rankdir,
        ],
        kwargs: <String, Object?>{
          ...kwargs,
        },
      );

  /// ## pydot__tree_to_png
  ///
  /// ### python source
  /// ```py
  /// def pydot__tree_to_png(tree: Tree, filename: str, rankdir: 'Literal["TB", "LR", "BT", "RL"]'="LR", **kwargs) -> None:
  ///     graph = pydot__tree_to_graph(tree, rankdir, **kwargs)
  ///     graph.write_png(filename)
  /// ```
  Object? pydot__tree_to_png({
    required Object? tree,
    required Object? filename,
    Object? rankdir = "LR",
    Map<String, Object?> kwargs = const <String, Object?>{},
  }) =>
      getFunction("pydot__tree_to_png").call(
        <Object?>[
          tree,
          filename,
          rankdir,
        ],
        kwargs: <String, Object?>{
          ...kwargs,
        },
      );

  /// ## ParseTree (getter)
  Object? get ParseTree => getAttribute("ParseTree");

  /// ## ParseTree (setter)
  set ParseTree(Object? ParseTree) => setAttribute("ParseTree", ParseTree);

  /// ## TYPE_CHECKING (getter)
  Object? get TYPE_CHECKING => getAttribute("TYPE_CHECKING");

  /// ## TYPE_CHECKING (setter)
  set TYPE_CHECKING(Object? TYPE_CHECKING) =>
      setAttribute("TYPE_CHECKING", TYPE_CHECKING);
}

/// ## utils
///
/// ### python source
/// ```py
/// import unicodedata
/// import os
/// from functools import reduce
/// from collections import deque
/// from typing import Callable, Iterator, List, Optional, Tuple, Type, TypeVar, Union, Dict, Any, Sequence
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
/// def classify(seq: Sequence, key: Optional[Callable] = None, value: Optional[Callable] = None) -> Dict:
///     d: Dict[Any, Any] = {}
///     for item in seq:
///         k = key(item) if (key is not None) else item
///         v = value(item) if (value is not None) else item
///         if k in d:
///             d[k].append(v)
///         else:
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
///     # 2x faster (ordered in PyPy and CPython 3.6+, gaurenteed to be ordered in Python 3.7+)
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
///     Accepts a list of alternatives, and enumerates all their possible concatinations.
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
///     init = [[x] for x in lists[0]]
///     return reduce(lambda a,b: [i+[j] for i in a for j in b], lists[1:], init)
///
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
///     true_elems = []
///     false_elems = []
///
///     for elem in seq:
///         if pred(elem):
///             true_elems.append(elem)
///         else:
///             false_elems.append(elem)
///
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
  Object? bfs({
    required Object? initial,
    required Object? expand,
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
  /// def classify(seq: Sequence, key: Optional[Callable] = None, value: Optional[Callable] = None) -> Dict:
  ///     d: Dict[Any, Any] = {}
  ///     for item in seq:
  ///         k = key(item) if (key is not None) else item
  ///         v = value(item) if (value is not None) else item
  ///         if k in d:
  ///             d[k].append(v)
  ///         else:
  ///             d[k] = [v]
  ///     return d
  /// ```
  Object? classify({
    required Object? seq,
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
  ///     true_elems = []
  ///     false_elems = []
  ///
  ///     for elem in seq:
  ///         if pred(elem):
  ///             true_elems.append(elem)
  ///         else:
  ///             false_elems.append(elem)
  ///
  ///     return true_elems, false_elems
  /// ```
  Object? classify_bool({
    required Object? seq,
    required Object? pred,
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
  /// Accepts a list of alternatives, and enumerates all their possible concatinations.
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
  ///     Accepts a list of alternatives, and enumerates all their possible concatinations.
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
  ///     init = [[x] for x in lists[0]]
  ///     return reduce(lambda a,b: [i+[j] for i in a for j in b], lists[1:], init)
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
  ///     # 2x faster (ordered in PyPy and CPython 3.6+, gaurenteed to be ordered in Python 3.7+)
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
    required Object? expr,
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
  Object? is_id_continue({
    required Object? s,
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
  Object? is_id_start({
    required Object? s,
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
  Object? isascii({
    required Object? s,
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
    required Object? n,
    required Object? max_factor,
  }) =>
      getFunction("small_factors").call(
        <Object?>[
          n,
          max_factor,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## T (getter)
  ///
  /// ### python docstring
  ///
  /// Type variable.
  ///
  /// Usage::
  ///
  ///   T = TypeVar('T')  # Can be anything
  ///   A = TypeVar('A', str, bytes)  # Must be str or bytes
  ///
  /// Type variables exist primarily for the benefit of static type
  /// checkers.  They serve as the parameters for generic types as well
  /// as for generic function definitions.  See class Generic for more
  /// information on generic types.  Generic functions work as follows:
  ///
  ///   def repeat(x: T, n: int) -> List[T]:
  ///       '''Return a list containing n references to x.'''
  ///       return [x]*n
  ///
  ///   def longest(x: A, y: A) -> A:
  ///       '''Return the longest of two strings.'''
  ///       return x if len(x) >= len(y) else y
  ///
  /// The latter example's signature is essentially the overloading
  /// of (str, str) -> str and (bytes, bytes) -> bytes.  Also note
  /// that if the arguments are instances of some subclass of str,
  /// the return type is still plain str.
  ///
  /// At runtime, isinstance(x, T) and issubclass(C, T) will raise TypeError.
  ///
  /// Type variables defined with covariant=True or contravariant=True
  /// can be used to declare covariant or contravariant generic types.
  /// See PEP 484 for more details. By default generic types are invariant
  /// in all type variables.
  ///
  /// Type variables can be introspected. e.g.:
  ///
  ///   T.__name__ == 'T'
  ///   T.__constraints__ == ()
  ///   T.__covariant__ == False
  ///   T.__contravariant__ = False
  ///   A.__constraints__ == (str, bytes)
  ///
  /// Note that only type variables defined in global scope can be pickled.
  Object? get T => getAttribute("T");

  /// ## T (setter)
  ///
  /// ### python docstring
  ///
  /// Type variable.
  ///
  /// Usage::
  ///
  ///   T = TypeVar('T')  # Can be anything
  ///   A = TypeVar('A', str, bytes)  # Must be str or bytes
  ///
  /// Type variables exist primarily for the benefit of static type
  /// checkers.  They serve as the parameters for generic types as well
  /// as for generic function definitions.  See class Generic for more
  /// information on generic types.  Generic functions work as follows:
  ///
  ///   def repeat(x: T, n: int) -> List[T]:
  ///       '''Return a list containing n references to x.'''
  ///       return [x]*n
  ///
  ///   def longest(x: A, y: A) -> A:
  ///       '''Return the longest of two strings.'''
  ///       return x if len(x) >= len(y) else y
  ///
  /// The latter example's signature is essentially the overloading
  /// of (str, str) -> str and (bytes, bytes) -> bytes.  Also note
  /// that if the arguments are instances of some subclass of str,
  /// the return type is still plain str.
  ///
  /// At runtime, isinstance(x, T) and issubclass(C, T) will raise TypeError.
  ///
  /// Type variables defined with covariant=True or contravariant=True
  /// can be used to declare covariant or contravariant generic types.
  /// See PEP 484 for more details. By default generic types are invariant
  /// in all type variables.
  ///
  /// Type variables can be introspected. e.g.:
  ///
  ///   T.__name__ == 'T'
  ///   T.__constraints__ == ()
  ///   T.__covariant__ == False
  ///   T.__contravariant__ = False
  ///   A.__constraints__ == (str, bytes)
  ///
  /// Note that only type variables defined in global scope can be pickled.
  set T(Object? T) => setAttribute("T", T);
}

/// ## unicodedata
final class unicodedata extends PythonModule {
  unicodedata.from(super.pythonModule) : super.from();

  static unicodedata import() => PythonFfiDart.instance.importModule(
        "unicodedata",
        unicodedata.from,
      );

  /// ## ucd_3_2_0 (getter)
  Object? get ucd_3_2_0 => getAttribute("ucd_3_2_0");

  /// ## ucd_3_2_0 (setter)
  set ucd_3_2_0(Object? ucd_3_2_0) => setAttribute("ucd_3_2_0", ucd_3_2_0);

  /// ## unidata_version (getter)
  Object? get unidata_version => getAttribute("unidata_version");

  /// ## unidata_version (setter)
  set unidata_version(Object? unidata_version) =>
      setAttribute("unidata_version", unidata_version);
}

/// ## visitors
///
/// ### python source
/// ```py
/// from typing import TypeVar, Tuple, List, Callable, Generic, Type, Union, Optional, Any, cast
/// from abc import ABC
///
/// from .utils import combine_alternatives
/// from .tree import Tree, Branch
/// from .exceptions import VisitError, GrammarError
/// from .lexer import Token
///
/// ###{standalone
/// from functools import wraps, update_wrapper
/// from inspect import getmembers, getmro
///
/// _Return_T = TypeVar('_Return_T')
/// _Return_V = TypeVar('_Return_V')
/// _Leaf_T = TypeVar('_Leaf_T')
/// _Leaf_U = TypeVar('_Leaf_U')
/// _R = TypeVar('_R')
/// _FUNC = Callable[..., _Return_T]
/// _DECORATED = Union[_FUNC, type]
///
/// class _DiscardType:
///     """When the Discard value is returned from a transformer callback,
///     that node is discarded and won't appear in the parent.
///
///     Note:
///         This feature is disabled when the transformer is provided to Lark
///         using the ``transformer`` keyword (aka Tree-less LALR mode).
///
///     Example:
///         ::
///
///             class T(Transformer):
///                 def ignore_tree(self, children):
///                     return Discard
///
///                 def IGNORE_TOKEN(self, token):
///                     return Discard
///     """
///
///     def __repr__(self):
///         return "lark.visitors.Discard"
///
/// Discard = _DiscardType()
///
/// # Transformers
///
/// class _Decoratable:
///     "Provides support for decorating methods with @v_args"
///
///     @classmethod
///     def _apply_v_args(cls, visit_wrapper):
///         mro = getmro(cls)
///         assert mro[0] is cls
///         libmembers = {name for _cls in mro[1:] for name, _ in getmembers(_cls)}
///         for name, value in getmembers(cls):
///
///             # Make sure the function isn't inherited (unless it's overwritten)
///             if name.startswith('_') or (name in libmembers and name not in cls.__dict__):
///                 continue
///             if not callable(value):
///                 continue
///
///             # Skip if v_args already applied (at the function level)
///             if isinstance(cls.__dict__[name], _VArgsWrapper):
///                 continue
///
///             setattr(cls, name, _VArgsWrapper(cls.__dict__[name], visit_wrapper))
///         return cls
///
///     def __class_getitem__(cls, _):
///         return cls
///
///
/// class Transformer(_Decoratable, ABC, Generic[_Leaf_T, _Return_T]):
///     """Transformers work bottom-up (or depth-first), starting with visiting the leaves and working
///     their way up until ending at the root of the tree.
///
///     For each node visited, the transformer will call the appropriate method (callbacks), according to the
///     node's ``data``, and use the returned value to replace the node, thereby creating a new tree structure.
///
///     Transformers can be used to implement map & reduce patterns. Because nodes are reduced from leaf to root,
///     at any point the callbacks may assume the children have already been transformed (if applicable).
///
///     If the transformer cannot find a method with the right name, it will instead call ``__default__``, which by
///     default creates a copy of the node.
///
///     To discard a node, return Discard (``lark.visitors.Discard``).
///
///     ``Transformer`` can do anything ``Visitor`` can do, but because it reconstructs the tree,
///     it is slightly less efficient.
///
///     A transformer without methods essentially performs a non-memoized partial deepcopy.
///
///     All these classes implement the transformer interface:
///
///     - ``Transformer`` - Recursively transforms the tree. This is the one you probably want.
///     - ``Transformer_InPlace`` - Non-recursive. Changes the tree in-place instead of returning new instances
///     - ``Transformer_InPlaceRecursive`` - Recursive. Changes the tree in-place instead of returning new instances
///
///     Parameters:
///         visit_tokens (bool, optional): Should the transformer visit tokens in addition to rules.
///                                        Setting this to ``False`` is slightly faster. Defaults to ``True``.
///                                        (For processing ignored tokens, use the ``lexer_callbacks`` options)
///
///     """
///     __visit_tokens__ = True   # For backwards compatibility
///
///     def __init__(self,  visit_tokens: bool=True) -> None:
///         self.__visit_tokens__ = visit_tokens
///
///     def _call_userfunc(self, tree, new_children=None):
///         # Assumes tree is already transformed
///         children = new_children if new_children is not None else tree.children
///         try:
///             f = getattr(self, tree.data)
///         except AttributeError:
///             return self.__default__(tree.data, children, tree.meta)
///         else:
///             try:
///                 wrapper = getattr(f, 'visit_wrapper', None)
///                 if wrapper is not None:
///                     return f.visit_wrapper(f, tree.data, children, tree.meta)
///                 else:
///                     return f(children)
///             except GrammarError:
///                 raise
///             except Exception as e:
///                 raise VisitError(tree.data, tree, e)
///
///     def _call_userfunc_token(self, token):
///         try:
///             f = getattr(self, token.type)
///         except AttributeError:
///             return self.__default_token__(token)
///         else:
///             try:
///                 return f(token)
///             except GrammarError:
///                 raise
///             except Exception as e:
///                 raise VisitError(token.type, token, e)
///
///     def _transform_children(self, children):
///         for c in children:
///             if isinstance(c, Tree):
///                 res = self._transform_tree(c)
///             elif self.__visit_tokens__ and isinstance(c, Token):
///                 res = self._call_userfunc_token(c)
///             else:
///                 res = c
///
///             if res is not Discard:
///                 yield res
///
///     def _transform_tree(self, tree):
///         children = list(self._transform_children(tree.children))
///         return self._call_userfunc(tree, children)
///
///     def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         "Transform the given tree, and return the final result"
///         return self._transform_tree(tree)
///
///     def __mul__(
///             self: 'Transformer[_Leaf_T, Tree[_Leaf_U]]',
///             other: 'Union[Transformer[_Leaf_U, _Return_V], TransformerChain[_Leaf_U, _Return_V,]]'
///     ) -> 'TransformerChain[_Leaf_T, _Return_V]':
///         """Chain two transformers together, returning a new transformer.
///         """
///         return TransformerChain(self, other)
///
///     def __default__(self, data, children, meta):
///         """Default function that is called if there is no attribute matching ``data``
///
///         Can be overridden. Defaults to creating a new copy of the tree node (i.e. ``return Tree(data, children, meta)``)
///         """
///         return Tree(data, children, meta)
///
///     def __default_token__(self, token):
///         """Default function that is called if there is no attribute matching ``token.type``
///
///         Can be overridden. Defaults to returning the token as-is.
///         """
///         return token
///
///
/// def merge_transformers(base_transformer=None, **transformers_to_merge):
///     """Merge a collection of transformers into the base_transformer, each into its own 'namespace'.
///
///     When called, it will collect the methods from each transformer, and assign them to base_transformer,
///     with their name prefixed with the given keyword, as ``prefix__methodname``.
///
///     This function is especially useful for processing grammars that import other grammars,
///     thereby creating some of their rules in a 'namespace'. (i.e with a consistent name prefix).
///     In this case, the key for the transformer should match the name of the imported grammar.
///
///     Parameters:
///         base_transformer (Transformer, optional): The transformer that all other transformers will be added to.
///         **transformers_to_merge: Keyword arguments, in the form of ``name_prefix = transformer``.
///
///     Raises:
///         AttributeError: In case of a name collision in the merged methods
///
///     Example:
///         ::
///
///             class TBase(Transformer):
///                 def start(self, children):
///                     return children[0] + 'bar'
///
///             class TImportedGrammar(Transformer):
///                 def foo(self, children):
///                     return "foo"
///
///             composed_transformer = merge_transformers(TBase(), imported=TImportedGrammar())
///
///             t = Tree('start', [ Tree('imported__foo', []) ])
///
///             assert composed_transformer.transform(t) == 'foobar'
///
///     """
///     if base_transformer is None:
///         base_transformer = Transformer()
///     for prefix, transformer in transformers_to_merge.items():
///         for method_name in dir(transformer):
///             method = getattr(transformer, method_name)
///             if not callable(method):
///                 continue
///             if method_name.startswith("_") or method_name == "transform":
///                 continue
///             prefixed_method = prefix + "__" + method_name
///             if hasattr(base_transformer, prefixed_method):
///                 raise AttributeError("Cannot merge: method '%s' appears more than once" % prefixed_method)
///
///             setattr(base_transformer, prefixed_method, method)
///
///     return base_transformer
///
///
/// class InlineTransformer(Transformer):   # XXX Deprecated
///     def _call_userfunc(self, tree, new_children=None):
///         # Assumes tree is already transformed
///         children = new_children if new_children is not None else tree.children
///         try:
///             f = getattr(self, tree.data)
///         except AttributeError:
///             return self.__default__(tree.data, children, tree.meta)
///         else:
///             return f(*children)
///
///
/// class TransformerChain(Generic[_Leaf_T, _Return_T]):
///
///     transformers: 'Tuple[Union[Transformer, TransformerChain], ...]'
///
///     def __init__(self, *transformers: 'Union[Transformer, TransformerChain]') -> None:
///         self.transformers = transformers
///
///     def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         for t in self.transformers:
///             tree = t.transform(tree)
///         return cast(_Return_T, tree)
///
///     def __mul__(
///             self: 'TransformerChain[_Leaf_T, Tree[_Leaf_U]]',
///             other: 'Union[Transformer[_Leaf_U, _Return_V], TransformerChain[_Leaf_U, _Return_V]]'
///     ) -> 'TransformerChain[_Leaf_T, _Return_V]':
///         return TransformerChain(*self.transformers + (other,))
///
///
/// class Transformer_InPlace(Transformer):
///     """Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
///
///     Useful for huge trees. Conservative in memory.
///     """
///     def _transform_tree(self, tree):           # Cancel recursion
///         return self._call_userfunc(tree)
///
///     def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         for subtree in tree.iter_subtrees():
///             subtree.children = list(self._transform_children(subtree.children))
///
///         return self._transform_tree(tree)
///
///
/// class Transformer_NonRecursive(Transformer):
///     """Same as Transformer but non-recursive.
///
///     Like Transformer, it doesn't change the original tree.
///
///     Useful for huge trees.
///     """
///
///     def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         # Tree to postfix
///         rev_postfix = []
///         q: List[Branch[_Leaf_T]] = [tree]
///         while q:
///             t = q.pop()
///             rev_postfix.append(t)
///             if isinstance(t, Tree):
///                 q += t.children
///
///         # Postfix to tree
///         stack: List = []
///         for x in reversed(rev_postfix):
///             if isinstance(x, Tree):
///                 size = len(x.children)
///                 if size:
///                     args = stack[-size:]
///                     del stack[-size:]
///                 else:
///                     args = []
///
///                 res = self._call_userfunc(x, args)
///                 if res is not Discard:
///                     stack.append(res)
///
///             elif self.__visit_tokens__ and isinstance(x, Token):
///                 res = self._call_userfunc_token(x)
///                 if res is not Discard:
///                     stack.append(res)
///             else:
///                 stack.append(x)
///
///         result, = stack  # We should have only one tree remaining
///         # There are no guarantees on the type of the value produced by calling a user func for a
///         # child will produce. This means type system can't statically know that the final result is
///         # _Return_T. As a result a cast is required.
///         return cast(_Return_T, result)
///
///
/// class Transformer_InPlaceRecursive(Transformer):
///     "Same as Transformer, recursive, but changes the tree in-place instead of returning new instances"
///     def _transform_tree(self, tree):
///         tree.children = list(self._transform_children(tree.children))
///         return self._call_userfunc(tree)
///
///
/// # Visitors
///
/// class VisitorBase:
///     def _call_userfunc(self, tree):
///         return getattr(self, tree.data, self.__default__)(tree)
///
///     def __default__(self, tree):
///         """Default function that is called if there is no attribute matching ``tree.data``
///
///         Can be overridden. Defaults to doing nothing.
///         """
///         return tree
///
///     def __class_getitem__(cls, _):
///         return cls
///
///
/// class Visitor(VisitorBase, ABC, Generic[_Leaf_T]):
///     """Tree visitor, non-recursive (can handle huge trees).
///
///     Visiting a node calls its methods (provided by the user via inheritance) according to ``tree.data``
///     """
///
///     def visit(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
///         "Visits the tree, starting with the leaves and finally the root (bottom-up)"
///         for subtree in tree.iter_subtrees():
///             self._call_userfunc(subtree)
///         return tree
///
///     def visit_topdown(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
///         "Visit the tree, starting at the root, and ending at the leaves (top-down)"
///         for subtree in tree.iter_subtrees_topdown():
///             self._call_userfunc(subtree)
///         return tree
///
///
/// class Visitor_Recursive(VisitorBase, Generic[_Leaf_T]):
///     """Bottom-up visitor, recursive.
///
///     Visiting a node calls its methods (provided by the user via inheritance) according to ``tree.data``
///
///     Slightly faster than the non-recursive version.
///     """
///
///     def visit(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
///         "Visits the tree, starting with the leaves and finally the root (bottom-up)"
///         for child in tree.children:
///             if isinstance(child, Tree):
///                 self.visit(child)
///
///         self._call_userfunc(tree)
///         return tree
///
///     def visit_topdown(self,tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
///         "Visit the tree, starting at the root, and ending at the leaves (top-down)"
///         self._call_userfunc(tree)
///
///         for child in tree.children:
///             if isinstance(child, Tree):
///                 self.visit_topdown(child)
///
///         return tree
///
///
/// class Interpreter(_Decoratable, ABC, Generic[_Leaf_T, _Return_T]):
///     """Interpreter walks the tree starting at the root.
///
///     Visits the tree, starting with the root and finally the leaves (top-down)
///
///     For each tree node, it calls its methods (provided by user via inheritance) according to ``tree.data``.
///
///     Unlike ``Transformer`` and ``Visitor``, the Interpreter doesn't automatically visit its sub-branches.
///     The user has to explicitly call ``visit``, ``visit_children``, or use the ``@visit_children_decor``.
///     This allows the user to implement branching and loops.
///     """
///
///     def visit(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         # There are no guarantees on the type of the value produced by calling a user func for a
///         # child will produce. So only annotate the public method and use an internal method when
///         # visiting child trees.
///         return self._visit_tree(tree)
///
///     def _visit_tree(self, tree: Tree[_Leaf_T]):
///         f = getattr(self, tree.data)
///         wrapper = getattr(f, 'visit_wrapper', None)
///         if wrapper is not None:
///             return f.visit_wrapper(f, tree.data, tree.children, tree.meta)
///         else:
///             return f(tree)
///
///     def visit_children(self, tree: Tree[_Leaf_T]) -> List:
///         return [self._visit_tree(child) if isinstance(child, Tree) else child
///                 for child in tree.children]
///
///     def __getattr__(self, name):
///         return self.__default__
///
///     def __default__(self, tree):
///         return self.visit_children(tree)
///
///
/// _InterMethod = Callable[[Type[Interpreter], _Return_T], _R]
///
/// def visit_children_decor(func: _InterMethod) -> _InterMethod:
///     "See Interpreter"
///     @wraps(func)
///     def inner(cls, tree):
///         values = cls.visit_children(tree)
///         return func(cls, values)
///     return inner
///
/// # Decorators
///
/// def _apply_v_args(obj, visit_wrapper):
///     try:
///         _apply = obj._apply_v_args
///     except AttributeError:
///         return _VArgsWrapper(obj, visit_wrapper)
///     else:
///         return _apply(visit_wrapper)
///
///
/// class _VArgsWrapper:
///     """
///     A wrapper around a Callable. It delegates `__call__` to the Callable.
///     If the Callable has a `__get__`, that is also delegate and the resulting function is wrapped.
///     Otherwise, we use the original function mirroring the behaviour without a __get__.
///     We also have the visit_wrapper attribute to be used by Transformers.
///     """
///     base_func: Callable
///
///     def __init__(self, func: Callable, visit_wrapper: Callable[[Callable, str, list, Any], Any]):
///         if isinstance(func, _VArgsWrapper):
///             func = func.base_func
///         # https://github.com/python/mypy/issues/708
///         self.base_func = func  # type: ignore[assignment]
///         self.visit_wrapper = visit_wrapper
///         update_wrapper(self, func)
///
///     def __call__(self, *args, **kwargs):
///         return self.base_func(*args, **kwargs)
///
///     def __get__(self, instance, owner=None):
///         try:
///             # Use the __get__ attribute of the type instead of the instance
///             # to fully mirror the behavior of getattr
///             g = type(self.base_func).__get__
///         except AttributeError:
///             return self
///         else:
///             return _VArgsWrapper(g(self.base_func, instance, owner), self.visit_wrapper)
///
///     def __set_name__(self, owner, name):
///         try:
///             f = type(self.base_func).__set_name__
///         except AttributeError:
///             return
///         else:
///             f(self.base_func, owner, name)
///
///
/// def _vargs_inline(f, _data, children, _meta):
///     return f(*children)
/// def _vargs_meta_inline(f, _data, children, meta):
///     return f(meta, *children)
/// def _vargs_meta(f, _data, children, meta):
///     return f(meta, children)
/// def _vargs_tree(f, data, children, meta):
///     return f(Tree(data, children, meta))
///
///
/// def v_args(inline: bool = False, meta: bool = False, tree: bool = False, wrapper: Optional[Callable] = None) -> Callable[[_DECORATED], _DECORATED]:
///     """A convenience decorator factory for modifying the behavior of user-supplied visitor methods.
///
///     By default, callback methods of transformers/visitors accept one argument - a list of the node's children.
///
///     ``v_args`` can modify this behavior. When used on a transformer/visitor class definition,
///     it applies to all the callback methods inside it.
///
///     ``v_args`` can be applied to a single method, or to an entire class. When applied to both,
///     the options given to the method take precedence.
///
///     Parameters:
///         inline (bool, optional): Children are provided as ``*args`` instead of a list argument (not recommended for very long lists).
///         meta (bool, optional): Provides two arguments: ``children`` and ``meta`` (instead of just the first)
///         tree (bool, optional): Provides the entire tree as the argument, instead of the children.
///         wrapper (function, optional): Provide a function to decorate all methods.
///
///     Example:
///         ::
///
///             @v_args(inline=True)
///             class SolveArith(Transformer):
///                 def add(self, left, right):
///                     return left + right
///
///
///             class ReverseNotation(Transformer_InPlace):
///                 @v_args(tree=True)
///                 def tree_node(self, tree):
///                     tree.children = tree.children[::-1]
///     """
///     if tree and (meta or inline):
///         raise ValueError("Visitor functions cannot combine 'tree' with 'meta' or 'inline'.")
///
///     func = None
///     if meta:
///         if inline:
///             func = _vargs_meta_inline
///         else:
///             func = _vargs_meta
///     elif inline:
///         func = _vargs_inline
///     elif tree:
///         func = _vargs_tree
///
///     if wrapper is not None:
///         if func is not None:
///             raise ValueError("Cannot use 'wrapper' along with 'tree', 'meta' or 'inline'.")
///         func = wrapper
///
///     def _visitor_args_dec(obj):
///         return _apply_v_args(obj, func)
///     return _visitor_args_dec
///
///
/// ###}
///
///
/// # --- Visitor Utilities ---
///
/// class CollapseAmbiguities(Transformer):
///     """
///     Transforms a tree that contains any number of _ambig nodes into a list of trees,
///     each one containing an unambiguous tree.
///
///     The length of the resulting list is the product of the length of all _ambig nodes.
///
///     Warning: This may quickly explode for highly ambiguous trees.
///
///     """
///     def _ambig(self, options):
///         return sum(options, [])
///
///     def __default__(self, data, children_lists, meta):
///         return [Tree(data, children, meta) for children in combine_alternatives(children_lists)]
///
///     def __default_token__(self, t):
///         return [t]
/// ```
final class visitors extends PythonModule {
  visitors.from(super.pythonModule) : super.from();

  static visitors import() => PythonFfiDart.instance.importModule(
        "lark.visitors",
        visitors.from,
      );

  /// ## merge_transformers
  ///
  /// ### python docstring
  ///
  /// Merge a collection of transformers into the base_transformer, each into its own 'namespace'.
  ///
  /// When called, it will collect the methods from each transformer, and assign them to base_transformer,
  /// with their name prefixed with the given keyword, as ``prefix__methodname``.
  ///
  /// This function is especially useful for processing grammars that import other grammars,
  /// thereby creating some of their rules in a 'namespace'. (i.e with a consistent name prefix).
  /// In this case, the key for the transformer should match the name of the imported grammar.
  ///
  /// Parameters:
  ///     base_transformer (Transformer, optional): The transformer that all other transformers will be added to.
  ///     **transformers_to_merge: Keyword arguments, in the form of ``name_prefix = transformer``.
  ///
  /// Raises:
  ///     AttributeError: In case of a name collision in the merged methods
  ///
  /// Example:
  ///     ::
  ///
  ///         class TBase(Transformer):
  ///             def start(self, children):
  ///                 return children[0] + 'bar'
  ///
  ///         class TImportedGrammar(Transformer):
  ///             def foo(self, children):
  ///                 return "foo"
  ///
  ///         composed_transformer = merge_transformers(TBase(), imported=TImportedGrammar())
  ///
  ///         t = Tree('start', [ Tree('imported__foo', []) ])
  ///
  ///         assert composed_transformer.transform(t) == 'foobar'
  ///
  /// ### python source
  /// ```py
  /// def merge_transformers(base_transformer=None, **transformers_to_merge):
  ///     """Merge a collection of transformers into the base_transformer, each into its own 'namespace'.
  ///
  ///     When called, it will collect the methods from each transformer, and assign them to base_transformer,
  ///     with their name prefixed with the given keyword, as ``prefix__methodname``.
  ///
  ///     This function is especially useful for processing grammars that import other grammars,
  ///     thereby creating some of their rules in a 'namespace'. (i.e with a consistent name prefix).
  ///     In this case, the key for the transformer should match the name of the imported grammar.
  ///
  ///     Parameters:
  ///         base_transformer (Transformer, optional): The transformer that all other transformers will be added to.
  ///         **transformers_to_merge: Keyword arguments, in the form of ``name_prefix = transformer``.
  ///
  ///     Raises:
  ///         AttributeError: In case of a name collision in the merged methods
  ///
  ///     Example:
  ///         ::
  ///
  ///             class TBase(Transformer):
  ///                 def start(self, children):
  ///                     return children[0] + 'bar'
  ///
  ///             class TImportedGrammar(Transformer):
  ///                 def foo(self, children):
  ///                     return "foo"
  ///
  ///             composed_transformer = merge_transformers(TBase(), imported=TImportedGrammar())
  ///
  ///             t = Tree('start', [ Tree('imported__foo', []) ])
  ///
  ///             assert composed_transformer.transform(t) == 'foobar'
  ///
  ///     """
  ///     if base_transformer is None:
  ///         base_transformer = Transformer()
  ///     for prefix, transformer in transformers_to_merge.items():
  ///         for method_name in dir(transformer):
  ///             method = getattr(transformer, method_name)
  ///             if not callable(method):
  ///                 continue
  ///             if method_name.startswith("_") or method_name == "transform":
  ///                 continue
  ///             prefixed_method = prefix + "__" + method_name
  ///             if hasattr(base_transformer, prefixed_method):
  ///                 raise AttributeError("Cannot merge: method '%s' appears more than once" % prefixed_method)
  ///
  ///             setattr(base_transformer, prefixed_method, method)
  ///
  ///     return base_transformer
  /// ```
  Object? merge_transformers({
    Object? base_transformer,
    Map<String, Object?> transformers_to_merge = const <String, Object?>{},
  }) =>
      getFunction("merge_transformers").call(
        <Object?>[
          base_transformer,
        ],
        kwargs: <String, Object?>{
          ...transformers_to_merge,
        },
      );

  /// ## v_args
  ///
  /// ### python docstring
  ///
  /// A convenience decorator factory for modifying the behavior of user-supplied visitor methods.
  ///
  /// By default, callback methods of transformers/visitors accept one argument - a list of the node's children.
  ///
  /// ``v_args`` can modify this behavior. When used on a transformer/visitor class definition,
  /// it applies to all the callback methods inside it.
  ///
  /// ``v_args`` can be applied to a single method, or to an entire class. When applied to both,
  /// the options given to the method take precedence.
  ///
  /// Parameters:
  ///     inline (bool, optional): Children are provided as ``*args`` instead of a list argument (not recommended for very long lists).
  ///     meta (bool, optional): Provides two arguments: ``children`` and ``meta`` (instead of just the first)
  ///     tree (bool, optional): Provides the entire tree as the argument, instead of the children.
  ///     wrapper (function, optional): Provide a function to decorate all methods.
  ///
  /// Example:
  ///     ::
  ///
  ///         @v_args(inline=True)
  ///         class SolveArith(Transformer):
  ///             def add(self, left, right):
  ///                 return left + right
  ///
  ///
  ///         class ReverseNotation(Transformer_InPlace):
  ///             @v_args(tree=True)
  ///             def tree_node(self, tree):
  ///                 tree.children = tree.children[::-1]
  ///
  /// ### python source
  /// ```py
  /// def v_args(inline: bool = False, meta: bool = False, tree: bool = False, wrapper: Optional[Callable] = None) -> Callable[[_DECORATED], _DECORATED]:
  ///     """A convenience decorator factory for modifying the behavior of user-supplied visitor methods.
  ///
  ///     By default, callback methods of transformers/visitors accept one argument - a list of the node's children.
  ///
  ///     ``v_args`` can modify this behavior. When used on a transformer/visitor class definition,
  ///     it applies to all the callback methods inside it.
  ///
  ///     ``v_args`` can be applied to a single method, or to an entire class. When applied to both,
  ///     the options given to the method take precedence.
  ///
  ///     Parameters:
  ///         inline (bool, optional): Children are provided as ``*args`` instead of a list argument (not recommended for very long lists).
  ///         meta (bool, optional): Provides two arguments: ``children`` and ``meta`` (instead of just the first)
  ///         tree (bool, optional): Provides the entire tree as the argument, instead of the children.
  ///         wrapper (function, optional): Provide a function to decorate all methods.
  ///
  ///     Example:
  ///         ::
  ///
  ///             @v_args(inline=True)
  ///             class SolveArith(Transformer):
  ///                 def add(self, left, right):
  ///                     return left + right
  ///
  ///
  ///             class ReverseNotation(Transformer_InPlace):
  ///                 @v_args(tree=True)
  ///                 def tree_node(self, tree):
  ///                     tree.children = tree.children[::-1]
  ///     """
  ///     if tree and (meta or inline):
  ///         raise ValueError("Visitor functions cannot combine 'tree' with 'meta' or 'inline'.")
  ///
  ///     func = None
  ///     if meta:
  ///         if inline:
  ///             func = _vargs_meta_inline
  ///         else:
  ///             func = _vargs_meta
  ///     elif inline:
  ///         func = _vargs_inline
  ///     elif tree:
  ///         func = _vargs_tree
  ///
  ///     if wrapper is not None:
  ///         if func is not None:
  ///             raise ValueError("Cannot use 'wrapper' along with 'tree', 'meta' or 'inline'.")
  ///         func = wrapper
  ///
  ///     def _visitor_args_dec(obj):
  ///         return _apply_v_args(obj, func)
  ///     return _visitor_args_dec
  /// ```
  Object? v_args({
    Object? inline = false,
    Object? meta = false,
    Object? tree = false,
    Object? wrapper,
  }) =>
      getFunction("v_args").call(
        <Object?>[
          inline,
          meta,
          tree,
          wrapper,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_children_decor
  ///
  /// ### python docstring
  ///
  /// See Interpreter
  ///
  /// ### python source
  /// ```py
  /// def visit_children_decor(func: _InterMethod) -> _InterMethod:
  ///     "See Interpreter"
  ///     @wraps(func)
  ///     def inner(cls, tree):
  ///         values = cls.visit_children(tree)
  ///         return func(cls, values)
  ///     return inner
  /// ```
  Object? visit_children_decor({
    required Object? func,
  }) =>
      getFunction("visit_children_decor").call(
        <Object?>[
          func,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## Discard (getter)
  ///
  /// ### python docstring
  ///
  /// When the Discard value is returned from a transformer callback,
  /// that node is discarded and won't appear in the parent.
  ///
  /// Note:
  ///     This feature is disabled when the transformer is provided to Lark
  ///     using the ``transformer`` keyword (aka Tree-less LALR mode).
  ///
  /// Example:
  ///     ::
  ///
  ///         class T(Transformer):
  ///             def ignore_tree(self, children):
  ///                 return Discard
  ///
  ///             def IGNORE_TOKEN(self, token):
  ///                 return Discard
  Object? get Discard => getAttribute("Discard");

  /// ## Discard (setter)
  ///
  /// ### python docstring
  ///
  /// When the Discard value is returned from a transformer callback,
  /// that node is discarded and won't appear in the parent.
  ///
  /// Note:
  ///     This feature is disabled when the transformer is provided to Lark
  ///     using the ``transformer`` keyword (aka Tree-less LALR mode).
  ///
  /// Example:
  ///     ::
  ///
  ///         class T(Transformer):
  ///             def ignore_tree(self, children):
  ///                 return Discard
  ///
  ///             def IGNORE_TOKEN(self, token):
  ///                 return Discard
  set Discard(Object? Discard) => setAttribute("Discard", Discard);
}
