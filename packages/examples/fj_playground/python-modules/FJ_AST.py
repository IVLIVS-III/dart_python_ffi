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


@dataclass(frozen=True)
class MethodLookup(Expression):
    '''
    expression.method(expressions)
    '''
    expression: Expression
    method: str
    parameters: list[Expression]
    counter_super: int = 0

    def __str__(self) -> str:
        expr = "(" + str(self.expression) + ")" if isinstance(self.expression, Cast) else str(self.expression)
        return f"{expr}.{self.method}({', '.join(str(e) for e in self.parameters)})"


@dataclass(frozen=True)
class NewClass(Expression):
    '''
    new class_name(expressions)
    '''
    type: Type
    parameters: list[Expression]

    def __str__(self) -> str:
        return f"new {str(self.type)}({', '.join(str(e) for e in self.parameters)})"


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
    return_type methode_name(types parameters) {
        return expression;
    }
    '''
    method_name: str
    return_type: Type
    typed_parameters: VarEnv
    body: Expression

    def __str__(self) -> str:
        out = f"{str(self.return_type)} {self.method_name}("
        out += ', '.join(f'{argument_type} {argument_name}' for argument_type, argument_name in self.typed_parameters.items())
        out += ") {\n\treturn " + str(self.body) + ";\n}"
        return out


@dataclass(frozen=True)
class ClassDef:
    '''
    class class_name extends superclass {
        types fields;
        constructor
        methods
    }
    '''
    class_name: str
    superclass: Type
    typed_fields: FieldEnv
    methods: dict[str, MethodDef]

    def __str__(self) -> str:
        """
        Without Constructor
        """
        out = f"class {self.class_name} extends {str(self.superclass)}" + " {"
        if self.typed_fields or self.methods:
            out += "\n"
        out += '\n'.join(f'\t{field_type} {field_name};' for field_name, field_type in self.typed_fields.items())
        if self.typed_fields:
            out += "\n"
        out += '\n'.join("\n".join(['\t' + line for line in str(method_def).split("\n")]) for method_def in self.methods.values())
        if self.methods:
            out += "\n"
        return out + "}"

    def str_with_constructor(self, CT: 'ClassTable'):
        def fields(fjclass: Type, CT: ClassTable) -> dict[str, Type]:
            match fjclass:
                case FJObject():
                    return dict()
                case FJClass(name):
                    return fields(CT[name].superclass, CT) | CT[name].typed_fields

        typed_fields_superclass_list = list(fields(self.superclass, CT).items())
        type_fields_list = list(fields(FJClass(self.class_name), CT).items())
        constructor = f"{self.class_name}("
        constructor += ", ".join(f"{type} {name}" for name, type in type_fields_list) + ") {"
        if typed_fields_superclass_list == [] and type_fields_list == []:
            constructor += " super(); "
        else:
            constructor += f"\n\tsuper({', '.join(name for (name, _) in typed_fields_superclass_list)});\n"
            constructor += '\n'.join(f'\tthis.{name}={name};' for name in self.typed_fields.keys())
            if self.typed_fields:
                constructor += '\n'
        constructor += "}"

        out = f"class {self.class_name} extends {str(self.superclass)}"
        out += " {\n" + ''.join([f'\t{field_type} {field_name};\n' for field_name, field_type in self.typed_fields.items()])
        out += ''.join('\t' + line + '\n' for line in constructor.split('\n'))
        out += ''.join('\n'.join('\t' + line for line in str(method_def).split('\n')) + "\n" for method_def in self.methods.values())
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
        out = '\n\n'.join([str(class_def) for class_def in self.class_table.values()])
        return out + f"\n\n{str(self.expression)}"

    def str_with_constructor(self) -> str:
        out = '\n\n'.join([ClassDef.str_with_constructor(class_def, self.class_table) for class_def in self.class_table.values()])
        return out + f"\n\n{str(self.expression)}"
