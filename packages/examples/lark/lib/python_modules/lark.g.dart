// ignore_for_file: camel_case_types

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## GrammarError
/// ### debug info
/// ```
/// Pointer: address=0x7f935e817390
/// ```
final class GrammarError extends PythonClass {
  factory GrammarError(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "GrammarError",
        GrammarError.from,
        <Object?>[name],
      );

  GrammarError.from(super.pythonClass) : super.from();
}

/// ## add_note
/// ### debug info
/// ```
/// Pointer: address=0x117845490
/// ```
final class add_note extends PythonClass {
  factory add_note(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "add_note",
        add_note.from,
        <Object?>[name],
      );

  add_note.from(super.pythonClass) : super.from();
}

/// ## with_traceback
/// ### debug info
/// ```
/// Pointer: address=0x117845440
/// ```
final class with_traceback extends PythonClass {
  factory with_traceback(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "with_traceback",
        with_traceback.from,
        <Object?>[name],
      );

  with_traceback.from(super.pythonClass) : super.from();
}

/// ## LarkError
/// ### debug info
/// ```
/// Pointer: address=0x7f935e816c10
/// ```
final class LarkError extends PythonClass {
  factory LarkError(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "LarkError",
        LarkError.from,
        <Object?>[name],
      );

  LarkError.from(super.pythonClass) : super.from();
}

/// ## LexError
/// ### debug info
/// ```
/// Pointer: address=0x7f935e83dc80
/// ```
final class LexError extends PythonClass {
  factory LexError(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "LexError",
        LexError.from,
        <Object?>[name],
      );

  LexError.from(super.pythonClass) : super.from();
}

/// ## ParseError
/// ### debug info
/// ```
/// Pointer: address=0x7f935e817750
/// ```
final class ParseError extends PythonClass {
  factory ParseError(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "ParseError",
        ParseError.from,
        <Object?>[name],
      );

  ParseError.from(super.pythonClass) : super.from();
}

/// ## UnexpectedCharacters
/// ### debug info
/// ```
/// Pointer: address=0x7f935e83e7c0
/// ```
///
/// ### python docstring
/// An exception that is raised by the lexer, when it cannot match the next
///     string of characters to any of its terminals.
final class UnexpectedCharacters extends PythonClass {
  factory UnexpectedCharacters(String name) =>
      PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "UnexpectedCharacters",
        UnexpectedCharacters.from,
        <Object?>[name],
      );

  UnexpectedCharacters.from(super.pythonClass) : super.from();

  /// ## get_context
  ///
  /// ### python docstring
  /// Returns a pretty string pinpointing the error in the text,
  ///         with span amount of context characters around it.
  ///
  ///         Note:
  ///             The parser doesn't hold a copy of the text it has to parse,
  ///             so you have to provide it again
  Object? get_context(Object? self, Object? text, Object? span, Object? pos,
          Object? start, Object? end, Object? before, Object? after) =>
      getFunction("get_context")
          .call(<Object?>[self, text, span, pos, start, end, before, after]);

  /// ## match_examples
  ///
  /// ### python docstring
  /// Allows you to detect what's wrong in the input text by matching
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
/// ### debug info
/// ```
/// Pointer: address=0x7f935e83e400
/// ```
///
/// ### python docstring
/// An exception that is raised by the parser, when the input ends while it still expects a token.
final class UnexpectedEOF extends PythonClass {
  factory UnexpectedEOF(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "UnexpectedEOF",
        UnexpectedEOF.from,
        <Object?>[name],
      );

  UnexpectedEOF.from(super.pythonClass) : super.from();

  /// ## get_context
  ///
  /// ### python docstring
  /// Returns a pretty string pinpointing the error in the text,
  ///         with span amount of context characters around it.
  ///
  ///         Note:
  ///             The parser doesn't hold a copy of the text it has to parse,
  ///             so you have to provide it again
  Object? get_context(Object? self, Object? text, Object? span, Object? pos,
          Object? start, Object? end, Object? before, Object? after) =>
      getFunction("get_context")
          .call(<Object?>[self, text, span, pos, start, end, before, after]);

  /// ## match_examples
  ///
  /// ### python docstring
  /// Allows you to detect what's wrong in the input text by matching
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
/// ### debug info
/// ```
/// Pointer: address=0x7f935e83e040
/// ```
///
/// ### python docstring
/// UnexpectedInput Error.
///
///     Used as a base class for the following exceptions:
///
///     - ``UnexpectedCharacters``: The lexer encountered an unexpected string
///     - ``UnexpectedToken``: The parser received an unexpected token
///     - ``UnexpectedEOF``: The parser expected a token, but the input ended
///
///     After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
final class UnexpectedInput extends PythonClass {
  factory UnexpectedInput(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "UnexpectedInput",
        UnexpectedInput.from,
        <Object?>[name],
      );

  UnexpectedInput.from(super.pythonClass) : super.from();

  /// ## get_context
  ///
  /// ### python docstring
  /// Returns a pretty string pinpointing the error in the text,
  ///         with span amount of context characters around it.
  ///
  ///         Note:
  ///             The parser doesn't hold a copy of the text it has to parse,
  ///             so you have to provide it again
  Object? get_context(Object? self, Object? text, Object? span, Object? pos,
          Object? start, Object? end, Object? before, Object? after) =>
      getFunction("get_context")
          .call(<Object?>[self, text, span, pos, start, end, before, after]);

  /// ## match_examples
  ///
  /// ### python docstring
  /// Allows you to detect what's wrong in the input text by matching
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
/// ### debug info
/// ```
/// Pointer: address=0x7f935e83eb80
/// ```
///
/// ### python docstring
/// An exception that is raised by the parser, when the token it received
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
final class UnexpectedToken extends PythonClass {
  factory UnexpectedToken(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "UnexpectedToken",
        UnexpectedToken.from,
        <Object?>[name],
      );

  UnexpectedToken.from(super.pythonClass) : super.from();

  /// ## get_context
  ///
  /// ### python docstring
  /// Returns a pretty string pinpointing the error in the text,
  ///         with span amount of context characters around it.
  ///
  ///         Note:
  ///             The parser doesn't hold a copy of the text it has to parse,
  ///             so you have to provide it again
  Object? get_context(Object? self, Object? text, Object? span, Object? pos,
          Object? start, Object? end, Object? before, Object? after) =>
      getFunction("get_context")
          .call(<Object?>[self, text, span, pos, start, end, before, after]);

  /// ## match_examples
  ///
  /// ### python docstring
  /// Allows you to detect what's wrong in the input text by matching
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

/// ## deleter
/// ### debug info
/// ```
/// Pointer: address=0x12a9c8a90
/// ```
final class deleter extends PythonClass {
  factory deleter(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "deleter",
        deleter.from,
        <Object?>[name],
      );

  deleter.from(super.pythonClass) : super.from();
}

/// ## getter
/// ### debug info
/// ```
/// Pointer: address=0x1197826b0
/// ```
final class getter extends PythonClass {
  factory getter(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "getter",
        getter.from,
        <Object?>[name],
      );

  getter.from(super.pythonClass) : super.from();
}

/// ## setter
/// ### debug info
/// ```
/// Pointer: address=0x119782930
/// ```
final class setter extends PythonClass {
  factory setter(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "setter",
        setter.from,
        <Object?>[name],
      );

  setter.from(super.pythonClass) : super.from();
}

/// ## Lark
/// ### debug info
/// ```
/// Pointer: address=0x7f935e884090
/// ```
///
/// ### python docstring
/// Main interface for the library.
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
///
///
///
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
final class Lark extends PythonClass {
  factory Lark(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
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
  ///         When dont_ignore=True, the lexer will return all tokens, even those marked for %ignore.
  ///
  ///         :raises UnexpectedCharacters: In case the lexer cannot find a suitable match.
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
  Object? parse(Object? self, Object? text, Object? start, Object? on_error) =>
      getFunction("parse").call(<Object?>[self, text, start, on_error]);

  /// ## parse_interactive
  ///
  /// ### python docstring
  /// Start an interactive parsing session.
  ///
  ///         Parameters:
  ///             text (str, optional): Text to be parsed. Required for ``resume_parse()``.
  ///             start (str, optional): Start symbol
  ///
  ///         Returns:
  ///             A new InteractiveParser instance.
  ///
  ///         See Also: ``Lark.parse()``
  Object? parse_interactive(Object? self, Object? text, Object? start) =>
      getFunction("parse_interactive").call(<Object?>[self, text, start]);

  /// ## save
  ///
  /// ### python docstring
  /// Saves the instance into the given file object
  ///
  ///         Useful for caching and multiprocessing.
  Object? save(Object? self, Object? f, Object? exclude_options, Object? data,
          Object? m) =>
      getFunction("save").call(<Object?>[self, f, exclude_options, data, m]);

  /// ## serialize
  Object? serialize(Object? self, Object? memo, Object? fields, Object? res) =>
      getFunction("serialize").call(<Object?>[self, memo, fields, res]);
}

/// ## deserialize
/// ### debug info
/// ```
/// Pointer: address=0x12abb9cc0
/// ```
final class deserialize extends PythonClass {
  factory deserialize(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "deserialize",
        deserialize.from,
        <Object?>[name],
      );

  deserialize.from(super.pythonClass) : super.from();
}

/// ## load
/// ### debug info
/// ```
/// Pointer: address=0x12ab7ab80
/// ```
///
/// ### python docstring
/// Loads an instance from the given file object
///
///         Useful for caching and multiprocessing.
final class load extends PythonClass {
  factory load(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "load",
        load.from,
        <Object?>[name],
      );

  load.from(super.pythonClass) : super.from();
}

/// ## open
/// ### debug info
/// ```
/// Pointer: address=0x12ab7a800
/// ```
///
/// ### python docstring
/// Create an instance of Lark with the grammar given by its filename
///
///         If ``rel_to`` is provided, the function will find the grammar filename in relation to it.
///
///         Example:
///
///             >>> Lark.open("grammar_file.lark", rel_to=__file__, parser="lalr")
///             Lark(...)
final class open extends PythonClass {
  factory open(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "open",
        open.from,
        <Object?>[name],
      );

  open.from(super.pythonClass) : super.from();
}

/// ## open_from_package
/// ### debug info
/// ```
/// Pointer: address=0x12ab7a600
/// ```
///
/// ### python docstring
/// Create an instance of Lark with the grammar loaded from within the package `package`.
///         This allows grammar loading from zipapps.
///
///         Imports in the grammar will use the `package` and `search_paths` provided, through `FromPackageLoader`
///
///         Example:
///
///             Lark.open_from_package(__name__, "example.lark", ("grammars",), parser=...)
final class open_from_package extends PythonClass {
  factory open_from_package(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "open_from_package",
        open_from_package.from,
        <Object?>[name],
      );

  open_from_package.from(super.pythonClass) : super.from();
}

/// ## Token
/// ### debug info
/// ```
/// Pointer: address=0x7f935f81ce10
/// ```
///
/// ### python docstring
/// A string with meta-information, that is produced by the lexer.
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
final class Token extends PythonClass {
  factory Token(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "Token",
        Token.from,
        <Object?>[name],
      );

  Token.from(super.pythonClass) : super.from();

  /// ## update
  Object? update(Object? self, Object? args, Object? kwargs) =>
      getFunction("update").call(<Object?>[self, args, kwargs]);
}

/// ## capitalize
/// ### debug info
/// ```
/// Pointer: address=0x117834130
/// ```
final class capitalize extends PythonClass {
  factory capitalize(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "capitalize",
        capitalize.from,
        <Object?>[name],
      );

  capitalize.from(super.pythonClass) : super.from();
}

/// ## casefold
/// ### debug info
/// ```
/// Pointer: address=0x117834180
/// ```
final class casefold extends PythonClass {
  factory casefold(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "casefold",
        casefold.from,
        <Object?>[name],
      );

  casefold.from(super.pythonClass) : super.from();
}

/// ## center
/// ### debug info
/// ```
/// Pointer: address=0x117834220
/// ```
final class center extends PythonClass {
  factory center(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "center",
        center.from,
        <Object?>[name],
      );

  center.from(super.pythonClass) : super.from();
}

/// ## count
/// ### debug info
/// ```
/// Pointer: address=0x117834270
/// ```
final class count extends PythonClass {
  factory count(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "count",
        count.from,
        <Object?>[name],
      );

  count.from(super.pythonClass) : super.from();
}

/// ## encode
/// ### debug info
/// ```
/// Pointer: address=0x11782ff60
/// ```
final class encode extends PythonClass {
  factory encode(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "encode",
        encode.from,
        <Object?>[name],
      );

  encode.from(super.pythonClass) : super.from();
}

/// ## endswith
/// ### debug info
/// ```
/// Pointer: address=0x117834860
/// ```
final class endswith extends PythonClass {
  factory endswith(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "endswith",
        endswith.from,
        <Object?>[name],
      );

  endswith.from(super.pythonClass) : super.from();
}

/// ## expandtabs
/// ### debug info
/// ```
/// Pointer: address=0x1178342c0
/// ```
final class expandtabs extends PythonClass {
  factory expandtabs(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "expandtabs",
        expandtabs.from,
        <Object?>[name],
      );

  expandtabs.from(super.pythonClass) : super.from();
}

/// ## find
/// ### debug info
/// ```
/// Pointer: address=0x117834310
/// ```
final class find extends PythonClass {
  factory find(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "find",
        find.from,
        <Object?>[name],
      );

  find.from(super.pythonClass) : super.from();
}

/// ## format
/// ### debug info
/// ```
/// Pointer: address=0x117834d60
/// ```
final class format extends PythonClass {
  factory format(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "format",
        format.from,
        <Object?>[name],
      );

  format.from(super.pythonClass) : super.from();
}

/// ## format_map
/// ### debug info
/// ```
/// Pointer: address=0x117834db0
/// ```
final class format_map extends PythonClass {
  factory format_map(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "format_map",
        format_map.from,
        <Object?>[name],
      );

  format_map.from(super.pythonClass) : super.from();
}

/// ## index
/// ### debug info
/// ```
/// Pointer: address=0x1178343b0
/// ```
final class index extends PythonClass {
  factory index(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "index",
        index.from,
        <Object?>[name],
      );

  index.from(super.pythonClass) : super.from();
}

/// ## isalnum
/// ### debug info
/// ```
/// Pointer: address=0x117834c20
/// ```
final class isalnum extends PythonClass {
  factory isalnum(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "isalnum",
        isalnum.from,
        <Object?>[name],
      );

  isalnum.from(super.pythonClass) : super.from();
}

/// ## isalpha
/// ### debug info
/// ```
/// Pointer: address=0x117834bd0
/// ```
final class isalpha extends PythonClass {
  factory isalpha(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "isalpha",
        isalpha.from,
        <Object?>[name],
      );

  isalpha.from(super.pythonClass) : super.from();
}

/// ## isascii
/// ### debug info
/// ```
/// Pointer: address=0x117834950
/// ```
final class isascii extends PythonClass {
  factory isascii(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "isascii",
        isascii.from,
        <Object?>[name],
      );

  isascii.from(super.pythonClass) : super.from();
}

/// ## isdecimal
/// ### debug info
/// ```
/// Pointer: address=0x117834ae0
/// ```
final class isdecimal extends PythonClass {
  factory isdecimal(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "isdecimal",
        isdecimal.from,
        <Object?>[name],
      );

  isdecimal.from(super.pythonClass) : super.from();
}

/// ## isdigit
/// ### debug info
/// ```
/// Pointer: address=0x117834b30
/// ```
final class isdigit extends PythonClass {
  factory isdigit(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "isdigit",
        isdigit.from,
        <Object?>[name],
      );

  isdigit.from(super.pythonClass) : super.from();
}

/// ## isidentifier
/// ### debug info
/// ```
/// Pointer: address=0x117834c70
/// ```
final class isidentifier extends PythonClass {
  factory isidentifier(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "isidentifier",
        isidentifier.from,
        <Object?>[name],
      );

  isidentifier.from(super.pythonClass) : super.from();
}

/// ## islower
/// ### debug info
/// ```
/// Pointer: address=0x1178349a0
/// ```
final class islower extends PythonClass {
  factory islower(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "islower",
        islower.from,
        <Object?>[name],
      );

  islower.from(super.pythonClass) : super.from();
}

/// ## isnumeric
/// ### debug info
/// ```
/// Pointer: address=0x117834b80
/// ```
final class isnumeric extends PythonClass {
  factory isnumeric(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "isnumeric",
        isnumeric.from,
        <Object?>[name],
      );

  isnumeric.from(super.pythonClass) : super.from();
}

/// ## isprintable
/// ### debug info
/// ```
/// Pointer: address=0x117834cc0
/// ```
final class isprintable extends PythonClass {
  factory isprintable(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "isprintable",
        isprintable.from,
        <Object?>[name],
      );

  isprintable.from(super.pythonClass) : super.from();
}

/// ## isspace
/// ### debug info
/// ```
/// Pointer: address=0x117834a90
/// ```
final class isspace extends PythonClass {
  factory isspace(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "isspace",
        isspace.from,
        <Object?>[name],
      );

  isspace.from(super.pythonClass) : super.from();
}

/// ## istitle
/// ### debug info
/// ```
/// Pointer: address=0x117834a40
/// ```
final class istitle extends PythonClass {
  factory istitle(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "istitle",
        istitle.from,
        <Object?>[name],
      );

  istitle.from(super.pythonClass) : super.from();
}

/// ## isupper
/// ### debug info
/// ```
/// Pointer: address=0x1178349f0
/// ```
final class isupper extends PythonClass {
  factory isupper(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "isupper",
        isupper.from,
        <Object?>[name],
      );

  isupper.from(super.pythonClass) : super.from();
}

/// ## join
/// ### debug info
/// ```
/// Pointer: address=0x1178340e0
/// ```
final class join extends PythonClass {
  factory join(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "join",
        join.from,
        <Object?>[name],
      );

  join.from(super.pythonClass) : super.from();
}

/// ## ljust
/// ### debug info
/// ```
/// Pointer: address=0x117834400
/// ```
final class ljust extends PythonClass {
  factory ljust(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "ljust",
        ljust.from,
        <Object?>[name],
      );

  ljust.from(super.pythonClass) : super.from();
}

/// ## lower
/// ### debug info
/// ```
/// Pointer: address=0x117834450
/// ```
final class lower extends PythonClass {
  factory lower(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "lower",
        lower.from,
        <Object?>[name],
      );

  lower.from(super.pythonClass) : super.from();
}

/// ## lstrip
/// ### debug info
/// ```
/// Pointer: address=0x1178344a0
/// ```
final class lstrip extends PythonClass {
  factory lstrip(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "lstrip",
        lstrip.from,
        <Object?>[name],
      );

  lstrip.from(super.pythonClass) : super.from();
}

/// ## maketrans
/// ### debug info
/// ```
/// Pointer: address=0x117834e50
/// ```
final class maketrans extends PythonClass {
  factory maketrans(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "maketrans",
        maketrans.from,
        <Object?>[name],
      );

  maketrans.from(super.pythonClass) : super.from();
}

/// ## new_borrow_pos
/// ### debug info
/// ```
/// Pointer: address=0x12abb5c40
/// ```
final class new_borrow_pos extends PythonClass {
  factory new_borrow_pos(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "new_borrow_pos",
        new_borrow_pos.from,
        <Object?>[name],
      );

  new_borrow_pos.from(super.pythonClass) : super.from();
}

/// ## partition
/// ### debug info
/// ```
/// Pointer: address=0x117834360
/// ```
final class partition extends PythonClass {
  factory partition(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "partition",
        partition.from,
        <Object?>[name],
      );

  partition.from(super.pythonClass) : super.from();
}

/// ## removeprefix
/// ### debug info
/// ```
/// Pointer: address=0x1178348b0
/// ```
final class removeprefix extends PythonClass {
  factory removeprefix(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "removeprefix",
        removeprefix.from,
        <Object?>[name],
      );

  removeprefix.from(super.pythonClass) : super.from();
}

/// ## removesuffix
/// ### debug info
/// ```
/// Pointer: address=0x117834900
/// ```
final class removesuffix extends PythonClass {
  factory removesuffix(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "removesuffix",
        removesuffix.from,
        <Object?>[name],
      );

  removesuffix.from(super.pythonClass) : super.from();
}

/// ## replace
/// ### debug info
/// ```
/// Pointer: address=0x11782ffb0
/// ```
final class replace extends PythonClass {
  factory replace(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "replace",
        replace.from,
        <Object?>[name],
      );

  replace.from(super.pythonClass) : super.from();
}

/// ## rfind
/// ### debug info
/// ```
/// Pointer: address=0x1178344f0
/// ```
final class rfind extends PythonClass {
  factory rfind(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "rfind",
        rfind.from,
        <Object?>[name],
      );

  rfind.from(super.pythonClass) : super.from();
}

/// ## rindex
/// ### debug info
/// ```
/// Pointer: address=0x117834540
/// ```
final class rindex extends PythonClass {
  factory rindex(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "rindex",
        rindex.from,
        <Object?>[name],
      );

  rindex.from(super.pythonClass) : super.from();
}

/// ## rjust
/// ### debug info
/// ```
/// Pointer: address=0x117834590
/// ```
final class rjust extends PythonClass {
  factory rjust(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "rjust",
        rjust.from,
        <Object?>[name],
      );

  rjust.from(super.pythonClass) : super.from();
}

/// ## rpartition
/// ### debug info
/// ```
/// Pointer: address=0x117834630
/// ```
final class rpartition extends PythonClass {
  factory rpartition(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "rpartition",
        rpartition.from,
        <Object?>[name],
      );

  rpartition.from(super.pythonClass) : super.from();
}

/// ## rsplit
/// ### debug info
/// ```
/// Pointer: address=0x117834090
/// ```
final class rsplit extends PythonClass {
  factory rsplit(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "rsplit",
        rsplit.from,
        <Object?>[name],
      );

  rsplit.from(super.pythonClass) : super.from();
}

/// ## rstrip
/// ### debug info
/// ```
/// Pointer: address=0x1178345e0
/// ```
final class rstrip extends PythonClass {
  factory rstrip(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "rstrip",
        rstrip.from,
        <Object?>[name],
      );

  rstrip.from(super.pythonClass) : super.from();
}

/// ## split
/// ### debug info
/// ```
/// Pointer: address=0x117834040
/// ```
final class split extends PythonClass {
  factory split(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "split",
        split.from,
        <Object?>[name],
      );

  split.from(super.pythonClass) : super.from();
}

/// ## splitlines
/// ### debug info
/// ```
/// Pointer: address=0x117834680
/// ```
final class splitlines extends PythonClass {
  factory splitlines(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "splitlines",
        splitlines.from,
        <Object?>[name],
      );

  splitlines.from(super.pythonClass) : super.from();
}

/// ## startswith
/// ### debug info
/// ```
/// Pointer: address=0x117834810
/// ```
final class startswith extends PythonClass {
  factory startswith(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "startswith",
        startswith.from,
        <Object?>[name],
      );

  startswith.from(super.pythonClass) : super.from();
}

/// ## strip
/// ### debug info
/// ```
/// Pointer: address=0x1178346d0
/// ```
final class strip extends PythonClass {
  factory strip(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "strip",
        strip.from,
        <Object?>[name],
      );

  strip.from(super.pythonClass) : super.from();
}

/// ## swapcase
/// ### debug info
/// ```
/// Pointer: address=0x117834720
/// ```
final class swapcase extends PythonClass {
  factory swapcase(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "swapcase",
        swapcase.from,
        <Object?>[name],
      );

  swapcase.from(super.pythonClass) : super.from();
}

/// ## title
/// ### debug info
/// ```
/// Pointer: address=0x1178341d0
/// ```
final class title extends PythonClass {
  factory title(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "title",
        title.from,
        <Object?>[name],
      );

  title.from(super.pythonClass) : super.from();
}

/// ## translate
/// ### debug info
/// ```
/// Pointer: address=0x117834770
/// ```
final class translate extends PythonClass {
  factory translate(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "translate",
        translate.from,
        <Object?>[name],
      );

  translate.from(super.pythonClass) : super.from();
}

/// ## upper
/// ### debug info
/// ```
/// Pointer: address=0x1178347c0
/// ```
final class upper extends PythonClass {
  factory upper(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "upper",
        upper.from,
        <Object?>[name],
      );

  upper.from(super.pythonClass) : super.from();
}

/// ## zfill
/// ### debug info
/// ```
/// Pointer: address=0x117834d10
/// ```
final class zfill extends PythonClass {
  factory zfill(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "zfill",
        zfill.from,
        <Object?>[name],
      );

  zfill.from(super.pythonClass) : super.from();
}

/// ## Tree
/// ### debug info
/// ```
/// Pointer: address=0x12aa27f50
/// ```
final class Tree extends PythonClass {
  factory Tree(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
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
  ///         Iterates over all the subtrees, never returning to the same node twice (Lark's parse-tree is actually a DAG).
  Object? iter_subtrees(Object? self, Object? queue, Object? subtree) =>
      getFunction("iter_subtrees").call(<Object?>[self, queue, subtree]);

  /// ## iter_subtrees_topdown
  ///
  /// ### python docstring
  /// Breadth-first iteration.
  ///
  ///         Iterates over all the subtrees, return nodes in order like pretty() does.
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
  ///         Great for debugging.
  Object? pretty(Object? self, Object? indent_str) =>
      getFunction("pretty").call(<Object?>[self, indent_str]);

  /// ## scan_values
  ///
  /// ### python docstring
  /// Return all values in the tree that evaluate pred(value) as true.
  ///
  ///         This can be used to find all the tokens in the tree.
  ///
  ///         Example:
  ///             >>> all_tokens = tree.scan_values(lambda v: isinstance(v, Token))
  Object? scan_values(Object? self, Object? pred, Object? c, Object? t) =>
      getFunction("scan_values").call(<Object?>[self, pred, c, t]);

  /// ## set
  Object? set(Object? self, Object? data, Object? children) =>
      getFunction("set").call(<Object?>[self, data, children]);
}

/// ## copy_with
/// ### debug info
/// ```
/// Pointer: address=0x12abb7d40
/// ```
final class copy_with extends PythonClass {
  factory copy_with(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "copy_with",
        copy_with.from,
        <Object?>[name],
      );

  copy_with.from(super.pythonClass) : super.from();
}

/// ## addFilter
/// ### debug info
/// ```
/// Pointer: address=0x12abaf440
/// ```
///
/// ### python docstring
/// Add the specified filter to this handler.
final class addFilter extends PythonClass {
  factory addFilter(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "addFilter",
        addFilter.from,
        <Object?>[name],
      );

  addFilter.from(super.pythonClass) : super.from();
}

/// ## addHandler
/// ### debug info
/// ```
/// Pointer: address=0x12abaf4c0
/// ```
///
/// ### python docstring
/// Add the specified handler to this logger.
final class addHandler extends PythonClass {
  factory addHandler(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "addHandler",
        addHandler.from,
        <Object?>[name],
      );

  addHandler.from(super.pythonClass) : super.from();
}

/// ## callHandlers
/// ### debug info
/// ```
/// Pointer: address=0x12abaf600
/// ```
///
/// ### python docstring
/// Pass a record to all relevant handlers.
///
///         Loop through all handlers for this logger and its parents in the
///         logger hierarchy. If no handler was found, output a one-off error
///         message to sys.stderr. Stop searching up the hierarchy whenever a
///         logger with the "propagate" attribute set to zero is found - that
///         will be the last logger whose handlers are called.
final class callHandlers extends PythonClass {
  factory callHandlers(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "callHandlers",
        callHandlers.from,
        <Object?>[name],
      );

  callHandlers.from(super.pythonClass) : super.from();
}

/// ## critical
/// ### debug info
/// ```
/// Pointer: address=0x12abaf780
/// ```
///
/// ### python docstring
/// Log 'msg % args' with severity 'CRITICAL'.
///
///         To pass exception information, use the keyword argument exc_info with
///         a true value, e.g.
///
///         logger.critical("Houston, we have a %s", "major disaster", exc_info=1)
final class critical extends PythonClass {
  factory critical(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "critical",
        critical.from,
        <Object?>[name],
      );

  critical.from(super.pythonClass) : super.from();
}

/// ## debug
/// ### debug info
/// ```
/// Pointer: address=0x12abaf8c0
/// ```
///
/// ### python docstring
/// Log 'msg % args' with severity 'DEBUG'.
///
///         To pass exception information, use the keyword argument exc_info with
///         a true value, e.g.
///
///         logger.debug("Houston, we have a %s", "thorny problem", exc_info=1)
final class debug extends PythonClass {
  factory debug(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "debug",
        debug.from,
        <Object?>[name],
      );

  debug.from(super.pythonClass) : super.from();
}

/// ## error
/// ### debug info
/// ```
/// Pointer: address=0x12abafac0
/// ```
///
/// ### python docstring
/// Log 'msg % args' with severity 'ERROR'.
///
///         To pass exception information, use the keyword argument exc_info with
///         a true value, e.g.
///
///         logger.error("Houston, we have a %s", "major problem", exc_info=1)
final class error extends PythonClass {
  factory error(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "error",
        error.from,
        <Object?>[name],
      );

  error.from(super.pythonClass) : super.from();
}

/// ## exception
/// ### debug info
/// ```
/// Pointer: address=0x12abafc40
/// ```
///
/// ### python docstring
/// Convenience method for logging an ERROR with exception information.
final class exception extends PythonClass {
  factory exception(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "exception",
        exception.from,
        <Object?>[name],
      );

  exception.from(super.pythonClass) : super.from();
}

/// ## fatal
/// ### debug info
/// ```
/// Pointer: address=0x12abafdc0
/// ```
///
/// ### python docstring
/// Don't use this method, use critical() instead.
final class fatal extends PythonClass {
  factory fatal(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "fatal",
        fatal.from,
        <Object?>[name],
      );

  fatal.from(super.pythonClass) : super.from();
}

/// ## filter
/// ### debug info
/// ```
/// Pointer: address=0x12abaff40
/// ```
///
/// ### python docstring
/// Determine if a record is loggable by consulting all the filters.
///
///         The default is to allow the record to be logged; any filter can veto
///         this and the record is then dropped. Returns a zero value if a record
///         is to be dropped, else non-zero.
///
///         .. versionchanged:: 3.2
///
///            Allow filters to be just callables.
final class filter extends PythonClass {
  factory filter(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "filter",
        filter.from,
        <Object?>[name],
      );

  filter.from(super.pythonClass) : super.from();
}

/// ## findCaller
/// ### debug info
/// ```
/// Pointer: address=0x12aba8140
/// ```
///
/// ### python docstring
/// Find the stack frame of the caller so that we can note the source
///         file name, line number and function name.
final class findCaller extends PythonClass {
  factory findCaller(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "findCaller",
        findCaller.from,
        <Object?>[name],
      );

  findCaller.from(super.pythonClass) : super.from();
}

/// ## getChild
/// ### debug info
/// ```
/// Pointer: address=0x12aba82c0
/// ```
///
/// ### python docstring
/// Get a logger which is a descendant to this one.
///
///         This is a convenience method, such that
///
///         logging.getLogger('abc').getChild('def.ghi')
///
///         is the same as
///
///         logging.getLogger('abc.def.ghi')
///
///         It's useful, for example, when the parent logger is named using
///         __name__ rather than a literal string.
final class getChild extends PythonClass {
  factory getChild(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "getChild",
        getChild.from,
        <Object?>[name],
      );

  getChild.from(super.pythonClass) : super.from();
}

/// ## getEffectiveLevel
/// ### debug info
/// ```
/// Pointer: address=0x12aba83c0
/// ```
///
/// ### python docstring
/// Get the effective level for this logger.
///
///         Loop through this logger and its parents in the logger hierarchy,
///         looking for a non-zero logging level. Return the first one found.
final class getEffectiveLevel extends PythonClass {
  factory getEffectiveLevel(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "getEffectiveLevel",
        getEffectiveLevel.from,
        <Object?>[name],
      );

  getEffectiveLevel.from(super.pythonClass) : super.from();
}

/// ## handle
/// ### debug info
/// ```
/// Pointer: address=0x12aba8540
/// ```
///
/// ### python docstring
/// Call the handlers for the specified record.
///
///         This method is used for unpickled records received from a socket, as
///         well as those created locally. Logger-level filtering is applied.
final class handle extends PythonClass {
  factory handle(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "handle",
        handle.from,
        <Object?>[name],
      );

  handle.from(super.pythonClass) : super.from();
}

/// ## hasHandlers
/// ### debug info
/// ```
/// Pointer: address=0x12aba8700
/// ```
///
/// ### python docstring
/// See if this logger has any handlers configured.
///
///         Loop through all handlers for this logger and its parents in the
///         logger hierarchy. Return True if a handler was found, else False.
///         Stop searching up the hierarchy whenever a logger with the "propagate"
///         attribute set to zero is found - that will be the last logger which
///         is checked for the existence of handlers.
final class hasHandlers extends PythonClass {
  factory hasHandlers(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "hasHandlers",
        hasHandlers.from,
        <Object?>[name],
      );

  hasHandlers.from(super.pythonClass) : super.from();
}

/// ## info
/// ### debug info
/// ```
/// Pointer: address=0x12aba8880
/// ```
///
/// ### python docstring
/// Log 'msg % args' with severity 'INFO'.
///
///         To pass exception information, use the keyword argument exc_info with
///         a true value, e.g.
///
///         logger.info("Houston, we have a %s", "interesting problem", exc_info=1)
final class info extends PythonClass {
  factory info(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "info",
        info.from,
        <Object?>[name],
      );

  info.from(super.pythonClass) : super.from();
}

/// ## isEnabledFor
/// ### debug info
/// ```
/// Pointer: address=0x12aba89c0
/// ```
///
/// ### python docstring
/// Is this logger enabled for level 'level'?
final class isEnabledFor extends PythonClass {
  factory isEnabledFor(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "isEnabledFor",
        isEnabledFor.from,
        <Object?>[name],
      );

  isEnabledFor.from(super.pythonClass) : super.from();
}

/// ## log
/// ### debug info
/// ```
/// Pointer: address=0x12aba8b80
/// ```
///
/// ### python docstring
/// Log 'msg % args' with the integer severity 'level'.
///
///         To pass exception information, use the keyword argument exc_info with
///         a true value, e.g.
///
///         logger.log(level, "We have a %s", "mysterious problem", exc_info=1)
final class log extends PythonClass {
  factory log(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "log",
        log.from,
        <Object?>[name],
      );

  log.from(super.pythonClass) : super.from();
}

/// ## makeRecord
/// ### debug info
/// ```
/// Pointer: address=0x12aba8cc0
/// ```
///
/// ### python docstring
/// A factory method which can be overridden in subclasses to create
///         specialized LogRecords.
final class makeRecord extends PythonClass {
  factory makeRecord(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "makeRecord",
        makeRecord.from,
        <Object?>[name],
      );

  makeRecord.from(super.pythonClass) : super.from();
}

/// ## getLogger
/// ### debug info
/// ```
/// Pointer: address=0x12aba90c0
/// ```
///
/// ### python docstring
/// Get a logger with the specified name (channel name), creating it
///         if it doesn't yet exist. This name is a dot-separated hierarchical
///         name, such as "a", "a.b", "a.b.c" or similar.
///
///         If a PlaceHolder existed for the specified name [i.e. the logger
///         didn't exist but a child of it did], replace it with the created
///         logger and fix up the parent/child references which pointed to the
///         placeholder to now point to the logger.
final class getLogger extends PythonClass {
  factory getLogger(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "getLogger",
        getLogger.from,
        <Object?>[name],
      );

  getLogger.from(super.pythonClass) : super.from();
}

/// ## removeFilter
/// ### debug info
/// ```
/// Pointer: address=0x12ab7a240
/// ```
///
/// ### python docstring
/// Remove the specified filter from this handler.
final class removeFilter extends PythonClass {
  factory removeFilter(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "removeFilter",
        removeFilter.from,
        <Object?>[name],
      );

  removeFilter.from(super.pythonClass) : super.from();
}

/// ## removeHandler
/// ### debug info
/// ```
/// Pointer: address=0x12abaad00
/// ```
///
/// ### python docstring
/// Remove the specified handler from this logger.
final class removeHandler extends PythonClass {
  factory removeHandler(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "removeHandler",
        removeHandler.from,
        <Object?>[name],
      );

  removeHandler.from(super.pythonClass) : super.from();
}

/// ## setLevel
/// ### debug info
/// ```
/// Pointer: address=0x12abaaf80
/// ```
///
/// ### python docstring
/// Set the logging level of this logger.  level must be an int or a str.
final class setLevel extends PythonClass {
  factory setLevel(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "setLevel",
        setLevel.from,
        <Object?>[name],
      );

  setLevel.from(super.pythonClass) : super.from();
}

/// ## warn
/// ### debug info
/// ```
/// Pointer: address=0x12abab0c0
/// ```
final class warn extends PythonClass {
  factory warn(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "warn",
        warn.from,
        <Object?>[name],
      );

  warn.from(super.pythonClass) : super.from();
}

/// ## warning
/// ### debug info
/// ```
/// Pointer: address=0x12abab200
/// ```
///
/// ### python docstring
/// Log 'msg % args' with severity 'WARNING'.
///
///         To pass exception information, use the keyword argument exc_info with
///         a true value, e.g.
///
///         logger.warning("Houston, we have a %s", "bit of a problem", exc_info=1)
final class warning extends PythonClass {
  factory warning(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "warning",
        warning.from,
        <Object?>[name],
      );

  warning.from(super.pythonClass) : super.from();
}

/// ## setLogRecordFactory
/// ### debug info
/// ```
/// Pointer: address=0x12ab7b100
/// ```
///
/// ### python docstring
/// Set the factory to be used when instantiating a log record with this
///         Manager.
final class setLogRecordFactory extends PythonClass {
  factory setLogRecordFactory(String name) =>
      PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "setLogRecordFactory",
        setLogRecordFactory.from,
        <Object?>[name],
      );

  setLogRecordFactory.from(super.pythonClass) : super.from();
}

/// ## setLoggerClass
/// ### debug info
/// ```
/// Pointer: address=0x12abab3c0
/// ```
///
/// ### python docstring
/// Set the class to be used when instantiating a logger with this Manager.
final class setLoggerClass extends PythonClass {
  factory setLoggerClass(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "setLoggerClass",
        setLoggerClass.from,
        <Object?>[name],
      );

  setLoggerClass.from(super.pythonClass) : super.from();
}

/// ## Transformer
/// ### debug info
/// ```
/// Pointer: address=0x7f935ea398d0
/// ```
///
/// ### python docstring
/// Transformers work bottom-up (or depth-first), starting with visiting the leaves and working
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
final class Transformer extends PythonClass {
  factory Transformer(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
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
/// ### debug info
/// ```
/// Pointer: address=0x7f935ea3b3d0
/// ```
///
/// ### python docstring
/// Same as Transformer but non-recursive.
///
///     Like Transformer, it doesn't change the original tree.
///
///     Useful for huge trees.
final class Transformer_NonRecursive extends PythonClass {
  factory Transformer_NonRecursive(String name) =>
      PythonFfiDart.instance.importClass(
        "basic_dataclass",
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
/// ### debug info
/// ```
/// Pointer: address=0x7f935ea3c810
/// ```
///
/// ### python docstring
/// Tree visitor, non-recursive (can handle huge trees).
///
///     Visiting a node calls its methods (provided by the user via inheritance) according to ``tree.data``
final class Visitor extends PythonClass {
  factory Visitor(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
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
  Object? v_args(Object? inline, Object? meta, Object? tree, Object? wrapper) =>
      getFunction("v_args").call(<Object?>[inline, meta, tree, wrapper]);
}
