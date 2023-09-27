// ignore_for_file: non_constant_identifier_names, camel_case_types

part of ast;

/// Python class definition for the Python class `ASTNode`.
/// This is hand-crafted and not generated. Thus it only contains a subset of
/// the actual class.
final class AST extends PythonClass {
  /// Creates a new instance of the Python class `ASTNode`.
  factory AST() => PythonFfiDart.instance.importClass(
        "ast",
        "ASTNode",
        AST.from,
        <Object?>[],
        <String, Object?>{},
      );

  /// Wraps a Python object with the [AST] class definition.
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

  /// Returns all flattened children of type [FunctionDef].
  Iterable<FunctionDef> get functionDefs => _getTypedChildren(
        name: "FunctionDef",
        constructor: FunctionDef.from,
      );

  /// Returns all flattened children of type [Assign].
  Iterable<Assign> get assigns => _getTypedChildren(
        name: "Assign",
        constructor: Assign.from,
      );

  /// Returns all flattened children of type [AugAssign].
  Iterable<AugAssign> get augAssigns => _getTypedChildren(
        name: "AugAssign",
        constructor: AugAssign.from,
      );

  /// Returns all flattened children of type [AnnAssign].
  Iterable<AnnAssign> get annAssigns => _getTypedChildren(
        name: "AnnAssign",
        constructor: AnnAssign.from,
      );

  /// Returns all flattened children of any type of assignment.
  Iterable<AssignBase> get allAssigns sync* {
    yield* assigns;
    yield* augAssigns;
    yield* annAssigns;
  }
}

/// Python class definition for the Python class `FunctionDef`.
/// This is hand-crafted and not generated. Thus it only contains a subset of
/// the actual class.
final class FunctionDef extends AST {
  /// Creates a new instance of the Python class `FunctionDef`.
  factory FunctionDef() => PythonFfiDart.instance.importClass(
        "ast",
        "FunctionDef",
        FunctionDef.from,
        <Object?>[],
        <String, Object?>{},
      );

  /// Wraps a Python object with the [FunctionDef] class definition.
  FunctionDef.from(super.classDelegate) : super.from();

  /// Returns the name of the function.
  String get name => getAttribute("name");
}

/// A common interface for all assignment nodes.
abstract interface class AssignBase {
  /// Returns all attributes of this assignment.
  Iterable<Attribute> get attributes;
}

/// Python class definition for the Python class `Assign`.
/// This is hand-crafted and not generated. Thus it only contains a subset of
/// the actual class.
final class Assign extends AST implements AssignBase {
  /// Creates a new instance of the Python class `Assign`.
  factory Assign() => PythonFfiDart.instance.importClass(
        "ast",
        "Assign",
        Assign.from,
        <Object?>[],
        <String, Object?>{},
      );

  /// Wraps a Python object with the [Assign] class definition.
  Assign.from(super.classDelegate) : super.from();

  /// Returns all targets of this assignment.
  Iterable<AST> get targets => List<Object?>.from(
        getAttribute("targets"),
      )
          .cast<PythonClassInterface<PythonFfiDelegate<Object?>, Object?>>()
          .map(AST.from);

  @override
  Iterable<Attribute> get attributes => targets
      .where(_isOfType("Attribute"))
      .map((AST e) => Attribute.from(e._classDelegate));
}

/// Python class definition for the Python class `AugAssign`.
/// This is hand-crafted and not generated. Thus it only contains a subset of
/// the actual class.
final class AugAssign extends AST implements AssignBase {
  /// Creates a new instance of the Python class `AugAssign`.
  factory AugAssign() => PythonFfiDart.instance.importClass(
        "ast",
        "AugAssign",
        AugAssign.from,
        <Object?>[],
        <String, Object?>{},
      );

  /// Wraps a Python object with the [AugAssign] class definition.
  AugAssign.from(super.classDelegate) : super.from();

  /// Returns the target of this assignment.
  AST get target => AST.from(getAttribute("target"));

  @override
  Iterable<Attribute> get attributes => <AST>[target]
      .where(_isOfType("Attribute"))
      .map((AST e) => Attribute.from(e._classDelegate));
}

/// Python class definition for the Python class `AnnAssign`.
/// This is hand-crafted and not generated. Thus it only contains a subset of
/// the actual class.
final class AnnAssign extends AST implements AssignBase {
  /// Creates a new instance of the Python class `AnnAssign`.
  factory AnnAssign() => PythonFfiDart.instance.importClass(
        "ast",
        "AnnAssign",
        AnnAssign.from,
        <Object?>[],
        <String, Object?>{},
      );

  /// Wraps a Python object with the [AnnAssign] class definition.
  AnnAssign.from(super.classDelegate) : super.from();

  /// Returns the target of this assignment.
  AST get target => AST.from(getAttribute("target"));

  /// Returns the annotation of this assignment.
  AST get annotation => AST.from(getAttribute("annotation"));

  @override
  Iterable<Attribute> get attributes => <AST>[target]
      .where(_isOfType("Attribute"))
      .map((AST e) => Attribute.from(e._classDelegate));
}

/// Python class definition for the Python class `Attribute`.
/// This is hand-crafted and not generated. Thus it only contains a subset of
/// the actual class.
final class Attribute extends AST {
  /// Creates a new instance of the Python class `Attribute`.
  factory Attribute() => PythonFfiDart.instance.importClass(
        "ast",
        "Attribute",
        Attribute.from,
        <Object?>[],
        <String, Object?>{},
      );

  /// Wraps a Python object with the [Attribute] class definition.
  Attribute.from(super.classDelegate) : super.from();

  /// Returns the value of the attribute.
  AST get value => AST.from(getAttribute("value"));
}

/// Python module definition for the Python module `ast`.
/// This is hand-crafted and not generated. Thus it only contains a subset of
/// the actual module.
final class ast extends PythonModule {
  /// Wraps a Python object with the [ast] module definition.
  ast.from(super.moduleDelegate) : super.from();

  /// Primary constructor for this module.
  static ast import() => PythonFfiDart.instance.importModule("ast", ast.from);

  /// Parses a Python source string into an AST tree.
  AST parse(String source) =>
      AST.from(getFunction("parse").call(<Object?>[source]));

  /// Returns a flattened iterable of all the AST nodes in the tree.
  Iterator<AST> walk(AST node) => TypedIterator<
          PythonClassInterface<PythonFfiDelegate<Object?>, Object?>>.from(
        getFunction("walk").call(<Object?>[node]),
      ).transform(AST.from);
}
