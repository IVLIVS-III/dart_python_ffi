import FJ_AST as FJ
from FJ_auxiliary_typing import fields, mtype, is_subtype, StupidWarning
import warnings as warnings_


def typecheck_expression(expression: FJ.Expression, env: dict[str, FJ.Type], CT: dict[str, FJ.ClassDef], warnings: list[StupidWarning], error_prefix: str) -> FJ.Type:
    match expression:
        case FJ.Variable(name):
            # check if variable is valid
            if name not in env:
                if name == "super":
                    raise Exception(f"\n{error_prefix} call to 'super' is not possible, because the superclass is 'Object'")
                raise Exception(f"\n{error_prefix} no variable '{name}' was found in scope")
            return env[name]

        case FJ.FieldLookup(expression, field):
            # recursively getting type of the expression
            type_of_expression = typecheck_expression(expression, env, CT, warnings, f"{error_prefix} in the expression of fieldlookup '{field}'")
            # lookup all fields of the 'expression'
            fields_of_expression = fields(type_of_expression, CT)
            # check if the fieldlookup is valid
            if field not in fields_of_expression:
                raise Exception(f"\n{error_prefix} the fieldlookup failed - class '{str(type_of_expression)}' has no field '{field}'")
            # return the type of the field according to the fieldlookup
            return fields_of_expression[field]

        case FJ.MethodLookup(expression, method_name, parameters):
            # recursively getting type of the expression
            type_of_expression = typecheck_expression(expression, env, CT, warnings, f"{error_prefix} in the expression of the methodlookup '{method_name}'")
            # checks if the method exists
            match type_of_expression:
                case FJ.FJObject():
                    raise Exception(f"\n{error_prefix} class 'Object' has no method '{method_name}'")
                case FJ.FJClass(name) if method_name not in CT[name].methods:
                    raise Exception(f"\n{error_prefix} class '{name}' has no method '{method_name}'")
            # getting mtype of method method_name
            type_of_arguments_of_method, type_of_returnvalue_of_method = mtype(method_name, type_of_expression, CT)
            # recursively checking the types of all parameters
            type_of_parameters = [typecheck_expression(parameter, env, CT, warnings, f"{error_prefix} in the parameters of the methodlookup '{method_name}'") for parameter in parameters]
            if len(type_of_arguments_of_method) != len(type_of_parameters):
                raise Exception(f"\n{error_prefix} wrong numbers of arguments")
            # checking if the found types of the parameters match to the typedeclaration of the method (by beeing subtypes of them)
            if all([is_subtype(class_C, class_D, CT) for class_C, class_D in zip(type_of_parameters, type_of_arguments_of_method)]):
                return type_of_returnvalue_of_method
            else:
                raise Exception(f"\n{error_prefix} arguments of types '{', '.join(map(str, type_of_parameters))}' were given while arguments of subtypes of '{', '.join(map(str, type_of_arguments_of_method))}' were expected")

        case FJ.NewClass(type, parameters):
            # lookup all fields of the class 'type' (new 'type'(...))
            fields_of_class = fields(type, CT)
            # check if the number of parameters equals the number of fields
            if len(parameters) != len(fields_of_class):
                raise Exception(f"\n{error_prefix} in 'new {str(type)}' {len(fields_of_class)} arguments were expected but {len(parameters)} were given")
            # recursively checking the types of all parameters
            types_of_parameters = [typecheck_expression(expression, env, CT, warnings, f"{error_prefix} in the parameters of 'new {str(type)}'") for expression in parameters]
            # checking if the found types of the fields match the typedeclaration of the class (by beeing subtypes of them)
            if all([is_subtype(class_C, class_D, CT) for class_C, class_D in zip(types_of_parameters, fields_of_class.values())]):
                return type
            else:
                raise Exception(f"\n{error_prefix} in 'new {str(type)}' arguments of types '{', '.join(map(str, types_of_parameters))}' were given while arguments or subtypes of '{', '.join(map(str, fields_of_class.values()))}' were expected")

        case FJ.Cast(type, expression):
            type_of_expression = typecheck_expression(expression, env, CT, warnings, f"{error_prefix} in the Cast '({str(type)})'")
            if is_subtype(type_of_expression, type, CT):  # UpCast
                return type
            elif is_subtype(type, type_of_expression, CT):  # DownCast
                return type
            else:  # stupid cast
                warnings.append(StupidWarning(f"\n{error_prefix} the cast between '{str(type)}' and '{str(type_of_expression)}' is stupid"))
                return type


def typecheck_method(method: FJ.MethodDef, class_name: str, env: dict[str, FJ.Type], CT: dict[str, FJ.ClassDef], warnings: list[StupidWarning], errors: list[str]) -> bool:
    is_okey = True
    intern_env = env.copy()
    for argument, type_of_argument in method.typed_parameters.items():
        if argument == "this" or argument == "super":
            errors.append(f"In class '{class_name}' in method '{method.method_name}' arguments are not allowed to be named '{argument}'")
            is_okey = False
        intern_env[argument] = type_of_argument
    intern_env["this"] = FJ.FJClass(class_name)
    match CT[class_name].superclass:
        case FJ.FJClass(name):
            intern_env["super"] = FJ.FJClass(name)
    type_of_e0 = typecheck_expression(method.body, intern_env, CT, warnings, f"In class '{class_name}' in method '{method.method_name}'")
    if not is_subtype(type_of_e0, method.return_type, CT):
        errors.append(f"In class '{class_name}' in method '{method.method_name}' the returned expression has type '{str(type_of_e0)}' while a subtype of '{str(method.return_type)}' was expected")
        is_okey = False
    # check superclass
    if isinstance(CT[class_name].superclass, FJ.FJClass) and method.method_name in CT[str(CT[class_name].superclass)].methods.keys():
        type_of_arguments_super, return_type_super = mtype(method.method_name, CT[class_name].superclass, CT)
        if type_of_arguments_super == list(method.typed_parameters.values()) and return_type_super == method.return_type:
            return True
        else:
            errors.append(f"In class '{class_name}' in method '{method.method_name}' the typesignature differs from the typesignatur of the method '{method.method_name}' defined in superclass '{str(CT[class_name].superclass)}' ({','.join(map(str, method.typed_parameters.values()))} != {','.join(map(str, type_of_arguments_super))} and/or {str(method.return_type)} != {str(return_type_super)})")
            is_okey = False
    return is_okey


def typecheck_class_definition(class_definition: FJ.ClassDef, env: dict[str, FJ.Type], CT: dict[str, FJ.ClassDef], warnings: list[StupidWarning], errors: list[str]) -> bool:
    # check constructor
    return all([typecheck_method(method, class_definition.class_name, env, CT, warnings, errors) for method in class_definition.methods.values()])


def typecheck_class_definitions(env: dict[str, FJ.Type], CT: dict[str, FJ.ClassDef], warnings: list[StupidWarning], errors: list[str]) -> bool:
    # fill env
    return all([typecheck_class_definition(class_definition, env, CT, warnings, errors) for class_definition in CT.values()])


def typecheck_program(program: FJ.Program) -> FJ.Type:
    env = dict()
    warnings = list()
    errors = list()
    if typecheck_class_definitions(env, program.class_table, warnings, errors):
        type_of_expression = typecheck_expression(program.expression, env, program.class_table, warnings, "In main")
        for warning in warnings:
            warnings_.warn(warning)
        return type_of_expression
    else:
        raise Exception("\n" + "\n".join(errors))
