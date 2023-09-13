// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library tree_templates;

import "package:python_ffi/python_ffi.dart";

/// ## MissingVariableError
///
/// ### python source
/// ```py
/// class MissingVariableError(LarkError):
///     pass
/// ```
final class MissingVariableError extends PythonClass {
  factory MissingVariableError() => PythonFfi.instance.importClass(
        "lark.tree_templates",
        "MissingVariableError",
        MissingVariableError.from,
        <Object?>[],
      );

  MissingVariableError.from(super.pythonClass) : super.from();

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

/// ## Template
///
/// ### python docstring
///
/// Represents a tree template, tied to a specific configuration
///
/// A tree template is a tree that contains nodes that are template variables.
/// Those variables will match any tree.
/// (future versions may support annotations on the variables, to allow more complex templates)
///
/// ### python source
/// ```py
/// class Template:
///     """Represents a tree template, tied to a specific configuration
///
///     A tree template is a tree that contains nodes that are template variables.
///     Those variables will match any tree.
///     (future versions may support annotations on the variables, to allow more complex templates)
///     """
///
///     def __init__(self, tree: Tree[str], conf: TemplateConf = TemplateConf()):
///         self.conf = conf
///         self.tree = conf._get_tree(tree)
///
///     def match(self, tree: TreeOrCode) -> Optional[MatchResult]:
///         """Match a tree template to a tree.
///
///         A tree template without variables will only match ``tree`` if it is equal to the template.
///
///         Parameters:
///             tree (Tree): The tree to match to the template
///
///         Returns:
///             Optional[Dict[str, Tree]]: If match is found, returns a dictionary mapping
///                 template variable names to their matching tree nodes.
///                 If no match was found, returns None.
///         """
///         tree = self.conf._get_tree(tree)
///         return self.conf._match_tree_template(self.tree, tree)
///
///     def search(self, tree: TreeOrCode) -> Iterator[Tuple[Tree[str], MatchResult]]:
///         """Search for all occurrences of the tree template inside ``tree``.
///         """
///         tree = self.conf._get_tree(tree)
///         for subtree in tree.iter_subtrees():
///             res = self.match(subtree)
///             if res:
///                 yield subtree, res
///
///     def apply_vars(self, vars: Mapping[str, Tree[str]]) -> Tree[str]:
///         """Apply vars to the template tree
///         """
///         return _ReplaceVars(self.conf, vars).transform(self.tree)
/// ```
final class Template extends PythonClass {
  factory Template({
    required Object? tree,
    TemplateConf conf,
  }) =>
      PythonFfi.instance.importClass(
        "lark.tree_templates",
        "Template",
        Template.from,
        <Object?>[
          tree,
          conf,
        ],
        <String, Object?>{},
      );

  Template.from(super.pythonClass) : super.from();

  /// ## apply_vars
  ///
  /// ### python docstring
  ///
  /// Apply vars to the template tree
  ///
  /// ### python source
  /// ```py
  /// def apply_vars(self, vars: Mapping[str, Tree[str]]) -> Tree[str]:
  ///         """Apply vars to the template tree
  ///         """
  ///         return _ReplaceVars(self.conf, vars).transform(self.tree)
  /// ```
  Object? apply_vars({
    required Object? vars,
  }) =>
      getFunction("apply_vars").call(
        <Object?>[
          vars,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## match
  ///
  /// ### python docstring
  ///
  /// Match a tree template to a tree.
  ///
  /// A tree template without variables will only match ``tree`` if it is equal to the template.
  ///
  /// Parameters:
  ///     tree (Tree): The tree to match to the template
  ///
  /// Returns:
  ///     Optional[Dict[str, Tree]]: If match is found, returns a dictionary mapping
  ///         template variable names to their matching tree nodes.
  ///         If no match was found, returns None.
  ///
  /// ### python source
  /// ```py
  /// def match(self, tree: TreeOrCode) -> Optional[MatchResult]:
  ///         """Match a tree template to a tree.
  ///
  ///         A tree template without variables will only match ``tree`` if it is equal to the template.
  ///
  ///         Parameters:
  ///             tree (Tree): The tree to match to the template
  ///
  ///         Returns:
  ///             Optional[Dict[str, Tree]]: If match is found, returns a dictionary mapping
  ///                 template variable names to their matching tree nodes.
  ///                 If no match was found, returns None.
  ///         """
  ///         tree = self.conf._get_tree(tree)
  ///         return self.conf._match_tree_template(self.tree, tree)
  /// ```
  Object? match({
    required Object? tree,
  }) =>
      getFunction("match").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## search
  ///
  /// ### python docstring
  ///
  /// Search for all occurrences of the tree template inside ``tree``.
  ///
  /// ### python source
  /// ```py
  /// def search(self, tree: TreeOrCode) -> Iterator[Tuple[Tree[str], MatchResult]]:
  ///         """Search for all occurrences of the tree template inside ``tree``.
  ///         """
  ///         tree = self.conf._get_tree(tree)
  ///         for subtree in tree.iter_subtrees():
  ///             res = self.match(subtree)
  ///             if res:
  ///                 yield subtree, res
  /// ```
  Iterator<Object?> search({
    required Object? tree,
  }) =>
      TypedIterator.from(
        PythonIterator.from<Object?, PythonFfiDelegate<Object?>, Object?>(
          getFunction("search").call(
            <Object?>[
              tree,
            ],
            kwargs: <String, Object?>{},
          ),
        ),
      ).transform((e) => e).cast<Object?>();

  /// ## conf (getter)
  ///
  /// ### python docstring
  ///
  /// Represents a tree template, tied to a specific configuration
  ///
  /// A tree template is a tree that contains nodes that are template variables.
  /// Those variables will match any tree.
  /// (future versions may support annotations on the variables, to allow more complex templates)
  Object? get conf => getAttribute("conf");

  /// ## conf (setter)
  ///
  /// ### python docstring
  ///
  /// Represents a tree template, tied to a specific configuration
  ///
  /// A tree template is a tree that contains nodes that are template variables.
  /// Those variables will match any tree.
  /// (future versions may support annotations on the variables, to allow more complex templates)
  set conf(Object? conf) => setAttribute("conf", conf);

  /// ## tree (getter)
  ///
  /// ### python docstring
  ///
  /// Represents a tree template, tied to a specific configuration
  ///
  /// A tree template is a tree that contains nodes that are template variables.
  /// Those variables will match any tree.
  /// (future versions may support annotations on the variables, to allow more complex templates)
  Object? get tree => getAttribute("tree");

  /// ## tree (setter)
  ///
  /// ### python docstring
  ///
  /// Represents a tree template, tied to a specific configuration
  ///
  /// A tree template is a tree that contains nodes that are template variables.
  /// Those variables will match any tree.
  /// (future versions may support annotations on the variables, to allow more complex templates)
  set tree(Object? tree) => setAttribute("tree", tree);
}

/// ## TemplateConf
///
/// ### python docstring
///
/// Template Configuration
///
/// Allows customization for different uses of Template
///
/// parse() must return a Tree instance.
///
/// ### python source
/// ```py
/// class TemplateConf:
///     """Template Configuration
///
///     Allows customization for different uses of Template
///
///     parse() must return a Tree instance.
///     """
///
///     def __init__(self, parse=None):
///         self._parse = parse
///
///     def test_var(self, var: Union[Tree[str], str]) -> Optional[str]:
///         """Given a tree node, if it is a template variable return its name. Otherwise, return None.
///
///         This method may be overridden for customization
///
///         Parameters:
///             var: Tree | str - The tree node to test
///
///         """
///         if isinstance(var, str):
///             return _get_template_name(var)
///
///         if (
///             isinstance(var, Tree)
///             and var.data == "var"
///             and len(var.children) > 0
///             and isinstance(var.children[0], str)
///         ):
///             return _get_template_name(var.children[0])
///
///         return None
///
///     def _get_tree(self, template: TreeOrCode) -> Tree[str]:
///         if isinstance(template, str):
///             assert self._parse
///             template = self._parse(template)
///
///         if not isinstance(template, Tree):
///             raise TypeError("template parser must return a Tree instance")
///
///         return template
///
///     def __call__(self, template: Tree[str]) -> 'Template':
///         return Template(template, conf=self)
///
///     def _match_tree_template(self, template: TreeOrCode, tree: Branch) -> Optional[MatchResult]:
///         """Returns dict of {var: match} if found a match, else None
///         """
///         template_var = self.test_var(template)
///         if template_var:
///             if not isinstance(tree, Tree):
///                 raise TypeError(f"Template variables can only match Tree instances. Not {tree!r}")
///             return {template_var: tree}
///
///         if isinstance(template, str):
///             if template == tree:
///                 return {}
///             return None
///
///         assert isinstance(template, Tree) and isinstance(tree, Tree), f"template={template} tree={tree}"
///
///         if template.data == tree.data and len(template.children) == len(tree.children):
///             res = {}
///             for t1, t2 in zip(template.children, tree.children):
///                 matches = self._match_tree_template(t1, t2)
///                 if matches is None:
///                     return None
///
///                 res.update(matches)
///
///             return res
///
///         return None
/// ```
final class TemplateConf extends PythonClass {
  factory TemplateConf({
    Object? parse,
  }) =>
      PythonFfi.instance.importClass(
        "lark.tree_templates",
        "TemplateConf",
        TemplateConf.from,
        <Object?>[
          parse,
        ],
        <String, Object?>{},
      );

  TemplateConf.from(super.pythonClass) : super.from();

  /// ## test_var
  ///
  /// ### python docstring
  ///
  /// Given a tree node, if it is a template variable return its name. Otherwise, return None.
  ///
  /// This method may be overridden for customization
  ///
  /// Parameters:
  ///     var: Tree | str - The tree node to test
  ///
  /// ### python source
  /// ```py
  /// def test_var(self, var: Union[Tree[str], str]) -> Optional[str]:
  ///         """Given a tree node, if it is a template variable return its name. Otherwise, return None.
  ///
  ///         This method may be overridden for customization
  ///
  ///         Parameters:
  ///             var: Tree | str - The tree node to test
  ///
  ///         """
  ///         if isinstance(var, str):
  ///             return _get_template_name(var)
  ///
  ///         if (
  ///             isinstance(var, Tree)
  ///             and var.data == "var"
  ///             and len(var.children) > 0
  ///             and isinstance(var.children[0], str)
  ///         ):
  ///             return _get_template_name(var.children[0])
  ///
  ///         return None
  /// ```
  Object? test_var({
    required Object? $var,
  }) =>
      getFunction("test_var").call(
        <Object?>[
          $var,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## TemplateTranslator
///
/// ### python docstring
///
/// Utility class for translating a collection of patterns
///
/// ### python source
/// ```py
/// class TemplateTranslator:
///     """Utility class for translating a collection of patterns
///     """
///
///     def __init__(self, translations: Mapping[Template, Template]):
///         assert all(isinstance(k, Template) and isinstance(v, Template) for k, v in translations.items())
///         self.translations = translations
///
///     def translate(self, tree: Tree[str]):
///         for k, v in self.translations.items():
///             tree = translate(k, v, tree)
///         return tree
/// ```
final class TemplateTranslator extends PythonClass {
  factory TemplateTranslator({
    required Object? translations,
  }) =>
      PythonFfi.instance.importClass(
        "lark.tree_templates",
        "TemplateTranslator",
        TemplateTranslator.from,
        <Object?>[
          translations,
        ],
        <String, Object?>{},
      );

  TemplateTranslator.from(super.pythonClass) : super.from();

  /// ## translate
  ///
  /// ### python source
  /// ```py
  /// def translate(self, tree: Tree[str]):
  ///         for k, v in self.translations.items():
  ///             tree = translate(k, v, tree)
  ///         return tree
  /// ```
  Object? translate({
    required Object? tree,
  }) =>
      getFunction("translate").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## translations (getter)
  ///
  /// ### python docstring
  ///
  /// Utility class for translating a collection of patterns
  Object? get translations => getAttribute("translations");

  /// ## translations (setter)
  ///
  /// ### python docstring
  ///
  /// Utility class for translating a collection of patterns
  set translations(Object? translations) =>
      setAttribute("translations", translations);
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
        "lark.tree_templates",
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
      PythonFfi.instance.importClass(
        "lark.tree_templates",
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

/// ## tree_templates
///
/// ### python docstring
///
/// This module defines utilities for matching and translation tree templates.
///
/// A tree templates is a tree that contains nodes that are template variables.
///
/// ### python source
/// ```py
/// """This module defines utilities for matching and translation tree templates.
///
/// A tree templates is a tree that contains nodes that are template variables.
///
/// """
///
/// from typing import Union, Optional, Mapping, Dict, Tuple, Iterator
///
/// from lark import Tree, Transformer
/// from lark.exceptions import MissingVariableError
///
/// Branch = Union[Tree[str], str]
/// TreeOrCode = Union[Tree[str], str]
/// MatchResult = Dict[str, Tree]
/// _TEMPLATE_MARKER = '$'
///
///
/// class TemplateConf:
///     """Template Configuration
///
///     Allows customization for different uses of Template
///
///     parse() must return a Tree instance.
///     """
///
///     def __init__(self, parse=None):
///         self._parse = parse
///
///     def test_var(self, var: Union[Tree[str], str]) -> Optional[str]:
///         """Given a tree node, if it is a template variable return its name. Otherwise, return None.
///
///         This method may be overridden for customization
///
///         Parameters:
///             var: Tree | str - The tree node to test
///
///         """
///         if isinstance(var, str):
///             return _get_template_name(var)
///
///         if (
///             isinstance(var, Tree)
///             and var.data == "var"
///             and len(var.children) > 0
///             and isinstance(var.children[0], str)
///         ):
///             return _get_template_name(var.children[0])
///
///         return None
///
///     def _get_tree(self, template: TreeOrCode) -> Tree[str]:
///         if isinstance(template, str):
///             assert self._parse
///             template = self._parse(template)
///
///         if not isinstance(template, Tree):
///             raise TypeError("template parser must return a Tree instance")
///
///         return template
///
///     def __call__(self, template: Tree[str]) -> 'Template':
///         return Template(template, conf=self)
///
///     def _match_tree_template(self, template: TreeOrCode, tree: Branch) -> Optional[MatchResult]:
///         """Returns dict of {var: match} if found a match, else None
///         """
///         template_var = self.test_var(template)
///         if template_var:
///             if not isinstance(tree, Tree):
///                 raise TypeError(f"Template variables can only match Tree instances. Not {tree!r}")
///             return {template_var: tree}
///
///         if isinstance(template, str):
///             if template == tree:
///                 return {}
///             return None
///
///         assert isinstance(template, Tree) and isinstance(tree, Tree), f"template={template} tree={tree}"
///
///         if template.data == tree.data and len(template.children) == len(tree.children):
///             res = {}
///             for t1, t2 in zip(template.children, tree.children):
///                 matches = self._match_tree_template(t1, t2)
///                 if matches is None:
///                     return None
///
///                 res.update(matches)
///
///             return res
///
///         return None
///
///
/// class _ReplaceVars(Transformer[str, Tree[str]]):
///     def __init__(self, conf: TemplateConf, vars: Mapping[str, Tree[str]]) -> None:
///         super().__init__()
///         self._conf = conf
///         self._vars = vars
///
///     def __default__(self, data, children, meta) -> Tree[str]:
///         tree = super().__default__(data, children, meta)
///
///         var = self._conf.test_var(tree)
///         if var:
///             try:
///                 return self._vars[var]
///             except KeyError:
///                 raise MissingVariableError(f"No mapping for template variable ({var})")
///         return tree
///
///
/// class Template:
///     """Represents a tree template, tied to a specific configuration
///
///     A tree template is a tree that contains nodes that are template variables.
///     Those variables will match any tree.
///     (future versions may support annotations on the variables, to allow more complex templates)
///     """
///
///     def __init__(self, tree: Tree[str], conf: TemplateConf = TemplateConf()):
///         self.conf = conf
///         self.tree = conf._get_tree(tree)
///
///     def match(self, tree: TreeOrCode) -> Optional[MatchResult]:
///         """Match a tree template to a tree.
///
///         A tree template without variables will only match ``tree`` if it is equal to the template.
///
///         Parameters:
///             tree (Tree): The tree to match to the template
///
///         Returns:
///             Optional[Dict[str, Tree]]: If match is found, returns a dictionary mapping
///                 template variable names to their matching tree nodes.
///                 If no match was found, returns None.
///         """
///         tree = self.conf._get_tree(tree)
///         return self.conf._match_tree_template(self.tree, tree)
///
///     def search(self, tree: TreeOrCode) -> Iterator[Tuple[Tree[str], MatchResult]]:
///         """Search for all occurrences of the tree template inside ``tree``.
///         """
///         tree = self.conf._get_tree(tree)
///         for subtree in tree.iter_subtrees():
///             res = self.match(subtree)
///             if res:
///                 yield subtree, res
///
///     def apply_vars(self, vars: Mapping[str, Tree[str]]) -> Tree[str]:
///         """Apply vars to the template tree
///         """
///         return _ReplaceVars(self.conf, vars).transform(self.tree)
///
///
/// def translate(t1: Template, t2: Template, tree: TreeOrCode):
///     """Search tree and translate each occurrence of t1 into t2.
///     """
///     tree = t1.conf._get_tree(tree)      # ensure it's a tree, parse if necessary and possible
///     for subtree, vars in t1.search(tree):
///         res = t2.apply_vars(vars)
///         subtree.set(res.data, res.children)
///     return tree
///
///
/// class TemplateTranslator:
///     """Utility class for translating a collection of patterns
///     """
///
///     def __init__(self, translations: Mapping[Template, Template]):
///         assert all(isinstance(k, Template) and isinstance(v, Template) for k, v in translations.items())
///         self.translations = translations
///
///     def translate(self, tree: Tree[str]):
///         for k, v in self.translations.items():
///             tree = translate(k, v, tree)
///         return tree
///
///
/// def _get_template_name(value: str) -> Optional[str]:
///     return value.lstrip(_TEMPLATE_MARKER) if value.startswith(_TEMPLATE_MARKER) else None
/// ```
final class tree_templates extends PythonModule {
  tree_templates.from(super.pythonModule) : super.from();

  static tree_templates import() => PythonFfi.instance.importModule(
        "lark.tree_templates",
        tree_templates.from,
      );

  /// ## translate
  ///
  /// ### python docstring
  ///
  /// Search tree and translate each occurrence of t1 into t2.
  ///
  /// ### python source
  /// ```py
  /// def translate(t1: Template, t2: Template, tree: TreeOrCode):
  ///     """Search tree and translate each occurrence of t1 into t2.
  ///     """
  ///     tree = t1.conf._get_tree(tree)      # ensure it's a tree, parse if necessary and possible
  ///     for subtree, vars in t1.search(tree):
  ///         res = t2.apply_vars(vars)
  ///         subtree.set(res.data, res.children)
  ///     return tree
  /// ```
  Object? translate({
    required Template t1,
    required Template t2,
    required Object? tree,
  }) =>
      getFunction("translate").call(
        <Object?>[
          t1,
          t2,
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## Branch (getter)
  ///
  /// ### python docstring
  ///
  /// This module defines utilities for matching and translation tree templates.
  ///
  /// A tree templates is a tree that contains nodes that are template variables.
  Object? get Branch => getAttribute("Branch");

  /// ## Branch (setter)
  ///
  /// ### python docstring
  ///
  /// This module defines utilities for matching and translation tree templates.
  ///
  /// A tree templates is a tree that contains nodes that are template variables.
  set Branch(Object? Branch) => setAttribute("Branch", Branch);

  /// ## Dict (getter)
  ///
  /// ### python docstring
  ///
  /// This module defines utilities for matching and translation tree templates.
  ///
  /// A tree templates is a tree that contains nodes that are template variables.
  Object? get Dict => getAttribute("Dict");

  /// ## Dict (setter)
  ///
  /// ### python docstring
  ///
  /// This module defines utilities for matching and translation tree templates.
  ///
  /// A tree templates is a tree that contains nodes that are template variables.
  set Dict(Object? Dict) => setAttribute("Dict", Dict);

  /// ## Iterator (getter)
  ///
  /// ### python docstring
  ///
  /// This module defines utilities for matching and translation tree templates.
  ///
  /// A tree templates is a tree that contains nodes that are template variables.
  Object? get $Iterator => getAttribute("Iterator");

  /// ## Iterator (setter)
  ///
  /// ### python docstring
  ///
  /// This module defines utilities for matching and translation tree templates.
  ///
  /// A tree templates is a tree that contains nodes that are template variables.
  set $Iterator(Object? $Iterator) => setAttribute("Iterator", $Iterator);

  /// ## Mapping (getter)
  ///
  /// ### python docstring
  ///
  /// This module defines utilities for matching and translation tree templates.
  ///
  /// A tree templates is a tree that contains nodes that are template variables.
  Object? get Mapping => getAttribute("Mapping");

  /// ## Mapping (setter)
  ///
  /// ### python docstring
  ///
  /// This module defines utilities for matching and translation tree templates.
  ///
  /// A tree templates is a tree that contains nodes that are template variables.
  set Mapping(Object? Mapping) => setAttribute("Mapping", Mapping);

  /// ## MatchResult (getter)
  ///
  /// ### python docstring
  ///
  /// This module defines utilities for matching and translation tree templates.
  ///
  /// A tree templates is a tree that contains nodes that are template variables.
  Object? get MatchResult => getAttribute("MatchResult");

  /// ## MatchResult (setter)
  ///
  /// ### python docstring
  ///
  /// This module defines utilities for matching and translation tree templates.
  ///
  /// A tree templates is a tree that contains nodes that are template variables.
  set MatchResult(Object? MatchResult) =>
      setAttribute("MatchResult", MatchResult);

  /// ## Optional (getter)
  ///
  /// ### python docstring
  ///
  /// This module defines utilities for matching and translation tree templates.
  ///
  /// A tree templates is a tree that contains nodes that are template variables.
  Object? get Optional => getAttribute("Optional");

  /// ## Optional (setter)
  ///
  /// ### python docstring
  ///
  /// This module defines utilities for matching and translation tree templates.
  ///
  /// A tree templates is a tree that contains nodes that are template variables.
  set Optional(Object? Optional) => setAttribute("Optional", Optional);

  /// ## Tuple (getter)
  ///
  /// ### python docstring
  ///
  /// This module defines utilities for matching and translation tree templates.
  ///
  /// A tree templates is a tree that contains nodes that are template variables.
  Object? get Tuple => getAttribute("Tuple");

  /// ## Tuple (setter)
  ///
  /// ### python docstring
  ///
  /// This module defines utilities for matching and translation tree templates.
  ///
  /// A tree templates is a tree that contains nodes that are template variables.
  set Tuple(Object? Tuple) => setAttribute("Tuple", Tuple);

  /// ## Union (getter)
  ///
  /// ### python docstring
  ///
  /// This module defines utilities for matching and translation tree templates.
  ///
  /// A tree templates is a tree that contains nodes that are template variables.
  Object? get Union => getAttribute("Union");

  /// ## Union (setter)
  ///
  /// ### python docstring
  ///
  /// This module defines utilities for matching and translation tree templates.
  ///
  /// A tree templates is a tree that contains nodes that are template variables.
  set Union(Object? Union) => setAttribute("Union", Union);
}
