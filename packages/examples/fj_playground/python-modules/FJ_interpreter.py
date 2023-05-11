import FJ_AST as FJ
from FJ_parser import fj_parse
from FJ_typing import typecheck_program
from FJ_computation import compute_program

from lark import UnexpectedCharacters
import argparse

import sys


def read_from(file_path: str) -> FJ.Program:
    with open(file_path, "r") as file:
        try:
            return fj_parse(file.read())
        except UnexpectedCharacters as exc:
            raise Exception(f"\n\nSyntax Error\n\n{str(exc).split('^')[0]}^")


def run(file_path: str, out_file_path: str, to_stdout: bool, only_typecheck: bool, with_constructor: bool):
    program = read_from(file_path)
    type_of_expr = typecheck_program(program)

    def write(text: str, mode: str = "a"):
        if to_stdout:
            print(text)
        else:
            with open(out_file_path, mode) as file:
                file.write(text)

    if with_constructor:
        write(program.str_with_constructor() + "\n", mode="w")
    elif file_path != out_file_path:
        write(str(program), mode="w")

    if only_typecheck:
        write(f"\n{program.expression} :: {type_of_expr}\n")
    else:
        computed_expr = compute_program(program)
        write(f"\n{computed_expr} :: {type_of_expr}\n")


def fj_run(program_as_str: str, with_constructor: bool = False, only_typecheck: bool = False) -> tuple[str, str, str]:
    """
    Takes a featherweight java program as a string.\n
    \n
    By default returns a tuple of strings containing:\n
    \tThe program, the computed expression and the type of the expression.\n
    \n
    If 'with_constructor' is set to True:\n
    \tThe returned program contains constructor definitions, even if the original program does not.\n
    \n
    If 'only_typecheck' is set to True:\n
    \tThe returned tuple contains the program, the not computed expression and the type of the expression.
    """
    program = fj_parse(program_as_str)
    type_of_expr = typecheck_program(program)
    if only_typecheck:
        if with_constructor:
            return program.str_with_constructor(), str(program.expression), str(type_of_expr)
        return str(program), str(program.expression), str(type_of_expr)
    else:
        comp_expr = compute_program(program)
        if with_constructor:
            return program.str_with_constructor(), str(comp_expr), str(type_of_expr)
        return str(program), str(comp_expr), str(type_of_expr)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="Featerweight Java Interpreter",
        description="Given a Featherweight Java program, this interpreter typechecks and computes it."
    )

    parser.add_argument("inpath", help="The file your FJ program is in.")
    parser.add_argument("outpath", nargs="?", help="The file the output is printed in. If none given, the output is printed into the infile.")
    parser.add_argument("-o", "--outpath", action="store_true", help="Print the output to the terminal.")
    parser.add_argument("-t", "--typecheck", action="store_true", help="The program is typechecked but not computed.")
    parser.add_argument("-c", "--constructor", action="store_true", help="The output includes constructors (even if the infile does not).")

    options = parser.parse_args(sys.argv[1:])

    run(options.inpath, options.outpath or options.inpath, options.outpath, options.typecheck, options.constructor)
