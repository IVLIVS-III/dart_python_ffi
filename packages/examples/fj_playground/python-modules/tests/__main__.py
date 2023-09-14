from __future__ import absolute_import, print_function

import unittest
import logging
import sys
from lark import logger

from .test_trees import TestTrees
from .test_tools import TestStandalone
from .test_cache import TestCache
from .test_grammar import TestGrammar
from .test_reconstructor import TestReconstructor
from .test_tree_forest_transformer import TestTreeForestTransformer
from .test_lexer import TestLexer
from .test_python_grammar import TestPythonParser
from .test_tree_templates import *  # We define __all__ to list which TestSuites to run

try:
    from .test_nearley.test_nearley import TestNearley
except ImportError:
    logger.warning("Warning: Skipping tests for Nearley grammar imports (js2py required)")

# from .test_selectors import TestSelectors
# from .test_grammars import TestPythonG, TestConfigG

from .test_logger import Testlogger

from .test_parser import *  # We define __all__ to list which TestSuites to run

if sys.version_info >= (3, 10):
    from .test_pattern_matching import TestPatternMatching

logger.setLevel(logging.INFO)

if __name__ == '__main__':
    unittest.main()
