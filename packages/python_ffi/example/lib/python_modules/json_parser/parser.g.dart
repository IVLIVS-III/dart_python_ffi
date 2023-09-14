// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library parser;

import "package:python_ffi/python_ffi.dart";

/// ## ParseError
///
/// ### python docstring
///
/// Error thrown when invalid JSON tokens are parsed
///
/// ### python source
/// ```py
/// class ParseError(Exception):
///     """Error thrown when invalid JSON tokens are parsed"""
/// ```
final class ParseError extends PythonClass {
  factory ParseError() => PythonFfi.instance.importClass(
        "json_parser.parser",
        "ParseError",
        ParseError.from,
        <Object?>[],
      );

  ParseError.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// Error thrown when invalid JSON tokens are parsed
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// Error thrown when invalid JSON tokens are parsed
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// Error thrown when invalid JSON tokens are parsed
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// Error thrown when invalid JSON tokens are parsed
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// Error thrown when invalid JSON tokens are parsed
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// Error thrown when invalid JSON tokens are parsed
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

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
        "json_parser.parser",
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

/// ## parser
///
/// ### python docstring
///
/// Parser functions
///
/// ### python source
/// ```py
/// """Parser functions"""
/// from ast import literal_eval
/// from typing import Deque, Dict, List, Union
///
/// from json_parser.lexer import Token, tokenize
///
/// JSONArray = List[object]
/// JSONObject = Dict[str, object]
/// JSONNumber = Union[int, float]
///
///
/// class ParseError(Exception):
///     """Error thrown when invalid JSON tokens are parsed"""
///
///
/// def parse_object(tokens: Deque[Token]) -> JSONObject:
///     """Parses an object out of JSON tokens"""
///     obj: JSONObject = {}
///
///     # special case:
///     if tokens[0].type == 'right_brace':
///         tokens.popleft()
///         return obj
///
///     while tokens:
///         token = tokens.popleft()
///
///         if not token.type == 'string':
///             raise ParseError(
///                 f"Expected string key for object, found {token.value} "
///                 f"(line {token.line} column {token.column})")
///
///         key = parse_string(token)
///
///         if len(tokens) == 0:
///             column_end = token.column + len(token.value)
///             raise ParseError(
///                 "Unexpected end of file while parsing "
///                 f"(line {token.line} column {column_end})")
///
///         token = tokens.popleft()
///         if token.type != 'colon':
///             raise ParseError(
///                 f"Expected colon, found {token.value} "
///                 f"(line {token.line} column {token.column})")
///
///         # Missing value for key
///         if len(tokens) == 0:
///             raise ParseError(
///                 "Unexpected end of file while parsing "
///                 f"(line {token.line} column {token.column+1})")
///
///         if tokens[0].type == 'right_brace':
///             token = tokens[0]
///             raise ParseError(
///                 "Expected value after colon, found } "
///                 f"(line {token.line} column {token.column})")
///
///         value = _parse(tokens)
///         obj[key] = value
///
///         if len(tokens) == 0:
///             column_end = token.column + len(token.value)
///             raise ParseError(
///                 "Unexpected end of file while parsing "
///                 f"(line {token.line} column {column_end})")
///
///         token = tokens.popleft()
///         if token.type not in ('comma', 'right_brace'):
///             raise ParseError(
///                 f"Expected ',' or '}}', found {token.value}"
///                 f" (line {token.line} column {token.column})")
///
///         if token.type == 'right_brace':
///             break
///
///         # Trailing comma checks
///         if len(tokens) == 0:
///             column_end = token.column + len(token.value)
///             raise ParseError(
///                 "Unexpected end of file while parsing "
///                 f"(line {token.line} column {column_end})")
///
///         if tokens[0].type == 'right_brace':
///             token = tokens[0]
///             raise ParseError(
///                 "Expected value after comma, found } "
///                 f"(line {token.line} column {token.column})")
///
///     return obj
///
///
/// def parse_array(tokens: Deque[Token]) -> JSONArray:
///     """Parses an array out of JSON tokens"""
///     array: JSONArray = []
///
///     # special case:
///     if tokens[0].type == 'right_bracket':
///         tokens.popleft()
///         return array
///
///     while tokens:
///         value = _parse(tokens)
///         array.append(value)
///
///         token = tokens.popleft()
///         if token.type not in ('comma', 'right_bracket'):
///             raise ParseError(
///                 f"Expected ',' or ']', found {token.value} "
///                 f"(line {token.line} column {token.column})")
///
///         if token.type == 'right_bracket':
///             break
///
///         # trailing comma check
///         if len(tokens) == 0:
///             column_end = token.column + len(token.value)
///             raise ParseError(
///                 "Unexpected end of file while parsing "
///                 f"(line {token.line} column {column_end})")
///
///         if tokens[0].type == 'right_bracket':
///             token = tokens[0]
///             raise ParseError(
///                 "Expected value after comma, found ] "
///                 f"(line {token.line} column {token.column})")
///
///     return array
///
///
/// def parse_string(token: Token) -> str:
///     """Parses a string out of a JSON token"""
///     chars: List[str] = []
///
///     index = 1
///     end = len(token.value) - 1
///     line, column = token.line, token.column + 1
///
///     while index < end:
///         char = token.value[index]
///
///         if char != '\\':
///             chars.append(char)
///             index += 1
///             if char == '\n':
///                 line += 1
///                 column = 1
///             else:
///                 column += 1
///             continue
///
///         next_char = token.value[index+1]
///         if next_char == 'u':
///             hex_string = token.value[index+2:index+6]
///             try:
///                 unicode_char = literal_eval(f'"\\u{hex_string}"')
///             except SyntaxError as err:
///                 raise ParseError(
///                     f"Invalid unicode escape: \\u{hex_string} "
///                     f"(line {line} column {column})") from err
///
///             chars.append(unicode_char)
///             index += 6
///             column += 6
///             continue
///
///         if next_char in ('"', '/', '\\'):
///             chars.append(next_char)
///         elif next_char == 'b':
///             chars.append('\b')
///         elif next_char == 'f':
///             chars.append('\f')
///         elif next_char == 'n':
///             chars.append('\n')
///         elif next_char == 'r':
///             chars.append('\r')
///         elif next_char == 't':
///             chars.append('\t')
///         else:
///             raise ParseError(
///                 f"Unknown escape sequence: {token.value} "
///                 f"(line {line} column {column})")
///
///         index += 2
///         column += 2
///
///     string = ''.join(chars)
///     return string
///
///
/// def parse_number(token: Token) -> JSONNumber:
///     """Parses a number out of a JSON token"""
///     try:
///         if token.value.isdigit():
///             number: JSONNumber = int(token.value)
///         else:
///             number = float(token.value)
///         return number
///
///     except ValueError as err:
///         raise ParseError(
///             f"Invalid token: {token.value} "
///             f"(line {token.line} column {token.column})") from err
///
///
/// def _parse(tokens: Deque[Token]) -> object:
///     """Recursive JSON parse implementation"""
///     token = tokens.popleft()
///
///     if token.type == 'left_bracket':
///         return parse_array(tokens)
///
///     if token.type == 'left_brace':
///         return parse_object(tokens)
///
///     if token.type == 'string':
///         return parse_string(token)
///
///     if token.type == 'number':
///         return parse_number(token)
///
///     special_tokens = {
///         'true': True,
///         'false': False,
///         'null': None,
///     }
///     if token.type in ('boolean', 'null'):
///         return special_tokens[token.value]
///
///     raise ParseError(
///         f"Unexpected token: {token.value} "
///         f"(line {token.line} column {token.column})")
///
///
/// def parse(json_string: str) -> object:
///     """Parses a JSON string into a Python object"""
///     tokens = tokenize(json_string)
///
///     value = _parse(tokens)
///     if len(tokens) != 0:
///         raise ParseError(
///             f"Invalid JSON at {tokens[0].value} "
///             f"(line {tokens[0].line} column {tokens[0].column})")
///
///     return value
/// ```
final class parser extends PythonModule {
  parser.from(super.pythonModule) : super.from();

  static parser import() => PythonFfi.instance.importModule(
        "json_parser.parser",
        parser.from,
      );

  /// ## parse
  ///
  /// ### python docstring
  ///
  /// Parses a JSON string into a Python object
  ///
  /// ### python source
  /// ```py
  /// def parse(json_string: str) -> object:
  ///     """Parses a JSON string into a Python object"""
  ///     tokens = tokenize(json_string)
  ///
  ///     value = _parse(tokens)
  ///     if len(tokens) != 0:
  ///         raise ParseError(
  ///             f"Invalid JSON at {tokens[0].value} "
  ///             f"(line {tokens[0].line} column {tokens[0].column})")
  ///
  ///     return value
  /// ```
  Object? parse({
    required String json_string,
  }) =>
      getFunction("parse").call(
        <Object?>[
          json_string,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## parse_array
  ///
  /// ### python docstring
  ///
  /// Parses an array out of JSON tokens
  ///
  /// ### python source
  /// ```py
  /// def parse_array(tokens: Deque[Token]) -> JSONArray:
  ///     """Parses an array out of JSON tokens"""
  ///     array: JSONArray = []
  ///
  ///     # special case:
  ///     if tokens[0].type == 'right_bracket':
  ///         tokens.popleft()
  ///         return array
  ///
  ///     while tokens:
  ///         value = _parse(tokens)
  ///         array.append(value)
  ///
  ///         token = tokens.popleft()
  ///         if token.type not in ('comma', 'right_bracket'):
  ///             raise ParseError(
  ///                 f"Expected ',' or ']', found {token.value} "
  ///                 f"(line {token.line} column {token.column})")
  ///
  ///         if token.type == 'right_bracket':
  ///             break
  ///
  ///         # trailing comma check
  ///         if len(tokens) == 0:
  ///             column_end = token.column + len(token.value)
  ///             raise ParseError(
  ///                 "Unexpected end of file while parsing "
  ///                 f"(line {token.line} column {column_end})")
  ///
  ///         if tokens[0].type == 'right_bracket':
  ///             token = tokens[0]
  ///             raise ParseError(
  ///                 "Expected value after comma, found ] "
  ///                 f"(line {token.line} column {token.column})")
  ///
  ///     return array
  /// ```
  Object? parse_array({
    required Object? tokens,
  }) =>
      getFunction("parse_array").call(
        <Object?>[
          tokens,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## parse_number
  ///
  /// ### python docstring
  ///
  /// Parses a number out of a JSON token
  ///
  /// ### python source
  /// ```py
  /// def parse_number(token: Token) -> JSONNumber:
  ///     """Parses a number out of a JSON token"""
  ///     try:
  ///         if token.value.isdigit():
  ///             number: JSONNumber = int(token.value)
  ///         else:
  ///             number = float(token.value)
  ///         return number
  ///
  ///     except ValueError as err:
  ///         raise ParseError(
  ///             f"Invalid token: {token.value} "
  ///             f"(line {token.line} column {token.column})") from err
  /// ```
  Object? parse_number({
    required Token token,
  }) =>
      getFunction("parse_number").call(
        <Object?>[
          token,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## parse_object
  ///
  /// ### python docstring
  ///
  /// Parses an object out of JSON tokens
  ///
  /// ### python source
  /// ```py
  /// def parse_object(tokens: Deque[Token]) -> JSONObject:
  ///     """Parses an object out of JSON tokens"""
  ///     obj: JSONObject = {}
  ///
  ///     # special case:
  ///     if tokens[0].type == 'right_brace':
  ///         tokens.popleft()
  ///         return obj
  ///
  ///     while tokens:
  ///         token = tokens.popleft()
  ///
  ///         if not token.type == 'string':
  ///             raise ParseError(
  ///                 f"Expected string key for object, found {token.value} "
  ///                 f"(line {token.line} column {token.column})")
  ///
  ///         key = parse_string(token)
  ///
  ///         if len(tokens) == 0:
  ///             column_end = token.column + len(token.value)
  ///             raise ParseError(
  ///                 "Unexpected end of file while parsing "
  ///                 f"(line {token.line} column {column_end})")
  ///
  ///         token = tokens.popleft()
  ///         if token.type != 'colon':
  ///             raise ParseError(
  ///                 f"Expected colon, found {token.value} "
  ///                 f"(line {token.line} column {token.column})")
  ///
  ///         # Missing value for key
  ///         if len(tokens) == 0:
  ///             raise ParseError(
  ///                 "Unexpected end of file while parsing "
  ///                 f"(line {token.line} column {token.column+1})")
  ///
  ///         if tokens[0].type == 'right_brace':
  ///             token = tokens[0]
  ///             raise ParseError(
  ///                 "Expected value after colon, found } "
  ///                 f"(line {token.line} column {token.column})")
  ///
  ///         value = _parse(tokens)
  ///         obj[key] = value
  ///
  ///         if len(tokens) == 0:
  ///             column_end = token.column + len(token.value)
  ///             raise ParseError(
  ///                 "Unexpected end of file while parsing "
  ///                 f"(line {token.line} column {column_end})")
  ///
  ///         token = tokens.popleft()
  ///         if token.type not in ('comma', 'right_brace'):
  ///             raise ParseError(
  ///                 f"Expected ',' or '}}', found {token.value}"
  ///                 f" (line {token.line} column {token.column})")
  ///
  ///         if token.type == 'right_brace':
  ///             break
  ///
  ///         # Trailing comma checks
  ///         if len(tokens) == 0:
  ///             column_end = token.column + len(token.value)
  ///             raise ParseError(
  ///                 "Unexpected end of file while parsing "
  ///                 f"(line {token.line} column {column_end})")
  ///
  ///         if tokens[0].type == 'right_brace':
  ///             token = tokens[0]
  ///             raise ParseError(
  ///                 "Expected value after comma, found } "
  ///                 f"(line {token.line} column {token.column})")
  ///
  ///     return obj
  /// ```
  Object? parse_object({
    required Object? tokens,
  }) =>
      getFunction("parse_object").call(
        <Object?>[
          tokens,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## parse_string
  ///
  /// ### python docstring
  ///
  /// Parses a string out of a JSON token
  ///
  /// ### python source
  /// ```py
  /// def parse_string(token: Token) -> str:
  ///     """Parses a string out of a JSON token"""
  ///     chars: List[str] = []
  ///
  ///     index = 1
  ///     end = len(token.value) - 1
  ///     line, column = token.line, token.column + 1
  ///
  ///     while index < end:
  ///         char = token.value[index]
  ///
  ///         if char != '\\':
  ///             chars.append(char)
  ///             index += 1
  ///             if char == '\n':
  ///                 line += 1
  ///                 column = 1
  ///             else:
  ///                 column += 1
  ///             continue
  ///
  ///         next_char = token.value[index+1]
  ///         if next_char == 'u':
  ///             hex_string = token.value[index+2:index+6]
  ///             try:
  ///                 unicode_char = literal_eval(f'"\\u{hex_string}"')
  ///             except SyntaxError as err:
  ///                 raise ParseError(
  ///                     f"Invalid unicode escape: \\u{hex_string} "
  ///                     f"(line {line} column {column})") from err
  ///
  ///             chars.append(unicode_char)
  ///             index += 6
  ///             column += 6
  ///             continue
  ///
  ///         if next_char in ('"', '/', '\\'):
  ///             chars.append(next_char)
  ///         elif next_char == 'b':
  ///             chars.append('\b')
  ///         elif next_char == 'f':
  ///             chars.append('\f')
  ///         elif next_char == 'n':
  ///             chars.append('\n')
  ///         elif next_char == 'r':
  ///             chars.append('\r')
  ///         elif next_char == 't':
  ///             chars.append('\t')
  ///         else:
  ///             raise ParseError(
  ///                 f"Unknown escape sequence: {token.value} "
  ///                 f"(line {line} column {column})")
  ///
  ///         index += 2
  ///         column += 2
  ///
  ///     string = ''.join(chars)
  ///     return string
  /// ```
  String parse_string({
    required Token token,
  }) =>
      getFunction("parse_string").call(
        <Object?>[
          token,
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
  /// Parser functions
  Object? get Deque => getAttribute("Deque");

  /// ## Deque (setter)
  ///
  /// ### python docstring
  ///
  /// Parser functions
  set Deque(Object? Deque) => setAttribute("Deque", Deque);

  /// ## Dict (getter)
  ///
  /// ### python docstring
  ///
  /// Parser functions
  Object? get Dict => getAttribute("Dict");

  /// ## Dict (setter)
  ///
  /// ### python docstring
  ///
  /// Parser functions
  set Dict(Object? Dict) => setAttribute("Dict", Dict);

  /// ## JSONArray (getter)
  ///
  /// ### python docstring
  ///
  /// Parser functions
  Object? get JSONArray => getAttribute("JSONArray");

  /// ## JSONArray (setter)
  ///
  /// ### python docstring
  ///
  /// Parser functions
  set JSONArray(Object? JSONArray) => setAttribute("JSONArray", JSONArray);

  /// ## JSONNumber (getter)
  ///
  /// ### python docstring
  ///
  /// Parser functions
  Object? get JSONNumber => getAttribute("JSONNumber");

  /// ## JSONNumber (setter)
  ///
  /// ### python docstring
  ///
  /// Parser functions
  set JSONNumber(Object? JSONNumber) => setAttribute("JSONNumber", JSONNumber);

  /// ## JSONObject (getter)
  ///
  /// ### python docstring
  ///
  /// Parser functions
  Object? get JSONObject => getAttribute("JSONObject");

  /// ## JSONObject (setter)
  ///
  /// ### python docstring
  ///
  /// Parser functions
  set JSONObject(Object? JSONObject) => setAttribute("JSONObject", JSONObject);

  /// ## List (getter)
  ///
  /// ### python docstring
  ///
  /// Parser functions
  Object? get $List => getAttribute("List");

  /// ## List (setter)
  ///
  /// ### python docstring
  ///
  /// Parser functions
  set $List(Object? $List) => setAttribute("List", $List);

  /// ## Union (getter)
  ///
  /// ### python docstring
  ///
  /// Parser functions
  Object? get Union => getAttribute("Union");

  /// ## Union (setter)
  ///
  /// ### python docstring
  ///
  /// Parser functions
  set Union(Object? Union) => setAttribute("Union", Union);
}
