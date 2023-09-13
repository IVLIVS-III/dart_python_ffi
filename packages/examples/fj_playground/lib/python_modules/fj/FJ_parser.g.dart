// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library FJ_parser;

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
        "fj.FJ_parser",
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
        "fj.FJ_parser",
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
        "fj.FJ_parser",
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
        "fj.FJ_parser",
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
        "fj.FJ_parser",
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
        "fj.FJ_parser",
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
        "fj.FJ_parser",
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
        "fj.FJ_parser",
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
        "fj.FJ_parser",
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
        "fj.FJ_parser",
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
        "fj.FJ_parser",
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
        "fj.FJ_parser",
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

/// ## Lark
///
/// ### python docstring
///
/// Main interface for the library.
///
/// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
///
/// Parameters:
///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
///     options: a dictionary controlling various aspects of Lark.
///
/// Example:
///     >>> Lark(r'''start: "foo" ''')
///     Lark(...)
///
///
///
/// **===  General Options  ===**
///
/// start
///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
/// debug
///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
/// strict
///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
/// transformer
///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
/// propagate_positions
///         Propagates positional attributes into the 'meta' attribute of all tree branches.
///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
///                           container_line, container_column, container_end_line, container_end_column)
///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
/// maybe_placeholders
///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
///         (default= ``True``)
/// cache
///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
///
///         - When ``False``, does nothing (default)
///         - When ``True``, caches to a temporary file in the local directory
///         - When given a string, caches to the path pointed by the string
/// regex
///         When True, uses the ``regex`` module instead of the stdlib ``re``.
/// g_regex_flags
///         Flags that are applied to all terminals (both regex and strings)
/// keep_all_tokens
///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
/// tree_class
///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
///
/// **=== Algorithm Options ===**
///
/// parser
///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
///         (there is also a "cyk" option for legacy)
/// lexer
///         Decides whether or not to use a lexer stage
///
///         - "auto" (default): Choose for me based on the parser
///         - "basic": Use a basic lexer
///         - "contextual": Stronger lexer (only works with parser="lalr")
///         - "dynamic": Flexible and powerful (only with parser="earley")
///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
/// ambiguity
///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
///
///         - "resolve": The parser will automatically choose the simplest derivation
///           (it chooses consistently: greedy for tokens, non-greedy for rules)
///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
///         - "forest": The parser will return the root of the shared packed parse forest.
///
/// **=== Misc. / Domain Specific Options ===**
///
/// postlex
///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
/// priority
///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
/// lexer_callbacks
///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
/// use_bytes
///         Accept an input of type ``bytes`` instead of ``str``.
/// edit_terminals
///         A callback for editing the terminals before parse.
/// import_paths
///         A List of either paths or loader functions to specify from where grammars are imported
/// source_path
///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
/// **=== End of Options ===**
///
/// ### python source
/// ```py
/// class Lark(Serialize):
///     """Main interface for the library.
///
///     It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
///
///     Parameters:
///         grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
///         options: a dictionary controlling various aspects of Lark.
///
///     Example:
///         >>> Lark(r'''start: "foo" ''')
///         Lark(...)
///     """
///
///     source_path: str
///     source_grammar: str
///     grammar: 'Grammar'
///     options: LarkOptions
///     lexer: Lexer
///     parser: 'ParsingFrontend'
///     terminals: Collection[TerminalDef]
///
///     def __init__(self, grammar: 'Union[Grammar, str, IO[str]]', **options) -> None:
///         self.options = LarkOptions(options)
///         re_module: types.ModuleType
///
///         # Set regex or re module
///         use_regex = self.options.regex
///         if use_regex:
///             if _has_regex:
///                 re_module = regex
///             else:
///                 raise ImportError('`regex` module must be installed if calling `Lark(regex=True)`.')
///         else:
///             re_module = re
///
///         # Some, but not all file-like objects have a 'name' attribute
///         if self.options.source_path is None:
///             try:
///                 self.source_path = grammar.name  # type: ignore[union-attr]
///             except AttributeError:
///                 self.source_path = '<string>'
///         else:
///             self.source_path = self.options.source_path
///
///         # Drain file-like objects to get their contents
///         try:
///             read = grammar.read  # type: ignore[union-attr]
///         except AttributeError:
///             pass
///         else:
///             grammar = read()
///
///         cache_fn = None
///         cache_sha256 = None
///         if isinstance(grammar, str):
///             self.source_grammar = grammar
///             if self.options.use_bytes:
///                 if not isascii(grammar):
///                     raise ConfigurationError("Grammar must be ascii only, when use_bytes=True")
///
///             if self.options.cache:
///                 if self.options.parser != 'lalr':
///                     raise ConfigurationError("cache only works with parser='lalr' for now")
///
///                 unhashable = ('transformer', 'postlex', 'lexer_callbacks', 'edit_terminals', '_plugins')
///                 options_str = ''.join(k+str(v) for k, v in options.items() if k not in unhashable)
///                 from . import __version__
///                 s = grammar + options_str + __version__ + str(sys.version_info[:2])
///                 cache_sha256 = sha256_digest(s)
///
///                 if isinstance(self.options.cache, str):
///                     cache_fn = self.options.cache
///                 else:
///                     if self.options.cache is not True:
///                         raise ConfigurationError("cache argument must be bool or str")
///
///                     try:
///                         username = getpass.getuser()
///                     except Exception:
///                         # The exception raised may be ImportError or OSError in
///                         # the future.  For the cache, we don't care about the
///                         # specific reason - we just want a username.
///                         username = "unknown"
///
///                     cache_fn = tempfile.gettempdir() + "/.lark_cache_%s_%s_%s_%s.tmp" % (username, cache_sha256, *sys.version_info[:2])
///
///                 old_options = self.options
///                 try:
///                     with FS.open(cache_fn, 'rb') as f:
///                         logger.debug('Loading grammar from cache: %s', cache_fn)
///                         # Remove options that aren't relevant for loading from cache
///                         for name in (set(options) - _LOAD_ALLOWED_OPTIONS):
///                             del options[name]
///                         file_sha256 = f.readline().rstrip(b'\n')
///                         cached_used_files = pickle.load(f)
///                         if file_sha256 == cache_sha256.encode('utf8') and verify_used_files(cached_used_files):
///                             cached_parser_data = pickle.load(f)
///                             self._load(cached_parser_data, **options)
///                             return
///                 except FileNotFoundError:
///                     # The cache file doesn't exist; parse and compose the grammar as normal
///                     pass
///                 except Exception: # We should probably narrow done which errors we catch here.
///                     logger.exception("Failed to load Lark from cache: %r. We will try to carry on.", cache_fn)
///
///                     # In theory, the Lark instance might have been messed up by the call to `_load`.
///                     # In practice the only relevant thing that might have been overwritten should be `options`
///                     self.options = old_options
///
///
///             # Parse the grammar file and compose the grammars
///             self.grammar, used_files = load_grammar(grammar, self.source_path, self.options.import_paths, self.options.keep_all_tokens)
///         else:
///             assert isinstance(grammar, Grammar)
///             self.grammar = grammar
///
///
///         if self.options.lexer == 'auto':
///             if self.options.parser == 'lalr':
///                 self.options.lexer = 'contextual'
///             elif self.options.parser == 'earley':
///                 if self.options.postlex is not None:
///                     logger.info("postlex can't be used with the dynamic lexer, so we use 'basic' instead. "
///                                 "Consider using lalr with contextual instead of earley")
///                     self.options.lexer = 'basic'
///                 else:
///                     self.options.lexer = 'dynamic'
///             elif self.options.parser == 'cyk':
///                 self.options.lexer = 'basic'
///             else:
///                 assert False, self.options.parser
///         lexer = self.options.lexer
///         if isinstance(lexer, type):
///             assert issubclass(lexer, Lexer)     # XXX Is this really important? Maybe just ensure interface compliance
///         else:
///             assert_config(lexer, ('basic', 'contextual', 'dynamic', 'dynamic_complete'))
///             if self.options.postlex is not None and 'dynamic' in lexer:
///                 raise ConfigurationError("Can't use postlex with a dynamic lexer. Use basic or contextual instead")
///
///         if self.options.ambiguity == 'auto':
///             if self.options.parser == 'earley':
///                 self.options.ambiguity = 'resolve'
///         else:
///             assert_config(self.options.parser, ('earley', 'cyk'), "%r doesn't support disambiguation. Use one of these parsers instead: %s")
///
///         if self.options.priority == 'auto':
///             self.options.priority = 'normal'
///
///         if self.options.priority not in _VALID_PRIORITY_OPTIONS:
///             raise ConfigurationError("invalid priority option: %r. Must be one of %r" % (self.options.priority, _VALID_PRIORITY_OPTIONS))
///         if self.options.ambiguity not in _VALID_AMBIGUITY_OPTIONS:
///             raise ConfigurationError("invalid ambiguity option: %r. Must be one of %r" % (self.options.ambiguity, _VALID_AMBIGUITY_OPTIONS))
///
///         if self.options.parser is None:
///             terminals_to_keep = '*'
///         elif self.options.postlex is not None:
///             terminals_to_keep = set(self.options.postlex.always_accept)
///         else:
///             terminals_to_keep = set()
///
///         # Compile the EBNF grammar into BNF
///         self.terminals, self.rules, self.ignore_tokens = self.grammar.compile(self.options.start, terminals_to_keep)
///
///         if self.options.edit_terminals:
///             for t in self.terminals:
///                 self.options.edit_terminals(t)
///
///         self._terminals_dict = {t.name: t for t in self.terminals}
///
///         # If the user asked to invert the priorities, negate them all here.
///         if self.options.priority == 'invert':
///             for rule in self.rules:
///                 if rule.options.priority is not None:
///                     rule.options.priority = -rule.options.priority
///             for term in self.terminals:
///                 term.priority = -term.priority
///         # Else, if the user asked to disable priorities, strip them from the
///         # rules and terminals. This allows the Earley parsers to skip an extra forest walk
///         # for improved performance, if you don't need them (or didn't specify any).
///         elif self.options.priority is None:
///             for rule in self.rules:
///                 if rule.options.priority is not None:
///                     rule.options.priority = None
///             for term in self.terminals:
///                 term.priority = 0
///
///         # TODO Deprecate lexer_callbacks?
///         self.lexer_conf = LexerConf(
///                 self.terminals, re_module, self.ignore_tokens, self.options.postlex,
///                 self.options.lexer_callbacks, self.options.g_regex_flags, use_bytes=self.options.use_bytes, strict=self.options.strict
///             )
///
///         if self.options.parser:
///             self.parser = self._build_parser()
///         elif lexer:
///             self.lexer = self._build_lexer()
///
///         if cache_fn:
///             logger.debug('Saving grammar to cache: %s', cache_fn)
///             try:
///                 with FS.open(cache_fn, 'wb') as f:
///                     assert cache_sha256 is not None
///                     f.write(cache_sha256.encode('utf8') + b'\n')
///                     pickle.dump(used_files, f)
///                     self.save(f, _LOAD_ALLOWED_OPTIONS)
///             except IOError as e:
///                 logger.exception("Failed to save Lark to cache: %r.", cache_fn, e)
///
///     if __doc__:
///         __doc__ += "\n\n" + LarkOptions.OPTIONS_DOC
///
///     __serialize_fields__ = 'parser', 'rules', 'options'
///
///     def _build_lexer(self, dont_ignore: bool=False) -> BasicLexer:
///         lexer_conf = self.lexer_conf
///         if dont_ignore:
///             from copy import copy
///             lexer_conf = copy(lexer_conf)
///             lexer_conf.ignore = ()
///         return BasicLexer(lexer_conf)
///
///     def _prepare_callbacks(self) -> None:
///         self._callbacks = {}
///         # we don't need these callbacks if we aren't building a tree
///         if self.options.ambiguity != 'forest':
///             self._parse_tree_builder = ParseTreeBuilder(
///                     self.rules,
///                     self.options.tree_class or Tree,
///                     self.options.propagate_positions,
///                     self.options.parser != 'lalr' and self.options.ambiguity == 'explicit',
///                     self.options.maybe_placeholders
///                 )
///             self._callbacks = self._parse_tree_builder.create_callback(self.options.transformer)
///         self._callbacks.update(_get_lexer_callbacks(self.options.transformer, self.terminals))
///
///     def _build_parser(self) -> "ParsingFrontend":
///         self._prepare_callbacks()
///         _validate_frontend_args(self.options.parser, self.options.lexer)
///         parser_conf = ParserConf(self.rules, self._callbacks, self.options.start)
///         return _construct_parsing_frontend(
///             self.options.parser,
///             self.options.lexer,
///             self.lexer_conf,
///             parser_conf,
///             options=self.options
///         )
///
///     def save(self, f, exclude_options: Collection[str] = ()) -> None:
///         """Saves the instance into the given file object
///
///         Useful for caching and multiprocessing.
///         """
///         data, m = self.memo_serialize([TerminalDef, Rule])
///         if exclude_options:
///             data["options"] = {n: v for n, v in data["options"].items() if n not in exclude_options}
///         pickle.dump({'data': data, 'memo': m}, f, protocol=pickle.HIGHEST_PROTOCOL)
///
///     @classmethod
///     def load(cls: Type[_T], f) -> _T:
///         """Loads an instance from the given file object
///
///         Useful for caching and multiprocessing.
///         """
///         inst = cls.__new__(cls)
///         return inst._load(f)
///
///     def _deserialize_lexer_conf(self, data: Dict[str, Any], memo: Dict[int, Union[TerminalDef, Rule]], options: LarkOptions) -> LexerConf:
///         lexer_conf = LexerConf.deserialize(data['lexer_conf'], memo)
///         lexer_conf.callbacks = options.lexer_callbacks or {}
///         lexer_conf.re_module = regex if options.regex else re
///         lexer_conf.use_bytes = options.use_bytes
///         lexer_conf.g_regex_flags = options.g_regex_flags
///         lexer_conf.skip_validation = True
///         lexer_conf.postlex = options.postlex
///         return lexer_conf
///
///     def _load(self: _T, f: Any, **kwargs) -> _T:
///         if isinstance(f, dict):
///             d = f
///         else:
///             d = pickle.load(f)
///         memo_json = d['memo']
///         data = d['data']
///
///         assert memo_json
///         memo = SerializeMemoizer.deserialize(memo_json, {'Rule': Rule, 'TerminalDef': TerminalDef}, {})
///         options = dict(data['options'])
///         if (set(kwargs) - _LOAD_ALLOWED_OPTIONS) & set(LarkOptions._defaults):
///             raise ConfigurationError("Some options are not allowed when loading a Parser: {}"
///                              .format(set(kwargs) - _LOAD_ALLOWED_OPTIONS))
///         options.update(kwargs)
///         self.options = LarkOptions.deserialize(options, memo)
///         self.rules = [Rule.deserialize(r, memo) for r in data['rules']]
///         self.source_path = '<deserialized>'
///         _validate_frontend_args(self.options.parser, self.options.lexer)
///         self.lexer_conf = self._deserialize_lexer_conf(data['parser'], memo, self.options)
///         self.terminals = self.lexer_conf.terminals
///         self._prepare_callbacks()
///         self._terminals_dict = {t.name: t for t in self.terminals}
///         self.parser = _deserialize_parsing_frontend(
///             data['parser'],
///             memo,
///             self.lexer_conf,
///             self._callbacks,
///             self.options,  # Not all, but multiple attributes are used
///         )
///         return self
///
///     @classmethod
///     def _load_from_dict(cls, data, memo, **kwargs):
///         inst = cls.__new__(cls)
///         return inst._load({'data': data, 'memo': memo}, **kwargs)
///
///     @classmethod
///     def open(cls: Type[_T], grammar_filename: str, rel_to: Optional[str]=None, **options) -> _T:
///         """Create an instance of Lark with the grammar given by its filename
///
///         If ``rel_to`` is provided, the function will find the grammar filename in relation to it.
///
///         Example:
///
///             >>> Lark.open("grammar_file.lark", rel_to=__file__, parser="lalr")
///             Lark(...)
///
///         """
///         if rel_to:
///             basepath = os.path.dirname(rel_to)
///             grammar_filename = os.path.join(basepath, grammar_filename)
///         with open(grammar_filename, encoding='utf8') as f:
///             return cls(f, **options)
///
///     @classmethod
///     def open_from_package(cls: Type[_T], package: str, grammar_path: str, search_paths: 'Sequence[str]'=[""], **options) -> _T:
///         """Create an instance of Lark with the grammar loaded from within the package `package`.
///         This allows grammar loading from zipapps.
///
///         Imports in the grammar will use the `package` and `search_paths` provided, through `FromPackageLoader`
///
///         Example:
///
///             Lark.open_from_package(__name__, "example.lark", ("grammars",), parser=...)
///         """
///         package_loader = FromPackageLoader(package, search_paths)
///         full_path, text = package_loader(None, grammar_path)
///         options.setdefault('source_path', full_path)
///         options.setdefault('import_paths', [])
///         options['import_paths'].append(package_loader)
///         return cls(text, **options)
///
///     def __repr__(self):
///         return 'Lark(open(%r), parser=%r, lexer=%r, ...)' % (self.source_path, self.options.parser, self.options.lexer)
///
///
///     def lex(self, text: str, dont_ignore: bool=False) -> Iterator[Token]:
///         """Only lex (and postlex) the text, without parsing it. Only relevant when lexer='basic'
///
///         When dont_ignore=True, the lexer will return all tokens, even those marked for %ignore.
///
///         :raises UnexpectedCharacters: In case the lexer cannot find a suitable match.
///         """
///         lexer: Lexer
///         if not hasattr(self, 'lexer') or dont_ignore:
///             lexer = self._build_lexer(dont_ignore)
///         else:
///             lexer = self.lexer
///         lexer_thread = LexerThread.from_text(lexer, text)
///         stream = lexer_thread.lex(None)
///         if self.options.postlex:
///             return self.options.postlex.process(stream)
///         return stream
///
///     def get_terminal(self, name: str) -> TerminalDef:
///         """Get information about a terminal"""
///         return self._terminals_dict[name]
///
///     def parse_interactive(self, text: Optional[str]=None, start: Optional[str]=None) -> 'InteractiveParser':
///         """Start an interactive parsing session.
///
///         Parameters:
///             text (str, optional): Text to be parsed. Required for ``resume_parse()``.
///             start (str, optional): Start symbol
///
///         Returns:
///             A new InteractiveParser instance.
///
///         See Also: ``Lark.parse()``
///         """
///         return self.parser.parse_interactive(text, start=start)
///
///     def parse(self, text: str, start: Optional[str]=None, on_error: 'Optional[Callable[[UnexpectedInput], bool]]'=None) -> 'ParseTree':
///         """Parse the given text, according to the options provided.
///
///         Parameters:
///             text (str): Text to be parsed.
///             start (str, optional): Required if Lark was given multiple possible start symbols (using the start option).
///             on_error (function, optional): if provided, will be called on UnexpectedToken error. Return true to resume parsing.
///                 LALR only. See examples/advanced/error_handling.py for an example of how to use on_error.
///
///         Returns:
///             If a transformer is supplied to ``__init__``, returns whatever is the
///             result of the transformation. Otherwise, returns a Tree instance.
///
///         :raises UnexpectedInput: On a parse error, one of these sub-exceptions will rise:
///                 ``UnexpectedCharacters``, ``UnexpectedToken``, or ``UnexpectedEOF``.
///                 For convenience, these sub-exceptions also inherit from ``ParserError`` and ``LexerError``.
///
///         """
///         return self.parser.parse(text, start=start, on_error=on_error)
/// ```
final class Lark extends PythonClass {
  factory Lark({
    required Object? grammar,
    Map<String, Object?> options = const <String, Object?>{},
  }) =>
      PythonFfi.instance.importClass(
        "fj.FJ_parser",
        "Lark",
        Lark.from,
        <Object?>[
          grammar,
        ],
        <String, Object?>{
          ...options,
        },
      );

  Lark.from(super.pythonClass) : super.from();

  /// ## get_terminal
  ///
  /// ### python docstring
  ///
  /// Get information about a terminal
  ///
  /// ### python source
  /// ```py
  /// def get_terminal(self, name: str) -> TerminalDef:
  ///         """Get information about a terminal"""
  ///         return self._terminals_dict[name]
  /// ```
  Object? get_terminal({
    required String name,
  }) =>
      getFunction("get_terminal").call(
        <Object?>[
          name,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## lex
  ///
  /// ### python docstring
  ///
  /// Only lex (and postlex) the text, without parsing it. Only relevant when lexer='basic'
  ///
  /// When dont_ignore=True, the lexer will return all tokens, even those marked for %ignore.
  ///
  /// :raises UnexpectedCharacters: In case the lexer cannot find a suitable match.
  ///
  /// ### python source
  /// ```py
  /// def lex(self, text: str, dont_ignore: bool=False) -> Iterator[Token]:
  ///         """Only lex (and postlex) the text, without parsing it. Only relevant when lexer='basic'
  ///
  ///         When dont_ignore=True, the lexer will return all tokens, even those marked for %ignore.
  ///
  ///         :raises UnexpectedCharacters: In case the lexer cannot find a suitable match.
  ///         """
  ///         lexer: Lexer
  ///         if not hasattr(self, 'lexer') or dont_ignore:
  ///             lexer = self._build_lexer(dont_ignore)
  ///         else:
  ///             lexer = self.lexer
  ///         lexer_thread = LexerThread.from_text(lexer, text)
  ///         stream = lexer_thread.lex(None)
  ///         if self.options.postlex:
  ///             return self.options.postlex.process(stream)
  ///         return stream
  /// ```
  Iterator<Object?> lex({
    required String text,
    bool dont_ignore = false,
  }) =>
      TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("lex").call(
            <Object?>[
              text,
              dont_ignore,
            ],
            kwargs: <String, Object?>{},
          ),
        ),
      ).transform((e) => e).cast<Object?>();

  /// ## memo_serialize
  ///
  /// ### python source
  /// ```py
  /// def memo_serialize(self, types_to_memoize: List) -> Any:
  ///         memo = SerializeMemoizer(types_to_memoize)
  ///         return self.serialize(memo), memo.serialize()
  /// ```
  Object? memo_serialize({
    required Object? types_to_memoize,
  }) =>
      getFunction("memo_serialize").call(
        <Object?>[
          types_to_memoize,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## parse
  ///
  /// ### python docstring
  ///
  /// Parse the given text, according to the options provided.
  ///
  /// Parameters:
  ///     text (str): Text to be parsed.
  ///     start (str, optional): Required if Lark was given multiple possible start symbols (using the start option).
  ///     on_error (function, optional): if provided, will be called on UnexpectedToken error. Return true to resume parsing.
  ///         LALR only. See examples/advanced/error_handling.py for an example of how to use on_error.
  ///
  /// Returns:
  ///     If a transformer is supplied to ``__init__``, returns whatever is the
  ///     result of the transformation. Otherwise, returns a Tree instance.
  ///
  /// :raises UnexpectedInput: On a parse error, one of these sub-exceptions will rise:
  ///         ``UnexpectedCharacters``, ``UnexpectedToken``, or ``UnexpectedEOF``.
  ///         For convenience, these sub-exceptions also inherit from ``ParserError`` and ``LexerError``.
  ///
  /// ### python source
  /// ```py
  /// def parse(self, text: str, start: Optional[str]=None, on_error: 'Optional[Callable[[UnexpectedInput], bool]]'=None) -> 'ParseTree':
  ///         """Parse the given text, according to the options provided.
  ///
  ///         Parameters:
  ///             text (str): Text to be parsed.
  ///             start (str, optional): Required if Lark was given multiple possible start symbols (using the start option).
  ///             on_error (function, optional): if provided, will be called on UnexpectedToken error. Return true to resume parsing.
  ///                 LALR only. See examples/advanced/error_handling.py for an example of how to use on_error.
  ///
  ///         Returns:
  ///             If a transformer is supplied to ``__init__``, returns whatever is the
  ///             result of the transformation. Otherwise, returns a Tree instance.
  ///
  ///         :raises UnexpectedInput: On a parse error, one of these sub-exceptions will rise:
  ///                 ``UnexpectedCharacters``, ``UnexpectedToken``, or ``UnexpectedEOF``.
  ///                 For convenience, these sub-exceptions also inherit from ``ParserError`` and ``LexerError``.
  ///
  ///         """
  ///         return self.parser.parse(text, start=start, on_error=on_error)
  /// ```
  Object? parse({
    required String text,
    Object? start,
    Object? on_error,
  }) =>
      getFunction("parse").call(
        <Object?>[
          text,
          start,
          on_error,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## parse_interactive
  ///
  /// ### python docstring
  ///
  /// Start an interactive parsing session.
  ///
  /// Parameters:
  ///     text (str, optional): Text to be parsed. Required for ``resume_parse()``.
  ///     start (str, optional): Start symbol
  ///
  /// Returns:
  ///     A new InteractiveParser instance.
  ///
  /// See Also: ``Lark.parse()``
  ///
  /// ### python source
  /// ```py
  /// def parse_interactive(self, text: Optional[str]=None, start: Optional[str]=None) -> 'InteractiveParser':
  ///         """Start an interactive parsing session.
  ///
  ///         Parameters:
  ///             text (str, optional): Text to be parsed. Required for ``resume_parse()``.
  ///             start (str, optional): Start symbol
  ///
  ///         Returns:
  ///             A new InteractiveParser instance.
  ///
  ///         See Also: ``Lark.parse()``
  ///         """
  ///         return self.parser.parse_interactive(text, start=start)
  /// ```
  Object? parse_interactive({
    Object? text,
    Object? start,
  }) =>
      getFunction("parse_interactive").call(
        <Object?>[
          text,
          start,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## save
  ///
  /// ### python docstring
  ///
  /// Saves the instance into the given file object
  ///
  /// Useful for caching and multiprocessing.
  ///
  /// ### python source
  /// ```py
  /// def save(self, f, exclude_options: Collection[str] = ()) -> None:
  ///         """Saves the instance into the given file object
  ///
  ///         Useful for caching and multiprocessing.
  ///         """
  ///         data, m = self.memo_serialize([TerminalDef, Rule])
  ///         if exclude_options:
  ///             data["options"] = {n: v for n, v in data["options"].items() if n not in exclude_options}
  ///         pickle.dump({'data': data, 'memo': m}, f, protocol=pickle.HIGHEST_PROTOCOL)
  /// ```
  Null save({
    required Object? f,
    Object? exclude_options = const [],
  }) =>
      getFunction("save").call(
        <Object?>[
          f,
          exclude_options,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## serialize
  ///
  /// ### python source
  /// ```py
  /// def serialize(self, memo = None) -> Dict[str, Any]:
  ///         if memo and memo.in_types(self):
  ///             return {'@': memo.memoized.get(self)}
  ///
  ///         fields = getattr(self, '__serialize_fields__')
  ///         res = {f: _serialize(getattr(self, f), memo) for f in fields}
  ///         res['__type__'] = type(self).__name__
  ///         if hasattr(self, '_serialize'):
  ///             self._serialize(res, memo)  # type: ignore[attr-defined]
  ///         return res
  /// ```
  Object? serialize({
    Object? memo,
  }) =>
      getFunction("serialize").call(
        <Object?>[
          memo,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## deserialize (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## load (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get load => getAttribute("load");

  /// ## load (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set load(Object? load) => setAttribute("load", load);

  /// ## open (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get open => getAttribute("open");

  /// ## open (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set open(Object? open) => setAttribute("open", open);

  /// ## open_from_package (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get open_from_package => getAttribute("open_from_package");

  /// ## open_from_package (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set open_from_package(Object? open_from_package) =>
      setAttribute("open_from_package", open_from_package);

  /// ## options (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get options => getAttribute("options");

  /// ## options (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set options(Object? options) => setAttribute("options", options);

  /// ## source_path (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get source_path => getAttribute("source_path");

  /// ## source_path (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set source_path(Object? source_path) =>
      setAttribute("source_path", source_path);

  /// ## source_grammar (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get source_grammar => getAttribute("source_grammar");

  /// ## source_grammar (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set source_grammar(Object? source_grammar) =>
      setAttribute("source_grammar", source_grammar);

  /// ## parser (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get parser => getAttribute("parser");

  /// ## parser (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set parser(Object? parser) => setAttribute("parser", parser);

  /// ## grammar (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get grammar => getAttribute("grammar");

  /// ## grammar (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set grammar(Object? grammar) => setAttribute("grammar", grammar);

  /// ## lexer (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get lexer => getAttribute("lexer");

  /// ## lexer (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set lexer(Object? lexer) => setAttribute("lexer", lexer);

  /// ## lexer_conf (getter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  Object? get lexer_conf => getAttribute("lexer_conf");

  /// ## lexer_conf (setter)
  ///
  /// ### python docstring
  ///
  /// Main interface for the library.
  ///
  /// It's mostly a thin wrapper for the many different parsers, and for the tree constructor.
  ///
  /// Parameters:
  ///     grammar: a string or file-object containing the grammar spec (using Lark's ebnf syntax)
  ///     options: a dictionary controlling various aspects of Lark.
  ///
  /// Example:
  ///     >>> Lark(r'''start: "foo" ''')
  ///     Lark(...)
  ///
  ///
  ///
  /// **===  General Options  ===**
  ///
  /// start
  ///         The start symbol. Either a string, or a list of strings for multiple possible starts (Default: "start")
  /// debug
  ///         Display debug information and extra warnings. Use only when debugging (Default: ``False``)
  ///         When used with Earley, it generates a forest graph as "sppf.png", if 'dot' is installed.
  /// strict
  ///         Throw an exception on any potential ambiguity, including shift/reduce conflicts, and regex collisions.
  /// transformer
  ///         Applies the transformer to every parse tree (equivalent to applying it after the parse, but faster)
  /// propagate_positions
  ///         Propagates positional attributes into the 'meta' attribute of all tree branches.
  ///         Sets attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         Accepts ``False``, ``True``, or a callable, which will filter which nodes to ignore when propagating.
  /// maybe_placeholders
  ///         When ``True``, the ``[]`` operator returns ``None`` when not matched.
  ///         When ``False``,  ``[]`` behaves like the ``?`` operator, and returns no value at all.
  ///         (default= ``True``)
  /// cache
  ///         Cache the results of the Lark grammar analysis, for x2 to x3 faster loading. LALR only for now.
  ///
  ///         - When ``False``, does nothing (default)
  ///         - When ``True``, caches to a temporary file in the local directory
  ///         - When given a string, caches to the path pointed by the string
  /// regex
  ///         When True, uses the ``regex`` module instead of the stdlib ``re``.
  /// g_regex_flags
  ///         Flags that are applied to all terminals (both regex and strings)
  /// keep_all_tokens
  ///         Prevent the tree builder from automagically removing "punctuation" tokens (Default: ``False``)
  /// tree_class
  ///         Lark will produce trees comprised of instances of this class instead of the default ``lark.Tree``.
  ///
  /// **=== Algorithm Options ===**
  ///
  /// parser
  ///         Decides which parser engine to use. Accepts "earley" or "lalr". (Default: "earley").
  ///         (there is also a "cyk" option for legacy)
  /// lexer
  ///         Decides whether or not to use a lexer stage
  ///
  ///         - "auto" (default): Choose for me based on the parser
  ///         - "basic": Use a basic lexer
  ///         - "contextual": Stronger lexer (only works with parser="lalr")
  ///         - "dynamic": Flexible and powerful (only with parser="earley")
  ///         - "dynamic_complete": Same as dynamic, but tries *every* variation of tokenizing possible.
  /// ambiguity
  ///         Decides how to handle ambiguity in the parse. Only relevant if parser="earley"
  ///
  ///         - "resolve": The parser will automatically choose the simplest derivation
  ///           (it chooses consistently: greedy for tokens, non-greedy for rules)
  ///         - "explicit": The parser will return all derivations wrapped in "_ambig" tree nodes (i.e. a forest).
  ///         - "forest": The parser will return the root of the shared packed parse forest.
  ///
  /// **=== Misc. / Domain Specific Options ===**
  ///
  /// postlex
  ///         Lexer post-processing (Default: ``None``) Only works with the basic and contextual lexers.
  /// priority
  ///         How priorities should be evaluated - "auto", ``None``, "normal", "invert" (Default: "auto")
  /// lexer_callbacks
  ///         Dictionary of callbacks for the lexer. May alter tokens during lexing. Use with caution.
  /// use_bytes
  ///         Accept an input of type ``bytes`` instead of ``str``.
  /// edit_terminals
  ///         A callback for editing the terminals before parse.
  /// import_paths
  ///         A List of either paths or loader functions to specify from where grammars are imported
  /// source_path
  ///         Override the source of from where the grammar was loaded. Useful for relative imports and unconventional grammar loading
  /// **=== End of Options ===**
  set lexer_conf(Object? lexer_conf) => setAttribute("lexer_conf", lexer_conf);
}

/// ## ParseException
///
/// ### python source
/// ```py
/// class ParseException(Exception):
///     pass
/// ```
final class ParseException extends PythonClass {
  factory ParseException() => PythonFfi.instance.importClass(
        "fj.FJ_parser",
        "ParseException",
        ParseException.from,
        <Object?>[],
      );

  ParseException.from(super.pythonClass) : super.from();

  /// ## args (getter)
  Object? get args => getAttribute("args");

  /// ## args (setter)
  set args(Object? args) => setAttribute("args", args);

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

/// ## Transformer
///
/// ### python docstring
///
/// Transformers work bottom-up (or depth-first), starting with visiting the leaves and working
/// their way up until ending at the root of the tree.
///
/// For each node visited, the transformer will call the appropriate method (callbacks), according to the
/// node's ``data``, and use the returned value to replace the node, thereby creating a new tree structure.
///
/// Transformers can be used to implement map & reduce patterns. Because nodes are reduced from leaf to root,
/// at any point the callbacks may assume the children have already been transformed (if applicable).
///
/// If the transformer cannot find a method with the right name, it will instead call ``__default__``, which by
/// default creates a copy of the node.
///
/// To discard a node, return Discard (``lark.visitors.Discard``).
///
/// ``Transformer`` can do anything ``Visitor`` can do, but because it reconstructs the tree,
/// it is slightly less efficient.
///
/// A transformer without methods essentially performs a non-memoized partial deepcopy.
///
/// All these classes implement the transformer interface:
///
/// - ``Transformer`` - Recursively transforms the tree. This is the one you probably want.
/// - ``Transformer_InPlace`` - Non-recursive. Changes the tree in-place instead of returning new instances
/// - ``Transformer_InPlaceRecursive`` - Recursive. Changes the tree in-place instead of returning new instances
///
/// Parameters:
///     visit_tokens (bool, optional): Should the transformer visit tokens in addition to rules.
///                                    Setting this to ``False`` is slightly faster. Defaults to ``True``.
///                                    (For processing ignored tokens, use the ``lexer_callbacks`` options)
///
/// ### python source
/// ```py
/// class Transformer(_Decoratable, ABC, Generic[_Leaf_T, _Return_T]):
///     """Transformers work bottom-up (or depth-first), starting with visiting the leaves and working
///     their way up until ending at the root of the tree.
///
///     For each node visited, the transformer will call the appropriate method (callbacks), according to the
///     node's ``data``, and use the returned value to replace the node, thereby creating a new tree structure.
///
///     Transformers can be used to implement map & reduce patterns. Because nodes are reduced from leaf to root,
///     at any point the callbacks may assume the children have already been transformed (if applicable).
///
///     If the transformer cannot find a method with the right name, it will instead call ``__default__``, which by
///     default creates a copy of the node.
///
///     To discard a node, return Discard (``lark.visitors.Discard``).
///
///     ``Transformer`` can do anything ``Visitor`` can do, but because it reconstructs the tree,
///     it is slightly less efficient.
///
///     A transformer without methods essentially performs a non-memoized partial deepcopy.
///
///     All these classes implement the transformer interface:
///
///     - ``Transformer`` - Recursively transforms the tree. This is the one you probably want.
///     - ``Transformer_InPlace`` - Non-recursive. Changes the tree in-place instead of returning new instances
///     - ``Transformer_InPlaceRecursive`` - Recursive. Changes the tree in-place instead of returning new instances
///
///     Parameters:
///         visit_tokens (bool, optional): Should the transformer visit tokens in addition to rules.
///                                        Setting this to ``False`` is slightly faster. Defaults to ``True``.
///                                        (For processing ignored tokens, use the ``lexer_callbacks`` options)
///
///     """
///     __visit_tokens__ = True   # For backwards compatibility
///
///     def __init__(self,  visit_tokens: bool=True) -> None:
///         self.__visit_tokens__ = visit_tokens
///
///     def _call_userfunc(self, tree, new_children=None):
///         # Assumes tree is already transformed
///         children = new_children if new_children is not None else tree.children
///         try:
///             f = getattr(self, tree.data)
///         except AttributeError:
///             return self.__default__(tree.data, children, tree.meta)
///         else:
///             try:
///                 wrapper = getattr(f, 'visit_wrapper', None)
///                 if wrapper is not None:
///                     return f.visit_wrapper(f, tree.data, children, tree.meta)
///                 else:
///                     return f(children)
///             except GrammarError:
///                 raise
///             except Exception as e:
///                 raise VisitError(tree.data, tree, e)
///
///     def _call_userfunc_token(self, token):
///         try:
///             f = getattr(self, token.type)
///         except AttributeError:
///             return self.__default_token__(token)
///         else:
///             try:
///                 return f(token)
///             except GrammarError:
///                 raise
///             except Exception as e:
///                 raise VisitError(token.type, token, e)
///
///     def _transform_children(self, children):
///         for c in children:
///             if isinstance(c, Tree):
///                 res = self._transform_tree(c)
///             elif self.__visit_tokens__ and isinstance(c, Token):
///                 res = self._call_userfunc_token(c)
///             else:
///                 res = c
///
///             if res is not Discard:
///                 yield res
///
///     def _transform_tree(self, tree):
///         children = list(self._transform_children(tree.children))
///         return self._call_userfunc(tree, children)
///
///     def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         "Transform the given tree, and return the final result"
///         return self._transform_tree(tree)
///
///     def __mul__(
///             self: 'Transformer[_Leaf_T, Tree[_Leaf_U]]',
///             other: 'Union[Transformer[_Leaf_U, _Return_V], TransformerChain[_Leaf_U, _Return_V,]]'
///     ) -> 'TransformerChain[_Leaf_T, _Return_V]':
///         """Chain two transformers together, returning a new transformer.
///         """
///         return TransformerChain(self, other)
///
///     def __default__(self, data, children, meta):
///         """Default function that is called if there is no attribute matching ``data``
///
///         Can be overridden. Defaults to creating a new copy of the tree node (i.e. ``return Tree(data, children, meta)``)
///         """
///         return Tree(data, children, meta)
///
///     def __default_token__(self, token):
///         """Default function that is called if there is no attribute matching ``token.type``
///
///         Can be overridden. Defaults to returning the token as-is.
///         """
///         return token
/// ```
final class Transformer extends PythonClass {
  factory Transformer({
    bool visit_tokens = true,
  }) =>
      PythonFfi.instance.importClass(
        "fj.FJ_parser",
        "Transformer",
        Transformer.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  Transformer.from(super.pythonClass) : super.from();

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         "Transform the given tree, and return the final result"
  ///         return self._transform_tree(tree)
  /// ```
  Object? transform({
    required Object? tree,
  }) =>
      getFunction("transform").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## TreeToFJ
///
/// ### python docstring
///
/// Transformers work bottom-up (or depth-first), starting with visiting the leaves and working
/// their way up until ending at the root of the tree.
///
/// For each node visited, the transformer will call the appropriate method (callbacks), according to the
/// node's ``data``, and use the returned value to replace the node, thereby creating a new tree structure.
///
/// Transformers can be used to implement map & reduce patterns. Because nodes are reduced from leaf to root,
/// at any point the callbacks may assume the children have already been transformed (if applicable).
///
/// If the transformer cannot find a method with the right name, it will instead call ``__default__``, which by
/// default creates a copy of the node.
///
/// To discard a node, return Discard (``lark.visitors.Discard``).
///
/// ``Transformer`` can do anything ``Visitor`` can do, but because it reconstructs the tree,
/// it is slightly less efficient.
///
/// A transformer without methods essentially performs a non-memoized partial deepcopy.
///
/// All these classes implement the transformer interface:
///
/// - ``Transformer`` - Recursively transforms the tree. This is the one you probably want.
/// - ``Transformer_InPlace`` - Non-recursive. Changes the tree in-place instead of returning new instances
/// - ``Transformer_InPlaceRecursive`` - Recursive. Changes the tree in-place instead of returning new instances
///
/// Parameters:
///     visit_tokens (bool, optional): Should the transformer visit tokens in addition to rules.
///                                    Setting this to ``False`` is slightly faster. Defaults to ``True``.
///                                    (For processing ignored tokens, use the ``lexer_callbacks`` options)
///
/// ### python source
/// ```py
/// class TreeToFJ(Transformer):
///
///     # Handling unallowed synatx
///
///     errors: list[str] = list()
///     keywords: list[str] = ["Object", "class", "extends", "return",
///                            "new"]
///     not_for_fields: list[str] = ["this", "super"]
///
///     def check_if_keyword(self, string: str):
///         if string in self.keywords:
///             self.errors.append(f"Using a keyword as identifier: '{string}'")
///
///     def check_variable_name(self, string: str):
///         if string[0].isupper():
///             self.errors.append(f"Names of variables must begin with a\
///                                  lowercase: '{string}'")
///
///     def check_fields_or_methods(self, string: str):
///         if string in self.not_for_fields:
///             self.errors.append(f"'super' is not allowed to be a part of a method name ('{string}')")
///
///     def check_class_name(self, string: str):
///         if string[0].islower():
///             self.errors.append(f"Names of classes must begin with an \
///                                  uppercase: '{string}'")
///
///     def show_errors(self):
///         if self.errors != []:
///             error_msg = f"Found {len(self.errors)} Error(s):\n" + \
///                           "\n".join(self.errors)
///             # have to delete all error messages, because type(self.errors) is list and lists are mutable over different instances
///             # have to make that pretier...
///             while len(self.errors):
///                 self.errors.pop()
///             raise ParseException(error_msg)
///
///     ###########################
///
///     def char(self, char_tupled):
///         ((char,),) = char_tupled
///         return char
///
///     def identifier(self, list_of_chars):
///         identifier = "".join(list_of_chars)
///         self.check_if_keyword(identifier)
///         return identifier
///
///     def type(self, type_tupled):
///         (type,) = type_tupled
///         return type
///
///     def fjobject(self, _):
///         return FJ.FJObject()
///
///     def fjclass(self, class_name_tupled):
///         (class_name,) = class_name_tupled
///         return FJ.FJClass(class_name)
///
///     def expression(self, expression_tupled):
///         (expression,) = expression_tupled
///         return expression
///
///     def variable(self, variable_tupled):
///         (variable,) = variable_tupled
///         self.check_variable_name(variable)
///         return FJ.Variable(variable)
///
///     def field_lookup(self, field_lookup):
///         expression, field = field_lookup
///         self.check_fields_or_methods(field)
///         return FJ.FieldLookup(expression, field)
///
///     def method_lookup(self, method_lookup):
///         expression, name, expressions = method_lookup
///         self.check_fields_or_methods(name)
///         return FJ.MethodLookup(expression, name, expressions)
///
///     def new_class(self, new_class):
///         type, parameters = new_class
///         return FJ.NewClass(type, parameters)
///
///     def cast(self, cast):
///         type, expression = cast
///         return FJ.Cast(type, expression)
///
///     def fieldenv(self, fieldenv_tupled_list):
///         return dict(fieldenv_tupled_list)
///
///     def varenv(self, varenv_tupled_list):
///         return dict(varenv_tupled_list)
///
///     def method_def(self, method_def):
///         (return_type, name, types_and_parameters, body) = method_def
///         return FJ.MethodDef(name, return_type, types_and_parameters, body)
///
///     def class_def(self, class_def):
///         if len(class_def) == 4:
///             class_name, super_class, fieldenv, methods = class_def
///         else:
///             class_name, super_class, fieldenv, constructor, methods = class_def
///         self.check_class_name(class_name)
///         return FJ.ClassDef(class_name, super_class, fieldenv, methods)
///
///     def class_def_list(self, class_def_list):
///         return dict([(x.class_name, x) for x in class_def_list])
///
///     def program(self, class_table_and_expression):
///         (class_table, expression) = class_table_and_expression
///         return FJ.Program(class_table, expression)
///
///     def fieldenv_helper(self, typed_identifier):
///         type, identifier = typed_identifier
///         return identifier, type
///
///     def varenv_helper(self, typed_variable):
///         (type, variable) = typed_variable
///         return variable, type
///
///     def expression_list(self, es):
///         return list(es)
///
///     def method_list(self, method_list):
///         return dict([(x.method_name, x) for x in method_list])
///
///     def with_error_warnings(self, program_tupled):
///         self.show_errors()
///         (program,) = program_tupled
///         return program
/// ```
final class TreeToFJ extends PythonClass {
  factory TreeToFJ({
    bool visit_tokens = true,
  }) =>
      PythonFfi.instance.importClass(
        "fj.FJ_parser",
        "TreeToFJ",
        TreeToFJ.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  TreeToFJ.from(super.pythonClass) : super.from();

  /// ## cast
  ///
  /// ### python source
  /// ```py
  /// def cast(self, cast):
  ///         type, expression = cast
  ///         return FJ.Cast(type, expression)
  /// ```
  Object? cast({
    required Object? cast,
  }) =>
      getFunction("cast").call(
        <Object?>[
          cast,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## char
  ///
  /// ### python source
  /// ```py
  /// def char(self, char_tupled):
  ///         ((char,),) = char_tupled
  ///         return char
  /// ```
  Object? char({
    required Object? char_tupled,
  }) =>
      getFunction("char").call(
        <Object?>[
          char_tupled,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## check_class_name
  ///
  /// ### python source
  /// ```py
  /// def check_class_name(self, string: str):
  ///         if string[0].islower():
  ///             self.errors.append(f"Names of classes must begin with an \
  ///                                  uppercase: '{string}'")
  /// ```
  Object? check_class_name({
    required String string,
  }) =>
      getFunction("check_class_name").call(
        <Object?>[
          string,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## check_fields_or_methods
  ///
  /// ### python source
  /// ```py
  /// def check_fields_or_methods(self, string: str):
  ///         if string in self.not_for_fields:
  ///             self.errors.append(f"'super' is not allowed to be a part of a method name ('{string}')")
  /// ```
  Object? check_fields_or_methods({
    required String string,
  }) =>
      getFunction("check_fields_or_methods").call(
        <Object?>[
          string,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## check_if_keyword
  ///
  /// ### python source
  /// ```py
  /// def check_if_keyword(self, string: str):
  ///         if string in self.keywords:
  ///             self.errors.append(f"Using a keyword as identifier: '{string}'")
  /// ```
  Object? check_if_keyword({
    required String string,
  }) =>
      getFunction("check_if_keyword").call(
        <Object?>[
          string,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## check_variable_name
  ///
  /// ### python source
  /// ```py
  /// def check_variable_name(self, string: str):
  ///         if string[0].isupper():
  ///             self.errors.append(f"Names of variables must begin with a\
  ///                                  lowercase: '{string}'")
  /// ```
  Object? check_variable_name({
    required String string,
  }) =>
      getFunction("check_variable_name").call(
        <Object?>[
          string,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## class_def
  ///
  /// ### python source
  /// ```py
  /// def class_def(self, class_def):
  ///         if len(class_def) == 4:
  ///             class_name, super_class, fieldenv, methods = class_def
  ///         else:
  ///             class_name, super_class, fieldenv, constructor, methods = class_def
  ///         self.check_class_name(class_name)
  ///         return FJ.ClassDef(class_name, super_class, fieldenv, methods)
  /// ```
  Object? class_def({
    required Object? class_def,
  }) =>
      getFunction("class_def").call(
        <Object?>[
          class_def,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## class_def_list
  ///
  /// ### python source
  /// ```py
  /// def class_def_list(self, class_def_list):
  ///         return dict([(x.class_name, x) for x in class_def_list])
  /// ```
  Object? class_def_list({
    required Object? class_def_list,
  }) =>
      getFunction("class_def_list").call(
        <Object?>[
          class_def_list,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expression
  ///
  /// ### python source
  /// ```py
  /// def expression(self, expression_tupled):
  ///         (expression,) = expression_tupled
  ///         return expression
  /// ```
  Object? expression({
    required Object? expression_tupled,
  }) =>
      getFunction("expression").call(
        <Object?>[
          expression_tupled,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expression_list
  ///
  /// ### python source
  /// ```py
  /// def expression_list(self, es):
  ///         return list(es)
  /// ```
  Object? expression_list({
    required Object? es,
  }) =>
      getFunction("expression_list").call(
        <Object?>[
          es,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## field_lookup
  ///
  /// ### python source
  /// ```py
  /// def field_lookup(self, field_lookup):
  ///         expression, field = field_lookup
  ///         self.check_fields_or_methods(field)
  ///         return FJ.FieldLookup(expression, field)
  /// ```
  Object? field_lookup({
    required Object? field_lookup,
  }) =>
      getFunction("field_lookup").call(
        <Object?>[
          field_lookup,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## fieldenv
  ///
  /// ### python source
  /// ```py
  /// def fieldenv(self, fieldenv_tupled_list):
  ///         return dict(fieldenv_tupled_list)
  /// ```
  Object? fieldenv({
    required Object? fieldenv_tupled_list,
  }) =>
      getFunction("fieldenv").call(
        <Object?>[
          fieldenv_tupled_list,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## fieldenv_helper
  ///
  /// ### python source
  /// ```py
  /// def fieldenv_helper(self, typed_identifier):
  ///         type, identifier = typed_identifier
  ///         return identifier, type
  /// ```
  Object? fieldenv_helper({
    required Object? typed_identifier,
  }) =>
      getFunction("fieldenv_helper").call(
        <Object?>[
          typed_identifier,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## fjclass
  ///
  /// ### python source
  /// ```py
  /// def fjclass(self, class_name_tupled):
  ///         (class_name,) = class_name_tupled
  ///         return FJ.FJClass(class_name)
  /// ```
  Object? fjclass({
    required Object? class_name_tupled,
  }) =>
      getFunction("fjclass").call(
        <Object?>[
          class_name_tupled,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## fjobject
  ///
  /// ### python source
  /// ```py
  /// def fjobject(self, _):
  ///         return FJ.FJObject()
  /// ```
  Object? fjobject({
    required Object? $_,
  }) =>
      getFunction("fjobject").call(
        <Object?>[
          $_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## identifier
  ///
  /// ### python source
  /// ```py
  /// def identifier(self, list_of_chars):
  ///         identifier = "".join(list_of_chars)
  ///         self.check_if_keyword(identifier)
  ///         return identifier
  /// ```
  Object? identifier({
    required Object? list_of_chars,
  }) =>
      getFunction("identifier").call(
        <Object?>[
          list_of_chars,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## method_def
  ///
  /// ### python source
  /// ```py
  /// def method_def(self, method_def):
  ///         (return_type, name, types_and_parameters, body) = method_def
  ///         return FJ.MethodDef(name, return_type, types_and_parameters, body)
  /// ```
  Object? method_def({
    required Object? method_def,
  }) =>
      getFunction("method_def").call(
        <Object?>[
          method_def,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## method_list
  ///
  /// ### python source
  /// ```py
  /// def method_list(self, method_list):
  ///         return dict([(x.method_name, x) for x in method_list])
  /// ```
  Object? method_list({
    required Object? method_list,
  }) =>
      getFunction("method_list").call(
        <Object?>[
          method_list,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## method_lookup
  ///
  /// ### python source
  /// ```py
  /// def method_lookup(self, method_lookup):
  ///         expression, name, expressions = method_lookup
  ///         self.check_fields_or_methods(name)
  ///         return FJ.MethodLookup(expression, name, expressions)
  /// ```
  Object? method_lookup({
    required Object? method_lookup,
  }) =>
      getFunction("method_lookup").call(
        <Object?>[
          method_lookup,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## new_class
  ///
  /// ### python source
  /// ```py
  /// def new_class(self, new_class):
  ///         type, parameters = new_class
  ///         return FJ.NewClass(type, parameters)
  /// ```
  Object? new_class({
    required Object? new_class,
  }) =>
      getFunction("new_class").call(
        <Object?>[
          new_class,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## program
  ///
  /// ### python source
  /// ```py
  /// def program(self, class_table_and_expression):
  ///         (class_table, expression) = class_table_and_expression
  ///         return FJ.Program(class_table, expression)
  /// ```
  Object? program({
    required Object? class_table_and_expression,
  }) =>
      getFunction("program").call(
        <Object?>[
          class_table_and_expression,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## show_errors
  ///
  /// ### python source
  /// ```py
  /// def show_errors(self):
  ///         if self.errors != []:
  ///             error_msg = f"Found {len(self.errors)} Error(s):\n" + \
  ///                           "\n".join(self.errors)
  ///             # have to delete all error messages, because type(self.errors) is list and lists are mutable over different instances
  ///             # have to make that pretier...
  ///             while len(self.errors):
  ///                 self.errors.pop()
  ///             raise ParseException(error_msg)
  /// ```
  Object? show_errors() => getFunction("show_errors").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         "Transform the given tree, and return the final result"
  ///         return self._transform_tree(tree)
  /// ```
  Object? transform({
    required Object? tree,
  }) =>
      getFunction("transform").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## type
  ///
  /// ### python source
  /// ```py
  /// def type(self, type_tupled):
  ///         (type,) = type_tupled
  ///         return type
  /// ```
  Object? type({
    required Object? type_tupled,
  }) =>
      getFunction("type").call(
        <Object?>[
          type_tupled,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## varenv
  ///
  /// ### python source
  /// ```py
  /// def varenv(self, varenv_tupled_list):
  ///         return dict(varenv_tupled_list)
  /// ```
  Object? varenv({
    required Object? varenv_tupled_list,
  }) =>
      getFunction("varenv").call(
        <Object?>[
          varenv_tupled_list,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## varenv_helper
  ///
  /// ### python source
  /// ```py
  /// def varenv_helper(self, typed_variable):
  ///         (type, variable) = typed_variable
  ///         return variable, type
  /// ```
  Object? varenv_helper({
    required Object? typed_variable,
  }) =>
      getFunction("varenv_helper").call(
        <Object?>[
          typed_variable,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## variable
  ///
  /// ### python source
  /// ```py
  /// def variable(self, variable_tupled):
  ///         (variable,) = variable_tupled
  ///         self.check_variable_name(variable)
  ///         return FJ.Variable(variable)
  /// ```
  Object? variable({
    required Object? variable_tupled,
  }) =>
      getFunction("variable").call(
        <Object?>[
          variable_tupled,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## with_error_warnings
  ///
  /// ### python source
  /// ```py
  /// def with_error_warnings(self, program_tupled):
  ///         self.show_errors()
  ///         (program,) = program_tupled
  ///         return program
  /// ```
  Object? with_error_warnings({
    required Object? program_tupled,
  }) =>
      getFunction("with_error_warnings").call(
        <Object?>[
          program_tupled,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## errors (getter)
  ///
  /// ### python docstring
  ///
  /// Transformers work bottom-up (or depth-first), starting with visiting the leaves and working
  /// their way up until ending at the root of the tree.
  ///
  /// For each node visited, the transformer will call the appropriate method (callbacks), according to the
  /// node's ``data``, and use the returned value to replace the node, thereby creating a new tree structure.
  ///
  /// Transformers can be used to implement map & reduce patterns. Because nodes are reduced from leaf to root,
  /// at any point the callbacks may assume the children have already been transformed (if applicable).
  ///
  /// If the transformer cannot find a method with the right name, it will instead call ``__default__``, which by
  /// default creates a copy of the node.
  ///
  /// To discard a node, return Discard (``lark.visitors.Discard``).
  ///
  /// ``Transformer`` can do anything ``Visitor`` can do, but because it reconstructs the tree,
  /// it is slightly less efficient.
  ///
  /// A transformer without methods essentially performs a non-memoized partial deepcopy.
  ///
  /// All these classes implement the transformer interface:
  ///
  /// - ``Transformer`` - Recursively transforms the tree. This is the one you probably want.
  /// - ``Transformer_InPlace`` - Non-recursive. Changes the tree in-place instead of returning new instances
  /// - ``Transformer_InPlaceRecursive`` - Recursive. Changes the tree in-place instead of returning new instances
  ///
  /// Parameters:
  ///     visit_tokens (bool, optional): Should the transformer visit tokens in addition to rules.
  ///                                    Setting this to ``False`` is slightly faster. Defaults to ``True``.
  ///                                    (For processing ignored tokens, use the ``lexer_callbacks`` options)
  Object? get errors => getAttribute("errors");

  /// ## errors (setter)
  ///
  /// ### python docstring
  ///
  /// Transformers work bottom-up (or depth-first), starting with visiting the leaves and working
  /// their way up until ending at the root of the tree.
  ///
  /// For each node visited, the transformer will call the appropriate method (callbacks), according to the
  /// node's ``data``, and use the returned value to replace the node, thereby creating a new tree structure.
  ///
  /// Transformers can be used to implement map & reduce patterns. Because nodes are reduced from leaf to root,
  /// at any point the callbacks may assume the children have already been transformed (if applicable).
  ///
  /// If the transformer cannot find a method with the right name, it will instead call ``__default__``, which by
  /// default creates a copy of the node.
  ///
  /// To discard a node, return Discard (``lark.visitors.Discard``).
  ///
  /// ``Transformer`` can do anything ``Visitor`` can do, but because it reconstructs the tree,
  /// it is slightly less efficient.
  ///
  /// A transformer without methods essentially performs a non-memoized partial deepcopy.
  ///
  /// All these classes implement the transformer interface:
  ///
  /// - ``Transformer`` - Recursively transforms the tree. This is the one you probably want.
  /// - ``Transformer_InPlace`` - Non-recursive. Changes the tree in-place instead of returning new instances
  /// - ``Transformer_InPlaceRecursive`` - Recursive. Changes the tree in-place instead of returning new instances
  ///
  /// Parameters:
  ///     visit_tokens (bool, optional): Should the transformer visit tokens in addition to rules.
  ///                                    Setting this to ``False`` is slightly faster. Defaults to ``True``.
  ///                                    (For processing ignored tokens, use the ``lexer_callbacks`` options)
  set errors(Object? errors) => setAttribute("errors", errors);

  /// ## keywords (getter)
  ///
  /// ### python docstring
  ///
  /// Transformers work bottom-up (or depth-first), starting with visiting the leaves and working
  /// their way up until ending at the root of the tree.
  ///
  /// For each node visited, the transformer will call the appropriate method (callbacks), according to the
  /// node's ``data``, and use the returned value to replace the node, thereby creating a new tree structure.
  ///
  /// Transformers can be used to implement map & reduce patterns. Because nodes are reduced from leaf to root,
  /// at any point the callbacks may assume the children have already been transformed (if applicable).
  ///
  /// If the transformer cannot find a method with the right name, it will instead call ``__default__``, which by
  /// default creates a copy of the node.
  ///
  /// To discard a node, return Discard (``lark.visitors.Discard``).
  ///
  /// ``Transformer`` can do anything ``Visitor`` can do, but because it reconstructs the tree,
  /// it is slightly less efficient.
  ///
  /// A transformer without methods essentially performs a non-memoized partial deepcopy.
  ///
  /// All these classes implement the transformer interface:
  ///
  /// - ``Transformer`` - Recursively transforms the tree. This is the one you probably want.
  /// - ``Transformer_InPlace`` - Non-recursive. Changes the tree in-place instead of returning new instances
  /// - ``Transformer_InPlaceRecursive`` - Recursive. Changes the tree in-place instead of returning new instances
  ///
  /// Parameters:
  ///     visit_tokens (bool, optional): Should the transformer visit tokens in addition to rules.
  ///                                    Setting this to ``False`` is slightly faster. Defaults to ``True``.
  ///                                    (For processing ignored tokens, use the ``lexer_callbacks`` options)
  Object? get keywords => getAttribute("keywords");

  /// ## keywords (setter)
  ///
  /// ### python docstring
  ///
  /// Transformers work bottom-up (or depth-first), starting with visiting the leaves and working
  /// their way up until ending at the root of the tree.
  ///
  /// For each node visited, the transformer will call the appropriate method (callbacks), according to the
  /// node's ``data``, and use the returned value to replace the node, thereby creating a new tree structure.
  ///
  /// Transformers can be used to implement map & reduce patterns. Because nodes are reduced from leaf to root,
  /// at any point the callbacks may assume the children have already been transformed (if applicable).
  ///
  /// If the transformer cannot find a method with the right name, it will instead call ``__default__``, which by
  /// default creates a copy of the node.
  ///
  /// To discard a node, return Discard (``lark.visitors.Discard``).
  ///
  /// ``Transformer`` can do anything ``Visitor`` can do, but because it reconstructs the tree,
  /// it is slightly less efficient.
  ///
  /// A transformer without methods essentially performs a non-memoized partial deepcopy.
  ///
  /// All these classes implement the transformer interface:
  ///
  /// - ``Transformer`` - Recursively transforms the tree. This is the one you probably want.
  /// - ``Transformer_InPlace`` - Non-recursive. Changes the tree in-place instead of returning new instances
  /// - ``Transformer_InPlaceRecursive`` - Recursive. Changes the tree in-place instead of returning new instances
  ///
  /// Parameters:
  ///     visit_tokens (bool, optional): Should the transformer visit tokens in addition to rules.
  ///                                    Setting this to ``False`` is slightly faster. Defaults to ``True``.
  ///                                    (For processing ignored tokens, use the ``lexer_callbacks`` options)
  set keywords(Object? keywords) => setAttribute("keywords", keywords);

  /// ## not_for_fields (getter)
  ///
  /// ### python docstring
  ///
  /// Transformers work bottom-up (or depth-first), starting with visiting the leaves and working
  /// their way up until ending at the root of the tree.
  ///
  /// For each node visited, the transformer will call the appropriate method (callbacks), according to the
  /// node's ``data``, and use the returned value to replace the node, thereby creating a new tree structure.
  ///
  /// Transformers can be used to implement map & reduce patterns. Because nodes are reduced from leaf to root,
  /// at any point the callbacks may assume the children have already been transformed (if applicable).
  ///
  /// If the transformer cannot find a method with the right name, it will instead call ``__default__``, which by
  /// default creates a copy of the node.
  ///
  /// To discard a node, return Discard (``lark.visitors.Discard``).
  ///
  /// ``Transformer`` can do anything ``Visitor`` can do, but because it reconstructs the tree,
  /// it is slightly less efficient.
  ///
  /// A transformer without methods essentially performs a non-memoized partial deepcopy.
  ///
  /// All these classes implement the transformer interface:
  ///
  /// - ``Transformer`` - Recursively transforms the tree. This is the one you probably want.
  /// - ``Transformer_InPlace`` - Non-recursive. Changes the tree in-place instead of returning new instances
  /// - ``Transformer_InPlaceRecursive`` - Recursive. Changes the tree in-place instead of returning new instances
  ///
  /// Parameters:
  ///     visit_tokens (bool, optional): Should the transformer visit tokens in addition to rules.
  ///                                    Setting this to ``False`` is slightly faster. Defaults to ``True``.
  ///                                    (For processing ignored tokens, use the ``lexer_callbacks`` options)
  Object? get not_for_fields => getAttribute("not_for_fields");

  /// ## not_for_fields (setter)
  ///
  /// ### python docstring
  ///
  /// Transformers work bottom-up (or depth-first), starting with visiting the leaves and working
  /// their way up until ending at the root of the tree.
  ///
  /// For each node visited, the transformer will call the appropriate method (callbacks), according to the
  /// node's ``data``, and use the returned value to replace the node, thereby creating a new tree structure.
  ///
  /// Transformers can be used to implement map & reduce patterns. Because nodes are reduced from leaf to root,
  /// at any point the callbacks may assume the children have already been transformed (if applicable).
  ///
  /// If the transformer cannot find a method with the right name, it will instead call ``__default__``, which by
  /// default creates a copy of the node.
  ///
  /// To discard a node, return Discard (``lark.visitors.Discard``).
  ///
  /// ``Transformer`` can do anything ``Visitor`` can do, but because it reconstructs the tree,
  /// it is slightly less efficient.
  ///
  /// A transformer without methods essentially performs a non-memoized partial deepcopy.
  ///
  /// All these classes implement the transformer interface:
  ///
  /// - ``Transformer`` - Recursively transforms the tree. This is the one you probably want.
  /// - ``Transformer_InPlace`` - Non-recursive. Changes the tree in-place instead of returning new instances
  /// - ``Transformer_InPlaceRecursive`` - Recursive. Changes the tree in-place instead of returning new instances
  ///
  /// Parameters:
  ///     visit_tokens (bool, optional): Should the transformer visit tokens in addition to rules.
  ///                                    Setting this to ``False`` is slightly faster. Defaults to ``True``.
  ///                                    (For processing ignored tokens, use the ``lexer_callbacks`` options)
  set not_for_fields(Object? not_for_fields) =>
      setAttribute("not_for_fields", not_for_fields);
}

/// ## tree_class
///
/// ### python docstring
///
/// The main tree class.
///
/// Creates a new tree, and stores "data" and "children" in attributes of the same name.
/// Trees can be hashed and compared.
///
/// Parameters:
///     data: The name of the rule or alias
///     children: List of matched sub-rules and terminals
///     meta: Line & Column numbers (if ``propagate_positions`` is enabled).
///         meta attributes: (line, column, end_line, end_column, start_pos, end_pos,
///                           container_line, container_column, container_end_line, container_end_column)
///         container_* attributes consider all symbols, including those that have been inlined in the tree.
///         For example, in the rule 'a: _A B _C', the regular attributes will mark the start and end of B,
///         but the container_* attributes will also include _A and _C in the range. However, rules that
///         contain 'a' will consider it in full, including _A and _C for all attributes.
///
/// ### python source
/// ```py
/// class Tree(Generic[_Leaf_T]):
///     """The main tree class.
///
///     Creates a new tree, and stores "data" and "children" in attributes of the same name.
///     Trees can be hashed and compared.
///
///     Parameters:
///         data: The name of the rule or alias
///         children: List of matched sub-rules and terminals
///         meta: Line & Column numbers (if ``propagate_positions`` is enabled).
///             meta attributes: (line, column, end_line, end_column, start_pos, end_pos,
///                               container_line, container_column, container_end_line, container_end_column)
///             container_* attributes consider all symbols, including those that have been inlined in the tree.
///             For example, in the rule 'a: _A B _C', the regular attributes will mark the start and end of B,
///             but the container_* attributes will also include _A and _C in the range. However, rules that
///             contain 'a' will consider it in full, including _A and _C for all attributes.
///     """
///
///     data: str
///     children: 'List[Branch[_Leaf_T]]'
///
///     def __init__(self, data: str, children: 'List[Branch[_Leaf_T]]', meta: Optional[Meta]=None) -> None:
///         self.data = data
///         self.children = children
///         self._meta = meta
///
///     @property
///     def meta(self) -> Meta:
///         if self._meta is None:
///             self._meta = Meta()
///         return self._meta
///
///     def __repr__(self):
///         return 'Tree(%r, %r)' % (self.data, self.children)
///
///     def _pretty_label(self):
///         return self.data
///
///     def _pretty(self, level, indent_str):
///         yield f'{indent_str*level}{self._pretty_label()}'
///         if len(self.children) == 1 and not isinstance(self.children[0], Tree):
///             yield f'\t{self.children[0]}\n'
///         else:
///             yield '\n'
///             for n in self.children:
///                 if isinstance(n, Tree):
///                     yield from n._pretty(level+1, indent_str)
///                 else:
///                     yield f'{indent_str*(level+1)}{n}\n'
///
///     def pretty(self, indent_str: str='  ') -> str:
///         """Returns an indented string representation of the tree.
///
///         Great for debugging.
///         """
///         return ''.join(self._pretty(0, indent_str))
///
///     def __rich__(self, parent:Optional['rich.tree.Tree']=None) -> 'rich.tree.Tree':
///         """Returns a tree widget for the 'rich' library.
///
///         Example:
///             ::
///                 from rich import print
///                 from lark import Tree
///
///                 tree = Tree('root', ['node1', 'node2'])
///                 print(tree)
///         """
///         return self._rich(parent)
///
///     def _rich(self, parent):
///         if parent:
///             tree = parent.add(f'[bold]{self.data}[/bold]')
///         else:
///             import rich.tree
///             tree = rich.tree.Tree(self.data)
///
///         for c in self.children:
///             if isinstance(c, Tree):
///                 c._rich(tree)
///             else:
///                 tree.add(f'[green]{c}[/green]')
///
///         return tree
///
///     def __eq__(self, other):
///         try:
///             return self.data == other.data and self.children == other.children
///         except AttributeError:
///             return False
///
///     def __ne__(self, other):
///         return not (self == other)
///
///     def __hash__(self) -> int:
///         return hash((self.data, tuple(self.children)))
///
///     def iter_subtrees(self) -> 'Iterator[Tree[_Leaf_T]]':
///         """Depth-first iteration.
///
///         Iterates over all the subtrees, never returning to the same node twice (Lark's parse-tree is actually a DAG).
///         """
///         queue = [self]
///         subtrees = OrderedDict()
///         for subtree in queue:
///             subtrees[id(subtree)] = subtree
///             # Reason for type ignore https://github.com/python/mypy/issues/10999
///             queue += [c for c in reversed(subtree.children)  # type: ignore[misc]
///                       if isinstance(c, Tree) and id(c) not in subtrees]
///
///         del queue
///         return reversed(list(subtrees.values()))
///
///     def iter_subtrees_topdown(self):
///         """Breadth-first iteration.
///
///         Iterates over all the subtrees, return nodes in order like pretty() does.
///         """
///         stack = [self]
///         stack_append = stack.append
///         stack_pop = stack.pop
///         while stack:
///             node = stack_pop()
///             if not isinstance(node, Tree):
///                 continue
///             yield node
///             for child in reversed(node.children):
///                 stack_append(child)
///
///     def find_pred(self, pred: 'Callable[[Tree[_Leaf_T]], bool]') -> 'Iterator[Tree[_Leaf_T]]':
///         """Returns all nodes of the tree that evaluate pred(node) as true."""
///         return filter(pred, self.iter_subtrees())
///
///     def find_data(self, data: str) -> 'Iterator[Tree[_Leaf_T]]':
///         """Returns all nodes of the tree whose data equals the given data."""
///         return self.find_pred(lambda t: t.data == data)
///
/// ###}
///
///     def expand_kids_by_data(self, *data_values):
///         """Expand (inline) children with any of the given data values. Returns True if anything changed"""
///         changed = False
///         for i in range(len(self.children)-1, -1, -1):
///             child = self.children[i]
///             if isinstance(child, Tree) and child.data in data_values:
///                 self.children[i:i+1] = child.children
///                 changed = True
///         return changed
///
///
///     def scan_values(self, pred: 'Callable[[Branch[_Leaf_T]], bool]') -> Iterator[_Leaf_T]:
///         """Return all values in the tree that evaluate pred(value) as true.
///
///         This can be used to find all the tokens in the tree.
///
///         Example:
///             >>> all_tokens = tree.scan_values(lambda v: isinstance(v, Token))
///         """
///         for c in self.children:
///             if isinstance(c, Tree):
///                 for t in c.scan_values(pred):
///                     yield t
///             else:
///                 if pred(c):
///                     yield c
///
///     def __deepcopy__(self, memo):
///         return type(self)(self.data, deepcopy(self.children, memo), meta=self._meta)
///
///     def copy(self) -> 'Tree[_Leaf_T]':
///         return type(self)(self.data, self.children)
///
///     def set(self, data: str, children: 'List[Branch[_Leaf_T]]') -> None:
///         self.data = data
///         self.children = children
/// ```
final class tree_class extends PythonClass {
  factory tree_class({
    required String data,
    required Object? children,
    Object? meta,
  }) =>
      PythonFfi.instance.importClass(
        "fj.FJ_parser",
        "tree_class",
        tree_class.from,
        <Object?>[
          data,
          children,
          meta,
        ],
        <String, Object?>{},
      );

  tree_class.from(super.pythonClass) : super.from();

  /// ## copy
  ///
  /// ### python source
  /// ```py
  /// def copy(self) -> 'Tree[_Leaf_T]':
  ///         return type(self)(self.data, self.children)
  /// ```
  Object? copy() => getFunction("copy").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## expand_kids_by_data
  ///
  /// ### python docstring
  ///
  /// Expand (inline) children with any of the given data values. Returns True if anything changed
  ///
  /// ### python source
  /// ```py
  /// def expand_kids_by_data(self, *data_values):
  ///         """Expand (inline) children with any of the given data values. Returns True if anything changed"""
  ///         changed = False
  ///         for i in range(len(self.children)-1, -1, -1):
  ///             child = self.children[i]
  ///             if isinstance(child, Tree) and child.data in data_values:
  ///                 self.children[i:i+1] = child.children
  ///                 changed = True
  ///         return changed
  /// ```
  Object? expand_kids_by_data({
    List<Object?> data_values = const <Object?>[],
  }) =>
      getFunction("expand_kids_by_data").call(
        <Object?>[
          ...data_values,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## find_data
  ///
  /// ### python docstring
  ///
  /// Returns all nodes of the tree whose data equals the given data.
  ///
  /// ### python source
  /// ```py
  /// def find_data(self, data: str) -> 'Iterator[Tree[_Leaf_T]]':
  ///         """Returns all nodes of the tree whose data equals the given data."""
  ///         return self.find_pred(lambda t: t.data == data)
  /// ```
  Object? find_data({
    required String data,
  }) =>
      getFunction("find_data").call(
        <Object?>[
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## find_pred
  ///
  /// ### python docstring
  ///
  /// Returns all nodes of the tree that evaluate pred(node) as true.
  ///
  /// ### python source
  /// ```py
  /// def find_pred(self, pred: 'Callable[[Tree[_Leaf_T]], bool]') -> 'Iterator[Tree[_Leaf_T]]':
  ///         """Returns all nodes of the tree that evaluate pred(node) as true."""
  ///         return filter(pred, self.iter_subtrees())
  /// ```
  Object? find_pred({
    required Object? pred,
  }) =>
      getFunction("find_pred").call(
        <Object?>[
          pred,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## iter_subtrees
  ///
  /// ### python docstring
  ///
  /// Depth-first iteration.
  ///
  /// Iterates over all the subtrees, never returning to the same node twice (Lark's parse-tree is actually a DAG).
  ///
  /// ### python source
  /// ```py
  /// def iter_subtrees(self) -> 'Iterator[Tree[_Leaf_T]]':
  ///         """Depth-first iteration.
  ///
  ///         Iterates over all the subtrees, never returning to the same node twice (Lark's parse-tree is actually a DAG).
  ///         """
  ///         queue = [self]
  ///         subtrees = OrderedDict()
  ///         for subtree in queue:
  ///             subtrees[id(subtree)] = subtree
  ///             # Reason for type ignore https://github.com/python/mypy/issues/10999
  ///             queue += [c for c in reversed(subtree.children)  # type: ignore[misc]
  ///                       if isinstance(c, Tree) and id(c) not in subtrees]
  ///
  ///         del queue
  ///         return reversed(list(subtrees.values()))
  /// ```
  Object? iter_subtrees() => getFunction("iter_subtrees").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## iter_subtrees_topdown
  ///
  /// ### python docstring
  ///
  /// Breadth-first iteration.
  ///
  /// Iterates over all the subtrees, return nodes in order like pretty() does.
  ///
  /// ### python source
  /// ```py
  /// def iter_subtrees_topdown(self):
  ///         """Breadth-first iteration.
  ///
  ///         Iterates over all the subtrees, return nodes in order like pretty() does.
  ///         """
  ///         stack = [self]
  ///         stack_append = stack.append
  ///         stack_pop = stack.pop
  ///         while stack:
  ///             node = stack_pop()
  ///             if not isinstance(node, Tree):
  ///                 continue
  ///             yield node
  ///             for child in reversed(node.children):
  ///                 stack_append(child)
  /// ```
  Object? iter_subtrees_topdown() => getFunction("iter_subtrees_topdown").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## pretty
  ///
  /// ### python docstring
  ///
  /// Returns an indented string representation of the tree.
  ///
  /// Great for debugging.
  ///
  /// ### python source
  /// ```py
  /// def pretty(self, indent_str: str='  ') -> str:
  ///         """Returns an indented string representation of the tree.
  ///
  ///         Great for debugging.
  ///         """
  ///         return ''.join(self._pretty(0, indent_str))
  /// ```
  String pretty({
    String indent_str = "  ",
  }) =>
      getFunction("pretty").call(
        <Object?>[
          indent_str,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## scan_values
  ///
  /// ### python docstring
  ///
  /// Return all values in the tree that evaluate pred(value) as true.
  ///
  /// This can be used to find all the tokens in the tree.
  ///
  /// Example:
  ///     >>> all_tokens = tree.scan_values(lambda v: isinstance(v, Token))
  ///
  /// ### python source
  /// ```py
  /// def scan_values(self, pred: 'Callable[[Branch[_Leaf_T]], bool]') -> Iterator[_Leaf_T]:
  ///         """Return all values in the tree that evaluate pred(value) as true.
  ///
  ///         This can be used to find all the tokens in the tree.
  ///
  ///         Example:
  ///             >>> all_tokens = tree.scan_values(lambda v: isinstance(v, Token))
  ///         """
  ///         for c in self.children:
  ///             if isinstance(c, Tree):
  ///                 for t in c.scan_values(pred):
  ///                     yield t
  ///             else:
  ///                 if pred(c):
  ///                     yield c
  /// ```
  Iterator<Object?> scan_values({
    required Object? pred,
  }) =>
      TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("scan_values").call(
            <Object?>[
              pred,
            ],
            kwargs: <String, Object?>{},
          ),
        ),
      ).transform((e) => e).cast<Object?>();

  /// ## set
  ///
  /// ### python source
  /// ```py
  /// def set(self, data: str, children: 'List[Branch[_Leaf_T]]') -> None:
  ///         self.data = data
  ///         self.children = children
  /// ```
  Null $set({
    required String data,
    required Object? children,
  }) =>
      getFunction("set").call(
        <Object?>[
          data,
          children,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## meta (getter)
  ///
  /// ### python docstring
  ///
  /// The main tree class.
  ///
  /// Creates a new tree, and stores "data" and "children" in attributes of the same name.
  /// Trees can be hashed and compared.
  ///
  /// Parameters:
  ///     data: The name of the rule or alias
  ///     children: List of matched sub-rules and terminals
  ///     meta: Line & Column numbers (if ``propagate_positions`` is enabled).
  ///         meta attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         container_* attributes consider all symbols, including those that have been inlined in the tree.
  ///         For example, in the rule 'a: _A B _C', the regular attributes will mark the start and end of B,
  ///         but the container_* attributes will also include _A and _C in the range. However, rules that
  ///         contain 'a' will consider it in full, including _A and _C for all attributes.
  Object? get meta => getAttribute("meta");

  /// ## meta (setter)
  ///
  /// ### python docstring
  ///
  /// The main tree class.
  ///
  /// Creates a new tree, and stores "data" and "children" in attributes of the same name.
  /// Trees can be hashed and compared.
  ///
  /// Parameters:
  ///     data: The name of the rule or alias
  ///     children: List of matched sub-rules and terminals
  ///     meta: Line & Column numbers (if ``propagate_positions`` is enabled).
  ///         meta attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         container_* attributes consider all symbols, including those that have been inlined in the tree.
  ///         For example, in the rule 'a: _A B _C', the regular attributes will mark the start and end of B,
  ///         but the container_* attributes will also include _A and _C in the range. However, rules that
  ///         contain 'a' will consider it in full, including _A and _C for all attributes.
  set meta(Object? meta) => setAttribute("meta", meta);

  /// ## data (getter)
  ///
  /// ### python docstring
  ///
  /// The main tree class.
  ///
  /// Creates a new tree, and stores "data" and "children" in attributes of the same name.
  /// Trees can be hashed and compared.
  ///
  /// Parameters:
  ///     data: The name of the rule or alias
  ///     children: List of matched sub-rules and terminals
  ///     meta: Line & Column numbers (if ``propagate_positions`` is enabled).
  ///         meta attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         container_* attributes consider all symbols, including those that have been inlined in the tree.
  ///         For example, in the rule 'a: _A B _C', the regular attributes will mark the start and end of B,
  ///         but the container_* attributes will also include _A and _C in the range. However, rules that
  ///         contain 'a' will consider it in full, including _A and _C for all attributes.
  Object? get data => getAttribute("data");

  /// ## data (setter)
  ///
  /// ### python docstring
  ///
  /// The main tree class.
  ///
  /// Creates a new tree, and stores "data" and "children" in attributes of the same name.
  /// Trees can be hashed and compared.
  ///
  /// Parameters:
  ///     data: The name of the rule or alias
  ///     children: List of matched sub-rules and terminals
  ///     meta: Line & Column numbers (if ``propagate_positions`` is enabled).
  ///         meta attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         container_* attributes consider all symbols, including those that have been inlined in the tree.
  ///         For example, in the rule 'a: _A B _C', the regular attributes will mark the start and end of B,
  ///         but the container_* attributes will also include _A and _C in the range. However, rules that
  ///         contain 'a' will consider it in full, including _A and _C for all attributes.
  set data(Object? data) => setAttribute("data", data);

  /// ## children (getter)
  ///
  /// ### python docstring
  ///
  /// The main tree class.
  ///
  /// Creates a new tree, and stores "data" and "children" in attributes of the same name.
  /// Trees can be hashed and compared.
  ///
  /// Parameters:
  ///     data: The name of the rule or alias
  ///     children: List of matched sub-rules and terminals
  ///     meta: Line & Column numbers (if ``propagate_positions`` is enabled).
  ///         meta attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         container_* attributes consider all symbols, including those that have been inlined in the tree.
  ///         For example, in the rule 'a: _A B _C', the regular attributes will mark the start and end of B,
  ///         but the container_* attributes will also include _A and _C in the range. However, rules that
  ///         contain 'a' will consider it in full, including _A and _C for all attributes.
  Object? get children => getAttribute("children");

  /// ## children (setter)
  ///
  /// ### python docstring
  ///
  /// The main tree class.
  ///
  /// Creates a new tree, and stores "data" and "children" in attributes of the same name.
  /// Trees can be hashed and compared.
  ///
  /// Parameters:
  ///     data: The name of the rule or alias
  ///     children: List of matched sub-rules and terminals
  ///     meta: Line & Column numbers (if ``propagate_positions`` is enabled).
  ///         meta attributes: (line, column, end_line, end_column, start_pos, end_pos,
  ///                           container_line, container_column, container_end_line, container_end_column)
  ///         container_* attributes consider all symbols, including those that have been inlined in the tree.
  ///         For example, in the rule 'a: _A B _C', the regular attributes will mark the start and end of B,
  ///         but the container_* attributes will also include _A and _C in the range. However, rules that
  ///         contain 'a' will consider it in full, including _A and _C for all attributes.
  set children(Object? children) => setAttribute("children", children);
}

/// ## FJ_parser
///
/// ### python source
/// ```py
/// from lark import Lark
/// from lark import Transformer
/// import FJ_AST as FJ
///
///
/// class ParseException(Exception):
///     pass
///
///
/// featherweight_java_parser = Lark(r"""
///
///     %import common.WS
///     %ignore WS
///
///
///
///     char : "a".."z" | "A".."Z"
///
///     identifier : char+
///
///
///
///     type : fjobject | fjclass
///
///     fjobject : "Object"
///
///     fjclass : identifier
///
///
///
///     expression : "(" expression ")" | cast | variable | method_lookup | field_lookup | new_class
///
///     variable : identifier
///
///     method_lookup : expression "." identifier "(" expression_list ")"
///
///     field_lookup : expression "." identifier
///
///     new_class : "new" type "(" expression_list ")"
///
///     cast : "(" type ")" expression
///
///
///
///     fieldenv : (fieldenv_helper ";")*
///
///     varenv : (varenv_helper ("," varenv_helper)*)?
///
///
///
///     method_def : type " " identifier "(" varenv ")" "{" "return" expression  \
///                  ";" "}"
///
///     class_def : "class" identifier "extends" type "{" fieldenv constructor? \
///                 method_list "}"
///
///     class_def_list : class_def*
///
///     program : class_def_list (" " | "\n") expression
///
///
///
///     fieldenv_helper : type " " identifier
///
///     varenv_helper : type " " identifier
///
///
///
///     expression_list : (expression ("," expression)*)?
///
///     method_list : method_def*
///
///
///
///     with_error_warnings : program
///
///
///
///     constructor : type "(" (type " " identifier ("," type " " identifier)*)? \
///         ")" "{" "super(" (identifier ("," identifier)*)? ");" ("this." \
///         identifier "=" identifier ";")* "}"
///     """, start=["char", "identifier", "type", "fjobject", "fjclass",
///                 "expression", "variable", "field_lookup", "method_lookup",
///                 "new_class", "cast", "fieldenv", "varenv", "method_def",
///                 "class_def", "program", "fieldenv_helper", "varenv_helper",
///                 "expression_list", "method_list", "with_error_warnings"]
///     )
///
///
/// class TreeToFJ(Transformer):
///
///     # Handling unallowed synatx
///
///     errors: list[str] = list()
///     keywords: list[str] = ["Object", "class", "extends", "return",
///                            "new"]
///     not_for_fields: list[str] = ["this", "super"]
///
///     def check_if_keyword(self, string: str):
///         if string in self.keywords:
///             self.errors.append(f"Using a keyword as identifier: '{string}'")
///
///     def check_variable_name(self, string: str):
///         if string[0].isupper():
///             self.errors.append(f"Names of variables must begin with a\
///                                  lowercase: '{string}'")
///
///     def check_fields_or_methods(self, string: str):
///         if string in self.not_for_fields:
///             self.errors.append(f"'super' is not allowed to be a part of a method name ('{string}')")
///
///     def check_class_name(self, string: str):
///         if string[0].islower():
///             self.errors.append(f"Names of classes must begin with an \
///                                  uppercase: '{string}'")
///
///     def show_errors(self):
///         if self.errors != []:
///             error_msg = f"Found {len(self.errors)} Error(s):\n" + \
///                           "\n".join(self.errors)
///             # have to delete all error messages, because type(self.errors) is list and lists are mutable over different instances
///             # have to make that pretier...
///             while len(self.errors):
///                 self.errors.pop()
///             raise ParseException(error_msg)
///
///     ###########################
///
///     def char(self, char_tupled):
///         ((char,),) = char_tupled
///         return char
///
///     def identifier(self, list_of_chars):
///         identifier = "".join(list_of_chars)
///         self.check_if_keyword(identifier)
///         return identifier
///
///     def type(self, type_tupled):
///         (type,) = type_tupled
///         return type
///
///     def fjobject(self, _):
///         return FJ.FJObject()
///
///     def fjclass(self, class_name_tupled):
///         (class_name,) = class_name_tupled
///         return FJ.FJClass(class_name)
///
///     def expression(self, expression_tupled):
///         (expression,) = expression_tupled
///         return expression
///
///     def variable(self, variable_tupled):
///         (variable,) = variable_tupled
///         self.check_variable_name(variable)
///         return FJ.Variable(variable)
///
///     def field_lookup(self, field_lookup):
///         expression, field = field_lookup
///         self.check_fields_or_methods(field)
///         return FJ.FieldLookup(expression, field)
///
///     def method_lookup(self, method_lookup):
///         expression, name, expressions = method_lookup
///         self.check_fields_or_methods(name)
///         return FJ.MethodLookup(expression, name, expressions)
///
///     def new_class(self, new_class):
///         type, parameters = new_class
///         return FJ.NewClass(type, parameters)
///
///     def cast(self, cast):
///         type, expression = cast
///         return FJ.Cast(type, expression)
///
///     def fieldenv(self, fieldenv_tupled_list):
///         return dict(fieldenv_tupled_list)
///
///     def varenv(self, varenv_tupled_list):
///         return dict(varenv_tupled_list)
///
///     def method_def(self, method_def):
///         (return_type, name, types_and_parameters, body) = method_def
///         return FJ.MethodDef(name, return_type, types_and_parameters, body)
///
///     def class_def(self, class_def):
///         if len(class_def) == 4:
///             class_name, super_class, fieldenv, methods = class_def
///         else:
///             class_name, super_class, fieldenv, constructor, methods = class_def
///         self.check_class_name(class_name)
///         return FJ.ClassDef(class_name, super_class, fieldenv, methods)
///
///     def class_def_list(self, class_def_list):
///         return dict([(x.class_name, x) for x in class_def_list])
///
///     def program(self, class_table_and_expression):
///         (class_table, expression) = class_table_and_expression
///         return FJ.Program(class_table, expression)
///
///     def fieldenv_helper(self, typed_identifier):
///         type, identifier = typed_identifier
///         return identifier, type
///
///     def varenv_helper(self, typed_variable):
///         (type, variable) = typed_variable
///         return variable, type
///
///     def expression_list(self, es):
///         return list(es)
///
///     def method_list(self, method_list):
///         return dict([(x.method_name, x) for x in method_list])
///
///     def with_error_warnings(self, program_tupled):
///         self.show_errors()
///         (program,) = program_tupled
///         return program
///
///
/// # Parsefunction
///
///
/// def fj_parse(source_code_txt: str, start_rule: str = "with_error_warnings") -> FJ.Program:
///     '''
///     Parses a given program source code textfile to a Featherweight Java program
///     ( A program is a pair of a classtable and an expression )
///     '''
///     tree = featherweight_java_parser.parse(source_code_txt, start_rule)
///     shaped_tree = TreeToFJ().transform(tree)
///     return shaped_tree
/// ```
final class FJ_parser extends PythonModule {
  FJ_parser.from(super.pythonModule) : super.from();

  static FJ_parser import() => PythonFfi.instance.importModule(
        "fj.FJ_parser",
        FJ_parser.from,
      );

  /// ## fj_parse
  ///
  /// ### python docstring
  ///
  /// Parses a given program source code textfile to a Featherweight Java program
  /// ( A program is a pair of a classtable and an expression )
  ///
  /// ### python source
  /// ```py
  /// def fj_parse(source_code_txt: str, start_rule: str = "with_error_warnings") -> FJ.Program:
  ///     '''
  ///     Parses a given program source code textfile to a Featherweight Java program
  ///     ( A program is a pair of a classtable and an expression )
  ///     '''
  ///     tree = featherweight_java_parser.parse(source_code_txt, start_rule)
  ///     shaped_tree = TreeToFJ().transform(tree)
  ///     return shaped_tree
  /// ```
  Program fj_parse({
    required String source_code_txt,
    String start_rule = "with_error_warnings",
  }) =>
      Program.from(
        getFunction("fj_parse").call(
          <Object?>[
            source_code_txt,
            start_rule,
          ],
          kwargs: <String, Object?>{},
        ),
      );

  /// ## FJ
  FJ get $FJ => FJ.import();

  /// ## featherweight_java_parser (getter)
  Object? get featherweight_java_parser =>
      getAttribute("featherweight_java_parser");

  /// ## featherweight_java_parser (setter)
  set featherweight_java_parser(Object? featherweight_java_parser) =>
      setAttribute("featherweight_java_parser", featherweight_java_parser);
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
