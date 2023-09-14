"""JSON parser tests"""
from typing import List

import pytest

from json_parser.lexer import tokenize, TokenizeError


@pytest.mark.parametrize(
    ('json_string', 'expected'),
    (
        ('""', ['""']),
        ('"abc"', ['"abc"']),
        ('42', ['42']),
        ('{}', ['{', '}']),
        ('{"abc": "def"}', ['{', '"abc"', ':', '"def"', '}']),
        ('{"value": 42}', ['{', '"value"', ':', '42', '}']),
        ('{"value": 12.3}', ['{', '"value"', ':', '12.3', '}']),
        ('[]', ['[', ']']),
        ('["foo", "bar"]', ['[', '"foo"', ',', '"bar"', ']']),
        ('[1, 2, 3, "abc"]', ['[', '1', ',', '2', ',', '3', ',', '"abc"', ']']),
        ('{"value": true}', ['{', '"value"', ':', 'true', '}']),
        ('{"value": false}', ['{', '"value"', ':', 'false', '}']),
        ('{"value": null}', ['{', '"value"', ':', 'null', '}']),
        ('{"foo": [1, 2, {"bar": 3}]}',
         ['{', '"foo"', ':', '[', '1', ',', '2', ',', '{', '"bar"', ':', '3', '}', ']', '}']),
    )
)
def test_lexer(json_string: str, expected: List[str]) -> None:
    """JSON lexer tests"""
    assert [token.value for token in tokenize(json_string)] == expected


@pytest.mark.parametrize(
    ('json_string', 'error_message'),
    (
        ('', 'Cannot parse empty string'),
        ('blabla', 'Unknown token found: blabla (line 1 column 1)'),
        ('"abc', 'Expected end of string (line 1 column 5)'),
        ('"abc\\"', 'Expected end of string (line 1 column 7)'),
        ('["a", "b", c]', 'Unknown token found: c (line 1 column 12)'),
        ('''{
            "values": ["a", "b", c]
        }''', 'Unknown token found: c (line 2 column 34)'),
        ('''{
            "values": ["a", "b", {
                "test": "ok",
                "wow": ["Such", "tests,]
            }]
        }''', 'Expected end of string (line 6 column 10)'),
    )
)
def test_lexer_failure(json_string: str, error_message: str) -> None:
    """JSON lexer test failutes"""
    with pytest.raises(TokenizeError) as exinfo:
        tokenize(json_string)

    msg, = exinfo.value.args
    assert msg == error_message
