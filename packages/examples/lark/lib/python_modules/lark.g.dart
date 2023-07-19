// ignore_for_file: camel_case_types

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## GrammarError
final class GrammarError extends PythonClass {
  factory GrammarError(String name) => PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "GrammarError",
        GrammarError.from,
        <Object?>[name],
      );

  GrammarError.from(super.pythonClass) : super.from();
}

/// ## LarkError
final class LarkError extends PythonClass {
  factory LarkError(String name) => PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "LarkError",
        LarkError.from,
        <Object?>[name],
      );

  LarkError.from(super.pythonClass) : super.from();
}

/// ## LexError
final class LexError extends PythonClass {
  factory LexError(String name) => PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "LexError",
        LexError.from,
        <Object?>[name],
      );

  LexError.from(super.pythonClass) : super.from();
}

/// ## ParseError
final class ParseError extends PythonClass {
  factory ParseError(String name) => PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "ParseError",
        ParseError.from,
        <Object?>[name],
      );

  ParseError.from(super.pythonClass) : super.from();
}

/// ## UnexpectedCharacters
///
/// ### python docstring
/// An exception that is raised by the lexer, when it cannot match the next
/// string of characters to any of its terminals.
final class UnexpectedCharacters extends PythonClass {
  factory UnexpectedCharacters(String name) =>
      PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "UnexpectedCharacters",
        UnexpectedCharacters.from,
        <Object?>[name],
      );

  UnexpectedCharacters.from(super.pythonClass) : super.from();

  /// ## get_context
  ///
  /// ### python docstring
  /// Returns a pretty string pinpointing the error in the text,
  /// with span amount of context characters around it.
  ///
  /// Note:
  /// The parser doesn't hold a copy of the text it has to parse,
  /// so you have to provide it again
  Object? get_context(Object? self, Object? text, Object? span, Object? pos,
          Object? start, Object? end, Object? before, Object? after) =>
      getFunction("get_context")
          .call(<Object?>[self, text, span, pos, start, end, before, after]);

  /// ## match_examples
  ///
  /// ### python docstring
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
  /// parse_fn: parse function (usually ``lark_instance.parse``)
  /// examples: dictionary of ``{'example_string': value}``.
  /// use_accepts: Recommended to keep this as ``use_accepts=True``.
  Object? match_examples(
          Object? self,
          Object? parse_fn,
          Object? examples,
          Object? token_type_match_fallback,
          Object? use_accepts,
          Object? candidate,
          Object? i,
          Object? label,
          Object? example,
          Object? j,
          Object? malformed,
          Object? ut) =>
      getFunction("match_examples").call(<Object?>[
        self,
        parse_fn,
        examples,
        token_type_match_fallback,
        use_accepts,
        candidate,
        i,
        label,
        example,
        j,
        malformed,
        ut
      ]);
}

/// ## UnexpectedEOF
///
/// ### python docstring
/// An exception that is raised by the parser, when the input ends while it still expects a token.
final class UnexpectedEOF extends PythonClass {
  factory UnexpectedEOF(String name) => PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "UnexpectedEOF",
        UnexpectedEOF.from,
        <Object?>[name],
      );

  UnexpectedEOF.from(super.pythonClass) : super.from();

  /// ## get_context
  ///
  /// ### python docstring
  /// Returns a pretty string pinpointing the error in the text,
  /// with span amount of context characters around it.
  ///
  /// Note:
  /// The parser doesn't hold a copy of the text it has to parse,
  /// so you have to provide it again
  Object? get_context(Object? self, Object? text, Object? span, Object? pos,
          Object? start, Object? end, Object? before, Object? after) =>
      getFunction("get_context")
          .call(<Object?>[self, text, span, pos, start, end, before, after]);

  /// ## match_examples
  ///
  /// ### python docstring
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
  /// parse_fn: parse function (usually ``lark_instance.parse``)
  /// examples: dictionary of ``{'example_string': value}``.
  /// use_accepts: Recommended to keep this as ``use_accepts=True``.
  Object? match_examples(
          Object? self,
          Object? parse_fn,
          Object? examples,
          Object? token_type_match_fallback,
          Object? use_accepts,
          Object? candidate,
          Object? i,
          Object? label,
          Object? example,
          Object? j,
          Object? malformed,
          Object? ut) =>
      getFunction("match_examples").call(<Object?>[
        self,
        parse_fn,
        examples,
        token_type_match_fallback,
        use_accepts,
        candidate,
        i,
        label,
        example,
        j,
        malformed,
        ut
      ]);
}

/// ## UnexpectedInput
///
/// ### python docstring
/// UnexpectedInput Error.
///
/// Used as a base class for the following exceptions:
///
/// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
/// - ``UnexpectedToken``: The parser received an unexpected token
/// - ``UnexpectedEOF``: The parser expected a token, but the input ended
///
/// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
final class UnexpectedInput extends PythonClass {
  factory UnexpectedInput(String name) => PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "UnexpectedInput",
        UnexpectedInput.from,
        <Object?>[name],
      );

  UnexpectedInput.from(super.pythonClass) : super.from();

  /// ## get_context
  ///
  /// ### python docstring
  /// Returns a pretty string pinpointing the error in the text,
  /// with span amount of context characters around it.
  ///
  /// Note:
  /// The parser doesn't hold a copy of the text it has to parse,
  /// so you have to provide it again
  Object? get_context(Object? self, Object? text, Object? span, Object? pos,
          Object? start, Object? end, Object? before, Object? after) =>
      getFunction("get_context")
          .call(<Object?>[self, text, span, pos, start, end, before, after]);

  /// ## match_examples
  ///
  /// ### python docstring
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
  /// parse_fn: parse function (usually ``lark_instance.parse``)
  /// examples: dictionary of ``{'example_string': value}``.
  /// use_accepts: Recommended to keep this as ``use_accepts=True``.
  Object? match_examples(
          Object? self,
          Object? parse_fn,
          Object? examples,
          Object? token_type_match_fallback,
          Object? use_accepts,
          Object? candidate,
          Object? i,
          Object? label,
          Object? example,
          Object? j,
          Object? malformed,
          Object? ut) =>
      getFunction("match_examples").call(<Object?>[
        self,
        parse_fn,
        examples,
        token_type_match_fallback,
        use_accepts,
        candidate,
        i,
        label,
        example,
        j,
        malformed,
        ut
      ]);
}

/// ## UnexpectedToken
///
/// ### python docstring
/// An exception that is raised by the parser, when the token it received
/// doesn't match any valid step forward.
///
/// Parameters:
/// token: The mismatched token
/// expected: The set of expected tokens
/// considered_rules: Which rules were considered, to deduce the expected tokens
/// state: A value representing the parser state. Do not rely on its value or type.
/// interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failture,
/// and can be used for debugging and error handling.
///
/// Note: These parameters are available as attributes of the instance.
final class UnexpectedToken extends PythonClass {
  factory UnexpectedToken(String name) => PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "UnexpectedToken",
        UnexpectedToken.from,
        <Object?>[name],
      );

  UnexpectedToken.from(super.pythonClass) : super.from();

  /// ## get_context
  ///
  /// ### python docstring
  /// Returns a pretty string pinpointing the error in the text,
  /// with span amount of context characters around it.
  ///
  /// Note:
  /// The parser doesn't hold a copy of the text it has to parse,
  /// so you have to provide it again
  Object? get_context(Object? self, Object? text, Object? span, Object? pos,
          Object? start, Object? end, Object? before, Object? after) =>
      getFunction("get_context")
          .call(<Object?>[self, text, span, pos, start, end, before, after]);

  /// ## match_examples
  ///
  /// ### python docstring
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
  /// parse_fn: parse function (usually ``lark_instance.parse``)
  /// examples: dictionary of ``{'example_string': value}``.
  /// use_accepts: Recommended to keep this as ``use_accepts=True``.
  Object? match_examples(
          Object? self,
          Object? parse_fn,
          Object? examples,
          Object? token_type_match_fallback,
          Object? use_accepts,
          Object? candidate,
          Object? i,
          Object? label,
          Object? example,
          Object? j,
          Object? malformed,
          Object? ut) =>
      getFunction("match_examples").call(<Object?>[
        self,
        parse_fn,
        examples,
        token_type_match_fallback,
        use_accepts,
        candidate,
        i,
        label,
        example,
        j,
        malformed,
        ut
      ]);
}

/// ## Lark
///
/// ### python docstring
/// Main interface for the library.
///
/// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
///
/// Parameters:
/// grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
/// options: a dictionary controlling various aspects of Lark.
///
/// Example:
/// >>> Lark(r'''start: "foo" ''')
/// Lark(...)
///
///
///
/// **===  General Options  ===**
///
/// start
/// The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
/// debug
/// Display debug information and extra warnings. Use only when debugging (Default: ``False``)
/// When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
/// transformer
/// Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
/// propagate_positions
/// Propagates (line, column, end_line, end_column) attributes into all tree branches.
/// Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
/// maybe_placeholders
/// When ``True``, the ``[]`` operator returns ``None`` when not matched.
/// When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
/// (default= ``True``)
/// cache
/// Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
///
/// - When ``False``, does nothing (default)
/// - When ``True``, caches to a temporary file in the local directory
/// - When given a string, caches to the path pointed by the string
/// regex
/// When True, uses the ``regex`` module instead of the stdlib ``re``.
/// g_regex_flags
/// Flags that are applied to all terminals (both regex and strings)
/// keep_all_tokens
/// Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
/// tree_class
/// Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
///
/// **=== Algorithm Options ===**
///
/// parser
/// Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
/// (there is also a "cyk" option for legacy)
/// lexer
/// Decides whether or not to use a lexer stage
///
/// - "auto" (default): Choose for me based on the parser
/// - "basic": Use a basic lexer
/// - "contextual": Stronger lexer (only works with parser="lalr")
/// - "dynamic": Flexible and powerful (only with parser="earley")
/// - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
/// ambiguity
/// Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
///
/// - "resolve": The parser will automatically choose the simplest derivation
/// (it chooses consistently: greedy for tokens, non-greedy for rules)
/// - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
/// - "forest": The parser will return the root of the shared packed parse forest.
///
/// **=== Misc. / Domain Specific Options ===**
///
/// postlex
/// Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
/// priority
/// How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
/// lexer_callbacks
/// Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
/// use_bytes
/// Accept an input of type ``bytes`` instead of ``str``.
/// edit_terminals
/// A callback for editing the terminals before parse.
/// import_paths
/// A List of either paths or loader functions to specify from where grammars are imported
/// source_path
/// Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
/// **=== End of Options ===**
final class Lark extends PythonClass {
  factory Lark(String name) => PythonFfiDart.instance.importClass(
        "lark.lark",
        "Lark",
        Lark.from,
        <Object?>[name],
      );

  Lark.from(super.pythonClass) : super.from();

  /// ## get_terminal
  ///
  /// ### python docstring
  /// Get information about a terminal
  Object? get_terminal(Object? self, Object? name) =>
      getFunction("get_terminal").call(<Object?>[self, name]);

  /// ## lex
  ///
  /// ### python docstring
  /// Only lex (and postlex) the text, without parsing it. Only relevant when lexer='basic'
  ///
  /// When dont_ignore=True, the lexer will return all tokens, even those marked for %ignore.
  ///
  /// :raises UnexpectedCharacters: In case the lexer cannot find a suitable match.
  Object? lex(Object? self, Object? text, Object? dont_ignore, Object? lexer,
          Object? lexer_thread, Object? stream) =>
      getFunction("lex").call(
          <Object?>[self, text, dont_ignore, lexer, lexer_thread, stream]);

  /// ## memo_serialize
  Object? memo_serialize(
          Object? self, Object? types_to_memoize, Object? memo) =>
      getFunction("memo_serialize")
          .call(<Object?>[self, types_to_memoize, memo]);

  /// ## parse
  ///
  /// ### python docstring
  /// Parse the given text, according to the options provided.
  ///
  /// Parameters:
  /// text (str): Text to be parsed.
  /// start (str, optional): Required if Lark was given multiple possible start symbols (using the start option).
  /// on_error (function, optional): if provided, will be called on UnexpectedToken error. Return true to resume parsing.
  /// LALR only. See examples/advanced/error_handling.py for an example of how to use on_error.
  ///
  /// Returns:
  /// If a transformer is supplied to ``__init__``, returns whatever is the
  /// result of the transformation. Otherwise, returns a Tree instance.
  ///
  /// :raises UnexpectedInput: On a parse error, one of these sub-exceptions will rise:
  /// ``UnexpectedCharacters``, ``UnexpectedToken``, or ``UnexpectedEOF``.
  /// For convenience, these sub-exceptions also inherit from ``ParserError`` and ``LexerError``.
  Object? parse(Object? self, Object? text, Object? start, Object? on_error) =>
      getFunction("parse").call(<Object?>[self, text, start, on_error]);

  /// ## parse_interactive
  ///
  /// ### python docstring
  /// Start an interactive parsing session.
  ///
  /// Parameters:
  /// text (str, optional): Text to be parsed. Required for ``resume_parse()``.
  /// start (str, optional): Start symbol
  ///
  /// Returns:
  /// A new InteractiveParser instance.
  ///
  /// See Also: ``Lark.parse()``
  Object? parse_interactive(Object? self, Object? text, Object? start) =>
      getFunction("parse_interactive").call(<Object?>[self, text, start]);

  /// ## save
  ///
  /// ### python docstring
  /// Saves the instance into the given file object
  ///
  /// Useful for caching and multiprocessing.
  Object? save(Object? self, Object? f, Object? exclude_options, Object? data,
          Object? m) =>
      getFunction("save").call(<Object?>[self, f, exclude_options, data, m]);

  /// ## serialize
  Object? serialize(Object? self, Object? memo, Object? fields, Object? res) =>
      getFunction("serialize").call(<Object?>[self, memo, fields, res]);
}

/// ## deserialize
final class deserialize extends PythonClass {
  factory deserialize(String name) => PythonFfiDart.instance.importClass(
        "lark.utils",
        "deserialize",
        deserialize.from,
        <Object?>[name],
      );

  deserialize.from(super.pythonClass) : super.from();
}

/// ## load
///
/// ### python docstring
/// Loads an instance from the given file object
///
/// Useful for caching and multiprocessing.
final class load extends PythonClass {
  factory load(String name) => PythonFfiDart.instance.importClass(
        "lark.lark",
        "load",
        load.from,
        <Object?>[name],
      );

  load.from(super.pythonClass) : super.from();
}

/// ## open
///
/// ### python docstring
/// Create an instance of Lark with the grammar given by its filename
///
/// If ``rel_to`` is provided, the function will find the grammar filename in relation to it.
///
/// Example:
///
/// >>> Lark.open("grammar_file.lark", rel_to=__file__, parser="lalr")
/// Lark(...)
final class open extends PythonClass {
  factory open(String name) => PythonFfiDart.instance.importClass(
        "lark.lark",
        "open",
        open.from,
        <Object?>[name],
      );

  open.from(super.pythonClass) : super.from();
}

/// ## open_from_package
///
/// ### python docstring
/// Create an instance of Lark with the grammar loaded from within the package `package`.
/// This allows grammar loading from zipapps.
///
/// Imports in the grammar will use the `package` and `search_paths` provided, through `FromPackageLoader`
///
/// Example:
///
/// Lark.open_from_package(__name__, "example.lark", ("grammars",), parser=...)
final class open_from_package extends PythonClass {
  factory open_from_package(String name) => PythonFfiDart.instance.importClass(
        "lark.lark",
        "open_from_package",
        open_from_package.from,
        <Object?>[name],
      );

  open_from_package.from(super.pythonClass) : super.from();
}

/// ## Token
///
/// ### python docstring
/// A string with meta-information, that is produced by the lexer.
///
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
///
/// Attributes:
/// type: Name of the token (as specified in grammar)
/// value: Value of the token (redundant, as ``token.value == token`` will always be true)
/// start_pos: The index of the token in the text
/// line: The line of the token in the text (starting with 1)
/// column: The column of the token in the text (starting with 1)
/// end_line: The line where the token ends
/// end_column: The next column after the end of the token. For example,
/// if the token is a single character with a column value of 4,
/// end_column will be 5.
/// end_pos: the index where the token ends (basically ``start_pos + len(token)``)
final class Token extends PythonClass {
  factory Token(String name) => PythonFfiDart.instance.importClass(
        "lark.lexer",
        "Token",
        Token.from,
        <Object?>[name],
      );

  Token.from(super.pythonClass) : super.from();

  /// ## update
  Object? update(Object? self, Object? args, Object? kwargs) =>
      getFunction("update").call(<Object?>[self, args, kwargs]);
}

/// ## new_borrow_pos
final class new_borrow_pos extends PythonClass {
  factory new_borrow_pos(String name) => PythonFfiDart.instance.importClass(
        "lark.lexer",
        "new_borrow_pos",
        new_borrow_pos.from,
        <Object?>[name],
      );

  new_borrow_pos.from(super.pythonClass) : super.from();
}

/// ## Tree
final class Tree extends PythonClass {
  factory Tree(String name) => PythonFfiDart.instance.importClass(
        "lark.tree",
        "Tree",
        Tree.from,
        <Object?>[name],
      );

  Tree.from(super.pythonClass) : super.from();

  /// ## copy
  Object? copy(Object? self) => getFunction("copy").call(<Object?>[self]);

  /// ## expand_kids_by_data
  ///
  /// ### python docstring
  /// Expand (inline) children with any of the given data values. Returns True if anything changed
  Object? expand_kids_by_data(Object? self, Object? data_values,
          Object? changed, Object? i, Object? child) =>
      getFunction("expand_kids_by_data")
          .call(<Object?>[self, data_values, changed, i, child]);

  /// ## find_data
  ///
  /// ### python docstring
  /// Returns all nodes of the tree whose data equals the given data.
  Object? find_data(Object? self, Object? data) =>
      getFunction("find_data").call(<Object?>[self, data]);

  /// ## find_pred
  ///
  /// ### python docstring
  /// Returns all nodes of the tree that evaluate pred(node) as true.
  Object? find_pred(Object? self, Object? pred) =>
      getFunction("find_pred").call(<Object?>[self, pred]);

  /// ## iter_subtrees
  ///
  /// ### python docstring
  /// Depth-first iteration.
  ///
  /// Iterates over all the subtrees, never returning to the same node twice (Lark's parse-tree is actually a DAG).
  Object? iter_subtrees(Object? self, Object? queue, Object? subtree) =>
      getFunction("iter_subtrees").call(<Object?>[self, queue, subtree]);

  /// ## iter_subtrees_topdown
  ///
  /// ### python docstring
  /// Breadth-first iteration.
  ///
  /// Iterates over all the subtrees, return nodes in order like pretty() does.
  Object? iter_subtrees_topdown(
          Object? self,
          Object? stack,
          Object? stack_append,
          Object? stack_pop,
          Object? node,
          Object? child) =>
      getFunction("iter_subtrees_topdown")
          .call(<Object?>[self, stack, stack_append, stack_pop, node, child]);

  /// ## pretty
  ///
  /// ### python docstring
  /// Returns an indented string representation of the tree.
  ///
  /// Great for debugging.
  Object? pretty(Object? self, Object? indent_str) =>
      getFunction("pretty").call(<Object?>[self, indent_str]);

  /// ## scan_values
  ///
  /// ### python docstring
  /// Return all values in the tree that evaluate pred(value) as true.
  ///
  /// This can be used to find all the tokens in the tree.
  ///
  /// Example:
  /// >>> all_tokens = tree.scan_values(lambda v: isinstance(v, Token))
  Object? scan_values(Object? self, Object? pred, Object? c, Object? t) =>
      getFunction("scan_values").call(<Object?>[self, pred, c, t]);

  /// ## set
  Object? set(Object? self, Object? data, Object? children) =>
      getFunction("set").call(<Object?>[self, data, children]);
}

/// ## copy_with
final class copy_with extends PythonClass {
  factory copy_with(String name) => PythonFfiDart.instance.importClass(
        "typing",
        "copy_with",
        copy_with.from,
        <Object?>[name],
      );

  copy_with.from(super.pythonClass) : super.from();
}

/// ## addFilter
///
/// ### python docstring
/// Add the specified filter to this handler.
final class addFilter extends PythonClass {
  factory addFilter(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "addFilter",
        addFilter.from,
        <Object?>[name],
      );

  addFilter.from(super.pythonClass) : super.from();
}

/// ## addHandler
///
/// ### python docstring
/// Add the specified handler to this logger.
final class addHandler extends PythonClass {
  factory addHandler(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "addHandler",
        addHandler.from,
        <Object?>[name],
      );

  addHandler.from(super.pythonClass) : super.from();
}

/// ## callHandlers
///
/// ### python docstring
/// Pass a record to all relevant handlers.
///
/// Loop through all handlers for this logger and its parents in the
/// logger hierarchy. If no handler was found, output a one-off error
/// message to sys.stderr. Stop searching up the hierarchy whenever a
/// logger with the "propagate" attribute set to zero is found - that
/// will be the last logger whose handlers are called.
final class callHandlers extends PythonClass {
  factory callHandlers(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "callHandlers",
        callHandlers.from,
        <Object?>[name],
      );

  callHandlers.from(super.pythonClass) : super.from();
}

/// ## critical
///
/// ### python docstring
/// Log 'msg % args' with severity 'CRITICAL'.
///
/// To pass exception information, use the keyword argument exc_info with
/// a true value, e.g.
///
/// logger.critical("Houston, we have a %s", "major disaster", exc_info=1)
final class critical extends PythonClass {
  factory critical(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "critical",
        critical.from,
        <Object?>[name],
      );

  critical.from(super.pythonClass) : super.from();
}

/// ## debug
///
/// ### python docstring
/// Log 'msg % args' with severity 'DEBUG'.
///
/// To pass exception information, use the keyword argument exc_info with
/// a true value, e.g.
///
/// logger.debug("Houston, we have a %s", "thorny problem", exc_info=1)
final class debug extends PythonClass {
  factory debug(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "debug",
        debug.from,
        <Object?>[name],
      );

  debug.from(super.pythonClass) : super.from();
}

/// ## error
///
/// ### python docstring
/// Log 'msg % args' with severity 'ERROR'.
///
/// To pass exception information, use the keyword argument exc_info with
/// a true value, e.g.
///
/// logger.error("Houston, we have a %s", "major problem", exc_info=1)
final class error extends PythonClass {
  factory error(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "error",
        error.from,
        <Object?>[name],
      );

  error.from(super.pythonClass) : super.from();
}

/// ## exception
///
/// ### python docstring
/// Convenience method for logging an ERROR with exception information.
final class exception extends PythonClass {
  factory exception(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "exception",
        exception.from,
        <Object?>[name],
      );

  exception.from(super.pythonClass) : super.from();
}

/// ## fatal
///
/// ### python docstring
/// Don't use this method, use critical() instead.
final class fatal extends PythonClass {
  factory fatal(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "fatal",
        fatal.from,
        <Object?>[name],
      );

  fatal.from(super.pythonClass) : super.from();
}

/// ## filter
///
/// ### python docstring
/// Determine if a record is loggable by consulting all the filters.
///
/// The default is to allow the record to be logged; any filter can veto
/// this and the record is then dropped. Returns a zero value if a record
/// is to be dropped, else non-zero.
///
/// .. versionchanged:: 3.2
///
/// Allow filters to be just callables.
final class filter extends PythonClass {
  factory filter(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "filter",
        filter.from,
        <Object?>[name],
      );

  filter.from(super.pythonClass) : super.from();
}

/// ## findCaller
///
/// ### python docstring
/// Find the stack frame of the caller so that we can note the source
/// file name, line number and function name.
final class findCaller extends PythonClass {
  factory findCaller(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "findCaller",
        findCaller.from,
        <Object?>[name],
      );

  findCaller.from(super.pythonClass) : super.from();
}

/// ## getChild
///
/// ### python docstring
/// Get a logger which is a descendant to this one.
///
/// This is a convenience method, such that
///
/// logging.getLogger('abc').getChild('def.ghi')
///
/// is the same as
///
/// logging.getLogger('abc.def.ghi')
///
/// It's useful, for example, when the parent logger is named using
/// __name__ rather than a literal string.
final class getChild extends PythonClass {
  factory getChild(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "getChild",
        getChild.from,
        <Object?>[name],
      );

  getChild.from(super.pythonClass) : super.from();
}

/// ## getEffectiveLevel
///
/// ### python docstring
/// Get the effective level for this logger.
///
/// Loop through this logger and its parents in the logger hierarchy,
/// looking for a non-zero logging level. Return the first one found.
final class getEffectiveLevel extends PythonClass {
  factory getEffectiveLevel(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "getEffectiveLevel",
        getEffectiveLevel.from,
        <Object?>[name],
      );

  getEffectiveLevel.from(super.pythonClass) : super.from();
}

/// ## handle
///
/// ### python docstring
/// Call the handlers for the specified record.
///
/// This method is used for unpickled records received from a socket, as
/// well as those created locally. Logger-level filtering is applied.
final class handle extends PythonClass {
  factory handle(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "handle",
        handle.from,
        <Object?>[name],
      );

  handle.from(super.pythonClass) : super.from();
}

/// ## hasHandlers
///
/// ### python docstring
/// See if this logger has any handlers configured.
///
/// Loop through all handlers for this logger and its parents in the
/// logger hierarchy. Return True if a handler was found, else False.
/// Stop searching up the hierarchy whenever a logger with the "propagate"
/// attribute set to zero is found - that will be the last logger which
/// is checked for the existence of handlers.
final class hasHandlers extends PythonClass {
  factory hasHandlers(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "hasHandlers",
        hasHandlers.from,
        <Object?>[name],
      );

  hasHandlers.from(super.pythonClass) : super.from();
}

/// ## info
///
/// ### python docstring
/// Log 'msg % args' with severity 'INFO'.
///
/// To pass exception information, use the keyword argument exc_info with
/// a true value, e.g.
///
/// logger.info("Houston, we have a %s", "interesting problem", exc_info=1)
final class info extends PythonClass {
  factory info(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "info",
        info.from,
        <Object?>[name],
      );

  info.from(super.pythonClass) : super.from();
}

/// ## isEnabledFor
///
/// ### python docstring
/// Is this logger enabled for level 'level'?
final class isEnabledFor extends PythonClass {
  factory isEnabledFor(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "isEnabledFor",
        isEnabledFor.from,
        <Object?>[name],
      );

  isEnabledFor.from(super.pythonClass) : super.from();
}

/// ## log
///
/// ### python docstring
/// Log 'msg % args' with the integer severity 'level'.
///
/// To pass exception information, use the keyword argument exc_info with
/// a true value, e.g.
///
/// logger.log(level, "We have a %s", "mysterious problem", exc_info=1)
final class log extends PythonClass {
  factory log(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "log",
        log.from,
        <Object?>[name],
      );

  log.from(super.pythonClass) : super.from();
}

/// ## makeRecord
///
/// ### python docstring
/// A factory method which can be overridden in subclasses to create
/// specialized LogRecords.
final class makeRecord extends PythonClass {
  factory makeRecord(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "makeRecord",
        makeRecord.from,
        <Object?>[name],
      );

  makeRecord.from(super.pythonClass) : super.from();
}

/// ## getLogger
///
/// ### python docstring
/// Get a logger with the specified name (channel name), creating it
/// if it doesn't yet exist. This name is a dot-separated hierarchical
/// name, such as "a", "a.b", "a.b.c" or similar.
///
/// If a PlaceHolder existed for the specified name [i.e. the logger
/// didn't exist but a child of it did], replace it with the created
/// logger and fix up the parent/child references which pointed to the
/// placeholder to now point to the logger.
final class getLogger extends PythonClass {
  factory getLogger(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "getLogger",
        getLogger.from,
        <Object?>[name],
      );

  getLogger.from(super.pythonClass) : super.from();
}

/// ## removeFilter
///
/// ### python docstring
/// Remove the specified filter from this handler.
final class removeFilter extends PythonClass {
  factory removeFilter(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "removeFilter",
        removeFilter.from,
        <Object?>[name],
      );

  removeFilter.from(super.pythonClass) : super.from();
}

/// ## removeHandler
///
/// ### python docstring
/// Remove the specified handler from this logger.
final class removeHandler extends PythonClass {
  factory removeHandler(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "removeHandler",
        removeHandler.from,
        <Object?>[name],
      );

  removeHandler.from(super.pythonClass) : super.from();
}

/// ## setLevel
///
/// ### python docstring
/// Set the logging level of this logger.  level must be an int or a str.
final class setLevel extends PythonClass {
  factory setLevel(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "setLevel",
        setLevel.from,
        <Object?>[name],
      );

  setLevel.from(super.pythonClass) : super.from();
}

/// ## warn
final class warn extends PythonClass {
  factory warn(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "warn",
        warn.from,
        <Object?>[name],
      );

  warn.from(super.pythonClass) : super.from();
}

/// ## warning
///
/// ### python docstring
/// Log 'msg % args' with severity 'WARNING'.
///
/// To pass exception information, use the keyword argument exc_info with
/// a true value, e.g.
///
/// logger.warning("Houston, we have a %s", "bit of a problem", exc_info=1)
final class warning extends PythonClass {
  factory warning(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "warning",
        warning.from,
        <Object?>[name],
      );

  warning.from(super.pythonClass) : super.from();
}

/// ## setLogRecordFactory
///
/// ### python docstring
/// Set the factory to be used when instantiating a log record with this
/// Manager.
final class setLogRecordFactory extends PythonClass {
  factory setLogRecordFactory(String name) =>
      PythonFfiDart.instance.importClass(
        "logging",
        "setLogRecordFactory",
        setLogRecordFactory.from,
        <Object?>[name],
      );

  setLogRecordFactory.from(super.pythonClass) : super.from();
}

/// ## setLoggerClass
///
/// ### python docstring
/// Set the class to be used when instantiating a logger with this Manager.
final class setLoggerClass extends PythonClass {
  factory setLoggerClass(String name) => PythonFfiDart.instance.importClass(
        "logging",
        "setLoggerClass",
        setLoggerClass.from,
        <Object?>[name],
      );

  setLoggerClass.from(super.pythonClass) : super.from();
}

/// ## Transformer
///
/// ### python docstring
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
/// visit_tokens (bool, optional): Should the transformer visit tokens in addition to rules.
/// Setting this to ``False`` is slightly faster. Defaults to ``True``.
/// (For processing ignored tokens, use the ``lexer_callbacks`` options)
final class Transformer extends PythonClass {
  factory Transformer(String name) => PythonFfiDart.instance.importClass(
        "lark.visitors",
        "Transformer",
        Transformer.from,
        <Object?>[name],
      );

  Transformer.from(super.pythonClass) : super.from();

  /// ## transform
  ///
  /// ### python docstring
  /// Transform the given tree, and return the final result
  Object? transform(Object? self, Object? tree) =>
      getFunction("transform").call(<Object?>[self, tree]);
}

/// ## Transformer_NonRecursive
///
/// ### python docstring
/// Same as Transformer but non-recursive.
///
/// Like Transformer, it doesn't change the original tree.
///
/// Useful for huge trees.
final class Transformer_NonRecursive extends PythonClass {
  factory Transformer_NonRecursive(String name) =>
      PythonFfiDart.instance.importClass(
        "lark.visitors",
        "Transformer_NonRecursive",
        Transformer_NonRecursive.from,
        <Object?>[name],
      );

  Transformer_NonRecursive.from(super.pythonClass) : super.from();

  /// ## transform
  Object? transform(
          Object? self,
          Object? tree,
          Object? rev_postfix,
          Object? q,
          Object? t,
          Object? stack,
          Object? x,
          Object? size,
          Object? args,
          Object? res,
          Object? result) =>
      getFunction("transform").call(<Object?>[
        self,
        tree,
        rev_postfix,
        q,
        t,
        stack,
        x,
        size,
        args,
        res,
        result
      ]);
}

/// ## Visitor
///
/// ### python docstring
/// Tree visitor, non-recursive (can handle huge trees).
///
/// Visiting a node calls its methods (provided by the user via inheritance) according to ``tree.data``
final class Visitor extends PythonClass {
  factory Visitor(String name) => PythonFfiDart.instance.importClass(
        "lark.visitors",
        "Visitor",
        Visitor.from,
        <Object?>[name],
      );

  Visitor.from(super.pythonClass) : super.from();

  /// ## visit
  ///
  /// ### python docstring
  /// Visits the tree, starting with the leaves and finally the root (bottom-up)
  Object? visit(Object? self, Object? tree, Object? subtree) =>
      getFunction("visit").call(<Object?>[self, tree, subtree]);

  /// ## visit_topdown
  ///
  /// ### python docstring
  /// Visit the tree, starting at the root, and ending at the leaves (top-down)
  Object? visit_topdown(Object? self, Object? tree, Object? subtree) =>
      getFunction("visit_topdown").call(<Object?>[self, tree, subtree]);
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

  static lark import() =>
      PythonFfiDart.instance.importModule("lark", lark.from);

  /// ## v_args
  ///
  /// ### python docstring
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
  /// inline (bool, optional): Children are provided as ``*args`` instead of a list argument (not recommended for very long lists).
  /// meta (bool, optional): Provides two arguments: ``children`` and ``meta`` (instead of just the first)
  /// tree (bool, optional): Provides the entire tree as the argument, instead of the children.
  /// wrapper (function, optional): Provide a function to decorate all methods.
  ///
  /// Example:
  /// ::
  ///
  /// @v_args(inline=True)
  /// class SolveArith(Transformer):
  /// def add(self, left, right):
  /// return left + right
  ///
  ///
  /// class ReverseNotation(Transformer_InPlace):
  /// @v_args(tree=True)
  /// def tree_node(self, tree):
  /// tree.children = tree.children[::-1]
  Object? v_args(Object? inline, Object? meta, Object? tree, Object? wrapper) =>
      getFunction("v_args").call(<Object?>[inline, meta, tree, wrapper]);
}
