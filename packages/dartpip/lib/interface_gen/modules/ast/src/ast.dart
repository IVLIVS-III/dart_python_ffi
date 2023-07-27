// ignore_for_file: non_constant_identifier_names

part of ast;

final class AST extends PythonClass {
  factory AST() =>
      PythonFfiDart.instance.importClass(
        "ast",
        "ASTNode",
        AST.from,
        <Object?>[],
        {},
      );

  AST.from(this._classDelegate) : super.from(_classDelegate);

  final PythonClassInterface _classDelegate;

  bool Function(AST) _isOfType(String name) =>
          (AST node) {
        final String className = (node as dynamic).__class__.__name__ as String;
        return className == name;
      };

  Iterable<T> _getTypedChildren<T extends AST>({
    required String name,
    required T Function(PythonClassInterface) constructor,
  }) sync* {
    final Iterator<AST> nodes = ast.import().walk(this);
    final bool Function(AST) isOfType = _isOfType(name);
    while (nodes.moveNext()) {
      final AST node = nodes.current;
      if (isOfType(node)) {
        yield constructor(node._classDelegate);
      }
    }
  }

  Iterable<FunctionDef> get functionDefs =>
      _getTypedChildren(
        name: "FunctionDef",
        constructor: FunctionDef.from,
      );

  Iterable<Assign> get assigns =>
      _getTypedChildren(
        name: "Assign",
        constructor: Assign.from,
      );
}

final class FunctionDef extends AST {
  factory FunctionDef() =>
      PythonFfiDart.instance.importClass(
        "ast",
        "FunctionDef",
        FunctionDef.from,
        <Object?>[],
        {},
      );

  FunctionDef.from(super.classDelegate) : super.from();

  String get name => getAttribute("name");
}

final class Assign extends AST {
  factory Assign() =>
      PythonFfiDart.instance.importClass(
        "ast",
        "Assign",
        Assign.from,
        <Object?>[],
        {},
      );

  Assign.from(super.classDelegate) : super.from();

  Iterable<AST> get targets =>
      List<Object?>.from(
        getAttribute("targets"),
      ).cast<PythonClassInterface>().map(AST.from);

  Iterable<Attribute> get attributes =>
      targets
          .where(_isOfType("Attribute"))
          .map((AST e) => Attribute.from(e._classDelegate));
}

final class Attribute extends AST {
  factory Attribute() =>
      PythonFfiDart.instance.importClass(
        "ast",
        "Attribute",
        Attribute.from,
        <Object?>[],
        {},
      );

  Attribute.from(super.classDelegate) : super.from();

  AST get value => AST.from(getAttribute("value"));
}

final class ast extends PythonModule {
  ast.from(super.moduleDelegate) : super.from();

  static ast import() => PythonFfiDart.instance.importModule("ast", ast.from);

  AST parse(String source) =>
      AST.from(getFunction("parse").call(<Object?>[source]));

  Iterator<AST> walk(AST node) =>
      TypedIterator<PythonClassInterface>.from(
        getFunction("walk").call(<Object?>[node]),
      ).transform(AST.from);
}
