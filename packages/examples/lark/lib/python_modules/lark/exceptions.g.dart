// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library exceptions;

import "package:python_ffi_dart/python_ffi_dart.dart";

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
  Object? get args => getAttribute("args");

  /// ## args (setter)
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
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
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
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
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
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
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
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
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
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);

  /// ## rule (getter)
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
  Object? get rule => getAttribute("rule");

  /// ## rule (setter)
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
  set rule(Object? rule) => setAttribute("rule", rule);

  /// ## obj (getter)
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
  Object? get obj => getAttribute("obj");

  /// ## obj (setter)
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
  set obj(Object? obj) => setAttribute("obj", obj);

  /// ## orig_exc (getter)
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
  Object? get orig_exc => getAttribute("orig_exc");

  /// ## orig_exc (setter)
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
  set orig_exc(Object? orig_exc) => setAttribute("orig_exc", orig_exc);
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
  Object? get T => getAttribute("T");

  /// ## T (setter)
  set T(Object? T) => setAttribute("T", T);

  /// ## TYPE_CHECKING (getter)
  Object? get TYPE_CHECKING => getAttribute("TYPE_CHECKING");

  /// ## TYPE_CHECKING (setter)
  set TYPE_CHECKING(Object? TYPE_CHECKING) =>
      setAttribute("TYPE_CHECKING", TYPE_CHECKING);
}
