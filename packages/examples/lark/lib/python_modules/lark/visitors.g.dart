// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library visitors;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## CollapseAmbiguities
///
/// ### python docstring
///
/// Transforms a tree that contains any number of _ambig nodes into a list of trees,
/// each one containing an unambiguous tree.
///
/// The length of the resulting list is the product of the length of all _ambig nodes.
///
/// Warning: This may quickly explode for highly ambiguous trees.
///
/// ### python source
/// ```py
/// class CollapseAmbiguities(Transformer):
///     """
///     Transforms a tree that contains any number of _ambig nodes into a list of trees,
///     each one containing an unambiguous tree.
///
///     The length of the resulting list is the product of the length of all _ambig nodes.
///
///     Warning: This may quickly explode for highly ambiguous trees.
///
///     """
///     def _ambig(self, options):
///         return sum(options, [])
///
///     def __default__(self, data, children_lists, meta):
///         return [Tree(data, children, meta) for children in combine_alternatives(children_lists)]
///
///     def __default_token__(self, t):
///         return [t]
/// ```
final class CollapseAmbiguities extends PythonClass {
  factory CollapseAmbiguities({
    bool visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.visitors",
        "CollapseAmbiguities",
        CollapseAmbiguities.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  CollapseAmbiguities.from(super.pythonClass) : super.from();

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

/// ## GrammarError
///
/// ### python source
/// ```py
/// class GrammarError(LarkError):
///     pass
/// ```
final class GrammarError extends PythonClass {
  factory GrammarError() => PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "GrammarError",
        GrammarError.from,
        <Object?>[],
      );

  GrammarError.from(super.pythonClass) : super.from();

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

/// ## InlineTransformer
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
/// class InlineTransformer(Transformer):   # XXX Deprecated
///     def _call_userfunc(self, tree, new_children=None):
///         # Assumes tree is already transformed
///         children = new_children if new_children is not None else tree.children
///         try:
///             f = getattr(self, tree.data)
///         except AttributeError:
///             return self.__default__(tree.data, children, tree.meta)
///         else:
///             return f(*children)
/// ```
final class InlineTransformer extends PythonClass {
  factory InlineTransformer({
    bool visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.visitors",
        "InlineTransformer",
        InlineTransformer.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  InlineTransformer.from(super.pythonClass) : super.from();

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

/// ## Interpreter
///
/// ### python docstring
///
/// Interpreter walks the tree starting at the root.
///
/// Visits the tree, starting with the root and finally the leaves (top-down)
///
/// For each tree node, it calls its methods (provided by user via inheritance) according to ``tree.data``.
///
/// Unlike ``Transformer`` and ``Visitor``, the Interpreter doesn't automatically visit its sub-branches.
/// The user has to explicitly call ``visit``, ``visit_children``, or use the ``@visit_children_decor``.
/// This allows the user to implement branching and loops.
///
/// ### python source
/// ```py
/// class Interpreter(_Decoratable, ABC, Generic[_Leaf_T, _Return_T]):
///     """Interpreter walks the tree starting at the root.
///
///     Visits the tree, starting with the root and finally the leaves (top-down)
///
///     For each tree node, it calls its methods (provided by user via inheritance) according to ``tree.data``.
///
///     Unlike ``Transformer`` and ``Visitor``, the Interpreter doesn't automatically visit its sub-branches.
///     The user has to explicitly call ``visit``, ``visit_children``, or use the ``@visit_children_decor``.
///     This allows the user to implement branching and loops.
///     """
///
///     def visit(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         # There are no guarantees on the type of the value produced by calling a user func for a
///         # child will produce. So only annotate the public method and use an internal method when
///         # visiting child trees.
///         return self._visit_tree(tree)
///
///     def _visit_tree(self, tree: Tree[_Leaf_T]):
///         f = getattr(self, tree.data)
///         wrapper = getattr(f, 'visit_wrapper', None)
///         if wrapper is not None:
///             return f.visit_wrapper(f, tree.data, tree.children, tree.meta)
///         else:
///             return f(tree)
///
///     def visit_children(self, tree: Tree[_Leaf_T]) -> List:
///         return [self._visit_tree(child) if isinstance(child, Tree) else child
///                 for child in tree.children]
///
///     def __getattr__(self, name):
///         return self.__default__
///
///     def __default__(self, tree):
///         return self.visit_children(tree)
/// ```
final class Interpreter extends PythonClass {
  factory Interpreter() => PythonFfiDart.instance.importClass(
        "lark.visitors",
        "Interpreter",
        Interpreter.from,
        <Object?>[],
      );

  Interpreter.from(super.pythonClass) : super.from();

  /// ## visit
  ///
  /// ### python source
  /// ```py
  /// def visit(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         # There are no guarantees on the type of the value produced by calling a user func for a
  ///         # child will produce. So only annotate the public method and use an internal method when
  ///         # visiting child trees.
  ///         return self._visit_tree(tree)
  /// ```
  Object? visit({
    required Object? tree,
  }) =>
      getFunction("visit").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_children
  ///
  /// ### python source
  /// ```py
  /// def visit_children(self, tree: Tree[_Leaf_T]) -> List:
  ///         return [self._visit_tree(child) if isinstance(child, Tree) else child
  ///                 for child in tree.children]
  /// ```
  Object? visit_children({
    required Object? tree,
  }) =>
      getFunction("visit_children").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## Token
///
/// ### python docstring
///
/// A string with meta-information, that is produced by the lexer.
///
/// When parsing text, the resulting chunks of the input that haven't been discarded,
/// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
/// so normal string comparisons and operations will work as expected.
///
/// Attributes:
///     type: Name of the token (as specified in grammar)
///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
///     start_pos: The index of the token in the text
///     line: The line of the token in the text (starting with 1)
///     column: The column of the token in the text (starting with 1)
///     end_line: The line where the token ends
///     end_column: The next column after the end of the token. For example,
///         if the token is a single character with a column value of 4,
///         end_column will be 5.
///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
///
/// ### python source
/// ```py
/// class Token(str):
///     """A string with meta-information, that is produced by the lexer.
///
///     When parsing text, the resulting chunks of the input that haven't been discarded,
///     will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
///     so normal string comparisons and operations will work as expected.
///
///     Attributes:
///         type: Name of the token (as specified in grammar)
///         value: Value of the token (redundant, as ``token.value == token`` will always be true)
///         start_pos: The index of the token in the text
///         line: The line of the token in the text (starting with 1)
///         column: The column of the token in the text (starting with 1)
///         end_line: The line where the token ends
///         end_column: The next column after the end of the token. For example,
///             if the token is a single character with a column value of 4,
///             end_column will be 5.
///         end_pos: the index where the token ends (basically ``start_pos + len(token)``)
///     """
///     __slots__ = ('type', 'start_pos', 'value', 'line', 'column', 'end_line', 'end_column', 'end_pos')
///
///     __match_args__ = ('type', 'value')
///
///     type: str
///     start_pos: Optional[int]
///     value: Any
///     line: Optional[int]
///     column: Optional[int]
///     end_line: Optional[int]
///     end_column: Optional[int]
///     end_pos: Optional[int]
///
///
///     @overload
///     def __new__(
///             cls,
///             type: str,
///             value: Any,
///             start_pos: Optional[int] = None,
///             line: Optional[int] = None,
///             column: Optional[int] = None,
///             end_line: Optional[int] = None,
///             end_column: Optional[int] = None,
///             end_pos: Optional[int] = None
///     ) -> 'Token':
///         ...
///
///     @overload
///     def __new__(
///             cls,
///             type_: str,
///             value: Any,
///             start_pos: Optional[int] = None,
///             line: Optional[int] = None,
///             column: Optional[int] = None,
///             end_line: Optional[int] = None,
///             end_column: Optional[int] = None,
///             end_pos: Optional[int] = None
///     ) -> 'Token':        ...
///
///     def __new__(cls, *args, **kwargs):
///         if "type_" in kwargs:
///             warnings.warn("`type_` is deprecated use `type` instead", DeprecationWarning)
///
///             if "type" in kwargs:
///                 raise TypeError("Error: using both 'type' and the deprecated 'type_' as arguments.")
///             kwargs["type"] = kwargs.pop("type_")
///
///         return cls._future_new(*args, **kwargs)
///
///
///     @classmethod
///     def _future_new(cls, type, value, start_pos=None, line=None, column=None, end_line=None, end_column=None, end_pos=None):
///         inst = super(Token, cls).__new__(cls, value)
///
///         inst.type = type
///         inst.start_pos = start_pos
///         inst.value = value
///         inst.line = line
///         inst.column = column
///         inst.end_line = end_line
///         inst.end_column = end_column
///         inst.end_pos = end_pos
///         return inst
///
///     @overload
///     def update(self, type: Optional[str] = None, value: Optional[Any] = None) -> 'Token':
///         ...
///
///     @overload
///     def update(self, type_: Optional[str] = None, value: Optional[Any] = None) -> 'Token':
///         ...
///
///     def update(self, *args, **kwargs):
///         if "type_" in kwargs:
///             warnings.warn("`type_` is deprecated use `type` instead", DeprecationWarning)
///
///             if "type" in kwargs:
///                 raise TypeError("Error: using both 'type' and the deprecated 'type_' as arguments.")
///             kwargs["type"] = kwargs.pop("type_")
///
///         return self._future_update(*args, **kwargs)
///
///     def _future_update(self, type: Optional[str] = None, value: Optional[Any] = None) -> 'Token':
///         return Token.new_borrow_pos(
///             type if type is not None else self.type,
///             value if value is not None else self.value,
///             self
///         )
///
///     @classmethod
///     def new_borrow_pos(cls: Type[_T], type_: str, value: Any, borrow_t: 'Token') -> _T:
///         return cls(type_, value, borrow_t.start_pos, borrow_t.line, borrow_t.column, borrow_t.end_line, borrow_t.end_column, borrow_t.end_pos)
///
///     def __reduce__(self):
///         return (self.__class__, (self.type, self.value, self.start_pos, self.line, self.column))
///
///     def __repr__(self):
///         return 'Token(%r, %r)' % (self.type, self.value)
///
///     def __deepcopy__(self, memo):
///         return Token(self.type, self.value, self.start_pos, self.line, self.column)
///
///     def __eq__(self, other):
///         if isinstance(other, Token) and self.type != other.type:
///             return False
///
///         return str.__eq__(self, other)
///
///     __hash__ = str.__hash__
/// ```
final class Token extends PythonClass {
  factory Token() => PythonFfiDart.instance.importClass(
        "lark.lexer",
        "Token",
        Token.from,
        <Object?>[],
      );

  Token.from(super.pythonClass) : super.from();

  /// ## update
  ///
  /// ### python source
  /// ```py
  /// def update(self, *args, **kwargs):
  ///         if "type_" in kwargs:
  ///             warnings.warn("`type_` is deprecated use `type` instead", DeprecationWarning)
  ///
  ///             if "type" in kwargs:
  ///                 raise TypeError("Error: using both 'type' and the deprecated 'type_' as arguments.")
  ///             kwargs["type"] = kwargs.pop("type_")
  ///
  ///         return self._future_update(*args, **kwargs)
  /// ```
  Object? update({
    List<Object?> args = const <Object?>[],
    Map<String, Object?> kwargs = const <String, Object?>{},
  }) =>
      getFunction("update").call(
        <Object?>[
          ...args,
        ],
        kwargs: <String, Object?>{
          ...kwargs,
        },
      );

  /// ## column (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get column => getAttribute("column");

  /// ## column (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set column(Object? column) => setAttribute("column", column);

  /// ## end_column (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get end_column => getAttribute("end_column");

  /// ## end_column (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set end_column(Object? end_column) => setAttribute("end_column", end_column);

  /// ## end_line (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get end_line => getAttribute("end_line");

  /// ## end_line (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set end_line(Object? end_line) => setAttribute("end_line", end_line);

  /// ## end_pos (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get end_pos => getAttribute("end_pos");

  /// ## end_pos (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set end_pos(Object? end_pos) => setAttribute("end_pos", end_pos);

  /// ## line (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get line => getAttribute("line");

  /// ## line (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set line(Object? line) => setAttribute("line", line);

  /// ## start_pos (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get start_pos => getAttribute("start_pos");

  /// ## start_pos (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set start_pos(Object? start_pos) => setAttribute("start_pos", start_pos);

  /// ## type (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get type => getAttribute("type");

  /// ## type (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set type(Object? type) => setAttribute("type", type);

  /// ## value (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get value => getAttribute("value");

  /// ## value (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set value(Object? value) => setAttribute("value", value);

  /// ## capitalize (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get capitalize => getAttribute("capitalize");

  /// ## capitalize (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set capitalize(Object? capitalize) => setAttribute("capitalize", capitalize);

  /// ## casefold (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get casefold => getAttribute("casefold");

  /// ## casefold (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set casefold(Object? casefold) => setAttribute("casefold", casefold);

  /// ## center (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get center => getAttribute("center");

  /// ## center (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set center(Object? center) => setAttribute("center", center);

  /// ## count (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get count => getAttribute("count");

  /// ## count (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set count(Object? count) => setAttribute("count", count);

  /// ## encode (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get encode => getAttribute("encode");

  /// ## encode (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set encode(Object? encode) => setAttribute("encode", encode);

  /// ## endswith (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get endswith => getAttribute("endswith");

  /// ## endswith (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set endswith(Object? endswith) => setAttribute("endswith", endswith);

  /// ## expandtabs (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get expandtabs => getAttribute("expandtabs");

  /// ## expandtabs (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set expandtabs(Object? expandtabs) => setAttribute("expandtabs", expandtabs);

  /// ## find (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get find => getAttribute("find");

  /// ## find (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set find(Object? find) => setAttribute("find", find);

  /// ## format (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get format => getAttribute("format");

  /// ## format (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set format(Object? format) => setAttribute("format", format);

  /// ## format_map (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get format_map => getAttribute("format_map");

  /// ## format_map (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set format_map(Object? format_map) => setAttribute("format_map", format_map);

  /// ## index (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get index => getAttribute("index");

  /// ## index (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set index(Object? index) => setAttribute("index", index);

  /// ## isalnum (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get isalnum => getAttribute("isalnum");

  /// ## isalnum (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set isalnum(Object? isalnum) => setAttribute("isalnum", isalnum);

  /// ## isalpha (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get isalpha => getAttribute("isalpha");

  /// ## isalpha (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set isalpha(Object? isalpha) => setAttribute("isalpha", isalpha);

  /// ## isascii (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get isascii => getAttribute("isascii");

  /// ## isascii (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set isascii(Object? isascii) => setAttribute("isascii", isascii);

  /// ## isdecimal (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get isdecimal => getAttribute("isdecimal");

  /// ## isdecimal (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set isdecimal(Object? isdecimal) => setAttribute("isdecimal", isdecimal);

  /// ## isdigit (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get isdigit => getAttribute("isdigit");

  /// ## isdigit (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set isdigit(Object? isdigit) => setAttribute("isdigit", isdigit);

  /// ## isidentifier (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get isidentifier => getAttribute("isidentifier");

  /// ## isidentifier (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set isidentifier(Object? isidentifier) =>
      setAttribute("isidentifier", isidentifier);

  /// ## islower (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get islower => getAttribute("islower");

  /// ## islower (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set islower(Object? islower) => setAttribute("islower", islower);

  /// ## isnumeric (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get isnumeric => getAttribute("isnumeric");

  /// ## isnumeric (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set isnumeric(Object? isnumeric) => setAttribute("isnumeric", isnumeric);

  /// ## isprintable (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get isprintable => getAttribute("isprintable");

  /// ## isprintable (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set isprintable(Object? isprintable) =>
      setAttribute("isprintable", isprintable);

  /// ## isspace (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get isspace => getAttribute("isspace");

  /// ## isspace (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set isspace(Object? isspace) => setAttribute("isspace", isspace);

  /// ## istitle (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get istitle => getAttribute("istitle");

  /// ## istitle (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set istitle(Object? istitle) => setAttribute("istitle", istitle);

  /// ## isupper (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get isupper => getAttribute("isupper");

  /// ## isupper (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set isupper(Object? isupper) => setAttribute("isupper", isupper);

  /// ## join (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get join => getAttribute("join");

  /// ## join (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set join(Object? join) => setAttribute("join", join);

  /// ## ljust (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get ljust => getAttribute("ljust");

  /// ## ljust (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set ljust(Object? ljust) => setAttribute("ljust", ljust);

  /// ## lower (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get lower => getAttribute("lower");

  /// ## lower (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set lower(Object? lower) => setAttribute("lower", lower);

  /// ## lstrip (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get lstrip => getAttribute("lstrip");

  /// ## lstrip (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set lstrip(Object? lstrip) => setAttribute("lstrip", lstrip);

  /// ## new_borrow_pos (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get new_borrow_pos => getAttribute("new_borrow_pos");

  /// ## new_borrow_pos (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set new_borrow_pos(Object? new_borrow_pos) =>
      setAttribute("new_borrow_pos", new_borrow_pos);

  /// ## partition (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get partition => getAttribute("partition");

  /// ## partition (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set partition(Object? partition) => setAttribute("partition", partition);

  /// ## removeprefix (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get removeprefix => getAttribute("removeprefix");

  /// ## removeprefix (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set removeprefix(Object? removeprefix) =>
      setAttribute("removeprefix", removeprefix);

  /// ## removesuffix (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get removesuffix => getAttribute("removesuffix");

  /// ## removesuffix (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set removesuffix(Object? removesuffix) =>
      setAttribute("removesuffix", removesuffix);

  /// ## replace (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get replace => getAttribute("replace");

  /// ## replace (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set replace(Object? replace) => setAttribute("replace", replace);

  /// ## rfind (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get rfind => getAttribute("rfind");

  /// ## rfind (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set rfind(Object? rfind) => setAttribute("rfind", rfind);

  /// ## rindex (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get rindex => getAttribute("rindex");

  /// ## rindex (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set rindex(Object? rindex) => setAttribute("rindex", rindex);

  /// ## rjust (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get rjust => getAttribute("rjust");

  /// ## rjust (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set rjust(Object? rjust) => setAttribute("rjust", rjust);

  /// ## rpartition (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get rpartition => getAttribute("rpartition");

  /// ## rpartition (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set rpartition(Object? rpartition) => setAttribute("rpartition", rpartition);

  /// ## rsplit (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get rsplit => getAttribute("rsplit");

  /// ## rsplit (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set rsplit(Object? rsplit) => setAttribute("rsplit", rsplit);

  /// ## rstrip (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get rstrip => getAttribute("rstrip");

  /// ## rstrip (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set rstrip(Object? rstrip) => setAttribute("rstrip", rstrip);

  /// ## split (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get split => getAttribute("split");

  /// ## split (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set split(Object? split) => setAttribute("split", split);

  /// ## splitlines (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get splitlines => getAttribute("splitlines");

  /// ## splitlines (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set splitlines(Object? splitlines) => setAttribute("splitlines", splitlines);

  /// ## startswith (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get startswith => getAttribute("startswith");

  /// ## startswith (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set startswith(Object? startswith) => setAttribute("startswith", startswith);

  /// ## strip (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get strip => getAttribute("strip");

  /// ## strip (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set strip(Object? strip) => setAttribute("strip", strip);

  /// ## swapcase (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get swapcase => getAttribute("swapcase");

  /// ## swapcase (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set swapcase(Object? swapcase) => setAttribute("swapcase", swapcase);

  /// ## title (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get title => getAttribute("title");

  /// ## title (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set title(Object? title) => setAttribute("title", title);

  /// ## translate (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get translate => getAttribute("translate");

  /// ## translate (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set translate(Object? translate) => setAttribute("translate", translate);

  /// ## upper (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get upper => getAttribute("upper");

  /// ## upper (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set upper(Object? upper) => setAttribute("upper", upper);

  /// ## zfill (getter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  Object? get zfill => getAttribute("zfill");

  /// ## zfill (setter)
  ///
  /// ### python docstring
  ///
  /// A string with meta-information, that is produced by the lexer.
  ///
  /// When parsing text, the resulting chunks of the input that haven't been discarded,
  /// will end up in the tree as Token instances. The Token class inherits from Python's ``str``,
  /// so normal string comparisons and operations will work as expected.
  ///
  /// Attributes:
  ///     type: Name of the token (as specified in grammar)
  ///     value: Value of the token (redundant, as ``token.value == token`` will always be true)
  ///     start_pos: The index of the token in the text
  ///     line: The line of the token in the text (starting with 1)
  ///     column: The column of the token in the text (starting with 1)
  ///     end_line: The line where the token ends
  ///     end_column: The next column after the end of the token. For example,
  ///         if the token is a single character with a column value of 4,
  ///         end_column will be 5.
  ///     end_pos: the index where the token ends (basically ``start_pos + len(token)``)
  set zfill(Object? zfill) => setAttribute("zfill", zfill);
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

/// ## TransformerChain
///
/// ### python docstring
///
/// Abstract base class for generic types.
///
/// A generic type is typically declared by inheriting from
/// this class parameterized with one or more type variables.
/// For example, a generic mapping type might be defined as::
///
///   class Mapping(Generic[KT, VT]):
///       def __getitem__(self, key: KT) -> VT:
///           ...
///       # Etc.
///
/// This class can then be used as follows::
///
///   def lookup_name(mapping: Mapping[KT, VT], key: KT, default: VT) -> VT:
///       try:
///           return mapping[key]
///       except KeyError:
///           return default
///
/// ### python source
/// ```py
/// class TransformerChain(Generic[_Leaf_T, _Return_T]):
///
///     transformers: 'Tuple[Union[Transformer, TransformerChain], ...]'
///
///     def __init__(self, *transformers: 'Union[Transformer, TransformerChain]') -> None:
///         self.transformers = transformers
///
///     def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         for t in self.transformers:
///             tree = t.transform(tree)
///         return cast(_Return_T, tree)
///
///     def __mul__(
///             self: 'TransformerChain[_Leaf_T, Tree[_Leaf_U]]',
///             other: 'Union[Transformer[_Leaf_U, _Return_V], TransformerChain[_Leaf_U, _Return_V]]'
///     ) -> 'TransformerChain[_Leaf_T, _Return_V]':
///         return TransformerChain(*self.transformers + (other,))
/// ```
final class TransformerChain extends PythonClass {
  factory TransformerChain({
    List<Object?> transformers = const <Object?>[],
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.visitors",
        "TransformerChain",
        TransformerChain.from,
        <Object?>[
          ...transformers,
        ],
        <String, Object?>{},
      );

  TransformerChain.from(super.pythonClass) : super.from();

  /// ## transform
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         for t in self.transformers:
  ///             tree = t.transform(tree)
  ///         return cast(_Return_T, tree)
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

  /// ## transformers (getter)
  ///
  /// ### python docstring
  ///
  /// Abstract base class for generic types.
  ///
  /// A generic type is typically declared by inheriting from
  /// this class parameterized with one or more type variables.
  /// For example, a generic mapping type might be defined as::
  ///
  ///   class Mapping(Generic[KT, VT]):
  ///       def __getitem__(self, key: KT) -> VT:
  ///           ...
  ///       # Etc.
  ///
  /// This class can then be used as follows::
  ///
  ///   def lookup_name(mapping: Mapping[KT, VT], key: KT, default: VT) -> VT:
  ///       try:
  ///           return mapping[key]
  ///       except KeyError:
  ///           return default
  Object? get transformers => getAttribute("transformers");

  /// ## transformers (setter)
  ///
  /// ### python docstring
  ///
  /// Abstract base class for generic types.
  ///
  /// A generic type is typically declared by inheriting from
  /// this class parameterized with one or more type variables.
  /// For example, a generic mapping type might be defined as::
  ///
  ///   class Mapping(Generic[KT, VT]):
  ///       def __getitem__(self, key: KT) -> VT:
  ///           ...
  ///       # Etc.
  ///
  /// This class can then be used as follows::
  ///
  ///   def lookup_name(mapping: Mapping[KT, VT], key: KT, default: VT) -> VT:
  ///       try:
  ///           return mapping[key]
  ///       except KeyError:
  ///           return default
  set transformers(Object? transformers) =>
      setAttribute("transformers", transformers);
}

/// ## Transformer_InPlace
///
/// ### python docstring
///
/// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
///
/// Useful for huge trees. Conservative in memory.
///
/// ### python source
/// ```py
/// class Transformer_InPlace(Transformer):
///     """Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
///
///     Useful for huge trees. Conservative in memory.
///     """
///     def _transform_tree(self, tree):           # Cancel recursion
///         return self._call_userfunc(tree)
///
///     def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         for subtree in tree.iter_subtrees():
///             subtree.children = list(self._transform_children(subtree.children))
///
///         return self._transform_tree(tree)
/// ```
final class Transformer_InPlace extends PythonClass {
  factory Transformer_InPlace({
    bool visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.visitors",
        "Transformer_InPlace",
        Transformer_InPlace.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  Transformer_InPlace.from(super.pythonClass) : super.from();

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         for subtree in tree.iter_subtrees():
  ///             subtree.children = list(self._transform_children(subtree.children))
  ///
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

/// ## Transformer_InPlaceRecursive
///
/// ### python docstring
///
/// Same as Transformer, recursive, but changes the tree in-place instead of returning new instances
///
/// ### python source
/// ```py
/// class Transformer_InPlaceRecursive(Transformer):
///     "Same as Transformer, recursive, but changes the tree in-place instead of returning new instances"
///     def _transform_tree(self, tree):
///         tree.children = list(self._transform_children(tree.children))
///         return self._call_userfunc(tree)
/// ```
final class Transformer_InPlaceRecursive extends PythonClass {
  factory Transformer_InPlaceRecursive({
    bool visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.visitors",
        "Transformer_InPlaceRecursive",
        Transformer_InPlaceRecursive.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  Transformer_InPlaceRecursive.from(super.pythonClass) : super.from();

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

/// ## Transformer_NonRecursive
///
/// ### python docstring
///
/// Same as Transformer but non-recursive.
///
/// Like Transformer, it doesn't change the original tree.
///
/// Useful for huge trees.
///
/// ### python source
/// ```py
/// class Transformer_NonRecursive(Transformer):
///     """Same as Transformer but non-recursive.
///
///     Like Transformer, it doesn't change the original tree.
///
///     Useful for huge trees.
///     """
///
///     def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         # Tree to postfix
///         rev_postfix = []
///         q: List[Branch[_Leaf_T]] = [tree]
///         while q:
///             t = q.pop()
///             rev_postfix.append(t)
///             if isinstance(t, Tree):
///                 q += t.children
///
///         # Postfix to tree
///         stack: List = []
///         for x in reversed(rev_postfix):
///             if isinstance(x, Tree):
///                 size = len(x.children)
///                 if size:
///                     args = stack[-size:]
///                     del stack[-size:]
///                 else:
///                     args = []
///
///                 res = self._call_userfunc(x, args)
///                 if res is not Discard:
///                     stack.append(res)
///
///             elif self.__visit_tokens__ and isinstance(x, Token):
///                 res = self._call_userfunc_token(x)
///                 if res is not Discard:
///                     stack.append(res)
///             else:
///                 stack.append(x)
///
///         result, = stack  # We should have only one tree remaining
///         # There are no guarantees on the type of the value produced by calling a user func for a
///         # child will produce. This means type system can't statically know that the final result is
///         # _Return_T. As a result a cast is required.
///         return cast(_Return_T, result)
/// ```
final class Transformer_NonRecursive extends PythonClass {
  factory Transformer_NonRecursive({
    bool visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.visitors",
        "Transformer_NonRecursive",
        Transformer_NonRecursive.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  Transformer_NonRecursive.from(super.pythonClass) : super.from();

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Transform the given tree, and return the final result
  ///
  /// ### python source
  /// ```py
  /// def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
  ///         # Tree to postfix
  ///         rev_postfix = []
  ///         q: List[Branch[_Leaf_T]] = [tree]
  ///         while q:
  ///             t = q.pop()
  ///             rev_postfix.append(t)
  ///             if isinstance(t, Tree):
  ///                 q += t.children
  ///
  ///         # Postfix to tree
  ///         stack: List = []
  ///         for x in reversed(rev_postfix):
  ///             if isinstance(x, Tree):
  ///                 size = len(x.children)
  ///                 if size:
  ///                     args = stack[-size:]
  ///                     del stack[-size:]
  ///                 else:
  ///                     args = []
  ///
  ///                 res = self._call_userfunc(x, args)
  ///                 if res is not Discard:
  ///                     stack.append(res)
  ///
  ///             elif self.__visit_tokens__ and isinstance(x, Token):
  ///                 res = self._call_userfunc_token(x)
  ///                 if res is not Discard:
  ///                     stack.append(res)
  ///             else:
  ///                 stack.append(x)
  ///
  ///         result, = stack  # We should have only one tree remaining
  ///         # There are no guarantees on the type of the value produced by calling a user func for a
  ///         # child will produce. This means type system can't statically know that the final result is
  ///         # _Return_T. As a result a cast is required.
  ///         return cast(_Return_T, result)
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

/// ## Tree
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
final class Tree extends PythonClass {
  factory Tree({
    required String data,
    required Object? children,
    Object? meta,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.tree",
        "Tree",
        Tree.from,
        <Object?>[
          data,
          children,
          meta,
        ],
        <String, Object?>{},
      );

  Tree.from(super.pythonClass) : super.from();

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

/// ## VisitError
///
/// ### python docstring
///
/// VisitError is raised when visitors are interrupted by an exception
///
/// It provides the following attributes for inspection:
///
/// Parameters:
///     rule: the name of the visit rule that failed
///     obj: the tree-node or token that was being processed
///     orig_exc: the exception that cause it to fail
///
/// Note: These parameters are available as attributes
///
/// ### python source
/// ```py
/// class VisitError(LarkError):
///     """VisitError is raised when visitors are interrupted by an exception
///
///     It provides the following attributes for inspection:
///
///     Parameters:
///         rule: the name of the visit rule that failed
///         obj: the tree-node or token that was being processed
///         orig_exc: the exception that cause it to fail
///
///     Note: These parameters are available as attributes
///     """
///
///     obj: 'Union[Tree, Token]'
///     orig_exc: Exception
///
///     def __init__(self, rule, obj, orig_exc):
///         message = 'Error trying to process rule "%s":\n\n%s' % (rule, orig_exc)
///         super(VisitError, self).__init__(message)
///
///         self.rule = rule
///         self.obj = obj
///         self.orig_exc = orig_exc
/// ```
final class VisitError extends PythonClass {
  factory VisitError({
    required Object? rule,
    required Object? obj,
    required Object? orig_exc,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "VisitError",
        VisitError.from,
        <Object?>[
          rule,
          obj,
          orig_exc,
        ],
        <String, Object?>{},
      );

  VisitError.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// VisitError is raised when visitors are interrupted by an exception
  ///
  /// It provides the following attributes for inspection:
  ///
  /// Parameters:
  ///     rule: the name of the visit rule that failed
  ///     obj: the tree-node or token that was being processed
  ///     orig_exc: the exception that cause it to fail
  ///
  /// Note: These parameters are available as attributes
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// VisitError is raised when visitors are interrupted by an exception
  ///
  /// It provides the following attributes for inspection:
  ///
  /// Parameters:
  ///     rule: the name of the visit rule that failed
  ///     obj: the tree-node or token that was being processed
  ///     orig_exc: the exception that cause it to fail
  ///
  /// Note: These parameters are available as attributes
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// VisitError is raised when visitors are interrupted by an exception
  ///
  /// It provides the following attributes for inspection:
  ///
  /// Parameters:
  ///     rule: the name of the visit rule that failed
  ///     obj: the tree-node or token that was being processed
  ///     orig_exc: the exception that cause it to fail
  ///
  /// Note: These parameters are available as attributes
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// VisitError is raised when visitors are interrupted by an exception
  ///
  /// It provides the following attributes for inspection:
  ///
  /// Parameters:
  ///     rule: the name of the visit rule that failed
  ///     obj: the tree-node or token that was being processed
  ///     orig_exc: the exception that cause it to fail
  ///
  /// Note: These parameters are available as attributes
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// VisitError is raised when visitors are interrupted by an exception
  ///
  /// It provides the following attributes for inspection:
  ///
  /// Parameters:
  ///     rule: the name of the visit rule that failed
  ///     obj: the tree-node or token that was being processed
  ///     orig_exc: the exception that cause it to fail
  ///
  /// Note: These parameters are available as attributes
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// VisitError is raised when visitors are interrupted by an exception
  ///
  /// It provides the following attributes for inspection:
  ///
  /// Parameters:
  ///     rule: the name of the visit rule that failed
  ///     obj: the tree-node or token that was being processed
  ///     orig_exc: the exception that cause it to fail
  ///
  /// Note: These parameters are available as attributes
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);

  /// ## rule (getter)
  ///
  /// ### python docstring
  ///
  /// VisitError is raised when visitors are interrupted by an exception
  ///
  /// It provides the following attributes for inspection:
  ///
  /// Parameters:
  ///     rule: the name of the visit rule that failed
  ///     obj: the tree-node or token that was being processed
  ///     orig_exc: the exception that cause it to fail
  ///
  /// Note: These parameters are available as attributes
  Object? get rule => getAttribute("rule");

  /// ## rule (setter)
  ///
  /// ### python docstring
  ///
  /// VisitError is raised when visitors are interrupted by an exception
  ///
  /// It provides the following attributes for inspection:
  ///
  /// Parameters:
  ///     rule: the name of the visit rule that failed
  ///     obj: the tree-node or token that was being processed
  ///     orig_exc: the exception that cause it to fail
  ///
  /// Note: These parameters are available as attributes
  set rule(Object? rule) => setAttribute("rule", rule);

  /// ## obj (getter)
  ///
  /// ### python docstring
  ///
  /// VisitError is raised when visitors are interrupted by an exception
  ///
  /// It provides the following attributes for inspection:
  ///
  /// Parameters:
  ///     rule: the name of the visit rule that failed
  ///     obj: the tree-node or token that was being processed
  ///     orig_exc: the exception that cause it to fail
  ///
  /// Note: These parameters are available as attributes
  Object? get obj => getAttribute("obj");

  /// ## obj (setter)
  ///
  /// ### python docstring
  ///
  /// VisitError is raised when visitors are interrupted by an exception
  ///
  /// It provides the following attributes for inspection:
  ///
  /// Parameters:
  ///     rule: the name of the visit rule that failed
  ///     obj: the tree-node or token that was being processed
  ///     orig_exc: the exception that cause it to fail
  ///
  /// Note: These parameters are available as attributes
  set obj(Object? obj) => setAttribute("obj", obj);

  /// ## orig_exc (getter)
  ///
  /// ### python docstring
  ///
  /// VisitError is raised when visitors are interrupted by an exception
  ///
  /// It provides the following attributes for inspection:
  ///
  /// Parameters:
  ///     rule: the name of the visit rule that failed
  ///     obj: the tree-node or token that was being processed
  ///     orig_exc: the exception that cause it to fail
  ///
  /// Note: These parameters are available as attributes
  Object? get orig_exc => getAttribute("orig_exc");

  /// ## orig_exc (setter)
  ///
  /// ### python docstring
  ///
  /// VisitError is raised when visitors are interrupted by an exception
  ///
  /// It provides the following attributes for inspection:
  ///
  /// Parameters:
  ///     rule: the name of the visit rule that failed
  ///     obj: the tree-node or token that was being processed
  ///     orig_exc: the exception that cause it to fail
  ///
  /// Note: These parameters are available as attributes
  set orig_exc(Object? orig_exc) => setAttribute("orig_exc", orig_exc);
}

/// ## Visitor
///
/// ### python docstring
///
/// Tree visitor, non-recursive (can handle huge trees).
///
/// Visiting a node calls its methods (provided by the user via inheritance) according to ``tree.data``
///
/// ### python source
/// ```py
/// class Visitor(VisitorBase, ABC, Generic[_Leaf_T]):
///     """Tree visitor, non-recursive (can handle huge trees).
///
///     Visiting a node calls its methods (provided by the user via inheritance) according to ``tree.data``
///     """
///
///     def visit(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
///         "Visits the tree, starting with the leaves and finally the root (bottom-up)"
///         for subtree in tree.iter_subtrees():
///             self._call_userfunc(subtree)
///         return tree
///
///     def visit_topdown(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
///         "Visit the tree, starting at the root, and ending at the leaves (top-down)"
///         for subtree in tree.iter_subtrees_topdown():
///             self._call_userfunc(subtree)
///         return tree
/// ```
final class Visitor extends PythonClass {
  factory Visitor() => PythonFfiDart.instance.importClass(
        "lark.visitors",
        "Visitor",
        Visitor.from,
        <Object?>[],
      );

  Visitor.from(super.pythonClass) : super.from();

  /// ## visit
  ///
  /// ### python docstring
  ///
  /// Visits the tree, starting with the leaves and finally the root (bottom-up)
  ///
  /// ### python source
  /// ```py
  /// def visit(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
  ///         "Visits the tree, starting with the leaves and finally the root (bottom-up)"
  ///         for subtree in tree.iter_subtrees():
  ///             self._call_userfunc(subtree)
  ///         return tree
  /// ```
  Object? visit({
    required Object? tree,
  }) =>
      getFunction("visit").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_topdown
  ///
  /// ### python docstring
  ///
  /// Visit the tree, starting at the root, and ending at the leaves (top-down)
  ///
  /// ### python source
  /// ```py
  /// def visit_topdown(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
  ///         "Visit the tree, starting at the root, and ending at the leaves (top-down)"
  ///         for subtree in tree.iter_subtrees_topdown():
  ///             self._call_userfunc(subtree)
  ///         return tree
  /// ```
  Object? visit_topdown({
    required Object? tree,
  }) =>
      getFunction("visit_topdown").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## VisitorBase
///
/// ### python source
/// ```py
/// class VisitorBase:
///     def _call_userfunc(self, tree):
///         return getattr(self, tree.data, self.__default__)(tree)
///
///     def __default__(self, tree):
///         """Default function that is called if there is no attribute matching ``tree.data``
///
///         Can be overridden. Defaults to doing nothing.
///         """
///         return tree
///
///     def __class_getitem__(cls, _):
///         return cls
/// ```
final class VisitorBase extends PythonClass {
  factory VisitorBase() => PythonFfiDart.instance.importClass(
        "lark.visitors",
        "VisitorBase",
        VisitorBase.from,
        <Object?>[],
      );

  VisitorBase.from(super.pythonClass) : super.from();
}

/// ## Visitor_Recursive
///
/// ### python docstring
///
/// Bottom-up visitor, recursive.
///
/// Visiting a node calls its methods (provided by the user via inheritance) according to ``tree.data``
///
/// Slightly faster than the non-recursive version.
///
/// ### python source
/// ```py
/// class Visitor_Recursive(VisitorBase, Generic[_Leaf_T]):
///     """Bottom-up visitor, recursive.
///
///     Visiting a node calls its methods (provided by the user via inheritance) according to ``tree.data``
///
///     Slightly faster than the non-recursive version.
///     """
///
///     def visit(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
///         "Visits the tree, starting with the leaves and finally the root (bottom-up)"
///         for child in tree.children:
///             if isinstance(child, Tree):
///                 self.visit(child)
///
///         self._call_userfunc(tree)
///         return tree
///
///     def visit_topdown(self,tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
///         "Visit the tree, starting at the root, and ending at the leaves (top-down)"
///         self._call_userfunc(tree)
///
///         for child in tree.children:
///             if isinstance(child, Tree):
///                 self.visit_topdown(child)
///
///         return tree
/// ```
final class Visitor_Recursive extends PythonClass {
  factory Visitor_Recursive() => PythonFfiDart.instance.importClass(
        "lark.visitors",
        "Visitor_Recursive",
        Visitor_Recursive.from,
        <Object?>[],
      );

  Visitor_Recursive.from(super.pythonClass) : super.from();

  /// ## visit
  ///
  /// ### python docstring
  ///
  /// Visits the tree, starting with the leaves and finally the root (bottom-up)
  ///
  /// ### python source
  /// ```py
  /// def visit(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
  ///         "Visits the tree, starting with the leaves and finally the root (bottom-up)"
  ///         for child in tree.children:
  ///             if isinstance(child, Tree):
  ///                 self.visit(child)
  ///
  ///         self._call_userfunc(tree)
  ///         return tree
  /// ```
  Object? visit({
    required Object? tree,
  }) =>
      getFunction("visit").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_topdown
  ///
  /// ### python docstring
  ///
  /// Visit the tree, starting at the root, and ending at the leaves (top-down)
  ///
  /// ### python source
  /// ```py
  /// def visit_topdown(self,tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
  ///         "Visit the tree, starting at the root, and ending at the leaves (top-down)"
  ///         self._call_userfunc(tree)
  ///
  ///         for child in tree.children:
  ///             if isinstance(child, Tree):
  ///                 self.visit_topdown(child)
  ///
  ///         return tree
  /// ```
  Object? visit_topdown({
    required Object? tree,
  }) =>
      getFunction("visit_topdown").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## visitors
///
/// ### python source
/// ```py
/// from typing import TypeVar, Tuple, List, Callable, Generic, Type, Union, Optional, Any, cast
/// from abc import ABC
///
/// from .utils import combine_alternatives
/// from .tree import Tree, Branch
/// from .exceptions import VisitError, GrammarError
/// from .lexer import Token
///
/// ###{standalone
/// from functools import wraps, update_wrapper
/// from inspect import getmembers, getmro
///
/// _Return_T = TypeVar('_Return_T')
/// _Return_V = TypeVar('_Return_V')
/// _Leaf_T = TypeVar('_Leaf_T')
/// _Leaf_U = TypeVar('_Leaf_U')
/// _R = TypeVar('_R')
/// _FUNC = Callable[..., _Return_T]
/// _DECORATED = Union[_FUNC, type]
///
/// class _DiscardType:
///     """When the Discard value is returned from a transformer callback,
///     that node is discarded and won't appear in the parent.
///
///     Note:
///         This feature is disabled when the transformer is provided to Lark
///         using the ``transformer`` keyword (aka Tree-less LALR mode).
///
///     Example:
///         ::
///
///             class T(Transformer):
///                 def ignore_tree(self, children):
///                     return Discard
///
///                 def IGNORE_TOKEN(self, token):
///                     return Discard
///     """
///
///     def __repr__(self):
///         return "lark.visitors.Discard"
///
/// Discard = _DiscardType()
///
/// # Transformers
///
/// class _Decoratable:
///     "Provides support for decorating methods with @v_args"
///
///     @classmethod
///     def _apply_v_args(cls, visit_wrapper):
///         mro = getmro(cls)
///         assert mro[0] is cls
///         libmembers = {name for _cls in mro[1:] for name, _ in getmembers(_cls)}
///         for name, value in getmembers(cls):
///
///             # Make sure the function isn't inherited (unless it's overwritten)
///             if name.startswith('_') or (name in libmembers and name not in cls.__dict__):
///                 continue
///             if not callable(value):
///                 continue
///
///             # Skip if v_args already applied (at the function level)
///             if isinstance(cls.__dict__[name], _VArgsWrapper):
///                 continue
///
///             setattr(cls, name, _VArgsWrapper(cls.__dict__[name], visit_wrapper))
///         return cls
///
///     def __class_getitem__(cls, _):
///         return cls
///
///
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
///
///
/// def merge_transformers(base_transformer=None, **transformers_to_merge):
///     """Merge a collection of transformers into the base_transformer, each into its own 'namespace'.
///
///     When called, it will collect the methods from each transformer, and assign them to base_transformer,
///     with their name prefixed with the given keyword, as ``prefix__methodname``.
///
///     This function is especially useful for processing grammars that import other grammars,
///     thereby creating some of their rules in a 'namespace'. (i.e with a consistent name prefix).
///     In this case, the key for the transformer should match the name of the imported grammar.
///
///     Parameters:
///         base_transformer (Transformer, optional): The transformer that all other transformers will be added to.
///         **transformers_to_merge: Keyword arguments, in the form of ``name_prefix = transformer``.
///
///     Raises:
///         AttributeError: In case of a name collision in the merged methods
///
///     Example:
///         ::
///
///             class TBase(Transformer):
///                 def start(self, children):
///                     return children[0] + 'bar'
///
///             class TImportedGrammar(Transformer):
///                 def foo(self, children):
///                     return "foo"
///
///             composed_transformer = merge_transformers(TBase(), imported=TImportedGrammar())
///
///             t = Tree('start', [ Tree('imported__foo', []) ])
///
///             assert composed_transformer.transform(t) == 'foobar'
///
///     """
///     if base_transformer is None:
///         base_transformer = Transformer()
///     for prefix, transformer in transformers_to_merge.items():
///         for method_name in dir(transformer):
///             method = getattr(transformer, method_name)
///             if not callable(method):
///                 continue
///             if method_name.startswith("_") or method_name == "transform":
///                 continue
///             prefixed_method = prefix + "__" + method_name
///             if hasattr(base_transformer, prefixed_method):
///                 raise AttributeError("Cannot merge: method '%s' appears more than once" % prefixed_method)
///
///             setattr(base_transformer, prefixed_method, method)
///
///     return base_transformer
///
///
/// class InlineTransformer(Transformer):   # XXX Deprecated
///     def _call_userfunc(self, tree, new_children=None):
///         # Assumes tree is already transformed
///         children = new_children if new_children is not None else tree.children
///         try:
///             f = getattr(self, tree.data)
///         except AttributeError:
///             return self.__default__(tree.data, children, tree.meta)
///         else:
///             return f(*children)
///
///
/// class TransformerChain(Generic[_Leaf_T, _Return_T]):
///
///     transformers: 'Tuple[Union[Transformer, TransformerChain], ...]'
///
///     def __init__(self, *transformers: 'Union[Transformer, TransformerChain]') -> None:
///         self.transformers = transformers
///
///     def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         for t in self.transformers:
///             tree = t.transform(tree)
///         return cast(_Return_T, tree)
///
///     def __mul__(
///             self: 'TransformerChain[_Leaf_T, Tree[_Leaf_U]]',
///             other: 'Union[Transformer[_Leaf_U, _Return_V], TransformerChain[_Leaf_U, _Return_V]]'
///     ) -> 'TransformerChain[_Leaf_T, _Return_V]':
///         return TransformerChain(*self.transformers + (other,))
///
///
/// class Transformer_InPlace(Transformer):
///     """Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
///
///     Useful for huge trees. Conservative in memory.
///     """
///     def _transform_tree(self, tree):           # Cancel recursion
///         return self._call_userfunc(tree)
///
///     def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         for subtree in tree.iter_subtrees():
///             subtree.children = list(self._transform_children(subtree.children))
///
///         return self._transform_tree(tree)
///
///
/// class Transformer_NonRecursive(Transformer):
///     """Same as Transformer but non-recursive.
///
///     Like Transformer, it doesn't change the original tree.
///
///     Useful for huge trees.
///     """
///
///     def transform(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         # Tree to postfix
///         rev_postfix = []
///         q: List[Branch[_Leaf_T]] = [tree]
///         while q:
///             t = q.pop()
///             rev_postfix.append(t)
///             if isinstance(t, Tree):
///                 q += t.children
///
///         # Postfix to tree
///         stack: List = []
///         for x in reversed(rev_postfix):
///             if isinstance(x, Tree):
///                 size = len(x.children)
///                 if size:
///                     args = stack[-size:]
///                     del stack[-size:]
///                 else:
///                     args = []
///
///                 res = self._call_userfunc(x, args)
///                 if res is not Discard:
///                     stack.append(res)
///
///             elif self.__visit_tokens__ and isinstance(x, Token):
///                 res = self._call_userfunc_token(x)
///                 if res is not Discard:
///                     stack.append(res)
///             else:
///                 stack.append(x)
///
///         result, = stack  # We should have only one tree remaining
///         # There are no guarantees on the type of the value produced by calling a user func for a
///         # child will produce. This means type system can't statically know that the final result is
///         # _Return_T. As a result a cast is required.
///         return cast(_Return_T, result)
///
///
/// class Transformer_InPlaceRecursive(Transformer):
///     "Same as Transformer, recursive, but changes the tree in-place instead of returning new instances"
///     def _transform_tree(self, tree):
///         tree.children = list(self._transform_children(tree.children))
///         return self._call_userfunc(tree)
///
///
/// # Visitors
///
/// class VisitorBase:
///     def _call_userfunc(self, tree):
///         return getattr(self, tree.data, self.__default__)(tree)
///
///     def __default__(self, tree):
///         """Default function that is called if there is no attribute matching ``tree.data``
///
///         Can be overridden. Defaults to doing nothing.
///         """
///         return tree
///
///     def __class_getitem__(cls, _):
///         return cls
///
///
/// class Visitor(VisitorBase, ABC, Generic[_Leaf_T]):
///     """Tree visitor, non-recursive (can handle huge trees).
///
///     Visiting a node calls its methods (provided by the user via inheritance) according to ``tree.data``
///     """
///
///     def visit(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
///         "Visits the tree, starting with the leaves and finally the root (bottom-up)"
///         for subtree in tree.iter_subtrees():
///             self._call_userfunc(subtree)
///         return tree
///
///     def visit_topdown(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
///         "Visit the tree, starting at the root, and ending at the leaves (top-down)"
///         for subtree in tree.iter_subtrees_topdown():
///             self._call_userfunc(subtree)
///         return tree
///
///
/// class Visitor_Recursive(VisitorBase, Generic[_Leaf_T]):
///     """Bottom-up visitor, recursive.
///
///     Visiting a node calls its methods (provided by the user via inheritance) according to ``tree.data``
///
///     Slightly faster than the non-recursive version.
///     """
///
///     def visit(self, tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
///         "Visits the tree, starting with the leaves and finally the root (bottom-up)"
///         for child in tree.children:
///             if isinstance(child, Tree):
///                 self.visit(child)
///
///         self._call_userfunc(tree)
///         return tree
///
///     def visit_topdown(self,tree: Tree[_Leaf_T]) -> Tree[_Leaf_T]:
///         "Visit the tree, starting at the root, and ending at the leaves (top-down)"
///         self._call_userfunc(tree)
///
///         for child in tree.children:
///             if isinstance(child, Tree):
///                 self.visit_topdown(child)
///
///         return tree
///
///
/// class Interpreter(_Decoratable, ABC, Generic[_Leaf_T, _Return_T]):
///     """Interpreter walks the tree starting at the root.
///
///     Visits the tree, starting with the root and finally the leaves (top-down)
///
///     For each tree node, it calls its methods (provided by user via inheritance) according to ``tree.data``.
///
///     Unlike ``Transformer`` and ``Visitor``, the Interpreter doesn't automatically visit its sub-branches.
///     The user has to explicitly call ``visit``, ``visit_children``, or use the ``@visit_children_decor``.
///     This allows the user to implement branching and loops.
///     """
///
///     def visit(self, tree: Tree[_Leaf_T]) -> _Return_T:
///         # There are no guarantees on the type of the value produced by calling a user func for a
///         # child will produce. So only annotate the public method and use an internal method when
///         # visiting child trees.
///         return self._visit_tree(tree)
///
///     def _visit_tree(self, tree: Tree[_Leaf_T]):
///         f = getattr(self, tree.data)
///         wrapper = getattr(f, 'visit_wrapper', None)
///         if wrapper is not None:
///             return f.visit_wrapper(f, tree.data, tree.children, tree.meta)
///         else:
///             return f(tree)
///
///     def visit_children(self, tree: Tree[_Leaf_T]) -> List:
///         return [self._visit_tree(child) if isinstance(child, Tree) else child
///                 for child in tree.children]
///
///     def __getattr__(self, name):
///         return self.__default__
///
///     def __default__(self, tree):
///         return self.visit_children(tree)
///
///
/// _InterMethod = Callable[[Type[Interpreter], _Return_T], _R]
///
/// def visit_children_decor(func: _InterMethod) -> _InterMethod:
///     "See Interpreter"
///     @wraps(func)
///     def inner(cls, tree):
///         values = cls.visit_children(tree)
///         return func(cls, values)
///     return inner
///
/// # Decorators
///
/// def _apply_v_args(obj, visit_wrapper):
///     try:
///         _apply = obj._apply_v_args
///     except AttributeError:
///         return _VArgsWrapper(obj, visit_wrapper)
///     else:
///         return _apply(visit_wrapper)
///
///
/// class _VArgsWrapper:
///     """
///     A wrapper around a Callable. It delegates `__call__` to the Callable.
///     If the Callable has a `__get__`, that is also delegate and the resulting function is wrapped.
///     Otherwise, we use the original function mirroring the behaviour without a __get__.
///     We also have the visit_wrapper attribute to be used by Transformers.
///     """
///     base_func: Callable
///
///     def __init__(self, func: Callable, visit_wrapper: Callable[[Callable, str, list, Any], Any]):
///         if isinstance(func, _VArgsWrapper):
///             func = func.base_func
///         # https://github.com/python/mypy/issues/708
///         self.base_func = func  # type: ignore[assignment]
///         self.visit_wrapper = visit_wrapper
///         update_wrapper(self, func)
///
///     def __call__(self, *args, **kwargs):
///         return self.base_func(*args, **kwargs)
///
///     def __get__(self, instance, owner=None):
///         try:
///             # Use the __get__ attribute of the type instead of the instance
///             # to fully mirror the behavior of getattr
///             g = type(self.base_func).__get__
///         except AttributeError:
///             return self
///         else:
///             return _VArgsWrapper(g(self.base_func, instance, owner), self.visit_wrapper)
///
///     def __set_name__(self, owner, name):
///         try:
///             f = type(self.base_func).__set_name__
///         except AttributeError:
///             return
///         else:
///             f(self.base_func, owner, name)
///
///
/// def _vargs_inline(f, _data, children, _meta):
///     return f(*children)
/// def _vargs_meta_inline(f, _data, children, meta):
///     return f(meta, *children)
/// def _vargs_meta(f, _data, children, meta):
///     return f(meta, children)
/// def _vargs_tree(f, data, children, meta):
///     return f(Tree(data, children, meta))
///
///
/// def v_args(inline: bool = False, meta: bool = False, tree: bool = False, wrapper: Optional[Callable] = None) -> Callable[[_DECORATED], _DECORATED]:
///     """A convenience decorator factory for modifying the behavior of user-supplied visitor methods.
///
///     By default, callback methods of transformers/visitors accept one argument - a list of the node's children.
///
///     ``v_args`` can modify this behavior. When used on a transformer/visitor class definition,
///     it applies to all the callback methods inside it.
///
///     ``v_args`` can be applied to a single method, or to an entire class. When applied to both,
///     the options given to the method take precedence.
///
///     Parameters:
///         inline (bool, optional): Children are provided as ``*args`` instead of a list argument (not recommended for very long lists).
///         meta (bool, optional): Provides two arguments: ``meta`` and ``children`` (instead of just the latter)
///         tree (bool, optional): Provides the entire tree as the argument, instead of the children.
///         wrapper (function, optional): Provide a function to decorate all methods.
///
///     Example:
///         ::
///
///             @v_args(inline=True)
///             class SolveArith(Transformer):
///                 def add(self, left, right):
///                     return left + right
///
///                 @v_args(meta=True)
///                 def mul(self, meta, children):
///                     logger.info(f'mul at line {meta.line}')
///                     left, right = children
///                     return left * right
///
///
///             class ReverseNotation(Transformer_InPlace):
///                 @v_args(tree=True)
///                 def tree_node(self, tree):
///                     tree.children = tree.children[::-1]
///     """
///     if tree and (meta or inline):
///         raise ValueError("Visitor functions cannot combine 'tree' with 'meta' or 'inline'.")
///
///     func = None
///     if meta:
///         if inline:
///             func = _vargs_meta_inline
///         else:
///             func = _vargs_meta
///     elif inline:
///         func = _vargs_inline
///     elif tree:
///         func = _vargs_tree
///
///     if wrapper is not None:
///         if func is not None:
///             raise ValueError("Cannot use 'wrapper' along with 'tree', 'meta' or 'inline'.")
///         func = wrapper
///
///     def _visitor_args_dec(obj):
///         return _apply_v_args(obj, func)
///     return _visitor_args_dec
///
///
/// ###}
///
///
/// # --- Visitor Utilities ---
///
/// class CollapseAmbiguities(Transformer):
///     """
///     Transforms a tree that contains any number of _ambig nodes into a list of trees,
///     each one containing an unambiguous tree.
///
///     The length of the resulting list is the product of the length of all _ambig nodes.
///
///     Warning: This may quickly explode for highly ambiguous trees.
///
///     """
///     def _ambig(self, options):
///         return sum(options, [])
///
///     def __default__(self, data, children_lists, meta):
///         return [Tree(data, children, meta) for children in combine_alternatives(children_lists)]
///
///     def __default_token__(self, t):
///         return [t]
/// ```
final class visitors extends PythonModule {
  visitors.from(super.pythonModule) : super.from();

  static visitors import() => PythonFfiDart.instance.importModule(
        "lark.visitors",
        visitors.from,
      );

  /// ## merge_transformers
  ///
  /// ### python docstring
  ///
  /// Merge a collection of transformers into the base_transformer, each into its own 'namespace'.
  ///
  /// When called, it will collect the methods from each transformer, and assign them to base_transformer,
  /// with their name prefixed with the given keyword, as ``prefix__methodname``.
  ///
  /// This function is especially useful for processing grammars that import other grammars,
  /// thereby creating some of their rules in a 'namespace'. (i.e with a consistent name prefix).
  /// In this case, the key for the transformer should match the name of the imported grammar.
  ///
  /// Parameters:
  ///     base_transformer (Transformer, optional): The transformer that all other transformers will be added to.
  ///     **transformers_to_merge: Keyword arguments, in the form of ``name_prefix = transformer``.
  ///
  /// Raises:
  ///     AttributeError: In case of a name collision in the merged methods
  ///
  /// Example:
  ///     ::
  ///
  ///         class TBase(Transformer):
  ///             def start(self, children):
  ///                 return children[0] + 'bar'
  ///
  ///         class TImportedGrammar(Transformer):
  ///             def foo(self, children):
  ///                 return "foo"
  ///
  ///         composed_transformer = merge_transformers(TBase(), imported=TImportedGrammar())
  ///
  ///         t = Tree('start', [ Tree('imported__foo', []) ])
  ///
  ///         assert composed_transformer.transform(t) == 'foobar'
  ///
  /// ### python source
  /// ```py
  /// def merge_transformers(base_transformer=None, **transformers_to_merge):
  ///     """Merge a collection of transformers into the base_transformer, each into its own 'namespace'.
  ///
  ///     When called, it will collect the methods from each transformer, and assign them to base_transformer,
  ///     with their name prefixed with the given keyword, as ``prefix__methodname``.
  ///
  ///     This function is especially useful for processing grammars that import other grammars,
  ///     thereby creating some of their rules in a 'namespace'. (i.e with a consistent name prefix).
  ///     In this case, the key for the transformer should match the name of the imported grammar.
  ///
  ///     Parameters:
  ///         base_transformer (Transformer, optional): The transformer that all other transformers will be added to.
  ///         **transformers_to_merge: Keyword arguments, in the form of ``name_prefix = transformer``.
  ///
  ///     Raises:
  ///         AttributeError: In case of a name collision in the merged methods
  ///
  ///     Example:
  ///         ::
  ///
  ///             class TBase(Transformer):
  ///                 def start(self, children):
  ///                     return children[0] + 'bar'
  ///
  ///             class TImportedGrammar(Transformer):
  ///                 def foo(self, children):
  ///                     return "foo"
  ///
  ///             composed_transformer = merge_transformers(TBase(), imported=TImportedGrammar())
  ///
  ///             t = Tree('start', [ Tree('imported__foo', []) ])
  ///
  ///             assert composed_transformer.transform(t) == 'foobar'
  ///
  ///     """
  ///     if base_transformer is None:
  ///         base_transformer = Transformer()
  ///     for prefix, transformer in transformers_to_merge.items():
  ///         for method_name in dir(transformer):
  ///             method = getattr(transformer, method_name)
  ///             if not callable(method):
  ///                 continue
  ///             if method_name.startswith("_") or method_name == "transform":
  ///                 continue
  ///             prefixed_method = prefix + "__" + method_name
  ///             if hasattr(base_transformer, prefixed_method):
  ///                 raise AttributeError("Cannot merge: method '%s' appears more than once" % prefixed_method)
  ///
  ///             setattr(base_transformer, prefixed_method, method)
  ///
  ///     return base_transformer
  /// ```
  Object? merge_transformers({
    Object? base_transformer,
    Map<String, Object?> transformers_to_merge = const <String, Object?>{},
  }) =>
      getFunction("merge_transformers").call(
        <Object?>[
          base_transformer,
        ],
        kwargs: <String, Object?>{
          ...transformers_to_merge,
        },
      );

  /// ## v_args
  ///
  /// ### python docstring
  ///
  /// A convenience decorator factory for modifying the behavior of user-supplied visitor methods.
  ///
  /// By default, callback methods of transformers/visitors accept one argument - a list of the node's children.
  ///
  /// ``v_args`` can modify this behavior. When used on a transformer/visitor class definition,
  /// it applies to all the callback methods inside it.
  ///
  /// ``v_args`` can be applied to a single method, or to an entire class. When applied to both,
  /// the options given to the method take precedence.
  ///
  /// Parameters:
  ///     inline (bool, optional): Children are provided as ``*args`` instead of a list argument (not recommended for very long lists).
  ///     meta (bool, optional): Provides two arguments: ``meta`` and ``children`` (instead of just the latter)
  ///     tree (bool, optional): Provides the entire tree as the argument, instead of the children.
  ///     wrapper (function, optional): Provide a function to decorate all methods.
  ///
  /// Example:
  ///     ::
  ///
  ///         @v_args(inline=True)
  ///         class SolveArith(Transformer):
  ///             def add(self, left, right):
  ///                 return left + right
  ///
  ///             @v_args(meta=True)
  ///             def mul(self, meta, children):
  ///                 logger.info(f'mul at line {meta.line}')
  ///                 left, right = children
  ///                 return left * right
  ///
  ///
  ///         class ReverseNotation(Transformer_InPlace):
  ///             @v_args(tree=True)
  ///             def tree_node(self, tree):
  ///                 tree.children = tree.children[::-1]
  ///
  /// ### python source
  /// ```py
  /// def v_args(inline: bool = False, meta: bool = False, tree: bool = False, wrapper: Optional[Callable] = None) -> Callable[[_DECORATED], _DECORATED]:
  ///     """A convenience decorator factory for modifying the behavior of user-supplied visitor methods.
  ///
  ///     By default, callback methods of transformers/visitors accept one argument - a list of the node's children.
  ///
  ///     ``v_args`` can modify this behavior. When used on a transformer/visitor class definition,
  ///     it applies to all the callback methods inside it.
  ///
  ///     ``v_args`` can be applied to a single method, or to an entire class. When applied to both,
  ///     the options given to the method take precedence.
  ///
  ///     Parameters:
  ///         inline (bool, optional): Children are provided as ``*args`` instead of a list argument (not recommended for very long lists).
  ///         meta (bool, optional): Provides two arguments: ``meta`` and ``children`` (instead of just the latter)
  ///         tree (bool, optional): Provides the entire tree as the argument, instead of the children.
  ///         wrapper (function, optional): Provide a function to decorate all methods.
  ///
  ///     Example:
  ///         ::
  ///
  ///             @v_args(inline=True)
  ///             class SolveArith(Transformer):
  ///                 def add(self, left, right):
  ///                     return left + right
  ///
  ///                 @v_args(meta=True)
  ///                 def mul(self, meta, children):
  ///                     logger.info(f'mul at line {meta.line}')
  ///                     left, right = children
  ///                     return left * right
  ///
  ///
  ///             class ReverseNotation(Transformer_InPlace):
  ///                 @v_args(tree=True)
  ///                 def tree_node(self, tree):
  ///                     tree.children = tree.children[::-1]
  ///     """
  ///     if tree and (meta or inline):
  ///         raise ValueError("Visitor functions cannot combine 'tree' with 'meta' or 'inline'.")
  ///
  ///     func = None
  ///     if meta:
  ///         if inline:
  ///             func = _vargs_meta_inline
  ///         else:
  ///             func = _vargs_meta
  ///     elif inline:
  ///         func = _vargs_inline
  ///     elif tree:
  ///         func = _vargs_tree
  ///
  ///     if wrapper is not None:
  ///         if func is not None:
  ///             raise ValueError("Cannot use 'wrapper' along with 'tree', 'meta' or 'inline'.")
  ///         func = wrapper
  ///
  ///     def _visitor_args_dec(obj):
  ///         return _apply_v_args(obj, func)
  ///     return _visitor_args_dec
  /// ```
  Object? Function(Object?) v_args({
    bool inline = false,
    bool meta = false,
    bool tree = false,
    Object? wrapper,
  }) =>
      PythonFunction.from(
        getFunction("v_args").call(
          <Object?>[
            inline,
            meta,
            tree,
            wrapper,
          ],
          kwargs: <String, Object?>{},
        ),
      ).asFunction(
        (PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?> f) =>
            (Object? x0) => f.call(<Object?>[x0]),
      );

  /// ## visit_children_decor
  ///
  /// ### python docstring
  ///
  /// See Interpreter
  ///
  /// ### python source
  /// ```py
  /// def visit_children_decor(func: _InterMethod) -> _InterMethod:
  ///     "See Interpreter"
  ///     @wraps(func)
  ///     def inner(cls, tree):
  ///         values = cls.visit_children(tree)
  ///         return func(cls, values)
  ///     return inner
  /// ```
  Object? Function(Object?, Object?) visit_children_decor({
    required Object? Function(Object?, Object?) func,
  }) =>
      PythonFunction.from(
        getFunction("visit_children_decor").call(
          <Object?>[
            func.generic2,
          ],
          kwargs: <String, Object?>{},
        ),
      ).asFunction(
        (PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?> f) =>
            (Object? x0, Object? x1) => f.call(<Object?>[x0, x1]),
      );

  /// ## Discard (getter)
  Object? get Discard => getAttribute("Discard");

  /// ## Discard (setter)
  set Discard(Object? Discard) => setAttribute("Discard", Discard);
}
