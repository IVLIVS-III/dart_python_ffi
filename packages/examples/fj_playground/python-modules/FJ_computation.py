import FJ_AST as FJ
from FJ_auxiliary_typing import fields, mbody, is_subtype  #, cast_counter


def compute_expression(outer_expression: FJ.Expression, CT: dict[str, FJ.ClassDef]) -> FJ.Expression:
    match outer_expression:
        case FJ.NewClass() | FJ.Variable():
            return outer_expression

        case FJ.FieldLookup(expression, field):
            if type(expression) is not FJ.NewClass:
                raise Exception(f"BECAUSE CONGRUENCE RULES -> CANT GO HERE BUT PYTHON STILL NEEDS THIS CHECK FOR TYPINFERENCE - Expected expression of Type NewClass, got {type(expression)}")
            field_names = fields(expression.type, CT).keys()
            if field not in field_names:
                raise Exception(f"IF WELL TYPED -> CANT GO HERE - Class {str(expression.type)} has no field {field}")
            else:
                # only works when the keys of the dictionary have the same orde as the list of parameters
                return expression.parameters[list(field_names).index(field)]

        case FJ.MethodLookup(expression, method_name, expressions, super_counter):
            if type(expression) is not FJ.NewClass:
                raise Exception(f"BECAUSE CONGRUENCE RULES -> CANT GO HERE BUT PYTHON STILL NEEDS THIS CHECK FOR TYPINFERENCE - Expected expression of Type NewClass, got {type(expression)}")
            # x.e
            mbody_variables, mbody_expression = mbody(method_name, expression.type, CT, super_counter)
            # expressions == arguments (replacing x) | expression == newClass (replacing this)
            # mbody_expression == e0 | mbody_variables == x
            expr = replace_things(mbody_expression, expressions, mbody_variables, expression, CT, super_counter)
            return congruence_expression(expr, CT)

        case FJ.Cast(type_of_class, expression):
            if type(expression) is not FJ.NewClass:
                raise Exception(f"BECAUSE CONGRUENCE RULES -> CANT GO HERE BUT PYTHON STILL NEEDS THIS CHECK FOR TYPINFERENCE - Expected expression of Type NewClass, got {type(expression)}")
            if is_subtype(expression.type, type_of_class, CT):  # UpCast
                return expression
            elif is_subtype(type_of_class, expression.type, CT):  # DownCast
                raise Exception(f"DownCast are not allowed - '{str(type_of_class)}' is a subtype of '{str(expression.type)}'")
            else:  # StupidCast
                raise Exception(f"Stupid Casts are not allowed - '{str(expression.type)}' is not a subtype of '{str(type_of_class)}' and vice versa")


def replace_things(e0: FJ.Expression, arguments: list[FJ.Expression], xs: list[str], newClass: FJ.Expression, CT: dict[str, FJ.ClassDef], super_counter: int) -> FJ.Expression:
    match e0:
        case FJ.Variable(name):
            if name == "this" or name == "super":
                return newClass
            elif name not in xs:
                raise Exception(f"IF WELL TYPED -> CANT GO HERE - Variable {name} not found in scope")
            else:
                return arguments[xs.index(name)]

        case FJ.FieldLookup(expression, field):
            new_expression = replace_things(expression, arguments, xs, newClass, CT, super_counter)
            return FJ.FieldLookup(new_expression, field)

        case FJ.MethodLookup(expression, method_name, expressions):
            match expression:
                case FJ.Variable("super"):
                    new_super_counter = super_counter + 1
                case _:
                    new_super_counter = 0
            new_expression = replace_things(expression, arguments, xs, newClass, CT, super_counter)
            new_expressions = [replace_things(e, arguments, xs, newClass, CT, super_counter) for e in expressions]
            return FJ.MethodLookup(new_expression, method_name, new_expressions, new_super_counter)

        case FJ.NewClass(type_of, expressions):
            new_expressions = [replace_things(inner_expression, arguments, xs, newClass, CT, super_counter) for inner_expression in expressions]
            return FJ.NewClass(type_of, new_expressions)

        case FJ.Cast(type_of, expression):
            new_expression = replace_things(expression, arguments, xs, newClass, CT, super_counter)
            return FJ.Cast(type_of, new_expression)


def congruence_expression(expression: FJ.Expression, CT: dict[str, FJ.ClassDef]) -> FJ.Expression:
    match expression:
        case FJ.FieldLookup(inner_expression, inner_field):
            new_expression = congruence_expression(inner_expression, CT)
            return compute_expression(FJ.FieldLookup(new_expression, inner_field), CT)

        case FJ.MethodLookup(inner_expression, inner_method_name, inner_expressions, sp):
            new_expression = congruence_expression(inner_expression, CT)
            new_expressions = [congruence_expression(single_expression, CT) for single_expression in inner_expressions]
            return compute_expression(FJ.MethodLookup(new_expression, inner_method_name, new_expressions, sp), CT)

        case FJ.NewClass(inner_type, inner_parameters):
            new_parameters = [congruence_expression(parameter, CT) for parameter in inner_parameters]
            return FJ.NewClass(inner_type, new_parameters)

        case FJ.Cast(inner_type, inner_expression):
            new_expression = congruence_expression(inner_expression, CT)
            return compute_expression(FJ.Cast(inner_type, new_expression), CT)


def compute_program(program: FJ.Program) -> FJ.NewClass:
    """
    Takes a well parsed program and computes it.\n
    If the program isnt well typed it may get stuck here.
    """
    congruenced_expression = congruence_expression(program.expression, program.class_table)
    return congruenced_expression
