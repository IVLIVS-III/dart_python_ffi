import FJ_AST as FJ
from FJ_parser import fj_parse
from FJ_typing import typecheck_program
from FJ_computation import compute_program

from lark import UnexpectedCharacters

import sys


def run_interpreter_on_file_to_terminal(file_path: str):
    program = read_from(file_path)
    type_of_expression = typecheck_program(program)
    computed_expression = compute_program(program)
    print()
    print(program.str_with_constructor())
    # print(program)
    print(f"\n{computed_expression} :: {type_of_expression}\n")


def only_typecheck_on_file_to_terminal(file_path: str):
    program = read_from(file_path)
    type_of_expression = typecheck_program(program)
    print()
    print(program.str_with_constructor())
    print(f"\nType is -> {type_of_expression}\n")


def run_interpreter_on_file(file_path: str, out_file_path: str = ""):
    """
    Interpretes the Featherweight Java code in the given file.\n
    \n
    By default the computed expression is appended in the given file.\n
    A different outputfile can be given via the 'out_file_path' parameter.
    """
    if out_file_path == "":
        out_file_path = file_path
    program = read_from(file_path)
    type_of_expression = typecheck_program(program)
    computed_expression = compute_program(program)
    if file_path != out_file_path:
        write_in(out_file_path, program)
    write_in_computed(out_file_path, type_of_expression, computed_expression)


def only_typecheck(file_path: str, out_file_path: str = ""):
    if out_file_path == "":
        out_file_path = file_path
    program = read_from(file_path)
    type_of_expression = typecheck_program(program)
    if file_path != out_file_path:
        write_in(out_file_path, program)
    write_in_type(out_file_path, type_of_expression)


def read_from(file_path: str) -> FJ.Program:
    with open(file_path, "r") as file:
        try:
            return fj_parse(file.read())
        except UnexpectedCharacters as exc:
            raise Exception(f"\n\nSyntax Error\n\n{str(exc).split('^')[0]}^")


def write_in(file_path: str, code: FJ.Program):
    with open(file_path, "a") as file:
        # file.write(str(code) + "\n")
        file.write(code.str_with_constructor() + "\n")


def write_in_computed(file_path: str, type_of_expression: FJ.Type, computed_expression: FJ.NewClass):
    with open(file_path, "a") as file:
        file.write("\n")
        file.write(f"{computed_expression} :: {type_of_expression}\n")


def write_in_type(file_path: str, type_of_expression: FJ.Type):
    with open(file_path, "a") as file:
        file.write("\n")
        file.write(f"Type is -> {type_of_expression}\n")


def print_help():
    print("\nWelcome to the Featherweight Java interpreter\n")
    print("\tUSAGE: python3 FJ_interpreter.py inpath [outpath | -o] [-t]\n")
    print("\tIf no outpath is given the outpath is set to the inpath")
    print("\tIf instead of the outpath '-o' is given, the output is printed to the terminal")
    print("\tIf '-t' is given, the program is only typechecked and the resulting type is returned")
    print("\tIf the given outpath doesn't exist, a new file is created\n")


if __name__ == "__main__":
    match sys.argv:
        case [_]:
            print("\nWrong use of the Featherweight Java interpreter.\nTry '--help' to see the correct usage\n")
        case [_, "--help"]:
            print_help()
        case [_, inpath]:
            run_interpreter_on_file(inpath)
        case [_, inpath, "-t"]:
            only_typecheck(inpath)
        case [_, inpath, "-o"]:
            run_interpreter_on_file_to_terminal(sys.argv[1])
        case [_, inpath, outpath]:
            run_interpreter_on_file(inpath, outpath)
        case [_, inpath, "-o", "-t"]:
            only_typecheck_on_file_to_terminal(inpath)
        case [_, inpath, outpath, "-t"]:
            only_typecheck(inpath, outpath)
        case _:
            print("\nWrong use of the Featherweight Java interpreter.\nTry '--help' to see the correct usage\n")
