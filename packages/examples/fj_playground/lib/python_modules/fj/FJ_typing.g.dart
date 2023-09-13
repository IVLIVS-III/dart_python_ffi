// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library FJ_typing;

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
        "fj.FJ_typing",
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
        "fj.FJ_typing",
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
        "fj.FJ_typing",
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
        "fj.FJ_typing",
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
        "fj.FJ_typing",
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
        "fj.FJ_typing",
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
        "fj.FJ_typing",
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
        "fj.FJ_typing",
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
        "fj.FJ_typing",
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
        "fj.FJ_typing",
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
        "fj.FJ_typing",
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
        "fj.FJ_typing",
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

/// ## StupidWarning
///
/// ### python source
/// ```py
/// class StupidWarning(Warning):
///     def __init__(self, message):
///         if type(message) is not str:
///             raise Exception("Warning messages must be a String")
///         self.__message: str = message
///
///     @property
///     def message(self):
///         return self.__message
///
///     def __str__(self):
///         return self.message
/// ```
final class StupidWarning extends PythonClass {
  factory StupidWarning({
    required Object? message,
  }) =>
      PythonFfi.instance.importClass(
        "fj.FJ_typing",
        "StupidWarning",
        StupidWarning.from,
        <Object?>[
          message,
        ],
        <String, Object?>{},
      );

  StupidWarning.from(super.pythonClass) : super.from();

  /// ## args (getter)
  Object? get args => getAttribute("args");

  /// ## args (setter)
  set args(Object? args) => setAttribute("args", args);

  /// ## message (getter)
  Object? get message => getAttribute("message");

  /// ## message (setter)
  set message(Object? message) => setAttribute("message", message);

  /// ## add_note (getter)
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## FJ_typing
///
/// ### python source
/// ```py
/// import FJ_AST as FJ
/// from FJ_auxiliary_typing import fields, mtype, is_subtype, StupidWarning
/// import warnings as warnings_
///
///
/// def typecheck_expression(expression: FJ.Expression, env: dict[str, FJ.Type], CT: dict[str, FJ.ClassDef], warnings: list[StupidWarning], error_prefix: str) -> FJ.Type:
///     match expression:
///         case FJ.Variable(name):
///             # check if variable is valid
///             if name not in env:
///                 if name == "super":
///                     raise Exception(f"\n{error_prefix} call to 'super' is not possible, because the superclass is 'Object'")
///                 raise Exception(f"\n{error_prefix} no variable '{name}' was found in scope")
///             return env[name]
///
///         case FJ.FieldLookup(expression, field):
///             # recursively getting type of the expression
///             type_of_expression = typecheck_expression(expression, env, CT, warnings, f"{error_prefix} in the expression of fieldlookup '{field}'")
///             # lookup all fields of the 'expression'
///             fields_of_expression = fields(type_of_expression, CT)
///             # check if the fieldlookup is valid
///             if field not in fields_of_expression:
///                 raise Exception(f"\n{error_prefix} the fieldlookup failed - class '{str(type_of_expression)}' has no field '{field}'")
///             # return the type of the field according to the fieldlookup
///             return fields_of_expression[field]
///
///         case FJ.MethodLookup(expression, method_name, parameters):
///             # recursively getting type of the expression
///             type_of_expression = typecheck_expression(expression, env, CT, warnings, f"{error_prefix} in the expression of the methodlookup '{method_name}'")
///             # checks if the method exists
///             match type_of_expression:
///                 case FJ.FJObject():
///                     raise Exception(f"\n{error_prefix} class 'Object' has no method '{method_name}'")
///                 case FJ.FJClass(name) if method_name not in CT[name].methods:
///                     raise Exception(f"\n{error_prefix} class '{name}' has no method '{method_name}'")
///             # getting mtype of method method_name
///             type_of_arguments_of_method, type_of_returnvalue_of_method = mtype(method_name, type_of_expression, CT)
///             # recursively checking the types of all parameters
///             type_of_parameters = [typecheck_expression(parameter, env, CT, warnings, f"{error_prefix} in the parameters of the methodlookup '{method_name}'") for parameter in parameters]
///             if len(type_of_arguments_of_method) != len(type_of_parameters):
///                 raise Exception(f"\n{error_prefix} wrong numbers of arguments")
///             # checking if the found types of the parameters match to the typedeclaration of the method (by beeing subtypes of them)
///             if all([is_subtype(class_C, class_D, CT) for class_C, class_D in zip(type_of_parameters, type_of_arguments_of_method)]):
///                 return type_of_returnvalue_of_method
///             else:
///                 raise Exception(f"\n{error_prefix} arguments of types '{', '.join(map(str, type_of_parameters))}' were given while arguments of subtypes of '{', '.join(map(str, type_of_arguments_of_method))}' were expected")
///
///         case FJ.NewClass(type, parameters):
///             # lookup all fields of the class 'type' (new 'type'(...))
///             fields_of_class = fields(type, CT)
///             # check if the number of parameters equals the number of fields
///             if len(parameters) != len(fields_of_class):
///                 raise Exception(f"\n{error_prefix} in 'new {str(type)}' {len(fields_of_class)} arguments were expected but {len(parameters)} were given")
///             # recursively checking the types of all parameters
///             types_of_parameters = [typecheck_expression(expression, env, CT, warnings, f"{error_prefix} in the parameters of 'new {str(type)}'") for expression in parameters]
///             # checking if the found types of the fields match the typedeclaration of the class (by beeing subtypes of them)
///             if all([is_subtype(class_C, class_D, CT) for class_C, class_D in zip(types_of_parameters, fields_of_class.values())]):
///                 return type
///             else:
///                 raise Exception(f"\n{error_prefix} in 'new {str(type)}' arguments of types '{', '.join(map(str, types_of_parameters))}' were given while arguments or subtypes of '{', '.join(map(str, fields_of_class.values()))}' were expected")
///
///         case FJ.Cast(type, expression):
///             type_of_expression = typecheck_expression(expression, env, CT, warnings, f"{error_prefix} in the Cast '({str(type)})'")
///             if is_subtype(type_of_expression, type, CT):  # UpCast
///                 return type
///             elif is_subtype(type, type_of_expression, CT):  # DownCast
///                 return type
///             else:  # stupid cast
///                 warnings.append(StupidWarning(f"\n{error_prefix} the cast between '{str(type)}' and '{str(type_of_expression)}' is stupid"))
///                 return type
///
///
/// def typecheck_method(method: FJ.MethodDef, class_name: str, env: dict[str, FJ.Type], CT: dict[str, FJ.ClassDef], warnings: list[StupidWarning], errors: list[str]) -> bool:
///     is_okey = True
///     intern_env = env.copy()
///     for argument, type_of_argument in method.typed_parameters.items():
///         if argument == "this" or argument == "super":
///             errors.append(f"In class '{class_name}' in method '{method.method_name}' arguments are not allowed to be named '{argument}'")
///             is_okey = False
///         intern_env[argument] = type_of_argument
///     intern_env["this"] = FJ.FJClass(class_name)
///     match CT[class_name].superclass:
///         case FJ.FJObject():
///             errors.append(f"In class '{class_name}' in method '{method.method_name}' a call to 'super' isnt possible, because 'super' is 'Object'")
///         case FJ.FJClass(name):
///             intern_env["super"] = FJ.FJClass(name)
///     type_of_e0 = typecheck_expression(method.body, intern_env, CT, warnings, f"In class '{class_name}' in method '{method.method_name}'")
///     if not is_subtype(type_of_e0, method.return_type, CT):
///         errors.append(f"In class '{class_name}' in method '{method.method_name}' the returned expression has type '{str(type_of_e0)}' while a subtype of '{str(method.return_type)}' was expected")
///         is_okey = False
///     # check superclass
///     if isinstance(CT[class_name].superclass, FJ.FJClass) and method.method_name in CT[str(CT[class_name].superclass)].methods.keys():
///         type_of_arguments_super, return_type_super = mtype(method.method_name, CT[class_name].superclass, CT)
///         if type_of_arguments_super == list(method.typed_parameters.values()) and return_type_super == method.return_type:
///             return True
///         else:
///             errors.append(f"In class '{class_name}' in method '{method.method_name}' the typesignature differs from the typesignatur of the method '{method.method_name}' defined in superclass '{str(CT[class_name].superclass)}' ({','.join(map(str, method.typed_parameters.values()))} != {','.join(map(str, type_of_arguments_super))} and/or {str(method.return_type)} != {str(return_type_super)})")
///             is_okey = False
///     return is_okey
///
///
/// def typecheck_class_definition(class_definition: FJ.ClassDef, env: dict[str, FJ.Type], CT: dict[str, FJ.ClassDef], warnings: list[StupidWarning], errors: list[str]) -> bool:
///     # check constructor
///     return all([typecheck_method(method, class_definition.class_name, env, CT, warnings, errors) for method in class_definition.methods.values()])
///
///
/// def typecheck_class_definitions(env: dict[str, FJ.Type], CT: dict[str, FJ.ClassDef], warnings: list[StupidWarning], errors: list[str]) -> bool:
///     # fill env
///     return all([typecheck_class_definition(class_definition, env, CT, warnings, errors) for class_definition in CT.values()])
///
///
/// def typecheck_program(program: FJ.Program) -> FJ.Type:
///     env = dict()
///     warnings = list()
///     errors = list()
///     if typecheck_class_definitions(env, program.class_table, warnings, errors):
///         type_of_expression = typecheck_expression(program.expression, env, program.class_table, warnings, "In main")
///         for warning in warnings:
///             warnings_.warn(warning)
///         return type_of_expression
///     else:
///         raise Exception("\n" + "\n".join(errors))
/// ```
final class FJ_typing extends PythonModule {
  FJ_typing.from(super.pythonModule) : super.from();

  static FJ_typing import() => PythonFfi.instance.importModule(
        "fj.FJ_typing",
        FJ_typing.from,
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

  /// ## mtype
  ///
  /// ### python docstring
  ///
  /// mtype(m, class_name, CT) == ([argument_type, ...], return_type)
  ///
  /// ### python source
  /// ```py
  /// def mtype(method_name: str, fjclass: FJ.Type, CT: FJ.ClassTable) -> tuple[list[FJ.Type], FJ.Type]:
  ///     """
  ///     mtype(m, class_name, CT) == ([argument_type, ...], return_type)
  ///     """
  ///     match fjclass:
  ///         case FJ.FJClass(name) if method_name in CT[name].methods.keys():
  ///             return ([x for x in CT[name].methods[method_name].typed_parameters.values()], CT[name].methods[method_name].return_type)
  ///         case FJ.FJClass(name):
  ///             return mtype(method_name, CT[name].superclass, CT)
  /// ```
  List<Object?> mtype({
    required String method_name,
    required Type fjclass,
    required Map<String, ClassDef> CT,
  }) =>
      List.from(
        getFunction("mtype").call(
          <Object?>[
            method_name,
            fjclass,
            CT,
          ],
          kwargs: <String, Object?>{},
        ),
      );

  /// ## typecheck_class_definition
  ///
  /// ### python source
  /// ```py
  /// def typecheck_class_definition(class_definition: FJ.ClassDef, env: dict[str, FJ.Type], CT: dict[str, FJ.ClassDef], warnings: list[StupidWarning], errors: list[str]) -> bool:
  ///     # check constructor
  ///     return all([typecheck_method(method, class_definition.class_name, env, CT, warnings, errors) for method in class_definition.methods.values()])
  /// ```
  bool typecheck_class_definition({
    required ClassDef class_definition,
    required Map<String, Type> env,
    required Map<String, ClassDef> CT,
    required List<StupidWarning> warnings,
    required List<String> errors,
  }) =>
      getFunction("typecheck_class_definition").call(
        <Object?>[
          class_definition,
          env,
          CT,
          warnings,
          errors,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## typecheck_class_definitions
  ///
  /// ### python source
  /// ```py
  /// def typecheck_class_definitions(env: dict[str, FJ.Type], CT: dict[str, FJ.ClassDef], warnings: list[StupidWarning], errors: list[str]) -> bool:
  ///     # fill env
  ///     return all([typecheck_class_definition(class_definition, env, CT, warnings, errors) for class_definition in CT.values()])
  /// ```
  bool typecheck_class_definitions({
    required Map<String, Type> env,
    required Map<String, ClassDef> CT,
    required List<StupidWarning> warnings,
    required List<String> errors,
  }) =>
      getFunction("typecheck_class_definitions").call(
        <Object?>[
          env,
          CT,
          warnings,
          errors,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## typecheck_expression
  ///
  /// ### python source
  /// ```py
  /// def typecheck_expression(expression: FJ.Expression, env: dict[str, FJ.Type], CT: dict[str, FJ.ClassDef], warnings: list[StupidWarning], error_prefix: str) -> FJ.Type:
  ///     match expression:
  ///         case FJ.Variable(name):
  ///             # check if variable is valid
  ///             if name not in env:
  ///                 if name == "super":
  ///                     raise Exception(f"\n{error_prefix} call to 'super' is not possible, because the superclass is 'Object'")
  ///                 raise Exception(f"\n{error_prefix} no variable '{name}' was found in scope")
  ///             return env[name]
  ///
  ///         case FJ.FieldLookup(expression, field):
  ///             # recursively getting type of the expression
  ///             type_of_expression = typecheck_expression(expression, env, CT, warnings, f"{error_prefix} in the expression of fieldlookup '{field}'")
  ///             # lookup all fields of the 'expression'
  ///             fields_of_expression = fields(type_of_expression, CT)
  ///             # check if the fieldlookup is valid
  ///             if field not in fields_of_expression:
  ///                 raise Exception(f"\n{error_prefix} the fieldlookup failed - class '{str(type_of_expression)}' has no field '{field}'")
  ///             # return the type of the field according to the fieldlookup
  ///             return fields_of_expression[field]
  ///
  ///         case FJ.MethodLookup(expression, method_name, parameters):
  ///             # recursively getting type of the expression
  ///             type_of_expression = typecheck_expression(expression, env, CT, warnings, f"{error_prefix} in the expression of the methodlookup '{method_name}'")
  ///             # checks if the method exists
  ///             match type_of_expression:
  ///                 case FJ.FJObject():
  ///                     raise Exception(f"\n{error_prefix} class 'Object' has no method '{method_name}'")
  ///                 case FJ.FJClass(name) if method_name not in CT[name].methods:
  ///                     raise Exception(f"\n{error_prefix} class '{name}' has no method '{method_name}'")
  ///             # getting mtype of method method_name
  ///             type_of_arguments_of_method, type_of_returnvalue_of_method = mtype(method_name, type_of_expression, CT)
  ///             # recursively checking the types of all parameters
  ///             type_of_parameters = [typecheck_expression(parameter, env, CT, warnings, f"{error_prefix} in the parameters of the methodlookup '{method_name}'") for parameter in parameters]
  ///             if len(type_of_arguments_of_method) != len(type_of_parameters):
  ///                 raise Exception(f"\n{error_prefix} wrong numbers of arguments")
  ///             # checking if the found types of the parameters match to the typedeclaration of the method (by beeing subtypes of them)
  ///             if all([is_subtype(class_C, class_D, CT) for class_C, class_D in zip(type_of_parameters, type_of_arguments_of_method)]):
  ///                 return type_of_returnvalue_of_method
  ///             else:
  ///                 raise Exception(f"\n{error_prefix} arguments of types '{', '.join(map(str, type_of_parameters))}' were given while arguments of subtypes of '{', '.join(map(str, type_of_arguments_of_method))}' were expected")
  ///
  ///         case FJ.NewClass(type, parameters):
  ///             # lookup all fields of the class 'type' (new 'type'(...))
  ///             fields_of_class = fields(type, CT)
  ///             # check if the number of parameters equals the number of fields
  ///             if len(parameters) != len(fields_of_class):
  ///                 raise Exception(f"\n{error_prefix} in 'new {str(type)}' {len(fields_of_class)} arguments were expected but {len(parameters)} were given")
  ///             # recursively checking the types of all parameters
  ///             types_of_parameters = [typecheck_expression(expression, env, CT, warnings, f"{error_prefix} in the parameters of 'new {str(type)}'") for expression in parameters]
  ///             # checking if the found types of the fields match the typedeclaration of the class (by beeing subtypes of them)
  ///             if all([is_subtype(class_C, class_D, CT) for class_C, class_D in zip(types_of_parameters, fields_of_class.values())]):
  ///                 return type
  ///             else:
  ///                 raise Exception(f"\n{error_prefix} in 'new {str(type)}' arguments of types '{', '.join(map(str, types_of_parameters))}' were given while arguments or subtypes of '{', '.join(map(str, fields_of_class.values()))}' were expected")
  ///
  ///         case FJ.Cast(type, expression):
  ///             type_of_expression = typecheck_expression(expression, env, CT, warnings, f"{error_prefix} in the Cast '({str(type)})'")
  ///             if is_subtype(type_of_expression, type, CT):  # UpCast
  ///                 return type
  ///             elif is_subtype(type, type_of_expression, CT):  # DownCast
  ///                 return type
  ///             else:  # stupid cast
  ///                 warnings.append(StupidWarning(f"\n{error_prefix} the cast between '{str(type)}' and '{str(type_of_expression)}' is stupid"))
  ///                 return type
  /// ```
  Type typecheck_expression({
    required Expression expression,
    required Map<String, Type> env,
    required Map<String, ClassDef> CT,
    required List<StupidWarning> warnings,
    required String error_prefix,
  }) =>
      Type.from(
        getFunction("typecheck_expression").call(
          <Object?>[
            expression,
            env,
            CT,
            warnings,
            error_prefix,
          ],
          kwargs: <String, Object?>{},
        ),
      );

  /// ## typecheck_method
  ///
  /// ### python source
  /// ```py
  /// def typecheck_method(method: FJ.MethodDef, class_name: str, env: dict[str, FJ.Type], CT: dict[str, FJ.ClassDef], warnings: list[StupidWarning], errors: list[str]) -> bool:
  ///     is_okey = True
  ///     intern_env = env.copy()
  ///     for argument, type_of_argument in method.typed_parameters.items():
  ///         if argument == "this" or argument == "super":
  ///             errors.append(f"In class '{class_name}' in method '{method.method_name}' arguments are not allowed to be named '{argument}'")
  ///             is_okey = False
  ///         intern_env[argument] = type_of_argument
  ///     intern_env["this"] = FJ.FJClass(class_name)
  ///     match CT[class_name].superclass:
  ///         case FJ.FJObject():
  ///             errors.append(f"In class '{class_name}' in method '{method.method_name}' a call to 'super' isnt possible, because 'super' is 'Object'")
  ///         case FJ.FJClass(name):
  ///             intern_env["super"] = FJ.FJClass(name)
  ///     type_of_e0 = typecheck_expression(method.body, intern_env, CT, warnings, f"In class '{class_name}' in method '{method.method_name}'")
  ///     if not is_subtype(type_of_e0, method.return_type, CT):
  ///         errors.append(f"In class '{class_name}' in method '{method.method_name}' the returned expression has type '{str(type_of_e0)}' while a subtype of '{str(method.return_type)}' was expected")
  ///         is_okey = False
  ///     # check superclass
  ///     if isinstance(CT[class_name].superclass, FJ.FJClass) and method.method_name in CT[str(CT[class_name].superclass)].methods.keys():
  ///         type_of_arguments_super, return_type_super = mtype(method.method_name, CT[class_name].superclass, CT)
  ///         if type_of_arguments_super == list(method.typed_parameters.values()) and return_type_super == method.return_type:
  ///             return True
  ///         else:
  ///             errors.append(f"In class '{class_name}' in method '{method.method_name}' the typesignature differs from the typesignatur of the method '{method.method_name}' defined in superclass '{str(CT[class_name].superclass)}' ({','.join(map(str, method.typed_parameters.values()))} != {','.join(map(str, type_of_arguments_super))} and/or {str(method.return_type)} != {str(return_type_super)})")
  ///             is_okey = False
  ///     return is_okey
  /// ```
  bool typecheck_method({
    required MethodDef method,
    required String class_name,
    required Map<String, Type> env,
    required Map<String, ClassDef> CT,
    required List<StupidWarning> warnings,
    required List<String> errors,
  }) =>
      getFunction("typecheck_method").call(
        <Object?>[
          method,
          class_name,
          env,
          CT,
          warnings,
          errors,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## typecheck_program
  ///
  /// ### python source
  /// ```py
  /// def typecheck_program(program: FJ.Program) -> FJ.Type:
  ///     env = dict()
  ///     warnings = list()
  ///     errors = list()
  ///     if typecheck_class_definitions(env, program.class_table, warnings, errors):
  ///         type_of_expression = typecheck_expression(program.expression, env, program.class_table, warnings, "In main")
  ///         for warning in warnings:
  ///             warnings_.warn(warning)
  ///         return type_of_expression
  ///     else:
  ///         raise Exception("\n" + "\n".join(errors))
  /// ```
  Type typecheck_program({
    required Program program,
  }) =>
      Type.from(
        getFunction("typecheck_program").call(
          <Object?>[
            program,
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
