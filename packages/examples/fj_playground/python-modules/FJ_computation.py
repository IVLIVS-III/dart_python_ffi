import FJ_AST as FJ
from FJ_auxiliary_typing import fields, mbody, is_subtype


def get_expression_of_right_side(right_side: FJ.MethodSuperLookUpRight, expression: FJ.Type, CT: dict[str, FJ.ClassDef]) -> tuple[FJ.Type, str, list[FJ.Expression]]:
    match right_side:
        case FJ.MethodSuperLookUpRight((method, parameters)):
            return expression, method, parameters
        case FJ.MethodSuperLookUpRight(inner_content):
            if type(expression) is not FJ.FJClass:
                raise Exception(f"BECAUSE CONGRUENCE RULES -> CANT GO HERE BUT PYTHON STILL NEEDS THIS CHECK FOR TYPEINFERENCE - Expected expression of Type FJClass, got {type(expression)}")
            superclass = CT[expression.name].superclass
            if type(superclass) is not FJ.FJClass:
                raise Exception(f"BECAUSE CONGRUENCE RULES -> CANT GO HERE BUT PYTHON STILL NEEDS THIS CHECK FOR TYPEINFERENCE - Expected expression of Type FJClass, got {type(expression)}")
            return get_expression_of_right_side(inner_content, superclass, CT)


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

        # Version without 'super'
        # case FJ.MethodLookup(expression, method_name, expressions):
        #     if type(expression) is not FJ.NewClass:
        #         raise Exception(f"BECAUSE CONGRUENCE RULES -> CANT GO HERE BUT PYTHON STILL NEEDS THIS CHECK FOR TYPINFERENCE - Expected expression of Type NewClass, got {type(expression)}")
        #     # x.e
        #     mbody_variables, mbody_expression = mbody(method_name, expression.type, CT)
        #     # expressions == arguments (replacing x) | expression == newClass (replacing this)
        #     # mbody_expression == e0 | mbody_variables == x
        #     return congruence_expression(replace_things(mbody_expression, expressions, mbody_variables, expression, CT), CT)

        case FJ.MethodSuperLookup(expression, right_side):
            if type(expression) is not FJ.NewClass:
                raise Exception(f"BECAUSE CONGRUENCE RULES -> CANT GO HERE BUT PYTHON STILL NEEDS THIS CHECK FOR TYPINFERENCE - Expected expression of Type NewClass, got {type(expression)}")
            superclass, method_name, expressions = get_expression_of_right_side(right_side, expression.type, CT)
            mbody_variables, mbody_expression = mbody(method_name, superclass, CT)
            return congruence_expression(replace_things(mbody_expression, expressions, mbody_variables, expression, CT), CT)

        case FJ.Cast(type_of_class, expression):
            if type(expression) is not FJ.NewClass:
                raise Exception(f"BECAUSE CONGRUENCE RULES -> CANT GO HERE BUT PYTHON STILL NEEDS THIS CHECK FOR TYPINFERENCE - Expected expression of Type NewClass, got {type(expression)}")
            if is_subtype(expression.type, type_of_class, CT):  # UpCast
                return expression
            elif is_subtype(type_of_class, expression.type, CT):  # DownCast
                raise Exception(f"DownCast are not allowed - '{str(type_of_class)}' is a subtype of '{str(expression.type)}'")
            else:  # StupidCast
                raise Exception(f"Stupid Casts are not allowed - '{str(expression.type)}' is not a subtype of '{str(type_of_class)}' and vice versa")


def replace_things_right_side(right_side: FJ.MethodSuperLookUpRight, arguments: list[FJ.Expression], xs: list[str], newClass: FJ.Expression, CT: dict[str, FJ.ClassDef]) -> FJ.MethodSuperLookUpRight:
    match right_side:
        case FJ.MethodSuperLookUpRight(method, parameters):
            new_parameters = [replace_things(e, arguments, xs, newClass, CT) for e in parameters]
            return FJ.MethodSuperLookUpRight((method, new_parameters))
        case FJ.MethodSuperLookUpRight(inner_content):
            return FJ.MethodSuperLookUpRight(replace_things_right_side(inner_content, arguments, xs, newClass, CT))


def replace_things(e0: FJ.Expression, arguments: list[FJ.Expression], xs: list[str], newClass: FJ.Expression, CT: dict[str, FJ.ClassDef]) -> FJ.Expression:
    match e0:
        case FJ.Variable(name):
            if name == "this":
                return newClass
            elif name not in xs:
                raise Exception(f"IF WELL TYPED -> CANT GO HERE - Variable {name} not found in scope")
            else:
                return arguments[xs.index(name)]

        case FJ.FieldLookup(expression, field):
            return FJ.FieldLookup(replace_things(expression, arguments, xs, newClass, CT), field)

        case FJ.MethodSuperLookup(expression, right_side):
            new_expression = replace_things(expression, arguments, xs, newClass, CT)
            new_right_side = replace_things_right_side(right_side, arguments, xs, newClass, CT)
            return FJ.MethodSuperLookup(new_expression, new_right_side)

        # Version without 'super'
        # case FJ.MethodLookup(expression, method_name, expressions):
        #     return FJ.MethodLookup(replace_things(expression, arguments, xs, newClass, CT), method_name, [replace_things(e, arguments, xs, newClass, CT) for e in expressions])

        case FJ.NewClass(type, expressions):
            return FJ.NewClass(type, [replace_things(inner_expression, arguments, xs, newClass, CT) for inner_expression in expressions])

        case FJ.Cast(type, expression):
            return FJ.Cast(type, replace_things(expression, arguments, xs, newClass, CT))


def congruence_right_side(right_side: FJ.MethodSuperLookUpRight, CT: dict[str, FJ.ClassDef]) -> FJ.MethodSuperLookUpRight:
    match right_side:
        case FJ.MethodSuperLookUpRight((method, parameters)):
            return FJ.MethodSuperLookUpRight((method, [congruence_expression(single_expression, CT) for single_expression in parameters]))
        case FJ.MethodSuperLookUpRight(inner_content):
            return FJ.MethodSuperLookUpRight(congruence_right_side(inner_content, CT))


def congruence_expression(expression: FJ.Expression, CT: dict[str, FJ.ClassDef]) -> FJ.Expression:
    match expression:
        case FJ.NewClass(inner_type, inner_expressions) if not inner_expressions:
            return expression

        case FJ.FieldLookup(inner_expression, inner_field):
            new_expression = congruence_expression(inner_expression, CT)
            return compute_expression(FJ.FieldLookup(new_expression, inner_field), CT)

        case FJ.MethodSuperLookup(expression, right_side):
            new_expression = congruence_expression(expression, CT)
            new_right_side = congruence_right_side(right_side, CT)
            return compute_expression(FJ.MethodSuperLookup(new_expression, new_right_side), CT)

        # Version without 'super'
        # case FJ.MethodLookup(inner_expression, inner_method_name, inner_expressions):
        #     new_expression = congruence_expression(inner_expression, CT)
        #     new_expressions = [congruence_expression(single_expression, CT) for single_expression in inner_expressions]
        #     return compute_expression(FJ.MethodLookup(new_expression, inner_method_name, new_expressions), CT)

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
    return congruence_expression(program.expression, program.class_table)
