from lark import Lark
from lark import Transformer
import FJ_AST as FJ


class ParseException(Exception):
    pass


featherweight_java_parser = Lark(r"""

    %import common.WS
    %ignore WS



    char : "a".."z" | "A".."Z"

    identifier : char+



    type : fjobject | fjclass

    fjobject : "Object"

    fjclass : identifier



    expression : "(" expression ")" | cast | variable | method_lookup | field_lookup | new_class

    variable : identifier

    method_lookup : expression "." identifier "(" expression_list ")"

    field_lookup : expression "." identifier

    new_class : "new" type "(" expression_list ")"

    cast : "(" type ")" expression



    fieldenv : (fieldenv_helper ";")*

    varenv : (varenv_helper ("," varenv_helper)*)?



    method_def : type " " identifier "(" varenv ")" "{" "return" expression  \
                 ";" "}"

    class_def : "class" identifier "extends" type "{" fieldenv constructor? \
                method_list "}"

    class_def_list : class_def*

    program : class_def_list (" " | "\n") expression



    fieldenv_helper : type " " identifier

    varenv_helper : type " " identifier



    expression_list : (expression ("," expression)*)?

    method_list : method_def*



    with_error_warnings : program



    constructor : type "(" (type " " identifier ("," type " " identifier)*)? \
        ")" "{" "super(" (identifier ("," identifier)*)? ");" ("this." \
        identifier "=" identifier ";")* "}"
    """, start=["char", "identifier", "type", "fjobject", "fjclass",
                "expression", "variable", "field_lookup", "method_lookup",
                "new_class", "cast", "fieldenv", "varenv", "method_def",
                "class_def", "program", "fieldenv_helper", "varenv_helper",
                "expression_list", "method_list", "with_error_warnings"]
    )


class TreeToFJ(Transformer):

    # Handling unallowed synatx

    errors: list[str] = list()
    keywords: list[str] = ["Object", "class", "extends", "return",
                           "new"]
    not_for_fields: list[str] = ["this", "super"]

    def check_if_keyword(self, string: str):
        if string in self.keywords:
            self.errors.append(f"Using a keyword as identifier: '{string}'")

    def check_variable_name(self, string: str):
        if string[0].isupper():
            self.errors.append(f"Names of variables must begin with a\
                                 lowercase: '{string}'")

    def check_fields_or_methods(self, string: str):
        if string in self.not_for_fields:
            self.errors.append(f"'super' is not allowed to be a part of a method name ('{string}')")

    def check_class_name(self, string: str):
        if string[0].islower():
            self.errors.append(f"Names of classes must begin with an \
                                 uppercase: '{string}'")

    def show_errors(self):
        if self.errors != []:
            error_msg = f"Found {len(self.errors)} Error(s):\n" + \
                          "\n".join(self.errors)
            # have to delete all error messages, because type(self.errors) is list and lists are mutable over different instances
            # have to make that pretier...
            while len(self.errors):
                self.errors.pop()
            raise ParseException(error_msg)

    ###########################

    def char(self, char_tupled):
        ((char,),) = char_tupled
        return char

    def identifier(self, list_of_chars):
        identifier = "".join(list_of_chars)
        self.check_if_keyword(identifier)
        return identifier

    def type(self, type_tupled):
        (type,) = type_tupled
        return type

    def fjobject(self, _):
        return FJ.FJObject()

    def fjclass(self, class_name_tupled):
        (class_name,) = class_name_tupled
        return FJ.FJClass(class_name)

    def expression(self, expression_tupled):
        (expression,) = expression_tupled
        return expression

    def variable(self, variable_tupled):
        (variable,) = variable_tupled
        self.check_variable_name(variable)
        return FJ.Variable(variable)

    def field_lookup(self, field_lookup):
        expression, field = field_lookup
        self.check_fields_or_methods(field)
        return FJ.FieldLookup(expression, field)

    def method_lookup(self, method_lookup):
        expression, name, expressions = method_lookup
        self.check_fields_or_methods(name)
        return FJ.MethodLookup(expression, name, expressions)

    def new_class(self, new_class):
        type, parameters = new_class
        return FJ.NewClass(type, parameters)

    def cast(self, cast):
        type, expression = cast
        return FJ.Cast(type, expression)

    def fieldenv(self, fieldenv_tupled_list):
        return dict(fieldenv_tupled_list)

    def varenv(self, varenv_tupled_list):
        return dict(varenv_tupled_list)

    def method_def(self, method_def):
        (return_type, name, types_and_parameters, body) = method_def
        return FJ.MethodDef(name, return_type, types_and_parameters, body)

    def class_def(self, class_def):
        if len(class_def) == 4:
            class_name, super_class, fieldenv, methods = class_def
        else:
            class_name, super_class, fieldenv, constructor, methods = class_def
        self.check_class_name(class_name)
        return FJ.ClassDef(class_name, super_class, fieldenv, methods)

    def class_def_list(self, class_def_list):
        return dict([(x.class_name, x) for x in class_def_list])

    def program(self, class_table_and_expression):
        (class_table, expression) = class_table_and_expression
        return FJ.Program(class_table, expression)

    def fieldenv_helper(self, typed_identifier):
        type, identifier = typed_identifier
        return identifier, type

    def varenv_helper(self, typed_variable):
        (type, variable) = typed_variable
        return variable, type

    def expression_list(self, es):
        return list(es)

    def method_list(self, method_list):
        return dict([(x.method_name, x) for x in method_list])

    def with_error_warnings(self, program_tupled):
        self.show_errors()
        (program,) = program_tupled
        return program


# Parsefunction


def fj_parse(source_code_txt: str, start_rule: str = "with_error_warnings") -> FJ.Program:
    '''
    Parses a given program source code textfile to a Featherweight Java program
    ( A program is a pair of a classtable and an expression )
    '''
    tree = featherweight_java_parser.parse(source_code_txt, start_rule)
    shaped_tree = TreeToFJ().transform(tree)
    return shaped_tree
