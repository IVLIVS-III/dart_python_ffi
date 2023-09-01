// ignore_for_file: non_constant_identifier_names, camel_case_types

part of ast;

/// TODO: Document.
final class AST extends PythonClass {
  /// TODO: Document.
  factory AST() => PythonFfiDart.instance.importClass(
        "ast",
        "ASTNode",
        AST.from,
        <Object?>[],
        <String, Object?>{},
      );

  /// TODO: Document.
  AST.from(this._classDelegate) : super.from(_classDelegate);

  final PythonClassInterface<PythonFfiDelegate<Object?>, Object?>
      _classDelegate;

  bool Function(AST) _isOfType(String name) => (AST node) {
        // ignore: avoid_dynamic_calls
        final String className = (node as dynamic).__class__.__name__ as String;
        return className == name;
      };

  Iterable<T> _getTypedChildren<T extends AST>({
    required String name,
    required T Function(
      PythonClassInterface<PythonFfiDelegate<Object?>, Object?>,
    ) constructor,
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

  /// TODO: Document.
  Iterable<FunctionDef> get functionDefs => _getTypedChildren(
        name: "FunctionDef",
        constructor: FunctionDef.from,
      );

  /// TODO: Document.
  Iterable<Assign> get assigns => _getTypedChildren(
        name: "Assign",
        constructor: Assign.from,
      );

  /// TODO: Document.
  Iterable<AugAssign> get augAssigns => _getTypedChildren(
        name: "AugAssign",
        constructor: AugAssign.from,
      );

  /// TODO: Document.
  Iterable<AnnAssign> get annAssigns => _getTypedChildren(
        name: "AnnAssign",
        constructor: AnnAssign.from,
      );

  /// TODO: Document.
  Iterable<AssignBase> get allAssigns sync* {
    yield* assigns;
    yield* augAssigns;
    yield* annAssigns;
  }
}

/// TODO: Document.
final class FunctionDef extends AST {
  /// TODO: Document.
  factory FunctionDef() => PythonFfiDart.instance.importClass(
        "ast",
        "FunctionDef",
        FunctionDef.from,
        <Object?>[],
        <String, Object?>{},
      );

  /// TODO: Document.
  FunctionDef.from(super.classDelegate) : super.from();

  /// TODO: Document.
  String get name => getAttribute("name");
}

/// TODO: Document.
abstract interface class AssignBase {
  /// TODO: Document.
  Iterable<Attribute> get attributes;
}

/// TODO: Document.
final class Assign extends AST implements AssignBase {
  /// TODO: Document.
  factory Assign() => PythonFfiDart.instance.importClass(
        "ast",
        "Assign",
        Assign.from,
        <Object?>[],
        <String, Object?>{},
      );

  /// TODO: Document.
  Assign.from(super.classDelegate) : super.from();

  /// TODO: Document.
  Iterable<AST> get targets => List<Object?>.from(
        getAttribute("targets"),
      )
          .cast<PythonClassInterface<PythonFfiDelegate<Object?>, Object?>>()
          .map(AST.from);

  /// TODO: Document.
  @override
  Iterable<Attribute> get attributes => targets
      .where(_isOfType("Attribute"))
      .map((AST e) => Attribute.from(e._classDelegate));
}

/// TODO: Document.
final class AugAssign extends AST implements AssignBase {
  /// TODO: Document.
  factory AugAssign() => PythonFfiDart.instance.importClass(
        "ast",
        "AugAssign",
        AugAssign.from,
        <Object?>[],
        <String, Object?>{},
      );

  /// TODO: Document.
  AugAssign.from(super.classDelegate) : super.from();

  /// TODO: Document.
  AST get target => AST.from(getAttribute("target"));

  /// TODO: Document.
  @override
  Iterable<Attribute> get attributes => <AST>[target]
      .where(_isOfType("Attribute"))
      .map((AST e) => Attribute.from(e._classDelegate));
}

/// TODO: Document.
final class AnnAssign extends AST implements AssignBase {
  /// TODO: Document.
  factory AnnAssign() => PythonFfiDart.instance.importClass(
        "ast",
        "AnnAssign",
        AnnAssign.from,
        <Object?>[],
        <String, Object?>{},
      );

  /// TODO: Document.
  AnnAssign.from(super.classDelegate) : super.from();

  /// TODO: Document.
  AST get target => AST.from(getAttribute("target"));

  /// TODO: Document.
  AST get annotation => AST.from(getAttribute("annotation"));

  /// TODO: Document.
  @override
  Iterable<Attribute> get attributes => <AST>[target]
      .where(_isOfType("Attribute"))
      .map((AST e) => Attribute.from(e._classDelegate));
}

/// TODO: Document.
final class Attribute extends AST {
  /// TODO: Document.
  factory Attribute() => PythonFfiDart.instance.importClass(
        "ast",
        "Attribute",
        Attribute.from,
        <Object?>[],
        <String, Object?>{},
      );

  /// TODO: Document.
  Attribute.from(super.classDelegate) : super.from();

  /// TODO: Document.
  AST get value => AST.from(getAttribute("value"));
}

/// TODO: Document.
final class ast extends PythonModule {
  /// TODO: Document.
  ast.from(super.moduleDelegate) : super.from();

  /// TODO: Document.
  static ast import() => PythonFfiDart.instance.importModule("ast", ast.from);

  /// TODO: Document.
  AST parse(String source) =>
      AST.from(getFunction("parse").call(<Object?>[source]));

  /// TODO: Document.
  Iterator<AST> walk(AST node) => TypedIterator<
          PythonClassInterface<PythonFfiDelegate<Object?>, Object?>>.from(
        getFunction("walk").call(<Object?>[node]),
      ).transform(AST.from);
}
