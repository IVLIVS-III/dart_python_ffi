"""Lexer functions"""
from collections import deque
from typing import Deque, Literal, NamedTuple, Tuple
from string import whitespace as WHITESPACE

TokenType = Literal[
    'string',
    'number',
    'boolean',
    'null',
    'left_bracket',
    'left_brace',
    'right_bracket',
    'right_brace',
    'comma',
    'colon',
]


class Token(NamedTuple):
    """Represents a Token extracted by the parser"""
    value: str
    type: TokenType
    line: int
    column: int


class TokenizeError(Exception):
    """Error thrown when an invalid JSON string is tokenized"""


def extract_string(
        json_string: str,
        index: int,
        tokens: Deque[Token],
        line: int,
        column: int) -> Tuple[int, int, int]:
    """Extracts a single string token from JSON string"""
    start = index
    end = len(json_string)
    start_line, start_column = line, column
    index += 1
    column += 1

    while index < end:
        char = json_string[index]

        if char == '\\':
            if index + 1 == end:
                raise TokenizeError("Incomplete escape at end of string")

            index += 2
            column += 2
            continue

        if char == '"':
            index += 1
            column += 1
            string = json_string[start:index]
            tokens.append(Token(string, 'string', start_line, start_column))

            return index, line, column

        index += 1
        if char == '\n':
            column = 1
            line += 1
        else:
            column += 1

    err = f"Expected end of string (line {line} column {column})"
    raise TokenizeError(err)


def extract_number(
        json_string: str,
        index: int,
        tokens: Deque[Token],
        line: int,
        column: int) -> Tuple[int, int, int]:
    """Extracts a single number token (eg. 42, -12.3) from JSON string"""
    start = index
    end = len(json_string)

    leading_minus_found = False
    decimal_point_found = False

    while index < end:
        char = json_string[index]
        if char == '.':
            if decimal_point_found:
                raise TokenizeError("Too many decimal points in number")

            decimal_point_found = True

        elif char == '-':
            if leading_minus_found:
                raise TokenizeError("Minus sign in between number")

            leading_minus_found = True

        elif not char.isdigit():
            break

        index += 1

    number = json_string[start:index]
    tokens.append(Token(number, 'number', line, column))
    length = index - start
    column += length
    return index, line, column


def extract_special(
        json_string: str,
        index: int,
        tokens: Deque[Token],
        line: int,
        column: int) -> Tuple[int, int, int]:
    """Extracts true, false and null from JSON string"""
    end = len(json_string)

    word = ''
    while index < end:
        char = json_string[index]
        if not char.isalpha():
            break

        word += char
        index += 1

    if word in ('true', 'false', 'null'):
        token = Token(
            word,
            line=line,
            column=column,
            type='null' if word == 'null' else 'boolean'
        )
        tokens.append(token)
        column += len(word)
        return index, line, column

    err = f"Unknown token found: {word} (line {line} column {column})"
    raise TokenizeError(err)


def tokenize(json_string: str) -> Deque[Token]:
    """Converts a JSON string into a queue of tokens"""
    tokens: Deque[Token] = deque()

    line = column = 1
    index = 0
    end = len(json_string)
    while index < end:
        char = json_string[index]

        if char in WHITESPACE:
            index += 1

            if char == '\n':
                column = 1
                line += 1
            else:
                column += 1

        elif char in '[]{},:':
            token = Token(
                char,
                line=line,
                column=column,
                type=('left_bracket' if char == '[' else
                      'right_bracket' if char == ']' else
                      'left_brace' if char == '{' else
                      'right_brace' if char == '}' else
                      'comma' if char == ',' else 'colon')
            )
            tokens.append(token)
            index += 1
            column += 1

        elif char == '"':
            index, line, column = extract_string(
                json_string, index, tokens, line, column)

        elif char == '-' or char.isdigit():
            index, line, column = extract_number(
                json_string, index, tokens, line, column)

        else:
            index, line, column = extract_special(
                json_string, index, tokens, line, column)

    if len(tokens) == 0:
        raise TokenizeError("Cannot parse empty string")

    return tokens
