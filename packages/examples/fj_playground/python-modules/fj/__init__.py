"""FJ Project"""

from .FJ_AST import Program
from .FJ_parser import fj_parse
from .FJ_typing import typecheck_program
from .FJ_computation import compute_program

__all__ = (
    "Program",
    "fj_parse",
    "typecheck_program",
    "compute_program",
)
