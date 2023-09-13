// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library FJ_computation;

import "package:python_ffi/python_ffi.dart";

/// ## Cast
///
/// ### python docstring
///
/// (class_name)expression
///
/// ### python source
/// ```py
/// @dataclass(frozen=True)
/// class Cast(Expression):
///     '''
///     (class_name)expression
///     '''
///     type: Type
///     expression: Expression
///
///     def __str__(self) -> str:
///         return f"({str(self.type)}){str(self.expression)}"
/// ```
final class Cast extends PythonClass {
  factory Cast({
    required Type type,
    required Expression expression,
  }) =>
      PythonFfi.instance.importClass(
        "fj.FJ_computation",
        "Cast",
        Cast.from,
        <Object?>[
          type,
          expression,
        ],
        <String, Object?>{},
      );

  Cast.from(super.pythonClass) : super.from();

  /// ## type (getter)
  ///
  /// ### python docstring
  ///
  /// (class_name)expression
  Object? get type => getAttribute("type");

  /// ## type (setter)
  ///
  /// ### python docstring
  ///
  /// (class_name)expression
  set type(Object? type) => setAttribute("type", type);

  /// ## expression (getter)
  ///
  /// ### python docstring
  ///
  /// (class_name)expression
  Object? get expression => getAttribute("expression");

  /// ## expression (setter)
  ///
  /// ### python docstring
  ///
  /// (class_name)expression
  set expression(Object? expression) => setAttribute("expression", expression);
}

/// ## ClassDef
///
/// ### python docstring
///
/// class class_name extends superclass {
///     types fields;
///     constructor
///     methods
/// }
///
/// ### python source
/// ```py
/// @dataclass(frozen=True)
/// class ClassDef:
///     '''
///     class class_name extends superclass {
///         types fields;
///         constructor
///         methods
///     }
///     '''
///     class_name: str
///     superclass: Type
///     typed_fields: FieldEnv
///     methods: dict[str, MethodDef]
///
///     def __str__(self) -> str:
///         """
///         Without Constructor
///         """
///         out = f"class {self.class_name} extends {str(self.superclass)}" + " {"
///         if self.typed_fields or self.methods:
///             out += "\n"
///         out += '\n'.join(f'\t{field_type} {field_name};' for field_name, field_type in self.typed_fields.items())
///         if self.typed_fields:
///             out += "\n"
///         out += '\n'.join("\n".join(['\t' + line for line in str(method_def).split("\n")]) for method_def in self.methods.values())
///         if self.methods:
///             out += "\n"
///         return out + "}"
///
///     def str_with_constructor(self, CT: 'ClassTable'):
///         def fields(fjclass: Type, CT: ClassTable) -> dict[str, Type]:
///             match fjclass:
///                 case FJObject():
///                     return dict()
///                 case FJClass(name):
///                     return fields(CT[name].superclass, CT) | CT[name].typed_fields
///
///         typed_fields_superclass_list = list(fields(self.superclass, CT).items())
///         type_fields_list = list(fields(FJClass(self.class_name), CT).items())
///         constructor = f"{self.class_name}("
///         constructor += ", ".join(f"{type} {name}" for name, type in type_fields_list) + ") {"
///         if typed_fields_superclass_list == [] and type_fields_list == []:
///             constructor += " super(); "
///         else:
///             constructor += f"\n\tsuper({', '.join(name for (name, _) in typed_fields_superclass_list)});\n"
///             constructor += '\n'.join(f'\tthis.{name}={name};' for name in self.typed_fields.keys())
///             if self.typed_fields:
///                 constructor += '\n'
///         constructor += "}"
///
///         out = f"class {self.class_name} extends {str(self.superclass)}"
///         out += " {\n" + ''.join([f'\t{field_type} {field_name};\n' for field_name, field_type in self.typed_fields.items()])
///         out += ''.join('\t' + line + '\n' for line in constructor.split('\n'))
///         out += ''.join('\n'.join('\t' + line for line in str(method_def).split('\n')) + "\n" for method_def in self.methods.values())
///         return out + "}"
/// ```
final class ClassDef extends PythonClass {
  factory ClassDef({
    required String class_name,
    required Type superclass,
    required Map<String, Type> typed_fields,
    required Map<String, MethodDef> methods,
  }) =>
      PythonFfi.instance.importClass(
        "fj.FJ_computation",
        "ClassDef",
        ClassDef.from,
        <Object?>[
          class_name,
          superclass,
          typed_fields,
          methods,
        ],
        <String, Object?>{},
      );

  ClassDef.from(super.pythonClass) : super.from();

  /// ## str_with_constructor
  ///
  /// ### python source
  /// ```py
  /// def str_with_constructor(self, CT: 'ClassTable'):
  ///         def fields(fjclass: Type, CT: ClassTable) -> dict[str, Type]:
  ///             match fjclass:
  ///                 case FJObject():
  ///                     return dict()
  ///                 case FJClass(name):
  ///                     return fields(CT[name].superclass, CT) | CT[name].typed_fields
  ///
  ///         typed_fields_superclass_list = list(fields(self.superclass, CT).items())
  ///         type_fields_list = list(fields(FJClass(self.class_name), CT).items())
  ///         constructor = f"{self.class_name}("
  ///         constructor += ", ".join(f"{type} {name}" for name, type in type_fields_list) + ") {"
  ///         if typed_fields_superclass_list == [] and type_fields_list == []:
  ///             constructor += " super(); "
  ///         else:
  ///             constructor += f"\n\tsuper({', '.join(name for (name, _) in typed_fields_superclass_list)});\n"
  ///             constructor += '\n'.join(f'\tthis.{name}={name};' for name in self.typed_fields.keys())
  ///             if self.typed_fields:
  ///                 constructor += '\n'
  ///         constructor += "}"
  ///
  ///         out = f"class {self.class_name} extends {str(self.superclass)}"
  ///         out += " {\n" + ''.join([f'\t{field_type} {field_name};\n' for field_name, field_type in self.typed_fields.items()])
  ///         out += ''.join('\t' + line + '\n' for line in constructor.split('\n'))
  ///         out += ''.join('\n'.join('\t' + line for line in str(method_def).split('\n')) + "\n" for method_def in self.methods.values())
  ///         return out + "}"
  /// ```
  Object? str_with_constructor({
    required Object? CT,
  }) =>
      getFunction("str_with_constructor").call(
        <Object?>[
          CT,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## class_name (getter)
  ///
  /// ### python docstring
  ///
  /// class class_name extends superclass {
  ///     types fields;
  ///     constructor
  ///     methods
  /// }
  Object? get class_name => getAttribute("class_name");

  /// ## class_name (setter)
  ///
  /// ### python docstring
  ///
  /// class class_name extends superclass {
  ///     types fields;
  ///     constructor
  ///     methods
  /// }
  set class_name(Object? class_name) => setAttribute("class_name", class_name);

  /// ## superclass (getter)
  ///
  /// ### python docstring
  ///
  /// class class_name extends superclass {
  ///     types fields;
  ///     constructor
  ///     methods
  /// }
  Object? get superclass => getAttribute("superclass");

  /// ## superclass (setter)
  ///
  /// ### python docstring
  ///
  /// class class_name extends superclass {
  ///     types fields;
  ///     constructor
  ///     methods
  /// }
  set superclass(Object? superclass) => setAttribute("superclass", superclass);

  /// ## typed_fields (getter)
  ///
  /// ### python docstring
  ///
  /// class class_name extends superclass {
  ///     types fields;
  ///     constructor
  ///     methods
  /// }
  Object? get typed_fields => getAttribute("typed_fields");

  /// ## typed_fields (setter)
  ///
  /// ### python docstring
  ///
  /// class class_name extends superclass {
  ///     types fields;
  ///     constructor
  ///     methods
  /// }
  set typed_fields(Object? typed_fields) =>
      setAttribute("typed_fields", typed_fields);

  /// ## methods (getter)
  ///
  /// ### python docstring
  ///
  /// class class_name extends superclass {
  ///     types fields;
  ///     constructor
  ///     methods
  /// }
  Object? get methods => getAttribute("methods");

  /// ## methods (setter)
  ///
  /// ### python docstring
  ///
  /// class class_name extends superclass {
  ///     types fields;
  ///     constructor
  ///     methods
  /// }
  set methods(Object? methods) => setAttribute("methods", methods);
}

/// ## Expression
///
/// ### python source
/// ```py
/// class Expression:
///     pass
/// ```
final class Expression extends PythonClass {
  factory Expression() => PythonFfi.instance.importClass(
        "fj.FJ_computation",
        "Expression",
        Expression.from,
        <Object?>[],
      );

  Expression.from(super.pythonClass) : super.from();
}

/// ## FJClass
///
/// ### python docstring
///
/// FJClass(name: str)
///
/// ### python source
/// ```py
/// @dataclass(frozen=True)
/// class FJClass(Type):
///     name: str
///
///     def __str__(self) -> str:
///         return self.name
/// ```
final class FJClass extends PythonClass {
  factory FJClass({
    required String name,
  }) =>
      PythonFfi.instance.importClass(
        "fj.FJ_computation",
        "FJClass",
        FJClass.from,
        <Object?>[
          name,
        ],
        <String, Object?>{},
      );

  FJClass.from(super.pythonClass) : super.from();

  /// ## name (getter)
  ///
  /// ### python docstring
  ///
  /// FJClass(name: str)
  Object? get name => getAttribute("name");

  /// ## name (setter)
  ///
  /// ### python docstring
  ///
  /// FJClass(name: str)
  set name(Object? name) => setAttribute("name", name);
}

/// ## FJObject
///
/// ### python docstring
///
/// FJObject()
///
/// ### python source
/// ```py
/// @dataclass(frozen=True)
/// class FJObject(Type):
///
///     def __str__(self) -> str:
///         return "Object"
/// ```
final class FJObject extends PythonClass {
  factory FJObject() => PythonFfi.instance.importClass(
        "fj.FJ_computation",
        "FJObject",
        FJObject.from,
        <Object?>[],
        <String, Object?>{},
      );

  FJObject.from(super.pythonClass) : super.from();
}

/// ## FieldLookup
///
/// ### python docstring
///
/// expression.field
///
/// ### python source
/// ```py
/// @dataclass(frozen=True)
/// class FieldLookup(Expression):
///     '''
///     expression.field
///     '''
///     expression: Expression
///     field: str
///
///     def __str__(self) -> str:
///         expr = "(" + str(self.expression) + ")" if isinstance(self.expression, Cast) else str(self.expression)
///         return f"{expr}.{self.field}"
/// ```
final class FieldLookup extends PythonClass {
  factory FieldLookup({
    required Expression expression,
    required String field,
  }) =>
      PythonFfi.instance.importClass(
        "fj.FJ_computation",
        "FieldLookup",
        FieldLookup.from,
        <Object?>[
          expression,
          field,
        ],
        <String, Object?>{},
      );

  FieldLookup.from(super.pythonClass) : super.from();

  /// ## expression (getter)
  ///
  /// ### python docstring
  ///
  /// expression.field
  Object? get expression => getAttribute("expression");

  /// ## expression (setter)
  ///
  /// ### python docstring
  ///
  /// expression.field
  set expression(Object? expression) => setAttribute("expression", expression);

  /// ## field (getter)
  ///
  /// ### python docstring
  ///
  /// expression.field
  Object? get field => getAttribute("field");

  /// ## field (setter)
  ///
  /// ### python docstring
  ///
  /// expression.field
  set field(Object? field) => setAttribute("field", field);
}

/// ## MethodDef
///
/// ### python docstring
///
/// return_type methode_name(types parameters) {
///     return expression;
/// }
///
/// ### python source
/// ```py
/// @dataclass(frozen=True)
/// class MethodDef:
///     '''
///     return_type methode_name(types parameters) {
///         return expression;
///     }
///     '''
///     method_name: str
///     return_type: Type
///     typed_parameters: VarEnv
///     body: Expression
///
///     def __str__(self) -> str:
///         out = f"{str(self.return_type)} {self.method_name}("
///         out += ', '.join(f'{argument_type} {argument_name}' for argument_type, argument_name in self.typed_parameters.items())
///         out += ") {\n\treturn " + str(self.body) + ";\n}"
///         return out
/// ```
final class MethodDef extends PythonClass {
  factory MethodDef({
    required String method_name,
    required Type return_type,
    required Map<String, Type> typed_parameters,
    required Expression body,
  }) =>
      PythonFfi.instance.importClass(
        "fj.FJ_computation",
        "MethodDef",
        MethodDef.from,
        <Object?>[
          method_name,
          return_type,
          typed_parameters,
          body,
        ],
        <String, Object?>{},
      );

  MethodDef.from(super.pythonClass) : super.from();

  /// ## method_name (getter)
  ///
  /// ### python docstring
  ///
  /// return_type methode_name(types parameters) {
  ///     return expression;
  /// }
  Object? get method_name => getAttribute("method_name");

  /// ## method_name (setter)
  ///
  /// ### python docstring
  ///
  /// return_type methode_name(types parameters) {
  ///     return expression;
  /// }
  set method_name(Object? method_name) =>
      setAttribute("method_name", method_name);

  /// ## return_type (getter)
  ///
  /// ### python docstring
  ///
  /// return_type methode_name(types parameters) {
  ///     return expression;
  /// }
  Object? get return_type => getAttribute("return_type");

  /// ## return_type (setter)
  ///
  /// ### python docstring
  ///
  /// return_type methode_name(types parameters) {
  ///     return expression;
  /// }
  set return_type(Object? return_type) =>
      setAttribute("return_type", return_type);

  /// ## typed_parameters (getter)
  ///
  /// ### python docstring
  ///
  /// return_type methode_name(types parameters) {
  ///     return expression;
  /// }
  Object? get typed_parameters => getAttribute("typed_parameters");

  /// ## typed_parameters (setter)
  ///
  /// ### python docstring
  ///
  /// return_type methode_name(types parameters) {
  ///     return expression;
  /// }
  set typed_parameters(Object? typed_parameters) =>
      setAttribute("typed_parameters", typed_parameters);

  /// ## body (getter)
  ///
  /// ### python docstring
  ///
  /// return_type methode_name(types parameters) {
  ///     return expression;
  /// }
  Object? get body => getAttribute("body");

  /// ## body (setter)
  ///
  /// ### python docstring
  ///
  /// return_type methode_name(types parameters) {
  ///     return expression;
  /// }
  set body(Object? body) => setAttribute("body", body);
}

/// ## MethodLookup
///
/// ### python docstring
///
/// expression.method(expressions)
///
/// ### python source
/// ```py
/// @dataclass(frozen=True)
/// class MethodLookup(Expression):
///     '''
///     expression.method(expressions)
///     '''
///     expression: Expression
///     method: str
///     parameters: list[Expression]
///     counter_super: int = 0
///
///     def __str__(self) -> str:
///         expr = "(" + str(self.expression) + ")" if isinstance(self.expression, Cast) else str(self.expression)
///         return f"{expr}.{self.method}({', '.join(str(e) for e in self.parameters)})"
/// ```
final class MethodLookup extends PythonClass {
  factory MethodLookup({
    required Expression expression,
    required String method,
    required List<Expression> parameters,
    int counter_super = 0,
  }) =>
      PythonFfi.instance.importClass(
        "fj.FJ_computation",
        "MethodLookup",
        MethodLookup.from,
        <Object?>[
          expression,
          method,
          parameters,
          counter_super,
        ],
        <String, Object?>{},
      );

  MethodLookup.from(super.pythonClass) : super.from();

  /// ## counter_super (getter)
  ///
  /// ### python docstring
  ///
  /// expression.method(expressions)
  Object? get counter_super => getAttribute("counter_super");

  /// ## counter_super (setter)
  ///
  /// ### python docstring
  ///
  /// expression.method(expressions)
  set counter_super(Object? counter_super) =>
      setAttribute("counter_super", counter_super);

  /// ## expression (getter)
  ///
  /// ### python docstring
  ///
  /// expression.method(expressions)
  Object? get expression => getAttribute("expression");

  /// ## expression (setter)
  ///
  /// ### python docstring
  ///
  /// expression.method(expressions)
  set expression(Object? expression) => setAttribute("expression", expression);

  /// ## method (getter)
  ///
  /// ### python docstring
  ///
  /// expression.method(expressions)
  Object? get method => getAttribute("method");

  /// ## method (setter)
  ///
  /// ### python docstring
  ///
  /// expression.method(expressions)
  set method(Object? method) => setAttribute("method", method);

  /// ## parameters (getter)
  ///
  /// ### python docstring
  ///
  /// expression.method(expressions)
  Object? get parameters => getAttribute("parameters");

  /// ## parameters (setter)
  ///
  /// ### python docstring
  ///
  /// expression.method(expressions)
  set parameters(Object? parameters) => setAttribute("parameters", parameters);
}

/// ## NewClass
///
/// ### python docstring
///
/// new class_name(expressions)
///
/// ### python source
/// ```py
/// @dataclass(frozen=True)
/// class NewClass(Expression):
///     '''
///     new class_name(expressions)
///     '''
///     type: Type
///     parameters: list[Expression]
///
///     def __str__(self) -> str:
///         return f"new {str(self.type)}({', '.join(str(e) for e in self.parameters)})"
/// ```
final class NewClass extends PythonClass {
  factory NewClass({
    required Type type,
    required List<Expression> parameters,
  }) =>
      PythonFfi.instance.importClass(
        "fj.FJ_computation",
        "NewClass",
        NewClass.from,
        <Object?>[
          type,
          parameters,
        ],
        <String, Object?>{},
      );

  NewClass.from(super.pythonClass) : super.from();

  /// ## type (getter)
  ///
  /// ### python docstring
  ///
  /// new class_name(expressions)
  Object? get type => getAttribute("type");

  /// ## type (setter)
  ///
  /// ### python docstring
  ///
  /// new class_name(expressions)
  set type(Object? type) => setAttribute("type", type);

  /// ## parameters (getter)
  ///
  /// ### python docstring
  ///
  /// new class_name(expressions)
  Object? get parameters => getAttribute("parameters");

  /// ## parameters (setter)
  ///
  /// ### python docstring
  ///
  /// new class_name(expressions)
  set parameters(Object? parameters) => setAttribute("parameters", parameters);
}

/// ## Program
///
/// ### python docstring
///
/// {class_name : ClassDef, ...}
///
/// ### python source
/// ```py
/// @dataclass(frozen=True)
/// class Program:
///     '''
///     {class_name : ClassDef, ...}
///     '''
///     class_table: ClassTable
///     expression: Expression
///
///     def __str__(self) -> str:
///         out = '\n\n'.join([str(class_def) for class_def in self.class_table.values()])
///         return out + f"\n\n{str(self.expression)}"
///
///     def str_with_constructor(self) -> str:
///         out = '\n\n'.join([ClassDef.str_with_constructor(class_def, self.class_table) for class_def in self.class_table.values()])
///         return out + f"\n\n{str(self.expression)}"
/// ```
final class Program extends PythonClass {
  factory Program({
    required Map<String, ClassDef> class_table,
    required Expression expression,
  }) =>
      PythonFfi.instance.importClass(
        "fj.FJ_computation",
        "Program",
        Program.from,
        <Object?>[
          class_table,
          expression,
        ],
        <String, Object?>{},
      );

  Program.from(super.pythonClass) : super.from();

  /// ## str_with_constructor
  ///
  /// ### python source
  /// ```py
  /// def str_with_constructor(self) -> str:
  ///         out = '\n\n'.join([ClassDef.str_with_constructor(class_def, self.class_table) for class_def in self.class_table.values()])
  ///         return out + f"\n\n{str(self.expression)}"
  /// ```
  String str_with_constructor() => getFunction("str_with_constructor").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## class_table (getter)
  ///
  /// ### python docstring
  ///
  /// {class_name : ClassDef, ...}
  Object? get class_table => getAttribute("class_table");

  /// ## class_table (setter)
  ///
  /// ### python docstring
  ///
  /// {class_name : ClassDef, ...}
  set class_table(Object? class_table) =>
      setAttribute("class_table", class_table);

  /// ## expression (getter)
  ///
  /// ### python docstring
  ///
  /// {class_name : ClassDef, ...}
  Object? get expression => getAttribute("expression");

  /// ## expression (setter)
  ///
  /// ### python docstring
  ///
  /// {class_name : ClassDef, ...}
  set expression(Object? expression) => setAttribute("expression", expression);
}

/// ## Type
///
/// ### python source
/// ```py
/// class Type:
///     pass
/// ```
final class Type extends PythonClass {
  factory Type() => PythonFfi.instance.importClass(
        "fj.FJ_computation",
        "Type",
        Type.from,
        <Object?>[],
      );

  Type.from(super.pythonClass) : super.from();
}

/// ## Variable
///
/// ### python docstring
///
/// variable
///
/// ### python source
/// ```py
/// @dataclass(frozen=True)
/// class Variable(Expression):
///     '''
///     variable
///     '''
///     name: str
///
///     def __str__(self) -> str:
///         return self.name
/// ```
final class Variable extends PythonClass {
  factory Variable({
    required String name,
  }) =>
      PythonFfi.instance.importClass(
        "fj.FJ_computation",
        "Variable",
        Variable.from,
        <Object?>[
          name,
        ],
        <String, Object?>{},
      );

  Variable.from(super.pythonClass) : super.from();

  /// ## name (getter)
  ///
  /// ### python docstring
  ///
  /// variable
  Object? get name => getAttribute("name");

  /// ## name (setter)
  ///
  /// ### python docstring
  ///
  /// variable
  set name(Object? name) => setAttribute("name", name);
}

/// ## FJ_computation
///
/// ### python source
/// ```py
/// import FJ_AST as FJ
/// from FJ_auxiliary_typing import fields, mbody, is_subtype
///
///
/// def compute_expression(outer_expression: FJ.Expression, CT: dict[str, FJ.ClassDef]) -> FJ.Expression:
///     match outer_expression:
///         case FJ.NewClass() | FJ.Variable():
///             return outer_expression
///
///         case FJ.FieldLookup(expression, field):
///             if type(expression) is not FJ.NewClass:
///                 raise Exception(f"BECAUSE CONGRUENCE RULES -> CANT GO HERE BUT PYTHON STILL NEEDS THIS CHECK FOR TYPINFERENCE - Expected expression of Type NewClass, got {type(expression)}")
///             field_names = fields(expression.type, CT).keys()
///             if field not in field_names:
///                 raise Exception(f"IF WELL TYPED -> CANT GO HERE - Class {str(expression.type)} has no field {field}")
///             else:
///                 # only works when the keys of the dictionary have the same orde as the list of parameters
///                 return expression.parameters[list(field_names).index(field)]
///
///         case FJ.MethodLookup(expression, method_name, expressions, super_counter):
///             if type(expression) is not FJ.NewClass:
///                 raise Exception(f"BECAUSE CONGRUENCE RULES -> CANT GO HERE BUT PYTHON STILL NEEDS THIS CHECK FOR TYPINFERENCE - Expected expression of Type NewClass, got {type(expression)}")
///             # x.e
///             mbody_variables, mbody_expression = mbody(method_name, expression.type, CT, super_counter)
///             # expressions == arguments (replacing x) | expression == newClass (replacing this)
///             # mbody_expression == e0 | mbody_variables == x
///             expr = replace_things(mbody_expression, expressions, mbody_variables, expression, CT, super_counter)
///             return congruence_expression(expr, CT)
///
///         case FJ.Cast(type_of_class, expression):
///             if type(expression) is not FJ.NewClass:
///                 raise Exception(f"BECAUSE CONGRUENCE RULES -> CANT GO HERE BUT PYTHON STILL NEEDS THIS CHECK FOR TYPINFERENCE - Expected expression of Type NewClass, got {type(expression)}")
///             if is_subtype(expression.type, type_of_class, CT):  # UpCast
///                 return expression
///             elif is_subtype(type_of_class, expression.type, CT):  # DownCast
///                 raise Exception(f"DownCast are not allowed - '{str(type_of_class)}' is a subtype of '{str(expression.type)}'")
///             else:  # StupidCast
///                 raise Exception(f"Stupid Casts are not allowed - '{str(expression.type)}' is not a subtype of '{str(type_of_class)}' and vice versa")
///
///
/// def replace_things(e0: FJ.Expression, arguments: list[FJ.Expression], xs: list[str], newClass: FJ.Expression, CT: dict[str, FJ.ClassDef], super_counter: int) -> FJ.Expression:
///     match e0:
///         case FJ.Variable(name):
///             if name == "this" or name == "super":
///                 return newClass
///             elif name not in xs:
///                 raise Exception(f"IF WELL TYPED -> CANT GO HERE - Variable {name} not found in scope")
///             else:
///                 return arguments[xs.index(name)]
///
///         case FJ.FieldLookup(expression, field):
///             new_expression = replace_things(expression, arguments, xs, newClass, CT, super_counter)
///             return FJ.FieldLookup(new_expression, field)
///
///         case FJ.MethodLookup(expression, method_name, expressions):
///             match expression:
///                 case FJ.Variable("super"):
///                     new_super_counter = super_counter + 1
///                 case FJ.Variable("this"):
///                     new_super_counter = 0
///             new_expression = replace_things(expression, arguments, xs, newClass, CT, super_counter)
///             new_expressions = [replace_things(e, arguments, xs, newClass, CT, super_counter) for e in expressions]
///             return FJ.MethodLookup(new_expression, method_name, new_expressions, new_super_counter)
///
///         case FJ.NewClass(type_of, expressions):
///             new_expressions = [replace_things(inner_expression, arguments, xs, newClass, CT, super_counter) for inner_expression in expressions]
///             return FJ.NewClass(type_of, new_expressions)
///
///         case FJ.Cast(type_of, expression):
///             new_expression = replace_things(expression, arguments, xs, newClass, CT, super_counter)
///             return FJ.Cast(type_of, new_expression)
///
///
/// def congruence_expression(expression: FJ.Expression, CT: dict[str, FJ.ClassDef]) -> FJ.Expression:
///     match expression:
///         case FJ.FieldLookup(inner_expression, inner_field):
///             new_expression = congruence_expression(inner_expression, CT)
///             return compute_expression(FJ.FieldLookup(new_expression, inner_field), CT)
///
///         case FJ.MethodLookup(inner_expression, inner_method_name, inner_expressions, sp):
///             new_expression = congruence_expression(inner_expression, CT)
///             new_expressions = [congruence_expression(single_expression, CT) for single_expression in inner_expressions]
///             return compute_expression(FJ.MethodLookup(new_expression, inner_method_name, new_expressions, sp), CT)
///
///         case FJ.NewClass(inner_type, inner_parameters):
///             new_parameters = [congruence_expression(parameter, CT) for parameter in inner_parameters]
///             return FJ.NewClass(inner_type, new_parameters)
///
///         case FJ.Cast(inner_type, inner_expression):
///             new_expression = congruence_expression(inner_expression, CT)
///             return compute_expression(FJ.Cast(inner_type, new_expression), CT)
///
///
/// def compute_program(program: FJ.Program) -> FJ.NewClass:
///     """
///     Takes a well parsed program and computes it.\n
///     If the program isnt well typed it may get stuck here.
///     """
///     congruenced_expression = congruence_expression(program.expression, program.class_table)
///     return congruenced_expression
/// ```
final class FJ_computation extends PythonModule {
  FJ_computation.from(super.pythonModule) : super.from();

  static FJ_computation import() => PythonFfi.instance.importModule(
        "fj.FJ_computation",
        FJ_computation.from,
      );

  /// ## compute_expression
  ///
  /// ### python source
  /// ```py
  /// def compute_expression(outer_expression: FJ.Expression, CT: dict[str, FJ.ClassDef]) -> FJ.Expression:
  ///     match outer_expression:
  ///         case FJ.NewClass() | FJ.Variable():
  ///             return outer_expression
  ///
  ///         case FJ.FieldLookup(expression, field):
  ///             if type(expression) is not FJ.NewClass:
  ///                 raise Exception(f"BECAUSE CONGRUENCE RULES -> CANT GO HERE BUT PYTHON STILL NEEDS THIS CHECK FOR TYPINFERENCE - Expected expression of Type NewClass, got {type(expression)}")
  ///             field_names = fields(expression.type, CT).keys()
  ///             if field not in field_names:
  ///                 raise Exception(f"IF WELL TYPED -> CANT GO HERE - Class {str(expression.type)} has no field {field}")
  ///             else:
  ///                 # only works when the keys of the dictionary have the same orde as the list of parameters
  ///                 return expression.parameters[list(field_names).index(field)]
  ///
  ///         case FJ.MethodLookup(expression, method_name, expressions, super_counter):
  ///             if type(expression) is not FJ.NewClass:
  ///                 raise Exception(f"BECAUSE CONGRUENCE RULES -> CANT GO HERE BUT PYTHON STILL NEEDS THIS CHECK FOR TYPINFERENCE - Expected expression of Type NewClass, got {type(expression)}")
  ///             # x.e
  ///             mbody_variables, mbody_expression = mbody(method_name, expression.type, CT, super_counter)
  ///             # expressions == arguments (replacing x) | expression == newClass (replacing this)
  ///             # mbody_expression == e0 | mbody_variables == x
  ///             expr = replace_things(mbody_expression, expressions, mbody_variables, expression, CT, super_counter)
  ///             return congruence_expression(expr, CT)
  ///
  ///         case FJ.Cast(type_of_class, expression):
  ///             if type(expression) is not FJ.NewClass:
  ///                 raise Exception(f"BECAUSE CONGRUENCE RULES -> CANT GO HERE BUT PYTHON STILL NEEDS THIS CHECK FOR TYPINFERENCE - Expected expression of Type NewClass, got {type(expression)}")
  ///             if is_subtype(expression.type, type_of_class, CT):  # UpCast
  ///                 return expression
  ///             elif is_subtype(type_of_class, expression.type, CT):  # DownCast
  ///                 raise Exception(f"DownCast are not allowed - '{str(type_of_class)}' is a subtype of '{str(expression.type)}'")
  ///             else:  # StupidCast
  ///                 raise Exception(f"Stupid Casts are not allowed - '{str(expression.type)}' is not a subtype of '{str(type_of_class)}' and vice versa")
  /// ```
  Expression compute_expression({
    required Expression outer_expression,
    required Map<String, ClassDef> CT,
  }) =>
      Expression.from(
        getFunction("compute_expression").call(
          <Object?>[
            outer_expression,
            CT,
          ],
          kwargs: <String, Object?>{},
        ),
      );

  /// ## compute_program
  ///
  /// ### python docstring
  ///
  /// Takes a well parsed program and computes it.
  ///
  /// If the program isnt well typed it may get stuck here.
  ///
  /// ### python source
  /// ```py
  /// def compute_program(program: FJ.Program) -> FJ.NewClass:
  ///     """
  ///     Takes a well parsed program and computes it.\n
  ///     If the program isnt well typed it may get stuck here.
  ///     """
  ///     congruenced_expression = congruence_expression(program.expression, program.class_table)
  ///     return congruenced_expression
  /// ```
  NewClass compute_program({
    required Program program,
  }) =>
      NewClass.from(
        getFunction("compute_program").call(
          <Object?>[
            program,
          ],
          kwargs: <String, Object?>{},
        ),
      );

  /// ## congruence_expression
  ///
  /// ### python source
  /// ```py
  /// def congruence_expression(expression: FJ.Expression, CT: dict[str, FJ.ClassDef]) -> FJ.Expression:
  ///     match expression:
  ///         case FJ.FieldLookup(inner_expression, inner_field):
  ///             new_expression = congruence_expression(inner_expression, CT)
  ///             return compute_expression(FJ.FieldLookup(new_expression, inner_field), CT)
  ///
  ///         case FJ.MethodLookup(inner_expression, inner_method_name, inner_expressions, sp):
  ///             new_expression = congruence_expression(inner_expression, CT)
  ///             new_expressions = [congruence_expression(single_expression, CT) for single_expression in inner_expressions]
  ///             return compute_expression(FJ.MethodLookup(new_expression, inner_method_name, new_expressions, sp), CT)
  ///
  ///         case FJ.NewClass(inner_type, inner_parameters):
  ///             new_parameters = [congruence_expression(parameter, CT) for parameter in inner_parameters]
  ///             return FJ.NewClass(inner_type, new_parameters)
  ///
  ///         case FJ.Cast(inner_type, inner_expression):
  ///             new_expression = congruence_expression(inner_expression, CT)
  ///             return compute_expression(FJ.Cast(inner_type, new_expression), CT)
  /// ```
  Expression congruence_expression({
    required Expression expression,
    required Map<String, ClassDef> CT,
  }) =>
      Expression.from(
        getFunction("congruence_expression").call(
          <Object?>[
            expression,
            CT,
          ],
          kwargs: <String, Object?>{},
        ),
      );

  /// ## fields
  ///
  /// ### python docstring
  ///
  /// fields(C, CT) == {field_of_C : Typ, ...}
  ///
  /// ### python source
  /// ```py
  /// def fields(fjclass: FJ.Type, CT: FJ.ClassTable) -> dict[str, FJ.Type]:
  ///     """
  ///     fields(C, CT) == {field_of_C : Typ, ...}
  ///     """
  ///     match fjclass:
  ///         case FJ.FJObject():
  ///             return dict()
  ///         case FJ.FJClass(name):
  ///             return merge_dicts(CT[name].typed_fields, fields(CT[name].superclass, CT))
  ///         case _:
  ///             raise Exception(f"{str(fjclass)} is neither FJObject nor FJClass")
  /// ```
  Map<String, Type> fields({
    required Type fjclass,
    required Map<String, ClassDef> CT,
  }) =>
      Map<String, Type>.from(
        Map.from(
          getFunction("fields").call(
            <Object?>[
              fjclass,
              CT,
            ],
            kwargs: <String, Object?>{},
          ),
        ).map(
          (k, v) => MapEntry(
            k,
            Type.from(
              v,
            ),
          ),
        ),
      );

  /// ## is_subtype
  ///
  /// ### python docstring
  ///
  /// True if C <: D
  ///
  /// ### python source
  /// ```py
  /// def is_subtype(c: FJ.Type, d: FJ.Type, CT: FJ.ClassTable) -> bool:
  ///     """
  ///     True if C <: D
  ///     """
  ///     match (c, d):
  ///         case _, FJ.FJObject():
  ///             return True
  ///         case FJ.FJObject(), _:
  ///             return False
  ///         case FJ.FJClass(name_of_c), FJ.FJClass(name_of_d) if name_of_c == name_of_d:
  ///             return True
  ///         case FJ.FJClass(name_of_c), _:
  ///             return is_subtype(CT[name_of_c].superclass, d, CT)
  /// ```
  bool is_subtype({
    required Type c,
    required Type d,
    required Map<String, ClassDef> CT,
  }) =>
      getFunction("is_subtype").call(
        <Object?>[
          c,
          d,
          CT,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## mbody
  ///
  /// ### python docstring
  ///
  /// mbody(m, C, CT) == ([parameters, ...], expression)
  ///
  /// ### python source
  /// ```py
  /// def mbody(method_name: str, fjclass: FJ.Type, CT: FJ.ClassTable, super_counter: int = 0) -> tuple[list[str], FJ.Expression]:
  ///     """
  ///     mbody(m, C, CT) == ([parameters, ...], expression)
  ///     """
  ///     match fjclass:
  ///         case FJ.FJClass(name) if method_name in CT[name].methods.keys() and super_counter <= 0:
  ///             return list(CT[name].methods[method_name].typed_parameters.keys()), CT[name].methods[method_name].body
  ///         case FJ.FJClass(name):
  ///             return mbody(method_name, CT[name].superclass, CT, super_counter - 1)
  /// ```
  List<Object?> mbody({
    required String method_name,
    required Type fjclass,
    required Map<String, ClassDef> CT,
    int super_counter = 0,
  }) =>
      List.from(
        getFunction("mbody").call(
          <Object?>[
            method_name,
            fjclass,
            CT,
            super_counter,
          ],
          kwargs: <String, Object?>{},
        ),
      );

  /// ## replace_things
  ///
  /// ### python source
  /// ```py
  /// def replace_things(e0: FJ.Expression, arguments: list[FJ.Expression], xs: list[str], newClass: FJ.Expression, CT: dict[str, FJ.ClassDef], super_counter: int) -> FJ.Expression:
  ///     match e0:
  ///         case FJ.Variable(name):
  ///             if name == "this" or name == "super":
  ///                 return newClass
  ///             elif name not in xs:
  ///                 raise Exception(f"IF WELL TYPED -> CANT GO HERE - Variable {name} not found in scope")
  ///             else:
  ///                 return arguments[xs.index(name)]
  ///
  ///         case FJ.FieldLookup(expression, field):
  ///             new_expression = replace_things(expression, arguments, xs, newClass, CT, super_counter)
  ///             return FJ.FieldLookup(new_expression, field)
  ///
  ///         case FJ.MethodLookup(expression, method_name, expressions):
  ///             match expression:
  ///                 case FJ.Variable("super"):
  ///                     new_super_counter = super_counter + 1
  ///                 case FJ.Variable("this"):
  ///                     new_super_counter = 0
  ///             new_expression = replace_things(expression, arguments, xs, newClass, CT, super_counter)
  ///             new_expressions = [replace_things(e, arguments, xs, newClass, CT, super_counter) for e in expressions]
  ///             return FJ.MethodLookup(new_expression, method_name, new_expressions, new_super_counter)
  ///
  ///         case FJ.NewClass(type_of, expressions):
  ///             new_expressions = [replace_things(inner_expression, arguments, xs, newClass, CT, super_counter) for inner_expression in expressions]
  ///             return FJ.NewClass(type_of, new_expressions)
  ///
  ///         case FJ.Cast(type_of, expression):
  ///             new_expression = replace_things(expression, arguments, xs, newClass, CT, super_counter)
  ///             return FJ.Cast(type_of, new_expression)
  /// ```
  Expression replace_things({
    required Expression e0,
    required List<Expression> arguments,
    required List<String> xs,
    required Expression newClass,
    required Map<String, ClassDef> CT,
    required int super_counter,
  }) =>
      Expression.from(
        getFunction("replace_things").call(
          <Object?>[
            e0,
            arguments,
            xs,
            newClass,
            CT,
            super_counter,
          ],
          kwargs: <String, Object?>{},
        ),
      );

  /// ## FJ
  FJ get $FJ => FJ.import();
}

/// ## FJ
///
/// ### python source
/// ```py
/// from dataclasses import dataclass
///
///
/// class Type:
///     pass
///
///
/// @dataclass(frozen=True)
/// class FJObject(Type):
///
///     def __str__(self) -> str:
///         return "Object"
///
///
/// @dataclass(frozen=True)
/// class FJClass(Type):
///     name: str
///
///     def __str__(self) -> str:
///         return self.name
///
///
/// class Expression:
///     pass
///
///
/// @dataclass(frozen=True)
/// class Variable(Expression):
///     '''
///     variable
///     '''
///     name: str
///
///     def __str__(self) -> str:
///         return self.name
///
///
/// @dataclass(frozen=True)
/// class FieldLookup(Expression):
///     '''
///     expression.field
///     '''
///     expression: Expression
///     field: str
///
///     def __str__(self) -> str:
///         expr = "(" + str(self.expression) + ")" if isinstance(self.expression, Cast) else str(self.expression)
///         return f"{expr}.{self.field}"
///
///
/// @dataclass(frozen=True)
/// class MethodLookup(Expression):
///     '''
///     expression.method(expressions)
///     '''
///     expression: Expression
///     method: str
///     parameters: list[Expression]
///     counter_super: int = 0
///
///     def __str__(self) -> str:
///         expr = "(" + str(self.expression) + ")" if isinstance(self.expression, Cast) else str(self.expression)
///         return f"{expr}.{self.method}({', '.join(str(e) for e in self.parameters)})"
///
///
/// @dataclass(frozen=True)
/// class NewClass(Expression):
///     '''
///     new class_name(expressions)
///     '''
///     type: Type
///     parameters: list[Expression]
///
///     def __str__(self) -> str:
///         return f"new {str(self.type)}({', '.join(str(e) for e in self.parameters)})"
///
///
/// @dataclass(frozen=True)
/// class Cast(Expression):
///     '''
///     (class_name)expression
///     '''
///     type: Type
///     expression: Expression
///
///     def __str__(self) -> str:
///         return f"({str(self.type)}){str(self.expression)}"
///
///
/// FieldEnv = dict[str, Type]
///
///
/// VarEnv = dict[str, Type]
///
///
/// @dataclass(frozen=True)
/// class MethodDef:
///     '''
///     return_type methode_name(types parameters) {
///         return expression;
///     }
///     '''
///     method_name: str
///     return_type: Type
///     typed_parameters: VarEnv
///     body: Expression
///
///     def __str__(self) -> str:
///         out = f"{str(self.return_type)} {self.method_name}("
///         out += ', '.join(f'{argument_type} {argument_name}' for argument_type, argument_name in self.typed_parameters.items())
///         out += ") {\n\treturn " + str(self.body) + ";\n}"
///         return out
///
///
/// @dataclass(frozen=True)
/// class ClassDef:
///     '''
///     class class_name extends superclass {
///         types fields;
///         constructor
///         methods
///     }
///     '''
///     class_name: str
///     superclass: Type
///     typed_fields: FieldEnv
///     methods: dict[str, MethodDef]
///
///     def __str__(self) -> str:
///         """
///         Without Constructor
///         """
///         out = f"class {self.class_name} extends {str(self.superclass)}" + " {"
///         if self.typed_fields or self.methods:
///             out += "\n"
///         out += '\n'.join(f'\t{field_type} {field_name};' for field_name, field_type in self.typed_fields.items())
///         if self.typed_fields:
///             out += "\n"
///         out += '\n'.join("\n".join(['\t' + line for line in str(method_def).split("\n")]) for method_def in self.methods.values())
///         if self.methods:
///             out += "\n"
///         return out + "}"
///
///     def str_with_constructor(self, CT: 'ClassTable'):
///         def fields(fjclass: Type, CT: ClassTable) -> dict[str, Type]:
///             match fjclass:
///                 case FJObject():
///                     return dict()
///                 case FJClass(name):
///                     return fields(CT[name].superclass, CT) | CT[name].typed_fields
///
///         typed_fields_superclass_list = list(fields(self.superclass, CT).items())
///         type_fields_list = list(fields(FJClass(self.class_name), CT).items())
///         constructor = f"{self.class_name}("
///         constructor += ", ".join(f"{type} {name}" for name, type in type_fields_list) + ") {"
///         if typed_fields_superclass_list == [] and type_fields_list == []:
///             constructor += " super(); "
///         else:
///             constructor += f"\n\tsuper({', '.join(name for (name, _) in typed_fields_superclass_list)});\n"
///             constructor += '\n'.join(f'\tthis.{name}={name};' for name in self.typed_fields.keys())
///             if self.typed_fields:
///                 constructor += '\n'
///         constructor += "}"
///
///         out = f"class {self.class_name} extends {str(self.superclass)}"
///         out += " {\n" + ''.join([f'\t{field_type} {field_name};\n' for field_name, field_type in self.typed_fields.items()])
///         out += ''.join('\t' + line + '\n' for line in constructor.split('\n'))
///         out += ''.join('\n'.join('\t' + line for line in str(method_def).split('\n')) + "\n" for method_def in self.methods.values())
///         return out + "}"
///
///
/// ClassTable = dict[str, ClassDef]
///
///
/// @dataclass(frozen=True)
/// class Program:
///     '''
///     {class_name : ClassDef, ...}
///     '''
///     class_table: ClassTable
///     expression: Expression
///
///     def __str__(self) -> str:
///         out = '\n\n'.join([str(class_def) for class_def in self.class_table.values()])
///         return out + f"\n\n{str(self.expression)}"
///
///     def str_with_constructor(self) -> str:
///         out = '\n\n'.join([ClassDef.str_with_constructor(class_def, self.class_table) for class_def in self.class_table.values()])
///         return out + f"\n\n{str(self.expression)}"
/// ```
final class FJ extends PythonModule {
  FJ.from(super.pythonModule) : super.from();

  static FJ import() => PythonFfi.instance.importModule(
        "fj.FJ_AST",
        FJ.from,
      );
}
