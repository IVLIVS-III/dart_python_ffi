// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library nearley;

import "package:python_ffi_dart/python_ffi_dart.dart";

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
  Object? get_terminal({
    required String name,
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
  Iterator<Object?> lex({
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
      ).transform((e) => e).cast<Object?>();

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

/// ## NearleyToLark
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
/// @v_args(inline=True)
/// class NearleyToLark(Transformer):
///     def __init__(self):
///         self._count = 0
///         self.extra_rules = {}
///         self.extra_rules_rev = {}
///         self.alias_js_code = {}
///
///     def _new_function(self, code):
///         name = 'alias_%d' % self._count
///         self._count += 1
///
///         self.alias_js_code[name] = code
///         return name
///
///     def _extra_rule(self, rule):
///         if rule in self.extra_rules_rev:
///             return self.extra_rules_rev[rule]
///
///         name = 'xrule_%d' % len(self.extra_rules)
///         assert name not in self.extra_rules
///         self.extra_rules[name] = rule
///         self.extra_rules_rev[rule] = name
///         return name
///
///     def rule(self, name):
///         return _get_rulename(name)
///
///     def ruledef(self, name, exps):
///         return '!%s: %s' % (_get_rulename(name), exps)
///
///     def expr(self, item, op):
///         rule = '(%s)%s' % (item, op)
///         return self._extra_rule(rule)
///
///     def regexp(self, r):
///         return '/%s/' % r
///
///     def null(self):
///         return ''
///
///     def string(self, s):
///         return self._extra_rule(s)
///
///     def expansion(self, *x):
///         x, js = x[:-1], x[-1]
///         if js.children:
///             js_code ,= js.children
///             js_code = js_code[2:-2]
///             alias = '-> ' + self._new_function(js_code)
///         else:
///             alias = ''
///         return ' '.join(x) + alias
///
///     def expansions(self, *x):
///         return '%s' % ('\n    |'.join(x))
///
///     def start(self, *rules):
///         return '\n'.join(filter(None, rules))
/// ```
final class NearleyToLark extends PythonClass {
  factory NearleyToLark() => PythonFfiDart.instance.importClass(
        "lark.tools.nearley",
        "NearleyToLark",
        NearleyToLark.from,
        <Object?>[],
        <String, Object?>{},
      );

  NearleyToLark.from(super.pythonClass) : super.from();

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

  /// ## expansion (getter)
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
  Object? get expansion => getAttribute("expansion");

  /// ## expansion (setter)
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
  set expansion(Object? expansion) => setAttribute("expansion", expansion);

  /// ## expansions (getter)
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
  Object? get expansions => getAttribute("expansions");

  /// ## expansions (setter)
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
  set expansions(Object? expansions) => setAttribute("expansions", expansions);

  /// ## expr (getter)
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
  Object? get expr => getAttribute("expr");

  /// ## expr (setter)
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
  set expr(Object? expr) => setAttribute("expr", expr);

  /// ## null (getter)
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
  Object? get $null => getAttribute("null");

  /// ## null (setter)
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
  set $null(Object? $null) => setAttribute("null", $null);

  /// ## regexp (getter)
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
  Object? get regexp => getAttribute("regexp");

  /// ## regexp (setter)
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
  set regexp(Object? regexp) => setAttribute("regexp", regexp);

  /// ## rule (getter)
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
  Object? get rule => getAttribute("rule");

  /// ## rule (setter)
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
  set rule(Object? rule) => setAttribute("rule", rule);

  /// ## ruledef (getter)
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
  Object? get ruledef => getAttribute("ruledef");

  /// ## ruledef (setter)
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
  set ruledef(Object? ruledef) => setAttribute("ruledef", ruledef);

  /// ## start (getter)
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
  Object? get start => getAttribute("start");

  /// ## start (setter)
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
  set start(Object? start) => setAttribute("start", start);

  /// ## string (getter)
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
  Object? get string => getAttribute("string");

  /// ## string (setter)
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
  set string(Object? string) => setAttribute("string", string);

  /// ## extra_rules (getter)
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
  Object? get extra_rules => getAttribute("extra_rules");

  /// ## extra_rules (setter)
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
  set extra_rules(Object? extra_rules) =>
      setAttribute("extra_rules", extra_rules);

  /// ## extra_rules_rev (getter)
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
  Object? get extra_rules_rev => getAttribute("extra_rules_rev");

  /// ## extra_rules_rev (setter)
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
  set extra_rules_rev(Object? extra_rules_rev) =>
      setAttribute("extra_rules_rev", extra_rules_rev);

  /// ## alias_js_code (getter)
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
  Object? get alias_js_code => getAttribute("alias_js_code");

  /// ## alias_js_code (setter)
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
  set alias_js_code(Object? alias_js_code) =>
      setAttribute("alias_js_code", alias_js_code);
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
    bool visit_tokens = true,
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

/// ## tree_class
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
final class tree_class extends PythonClass {
  factory tree_class({
    required String data,
    required Object? children,
    Object? meta,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.tree",
        "tree_class",
        tree_class.from,
        <Object?>[
          data,
          children,
          meta,
        ],
        <String, Object?>{},
      );

  tree_class.from(super.pythonClass) : super.from();

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

/// ## nearley
///
/// ### python docstring
///
/// Converts Nearley grammars to Lark
///
/// ### python source
/// ```py
/// "Converts Nearley grammars to Lark"
///
/// import os.path
/// import sys
/// import codecs
/// import argparse
///
///
/// from lark import Lark, Transformer, v_args
///
/// nearley_grammar = r"""
///     start: (ruledef|directive)+
///
///     directive: "@" NAME (STRING|NAME)
///              | "@" JS  -> js_code
///     ruledef: NAME "->" expansions
///            | NAME REGEXP "->" expansions -> macro
///     expansions: expansion ("|" expansion)*
///
///     expansion: expr+ js
///
///     ?expr: item (":" /[+*?]/)?
///
///     ?item: rule|string|regexp|null
///          | "(" expansions ")"
///
///     rule: NAME
///     string: STRING
///     regexp: REGEXP
///     null: "null"
///     JS: /{%.*?%}/s
///     js: JS?
///
///     NAME: /[a-zA-Z_$]\w*/
///     COMMENT: /#[^\n]*/
///     REGEXP: /\[.*?\]/
///
///     STRING: _STRING "i"?
///
///     %import common.ESCAPED_STRING -> _STRING
///     %import common.WS
///     %ignore WS
///     %ignore COMMENT
///
///     """
///
/// nearley_grammar_parser = Lark(nearley_grammar, parser='earley', lexer='basic')
///
/// def _get_rulename(name):
///     name = {'_': '_ws_maybe', '__': '_ws'}.get(name, name)
///     return 'n_' + name.replace('$', '__DOLLAR__').lower()
///
/// @v_args(inline=True)
/// class NearleyToLark(Transformer):
///     def __init__(self):
///         self._count = 0
///         self.extra_rules = {}
///         self.extra_rules_rev = {}
///         self.alias_js_code = {}
///
///     def _new_function(self, code):
///         name = 'alias_%d' % self._count
///         self._count += 1
///
///         self.alias_js_code[name] = code
///         return name
///
///     def _extra_rule(self, rule):
///         if rule in self.extra_rules_rev:
///             return self.extra_rules_rev[rule]
///
///         name = 'xrule_%d' % len(self.extra_rules)
///         assert name not in self.extra_rules
///         self.extra_rules[name] = rule
///         self.extra_rules_rev[rule] = name
///         return name
///
///     def rule(self, name):
///         return _get_rulename(name)
///
///     def ruledef(self, name, exps):
///         return '!%s: %s' % (_get_rulename(name), exps)
///
///     def expr(self, item, op):
///         rule = '(%s)%s' % (item, op)
///         return self._extra_rule(rule)
///
///     def regexp(self, r):
///         return '/%s/' % r
///
///     def null(self):
///         return ''
///
///     def string(self, s):
///         return self._extra_rule(s)
///
///     def expansion(self, *x):
///         x, js = x[:-1], x[-1]
///         if js.children:
///             js_code ,= js.children
///             js_code = js_code[2:-2]
///             alias = '-> ' + self._new_function(js_code)
///         else:
///             alias = ''
///         return ' '.join(x) + alias
///
///     def expansions(self, *x):
///         return '%s' % ('\n    |'.join(x))
///
///     def start(self, *rules):
///         return '\n'.join(filter(None, rules))
///
/// def _nearley_to_lark(g, builtin_path, n2l, js_code, folder_path, includes):
///     rule_defs = []
///
///     tree = nearley_grammar_parser.parse(g)
///     for statement in tree.children:
///         if statement.data == 'directive':
///             directive, arg = statement.children
///             if directive in ('builtin', 'include'):
///                 folder = builtin_path if directive == 'builtin' else folder_path
///                 path = os.path.join(folder, arg[1:-1])
///                 if path not in includes:
///                     includes.add(path)
///                     with codecs.open(path, encoding='utf8') as f:
///                         text = f.read()
///                     rule_defs += _nearley_to_lark(text, builtin_path, n2l, js_code, os.path.abspath(os.path.dirname(path)), includes)
///             else:
///                 assert False, directive
///         elif statement.data == 'js_code':
///             code ,= statement.children
///             code = code[2:-2]
///             js_code.append(code)
///         elif statement.data == 'macro':
///             pass    # TODO Add support for macros!
///         elif statement.data == 'ruledef':
///             rule_defs.append(n2l.transform(statement))
///         else:
///             raise Exception("Unknown statement: %s" % statement)
///
///     return rule_defs
///
///
/// def create_code_for_nearley_grammar(g, start, builtin_path, folder_path, es6=False):
///     import js2py
///
///     emit_code = []
///     def emit(x=None):
///         if x:
///             emit_code.append(x)
///         emit_code.append('\n')
///
///     js_code = ['function id(x) {return x[0];}']
///     n2l = NearleyToLark()
///     rule_defs = _nearley_to_lark(g, builtin_path, n2l, js_code, folder_path, set())
///     lark_g = '\n'.join(rule_defs)
///     lark_g += '\n'+'\n'.join('!%s: %s' % item for item in n2l.extra_rules.items())
///
///     emit('from lark import Lark, Transformer')
///     emit()
///     emit('grammar = ' + repr(lark_g))
///     emit()
///
///     for alias, code in n2l.alias_js_code.items():
///         js_code.append('%s = (%s);' % (alias, code))
///
///     if es6:
///         emit(js2py.translate_js6('\n'.join(js_code)))
///     else:
///         emit(js2py.translate_js('\n'.join(js_code)))
///     emit('class TransformNearley(Transformer):')
///     for alias in n2l.alias_js_code:
///         emit("    %s = var.get('%s').to_python()" % (alias, alias))
///     emit("    __default__ = lambda self, n, c, m: c if c else None")
///
///     emit()
///     emit('parser = Lark(grammar, start="n_%s", maybe_placeholders=False)' % start)
///     emit('def parse(text):')
///     emit('    return TransformNearley().transform(parser.parse(text))')
///
///     return ''.join(emit_code)
///
/// def main(fn, start, nearley_lib, es6=False):
///     with codecs.open(fn, encoding='utf8') as f:
///         grammar = f.read()
///     return create_code_for_nearley_grammar(grammar, start, os.path.join(nearley_lib, 'builtin'), os.path.abspath(os.path.dirname(fn)), es6=es6)
///
/// def get_arg_parser():
///     parser = argparse.ArgumentParser(description='Reads a Nearley grammar (with js functions), and outputs an equivalent lark parser.')
///     parser.add_argument('nearley_grammar', help='Path to the file containing the nearley grammar')
///     parser.add_argument('start_rule', help='Rule within the nearley grammar to make the base rule')
///     parser.add_argument('nearley_lib', help='Path to root directory of nearley codebase (used for including builtins)')
///     parser.add_argument('--es6', help='Enable experimental ES6 support', action='store_true')
///     return parser
///
/// if __name__ == '__main__':
///     parser = get_arg_parser()
///     if len(sys.argv) == 1:
///         parser.print_help(sys.stderr)
///         sys.exit(1)
///     args = parser.parse_args()
///     print(main(fn=args.nearley_grammar, start=args.start_rule, nearley_lib=args.nearley_lib, es6=args.es6))
/// ```
final class nearley extends PythonModule {
  nearley.from(super.pythonModule) : super.from();

  static nearley import() => PythonFfiDart.instance.importModule(
        "lark.tools.nearley",
        nearley.from,
      );

  /// ## create_code_for_nearley_grammar
  ///
  /// ### python source
  /// ```py
  /// def create_code_for_nearley_grammar(g, start, builtin_path, folder_path, es6=False):
  ///     import js2py
  ///
  ///     emit_code = []
  ///     def emit(x=None):
  ///         if x:
  ///             emit_code.append(x)
  ///         emit_code.append('\n')
  ///
  ///     js_code = ['function id(x) {return x[0];}']
  ///     n2l = NearleyToLark()
  ///     rule_defs = _nearley_to_lark(g, builtin_path, n2l, js_code, folder_path, set())
  ///     lark_g = '\n'.join(rule_defs)
  ///     lark_g += '\n'+'\n'.join('!%s: %s' % item for item in n2l.extra_rules.items())
  ///
  ///     emit('from lark import Lark, Transformer')
  ///     emit()
  ///     emit('grammar = ' + repr(lark_g))
  ///     emit()
  ///
  ///     for alias, code in n2l.alias_js_code.items():
  ///         js_code.append('%s = (%s);' % (alias, code))
  ///
  ///     if es6:
  ///         emit(js2py.translate_js6('\n'.join(js_code)))
  ///     else:
  ///         emit(js2py.translate_js('\n'.join(js_code)))
  ///     emit('class TransformNearley(Transformer):')
  ///     for alias in n2l.alias_js_code:
  ///         emit("    %s = var.get('%s').to_python()" % (alias, alias))
  ///     emit("    __default__ = lambda self, n, c, m: c if c else None")
  ///
  ///     emit()
  ///     emit('parser = Lark(grammar, start="n_%s", maybe_placeholders=False)' % start)
  ///     emit('def parse(text):')
  ///     emit('    return TransformNearley().transform(parser.parse(text))')
  ///
  ///     return ''.join(emit_code)
  /// ```
  Object? create_code_for_nearley_grammar({
    required Object? g,
    required Object? start,
    required Object? builtin_path,
    required Object? folder_path,
    Object? es6 = false,
  }) =>
      getFunction("create_code_for_nearley_grammar").call(
        <Object?>[
          g,
          start,
          builtin_path,
          folder_path,
          es6,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## get_arg_parser
  ///
  /// ### python source
  /// ```py
  /// def get_arg_parser():
  ///     parser = argparse.ArgumentParser(description='Reads a Nearley grammar (with js functions), and outputs an equivalent lark parser.')
  ///     parser.add_argument('nearley_grammar', help='Path to the file containing the nearley grammar')
  ///     parser.add_argument('start_rule', help='Rule within the nearley grammar to make the base rule')
  ///     parser.add_argument('nearley_lib', help='Path to root directory of nearley codebase (used for including builtins)')
  ///     parser.add_argument('--es6', help='Enable experimental ES6 support', action='store_true')
  ///     return parser
  /// ```
  Object? get_arg_parser() => getFunction("get_arg_parser").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## main
  ///
  /// ### python source
  /// ```py
  /// def main(fn, start, nearley_lib, es6=False):
  ///     with codecs.open(fn, encoding='utf8') as f:
  ///         grammar = f.read()
  ///     return create_code_for_nearley_grammar(grammar, start, os.path.join(nearley_lib, 'builtin'), os.path.abspath(os.path.dirname(fn)), es6=es6)
  /// ```
  Object? main({
    required Object? fn,
    required Object? start,
    required Object? nearley_lib,
    Object? es6 = false,
  }) =>
      getFunction("main").call(
        <Object?>[
          fn,
          start,
          nearley_lib,
          es6,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## nearley_grammar (getter)
  ///
  /// ### python docstring
  ///
  /// Converts Nearley grammars to Lark
  Object? get nearley_grammar => getAttribute("nearley_grammar");

  /// ## nearley_grammar (setter)
  ///
  /// ### python docstring
  ///
  /// Converts Nearley grammars to Lark
  set nearley_grammar(Object? nearley_grammar) =>
      setAttribute("nearley_grammar", nearley_grammar);
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
