// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library tools;

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
        "lark.tools",
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

/// ## tools
///
/// ### python source
/// ```py
/// import sys
/// from argparse import ArgumentParser, FileType
/// from textwrap import indent
/// from logging import DEBUG, INFO, WARN, ERROR
/// from typing import Optional
/// import warnings
///
/// from lark import Lark, logger
/// try:
///     from interegular import logger as interegular_logger
///     has_interegular = True
/// except ImportError:
///     has_interegular = False
///
/// lalr_argparser = ArgumentParser(add_help=False, epilog='Look at the Lark documentation for more info on the options')
///
/// flags = [
///     ('d', 'debug'),
///     'keep_all_tokens',
///     'regex',
///     'propagate_positions',
///     'maybe_placeholders',
///     'use_bytes'
/// ]
///
/// options = ['start', 'lexer']
///
/// lalr_argparser.add_argument('-v', '--verbose', action='count', default=0, help="Increase Logger output level, up to three times")
/// lalr_argparser.add_argument('-s', '--start', action='append', default=[])
/// lalr_argparser.add_argument('-l', '--lexer', default='contextual', choices=('basic', 'contextual'))
/// encoding: Optional[str] = 'utf-8' if sys.version_info > (3, 4) else None
/// lalr_argparser.add_argument('-o', '--out', type=FileType('w', encoding=encoding), default=sys.stdout, help='the output file (default=stdout)')
/// lalr_argparser.add_argument('grammar_file', type=FileType('r', encoding=encoding), help='A valid .lark file')
///
/// for flag in flags:
///     if isinstance(flag, tuple):
///         options.append(flag[1])
///         lalr_argparser.add_argument('-' + flag[0], '--' + flag[1], action='store_true')
///     elif isinstance(flag, str):
///         options.append(flag)
///         lalr_argparser.add_argument('--' + flag, action='store_true')
///     else:
///         raise NotImplementedError("flags must only contain strings or tuples of strings")
///
///
/// def build_lalr(namespace):
///     logger.setLevel((ERROR, WARN, INFO, DEBUG)[min(namespace.verbose, 3)])
///     if has_interegular:
///         interegular_logger.setLevel(logger.getEffectiveLevel())
///     if len(namespace.start) == 0:
///         namespace.start.append('start')
///     kwargs = {n: getattr(namespace, n) for n in options}
///     return Lark(namespace.grammar_file, parser='lalr', **kwargs), namespace.out
///
///
/// def showwarning_as_comment(message, category, filename, lineno, file=None, line=None):
///     # Based on warnings._showwarnmsg_impl
///     text = warnings.formatwarning(message, category, filename, lineno, line)
///     text = indent(text, '# ')
///     if file is None:
///         file = sys.stderr
///         if file is None:
///             return
///     try:
///         file.write(text)
///     except OSError:
///         pass
///
///
/// def make_warnings_comments():
///     warnings.showwarning = showwarning_as_comment
/// ```
final class tools extends PythonModule {
  tools.from(super.pythonModule) : super.from();

  static tools import() => PythonFfiDart.instance.importModule(
        "lark.tools",
        tools.from,
      );

  /// ## build_lalr
  ///
  /// ### python source
  /// ```py
  /// def build_lalr(namespace):
  ///     logger.setLevel((ERROR, WARN, INFO, DEBUG)[min(namespace.verbose, 3)])
  ///     if has_interegular:
  ///         interegular_logger.setLevel(logger.getEffectiveLevel())
  ///     if len(namespace.start) == 0:
  ///         namespace.start.append('start')
  ///     kwargs = {n: getattr(namespace, n) for n in options}
  ///     return Lark(namespace.grammar_file, parser='lalr', **kwargs), namespace.out
  /// ```
  Object? build_lalr({
    required Object? namespace,
  }) =>
      getFunction("build_lalr").call(
        <Object?>[
          namespace,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## make_warnings_comments
  ///
  /// ### python source
  /// ```py
  /// def make_warnings_comments():
  ///     warnings.showwarning = showwarning_as_comment
  /// ```
  Object? make_warnings_comments() =>
      getFunction("make_warnings_comments").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## showwarning_as_comment
  ///
  /// ### python source
  /// ```py
  /// def showwarning_as_comment(message, category, filename, lineno, file=None, line=None):
  ///     # Based on warnings._showwarnmsg_impl
  ///     text = warnings.formatwarning(message, category, filename, lineno, line)
  ///     text = indent(text, '# ')
  ///     if file is None:
  ///         file = sys.stderr
  ///         if file is None:
  ///             return
  ///     try:
  ///         file.write(text)
  ///     except OSError:
  ///         pass
  /// ```
  Object? showwarning_as_comment({
    required Object? message,
    required Object? category,
    required Object? filename,
    required Object? lineno,
    Object? file,
    Object? line,
  }) =>
      getFunction("showwarning_as_comment").call(
        <Object?>[
          message,
          category,
          filename,
          lineno,
          file,
          line,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## sys
  sys get $sys => sys.import();

  /// ## lalr_argparser (getter)
  Object? get lalr_argparser => getAttribute("lalr_argparser");

  /// ## lalr_argparser (setter)
  set lalr_argparser(Object? lalr_argparser) =>
      setAttribute("lalr_argparser", lalr_argparser);

  /// ## logger (getter)
  Object? get logger => getAttribute("logger");

  /// ## logger (setter)
  set logger(Object? logger) => setAttribute("logger", logger);

  /// ## Optional (getter)
  Object? get Optional => getAttribute("Optional");

  /// ## Optional (setter)
  set Optional(Object? Optional) => setAttribute("Optional", Optional);

  /// ## DEBUG (getter)
  Object? get DEBUG => getAttribute("DEBUG");

  /// ## DEBUG (setter)
  set DEBUG(Object? DEBUG) => setAttribute("DEBUG", DEBUG);

  /// ## ERROR (getter)
  Object? get ERROR => getAttribute("ERROR");

  /// ## ERROR (setter)
  set ERROR(Object? ERROR) => setAttribute("ERROR", ERROR);

  /// ## INFO (getter)
  Object? get INFO => getAttribute("INFO");

  /// ## INFO (setter)
  set INFO(Object? INFO) => setAttribute("INFO", INFO);

  /// ## WARN (getter)
  Object? get WARN => getAttribute("WARN");

  /// ## WARN (setter)
  set WARN(Object? WARN) => setAttribute("WARN", WARN);

  /// ## encoding (getter)
  Object? get encoding => getAttribute("encoding");

  /// ## encoding (setter)
  set encoding(Object? encoding) => setAttribute("encoding", encoding);

  /// ## flag (getter)
  Object? get flag => getAttribute("flag");

  /// ## flag (setter)
  set flag(Object? flag) => setAttribute("flag", flag);

  /// ## flags (getter)
  Object? get flags => getAttribute("flags");

  /// ## flags (setter)
  set flags(Object? flags) => setAttribute("flags", flags);

  /// ## has_interegular (getter)
  Object? get has_interegular => getAttribute("has_interegular");

  /// ## has_interegular (setter)
  set has_interegular(Object? has_interegular) =>
      setAttribute("has_interegular", has_interegular);

  /// ## options (getter)
  Object? get options => getAttribute("options");

  /// ## options (setter)
  set options(Object? options) => setAttribute("options", options);
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
