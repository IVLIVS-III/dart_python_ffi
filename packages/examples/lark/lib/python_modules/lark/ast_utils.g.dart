// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library ast_utils;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## AsList
///
/// ### python docstring
///
/// Abstract class
///
/// Subclasses will be instantiated with the parse results as a single list, instead of as arguments.
///
/// ### python source
/// ```py
/// class AsList:
///     """Abstract class
///
///     Subclasses will be instantiated with the parse results as a single list, instead of as arguments.
///     """
/// ```
final class AsList extends PythonClass {
  factory AsList() => PythonFfiDart.instance.importClass(
        "lark.ast_utils",
        "AsList",
        AsList.from,
        <Object?>[],
      );

  AsList.from(super.pythonClass) : super.from();
}

/// ## Ast
///
/// ### python docstring
///
/// Abstract class
///
/// Subclasses will be collected by `create_transformer()`
///
/// ### python source
/// ```py
/// class Ast:
///     """Abstract class
///
///     Subclasses will be collected by `create_transformer()`
///     """
///     pass
/// ```
final class Ast extends PythonClass {
  factory Ast() => PythonFfiDart.instance.importClass(
        "lark.ast_utils",
        "Ast",
        Ast.from,
        <Object?>[],
      );

  Ast.from(super.pythonClass) : super.from();
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
      PythonFfiDart.instance.importClass(
        "lark.visitors",
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

/// ## WithMeta
///
/// ### python docstring
///
/// Abstract class
///
/// Subclasses will be instantiated with the Meta instance of the tree. (see ``v_args`` for more detail)
///
/// ### python source
/// ```py
/// class WithMeta:
///     """Abstract class
///
///     Subclasses will be instantiated with the Meta instance of the tree. (see ``v_args`` for more detail)
///     """
///     pass
/// ```
final class WithMeta extends PythonClass {
  factory WithMeta() => PythonFfiDart.instance.importClass(
        "lark.ast_utils",
        "WithMeta",
        WithMeta.from,
        <Object?>[],
      );

  WithMeta.from(super.pythonClass) : super.from();
}

/// ## ast_utils
///
/// ### python docstring
///
/// Module of utilities for transforming a lark.Tree into a custom Abstract Syntax Tree
///
/// ### python source
/// ```py
/// """
///     Module of utilities for transforming a lark.Tree into a custom Abstract Syntax Tree
/// """
///
/// import inspect, re
/// import types
/// from typing import Optional, Callable
///
/// from lark import Transformer, v_args
///
/// class Ast:
///     """Abstract class
///
///     Subclasses will be collected by `create_transformer()`
///     """
///     pass
///
/// class AsList:
///     """Abstract class
///
///     Subclasses will be instantiated with the parse results as a single list, instead of as arguments.
///     """
///
/// class WithMeta:
///     """Abstract class
///
///     Subclasses will be instantiated with the Meta instance of the tree. (see ``v_args`` for more detail)
///     """
///     pass
///
/// def camel_to_snake(name):
///     return re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()
///
/// def create_transformer(ast_module: types.ModuleType,
///                        transformer: Optional[Transformer]=None,
///                        decorator_factory: Callable=v_args) -> Transformer:
///     """Collects `Ast` subclasses from the given module, and creates a Lark transformer that builds the AST.
///
///     For each class, we create a corresponding rule in the transformer, with a matching name.
///     CamelCase names will be converted into snake_case. Example: "CodeBlock" -> "code_block".
///
///     Classes starting with an underscore (`_`) will be skipped.
///
///     Parameters:
///         ast_module: A Python module containing all the subclasses of ``ast_utils.Ast``
///         transformer (Optional[Transformer]): An initial transformer. Its attributes may be overwritten.
///         decorator_factory (Callable): An optional callable accepting two booleans, inline, and meta,
///             and returning a decorator for the methods of ``transformer``. (default: ``v_args``).
///     """
///     t = transformer or Transformer()
///
///     for name, obj in inspect.getmembers(ast_module):
///         if not name.startswith('_') and inspect.isclass(obj):
///             if issubclass(obj, Ast):
///                 wrapper = decorator_factory(inline=not issubclass(obj, AsList), meta=issubclass(obj, WithMeta))
///                 obj = wrapper(obj).__get__(t)
///                 setattr(t, camel_to_snake(name), obj)
///
///     return t
/// ```
final class ast_utils extends PythonModule {
  ast_utils.from(super.pythonModule) : super.from();

  static ast_utils import() => PythonFfiDart.instance.importModule(
        "lark.ast_utils",
        ast_utils.from,
      );

  /// ## camel_to_snake
  ///
  /// ### python source
  /// ```py
  /// def camel_to_snake(name):
  ///     return re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()
  /// ```
  Object? camel_to_snake({
    required Object? name,
  }) =>
      getFunction("camel_to_snake").call(
        <Object?>[
          name,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## create_transformer
  ///
  /// ### python docstring
  ///
  /// Collects `Ast` subclasses from the given module, and creates a Lark transformer that builds the AST.
  ///
  /// For each class, we create a corresponding rule in the transformer, with a matching name.
  /// CamelCase names will be converted into snake_case. Example: "CodeBlock" -> "code_block".
  ///
  /// Classes starting with an underscore (`_`) will be skipped.
  ///
  /// Parameters:
  ///     ast_module: A Python module containing all the subclasses of ``ast_utils.Ast``
  ///     transformer (Optional[Transformer]): An initial transformer. Its attributes may be overwritten.
  ///     decorator_factory (Callable): An optional callable accepting two booleans, inline, and meta,
  ///         and returning a decorator for the methods of ``transformer``. (default: ``v_args``).
  ///
  /// ### python source
  /// ```py
  /// def create_transformer(ast_module: types.ModuleType,
  ///                        transformer: Optional[Transformer]=None,
  ///                        decorator_factory: Callable=v_args) -> Transformer:
  ///     """Collects `Ast` subclasses from the given module, and creates a Lark transformer that builds the AST.
  ///
  ///     For each class, we create a corresponding rule in the transformer, with a matching name.
  ///     CamelCase names will be converted into snake_case. Example: "CodeBlock" -> "code_block".
  ///
  ///     Classes starting with an underscore (`_`) will be skipped.
  ///
  ///     Parameters:
  ///         ast_module: A Python module containing all the subclasses of ``ast_utils.Ast``
  ///         transformer (Optional[Transformer]): An initial transformer. Its attributes may be overwritten.
  ///         decorator_factory (Callable): An optional callable accepting two booleans, inline, and meta,
  ///             and returning a decorator for the methods of ``transformer``. (default: ``v_args``).
  ///     """
  ///     t = transformer or Transformer()
  ///
  ///     for name, obj in inspect.getmembers(ast_module):
  ///         if not name.startswith('_') and inspect.isclass(obj):
  ///             if issubclass(obj, Ast):
  ///                 wrapper = decorator_factory(inline=not issubclass(obj, AsList), meta=issubclass(obj, WithMeta))
  ///                 obj = wrapper(obj).__get__(t)
  ///                 setattr(t, camel_to_snake(name), obj)
  ///
  ///     return t
  /// ```
  Transformer create_transformer({
    required Object? ast_module,
    Object? transformer,
    Function decorator_factory,
  }) =>
      Transformer.from(
        getFunction("create_transformer").call(
          <Object?>[
            ast_module,
            transformer,
            decorator_factory,
          ],
          kwargs: <String, Object?>{},
        ),
      );
}
