// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library reconstruct;

import "package:python_ffi/python_ffi.dart";

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
      PythonFfi.instance.importClass(
        "lark.reconstruct",
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
        "lark.reconstruct",
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
      PythonFfi.instance.importClass(
        "lark.reconstruct",
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

/// ## Reconstructor
///
/// ### python docstring
///
/// A Reconstructor that will, given a full parse Tree, generate source code.
///
/// Note:
///     The reconstructor cannot generate values from regexps. If you need to produce discarded
///     regexes, such as newlines, use `term_subs` and provide default values for them.
///
/// Parameters:
///     parser: a Lark instance
///     term_subs: a dictionary of [Terminal name as str] to [output text as str]
///
/// ### python source
/// ```py
/// class Reconstructor(TreeMatcher):
///     """
///     A Reconstructor that will, given a full parse Tree, generate source code.
///
///     Note:
///         The reconstructor cannot generate values from regexps. If you need to produce discarded
///         regexes, such as newlines, use `term_subs` and provide default values for them.
///
///     Parameters:
///         parser: a Lark instance
///         term_subs: a dictionary of [Terminal name as str] to [output text as str]
///     """
///
///     write_tokens: WriteTokensTransformer
///
///     def __init__(self, parser: Lark, term_subs: Optional[Dict[str, Callable[[Symbol], str]]]=None) -> None:
///         TreeMatcher.__init__(self, parser)
///
///         self.write_tokens = WriteTokensTransformer({t.name:t for t in self.tokens}, term_subs or {})
///
///     def _reconstruct(self, tree):
///         unreduced_tree = self.match_tree(tree, tree.data)
///
///         res = self.write_tokens.transform(unreduced_tree)
///         for item in res:
///             if isinstance(item, Tree):
///                 # TODO use orig_expansion.rulename to support templates
///                 yield from self._reconstruct(item)
///             else:
///                 yield item
///
///     def reconstruct(self, tree: ParseTree, postproc: Optional[Callable[[Iterable[str]], Iterable[str]]]=None, insert_spaces: bool=True) -> str:
///         x = self._reconstruct(tree)
///         if postproc:
///             x = postproc(x)
///         y = []
///         prev_item = ''
///         for item in x:
///             if insert_spaces and prev_item and item and is_id_continue(prev_item[-1]) and is_id_continue(item[0]):
///                 y.append(' ')
///             y.append(item)
///             prev_item = item
///         return ''.join(y)
/// ```
final class Reconstructor extends PythonClass {
  factory Reconstructor({
    required Lark parser,
    Object? term_subs,
  }) =>
      PythonFfi.instance.importClass(
        "lark.reconstruct",
        "Reconstructor",
        Reconstructor.from,
        <Object?>[
          parser,
          term_subs,
        ],
        <String, Object?>{},
      );

  Reconstructor.from(super.pythonClass) : super.from();

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

  /// ## reconstruct
  ///
  /// ### python source
  /// ```py
  /// def reconstruct(self, tree: ParseTree, postproc: Optional[Callable[[Iterable[str]], Iterable[str]]]=None, insert_spaces: bool=True) -> str:
  ///         x = self._reconstruct(tree)
  ///         if postproc:
  ///             x = postproc(x)
  ///         y = []
  ///         prev_item = ''
  ///         for item in x:
  ///             if insert_spaces and prev_item and item and is_id_continue(prev_item[-1]) and is_id_continue(item[0]):
  ///                 y.append(' ')
  ///             y.append(item)
  ///             prev_item = item
  ///         return ''.join(y)
  /// ```
  String reconstruct({
    required Object? tree,
    Object? postproc,
    bool insert_spaces = true,
  }) =>
      getFunction("reconstruct").call(
        <Object?>[
          tree,
          postproc,
          insert_spaces,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## write_tokens (getter)
  ///
  /// ### python docstring
  ///
  /// A Reconstructor that will, given a full parse Tree, generate source code.
  ///
  /// Note:
  ///     The reconstructor cannot generate values from regexps. If you need to produce discarded
  ///     regexes, such as newlines, use `term_subs` and provide default values for them.
  ///
  /// Parameters:
  ///     parser: a Lark instance
  ///     term_subs: a dictionary of [Terminal name as str] to [output text as str]
  Object? get write_tokens => getAttribute("write_tokens");

  /// ## write_tokens (setter)
  ///
  /// ### python docstring
  ///
  /// A Reconstructor that will, given a full parse Tree, generate source code.
  ///
  /// Note:
  ///     The reconstructor cannot generate values from regexps. If you need to produce discarded
  ///     regexes, such as newlines, use `term_subs` and provide default values for them.
  ///
  /// Parameters:
  ///     parser: a Lark instance
  ///     term_subs: a dictionary of [Terminal name as str] to [output text as str]
  set write_tokens(Object? write_tokens) =>
      setAttribute("write_tokens", write_tokens);
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
        "lark.reconstruct",
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
        "lark.reconstruct",
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
      PythonFfi.instance.importClass(
        "lark.reconstruct",
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
  factory Token() => PythonFfi.instance.importClass(
        "lark.reconstruct",
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
    bool visit_tokens = true,
  }) =>
      PythonFfi.instance.importClass(
        "lark.reconstruct",
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
        "lark.reconstruct",
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
        "lark.reconstruct",
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

/// ## WriteTokensTransformer
///
/// ### python docstring
///
/// Inserts discarded tokens into their correct place, according to the rules of grammar
///
/// ### python source
/// ```py
/// class WriteTokensTransformer(Transformer_InPlace):
///     "Inserts discarded tokens into their correct place, according to the rules of grammar"
///
///     tokens: Dict[str, TerminalDef]
///     term_subs: Dict[str, Callable[[Symbol], str]]
///
///     def __init__(self, tokens: Dict[str, TerminalDef], term_subs: Dict[str, Callable[[Symbol], str]]) -> None:
///         self.tokens = tokens
///         self.term_subs = term_subs
///
///     def __default__(self, data, children, meta):
///         if not getattr(meta, 'match_tree', False):
///             return Tree(data, children)
///
///         iter_args = iter(children)
///         to_write = []
///         for sym in meta.orig_expansion:
///             if is_discarded_terminal(sym):
///                 try:
///                     v = self.term_subs[sym.name](sym)
///                 except KeyError:
///                     t = self.tokens[sym.name]
///                     if not isinstance(t.pattern, PatternStr):
///                         raise NotImplementedError("Reconstructing regexps not supported yet: %s" % t)
///
///                     v = t.pattern.value
///                 to_write.append(v)
///             else:
///                 x = next(iter_args)
///                 if isinstance(x, list):
///                     to_write += x
///                 else:
///                     if isinstance(x, Token):
///                         assert Terminal(x.type) == sym, x
///                     else:
///                         assert NonTerminal(x.data) == sym, (sym, x)
///                     to_write.append(x)
///
///         assert is_iter_empty(iter_args)
///         return to_write
/// ```
final class WriteTokensTransformer extends PythonClass {
  factory WriteTokensTransformer({
    required Object? tokens,
    required Object? term_subs,
  }) =>
      PythonFfi.instance.importClass(
        "lark.reconstruct",
        "WriteTokensTransformer",
        WriteTokensTransformer.from,
        <Object?>[
          tokens,
          term_subs,
        ],
        <String, Object?>{},
      );

  WriteTokensTransformer.from(super.pythonClass) : super.from();

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

  /// ## tokens (getter)
  ///
  /// ### python docstring
  ///
  /// Inserts discarded tokens into their correct place, according to the rules of grammar
  Object? get tokens => getAttribute("tokens");

  /// ## tokens (setter)
  ///
  /// ### python docstring
  ///
  /// Inserts discarded tokens into their correct place, according to the rules of grammar
  set tokens(Object? tokens) => setAttribute("tokens", tokens);

  /// ## term_subs (getter)
  ///
  /// ### python docstring
  ///
  /// Inserts discarded tokens into their correct place, according to the rules of grammar
  Object? get term_subs => getAttribute("term_subs");

  /// ## term_subs (setter)
  ///
  /// ### python docstring
  ///
  /// Inserts discarded tokens into their correct place, according to the rules of grammar
  set term_subs(Object? term_subs) => setAttribute("term_subs", term_subs);
}

/// ## reconstruct
///
/// ### python docstring
///
/// Reconstruct text from a tree, based on Lark grammar
///
/// ### python source
/// ```py
/// """Reconstruct text from a tree, based on Lark grammar"""
///
/// from typing import Dict, Callable, Iterable, Optional
///
/// from .lark import Lark
/// from .tree import Tree, ParseTree
/// from .visitors import Transformer_InPlace
/// from .lexer import Token, PatternStr, TerminalDef
/// from .grammar import Terminal, NonTerminal, Symbol
///
/// from .tree_matcher import TreeMatcher, is_discarded_terminal
/// from .utils import is_id_continue
///
/// def is_iter_empty(i):
///     try:
///         _ = next(i)
///         return False
///     except StopIteration:
///         return True
///
///
/// class WriteTokensTransformer(Transformer_InPlace):
///     "Inserts discarded tokens into their correct place, according to the rules of grammar"
///
///     tokens: Dict[str, TerminalDef]
///     term_subs: Dict[str, Callable[[Symbol], str]]
///
///     def __init__(self, tokens: Dict[str, TerminalDef], term_subs: Dict[str, Callable[[Symbol], str]]) -> None:
///         self.tokens = tokens
///         self.term_subs = term_subs
///
///     def __default__(self, data, children, meta):
///         if not getattr(meta, 'match_tree', False):
///             return Tree(data, children)
///
///         iter_args = iter(children)
///         to_write = []
///         for sym in meta.orig_expansion:
///             if is_discarded_terminal(sym):
///                 try:
///                     v = self.term_subs[sym.name](sym)
///                 except KeyError:
///                     t = self.tokens[sym.name]
///                     if not isinstance(t.pattern, PatternStr):
///                         raise NotImplementedError("Reconstructing regexps not supported yet: %s" % t)
///
///                     v = t.pattern.value
///                 to_write.append(v)
///             else:
///                 x = next(iter_args)
///                 if isinstance(x, list):
///                     to_write += x
///                 else:
///                     if isinstance(x, Token):
///                         assert Terminal(x.type) == sym, x
///                     else:
///                         assert NonTerminal(x.data) == sym, (sym, x)
///                     to_write.append(x)
///
///         assert is_iter_empty(iter_args)
///         return to_write
///
///
/// class Reconstructor(TreeMatcher):
///     """
///     A Reconstructor that will, given a full parse Tree, generate source code.
///
///     Note:
///         The reconstructor cannot generate values from regexps. If you need to produce discarded
///         regexes, such as newlines, use `term_subs` and provide default values for them.
///
///     Parameters:
///         parser: a Lark instance
///         term_subs: a dictionary of [Terminal name as str] to [output text as str]
///     """
///
///     write_tokens: WriteTokensTransformer
///
///     def __init__(self, parser: Lark, term_subs: Optional[Dict[str, Callable[[Symbol], str]]]=None) -> None:
///         TreeMatcher.__init__(self, parser)
///
///         self.write_tokens = WriteTokensTransformer({t.name:t for t in self.tokens}, term_subs or {})
///
///     def _reconstruct(self, tree):
///         unreduced_tree = self.match_tree(tree, tree.data)
///
///         res = self.write_tokens.transform(unreduced_tree)
///         for item in res:
///             if isinstance(item, Tree):
///                 # TODO use orig_expansion.rulename to support templates
///                 yield from self._reconstruct(item)
///             else:
///                 yield item
///
///     def reconstruct(self, tree: ParseTree, postproc: Optional[Callable[[Iterable[str]], Iterable[str]]]=None, insert_spaces: bool=True) -> str:
///         x = self._reconstruct(tree)
///         if postproc:
///             x = postproc(x)
///         y = []
///         prev_item = ''
///         for item in x:
///             if insert_spaces and prev_item and item and is_id_continue(prev_item[-1]) and is_id_continue(item[0]):
///                 y.append(' ')
///             y.append(item)
///             prev_item = item
///         return ''.join(y)
/// ```
final class reconstruct extends PythonModule {
  reconstruct.from(super.pythonModule) : super.from();

  static reconstruct import() => PythonFfi.instance.importModule(
        "lark.reconstruct",
        reconstruct.from,
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
  bool is_id_continue({
    required String s,
  }) =>
      getFunction("is_id_continue").call(
        <Object?>[
          s,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## is_iter_empty
  ///
  /// ### python source
  /// ```py
  /// def is_iter_empty(i):
  ///     try:
  ///         _ = next(i)
  ///         return False
  ///     except StopIteration:
  ///         return True
  /// ```
  Object? is_iter_empty({
    required Object? i,
  }) =>
      getFunction("is_iter_empty").call(
        <Object?>[
          i,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## Callable (getter)
  ///
  /// ### python docstring
  ///
  /// Reconstruct text from a tree, based on Lark grammar
  Object? get Callable => getAttribute("Callable");

  /// ## Callable (setter)
  ///
  /// ### python docstring
  ///
  /// Reconstruct text from a tree, based on Lark grammar
  set Callable(Object? Callable) => setAttribute("Callable", Callable);

  /// ## Dict (getter)
  ///
  /// ### python docstring
  ///
  /// Reconstruct text from a tree, based on Lark grammar
  Object? get Dict => getAttribute("Dict");

  /// ## Dict (setter)
  ///
  /// ### python docstring
  ///
  /// Reconstruct text from a tree, based on Lark grammar
  set Dict(Object? Dict) => setAttribute("Dict", Dict);

  /// ## Iterable (getter)
  ///
  /// ### python docstring
  ///
  /// Reconstruct text from a tree, based on Lark grammar
  Object? get $Iterable => getAttribute("Iterable");

  /// ## Iterable (setter)
  ///
  /// ### python docstring
  ///
  /// Reconstruct text from a tree, based on Lark grammar
  set $Iterable(Object? $Iterable) => setAttribute("Iterable", $Iterable);

  /// ## Optional (getter)
  ///
  /// ### python docstring
  ///
  /// Reconstruct text from a tree, based on Lark grammar
  Object? get Optional => getAttribute("Optional");

  /// ## Optional (setter)
  ///
  /// ### python docstring
  ///
  /// Reconstruct text from a tree, based on Lark grammar
  set Optional(Object? Optional) => setAttribute("Optional", Optional);

  /// ## ParseTree (getter)
  ///
  /// ### python docstring
  ///
  /// Reconstruct text from a tree, based on Lark grammar
  Object? get ParseTree => getAttribute("ParseTree");

  /// ## ParseTree (setter)
  ///
  /// ### python docstring
  ///
  /// Reconstruct text from a tree, based on Lark grammar
  set ParseTree(Object? ParseTree) => setAttribute("ParseTree", ParseTree);
}
