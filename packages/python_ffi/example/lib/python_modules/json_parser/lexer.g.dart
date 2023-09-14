// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library lexer;

import "package:python_ffi/python_ffi.dart";

/// ## Token
///
/// ### python docstring
///
/// Represents a Token extracted by the parser
///
/// ### python source
/// ```py
/// class Token(NamedTuple):
///     """Represents a Token extracted by the parser"""
///     value: str
///     type: TokenType
///     line: int
///     column: int
/// ```
final class Token extends PythonClass {
  factory Token() => PythonFfi.instance.importClass(
        "json_parser.lexer",
        "Token",
        Token.from,
        <Object?>[],
      );

  Token.from(super.pythonClass) : super.from();

  /// ## column (getter)
  ///
  /// ### python docstring
  ///
  /// Represents a Token extracted by the parser
  Object? get column => getAttribute("column");

  /// ## column (setter)
  ///
  /// ### python docstring
  ///
  /// Represents a Token extracted by the parser
  set column(Object? column) => setAttribute("column", column);

  /// ## line (getter)
  ///
  /// ### python docstring
  ///
  /// Represents a Token extracted by the parser
  Object? get line => getAttribute("line");

  /// ## line (setter)
  ///
  /// ### python docstring
  ///
  /// Represents a Token extracted by the parser
  set line(Object? line) => setAttribute("line", line);

  /// ## type (getter)
  ///
  /// ### python docstring
  ///
  /// Represents a Token extracted by the parser
  Object? get type => getAttribute("type");

  /// ## type (setter)
  ///
  /// ### python docstring
  ///
  /// Represents a Token extracted by the parser
  set type(Object? type) => setAttribute("type", type);

  /// ## value (getter)
  ///
  /// ### python docstring
  ///
  /// Represents a Token extracted by the parser
  Object? get value => getAttribute("value");

  /// ## value (setter)
  ///
  /// ### python docstring
  ///
  /// Represents a Token extracted by the parser
  set value(Object? value) => setAttribute("value", value);

  /// ## count (getter)
  ///
  /// ### python docstring
  ///
  /// Represents a Token extracted by the parser
  Object? get count => getAttribute("count");

  /// ## count (setter)
  ///
  /// ### python docstring
  ///
  /// Represents a Token extracted by the parser
  set count(Object? count) => setAttribute("count", count);

  /// ## index (getter)
  ///
  /// ### python docstring
  ///
  /// Represents a Token extracted by the parser
  Object? get index => getAttribute("index");

  /// ## index (setter)
  ///
  /// ### python docstring
  ///
  /// Represents a Token extracted by the parser
  set index(Object? index) => setAttribute("index", index);
}

/// ## TokenizeError
///
/// ### python docstring
///
/// Error thrown when an invalid JSON string is tokenized
///
/// ### python source
/// ```py
/// class TokenizeError(Exception):
///     """Error thrown when an invalid JSON string is tokenized"""
/// ```
final class TokenizeError extends PythonClass {
  factory TokenizeError() => PythonFfi.instance.importClass(
        "json_parser.lexer",
        "TokenizeError",
        TokenizeError.from,
        <Object?>[],
      );

  TokenizeError.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// Error thrown when an invalid JSON string is tokenized
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// Error thrown when an invalid JSON string is tokenized
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// Error thrown when an invalid JSON string is tokenized
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// Error thrown when an invalid JSON string is tokenized
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// Error thrown when an invalid JSON string is tokenized
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// Error thrown when an invalid JSON string is tokenized
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## lexer
///
/// ### python docstring
///
/// Lexer functions
///
/// ### python source
/// ```py
/// """Lexer functions"""
/// from collections import deque
/// from typing import Deque, Literal, NamedTuple, Tuple
/// from string import whitespace as WHITESPACE
///
/// TokenType = Literal[
///     'string',
///     'number',
///     'boolean',
///     'null',
///     'left_bracket',
///     'left_brace',
///     'right_bracket',
///     'right_brace',
///     'comma',
///     'colon',
/// ]
///
///
/// class Token(NamedTuple):
///     """Represents a Token extracted by the parser"""
///     value: str
///     type: TokenType
///     line: int
///     column: int
///
///
/// class TokenizeError(Exception):
///     """Error thrown when an invalid JSON string is tokenized"""
///
///
/// def extract_string(
///         json_string: str,
///         index: int,
///         tokens: Deque[Token],
///         line: int,
///         column: int) -> Tuple[int, int, int]:
///     """Extracts a single string token from JSON string"""
///     start = index
///     end = len(json_string)
///     start_line, start_column = line, column
///     index += 1
///     column += 1
///
///     while index < end:
///         char = json_string[index]
///
///         if char == '\\':
///             if index + 1 == end:
///                 raise TokenizeError("Incomplete escape at end of string")
///
///             index += 2
///             column += 2
///             continue
///
///         if char == '"':
///             index += 1
///             column += 1
///             string = json_string[start:index]
///             tokens.append(Token(string, 'string', start_line, start_column))
///
///             return index, line, column
///
///         index += 1
///         if char == '\n':
///             column = 1
///             line += 1
///         else:
///             column += 1
///
///     err = f"Expected end of string (line {line} column {column})"
///     raise TokenizeError(err)
///
///
/// def extract_number(
///         json_string: str,
///         index: int,
///         tokens: Deque[Token],
///         line: int,
///         column: int) -> Tuple[int, int, int]:
///     """Extracts a single number token (eg. 42, -12.3) from JSON string"""
///     start = index
///     end = len(json_string)
///
///     leading_minus_found = False
///     decimal_point_found = False
///
///     while index < end:
///         char = json_string[index]
///         if char == '.':
///             if decimal_point_found:
///                 raise TokenizeError("Too many decimal points in number")
///
///             decimal_point_found = True
///
///         elif char == '-':
///             if leading_minus_found:
///                 raise TokenizeError("Minus sign in between number")
///
///             leading_minus_found = True
///
///         elif not char.isdigit():
///             break
///
///         index += 1
///
///     number = json_string[start:index]
///     tokens.append(Token(number, 'number', line, column))
///     length = index - start
///     column += length
///     return index, line, column
///
///
/// def extract_special(
///         json_string: str,
///         index: int,
///         tokens: Deque[Token],
///         line: int,
///         column: int) -> Tuple[int, int, int]:
///     """Extracts true, false and null from JSON string"""
///     end = len(json_string)
///
///     word = ''
///     while index < end:
///         char = json_string[index]
///         if not char.isalpha():
///             break
///
///         word += char
///         index += 1
///
///     if word in ('true', 'false', 'null'):
///         token = Token(
///             word,
///             line=line,
///             column=column,
///             type='null' if word == 'null' else 'boolean'
///         )
///         tokens.append(token)
///         column += len(word)
///         return index, line, column
///
///     err = f"Unknown token found: {word} (line {line} column {column})"
///     raise TokenizeError(err)
///
///
/// def tokenize(json_string: str) -> Deque[Token]:
///     """Converts a JSON string into a queue of tokens"""
///     tokens: Deque[Token] = deque()
///
///     line = column = 1
///     index = 0
///     end = len(json_string)
///     while index < end:
///         char = json_string[index]
///
///         if char in WHITESPACE:
///             index += 1
///
///             if char == '\n':
///                 column = 1
///                 line += 1
///             else:
///                 column += 1
///
///         elif char in '[]{},:':
///             token = Token(
///                 char,
///                 line=line,
///                 column=column,
///                 type=('left_bracket' if char == '[' else
///                       'right_bracket' if char == ']' else
///                       'left_brace' if char == '{' else
///                       'right_brace' if char == '}' else
///                       'comma' if char == ',' else 'colon')
///             )
///             tokens.append(token)
///             index += 1
///             column += 1
///
///         elif char == '"':
///             index, line, column = extract_string(
///                 json_string, index, tokens, line, column)
///
///         elif char == '-' or char.isdigit():
///             index, line, column = extract_number(
///                 json_string, index, tokens, line, column)
///
///         else:
///             index, line, column = extract_special(
///                 json_string, index, tokens, line, column)
///
///     if len(tokens) == 0:
///         raise TokenizeError("Cannot parse empty string")
///
///     return tokens
/// ```
final class lexer extends PythonModule {
  lexer.from(super.pythonModule) : super.from();

  static lexer import() => PythonFfi.instance.importModule(
        "json_parser.lexer",
        lexer.from,
      );

  /// ## extract_number
  ///
  /// ### python docstring
  ///
  /// Extracts a single number token (eg. 42, -12.3) from JSON string
  ///
  /// ### python source
  /// ```py
  /// def extract_number(
  ///         json_string: str,
  ///         index: int,
  ///         tokens: Deque[Token],
  ///         line: int,
  ///         column: int) -> Tuple[int, int, int]:
  ///     """Extracts a single number token (eg. 42, -12.3) from JSON string"""
  ///     start = index
  ///     end = len(json_string)
  ///
  ///     leading_minus_found = False
  ///     decimal_point_found = False
  ///
  ///     while index < end:
  ///         char = json_string[index]
  ///         if char == '.':
  ///             if decimal_point_found:
  ///                 raise TokenizeError("Too many decimal points in number")
  ///
  ///             decimal_point_found = True
  ///
  ///         elif char == '-':
  ///             if leading_minus_found:
  ///                 raise TokenizeError("Minus sign in between number")
  ///
  ///             leading_minus_found = True
  ///
  ///         elif not char.isdigit():
  ///             break
  ///
  ///         index += 1
  ///
  ///     number = json_string[start:index]
  ///     tokens.append(Token(number, 'number', line, column))
  ///     length = index - start
  ///     column += length
  ///     return index, line, column
  /// ```
  Object? extract_number({
    required String json_string,
    required int index,
    required Object? tokens,
    required int line,
    required int column,
  }) =>
      getFunction("extract_number").call(
        <Object?>[
          json_string,
          index,
          tokens,
          line,
          column,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## extract_special
  ///
  /// ### python docstring
  ///
  /// Extracts true, false and null from JSON string
  ///
  /// ### python source
  /// ```py
  /// def extract_special(
  ///         json_string: str,
  ///         index: int,
  ///         tokens: Deque[Token],
  ///         line: int,
  ///         column: int) -> Tuple[int, int, int]:
  ///     """Extracts true, false and null from JSON string"""
  ///     end = len(json_string)
  ///
  ///     word = ''
  ///     while index < end:
  ///         char = json_string[index]
  ///         if not char.isalpha():
  ///             break
  ///
  ///         word += char
  ///         index += 1
  ///
  ///     if word in ('true', 'false', 'null'):
  ///         token = Token(
  ///             word,
  ///             line=line,
  ///             column=column,
  ///             type='null' if word == 'null' else 'boolean'
  ///         )
  ///         tokens.append(token)
  ///         column += len(word)
  ///         return index, line, column
  ///
  ///     err = f"Unknown token found: {word} (line {line} column {column})"
  ///     raise TokenizeError(err)
  /// ```
  Object? extract_special({
    required String json_string,
    required int index,
    required Object? tokens,
    required int line,
    required int column,
  }) =>
      getFunction("extract_special").call(
        <Object?>[
          json_string,
          index,
          tokens,
          line,
          column,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## extract_string
  ///
  /// ### python docstring
  ///
  /// Extracts a single string token from JSON string
  ///
  /// ### python source
  /// ```py
  /// def extract_string(
  ///         json_string: str,
  ///         index: int,
  ///         tokens: Deque[Token],
  ///         line: int,
  ///         column: int) -> Tuple[int, int, int]:
  ///     """Extracts a single string token from JSON string"""
  ///     start = index
  ///     end = len(json_string)
  ///     start_line, start_column = line, column
  ///     index += 1
  ///     column += 1
  ///
  ///     while index < end:
  ///         char = json_string[index]
  ///
  ///         if char == '\\':
  ///             if index + 1 == end:
  ///                 raise TokenizeError("Incomplete escape at end of string")
  ///
  ///             index += 2
  ///             column += 2
  ///             continue
  ///
  ///         if char == '"':
  ///             index += 1
  ///             column += 1
  ///             string = json_string[start:index]
  ///             tokens.append(Token(string, 'string', start_line, start_column))
  ///
  ///             return index, line, column
  ///
  ///         index += 1
  ///         if char == '\n':
  ///             column = 1
  ///             line += 1
  ///         else:
  ///             column += 1
  ///
  ///     err = f"Expected end of string (line {line} column {column})"
  ///     raise TokenizeError(err)
  /// ```
  Object? extract_string({
    required String json_string,
    required int index,
    required Object? tokens,
    required int line,
    required int column,
  }) =>
      getFunction("extract_string").call(
        <Object?>[
          json_string,
          index,
          tokens,
          line,
          column,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## tokenize
  ///
  /// ### python docstring
  ///
  /// Converts a JSON string into a queue of tokens
  ///
  /// ### python source
  /// ```py
  /// def tokenize(json_string: str) -> Deque[Token]:
  ///     """Converts a JSON string into a queue of tokens"""
  ///     tokens: Deque[Token] = deque()
  ///
  ///     line = column = 1
  ///     index = 0
  ///     end = len(json_string)
  ///     while index < end:
  ///         char = json_string[index]
  ///
  ///         if char in WHITESPACE:
  ///             index += 1
  ///
  ///             if char == '\n':
  ///                 column = 1
  ///                 line += 1
  ///             else:
  ///                 column += 1
  ///
  ///         elif char in '[]{},:':
  ///             token = Token(
  ///                 char,
  ///                 line=line,
  ///                 column=column,
  ///                 type=('left_bracket' if char == '[' else
  ///                       'right_bracket' if char == ']' else
  ///                       'left_brace' if char == '{' else
  ///                       'right_brace' if char == '}' else
  ///                       'comma' if char == ',' else 'colon')
  ///             )
  ///             tokens.append(token)
  ///             index += 1
  ///             column += 1
  ///
  ///         elif char == '"':
  ///             index, line, column = extract_string(
  ///                 json_string, index, tokens, line, column)
  ///
  ///         elif char == '-' or char.isdigit():
  ///             index, line, column = extract_number(
  ///                 json_string, index, tokens, line, column)
  ///
  ///         else:
  ///             index, line, column = extract_special(
  ///                 json_string, index, tokens, line, column)
  ///
  ///     if len(tokens) == 0:
  ///         raise TokenizeError("Cannot parse empty string")
  ///
  ///     return tokens
  /// ```
  Object? tokenize({
    required String json_string,
  }) =>
      getFunction("tokenize").call(
        <Object?>[
          json_string,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## Deque (getter)
  ///
  /// ### python docstring
  ///
  /// Lexer functions
  Object? get Deque => getAttribute("Deque");

  /// ## Deque (setter)
  ///
  /// ### python docstring
  ///
  /// Lexer functions
  set Deque(Object? Deque) => setAttribute("Deque", Deque);

  /// ## Literal (getter)
  ///
  /// ### python docstring
  ///
  /// Lexer functions
  Object? get Literal => getAttribute("Literal");

  /// ## Literal (setter)
  ///
  /// ### python docstring
  ///
  /// Lexer functions
  set Literal(Object? Literal) => setAttribute("Literal", Literal);

  /// ## TokenType (getter)
  ///
  /// ### python docstring
  ///
  /// Lexer functions
  Object? get TokenType => getAttribute("TokenType");

  /// ## TokenType (setter)
  ///
  /// ### python docstring
  ///
  /// Lexer functions
  set TokenType(Object? TokenType) => setAttribute("TokenType", TokenType);

  /// ## Tuple (getter)
  ///
  /// ### python docstring
  ///
  /// Lexer functions
  Object? get Tuple => getAttribute("Tuple");

  /// ## Tuple (setter)
  ///
  /// ### python docstring
  ///
  /// Lexer functions
  set Tuple(Object? Tuple) => setAttribute("Tuple", Tuple);

  /// ## WHITESPACE (getter)
  ///
  /// ### python docstring
  ///
  /// Lexer functions
  Object? get WHITESPACE => getAttribute("WHITESPACE");

  /// ## WHITESPACE (setter)
  ///
  /// ### python docstring
  ///
  /// Lexer functions
  set WHITESPACE(Object? WHITESPACE) => setAttribute("WHITESPACE", WHITESPACE);
}
