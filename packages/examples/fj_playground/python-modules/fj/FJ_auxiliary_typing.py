import FJ_AST as FJ


class StupidWarning(Warning):
    def __init__(self, message):
        if type(message) is not str:
            raise Exception("Warning messages must be a String")
        self.__message: str = message

    @property
    def message(self):
        return self.__message

    def __str__(self):
        return self.message


def is_subtype(c: FJ.Type, d: FJ.Type, CT: FJ.ClassTable) -> bool:
    """
    True if C <: D
    """
    match (c, d):
        case _, FJ.FJObject():
            return True
        case FJ.FJObject(), _:
            return False
        case FJ.FJClass(name_of_c), FJ.FJClass(name_of_d) if name_of_c == name_of_d:
            return True
        case FJ.FJClass(name_of_c), _:
            return is_subtype(CT[name_of_c].superclass, d, CT)


def fields(fjclass: FJ.Type, CT: FJ.ClassTable) -> dict[str, FJ.Type]:
    """
    fields(C, CT) == {field_of_C : Typ, ...}
    """
    match fjclass:
        case FJ.FJObject():
            return dict()
        case FJ.FJClass(name):
            return merge_dicts(CT[name].typed_fields, fields(CT[name].superclass, CT))
        case _:
            raise Exception(f"{str(fjclass)} is neither FJObject nor FJClass")


def mtype(method_name: str, fjclass: FJ.Type, CT: FJ.ClassTable) -> tuple[list[FJ.Type], FJ.Type]:
    """
    mtype(m, class_name, CT) == ([argument_type, ...], return_type)
    """
    match fjclass:
        case FJ.FJClass(name) if method_name in CT[name].methods.keys():
            return ([x for x in CT[name].methods[method_name].typed_parameters.values()], CT[name].methods[method_name].return_type)
        case FJ.FJClass(name):
            return mtype(method_name, CT[name].superclass, CT)


def mbody(method_name: str, fjclass: FJ.Type, CT: FJ.ClassTable) -> tuple[list[str], FJ.Expression]:
    """
    mbody(m, C, CT) == ([parameters, ...], expression)
    """
    match fjclass:
        case FJ.FJClass(name) if method_name in CT[name].methods.keys():
            return list(CT[name].methods[method_name].typed_parameters.keys()), CT[name].methods[method_name].body
        case FJ.FJClass(name):
            return mbody(method_name, CT[name].superclass, CT)


def merge_dicts(d1: dict[str, FJ.Type], d2: dict[str, FJ.Type]) -> dict[str, FJ.Type]:
    d_out = d1
    for key, value in d2.items():
        # need the seccond condition so stupid casts are detected
        if key in d_out.keys() and value != d_out[key]:
            raise Exception(f"Keys are not distinct -> {key}")
        d_out[key] = value
    return d_out
