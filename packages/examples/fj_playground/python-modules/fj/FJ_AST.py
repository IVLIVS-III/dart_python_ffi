from dataclasses import dataclass


class Type:
    pass


@dataclass(frozen=True)
class FJObject(Type):

    def __str__(self) -> str:
        return "Object"


@dataclass(frozen=True)
class FJClass(Type):
    name: str

    def __str__(self) -> str:
        return self.name


class Expression:
    pass


@dataclass(frozen=True)
class Variable(Expression):
    '''
    variable
    '''
    name: str

    def __str__(self) -> str:
        return self.name


@dataclass(frozen=True)
class FieldLookup(Expression):
    '''
    expression.field
    '''
    expression: Expression
    field: str

    def __str__(self) -> str:
        expr = "(" + str(self.expression) + ")" if isinstance(self.expression, Cast) else str(self.expression)
        return f"{expr}.{self.field}"


# Version without 'super'
# @dataclass(frozen=True)
# class MethodLookup(Expression):
#     '''
#     expression.method(expressions)
#     '''
#     expression: Expression
#     method: str
#     parameters: list[Expression]

#     def __str__(self) -> str:
#         expr = "(" + str(self.expression) + ")" if isinstance(self.expression, Cast) else str(self.expression)
#         return f"{expr}.{self.method}({', '.join([str(e) for e in self.parameters])})"


@dataclass(frozen=True)
class MethodSuperLookUpRight:
    '''
    super1.right_side | method(expressions)
    '''
    content: 'Content'

    def __str__(self) -> str:
        match self.content:
            case (method, parameters):
                return f"{method}({', '.join([str(e) for e in parameters])})"
            case _:
                return "super{}." + str(self.content)


Content = tuple[str, list[Expression]] | MethodSuperLookUpRight


@dataclass(frozen=True)
class MethodSuperLookup(Expression):
    '''
    expression.right_side
    '''
    # inner_method: MethodLookup
    expression: Expression
    right_side: MethodSuperLookUpRight

    def __str__(self) -> str:
        expr = "(" + str(self.expression) + ")" if isinstance(self.expression, Cast) else str(self.expression)
        return f"{expr}.{str(self.right_side)}"


@dataclass(frozen=True)
class NewClass(Expression):
    '''
    new class_name(expressions)
    '''
    type: Type
    parameters: list[Expression]

    def __str__(self) -> str:
        return f"new {str(self.type)}({', '.join([str(e) for e in self.parameters])})"


@dataclass(frozen=True)
class Cast(Expression):
    '''
    (class_name)expression
    '''
    type: Type
    expression: Expression

    def __str__(self) -> str:
        return f"({str(self.type)}){str(self.expression)}"


FieldEnv = dict[str, Type]


VarEnv = dict[str, Type]


@dataclass(frozen=True)
class MethodDef:
    '''
    return_type methode_name(types parameters) {return expression;}
    '''
    method_name: str
    return_type: Type
    typed_parameters: VarEnv
    body: Expression

    def __str__(self) -> str:
        out = f"{str(self.return_type)} {self.method_name}("
        out += ', '.join([f'{argument_type} {argument_name}' for argument_type, argument_name in self.typed_parameters.items()])
        out += ") {\n\t\treturn " + str(self.body) + ";\n\t}"
        return out


@dataclass(frozen=True)
class ClassDef:
    '''
    class class_name extends superclass {types fields; constructor methods}
    '''
    class_name: str
    superclass: Type
    typed_fields: FieldEnv
    methods: dict[str, MethodDef]

    def __str__(self) -> str:
        """
        Without Constructor
        """
        out = f"class {self.class_name} extends {str(self.superclass)}"
        out += " {\n" + ''.join([f'\t{field_type} {field_name};\n' for field_name, field_type in self.typed_fields.items()])
        out += ''.join([f'\t{str(method_def)}\n' for method_def in self.methods.values()])
        return out + "}"

    def str_with_constructor(self, CT: 'ClassTable'):
        typed_fields_superclass = [] if isinstance(self.superclass, FJObject) else [(type, name) for type, name in CT[str(self.superclass)].typed_fields.items()]
        constructor = f"\t{self.class_name}("
        constructor += ", ".join(f"{type} {name}" for name, type in typed_fields_superclass + list(self.typed_fields.items())) + ") {"
        if typed_fields_superclass == [] and list(self.typed_fields.items()) == []:
            constructor += " super(); "
        else:
            constructor += f"\n\t\tsuper({', '.join([name for name in CT[str(self.superclass)].typed_fields.keys()]) if not isinstance(self.superclass, FJObject) else ''});\n"
            constructor += ''.join([f'\t\tthis.{name}={name};\n' for name in self.typed_fields.keys()]) + "\t"
        constructor += "}\n"

        out = f"class {self.class_name} extends {str(self.superclass)}"
        out += " {\n" + ''.join([f'\t{field_type} {field_name};\n' for field_name, field_type in self.typed_fields.items()])
        out += constructor
        out += ''.join([f'\t{str(method_def)}\n' for method_def in self.methods.values()])
        return out + "}"


ClassTable = dict[str, ClassDef]


@dataclass(frozen=True)
class Program:
    '''
    {class_name : ClassDef, ...}
    '''
    class_table: ClassTable
    expression: Expression

    def __str__(self) -> str:
        out = '\n'.join([str(class_def) for class_def in self.class_table.values()])
        return out + f"\n\n{str(self.expression)}"

    def str_with_constructor(self) -> str:
        out = '\n'.join([ClassDef.str_with_constructor(class_def, self.class_table) for class_def in self.class_table.values()])
        return out + f"\n\n{str(self.expression)}"
