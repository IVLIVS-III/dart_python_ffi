// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library earley_forest;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## AmbiguousIntermediateExpander
///
/// ### python docstring
///
/// Propagate ambiguous intermediate nodes and their derivations up to the
/// current rule.
///
/// In general, converts
///
/// rule
///   _iambig
///     _inter
///       someChildren1
///       ...
///     _inter
///       someChildren2
///       ...
///   someChildren3
///   ...
///
/// to
///
/// _ambig
///   rule
///     someChildren1
///     ...
///     someChildren3
///     ...
///   rule
///     someChildren2
///     ...
///     someChildren3
///     ...
///   rule
///     childrenFromNestedIambigs
///     ...
///     someChildren3
///     ...
///   ...
///
/// propagating up any nested '_iambig' nodes along the way.
///
/// ### python source
/// ```py
/// class AmbiguousIntermediateExpander:
///     """
///     Propagate ambiguous intermediate nodes and their derivations up to the
///     current rule.
///
///     In general, converts
///
///     rule
///       _iambig
///         _inter
///           someChildren1
///           ...
///         _inter
///           someChildren2
///           ...
///       someChildren3
///       ...
///
///     to
///
///     _ambig
///       rule
///         someChildren1
///         ...
///         someChildren3
///         ...
///       rule
///         someChildren2
///         ...
///         someChildren3
///         ...
///       rule
///         childrenFromNestedIambigs
///         ...
///         someChildren3
///         ...
///       ...
///
///     propagating up any nested '_iambig' nodes along the way.
///     """
///
///     def __init__(self, tree_class, node_builder):
///         self.node_builder = node_builder
///         self.tree_class = tree_class
///
///     def __call__(self, children):
///         def _is_iambig_tree(child):
///             return hasattr(child, 'data') and child.data == '_iambig'
///
///         def _collapse_iambig(children):
///             """
///             Recursively flatten the derivations of the parent of an '_iambig'
///             node. Returns a list of '_inter' nodes guaranteed not
///             to contain any nested '_iambig' nodes, or None if children does
///             not contain an '_iambig' node.
///             """
///
///             # Due to the structure of the SPPF,
///             # an '_iambig' node can only appear as the first child
///             if children and _is_iambig_tree(children[0]):
///                 iambig_node = children[0]
///                 result = []
///                 for grandchild in iambig_node.children:
///                     collapsed = _collapse_iambig(grandchild.children)
///                     if collapsed:
///                         for child in collapsed:
///                             child.children += children[1:]
///                         result += collapsed
///                     else:
///                         new_tree = self.tree_class('_inter', grandchild.children + children[1:])
///                         result.append(new_tree)
///                 return result
///
///         collapsed = _collapse_iambig(children)
///         if collapsed:
///             processed_nodes = [self.node_builder(c.children) for c in collapsed]
///             return self.tree_class('_ambig', processed_nodes)
///
///         return self.node_builder(children)
/// ```
final class AmbiguousIntermediateExpander extends PythonClass {
  factory AmbiguousIntermediateExpander({
    required Object? tree_class,
    required Object? node_builder,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parse_tree_builder",
        "AmbiguousIntermediateExpander",
        AmbiguousIntermediateExpander.from,
        <Object?>[
          tree_class,
          node_builder,
        ],
        <String, Object?>{},
      );

  AmbiguousIntermediateExpander.from(super.pythonClass) : super.from();

  /// ## node_builder (getter)
  ///
  /// ### python docstring
  ///
  /// Propagate ambiguous intermediate nodes and their derivations up to the
  /// current rule.
  ///
  /// In general, converts
  ///
  /// rule
  ///   _iambig
  ///     _inter
  ///       someChildren1
  ///       ...
  ///     _inter
  ///       someChildren2
  ///       ...
  ///   someChildren3
  ///   ...
  ///
  /// to
  ///
  /// _ambig
  ///   rule
  ///     someChildren1
  ///     ...
  ///     someChildren3
  ///     ...
  ///   rule
  ///     someChildren2
  ///     ...
  ///     someChildren3
  ///     ...
  ///   rule
  ///     childrenFromNestedIambigs
  ///     ...
  ///     someChildren3
  ///     ...
  ///   ...
  ///
  /// propagating up any nested '_iambig' nodes along the way.
  Object? get node_builder => getAttribute("node_builder");

  /// ## node_builder (setter)
  ///
  /// ### python docstring
  ///
  /// Propagate ambiguous intermediate nodes and their derivations up to the
  /// current rule.
  ///
  /// In general, converts
  ///
  /// rule
  ///   _iambig
  ///     _inter
  ///       someChildren1
  ///       ...
  ///     _inter
  ///       someChildren2
  ///       ...
  ///   someChildren3
  ///   ...
  ///
  /// to
  ///
  /// _ambig
  ///   rule
  ///     someChildren1
  ///     ...
  ///     someChildren3
  ///     ...
  ///   rule
  ///     someChildren2
  ///     ...
  ///     someChildren3
  ///     ...
  ///   rule
  ///     childrenFromNestedIambigs
  ///     ...
  ///     someChildren3
  ///     ...
  ///   ...
  ///
  /// propagating up any nested '_iambig' nodes along the way.
  set node_builder(Object? node_builder) =>
      setAttribute("node_builder", node_builder);

  /// ## tree_class (getter)
  ///
  /// ### python docstring
  ///
  /// Propagate ambiguous intermediate nodes and their derivations up to the
  /// current rule.
  ///
  /// In general, converts
  ///
  /// rule
  ///   _iambig
  ///     _inter
  ///       someChildren1
  ///       ...
  ///     _inter
  ///       someChildren2
  ///       ...
  ///   someChildren3
  ///   ...
  ///
  /// to
  ///
  /// _ambig
  ///   rule
  ///     someChildren1
  ///     ...
  ///     someChildren3
  ///     ...
  ///   rule
  ///     someChildren2
  ///     ...
  ///     someChildren3
  ///     ...
  ///   rule
  ///     childrenFromNestedIambigs
  ///     ...
  ///     someChildren3
  ///     ...
  ///   ...
  ///
  /// propagating up any nested '_iambig' nodes along the way.
  Object? get tree_class => getAttribute("tree_class");

  /// ## tree_class (setter)
  ///
  /// ### python docstring
  ///
  /// Propagate ambiguous intermediate nodes and their derivations up to the
  /// current rule.
  ///
  /// In general, converts
  ///
  /// rule
  ///   _iambig
  ///     _inter
  ///       someChildren1
  ///       ...
  ///     _inter
  ///       someChildren2
  ///       ...
  ///   someChildren3
  ///   ...
  ///
  /// to
  ///
  /// _ambig
  ///   rule
  ///     someChildren1
  ///     ...
  ///     someChildren3
  ///     ...
  ///   rule
  ///     someChildren2
  ///     ...
  ///     someChildren3
  ///     ...
  ///   rule
  ///     childrenFromNestedIambigs
  ///     ...
  ///     someChildren3
  ///     ...
  ///   ...
  ///
  /// propagating up any nested '_iambig' nodes along the way.
  set tree_class(Object? tree_class) => setAttribute("tree_class", tree_class);
}

/// ## ForestNode
///
/// ### python source
/// ```py
/// class ForestNode:
///     pass
/// ```
final class ForestNode extends PythonClass {
  factory ForestNode() => PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
        "ForestNode",
        ForestNode.from,
        <Object?>[],
      );

  ForestNode.from(super.pythonClass) : super.from();
}

/// ## ForestSumVisitor
///
/// ### python docstring
///
/// A visitor for prioritizing ambiguous parts of the Forest.
///
/// This visitor is used when support for explicit priorities on
/// rules is requested (whether normal, or invert). It walks the
/// forest (or subsets thereof) and cascades properties upwards
/// from the leaves.
///
/// It would be ideal to do this during parsing, however this would
/// require processing each Earley item multiple times. That's
/// a big performance drawback; so running a forest walk is the
/// lesser of two evils: there can be significantly more Earley
/// items created during parsing than there are SPPF nodes in the
/// final tree.
///
/// ### python source
/// ```py
/// class ForestSumVisitor(ForestVisitor):
///     """
///     A visitor for prioritizing ambiguous parts of the Forest.
///
///     This visitor is used when support for explicit priorities on
///     rules is requested (whether normal, or invert). It walks the
///     forest (or subsets thereof) and cascades properties upwards
///     from the leaves.
///
///     It would be ideal to do this during parsing, however this would
///     require processing each Earley item multiple times. That's
///     a big performance drawback; so running a forest walk is the
///     lesser of two evils: there can be significantly more Earley
///     items created during parsing than there are SPPF nodes in the
///     final tree.
///     """
///     def __init__(self):
///         super(ForestSumVisitor, self).__init__(single_visit=True)
///
///     def visit_packed_node_in(self, node):
///         yield node.left
///         yield node.right
///
///     def visit_symbol_node_in(self, node):
///         return iter(node.children)
///
///     def visit_packed_node_out(self, node):
///         priority = node.rule.options.priority if not node.parent.is_intermediate and node.rule.options.priority else 0
///         priority += getattr(node.right, 'priority', 0)
///         priority += getattr(node.left, 'priority', 0)
///         node.priority = priority
///
///     def visit_symbol_node_out(self, node):
///         node.priority = max(child.priority for child in node.children)
/// ```
final class ForestSumVisitor extends PythonClass {
  factory ForestSumVisitor() => PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
        "ForestSumVisitor",
        ForestSumVisitor.from,
        <Object?>[],
        <String, Object?>{},
      );

  ForestSumVisitor.from(super.pythonClass) : super.from();

  /// ## get_cycle_in_path
  ///
  /// ### python docstring
  ///
  /// A utility function for use in ``on_cycle`` to obtain a slice of
  /// ``path`` that only contains the nodes that make up the cycle.
  ///
  /// ### python source
  /// ```py
  /// def get_cycle_in_path(self, node, path):
  ///         """A utility function for use in ``on_cycle`` to obtain a slice of
  ///         ``path`` that only contains the nodes that make up the cycle."""
  ///         index = len(path) - 1
  ///         while id(path[index]) != id(node):
  ///             index -= 1
  ///         return path[index:]
  /// ```
  Object? get_cycle_in_path({
    required Object? node,
    required Object? path,
  }) =>
      getFunction("get_cycle_in_path").call(
        <Object?>[
          node,
          path,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## on_cycle
  ///
  /// ### python docstring
  ///
  /// Called when a cycle is encountered.
  ///
  /// Parameters:
  ///     node: The node that causes a cycle.
  ///     path: The list of nodes being visited: nodes that have been
  ///         entered but not exited. The first element is the root in a forest
  ///         visit, and the last element is the node visited most recently.
  ///         ``path`` should be treated as read-only.
  ///
  /// ### python source
  /// ```py
  /// def on_cycle(self, node, path):
  ///         """Called when a cycle is encountered.
  ///
  ///         Parameters:
  ///             node: The node that causes a cycle.
  ///             path: The list of nodes being visited: nodes that have been
  ///                 entered but not exited. The first element is the root in a forest
  ///                 visit, and the last element is the node visited most recently.
  ///                 ``path`` should be treated as read-only.
  ///         """
  ///         pass
  /// ```
  Object? on_cycle({
    required Object? node,
    required Object? path,
  }) =>
      getFunction("on_cycle").call(
        <Object?>[
          node,
          path,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit
  ///
  /// ### python source
  /// ```py
  /// def visit(self, root):
  ///         # Visiting is a list of IDs of all symbol/intermediate nodes currently in
  ///         # the stack. It serves two purposes: to detect when we 'recurse' in and out
  ///         # of a symbol/intermediate so that we can process both up and down. Also,
  ///         # since the SPPF can have cycles it allows us to detect if we're trying
  ///         # to recurse into a node that's already on the stack (infinite recursion).
  ///         visiting = set()
  ///
  ///         # set of all nodes that have been visited
  ///         visited = set()
  ///
  ///         # a list of nodes that are currently being visited
  ///         # used for the `on_cycle` callback
  ///         path = []
  ///
  ///         # We do not use recursion here to walk the Forest due to the limited
  ///         # stack size in python. Therefore input_stack is essentially our stack.
  ///         input_stack = deque([root])
  ///
  ///         # It is much faster to cache these as locals since they are called
  ///         # many times in large parses.
  ///         vpno = getattr(self, 'visit_packed_node_out')
  ///         vpni = getattr(self, 'visit_packed_node_in')
  ///         vsno = getattr(self, 'visit_symbol_node_out')
  ///         vsni = getattr(self, 'visit_symbol_node_in')
  ///         vino = getattr(self, 'visit_intermediate_node_out', vsno)
  ///         vini = getattr(self, 'visit_intermediate_node_in', vsni)
  ///         vtn = getattr(self, 'visit_token_node')
  ///         oc = getattr(self, 'on_cycle')
  ///
  ///         while input_stack:
  ///             current = next(reversed(input_stack))
  ///             try:
  ///                 next_node = next(current)
  ///             except StopIteration:
  ///                 input_stack.pop()
  ///                 continue
  ///             except TypeError:
  ///                 ### If the current object is not an iterator, pass through to Token/SymbolNode
  ///                 pass
  ///             else:
  ///                 if next_node is None:
  ///                     continue
  ///
  ///                 if id(next_node) in visiting:
  ///                     oc(next_node, path)
  ///                     continue
  ///
  ///                 input_stack.append(next_node)
  ///                 continue
  ///
  ///             if isinstance(current, TokenNode):
  ///                 vtn(current.token)
  ///                 input_stack.pop()
  ///                 continue
  ///
  ///             current_id = id(current)
  ///             if current_id in visiting:
  ///                 if isinstance(current, PackedNode):
  ///                     vpno(current)
  ///                 elif current.is_intermediate:
  ///                     vino(current)
  ///                 else:
  ///                     vsno(current)
  ///                 input_stack.pop()
  ///                 path.pop()
  ///                 visiting.remove(current_id)
  ///                 visited.add(current_id)
  ///             elif self.single_visit and current_id in visited:
  ///                 input_stack.pop()
  ///             else:
  ///                 visiting.add(current_id)
  ///                 path.append(current)
  ///                 if isinstance(current, PackedNode):
  ///                     next_node = vpni(current)
  ///                 elif current.is_intermediate:
  ///                     next_node = vini(current)
  ///                 else:
  ///                     next_node = vsni(current)
  ///                 if next_node is None:
  ///                     continue
  ///
  ///                 if not isinstance(next_node, ForestNode):
  ///                     next_node = iter(next_node)
  ///                 elif id(next_node) in visiting:
  ///                     oc(next_node, path)
  ///                     continue
  ///
  ///                 input_stack.append(next_node)
  /// ```
  Object? visit({
    required Object? root,
  }) =>
      getFunction("visit").call(
        <Object?>[
          root,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_packed_node_in
  ///
  /// ### python docstring
  ///
  /// Called when a packed node is visited. Nodes that are returned
  /// will be scheduled to be visited.
  ///
  /// ### python source
  /// ```py
  /// def visit_packed_node_in(self, node):
  ///         yield node.left
  ///         yield node.right
  /// ```
  Object? visit_packed_node_in({
    required Object? node,
  }) =>
      getFunction("visit_packed_node_in").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_packed_node_out
  ///
  /// ### python docstring
  ///
  /// Called after all nodes returned from a corresponding ``visit_packed_node_in``
  /// call have been visited.
  ///
  /// ### python source
  /// ```py
  /// def visit_packed_node_out(self, node):
  ///         priority = node.rule.options.priority if not node.parent.is_intermediate and node.rule.options.priority else 0
  ///         priority += getattr(node.right, 'priority', 0)
  ///         priority += getattr(node.left, 'priority', 0)
  ///         node.priority = priority
  /// ```
  Object? visit_packed_node_out({
    required Object? node,
  }) =>
      getFunction("visit_packed_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_symbol_node_in
  ///
  /// ### python docstring
  ///
  /// Called when a symbol node is visited. Nodes that are returned
  /// will be scheduled to be visited. If ``visit_intermediate_node_in``
  /// is not implemented, this function will be called for intermediate
  /// nodes as well.
  ///
  /// ### python source
  /// ```py
  /// def visit_symbol_node_in(self, node):
  ///         return iter(node.children)
  /// ```
  Object? visit_symbol_node_in({
    required Object? node,
  }) =>
      getFunction("visit_symbol_node_in").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_symbol_node_out
  ///
  /// ### python docstring
  ///
  /// Called after all nodes returned from a corresponding ``visit_symbol_node_in``
  /// call have been visited. If ``visit_intermediate_node_out``
  /// is not implemented, this function will be called for intermediate
  /// nodes as well.
  ///
  /// ### python source
  /// ```py
  /// def visit_symbol_node_out(self, node):
  ///         node.priority = max(child.priority for child in node.children)
  /// ```
  Object? visit_symbol_node_out({
    required Object? node,
  }) =>
      getFunction("visit_symbol_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_token_node
  ///
  /// ### python docstring
  ///
  /// Called when a ``Token`` is visited. ``Token`` nodes are always leaves.
  ///
  /// ### python source
  /// ```py
  /// def visit_token_node(self, node):
  ///         """Called when a ``Token`` is visited. ``Token`` nodes are always leaves."""
  ///         pass
  /// ```
  Object? visit_token_node({
    required Object? node,
  }) =>
      getFunction("visit_token_node").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## ForestToParseTree
///
/// ### python docstring
///
/// Used by the earley parser when ambiguity equals 'resolve' or
/// 'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
///
/// Parameters:
///     tree_class: The tree class to use for construction
///     callbacks: A dictionary of rules to functions that output a tree
///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
///     resolve_ambiguity: If True, ambiguities will be resolved based on
///                     priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
///     use_cache: If True, the results of packed node transformations will be cached.
///
/// ### python source
/// ```py
/// class ForestToParseTree(ForestTransformer):
///     """Used by the earley parser when ambiguity equals 'resolve' or
///     'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
///
///     Parameters:
///         tree_class: The tree class to use for construction
///         callbacks: A dictionary of rules to functions that output a tree
///         prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
///         resolve_ambiguity: If True, ambiguities will be resolved based on
///                         priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
///         use_cache: If True, the results of packed node transformations will be cached.
///     """
///
///     def __init__(self, tree_class=Tree, callbacks=dict(), prioritizer=ForestSumVisitor(), resolve_ambiguity=True, use_cache=True):
///         super(ForestToParseTree, self).__init__()
///         self.tree_class = tree_class
///         self.callbacks = callbacks
///         self.prioritizer = prioritizer
///         self.resolve_ambiguity = resolve_ambiguity
///         self._use_cache = use_cache
///         self._cache = {}
///         self._on_cycle_retreat = False
///         self._cycle_node = None
///         self._successful_visits = set()
///
///     def visit(self, root):
///         if self.prioritizer:
///             self.prioritizer.visit(root)
///         super(ForestToParseTree, self).visit(root)
///         self._cache = {}
///
///     def on_cycle(self, node, path):
///         logger.debug("Cycle encountered in the SPPF at node: %s. "
///                 "As infinite ambiguities cannot be represented in a tree, "
///                 "this family of derivations will be discarded.", node)
///         self._cycle_node = node
///         self._on_cycle_retreat = True
///
///     def _check_cycle(self, node):
///         if self._on_cycle_retreat:
///             if id(node) == id(self._cycle_node) or id(node) in self._successful_visits:
///                 self._cycle_node = None
///                 self._on_cycle_retreat = False
///             else:
///                 return Discard
///
///     def _collapse_ambig(self, children):
///         new_children = []
///         for child in children:
///             if hasattr(child, 'data') and child.data == '_ambig':
///                 new_children += child.children
///             else:
///                 new_children.append(child)
///         return new_children
///
///     def _call_rule_func(self, node, data):
///         # called when transforming children of symbol nodes
///         # data is a list of trees or tokens that correspond to the
///         # symbol's rule expansion
///         return self.callbacks[node.rule](data)
///
///     def _call_ambig_func(self, node, data):
///         # called when transforming a symbol node
///         # data is a list of trees where each tree's data is
///         # equal to the name of the symbol or one of its aliases.
///         if len(data) > 1:
///             return self.tree_class('_ambig', data)
///         elif data:
///             return data[0]
///         return Discard
///
///     def transform_symbol_node(self, node, data):
///         if id(node) not in self._successful_visits:
///             return Discard
///         r = self._check_cycle(node)
///         if r is Discard:
///             return r
///         self._successful_visits.remove(id(node))
///         data = self._collapse_ambig(data)
///         return self._call_ambig_func(node, data)
///
///     def transform_intermediate_node(self, node, data):
///         if id(node) not in self._successful_visits:
///             return Discard
///         r = self._check_cycle(node)
///         if r is Discard:
///             return r
///         self._successful_visits.remove(id(node))
///         if len(data) > 1:
///             children = [self.tree_class('_inter', c) for c in data]
///             return self.tree_class('_iambig', children)
///         return data[0]
///
///     def transform_packed_node(self, node, data):
///         r = self._check_cycle(node)
///         if r is Discard:
///             return r
///         if self.resolve_ambiguity and id(node.parent) in self._successful_visits:
///             return Discard
///         if self._use_cache and id(node) in self._cache:
///             return self._cache[id(node)]
///         children = []
///         assert len(data) <= 2
///         data = PackedData(node, data)
///         if data.left is not PackedData.NO_DATA:
///             if node.left.is_intermediate and isinstance(data.left, list):
///                 children += data.left
///             else:
///                 children.append(data.left)
///         if data.right is not PackedData.NO_DATA:
///             children.append(data.right)
///         if node.parent.is_intermediate:
///             return self._cache.setdefault(id(node), children)
///         return self._cache.setdefault(id(node), self._call_rule_func(node, children))
///
///     def visit_symbol_node_in(self, node):
///         super(ForestToParseTree, self).visit_symbol_node_in(node)
///         if self._on_cycle_retreat:
///             return
///         return node.children
///
///     def visit_packed_node_in(self, node):
///         self._on_cycle_retreat = False
///         to_visit = super(ForestToParseTree, self).visit_packed_node_in(node)
///         if not self.resolve_ambiguity or id(node.parent) not in self._successful_visits:
///             if not self._use_cache or id(node) not in self._cache:
///                 return to_visit
///
///     def visit_packed_node_out(self, node):
///         super(ForestToParseTree, self).visit_packed_node_out(node)
///         if not self._on_cycle_retreat:
///             self._successful_visits.add(id(node.parent))
/// ```
final class ForestToParseTree extends PythonClass {
  factory ForestToParseTree({
    Object? tree_class,
    Object? callbacks = const {},
    Object? prioritizer,
    Object? resolve_ambiguity = true,
    Object? use_cache = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
        "ForestToParseTree",
        ForestToParseTree.from,
        <Object?>[
          tree_class,
          callbacks,
          prioritizer,
          resolve_ambiguity,
          use_cache,
        ],
        <String, Object?>{},
      );

  ForestToParseTree.from(super.pythonClass) : super.from();

  /// ## get_cycle_in_path
  ///
  /// ### python docstring
  ///
  /// A utility function for use in ``on_cycle`` to obtain a slice of
  /// ``path`` that only contains the nodes that make up the cycle.
  ///
  /// ### python source
  /// ```py
  /// def get_cycle_in_path(self, node, path):
  ///         """A utility function for use in ``on_cycle`` to obtain a slice of
  ///         ``path`` that only contains the nodes that make up the cycle."""
  ///         index = len(path) - 1
  ///         while id(path[index]) != id(node):
  ///             index -= 1
  ///         return path[index:]
  /// ```
  Object? get_cycle_in_path({
    required Object? node,
    required Object? path,
  }) =>
      getFunction("get_cycle_in_path").call(
        <Object?>[
          node,
          path,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## on_cycle
  ///
  /// ### python docstring
  ///
  /// Called when a cycle is encountered.
  ///
  /// Parameters:
  ///     node: The node that causes a cycle.
  ///     path: The list of nodes being visited: nodes that have been
  ///         entered but not exited. The first element is the root in a forest
  ///         visit, and the last element is the node visited most recently.
  ///         ``path`` should be treated as read-only.
  ///
  /// ### python source
  /// ```py
  /// def on_cycle(self, node, path):
  ///         logger.debug("Cycle encountered in the SPPF at node: %s. "
  ///                 "As infinite ambiguities cannot be represented in a tree, "
  ///                 "this family of derivations will be discarded.", node)
  ///         self._cycle_node = node
  ///         self._on_cycle_retreat = True
  /// ```
  Object? on_cycle({
    required Object? node,
    required Object? path,
  }) =>
      getFunction("on_cycle").call(
        <Object?>[
          node,
          path,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Perform a transformation on an SPPF.
  ///
  /// ### python source
  /// ```py
  /// def transform(self, root):
  ///         """Perform a transformation on an SPPF."""
  ///         self.node_stack.append('result')
  ///         self.data['result'] = []
  ///         self.visit(root)
  ///         assert len(self.data['result']) <= 1
  ///         if self.data['result']:
  ///             return self.data['result'][0]
  /// ```
  Object? transform({
    required Object? root,
  }) =>
      getFunction("transform").call(
        <Object?>[
          root,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform_intermediate_node
  ///
  /// ### python docstring
  ///
  /// Transform an intermediate node.
  ///
  /// ### python source
  /// ```py
  /// def transform_intermediate_node(self, node, data):
  ///         if id(node) not in self._successful_visits:
  ///             return Discard
  ///         r = self._check_cycle(node)
  ///         if r is Discard:
  ///             return r
  ///         self._successful_visits.remove(id(node))
  ///         if len(data) > 1:
  ///             children = [self.tree_class('_inter', c) for c in data]
  ///             return self.tree_class('_iambig', children)
  ///         return data[0]
  /// ```
  Object? transform_intermediate_node({
    required Object? node,
    required Object? data,
  }) =>
      getFunction("transform_intermediate_node").call(
        <Object?>[
          node,
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform_packed_node
  ///
  /// ### python docstring
  ///
  /// Transform a packed node.
  ///
  /// ### python source
  /// ```py
  /// def transform_packed_node(self, node, data):
  ///         r = self._check_cycle(node)
  ///         if r is Discard:
  ///             return r
  ///         if self.resolve_ambiguity and id(node.parent) in self._successful_visits:
  ///             return Discard
  ///         if self._use_cache and id(node) in self._cache:
  ///             return self._cache[id(node)]
  ///         children = []
  ///         assert len(data) <= 2
  ///         data = PackedData(node, data)
  ///         if data.left is not PackedData.NO_DATA:
  ///             if node.left.is_intermediate and isinstance(data.left, list):
  ///                 children += data.left
  ///             else:
  ///                 children.append(data.left)
  ///         if data.right is not PackedData.NO_DATA:
  ///             children.append(data.right)
  ///         if node.parent.is_intermediate:
  ///             return self._cache.setdefault(id(node), children)
  ///         return self._cache.setdefault(id(node), self._call_rule_func(node, children))
  /// ```
  Object? transform_packed_node({
    required Object? node,
    required Object? data,
  }) =>
      getFunction("transform_packed_node").call(
        <Object?>[
          node,
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform_symbol_node
  ///
  /// ### python docstring
  ///
  /// Transform a symbol node.
  ///
  /// ### python source
  /// ```py
  /// def transform_symbol_node(self, node, data):
  ///         if id(node) not in self._successful_visits:
  ///             return Discard
  ///         r = self._check_cycle(node)
  ///         if r is Discard:
  ///             return r
  ///         self._successful_visits.remove(id(node))
  ///         data = self._collapse_ambig(data)
  ///         return self._call_ambig_func(node, data)
  /// ```
  Object? transform_symbol_node({
    required Object? node,
    required Object? data,
  }) =>
      getFunction("transform_symbol_node").call(
        <Object?>[
          node,
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform_token_node
  ///
  /// ### python docstring
  ///
  /// Transform a ``Token``.
  ///
  /// ### python source
  /// ```py
  /// def transform_token_node(self, node):
  ///         """Transform a ``Token``."""
  ///         return node
  /// ```
  Object? transform_token_node({
    required Object? node,
  }) =>
      getFunction("transform_token_node").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit
  ///
  /// ### python source
  /// ```py
  /// def visit(self, root):
  ///         if self.prioritizer:
  ///             self.prioritizer.visit(root)
  ///         super(ForestToParseTree, self).visit(root)
  ///         self._cache = {}
  /// ```
  Object? visit({
    required Object? root,
  }) =>
      getFunction("visit").call(
        <Object?>[
          root,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_intermediate_node_out
  ///
  /// ### python source
  /// ```py
  /// def visit_intermediate_node_out(self, node):
  ///         self._visit_node_out_helper(node, self.transform_intermediate_node)
  /// ```
  Object? visit_intermediate_node_out({
    required Object? node,
  }) =>
      getFunction("visit_intermediate_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_packed_node_in
  ///
  /// ### python docstring
  ///
  /// Called when a packed node is visited. Nodes that are returned
  /// will be scheduled to be visited.
  ///
  /// ### python source
  /// ```py
  /// def visit_packed_node_in(self, node):
  ///         self._on_cycle_retreat = False
  ///         to_visit = super(ForestToParseTree, self).visit_packed_node_in(node)
  ///         if not self.resolve_ambiguity or id(node.parent) not in self._successful_visits:
  ///             if not self._use_cache or id(node) not in self._cache:
  ///                 return to_visit
  /// ```
  Object? visit_packed_node_in({
    required Object? node,
  }) =>
      getFunction("visit_packed_node_in").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_packed_node_out
  ///
  /// ### python docstring
  ///
  /// Called after all nodes returned from a corresponding ``visit_packed_node_in``
  /// call have been visited.
  ///
  /// ### python source
  /// ```py
  /// def visit_packed_node_out(self, node):
  ///         super(ForestToParseTree, self).visit_packed_node_out(node)
  ///         if not self._on_cycle_retreat:
  ///             self._successful_visits.add(id(node.parent))
  /// ```
  Object? visit_packed_node_out({
    required Object? node,
  }) =>
      getFunction("visit_packed_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_symbol_node_in
  ///
  /// ### python docstring
  ///
  /// Called when a symbol node is visited. Nodes that are returned
  /// will be scheduled to be visited. If ``visit_intermediate_node_in``
  /// is not implemented, this function will be called for intermediate
  /// nodes as well.
  ///
  /// ### python source
  /// ```py
  /// def visit_symbol_node_in(self, node):
  ///         super(ForestToParseTree, self).visit_symbol_node_in(node)
  ///         if self._on_cycle_retreat:
  ///             return
  ///         return node.children
  /// ```
  Object? visit_symbol_node_in({
    required Object? node,
  }) =>
      getFunction("visit_symbol_node_in").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_symbol_node_out
  ///
  /// ### python docstring
  ///
  /// Called after all nodes returned from a corresponding ``visit_symbol_node_in``
  /// call have been visited. If ``visit_intermediate_node_out``
  /// is not implemented, this function will be called for intermediate
  /// nodes as well.
  ///
  /// ### python source
  /// ```py
  /// def visit_symbol_node_out(self, node):
  ///         self._visit_node_out_helper(node, self.transform_symbol_node)
  /// ```
  Object? visit_symbol_node_out({
    required Object? node,
  }) =>
      getFunction("visit_symbol_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_token_node
  ///
  /// ### python docstring
  ///
  /// Called when a ``Token`` is visited. ``Token`` nodes are always leaves.
  ///
  /// ### python source
  /// ```py
  /// def visit_token_node(self, node):
  ///         transformed = self.transform_token_node(node)
  ///         if transformed is not Discard:
  ///             self.data[self.node_stack[-1]].append(transformed)
  /// ```
  Object? visit_token_node({
    required Object? node,
  }) =>
      getFunction("visit_token_node").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## tree_class (getter)
  ///
  /// ### python docstring
  ///
  /// Used by the earley parser when ambiguity equals 'resolve' or
  /// 'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
  ///
  /// Parameters:
  ///     tree_class: The tree class to use for construction
  ///     callbacks: A dictionary of rules to functions that output a tree
  ///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
  ///     resolve_ambiguity: If True, ambiguities will be resolved based on
  ///                     priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
  ///     use_cache: If True, the results of packed node transformations will be cached.
  Object? get tree_class => getAttribute("tree_class");

  /// ## tree_class (setter)
  ///
  /// ### python docstring
  ///
  /// Used by the earley parser when ambiguity equals 'resolve' or
  /// 'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
  ///
  /// Parameters:
  ///     tree_class: The tree class to use for construction
  ///     callbacks: A dictionary of rules to functions that output a tree
  ///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
  ///     resolve_ambiguity: If True, ambiguities will be resolved based on
  ///                     priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
  ///     use_cache: If True, the results of packed node transformations will be cached.
  set tree_class(Object? tree_class) => setAttribute("tree_class", tree_class);

  /// ## callbacks (getter)
  ///
  /// ### python docstring
  ///
  /// Used by the earley parser when ambiguity equals 'resolve' or
  /// 'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
  ///
  /// Parameters:
  ///     tree_class: The tree class to use for construction
  ///     callbacks: A dictionary of rules to functions that output a tree
  ///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
  ///     resolve_ambiguity: If True, ambiguities will be resolved based on
  ///                     priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
  ///     use_cache: If True, the results of packed node transformations will be cached.
  Object? get callbacks => getAttribute("callbacks");

  /// ## callbacks (setter)
  ///
  /// ### python docstring
  ///
  /// Used by the earley parser when ambiguity equals 'resolve' or
  /// 'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
  ///
  /// Parameters:
  ///     tree_class: The tree class to use for construction
  ///     callbacks: A dictionary of rules to functions that output a tree
  ///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
  ///     resolve_ambiguity: If True, ambiguities will be resolved based on
  ///                     priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
  ///     use_cache: If True, the results of packed node transformations will be cached.
  set callbacks(Object? callbacks) => setAttribute("callbacks", callbacks);

  /// ## prioritizer (getter)
  ///
  /// ### python docstring
  ///
  /// Used by the earley parser when ambiguity equals 'resolve' or
  /// 'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
  ///
  /// Parameters:
  ///     tree_class: The tree class to use for construction
  ///     callbacks: A dictionary of rules to functions that output a tree
  ///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
  ///     resolve_ambiguity: If True, ambiguities will be resolved based on
  ///                     priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
  ///     use_cache: If True, the results of packed node transformations will be cached.
  Object? get prioritizer => getAttribute("prioritizer");

  /// ## prioritizer (setter)
  ///
  /// ### python docstring
  ///
  /// Used by the earley parser when ambiguity equals 'resolve' or
  /// 'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
  ///
  /// Parameters:
  ///     tree_class: The tree class to use for construction
  ///     callbacks: A dictionary of rules to functions that output a tree
  ///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
  ///     resolve_ambiguity: If True, ambiguities will be resolved based on
  ///                     priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
  ///     use_cache: If True, the results of packed node transformations will be cached.
  set prioritizer(Object? prioritizer) =>
      setAttribute("prioritizer", prioritizer);

  /// ## resolve_ambiguity (getter)
  ///
  /// ### python docstring
  ///
  /// Used by the earley parser when ambiguity equals 'resolve' or
  /// 'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
  ///
  /// Parameters:
  ///     tree_class: The tree class to use for construction
  ///     callbacks: A dictionary of rules to functions that output a tree
  ///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
  ///     resolve_ambiguity: If True, ambiguities will be resolved based on
  ///                     priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
  ///     use_cache: If True, the results of packed node transformations will be cached.
  Object? get resolve_ambiguity => getAttribute("resolve_ambiguity");

  /// ## resolve_ambiguity (setter)
  ///
  /// ### python docstring
  ///
  /// Used by the earley parser when ambiguity equals 'resolve' or
  /// 'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
  ///
  /// Parameters:
  ///     tree_class: The tree class to use for construction
  ///     callbacks: A dictionary of rules to functions that output a tree
  ///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
  ///     resolve_ambiguity: If True, ambiguities will be resolved based on
  ///                     priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
  ///     use_cache: If True, the results of packed node transformations will be cached.
  set resolve_ambiguity(Object? resolve_ambiguity) =>
      setAttribute("resolve_ambiguity", resolve_ambiguity);
}

/// ## ForestToPyDotVisitor
///
/// ### python docstring
///
/// A Forest visitor which writes the SPPF to a PNG.
///
/// The SPPF can get really large, really quickly because
/// of the amount of meta-data it stores, so this is probably
/// only useful for trivial trees and learning how the SPPF
/// is structured.
///
/// ### python source
/// ```py
/// class ForestToPyDotVisitor(ForestVisitor):
///     """
///     A Forest visitor which writes the SPPF to a PNG.
///
///     The SPPF can get really large, really quickly because
///     of the amount of meta-data it stores, so this is probably
///     only useful for trivial trees and learning how the SPPF
///     is structured.
///     """
///     def __init__(self, rankdir="TB"):
///         super(ForestToPyDotVisitor, self).__init__(single_visit=True)
///         self.pydot = import_module('pydot')
///         self.graph = self.pydot.Dot(graph_type='digraph', rankdir=rankdir)
///
///     def visit(self, root, filename):
///         super(ForestToPyDotVisitor, self).visit(root)
///         try:
///             self.graph.write_png(filename)
///         except FileNotFoundError as e:
///             logger.error("Could not write png: ", e)
///
///     def visit_token_node(self, node):
///         graph_node_id = str(id(node))
///         graph_node_label = "\"{}\"".format(node.value.replace('"', '\\"'))
///         graph_node_color = 0x808080
///         graph_node_style = "\"filled,rounded\""
///         graph_node_shape = "diamond"
///         graph_node = self.pydot.Node(graph_node_id, style=graph_node_style, fillcolor="#{:06x}".format(graph_node_color), shape=graph_node_shape, label=graph_node_label)
///         self.graph.add_node(graph_node)
///
///     def visit_packed_node_in(self, node):
///         graph_node_id = str(id(node))
///         graph_node_label = repr(node)
///         graph_node_color = 0x808080
///         graph_node_style = "filled"
///         graph_node_shape = "diamond"
///         graph_node = self.pydot.Node(graph_node_id, style=graph_node_style, fillcolor="#{:06x}".format(graph_node_color), shape=graph_node_shape, label=graph_node_label)
///         self.graph.add_node(graph_node)
///         yield node.left
///         yield node.right
///
///     def visit_packed_node_out(self, node):
///         graph_node_id = str(id(node))
///         graph_node = self.graph.get_node(graph_node_id)[0]
///         for child in [node.left, node.right]:
///             if child is not None:
///                 child_graph_node_id = str(id(child.token if isinstance(child, TokenNode) else child))
///                 child_graph_node = self.graph.get_node(child_graph_node_id)[0]
///                 self.graph.add_edge(self.pydot.Edge(graph_node, child_graph_node))
///             else:
///                 #### Try and be above the Python object ID range; probably impl. specific, but maybe this is okay.
///                 child_graph_node_id = str(randint(100000000000000000000000000000,123456789012345678901234567890))
///                 child_graph_node_style = "invis"
///                 child_graph_node = self.pydot.Node(child_graph_node_id, style=child_graph_node_style, label="None")
///                 child_edge_style = "invis"
///                 self.graph.add_node(child_graph_node)
///                 self.graph.add_edge(self.pydot.Edge(graph_node, child_graph_node, style=child_edge_style))
///
///     def visit_symbol_node_in(self, node):
///         graph_node_id = str(id(node))
///         graph_node_label = repr(node)
///         graph_node_color = 0x808080
///         graph_node_style = "\"filled\""
///         if node.is_intermediate:
///             graph_node_shape = "ellipse"
///         else:
///             graph_node_shape = "rectangle"
///         graph_node = self.pydot.Node(graph_node_id, style=graph_node_style, fillcolor="#{:06x}".format(graph_node_color), shape=graph_node_shape, label=graph_node_label)
///         self.graph.add_node(graph_node)
///         return iter(node.children)
///
///     def visit_symbol_node_out(self, node):
///         graph_node_id = str(id(node))
///         graph_node = self.graph.get_node(graph_node_id)[0]
///         for child in node.children:
///             child_graph_node_id = str(id(child))
///             child_graph_node = self.graph.get_node(child_graph_node_id)[0]
///             self.graph.add_edge(self.pydot.Edge(graph_node, child_graph_node))
/// ```
final class ForestToPyDotVisitor extends PythonClass {
  factory ForestToPyDotVisitor({
    Object? rankdir = "TB",
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
        "ForestToPyDotVisitor",
        ForestToPyDotVisitor.from,
        <Object?>[
          rankdir,
        ],
        <String, Object?>{},
      );

  ForestToPyDotVisitor.from(super.pythonClass) : super.from();

  /// ## get_cycle_in_path
  ///
  /// ### python docstring
  ///
  /// A utility function for use in ``on_cycle`` to obtain a slice of
  /// ``path`` that only contains the nodes that make up the cycle.
  ///
  /// ### python source
  /// ```py
  /// def get_cycle_in_path(self, node, path):
  ///         """A utility function for use in ``on_cycle`` to obtain a slice of
  ///         ``path`` that only contains the nodes that make up the cycle."""
  ///         index = len(path) - 1
  ///         while id(path[index]) != id(node):
  ///             index -= 1
  ///         return path[index:]
  /// ```
  Object? get_cycle_in_path({
    required Object? node,
    required Object? path,
  }) =>
      getFunction("get_cycle_in_path").call(
        <Object?>[
          node,
          path,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## on_cycle
  ///
  /// ### python docstring
  ///
  /// Called when a cycle is encountered.
  ///
  /// Parameters:
  ///     node: The node that causes a cycle.
  ///     path: The list of nodes being visited: nodes that have been
  ///         entered but not exited. The first element is the root in a forest
  ///         visit, and the last element is the node visited most recently.
  ///         ``path`` should be treated as read-only.
  ///
  /// ### python source
  /// ```py
  /// def on_cycle(self, node, path):
  ///         """Called when a cycle is encountered.
  ///
  ///         Parameters:
  ///             node: The node that causes a cycle.
  ///             path: The list of nodes being visited: nodes that have been
  ///                 entered but not exited. The first element is the root in a forest
  ///                 visit, and the last element is the node visited most recently.
  ///                 ``path`` should be treated as read-only.
  ///         """
  ///         pass
  /// ```
  Object? on_cycle({
    required Object? node,
    required Object? path,
  }) =>
      getFunction("on_cycle").call(
        <Object?>[
          node,
          path,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit
  ///
  /// ### python source
  /// ```py
  /// def visit(self, root, filename):
  ///         super(ForestToPyDotVisitor, self).visit(root)
  ///         try:
  ///             self.graph.write_png(filename)
  ///         except FileNotFoundError as e:
  ///             logger.error("Could not write png: ", e)
  /// ```
  Object? visit({
    required Object? root,
    required Object? filename,
  }) =>
      getFunction("visit").call(
        <Object?>[
          root,
          filename,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_packed_node_in
  ///
  /// ### python docstring
  ///
  /// Called when a packed node is visited. Nodes that are returned
  /// will be scheduled to be visited.
  ///
  /// ### python source
  /// ```py
  /// def visit_packed_node_in(self, node):
  ///         graph_node_id = str(id(node))
  ///         graph_node_label = repr(node)
  ///         graph_node_color = 0x808080
  ///         graph_node_style = "filled"
  ///         graph_node_shape = "diamond"
  ///         graph_node = self.pydot.Node(graph_node_id, style=graph_node_style, fillcolor="#{:06x}".format(graph_node_color), shape=graph_node_shape, label=graph_node_label)
  ///         self.graph.add_node(graph_node)
  ///         yield node.left
  ///         yield node.right
  /// ```
  Object? visit_packed_node_in({
    required Object? node,
  }) =>
      getFunction("visit_packed_node_in").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_packed_node_out
  ///
  /// ### python docstring
  ///
  /// Called after all nodes returned from a corresponding ``visit_packed_node_in``
  /// call have been visited.
  ///
  /// ### python source
  /// ```py
  /// def visit_packed_node_out(self, node):
  ///         graph_node_id = str(id(node))
  ///         graph_node = self.graph.get_node(graph_node_id)[0]
  ///         for child in [node.left, node.right]:
  ///             if child is not None:
  ///                 child_graph_node_id = str(id(child.token if isinstance(child, TokenNode) else child))
  ///                 child_graph_node = self.graph.get_node(child_graph_node_id)[0]
  ///                 self.graph.add_edge(self.pydot.Edge(graph_node, child_graph_node))
  ///             else:
  ///                 #### Try and be above the Python object ID range; probably impl. specific, but maybe this is okay.
  ///                 child_graph_node_id = str(randint(100000000000000000000000000000,123456789012345678901234567890))
  ///                 child_graph_node_style = "invis"
  ///                 child_graph_node = self.pydot.Node(child_graph_node_id, style=child_graph_node_style, label="None")
  ///                 child_edge_style = "invis"
  ///                 self.graph.add_node(child_graph_node)
  ///                 self.graph.add_edge(self.pydot.Edge(graph_node, child_graph_node, style=child_edge_style))
  /// ```
  Object? visit_packed_node_out({
    required Object? node,
  }) =>
      getFunction("visit_packed_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_symbol_node_in
  ///
  /// ### python docstring
  ///
  /// Called when a symbol node is visited. Nodes that are returned
  /// will be scheduled to be visited. If ``visit_intermediate_node_in``
  /// is not implemented, this function will be called for intermediate
  /// nodes as well.
  ///
  /// ### python source
  /// ```py
  /// def visit_symbol_node_in(self, node):
  ///         graph_node_id = str(id(node))
  ///         graph_node_label = repr(node)
  ///         graph_node_color = 0x808080
  ///         graph_node_style = "\"filled\""
  ///         if node.is_intermediate:
  ///             graph_node_shape = "ellipse"
  ///         else:
  ///             graph_node_shape = "rectangle"
  ///         graph_node = self.pydot.Node(graph_node_id, style=graph_node_style, fillcolor="#{:06x}".format(graph_node_color), shape=graph_node_shape, label=graph_node_label)
  ///         self.graph.add_node(graph_node)
  ///         return iter(node.children)
  /// ```
  Object? visit_symbol_node_in({
    required Object? node,
  }) =>
      getFunction("visit_symbol_node_in").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_symbol_node_out
  ///
  /// ### python docstring
  ///
  /// Called after all nodes returned from a corresponding ``visit_symbol_node_in``
  /// call have been visited. If ``visit_intermediate_node_out``
  /// is not implemented, this function will be called for intermediate
  /// nodes as well.
  ///
  /// ### python source
  /// ```py
  /// def visit_symbol_node_out(self, node):
  ///         graph_node_id = str(id(node))
  ///         graph_node = self.graph.get_node(graph_node_id)[0]
  ///         for child in node.children:
  ///             child_graph_node_id = str(id(child))
  ///             child_graph_node = self.graph.get_node(child_graph_node_id)[0]
  ///             self.graph.add_edge(self.pydot.Edge(graph_node, child_graph_node))
  /// ```
  Object? visit_symbol_node_out({
    required Object? node,
  }) =>
      getFunction("visit_symbol_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_token_node
  ///
  /// ### python docstring
  ///
  /// Called when a ``Token`` is visited. ``Token`` nodes are always leaves.
  ///
  /// ### python source
  /// ```py
  /// def visit_token_node(self, node):
  ///         graph_node_id = str(id(node))
  ///         graph_node_label = "\"{}\"".format(node.value.replace('"', '\\"'))
  ///         graph_node_color = 0x808080
  ///         graph_node_style = "\"filled,rounded\""
  ///         graph_node_shape = "diamond"
  ///         graph_node = self.pydot.Node(graph_node_id, style=graph_node_style, fillcolor="#{:06x}".format(graph_node_color), shape=graph_node_shape, label=graph_node_label)
  ///         self.graph.add_node(graph_node)
  /// ```
  Object? visit_token_node({
    required Object? node,
  }) =>
      getFunction("visit_token_node").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## pydot (getter)
  ///
  /// ### python docstring
  ///
  /// A Forest visitor which writes the SPPF to a PNG.
  ///
  /// The SPPF can get really large, really quickly because
  /// of the amount of meta-data it stores, so this is probably
  /// only useful for trivial trees and learning how the SPPF
  /// is structured.
  Object? get pydot => getAttribute("pydot");

  /// ## pydot (setter)
  ///
  /// ### python docstring
  ///
  /// A Forest visitor which writes the SPPF to a PNG.
  ///
  /// The SPPF can get really large, really quickly because
  /// of the amount of meta-data it stores, so this is probably
  /// only useful for trivial trees and learning how the SPPF
  /// is structured.
  set pydot(Object? pydot) => setAttribute("pydot", pydot);

  /// ## graph (getter)
  ///
  /// ### python docstring
  ///
  /// A Forest visitor which writes the SPPF to a PNG.
  ///
  /// The SPPF can get really large, really quickly because
  /// of the amount of meta-data it stores, so this is probably
  /// only useful for trivial trees and learning how the SPPF
  /// is structured.
  Object? get graph => getAttribute("graph");

  /// ## graph (setter)
  ///
  /// ### python docstring
  ///
  /// A Forest visitor which writes the SPPF to a PNG.
  ///
  /// The SPPF can get really large, really quickly because
  /// of the amount of meta-data it stores, so this is probably
  /// only useful for trivial trees and learning how the SPPF
  /// is structured.
  set graph(Object? graph) => setAttribute("graph", graph);
}

/// ## ForestTransformer
///
/// ### python docstring
///
/// The base class for a bottom-up forest transformation. Most users will
/// want to use ``TreeForestTransformer`` instead as it has a friendlier
/// interface and covers most use cases.
///
/// Transformations are applied via inheritance and overriding of the
/// ``transform*node`` methods.
///
/// ``transform_token_node`` receives a ``Token`` as an argument.
/// All other methods receive the node that is being transformed and
/// a list of the results of the transformations of that node's children.
/// The return value of these methods are the resulting transformations.
///
/// If ``Discard`` is raised in a node's transformation, no data from that node
/// will be passed to its parent's transformation.
///
/// ### python source
/// ```py
/// class ForestTransformer(ForestVisitor):
///     """The base class for a bottom-up forest transformation. Most users will
///     want to use ``TreeForestTransformer`` instead as it has a friendlier
///     interface and covers most use cases.
///
///     Transformations are applied via inheritance and overriding of the
///     ``transform*node`` methods.
///
///     ``transform_token_node`` receives a ``Token`` as an argument.
///     All other methods receive the node that is being transformed and
///     a list of the results of the transformations of that node's children.
///     The return value of these methods are the resulting transformations.
///
///     If ``Discard`` is raised in a node's transformation, no data from that node
///     will be passed to its parent's transformation.
///     """
///
///     def __init__(self):
///         super(ForestTransformer, self).__init__()
///         # results of transformations
///         self.data = dict()
///         # used to track parent nodes
///         self.node_stack = deque()
///
///     def transform(self, root):
///         """Perform a transformation on an SPPF."""
///         self.node_stack.append('result')
///         self.data['result'] = []
///         self.visit(root)
///         assert len(self.data['result']) <= 1
///         if self.data['result']:
///             return self.data['result'][0]
///
///     def transform_symbol_node(self, node, data):
///         """Transform a symbol node."""
///         return node
///
///     def transform_intermediate_node(self, node, data):
///         """Transform an intermediate node."""
///         return node
///
///     def transform_packed_node(self, node, data):
///         """Transform a packed node."""
///         return node
///
///     def transform_token_node(self, node):
///         """Transform a ``Token``."""
///         return node
///
///     def visit_symbol_node_in(self, node):
///         self.node_stack.append(id(node))
///         self.data[id(node)] = []
///         return node.children
///
///     def visit_packed_node_in(self, node):
///         self.node_stack.append(id(node))
///         self.data[id(node)] = []
///         return node.children
///
///     def visit_token_node(self, node):
///         transformed = self.transform_token_node(node)
///         if transformed is not Discard:
///             self.data[self.node_stack[-1]].append(transformed)
///
///     def _visit_node_out_helper(self, node, method):
///         self.node_stack.pop()
///         transformed = method(node, self.data[id(node)])
///         if transformed is not Discard:
///             self.data[self.node_stack[-1]].append(transformed)
///         del self.data[id(node)]
///
///     def visit_symbol_node_out(self, node):
///         self._visit_node_out_helper(node, self.transform_symbol_node)
///
///     def visit_intermediate_node_out(self, node):
///         self._visit_node_out_helper(node, self.transform_intermediate_node)
///
///     def visit_packed_node_out(self, node):
///         self._visit_node_out_helper(node, self.transform_packed_node)
/// ```
final class ForestTransformer extends PythonClass {
  factory ForestTransformer() => PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
        "ForestTransformer",
        ForestTransformer.from,
        <Object?>[],
        <String, Object?>{},
      );

  ForestTransformer.from(super.pythonClass) : super.from();

  /// ## get_cycle_in_path
  ///
  /// ### python docstring
  ///
  /// A utility function for use in ``on_cycle`` to obtain a slice of
  /// ``path`` that only contains the nodes that make up the cycle.
  ///
  /// ### python source
  /// ```py
  /// def get_cycle_in_path(self, node, path):
  ///         """A utility function for use in ``on_cycle`` to obtain a slice of
  ///         ``path`` that only contains the nodes that make up the cycle."""
  ///         index = len(path) - 1
  ///         while id(path[index]) != id(node):
  ///             index -= 1
  ///         return path[index:]
  /// ```
  Object? get_cycle_in_path({
    required Object? node,
    required Object? path,
  }) =>
      getFunction("get_cycle_in_path").call(
        <Object?>[
          node,
          path,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## on_cycle
  ///
  /// ### python docstring
  ///
  /// Called when a cycle is encountered.
  ///
  /// Parameters:
  ///     node: The node that causes a cycle.
  ///     path: The list of nodes being visited: nodes that have been
  ///         entered but not exited. The first element is the root in a forest
  ///         visit, and the last element is the node visited most recently.
  ///         ``path`` should be treated as read-only.
  ///
  /// ### python source
  /// ```py
  /// def on_cycle(self, node, path):
  ///         """Called when a cycle is encountered.
  ///
  ///         Parameters:
  ///             node: The node that causes a cycle.
  ///             path: The list of nodes being visited: nodes that have been
  ///                 entered but not exited. The first element is the root in a forest
  ///                 visit, and the last element is the node visited most recently.
  ///                 ``path`` should be treated as read-only.
  ///         """
  ///         pass
  /// ```
  Object? on_cycle({
    required Object? node,
    required Object? path,
  }) =>
      getFunction("on_cycle").call(
        <Object?>[
          node,
          path,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Perform a transformation on an SPPF.
  ///
  /// ### python source
  /// ```py
  /// def transform(self, root):
  ///         """Perform a transformation on an SPPF."""
  ///         self.node_stack.append('result')
  ///         self.data['result'] = []
  ///         self.visit(root)
  ///         assert len(self.data['result']) <= 1
  ///         if self.data['result']:
  ///             return self.data['result'][0]
  /// ```
  Object? transform({
    required Object? root,
  }) =>
      getFunction("transform").call(
        <Object?>[
          root,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform_intermediate_node
  ///
  /// ### python docstring
  ///
  /// Transform an intermediate node.
  ///
  /// ### python source
  /// ```py
  /// def transform_intermediate_node(self, node, data):
  ///         """Transform an intermediate node."""
  ///         return node
  /// ```
  Object? transform_intermediate_node({
    required Object? node,
    required Object? data,
  }) =>
      getFunction("transform_intermediate_node").call(
        <Object?>[
          node,
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform_packed_node
  ///
  /// ### python docstring
  ///
  /// Transform a packed node.
  ///
  /// ### python source
  /// ```py
  /// def transform_packed_node(self, node, data):
  ///         """Transform a packed node."""
  ///         return node
  /// ```
  Object? transform_packed_node({
    required Object? node,
    required Object? data,
  }) =>
      getFunction("transform_packed_node").call(
        <Object?>[
          node,
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform_symbol_node
  ///
  /// ### python docstring
  ///
  /// Transform a symbol node.
  ///
  /// ### python source
  /// ```py
  /// def transform_symbol_node(self, node, data):
  ///         """Transform a symbol node."""
  ///         return node
  /// ```
  Object? transform_symbol_node({
    required Object? node,
    required Object? data,
  }) =>
      getFunction("transform_symbol_node").call(
        <Object?>[
          node,
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform_token_node
  ///
  /// ### python docstring
  ///
  /// Transform a ``Token``.
  ///
  /// ### python source
  /// ```py
  /// def transform_token_node(self, node):
  ///         """Transform a ``Token``."""
  ///         return node
  /// ```
  Object? transform_token_node({
    required Object? node,
  }) =>
      getFunction("transform_token_node").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit
  ///
  /// ### python source
  /// ```py
  /// def visit(self, root):
  ///         # Visiting is a list of IDs of all symbol/intermediate nodes currently in
  ///         # the stack. It serves two purposes: to detect when we 'recurse' in and out
  ///         # of a symbol/intermediate so that we can process both up and down. Also,
  ///         # since the SPPF can have cycles it allows us to detect if we're trying
  ///         # to recurse into a node that's already on the stack (infinite recursion).
  ///         visiting = set()
  ///
  ///         # set of all nodes that have been visited
  ///         visited = set()
  ///
  ///         # a list of nodes that are currently being visited
  ///         # used for the `on_cycle` callback
  ///         path = []
  ///
  ///         # We do not use recursion here to walk the Forest due to the limited
  ///         # stack size in python. Therefore input_stack is essentially our stack.
  ///         input_stack = deque([root])
  ///
  ///         # It is much faster to cache these as locals since they are called
  ///         # many times in large parses.
  ///         vpno = getattr(self, 'visit_packed_node_out')
  ///         vpni = getattr(self, 'visit_packed_node_in')
  ///         vsno = getattr(self, 'visit_symbol_node_out')
  ///         vsni = getattr(self, 'visit_symbol_node_in')
  ///         vino = getattr(self, 'visit_intermediate_node_out', vsno)
  ///         vini = getattr(self, 'visit_intermediate_node_in', vsni)
  ///         vtn = getattr(self, 'visit_token_node')
  ///         oc = getattr(self, 'on_cycle')
  ///
  ///         while input_stack:
  ///             current = next(reversed(input_stack))
  ///             try:
  ///                 next_node = next(current)
  ///             except StopIteration:
  ///                 input_stack.pop()
  ///                 continue
  ///             except TypeError:
  ///                 ### If the current object is not an iterator, pass through to Token/SymbolNode
  ///                 pass
  ///             else:
  ///                 if next_node is None:
  ///                     continue
  ///
  ///                 if id(next_node) in visiting:
  ///                     oc(next_node, path)
  ///                     continue
  ///
  ///                 input_stack.append(next_node)
  ///                 continue
  ///
  ///             if isinstance(current, TokenNode):
  ///                 vtn(current.token)
  ///                 input_stack.pop()
  ///                 continue
  ///
  ///             current_id = id(current)
  ///             if current_id in visiting:
  ///                 if isinstance(current, PackedNode):
  ///                     vpno(current)
  ///                 elif current.is_intermediate:
  ///                     vino(current)
  ///                 else:
  ///                     vsno(current)
  ///                 input_stack.pop()
  ///                 path.pop()
  ///                 visiting.remove(current_id)
  ///                 visited.add(current_id)
  ///             elif self.single_visit and current_id in visited:
  ///                 input_stack.pop()
  ///             else:
  ///                 visiting.add(current_id)
  ///                 path.append(current)
  ///                 if isinstance(current, PackedNode):
  ///                     next_node = vpni(current)
  ///                 elif current.is_intermediate:
  ///                     next_node = vini(current)
  ///                 else:
  ///                     next_node = vsni(current)
  ///                 if next_node is None:
  ///                     continue
  ///
  ///                 if not isinstance(next_node, ForestNode):
  ///                     next_node = iter(next_node)
  ///                 elif id(next_node) in visiting:
  ///                     oc(next_node, path)
  ///                     continue
  ///
  ///                 input_stack.append(next_node)
  /// ```
  Object? visit({
    required Object? root,
  }) =>
      getFunction("visit").call(
        <Object?>[
          root,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_intermediate_node_out
  ///
  /// ### python source
  /// ```py
  /// def visit_intermediate_node_out(self, node):
  ///         self._visit_node_out_helper(node, self.transform_intermediate_node)
  /// ```
  Object? visit_intermediate_node_out({
    required Object? node,
  }) =>
      getFunction("visit_intermediate_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_packed_node_in
  ///
  /// ### python docstring
  ///
  /// Called when a packed node is visited. Nodes that are returned
  /// will be scheduled to be visited.
  ///
  /// ### python source
  /// ```py
  /// def visit_packed_node_in(self, node):
  ///         self.node_stack.append(id(node))
  ///         self.data[id(node)] = []
  ///         return node.children
  /// ```
  Object? visit_packed_node_in({
    required Object? node,
  }) =>
      getFunction("visit_packed_node_in").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_packed_node_out
  ///
  /// ### python docstring
  ///
  /// Called after all nodes returned from a corresponding ``visit_packed_node_in``
  /// call have been visited.
  ///
  /// ### python source
  /// ```py
  /// def visit_packed_node_out(self, node):
  ///         self._visit_node_out_helper(node, self.transform_packed_node)
  /// ```
  Object? visit_packed_node_out({
    required Object? node,
  }) =>
      getFunction("visit_packed_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_symbol_node_in
  ///
  /// ### python docstring
  ///
  /// Called when a symbol node is visited. Nodes that are returned
  /// will be scheduled to be visited. If ``visit_intermediate_node_in``
  /// is not implemented, this function will be called for intermediate
  /// nodes as well.
  ///
  /// ### python source
  /// ```py
  /// def visit_symbol_node_in(self, node):
  ///         self.node_stack.append(id(node))
  ///         self.data[id(node)] = []
  ///         return node.children
  /// ```
  Object? visit_symbol_node_in({
    required Object? node,
  }) =>
      getFunction("visit_symbol_node_in").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_symbol_node_out
  ///
  /// ### python docstring
  ///
  /// Called after all nodes returned from a corresponding ``visit_symbol_node_in``
  /// call have been visited. If ``visit_intermediate_node_out``
  /// is not implemented, this function will be called for intermediate
  /// nodes as well.
  ///
  /// ### python source
  /// ```py
  /// def visit_symbol_node_out(self, node):
  ///         self._visit_node_out_helper(node, self.transform_symbol_node)
  /// ```
  Object? visit_symbol_node_out({
    required Object? node,
  }) =>
      getFunction("visit_symbol_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_token_node
  ///
  /// ### python docstring
  ///
  /// Called when a ``Token`` is visited. ``Token`` nodes are always leaves.
  ///
  /// ### python source
  /// ```py
  /// def visit_token_node(self, node):
  ///         transformed = self.transform_token_node(node)
  ///         if transformed is not Discard:
  ///             self.data[self.node_stack[-1]].append(transformed)
  /// ```
  Object? visit_token_node({
    required Object? node,
  }) =>
      getFunction("visit_token_node").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## data (getter)
  ///
  /// ### python docstring
  ///
  /// The base class for a bottom-up forest transformation. Most users will
  /// want to use ``TreeForestTransformer`` instead as it has a friendlier
  /// interface and covers most use cases.
  ///
  /// Transformations are applied via inheritance and overriding of the
  /// ``transform*node`` methods.
  ///
  /// ``transform_token_node`` receives a ``Token`` as an argument.
  /// All other methods receive the node that is being transformed and
  /// a list of the results of the transformations of that node's children.
  /// The return value of these methods are the resulting transformations.
  ///
  /// If ``Discard`` is raised in a node's transformation, no data from that node
  /// will be passed to its parent's transformation.
  Object? get data => getAttribute("data");

  /// ## data (setter)
  ///
  /// ### python docstring
  ///
  /// The base class for a bottom-up forest transformation. Most users will
  /// want to use ``TreeForestTransformer`` instead as it has a friendlier
  /// interface and covers most use cases.
  ///
  /// Transformations are applied via inheritance and overriding of the
  /// ``transform*node`` methods.
  ///
  /// ``transform_token_node`` receives a ``Token`` as an argument.
  /// All other methods receive the node that is being transformed and
  /// a list of the results of the transformations of that node's children.
  /// The return value of these methods are the resulting transformations.
  ///
  /// If ``Discard`` is raised in a node's transformation, no data from that node
  /// will be passed to its parent's transformation.
  set data(Object? data) => setAttribute("data", data);

  /// ## node_stack (getter)
  ///
  /// ### python docstring
  ///
  /// The base class for a bottom-up forest transformation. Most users will
  /// want to use ``TreeForestTransformer`` instead as it has a friendlier
  /// interface and covers most use cases.
  ///
  /// Transformations are applied via inheritance and overriding of the
  /// ``transform*node`` methods.
  ///
  /// ``transform_token_node`` receives a ``Token`` as an argument.
  /// All other methods receive the node that is being transformed and
  /// a list of the results of the transformations of that node's children.
  /// The return value of these methods are the resulting transformations.
  ///
  /// If ``Discard`` is raised in a node's transformation, no data from that node
  /// will be passed to its parent's transformation.
  Object? get node_stack => getAttribute("node_stack");

  /// ## node_stack (setter)
  ///
  /// ### python docstring
  ///
  /// The base class for a bottom-up forest transformation. Most users will
  /// want to use ``TreeForestTransformer`` instead as it has a friendlier
  /// interface and covers most use cases.
  ///
  /// Transformations are applied via inheritance and overriding of the
  /// ``transform*node`` methods.
  ///
  /// ``transform_token_node`` receives a ``Token`` as an argument.
  /// All other methods receive the node that is being transformed and
  /// a list of the results of the transformations of that node's children.
  /// The return value of these methods are the resulting transformations.
  ///
  /// If ``Discard`` is raised in a node's transformation, no data from that node
  /// will be passed to its parent's transformation.
  set node_stack(Object? node_stack) => setAttribute("node_stack", node_stack);
}

/// ## ForestVisitor
///
/// ### python docstring
///
/// An abstract base class for building forest visitors.
///
/// This class performs a controllable depth-first walk of an SPPF.
/// The visitor will not enter cycles and will backtrack if one is encountered.
/// Subclasses are notified of cycles through the ``on_cycle`` method.
///
/// Behavior for visit events is defined by overriding the
/// ``visit*node*`` functions.
///
/// The walk is controlled by the return values of the ``visit*node_in``
/// methods. Returning a node(s) will schedule them to be visited. The visitor
/// will begin to backtrack if no nodes are returned.
///
/// Parameters:
///     single_visit: If ``True``, non-Token nodes will only be visited once.
///
/// ### python source
/// ```py
/// class ForestVisitor:
///     """
///     An abstract base class for building forest visitors.
///
///     This class performs a controllable depth-first walk of an SPPF.
///     The visitor will not enter cycles and will backtrack if one is encountered.
///     Subclasses are notified of cycles through the ``on_cycle`` method.
///
///     Behavior for visit events is defined by overriding the
///     ``visit*node*`` functions.
///
///     The walk is controlled by the return values of the ``visit*node_in``
///     methods. Returning a node(s) will schedule them to be visited. The visitor
///     will begin to backtrack if no nodes are returned.
///
///     Parameters:
///         single_visit: If ``True``, non-Token nodes will only be visited once.
///     """
///
///     def __init__(self, single_visit=False):
///         self.single_visit = single_visit
///
///     def visit_token_node(self, node):
///         """Called when a ``Token`` is visited. ``Token`` nodes are always leaves."""
///         pass
///
///     def visit_symbol_node_in(self, node):
///         """Called when a symbol node is visited. Nodes that are returned
///         will be scheduled to be visited. If ``visit_intermediate_node_in``
///         is not implemented, this function will be called for intermediate
///         nodes as well."""
///         pass
///
///     def visit_symbol_node_out(self, node):
///         """Called after all nodes returned from a corresponding ``visit_symbol_node_in``
///         call have been visited. If ``visit_intermediate_node_out``
///         is not implemented, this function will be called for intermediate
///         nodes as well."""
///         pass
///
///     def visit_packed_node_in(self, node):
///         """Called when a packed node is visited. Nodes that are returned
///         will be scheduled to be visited. """
///         pass
///
///     def visit_packed_node_out(self, node):
///         """Called after all nodes returned from a corresponding ``visit_packed_node_in``
///         call have been visited."""
///         pass
///
///     def on_cycle(self, node, path):
///         """Called when a cycle is encountered.
///
///         Parameters:
///             node: The node that causes a cycle.
///             path: The list of nodes being visited: nodes that have been
///                 entered but not exited. The first element is the root in a forest
///                 visit, and the last element is the node visited most recently.
///                 ``path`` should be treated as read-only.
///         """
///         pass
///
///     def get_cycle_in_path(self, node, path):
///         """A utility function for use in ``on_cycle`` to obtain a slice of
///         ``path`` that only contains the nodes that make up the cycle."""
///         index = len(path) - 1
///         while id(path[index]) != id(node):
///             index -= 1
///         return path[index:]
///
///     def visit(self, root):
///         # Visiting is a list of IDs of all symbol/intermediate nodes currently in
///         # the stack. It serves two purposes: to detect when we 'recurse' in and out
///         # of a symbol/intermediate so that we can process both up and down. Also,
///         # since the SPPF can have cycles it allows us to detect if we're trying
///         # to recurse into a node that's already on the stack (infinite recursion).
///         visiting = set()
///
///         # set of all nodes that have been visited
///         visited = set()
///
///         # a list of nodes that are currently being visited
///         # used for the `on_cycle` callback
///         path = []
///
///         # We do not use recursion here to walk the Forest due to the limited
///         # stack size in python. Therefore input_stack is essentially our stack.
///         input_stack = deque([root])
///
///         # It is much faster to cache these as locals since they are called
///         # many times in large parses.
///         vpno = getattr(self, 'visit_packed_node_out')
///         vpni = getattr(self, 'visit_packed_node_in')
///         vsno = getattr(self, 'visit_symbol_node_out')
///         vsni = getattr(self, 'visit_symbol_node_in')
///         vino = getattr(self, 'visit_intermediate_node_out', vsno)
///         vini = getattr(self, 'visit_intermediate_node_in', vsni)
///         vtn = getattr(self, 'visit_token_node')
///         oc = getattr(self, 'on_cycle')
///
///         while input_stack:
///             current = next(reversed(input_stack))
///             try:
///                 next_node = next(current)
///             except StopIteration:
///                 input_stack.pop()
///                 continue
///             except TypeError:
///                 ### If the current object is not an iterator, pass through to Token/SymbolNode
///                 pass
///             else:
///                 if next_node is None:
///                     continue
///
///                 if id(next_node) in visiting:
///                     oc(next_node, path)
///                     continue
///
///                 input_stack.append(next_node)
///                 continue
///
///             if isinstance(current, TokenNode):
///                 vtn(current.token)
///                 input_stack.pop()
///                 continue
///
///             current_id = id(current)
///             if current_id in visiting:
///                 if isinstance(current, PackedNode):
///                     vpno(current)
///                 elif current.is_intermediate:
///                     vino(current)
///                 else:
///                     vsno(current)
///                 input_stack.pop()
///                 path.pop()
///                 visiting.remove(current_id)
///                 visited.add(current_id)
///             elif self.single_visit and current_id in visited:
///                 input_stack.pop()
///             else:
///                 visiting.add(current_id)
///                 path.append(current)
///                 if isinstance(current, PackedNode):
///                     next_node = vpni(current)
///                 elif current.is_intermediate:
///                     next_node = vini(current)
///                 else:
///                     next_node = vsni(current)
///                 if next_node is None:
///                     continue
///
///                 if not isinstance(next_node, ForestNode):
///                     next_node = iter(next_node)
///                 elif id(next_node) in visiting:
///                     oc(next_node, path)
///                     continue
///
///                 input_stack.append(next_node)
/// ```
final class ForestVisitor extends PythonClass {
  factory ForestVisitor({
    Object? single_visit = false,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
        "ForestVisitor",
        ForestVisitor.from,
        <Object?>[
          single_visit,
        ],
        <String, Object?>{},
      );

  ForestVisitor.from(super.pythonClass) : super.from();

  /// ## get_cycle_in_path
  ///
  /// ### python docstring
  ///
  /// A utility function for use in ``on_cycle`` to obtain a slice of
  /// ``path`` that only contains the nodes that make up the cycle.
  ///
  /// ### python source
  /// ```py
  /// def get_cycle_in_path(self, node, path):
  ///         """A utility function for use in ``on_cycle`` to obtain a slice of
  ///         ``path`` that only contains the nodes that make up the cycle."""
  ///         index = len(path) - 1
  ///         while id(path[index]) != id(node):
  ///             index -= 1
  ///         return path[index:]
  /// ```
  Object? get_cycle_in_path({
    required Object? node,
    required Object? path,
  }) =>
      getFunction("get_cycle_in_path").call(
        <Object?>[
          node,
          path,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## on_cycle
  ///
  /// ### python docstring
  ///
  /// Called when a cycle is encountered.
  ///
  /// Parameters:
  ///     node: The node that causes a cycle.
  ///     path: The list of nodes being visited: nodes that have been
  ///         entered but not exited. The first element is the root in a forest
  ///         visit, and the last element is the node visited most recently.
  ///         ``path`` should be treated as read-only.
  ///
  /// ### python source
  /// ```py
  /// def on_cycle(self, node, path):
  ///         """Called when a cycle is encountered.
  ///
  ///         Parameters:
  ///             node: The node that causes a cycle.
  ///             path: The list of nodes being visited: nodes that have been
  ///                 entered but not exited. The first element is the root in a forest
  ///                 visit, and the last element is the node visited most recently.
  ///                 ``path`` should be treated as read-only.
  ///         """
  ///         pass
  /// ```
  Object? on_cycle({
    required Object? node,
    required Object? path,
  }) =>
      getFunction("on_cycle").call(
        <Object?>[
          node,
          path,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit
  ///
  /// ### python source
  /// ```py
  /// def visit(self, root):
  ///         # Visiting is a list of IDs of all symbol/intermediate nodes currently in
  ///         # the stack. It serves two purposes: to detect when we 'recurse' in and out
  ///         # of a symbol/intermediate so that we can process both up and down. Also,
  ///         # since the SPPF can have cycles it allows us to detect if we're trying
  ///         # to recurse into a node that's already on the stack (infinite recursion).
  ///         visiting = set()
  ///
  ///         # set of all nodes that have been visited
  ///         visited = set()
  ///
  ///         # a list of nodes that are currently being visited
  ///         # used for the `on_cycle` callback
  ///         path = []
  ///
  ///         # We do not use recursion here to walk the Forest due to the limited
  ///         # stack size in python. Therefore input_stack is essentially our stack.
  ///         input_stack = deque([root])
  ///
  ///         # It is much faster to cache these as locals since they are called
  ///         # many times in large parses.
  ///         vpno = getattr(self, 'visit_packed_node_out')
  ///         vpni = getattr(self, 'visit_packed_node_in')
  ///         vsno = getattr(self, 'visit_symbol_node_out')
  ///         vsni = getattr(self, 'visit_symbol_node_in')
  ///         vino = getattr(self, 'visit_intermediate_node_out', vsno)
  ///         vini = getattr(self, 'visit_intermediate_node_in', vsni)
  ///         vtn = getattr(self, 'visit_token_node')
  ///         oc = getattr(self, 'on_cycle')
  ///
  ///         while input_stack:
  ///             current = next(reversed(input_stack))
  ///             try:
  ///                 next_node = next(current)
  ///             except StopIteration:
  ///                 input_stack.pop()
  ///                 continue
  ///             except TypeError:
  ///                 ### If the current object is not an iterator, pass through to Token/SymbolNode
  ///                 pass
  ///             else:
  ///                 if next_node is None:
  ///                     continue
  ///
  ///                 if id(next_node) in visiting:
  ///                     oc(next_node, path)
  ///                     continue
  ///
  ///                 input_stack.append(next_node)
  ///                 continue
  ///
  ///             if isinstance(current, TokenNode):
  ///                 vtn(current.token)
  ///                 input_stack.pop()
  ///                 continue
  ///
  ///             current_id = id(current)
  ///             if current_id in visiting:
  ///                 if isinstance(current, PackedNode):
  ///                     vpno(current)
  ///                 elif current.is_intermediate:
  ///                     vino(current)
  ///                 else:
  ///                     vsno(current)
  ///                 input_stack.pop()
  ///                 path.pop()
  ///                 visiting.remove(current_id)
  ///                 visited.add(current_id)
  ///             elif self.single_visit and current_id in visited:
  ///                 input_stack.pop()
  ///             else:
  ///                 visiting.add(current_id)
  ///                 path.append(current)
  ///                 if isinstance(current, PackedNode):
  ///                     next_node = vpni(current)
  ///                 elif current.is_intermediate:
  ///                     next_node = vini(current)
  ///                 else:
  ///                     next_node = vsni(current)
  ///                 if next_node is None:
  ///                     continue
  ///
  ///                 if not isinstance(next_node, ForestNode):
  ///                     next_node = iter(next_node)
  ///                 elif id(next_node) in visiting:
  ///                     oc(next_node, path)
  ///                     continue
  ///
  ///                 input_stack.append(next_node)
  /// ```
  Object? visit({
    required Object? root,
  }) =>
      getFunction("visit").call(
        <Object?>[
          root,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_packed_node_in
  ///
  /// ### python docstring
  ///
  /// Called when a packed node is visited. Nodes that are returned
  /// will be scheduled to be visited.
  ///
  /// ### python source
  /// ```py
  /// def visit_packed_node_in(self, node):
  ///         """Called when a packed node is visited. Nodes that are returned
  ///         will be scheduled to be visited. """
  ///         pass
  /// ```
  Object? visit_packed_node_in({
    required Object? node,
  }) =>
      getFunction("visit_packed_node_in").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_packed_node_out
  ///
  /// ### python docstring
  ///
  /// Called after all nodes returned from a corresponding ``visit_packed_node_in``
  /// call have been visited.
  ///
  /// ### python source
  /// ```py
  /// def visit_packed_node_out(self, node):
  ///         """Called after all nodes returned from a corresponding ``visit_packed_node_in``
  ///         call have been visited."""
  ///         pass
  /// ```
  Object? visit_packed_node_out({
    required Object? node,
  }) =>
      getFunction("visit_packed_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_symbol_node_in
  ///
  /// ### python docstring
  ///
  /// Called when a symbol node is visited. Nodes that are returned
  /// will be scheduled to be visited. If ``visit_intermediate_node_in``
  /// is not implemented, this function will be called for intermediate
  /// nodes as well.
  ///
  /// ### python source
  /// ```py
  /// def visit_symbol_node_in(self, node):
  ///         """Called when a symbol node is visited. Nodes that are returned
  ///         will be scheduled to be visited. If ``visit_intermediate_node_in``
  ///         is not implemented, this function will be called for intermediate
  ///         nodes as well."""
  ///         pass
  /// ```
  Object? visit_symbol_node_in({
    required Object? node,
  }) =>
      getFunction("visit_symbol_node_in").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_symbol_node_out
  ///
  /// ### python docstring
  ///
  /// Called after all nodes returned from a corresponding ``visit_symbol_node_in``
  /// call have been visited. If ``visit_intermediate_node_out``
  /// is not implemented, this function will be called for intermediate
  /// nodes as well.
  ///
  /// ### python source
  /// ```py
  /// def visit_symbol_node_out(self, node):
  ///         """Called after all nodes returned from a corresponding ``visit_symbol_node_in``
  ///         call have been visited. If ``visit_intermediate_node_out``
  ///         is not implemented, this function will be called for intermediate
  ///         nodes as well."""
  ///         pass
  /// ```
  Object? visit_symbol_node_out({
    required Object? node,
  }) =>
      getFunction("visit_symbol_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_token_node
  ///
  /// ### python docstring
  ///
  /// Called when a ``Token`` is visited. ``Token`` nodes are always leaves.
  ///
  /// ### python source
  /// ```py
  /// def visit_token_node(self, node):
  ///         """Called when a ``Token`` is visited. ``Token`` nodes are always leaves."""
  ///         pass
  /// ```
  Object? visit_token_node({
    required Object? node,
  }) =>
      getFunction("visit_token_node").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## single_visit (getter)
  ///
  /// ### python docstring
  ///
  /// An abstract base class for building forest visitors.
  ///
  /// This class performs a controllable depth-first walk of an SPPF.
  /// The visitor will not enter cycles and will backtrack if one is encountered.
  /// Subclasses are notified of cycles through the ``on_cycle`` method.
  ///
  /// Behavior for visit events is defined by overriding the
  /// ``visit*node*`` functions.
  ///
  /// The walk is controlled by the return values of the ``visit*node_in``
  /// methods. Returning a node(s) will schedule them to be visited. The visitor
  /// will begin to backtrack if no nodes are returned.
  ///
  /// Parameters:
  ///     single_visit: If ``True``, non-Token nodes will only be visited once.
  Object? get single_visit => getAttribute("single_visit");

  /// ## single_visit (setter)
  ///
  /// ### python docstring
  ///
  /// An abstract base class for building forest visitors.
  ///
  /// This class performs a controllable depth-first walk of an SPPF.
  /// The visitor will not enter cycles and will backtrack if one is encountered.
  /// Subclasses are notified of cycles through the ``on_cycle`` method.
  ///
  /// Behavior for visit events is defined by overriding the
  /// ``visit*node*`` functions.
  ///
  /// The walk is controlled by the return values of the ``visit*node_in``
  /// methods. Returning a node(s) will schedule them to be visited. The visitor
  /// will begin to backtrack if no nodes are returned.
  ///
  /// Parameters:
  ///     single_visit: If ``True``, non-Token nodes will only be visited once.
  set single_visit(Object? single_visit) =>
      setAttribute("single_visit", single_visit);
}

/// ## PackedData
///
/// ### python docstring
///
/// Used in transformationss of packed nodes to distinguish the data
/// that comes from the left child and the right child.
///
/// ### python source
/// ```py
/// class PackedData():
///     """Used in transformationss of packed nodes to distinguish the data
///     that comes from the left child and the right child.
///     """
///
///     class _NoData():
///         pass
///
///     NO_DATA = _NoData()
///
///     def __init__(self, node, data):
///         self.left = self.NO_DATA
///         self.right = self.NO_DATA
///         if data:
///             if node.left is not None:
///                 self.left = data[0]
///                 if len(data) > 1:
///                     self.right = data[1]
///             else:
///                 self.right = data[0]
/// ```
final class PackedData extends PythonClass {
  factory PackedData({
    required Object? node,
    required Object? data,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
        "PackedData",
        PackedData.from,
        <Object?>[
          node,
          data,
        ],
        <String, Object?>{},
      );

  PackedData.from(super.pythonClass) : super.from();

  /// ## NO_DATA (getter)
  ///
  /// ### python docstring
  ///
  /// Used in transformationss of packed nodes to distinguish the data
  /// that comes from the left child and the right child.
  Object? get NO_DATA => getAttribute("NO_DATA");

  /// ## NO_DATA (setter)
  ///
  /// ### python docstring
  ///
  /// Used in transformationss of packed nodes to distinguish the data
  /// that comes from the left child and the right child.
  set NO_DATA(Object? NO_DATA) => setAttribute("NO_DATA", NO_DATA);

  /// ## left (getter)
  ///
  /// ### python docstring
  ///
  /// Used in transformationss of packed nodes to distinguish the data
  /// that comes from the left child and the right child.
  Object? get left => getAttribute("left");

  /// ## left (setter)
  ///
  /// ### python docstring
  ///
  /// Used in transformationss of packed nodes to distinguish the data
  /// that comes from the left child and the right child.
  set left(Object? left) => setAttribute("left", left);

  /// ## right (getter)
  ///
  /// ### python docstring
  ///
  /// Used in transformationss of packed nodes to distinguish the data
  /// that comes from the left child and the right child.
  Object? get right => getAttribute("right");

  /// ## right (setter)
  ///
  /// ### python docstring
  ///
  /// Used in transformationss of packed nodes to distinguish the data
  /// that comes from the left child and the right child.
  set right(Object? right) => setAttribute("right", right);
}

/// ## PackedNode
///
/// ### python docstring
///
/// A Packed Node represents a single derivation in a symbol node.
///
/// Parameters:
///     rule: The rule associated with this node.
///     parent: The parent of this node.
///     left: The left child of this node. ``None`` if one does not exist.
///     right: The right child of this node. ``None`` if one does not exist.
///     priority: The priority of this node.
///
/// ### python source
/// ```py
/// class PackedNode(ForestNode):
///     """
///     A Packed Node represents a single derivation in a symbol node.
///
///     Parameters:
///         rule: The rule associated with this node.
///         parent: The parent of this node.
///         left: The left child of this node. ``None`` if one does not exist.
///         right: The right child of this node. ``None`` if one does not exist.
///         priority: The priority of this node.
///     """
///     __slots__ = ('parent', 's', 'rule', 'start', 'left', 'right', 'priority', '_hash')
///     def __init__(self, parent, s, rule, start, left, right):
///         self.parent = parent
///         self.s = s
///         self.start = start
///         self.rule = rule
///         self.left = left
///         self.right = right
///         self.priority = float('-inf')
///         self._hash = hash((self.left, self.right))
///
///     @property
///     def is_empty(self):
///         return self.left is None and self.right is None
///
///     @property
///     def sort_key(self):
///         """
///         Used to sort PackedNode children of SymbolNodes.
///         A SymbolNode has multiple PackedNodes if it matched
///         ambiguously. Hence, we use the sort order to identify
///         the order in which ambiguous children should be considered.
///         """
///         return self.is_empty, -self.priority, self.rule.order
///
///     @property
///     def children(self):
///         """Returns a list of this node's children."""
///         return [x for x in [self.left, self.right] if x is not None]
///
///     def __iter__(self):
///         yield self.left
///         yield self.right
///
///     def __eq__(self, other):
///         if not isinstance(other, PackedNode):
///             return False
///         return self is other or (self.left == other.left and self.right == other.right)
///
///     def __hash__(self):
///         return self._hash
///
///     def __repr__(self):
///         if isinstance(self.s, tuple):
///             rule = self.s[0]
///             ptr = self.s[1]
///             before = ( expansion.name for expansion in rule.expansion[:ptr] )
///             after = ( expansion.name for expansion in rule.expansion[ptr:] )
///             symbol = "{} ::= {}* {}".format(rule.origin.name, ' '.join(before), ' '.join(after))
///         else:
///             symbol = self.s.name
///         return "({}, {}, {}, {})".format(symbol, self.start, self.priority, self.rule.order)
/// ```
final class PackedNode extends PythonClass {
  factory PackedNode({
    required Object? parent,
    required Object? s,
    required Object? rule,
    required Object? start,
    required Object? left,
    required Object? right,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
        "PackedNode",
        PackedNode.from,
        <Object?>[
          parent,
          s,
          rule,
          start,
          left,
          right,
        ],
        <String, Object?>{},
      );

  PackedNode.from(super.pythonClass) : super.from();

  /// ## children (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get children => getAttribute("children");

  /// ## children (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set children(Object? children) => setAttribute("children", children);

  /// ## is_empty (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get is_empty => getAttribute("is_empty");

  /// ## is_empty (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set is_empty(Object? is_empty) => setAttribute("is_empty", is_empty);

  /// ## sort_key (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get sort_key => getAttribute("sort_key");

  /// ## sort_key (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set sort_key(Object? sort_key) => setAttribute("sort_key", sort_key);

  /// ## left (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get left => getAttribute("left");

  /// ## left (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set left(Object? left) => setAttribute("left", left);

  /// ## parent (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get parent => getAttribute("parent");

  /// ## parent (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set parent(Object? parent) => setAttribute("parent", parent);

  /// ## priority (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get priority => getAttribute("priority");

  /// ## priority (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set priority(Object? priority) => setAttribute("priority", priority);

  /// ## right (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get right => getAttribute("right");

  /// ## right (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set right(Object? right) => setAttribute("right", right);

  /// ## rule (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get rule => getAttribute("rule");

  /// ## rule (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set rule(Object? rule) => setAttribute("rule", rule);

  /// ## s (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get s => getAttribute("s");

  /// ## s (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set s(Object? s) => setAttribute("s", s);

  /// ## start (getter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  Object? get start => getAttribute("start");

  /// ## start (setter)
  ///
  /// ### python docstring
  ///
  /// A Packed Node represents a single derivation in a symbol node.
  ///
  /// Parameters:
  ///     rule: The rule associated with this node.
  ///     parent: The parent of this node.
  ///     left: The left child of this node. ``None`` if one does not exist.
  ///     right: The right child of this node. ``None`` if one does not exist.
  ///     priority: The priority of this node.
  set start(Object? start) => setAttribute("start", start);
}

/// ## SymbolNode
///
/// ### python docstring
///
/// A Symbol Node represents a symbol (or Intermediate LR0).
///
/// Symbol nodes are keyed by the symbol (s). For intermediate nodes
/// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
/// nodes, s will be a string representing the non-terminal origin (i.e.
/// the left hand side of the rule).
///
/// The children of a Symbol or Intermediate Node will always be Packed Nodes;
/// with each Packed Node child representing a single derivation of a production.
///
/// Hence a Symbol Node with a single child is unambiguous.
///
/// Parameters:
///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
///     start: The index of the start of the substring matched by this symbol (inclusive).
///     end: The index of the end of the substring matched by this symbol (exclusive).
///
/// Properties:
///     is_intermediate: True if this node is an intermediate node.
///     priority: The priority of the node's symbol.
///
/// ### python source
/// ```py
/// class SymbolNode(ForestNode):
///     """
///     A Symbol Node represents a symbol (or Intermediate LR0).
///
///     Symbol nodes are keyed by the symbol (s). For intermediate nodes
///     s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
///     nodes, s will be a string representing the non-terminal origin (i.e.
///     the left hand side of the rule).
///
///     The children of a Symbol or Intermediate Node will always be Packed Nodes;
///     with each Packed Node child representing a single derivation of a production.
///
///     Hence a Symbol Node with a single child is unambiguous.
///
///     Parameters:
///         s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
///         start: The index of the start of the substring matched by this symbol (inclusive).
///         end: The index of the end of the substring matched by this symbol (exclusive).
///
///     Properties:
///         is_intermediate: True if this node is an intermediate node.
///         priority: The priority of the node's symbol.
///     """
///     __slots__ = ('s', 'start', 'end', '_children', 'paths', 'paths_loaded', 'priority', 'is_intermediate', '_hash')
///     def __init__(self, s, start, end):
///         self.s = s
///         self.start = start
///         self.end = end
///         self._children = set()
///         self.paths = set()
///         self.paths_loaded = False
///
///         ### We use inf here as it can be safely negated without resorting to conditionals,
///         #   unlike None or float('NaN'), and sorts appropriately.
///         self.priority = float('-inf')
///         self.is_intermediate = isinstance(s, tuple)
///         self._hash = hash((self.s, self.start, self.end))
///
///     def add_family(self, lr0, rule, start, left, right):
///         self._children.add(PackedNode(self, lr0, rule, start, left, right))
///
///     def add_path(self, transitive, node):
///         self.paths.add((transitive, node))
///
///     def load_paths(self):
///         for transitive, node in self.paths:
///             if transitive.next_titem is not None:
///                 vn = SymbolNode(transitive.next_titem.s, transitive.next_titem.start, self.end)
///                 vn.add_path(transitive.next_titem, node)
///                 self.add_family(transitive.reduction.rule.origin, transitive.reduction.rule, transitive.reduction.start, transitive.reduction.node, vn)
///             else:
///                 self.add_family(transitive.reduction.rule.origin, transitive.reduction.rule, transitive.reduction.start, transitive.reduction.node, node)
///         self.paths_loaded = True
///
///     @property
///     def is_ambiguous(self):
///         """Returns True if this node is ambiguous."""
///         return len(self.children) > 1
///
///     @property
///     def children(self):
///         """Returns a list of this node's children sorted from greatest to
///         least priority."""
///         if not self.paths_loaded:
///             self.load_paths()
///         return sorted(self._children, key=attrgetter('sort_key'))
///
///     def __iter__(self):
///         return iter(self._children)
///
///     def __eq__(self, other):
///         if not isinstance(other, SymbolNode):
///             return False
///         return self is other or (type(self.s) == type(other.s) and self.s == other.s and self.start == other.start and self.end is other.end)
///
///     def __hash__(self):
///         return self._hash
///
///     def __repr__(self):
///         if self.is_intermediate:
///             rule = self.s[0]
///             ptr = self.s[1]
///             before = ( expansion.name for expansion in rule.expansion[:ptr] )
///             after = ( expansion.name for expansion in rule.expansion[ptr:] )
///             symbol = "{} ::= {}* {}".format(rule.origin.name, ' '.join(before), ' '.join(after))
///         else:
///             symbol = self.s.name
///         return "({}, {}, {}, {})".format(symbol, self.start, self.end, self.priority)
/// ```
final class SymbolNode extends PythonClass {
  factory SymbolNode({
    required Object? s,
    required Object? start,
    required Object? end,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
        "SymbolNode",
        SymbolNode.from,
        <Object?>[
          s,
          start,
          end,
        ],
        <String, Object?>{},
      );

  SymbolNode.from(super.pythonClass) : super.from();

  /// ## add_family
  ///
  /// ### python source
  /// ```py
  /// def add_family(self, lr0, rule, start, left, right):
  ///         self._children.add(PackedNode(self, lr0, rule, start, left, right))
  /// ```
  Object? add_family({
    required Object? lr0,
    required Object? rule,
    required Object? start,
    required Object? left,
    required Object? right,
  }) =>
      getFunction("add_family").call(
        <Object?>[
          lr0,
          rule,
          start,
          left,
          right,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## add_path
  ///
  /// ### python source
  /// ```py
  /// def add_path(self, transitive, node):
  ///         self.paths.add((transitive, node))
  /// ```
  Object? add_path({
    required Object? transitive,
    required Object? node,
  }) =>
      getFunction("add_path").call(
        <Object?>[
          transitive,
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## load_paths
  ///
  /// ### python source
  /// ```py
  /// def load_paths(self):
  ///         for transitive, node in self.paths:
  ///             if transitive.next_titem is not None:
  ///                 vn = SymbolNode(transitive.next_titem.s, transitive.next_titem.start, self.end)
  ///                 vn.add_path(transitive.next_titem, node)
  ///                 self.add_family(transitive.reduction.rule.origin, transitive.reduction.rule, transitive.reduction.start, transitive.reduction.node, vn)
  ///             else:
  ///                 self.add_family(transitive.reduction.rule.origin, transitive.reduction.rule, transitive.reduction.start, transitive.reduction.node, node)
  ///         self.paths_loaded = True
  /// ```
  Object? load_paths() => getFunction("load_paths").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## children (getter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  Object? get children => getAttribute("children");

  /// ## children (setter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  set children(Object? children) => setAttribute("children", children);

  /// ## is_ambiguous (getter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  Object? get is_ambiguous => getAttribute("is_ambiguous");

  /// ## is_ambiguous (setter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  set is_ambiguous(Object? is_ambiguous) =>
      setAttribute("is_ambiguous", is_ambiguous);

  /// ## end (getter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  Object? get end => getAttribute("end");

  /// ## end (setter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  set end(Object? end) => setAttribute("end", end);

  /// ## is_intermediate (getter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  Object? get is_intermediate => getAttribute("is_intermediate");

  /// ## is_intermediate (setter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  set is_intermediate(Object? is_intermediate) =>
      setAttribute("is_intermediate", is_intermediate);

  /// ## paths (getter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  Object? get paths => getAttribute("paths");

  /// ## paths (setter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  set paths(Object? paths) => setAttribute("paths", paths);

  /// ## paths_loaded (getter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  Object? get paths_loaded => getAttribute("paths_loaded");

  /// ## paths_loaded (setter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  set paths_loaded(Object? paths_loaded) =>
      setAttribute("paths_loaded", paths_loaded);

  /// ## priority (getter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  Object? get priority => getAttribute("priority");

  /// ## priority (setter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  set priority(Object? priority) => setAttribute("priority", priority);

  /// ## s (getter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  Object? get s => getAttribute("s");

  /// ## s (setter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  set s(Object? s) => setAttribute("s", s);

  /// ## start (getter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  Object? get start => getAttribute("start");

  /// ## start (setter)
  ///
  /// ### python docstring
  ///
  /// A Symbol Node represents a symbol (or Intermediate LR0).
  ///
  /// Symbol nodes are keyed by the symbol (s). For intermediate nodes
  /// s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
  /// nodes, s will be a string representing the non-terminal origin (i.e.
  /// the left hand side of the rule).
  ///
  /// The children of a Symbol or Intermediate Node will always be Packed Nodes;
  /// with each Packed Node child representing a single derivation of a production.
  ///
  /// Hence a Symbol Node with a single child is unambiguous.
  ///
  /// Parameters:
  ///     s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
  ///     start: The index of the start of the substring matched by this symbol (inclusive).
  ///     end: The index of the end of the substring matched by this symbol (exclusive).
  ///
  /// Properties:
  ///     is_intermediate: True if this node is an intermediate node.
  ///     priority: The priority of the node's symbol.
  set start(Object? start) => setAttribute("start", start);
}

/// ## TokenNode
///
/// ### python docstring
///
/// A Token Node represents a matched terminal and is always a leaf node.
///
/// Parameters:
///     token: The Token associated with this node.
///     term: The TerminalDef matched by the token.
///     priority: The priority of this node.
///
/// ### python source
/// ```py
/// class TokenNode(ForestNode):
///     """
///     A Token Node represents a matched terminal and is always a leaf node.
///
///     Parameters:
///         token: The Token associated with this node.
///         term: The TerminalDef matched by the token.
///         priority: The priority of this node.
///     """
///     __slots__ = ('token', 'term', 'priority', '_hash')
///     def __init__(self, token, term, priority=None):
///         self.token = token
///         self.term = term
///         if priority is not None:
///             self.priority = priority
///         else:
///             self.priority = term.priority if term is not None else 0
///         self._hash = hash(token)
///
///     def __eq__(self, other):
///         if not isinstance(other, TokenNode):
///             return False
///         return self is other or (self.token == other.token)
///
///     def __hash__(self):
///         return self._hash
///
///     def __repr__(self):
///         return repr(self.token)
/// ```
final class TokenNode extends PythonClass {
  factory TokenNode({
    required Object? token,
    required Object? term,
    Object? priority,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
        "TokenNode",
        TokenNode.from,
        <Object?>[
          token,
          term,
          priority,
        ],
        <String, Object?>{},
      );

  TokenNode.from(super.pythonClass) : super.from();

  /// ## priority (getter)
  ///
  /// ### python docstring
  ///
  /// A Token Node represents a matched terminal and is always a leaf node.
  ///
  /// Parameters:
  ///     token: The Token associated with this node.
  ///     term: The TerminalDef matched by the token.
  ///     priority: The priority of this node.
  Object? get priority => getAttribute("priority");

  /// ## priority (setter)
  ///
  /// ### python docstring
  ///
  /// A Token Node represents a matched terminal and is always a leaf node.
  ///
  /// Parameters:
  ///     token: The Token associated with this node.
  ///     term: The TerminalDef matched by the token.
  ///     priority: The priority of this node.
  set priority(Object? priority) => setAttribute("priority", priority);

  /// ## term (getter)
  ///
  /// ### python docstring
  ///
  /// A Token Node represents a matched terminal and is always a leaf node.
  ///
  /// Parameters:
  ///     token: The Token associated with this node.
  ///     term: The TerminalDef matched by the token.
  ///     priority: The priority of this node.
  Object? get term => getAttribute("term");

  /// ## term (setter)
  ///
  /// ### python docstring
  ///
  /// A Token Node represents a matched terminal and is always a leaf node.
  ///
  /// Parameters:
  ///     token: The Token associated with this node.
  ///     term: The TerminalDef matched by the token.
  ///     priority: The priority of this node.
  set term(Object? term) => setAttribute("term", term);

  /// ## token (getter)
  ///
  /// ### python docstring
  ///
  /// A Token Node represents a matched terminal and is always a leaf node.
  ///
  /// Parameters:
  ///     token: The Token associated with this node.
  ///     term: The TerminalDef matched by the token.
  ///     priority: The priority of this node.
  Object? get token => getAttribute("token");

  /// ## token (setter)
  ///
  /// ### python docstring
  ///
  /// A Token Node represents a matched terminal and is always a leaf node.
  ///
  /// Parameters:
  ///     token: The Token associated with this node.
  ///     term: The TerminalDef matched by the token.
  ///     priority: The priority of this node.
  set token(Object? token) => setAttribute("token", token);
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

/// ## TreeForestTransformer
///
/// ### python docstring
///
/// A ``ForestTransformer`` with a tree ``Transformer``-like interface.
/// By default, it will construct a tree.
///
/// Methods provided via inheritance are called based on the rule/symbol
/// names of nodes in the forest.
///
/// Methods that act on rules will receive a list of the results of the
/// transformations of the rule's children. By default, trees and tokens.
///
/// Methods that act on tokens will receive a token.
///
/// Alternatively, methods that act on rules may be annotated with
/// ``handles_ambiguity``. In this case, the function will receive a list
/// of all the transformations of all the derivations of the rule.
/// By default, a list of trees where each tree.data is equal to the
/// rule name or one of its aliases.
///
/// Non-tree transformations are made possible by override of
/// ``__default__``, ``__default_token__``, and ``__default_ambig__``.
///
/// Note:
///     Tree shaping features such as inlined rules and token filtering are
///     not built into the transformation. Positions are also not propagated.
///
/// Parameters:
///     tree_class: The tree class to use for construction
///     prioritizer: A ``ForestVisitor`` that manipulates the priorities of nodes in the SPPF.
///     resolve_ambiguity: If True, ambiguities will be resolved based on priorities.
///     use_cache (bool): If True, caches the results of some transformations,
///                       potentially improving performance when ``resolve_ambiguity==False``.
///                       Only use if you know what you are doing: i.e. All transformation
///                       functions are pure and referentially transparent.
///
/// ### python source
/// ```py
/// class TreeForestTransformer(ForestToParseTree):
///     """A ``ForestTransformer`` with a tree ``Transformer``-like interface.
///     By default, it will construct a tree.
///
///     Methods provided via inheritance are called based on the rule/symbol
///     names of nodes in the forest.
///
///     Methods that act on rules will receive a list of the results of the
///     transformations of the rule's children. By default, trees and tokens.
///
///     Methods that act on tokens will receive a token.
///
///     Alternatively, methods that act on rules may be annotated with
///     ``handles_ambiguity``. In this case, the function will receive a list
///     of all the transformations of all the derivations of the rule.
///     By default, a list of trees where each tree.data is equal to the
///     rule name or one of its aliases.
///
///     Non-tree transformations are made possible by override of
///     ``__default__``, ``__default_token__``, and ``__default_ambig__``.
///
///     Note:
///         Tree shaping features such as inlined rules and token filtering are
///         not built into the transformation. Positions are also not propagated.
///
///     Parameters:
///         tree_class: The tree class to use for construction
///         prioritizer: A ``ForestVisitor`` that manipulates the priorities of nodes in the SPPF.
///         resolve_ambiguity: If True, ambiguities will be resolved based on priorities.
///         use_cache (bool): If True, caches the results of some transformations,
///                           potentially improving performance when ``resolve_ambiguity==False``.
///                           Only use if you know what you are doing: i.e. All transformation
///                           functions are pure and referentially transparent.
///     """
///
///     def __init__(self, tree_class=Tree, prioritizer=ForestSumVisitor(), resolve_ambiguity=True, use_cache=False):
///         super(TreeForestTransformer, self).__init__(tree_class, dict(), prioritizer, resolve_ambiguity, use_cache)
///
///     def __default__(self, name, data):
///         """Default operation on tree (for override).
///
///         Returns a tree with name with data as children.
///         """
///         return self.tree_class(name, data)
///
///     def __default_ambig__(self, name, data):
///         """Default operation on ambiguous rule (for override).
///
///         Wraps data in an '_ambig_' node if it contains more than
///         one element.
///         """
///         if len(data) > 1:
///             return self.tree_class('_ambig', data)
///         elif data:
///             return data[0]
///         return Discard
///
///     def __default_token__(self, node):
///         """Default operation on ``Token`` (for override).
///
///         Returns ``node``.
///         """
///         return node
///
///     def transform_token_node(self, node):
///         return getattr(self, node.type, self.__default_token__)(node)
///
///     def _call_rule_func(self, node, data):
///         name = node.rule.alias or node.rule.options.template_source or node.rule.origin.name
///         user_func = getattr(self, name, self.__default__)
///         if user_func == self.__default__ or hasattr(user_func, 'handles_ambiguity'):
///             user_func = partial(self.__default__, name)
///         if not self.resolve_ambiguity:
///             wrapper = partial(AmbiguousIntermediateExpander, self.tree_class)
///             user_func = wrapper(user_func)
///         return user_func(data)
///
///     def _call_ambig_func(self, node, data):
///         name = node.s.name
///         user_func = getattr(self, name, self.__default_ambig__)
///         if user_func == self.__default_ambig__ or not hasattr(user_func, 'handles_ambiguity'):
///             user_func = partial(self.__default_ambig__, name)
///         return user_func(data)
/// ```
final class TreeForestTransformer extends PythonClass {
  factory TreeForestTransformer({
    Object? tree_class,
    Object? prioritizer,
    Object? resolve_ambiguity = true,
    Object? use_cache = false,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.earley_forest",
        "TreeForestTransformer",
        TreeForestTransformer.from,
        <Object?>[
          tree_class,
          prioritizer,
          resolve_ambiguity,
          use_cache,
        ],
        <String, Object?>{},
      );

  TreeForestTransformer.from(super.pythonClass) : super.from();

  /// ## get_cycle_in_path
  ///
  /// ### python docstring
  ///
  /// A utility function for use in ``on_cycle`` to obtain a slice of
  /// ``path`` that only contains the nodes that make up the cycle.
  ///
  /// ### python source
  /// ```py
  /// def get_cycle_in_path(self, node, path):
  ///         """A utility function for use in ``on_cycle`` to obtain a slice of
  ///         ``path`` that only contains the nodes that make up the cycle."""
  ///         index = len(path) - 1
  ///         while id(path[index]) != id(node):
  ///             index -= 1
  ///         return path[index:]
  /// ```
  Object? get_cycle_in_path({
    required Object? node,
    required Object? path,
  }) =>
      getFunction("get_cycle_in_path").call(
        <Object?>[
          node,
          path,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## on_cycle
  ///
  /// ### python docstring
  ///
  /// Called when a cycle is encountered.
  ///
  /// Parameters:
  ///     node: The node that causes a cycle.
  ///     path: The list of nodes being visited: nodes that have been
  ///         entered but not exited. The first element is the root in a forest
  ///         visit, and the last element is the node visited most recently.
  ///         ``path`` should be treated as read-only.
  ///
  /// ### python source
  /// ```py
  /// def on_cycle(self, node, path):
  ///         logger.debug("Cycle encountered in the SPPF at node: %s. "
  ///                 "As infinite ambiguities cannot be represented in a tree, "
  ///                 "this family of derivations will be discarded.", node)
  ///         self._cycle_node = node
  ///         self._on_cycle_retreat = True
  /// ```
  Object? on_cycle({
    required Object? node,
    required Object? path,
  }) =>
      getFunction("on_cycle").call(
        <Object?>[
          node,
          path,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform
  ///
  /// ### python docstring
  ///
  /// Perform a transformation on an SPPF.
  ///
  /// ### python source
  /// ```py
  /// def transform(self, root):
  ///         """Perform a transformation on an SPPF."""
  ///         self.node_stack.append('result')
  ///         self.data['result'] = []
  ///         self.visit(root)
  ///         assert len(self.data['result']) <= 1
  ///         if self.data['result']:
  ///             return self.data['result'][0]
  /// ```
  Object? transform({
    required Object? root,
  }) =>
      getFunction("transform").call(
        <Object?>[
          root,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform_intermediate_node
  ///
  /// ### python docstring
  ///
  /// Transform an intermediate node.
  ///
  /// ### python source
  /// ```py
  /// def transform_intermediate_node(self, node, data):
  ///         if id(node) not in self._successful_visits:
  ///             return Discard
  ///         r = self._check_cycle(node)
  ///         if r is Discard:
  ///             return r
  ///         self._successful_visits.remove(id(node))
  ///         if len(data) > 1:
  ///             children = [self.tree_class('_inter', c) for c in data]
  ///             return self.tree_class('_iambig', children)
  ///         return data[0]
  /// ```
  Object? transform_intermediate_node({
    required Object? node,
    required Object? data,
  }) =>
      getFunction("transform_intermediate_node").call(
        <Object?>[
          node,
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform_packed_node
  ///
  /// ### python docstring
  ///
  /// Transform a packed node.
  ///
  /// ### python source
  /// ```py
  /// def transform_packed_node(self, node, data):
  ///         r = self._check_cycle(node)
  ///         if r is Discard:
  ///             return r
  ///         if self.resolve_ambiguity and id(node.parent) in self._successful_visits:
  ///             return Discard
  ///         if self._use_cache and id(node) in self._cache:
  ///             return self._cache[id(node)]
  ///         children = []
  ///         assert len(data) <= 2
  ///         data = PackedData(node, data)
  ///         if data.left is not PackedData.NO_DATA:
  ///             if node.left.is_intermediate and isinstance(data.left, list):
  ///                 children += data.left
  ///             else:
  ///                 children.append(data.left)
  ///         if data.right is not PackedData.NO_DATA:
  ///             children.append(data.right)
  ///         if node.parent.is_intermediate:
  ///             return self._cache.setdefault(id(node), children)
  ///         return self._cache.setdefault(id(node), self._call_rule_func(node, children))
  /// ```
  Object? transform_packed_node({
    required Object? node,
    required Object? data,
  }) =>
      getFunction("transform_packed_node").call(
        <Object?>[
          node,
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform_symbol_node
  ///
  /// ### python docstring
  ///
  /// Transform a symbol node.
  ///
  /// ### python source
  /// ```py
  /// def transform_symbol_node(self, node, data):
  ///         if id(node) not in self._successful_visits:
  ///             return Discard
  ///         r = self._check_cycle(node)
  ///         if r is Discard:
  ///             return r
  ///         self._successful_visits.remove(id(node))
  ///         data = self._collapse_ambig(data)
  ///         return self._call_ambig_func(node, data)
  /// ```
  Object? transform_symbol_node({
    required Object? node,
    required Object? data,
  }) =>
      getFunction("transform_symbol_node").call(
        <Object?>[
          node,
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## transform_token_node
  ///
  /// ### python docstring
  ///
  /// Transform a ``Token``.
  ///
  /// ### python source
  /// ```py
  /// def transform_token_node(self, node):
  ///         return getattr(self, node.type, self.__default_token__)(node)
  /// ```
  Object? transform_token_node({
    required Object? node,
  }) =>
      getFunction("transform_token_node").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit
  ///
  /// ### python source
  /// ```py
  /// def visit(self, root):
  ///         if self.prioritizer:
  ///             self.prioritizer.visit(root)
  ///         super(ForestToParseTree, self).visit(root)
  ///         self._cache = {}
  /// ```
  Object? visit({
    required Object? root,
  }) =>
      getFunction("visit").call(
        <Object?>[
          root,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_intermediate_node_out
  ///
  /// ### python source
  /// ```py
  /// def visit_intermediate_node_out(self, node):
  ///         self._visit_node_out_helper(node, self.transform_intermediate_node)
  /// ```
  Object? visit_intermediate_node_out({
    required Object? node,
  }) =>
      getFunction("visit_intermediate_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_packed_node_in
  ///
  /// ### python docstring
  ///
  /// Called when a packed node is visited. Nodes that are returned
  /// will be scheduled to be visited.
  ///
  /// ### python source
  /// ```py
  /// def visit_packed_node_in(self, node):
  ///         self._on_cycle_retreat = False
  ///         to_visit = super(ForestToParseTree, self).visit_packed_node_in(node)
  ///         if not self.resolve_ambiguity or id(node.parent) not in self._successful_visits:
  ///             if not self._use_cache or id(node) not in self._cache:
  ///                 return to_visit
  /// ```
  Object? visit_packed_node_in({
    required Object? node,
  }) =>
      getFunction("visit_packed_node_in").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_packed_node_out
  ///
  /// ### python docstring
  ///
  /// Called after all nodes returned from a corresponding ``visit_packed_node_in``
  /// call have been visited.
  ///
  /// ### python source
  /// ```py
  /// def visit_packed_node_out(self, node):
  ///         super(ForestToParseTree, self).visit_packed_node_out(node)
  ///         if not self._on_cycle_retreat:
  ///             self._successful_visits.add(id(node.parent))
  /// ```
  Object? visit_packed_node_out({
    required Object? node,
  }) =>
      getFunction("visit_packed_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_symbol_node_in
  ///
  /// ### python docstring
  ///
  /// Called when a symbol node is visited. Nodes that are returned
  /// will be scheduled to be visited. If ``visit_intermediate_node_in``
  /// is not implemented, this function will be called for intermediate
  /// nodes as well.
  ///
  /// ### python source
  /// ```py
  /// def visit_symbol_node_in(self, node):
  ///         super(ForestToParseTree, self).visit_symbol_node_in(node)
  ///         if self._on_cycle_retreat:
  ///             return
  ///         return node.children
  /// ```
  Object? visit_symbol_node_in({
    required Object? node,
  }) =>
      getFunction("visit_symbol_node_in").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_symbol_node_out
  ///
  /// ### python docstring
  ///
  /// Called after all nodes returned from a corresponding ``visit_symbol_node_in``
  /// call have been visited. If ``visit_intermediate_node_out``
  /// is not implemented, this function will be called for intermediate
  /// nodes as well.
  ///
  /// ### python source
  /// ```py
  /// def visit_symbol_node_out(self, node):
  ///         self._visit_node_out_helper(node, self.transform_symbol_node)
  /// ```
  Object? visit_symbol_node_out({
    required Object? node,
  }) =>
      getFunction("visit_symbol_node_out").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## visit_token_node
  ///
  /// ### python docstring
  ///
  /// Called when a ``Token`` is visited. ``Token`` nodes are always leaves.
  ///
  /// ### python source
  /// ```py
  /// def visit_token_node(self, node):
  ///         transformed = self.transform_token_node(node)
  ///         if transformed is not Discard:
  ///             self.data[self.node_stack[-1]].append(transformed)
  /// ```
  Object? visit_token_node({
    required Object? node,
  }) =>
      getFunction("visit_token_node").call(
        <Object?>[
          node,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## earley_forest
///
/// ### python docstring
///
/// "This module implements an SPPF implementation
///
/// This is used as the primary output mechanism for the Earley parser
/// in order to store complex ambiguities.
///
/// Full reference and more details is here:
/// https://web.archive.org/web/20190616123959/http://www.bramvandersanden.com/post/2014/06/shared-packed-parse-forest/
///
/// ### python source
/// ```py
/// """"This module implements an SPPF implementation
///
/// This is used as the primary output mechanism for the Earley parser
/// in order to store complex ambiguities.
///
/// Full reference and more details is here:
/// https://web.archive.org/web/20190616123959/http://www.bramvandersanden.com/post/2014/06/shared-packed-parse-forest/
/// """
///
/// from random import randint
/// from collections import deque
/// from operator import attrgetter
/// from importlib import import_module
/// from functools import partial
///
/// from ..parse_tree_builder import AmbiguousIntermediateExpander
/// from ..visitors import Discard
/// from ..utils import logger
/// from ..tree import Tree
///
/// class ForestNode:
///     pass
///
/// class SymbolNode(ForestNode):
///     """
///     A Symbol Node represents a symbol (or Intermediate LR0).
///
///     Symbol nodes are keyed by the symbol (s). For intermediate nodes
///     s will be an LR0, stored as a tuple of (rule, ptr). For completed symbol
///     nodes, s will be a string representing the non-terminal origin (i.e.
///     the left hand side of the rule).
///
///     The children of a Symbol or Intermediate Node will always be Packed Nodes;
///     with each Packed Node child representing a single derivation of a production.
///
///     Hence a Symbol Node with a single child is unambiguous.
///
///     Parameters:
///         s: A Symbol, or a tuple of (rule, ptr) for an intermediate node.
///         start: The index of the start of the substring matched by this symbol (inclusive).
///         end: The index of the end of the substring matched by this symbol (exclusive).
///
///     Properties:
///         is_intermediate: True if this node is an intermediate node.
///         priority: The priority of the node's symbol.
///     """
///     __slots__ = ('s', 'start', 'end', '_children', 'paths', 'paths_loaded', 'priority', 'is_intermediate', '_hash')
///     def __init__(self, s, start, end):
///         self.s = s
///         self.start = start
///         self.end = end
///         self._children = set()
///         self.paths = set()
///         self.paths_loaded = False
///
///         ### We use inf here as it can be safely negated without resorting to conditionals,
///         #   unlike None or float('NaN'), and sorts appropriately.
///         self.priority = float('-inf')
///         self.is_intermediate = isinstance(s, tuple)
///         self._hash = hash((self.s, self.start, self.end))
///
///     def add_family(self, lr0, rule, start, left, right):
///         self._children.add(PackedNode(self, lr0, rule, start, left, right))
///
///     def add_path(self, transitive, node):
///         self.paths.add((transitive, node))
///
///     def load_paths(self):
///         for transitive, node in self.paths:
///             if transitive.next_titem is not None:
///                 vn = SymbolNode(transitive.next_titem.s, transitive.next_titem.start, self.end)
///                 vn.add_path(transitive.next_titem, node)
///                 self.add_family(transitive.reduction.rule.origin, transitive.reduction.rule, transitive.reduction.start, transitive.reduction.node, vn)
///             else:
///                 self.add_family(transitive.reduction.rule.origin, transitive.reduction.rule, transitive.reduction.start, transitive.reduction.node, node)
///         self.paths_loaded = True
///
///     @property
///     def is_ambiguous(self):
///         """Returns True if this node is ambiguous."""
///         return len(self.children) > 1
///
///     @property
///     def children(self):
///         """Returns a list of this node's children sorted from greatest to
///         least priority."""
///         if not self.paths_loaded:
///             self.load_paths()
///         return sorted(self._children, key=attrgetter('sort_key'))
///
///     def __iter__(self):
///         return iter(self._children)
///
///     def __eq__(self, other):
///         if not isinstance(other, SymbolNode):
///             return False
///         return self is other or (type(self.s) == type(other.s) and self.s == other.s and self.start == other.start and self.end is other.end)
///
///     def __hash__(self):
///         return self._hash
///
///     def __repr__(self):
///         if self.is_intermediate:
///             rule = self.s[0]
///             ptr = self.s[1]
///             before = ( expansion.name for expansion in rule.expansion[:ptr] )
///             after = ( expansion.name for expansion in rule.expansion[ptr:] )
///             symbol = "{} ::= {}* {}".format(rule.origin.name, ' '.join(before), ' '.join(after))
///         else:
///             symbol = self.s.name
///         return "({}, {}, {}, {})".format(symbol, self.start, self.end, self.priority)
///
/// class PackedNode(ForestNode):
///     """
///     A Packed Node represents a single derivation in a symbol node.
///
///     Parameters:
///         rule: The rule associated with this node.
///         parent: The parent of this node.
///         left: The left child of this node. ``None`` if one does not exist.
///         right: The right child of this node. ``None`` if one does not exist.
///         priority: The priority of this node.
///     """
///     __slots__ = ('parent', 's', 'rule', 'start', 'left', 'right', 'priority', '_hash')
///     def __init__(self, parent, s, rule, start, left, right):
///         self.parent = parent
///         self.s = s
///         self.start = start
///         self.rule = rule
///         self.left = left
///         self.right = right
///         self.priority = float('-inf')
///         self._hash = hash((self.left, self.right))
///
///     @property
///     def is_empty(self):
///         return self.left is None and self.right is None
///
///     @property
///     def sort_key(self):
///         """
///         Used to sort PackedNode children of SymbolNodes.
///         A SymbolNode has multiple PackedNodes if it matched
///         ambiguously. Hence, we use the sort order to identify
///         the order in which ambiguous children should be considered.
///         """
///         return self.is_empty, -self.priority, self.rule.order
///
///     @property
///     def children(self):
///         """Returns a list of this node's children."""
///         return [x for x in [self.left, self.right] if x is not None]
///
///     def __iter__(self):
///         yield self.left
///         yield self.right
///
///     def __eq__(self, other):
///         if not isinstance(other, PackedNode):
///             return False
///         return self is other or (self.left == other.left and self.right == other.right)
///
///     def __hash__(self):
///         return self._hash
///
///     def __repr__(self):
///         if isinstance(self.s, tuple):
///             rule = self.s[0]
///             ptr = self.s[1]
///             before = ( expansion.name for expansion in rule.expansion[:ptr] )
///             after = ( expansion.name for expansion in rule.expansion[ptr:] )
///             symbol = "{} ::= {}* {}".format(rule.origin.name, ' '.join(before), ' '.join(after))
///         else:
///             symbol = self.s.name
///         return "({}, {}, {}, {})".format(symbol, self.start, self.priority, self.rule.order)
///
/// class TokenNode(ForestNode):
///     """
///     A Token Node represents a matched terminal and is always a leaf node.
///
///     Parameters:
///         token: The Token associated with this node.
///         term: The TerminalDef matched by the token.
///         priority: The priority of this node.
///     """
///     __slots__ = ('token', 'term', 'priority', '_hash')
///     def __init__(self, token, term, priority=None):
///         self.token = token
///         self.term = term
///         if priority is not None:
///             self.priority = priority
///         else:
///             self.priority = term.priority if term is not None else 0
///         self._hash = hash(token)
///
///     def __eq__(self, other):
///         if not isinstance(other, TokenNode):
///             return False
///         return self is other or (self.token == other.token)
///
///     def __hash__(self):
///         return self._hash
///
///     def __repr__(self):
///         return repr(self.token)
///
/// class ForestVisitor:
///     """
///     An abstract base class for building forest visitors.
///
///     This class performs a controllable depth-first walk of an SPPF.
///     The visitor will not enter cycles and will backtrack if one is encountered.
///     Subclasses are notified of cycles through the ``on_cycle`` method.
///
///     Behavior for visit events is defined by overriding the
///     ``visit*node*`` functions.
///
///     The walk is controlled by the return values of the ``visit*node_in``
///     methods. Returning a node(s) will schedule them to be visited. The visitor
///     will begin to backtrack if no nodes are returned.
///
///     Parameters:
///         single_visit: If ``True``, non-Token nodes will only be visited once.
///     """
///
///     def __init__(self, single_visit=False):
///         self.single_visit = single_visit
///
///     def visit_token_node(self, node):
///         """Called when a ``Token`` is visited. ``Token`` nodes are always leaves."""
///         pass
///
///     def visit_symbol_node_in(self, node):
///         """Called when a symbol node is visited. Nodes that are returned
///         will be scheduled to be visited. If ``visit_intermediate_node_in``
///         is not implemented, this function will be called for intermediate
///         nodes as well."""
///         pass
///
///     def visit_symbol_node_out(self, node):
///         """Called after all nodes returned from a corresponding ``visit_symbol_node_in``
///         call have been visited. If ``visit_intermediate_node_out``
///         is not implemented, this function will be called for intermediate
///         nodes as well."""
///         pass
///
///     def visit_packed_node_in(self, node):
///         """Called when a packed node is visited. Nodes that are returned
///         will be scheduled to be visited. """
///         pass
///
///     def visit_packed_node_out(self, node):
///         """Called after all nodes returned from a corresponding ``visit_packed_node_in``
///         call have been visited."""
///         pass
///
///     def on_cycle(self, node, path):
///         """Called when a cycle is encountered.
///
///         Parameters:
///             node: The node that causes a cycle.
///             path: The list of nodes being visited: nodes that have been
///                 entered but not exited. The first element is the root in a forest
///                 visit, and the last element is the node visited most recently.
///                 ``path`` should be treated as read-only.
///         """
///         pass
///
///     def get_cycle_in_path(self, node, path):
///         """A utility function for use in ``on_cycle`` to obtain a slice of
///         ``path`` that only contains the nodes that make up the cycle."""
///         index = len(path) - 1
///         while id(path[index]) != id(node):
///             index -= 1
///         return path[index:]
///
///     def visit(self, root):
///         # Visiting is a list of IDs of all symbol/intermediate nodes currently in
///         # the stack. It serves two purposes: to detect when we 'recurse' in and out
///         # of a symbol/intermediate so that we can process both up and down. Also,
///         # since the SPPF can have cycles it allows us to detect if we're trying
///         # to recurse into a node that's already on the stack (infinite recursion).
///         visiting = set()
///
///         # set of all nodes that have been visited
///         visited = set()
///
///         # a list of nodes that are currently being visited
///         # used for the `on_cycle` callback
///         path = []
///
///         # We do not use recursion here to walk the Forest due to the limited
///         # stack size in python. Therefore input_stack is essentially our stack.
///         input_stack = deque([root])
///
///         # It is much faster to cache these as locals since they are called
///         # many times in large parses.
///         vpno = getattr(self, 'visit_packed_node_out')
///         vpni = getattr(self, 'visit_packed_node_in')
///         vsno = getattr(self, 'visit_symbol_node_out')
///         vsni = getattr(self, 'visit_symbol_node_in')
///         vino = getattr(self, 'visit_intermediate_node_out', vsno)
///         vini = getattr(self, 'visit_intermediate_node_in', vsni)
///         vtn = getattr(self, 'visit_token_node')
///         oc = getattr(self, 'on_cycle')
///
///         while input_stack:
///             current = next(reversed(input_stack))
///             try:
///                 next_node = next(current)
///             except StopIteration:
///                 input_stack.pop()
///                 continue
///             except TypeError:
///                 ### If the current object is not an iterator, pass through to Token/SymbolNode
///                 pass
///             else:
///                 if next_node is None:
///                     continue
///
///                 if id(next_node) in visiting:
///                     oc(next_node, path)
///                     continue
///
///                 input_stack.append(next_node)
///                 continue
///
///             if isinstance(current, TokenNode):
///                 vtn(current.token)
///                 input_stack.pop()
///                 continue
///
///             current_id = id(current)
///             if current_id in visiting:
///                 if isinstance(current, PackedNode):
///                     vpno(current)
///                 elif current.is_intermediate:
///                     vino(current)
///                 else:
///                     vsno(current)
///                 input_stack.pop()
///                 path.pop()
///                 visiting.remove(current_id)
///                 visited.add(current_id)
///             elif self.single_visit and current_id in visited:
///                 input_stack.pop()
///             else:
///                 visiting.add(current_id)
///                 path.append(current)
///                 if isinstance(current, PackedNode):
///                     next_node = vpni(current)
///                 elif current.is_intermediate:
///                     next_node = vini(current)
///                 else:
///                     next_node = vsni(current)
///                 if next_node is None:
///                     continue
///
///                 if not isinstance(next_node, ForestNode):
///                     next_node = iter(next_node)
///                 elif id(next_node) in visiting:
///                     oc(next_node, path)
///                     continue
///
///                 input_stack.append(next_node)
///
/// class ForestTransformer(ForestVisitor):
///     """The base class for a bottom-up forest transformation. Most users will
///     want to use ``TreeForestTransformer`` instead as it has a friendlier
///     interface and covers most use cases.
///
///     Transformations are applied via inheritance and overriding of the
///     ``transform*node`` methods.
///
///     ``transform_token_node`` receives a ``Token`` as an argument.
///     All other methods receive the node that is being transformed and
///     a list of the results of the transformations of that node's children.
///     The return value of these methods are the resulting transformations.
///
///     If ``Discard`` is raised in a node's transformation, no data from that node
///     will be passed to its parent's transformation.
///     """
///
///     def __init__(self):
///         super(ForestTransformer, self).__init__()
///         # results of transformations
///         self.data = dict()
///         # used to track parent nodes
///         self.node_stack = deque()
///
///     def transform(self, root):
///         """Perform a transformation on an SPPF."""
///         self.node_stack.append('result')
///         self.data['result'] = []
///         self.visit(root)
///         assert len(self.data['result']) <= 1
///         if self.data['result']:
///             return self.data['result'][0]
///
///     def transform_symbol_node(self, node, data):
///         """Transform a symbol node."""
///         return node
///
///     def transform_intermediate_node(self, node, data):
///         """Transform an intermediate node."""
///         return node
///
///     def transform_packed_node(self, node, data):
///         """Transform a packed node."""
///         return node
///
///     def transform_token_node(self, node):
///         """Transform a ``Token``."""
///         return node
///
///     def visit_symbol_node_in(self, node):
///         self.node_stack.append(id(node))
///         self.data[id(node)] = []
///         return node.children
///
///     def visit_packed_node_in(self, node):
///         self.node_stack.append(id(node))
///         self.data[id(node)] = []
///         return node.children
///
///     def visit_token_node(self, node):
///         transformed = self.transform_token_node(node)
///         if transformed is not Discard:
///             self.data[self.node_stack[-1]].append(transformed)
///
///     def _visit_node_out_helper(self, node, method):
///         self.node_stack.pop()
///         transformed = method(node, self.data[id(node)])
///         if transformed is not Discard:
///             self.data[self.node_stack[-1]].append(transformed)
///         del self.data[id(node)]
///
///     def visit_symbol_node_out(self, node):
///         self._visit_node_out_helper(node, self.transform_symbol_node)
///
///     def visit_intermediate_node_out(self, node):
///         self._visit_node_out_helper(node, self.transform_intermediate_node)
///
///     def visit_packed_node_out(self, node):
///         self._visit_node_out_helper(node, self.transform_packed_node)
///
///
/// class ForestSumVisitor(ForestVisitor):
///     """
///     A visitor for prioritizing ambiguous parts of the Forest.
///
///     This visitor is used when support for explicit priorities on
///     rules is requested (whether normal, or invert). It walks the
///     forest (or subsets thereof) and cascades properties upwards
///     from the leaves.
///
///     It would be ideal to do this during parsing, however this would
///     require processing each Earley item multiple times. That's
///     a big performance drawback; so running a forest walk is the
///     lesser of two evils: there can be significantly more Earley
///     items created during parsing than there are SPPF nodes in the
///     final tree.
///     """
///     def __init__(self):
///         super(ForestSumVisitor, self).__init__(single_visit=True)
///
///     def visit_packed_node_in(self, node):
///         yield node.left
///         yield node.right
///
///     def visit_symbol_node_in(self, node):
///         return iter(node.children)
///
///     def visit_packed_node_out(self, node):
///         priority = node.rule.options.priority if not node.parent.is_intermediate and node.rule.options.priority else 0
///         priority += getattr(node.right, 'priority', 0)
///         priority += getattr(node.left, 'priority', 0)
///         node.priority = priority
///
///     def visit_symbol_node_out(self, node):
///         node.priority = max(child.priority for child in node.children)
///
/// class PackedData():
///     """Used in transformationss of packed nodes to distinguish the data
///     that comes from the left child and the right child.
///     """
///
///     class _NoData():
///         pass
///
///     NO_DATA = _NoData()
///
///     def __init__(self, node, data):
///         self.left = self.NO_DATA
///         self.right = self.NO_DATA
///         if data:
///             if node.left is not None:
///                 self.left = data[0]
///                 if len(data) > 1:
///                     self.right = data[1]
///             else:
///                 self.right = data[0]
///
/// class ForestToParseTree(ForestTransformer):
///     """Used by the earley parser when ambiguity equals 'resolve' or
///     'explicit'. Transforms an SPPF into an (ambiguous) parse tree.
///
///     Parameters:
///         tree_class: The tree class to use for construction
///         callbacks: A dictionary of rules to functions that output a tree
///         prioritizer: A ``ForestVisitor`` that manipulates the priorities of ForestNodes
///         resolve_ambiguity: If True, ambiguities will be resolved based on
///                         priorities. Otherwise, `_ambig` nodes will be in the resulting tree.
///         use_cache: If True, the results of packed node transformations will be cached.
///     """
///
///     def __init__(self, tree_class=Tree, callbacks=dict(), prioritizer=ForestSumVisitor(), resolve_ambiguity=True, use_cache=True):
///         super(ForestToParseTree, self).__init__()
///         self.tree_class = tree_class
///         self.callbacks = callbacks
///         self.prioritizer = prioritizer
///         self.resolve_ambiguity = resolve_ambiguity
///         self._use_cache = use_cache
///         self._cache = {}
///         self._on_cycle_retreat = False
///         self._cycle_node = None
///         self._successful_visits = set()
///
///     def visit(self, root):
///         if self.prioritizer:
///             self.prioritizer.visit(root)
///         super(ForestToParseTree, self).visit(root)
///         self._cache = {}
///
///     def on_cycle(self, node, path):
///         logger.debug("Cycle encountered in the SPPF at node: %s. "
///                 "As infinite ambiguities cannot be represented in a tree, "
///                 "this family of derivations will be discarded.", node)
///         self._cycle_node = node
///         self._on_cycle_retreat = True
///
///     def _check_cycle(self, node):
///         if self._on_cycle_retreat:
///             if id(node) == id(self._cycle_node) or id(node) in self._successful_visits:
///                 self._cycle_node = None
///                 self._on_cycle_retreat = False
///             else:
///                 return Discard
///
///     def _collapse_ambig(self, children):
///         new_children = []
///         for child in children:
///             if hasattr(child, 'data') and child.data == '_ambig':
///                 new_children += child.children
///             else:
///                 new_children.append(child)
///         return new_children
///
///     def _call_rule_func(self, node, data):
///         # called when transforming children of symbol nodes
///         # data is a list of trees or tokens that correspond to the
///         # symbol's rule expansion
///         return self.callbacks[node.rule](data)
///
///     def _call_ambig_func(self, node, data):
///         # called when transforming a symbol node
///         # data is a list of trees where each tree's data is
///         # equal to the name of the symbol or one of its aliases.
///         if len(data) > 1:
///             return self.tree_class('_ambig', data)
///         elif data:
///             return data[0]
///         return Discard
///
///     def transform_symbol_node(self, node, data):
///         if id(node) not in self._successful_visits:
///             return Discard
///         r = self._check_cycle(node)
///         if r is Discard:
///             return r
///         self._successful_visits.remove(id(node))
///         data = self._collapse_ambig(data)
///         return self._call_ambig_func(node, data)
///
///     def transform_intermediate_node(self, node, data):
///         if id(node) not in self._successful_visits:
///             return Discard
///         r = self._check_cycle(node)
///         if r is Discard:
///             return r
///         self._successful_visits.remove(id(node))
///         if len(data) > 1:
///             children = [self.tree_class('_inter', c) for c in data]
///             return self.tree_class('_iambig', children)
///         return data[0]
///
///     def transform_packed_node(self, node, data):
///         r = self._check_cycle(node)
///         if r is Discard:
///             return r
///         if self.resolve_ambiguity and id(node.parent) in self._successful_visits:
///             return Discard
///         if self._use_cache and id(node) in self._cache:
///             return self._cache[id(node)]
///         children = []
///         assert len(data) <= 2
///         data = PackedData(node, data)
///         if data.left is not PackedData.NO_DATA:
///             if node.left.is_intermediate and isinstance(data.left, list):
///                 children += data.left
///             else:
///                 children.append(data.left)
///         if data.right is not PackedData.NO_DATA:
///             children.append(data.right)
///         if node.parent.is_intermediate:
///             return self._cache.setdefault(id(node), children)
///         return self._cache.setdefault(id(node), self._call_rule_func(node, children))
///
///     def visit_symbol_node_in(self, node):
///         super(ForestToParseTree, self).visit_symbol_node_in(node)
///         if self._on_cycle_retreat:
///             return
///         return node.children
///
///     def visit_packed_node_in(self, node):
///         self._on_cycle_retreat = False
///         to_visit = super(ForestToParseTree, self).visit_packed_node_in(node)
///         if not self.resolve_ambiguity or id(node.parent) not in self._successful_visits:
///             if not self._use_cache or id(node) not in self._cache:
///                 return to_visit
///
///     def visit_packed_node_out(self, node):
///         super(ForestToParseTree, self).visit_packed_node_out(node)
///         if not self._on_cycle_retreat:
///             self._successful_visits.add(id(node.parent))
///
/// def handles_ambiguity(func):
///     """Decorator for methods of subclasses of ``TreeForestTransformer``.
///     Denotes that the method should receive a list of transformed derivations."""
///     func.handles_ambiguity = True
///     return func
///
/// class TreeForestTransformer(ForestToParseTree):
///     """A ``ForestTransformer`` with a tree ``Transformer``-like interface.
///     By default, it will construct a tree.
///
///     Methods provided via inheritance are called based on the rule/symbol
///     names of nodes in the forest.
///
///     Methods that act on rules will receive a list of the results of the
///     transformations of the rule's children. By default, trees and tokens.
///
///     Methods that act on tokens will receive a token.
///
///     Alternatively, methods that act on rules may be annotated with
///     ``handles_ambiguity``. In this case, the function will receive a list
///     of all the transformations of all the derivations of the rule.
///     By default, a list of trees where each tree.data is equal to the
///     rule name or one of its aliases.
///
///     Non-tree transformations are made possible by override of
///     ``__default__``, ``__default_token__``, and ``__default_ambig__``.
///
///     Note:
///         Tree shaping features such as inlined rules and token filtering are
///         not built into the transformation. Positions are also not propagated.
///
///     Parameters:
///         tree_class: The tree class to use for construction
///         prioritizer: A ``ForestVisitor`` that manipulates the priorities of nodes in the SPPF.
///         resolve_ambiguity: If True, ambiguities will be resolved based on priorities.
///         use_cache (bool): If True, caches the results of some transformations,
///                           potentially improving performance when ``resolve_ambiguity==False``.
///                           Only use if you know what you are doing: i.e. All transformation
///                           functions are pure and referentially transparent.
///     """
///
///     def __init__(self, tree_class=Tree, prioritizer=ForestSumVisitor(), resolve_ambiguity=True, use_cache=False):
///         super(TreeForestTransformer, self).__init__(tree_class, dict(), prioritizer, resolve_ambiguity, use_cache)
///
///     def __default__(self, name, data):
///         """Default operation on tree (for override).
///
///         Returns a tree with name with data as children.
///         """
///         return self.tree_class(name, data)
///
///     def __default_ambig__(self, name, data):
///         """Default operation on ambiguous rule (for override).
///
///         Wraps data in an '_ambig_' node if it contains more than
///         one element.
///         """
///         if len(data) > 1:
///             return self.tree_class('_ambig', data)
///         elif data:
///             return data[0]
///         return Discard
///
///     def __default_token__(self, node):
///         """Default operation on ``Token`` (for override).
///
///         Returns ``node``.
///         """
///         return node
///
///     def transform_token_node(self, node):
///         return getattr(self, node.type, self.__default_token__)(node)
///
///     def _call_rule_func(self, node, data):
///         name = node.rule.alias or node.rule.options.template_source or node.rule.origin.name
///         user_func = getattr(self, name, self.__default__)
///         if user_func == self.__default__ or hasattr(user_func, 'handles_ambiguity'):
///             user_func = partial(self.__default__, name)
///         if not self.resolve_ambiguity:
///             wrapper = partial(AmbiguousIntermediateExpander, self.tree_class)
///             user_func = wrapper(user_func)
///         return user_func(data)
///
///     def _call_ambig_func(self, node, data):
///         name = node.s.name
///         user_func = getattr(self, name, self.__default_ambig__)
///         if user_func == self.__default_ambig__ or not hasattr(user_func, 'handles_ambiguity'):
///             user_func = partial(self.__default_ambig__, name)
///         return user_func(data)
///
/// class ForestToPyDotVisitor(ForestVisitor):
///     """
///     A Forest visitor which writes the SPPF to a PNG.
///
///     The SPPF can get really large, really quickly because
///     of the amount of meta-data it stores, so this is probably
///     only useful for trivial trees and learning how the SPPF
///     is structured.
///     """
///     def __init__(self, rankdir="TB"):
///         super(ForestToPyDotVisitor, self).__init__(single_visit=True)
///         self.pydot = import_module('pydot')
///         self.graph = self.pydot.Dot(graph_type='digraph', rankdir=rankdir)
///
///     def visit(self, root, filename):
///         super(ForestToPyDotVisitor, self).visit(root)
///         try:
///             self.graph.write_png(filename)
///         except FileNotFoundError as e:
///             logger.error("Could not write png: ", e)
///
///     def visit_token_node(self, node):
///         graph_node_id = str(id(node))
///         graph_node_label = "\"{}\"".format(node.value.replace('"', '\\"'))
///         graph_node_color = 0x808080
///         graph_node_style = "\"filled,rounded\""
///         graph_node_shape = "diamond"
///         graph_node = self.pydot.Node(graph_node_id, style=graph_node_style, fillcolor="#{:06x}".format(graph_node_color), shape=graph_node_shape, label=graph_node_label)
///         self.graph.add_node(graph_node)
///
///     def visit_packed_node_in(self, node):
///         graph_node_id = str(id(node))
///         graph_node_label = repr(node)
///         graph_node_color = 0x808080
///         graph_node_style = "filled"
///         graph_node_shape = "diamond"
///         graph_node = self.pydot.Node(graph_node_id, style=graph_node_style, fillcolor="#{:06x}".format(graph_node_color), shape=graph_node_shape, label=graph_node_label)
///         self.graph.add_node(graph_node)
///         yield node.left
///         yield node.right
///
///     def visit_packed_node_out(self, node):
///         graph_node_id = str(id(node))
///         graph_node = self.graph.get_node(graph_node_id)[0]
///         for child in [node.left, node.right]:
///             if child is not None:
///                 child_graph_node_id = str(id(child.token if isinstance(child, TokenNode) else child))
///                 child_graph_node = self.graph.get_node(child_graph_node_id)[0]
///                 self.graph.add_edge(self.pydot.Edge(graph_node, child_graph_node))
///             else:
///                 #### Try and be above the Python object ID range; probably impl. specific, but maybe this is okay.
///                 child_graph_node_id = str(randint(100000000000000000000000000000,123456789012345678901234567890))
///                 child_graph_node_style = "invis"
///                 child_graph_node = self.pydot.Node(child_graph_node_id, style=child_graph_node_style, label="None")
///                 child_edge_style = "invis"
///                 self.graph.add_node(child_graph_node)
///                 self.graph.add_edge(self.pydot.Edge(graph_node, child_graph_node, style=child_edge_style))
///
///     def visit_symbol_node_in(self, node):
///         graph_node_id = str(id(node))
///         graph_node_label = repr(node)
///         graph_node_color = 0x808080
///         graph_node_style = "\"filled\""
///         if node.is_intermediate:
///             graph_node_shape = "ellipse"
///         else:
///             graph_node_shape = "rectangle"
///         graph_node = self.pydot.Node(graph_node_id, style=graph_node_style, fillcolor="#{:06x}".format(graph_node_color), shape=graph_node_shape, label=graph_node_label)
///         self.graph.add_node(graph_node)
///         return iter(node.children)
///
///     def visit_symbol_node_out(self, node):
///         graph_node_id = str(id(node))
///         graph_node = self.graph.get_node(graph_node_id)[0]
///         for child in node.children:
///             child_graph_node_id = str(id(child))
///             child_graph_node = self.graph.get_node(child_graph_node_id)[0]
///             self.graph.add_edge(self.pydot.Edge(graph_node, child_graph_node))
/// ```
final class earley_forest extends PythonModule {
  earley_forest.from(super.pythonModule) : super.from();

  static earley_forest import() => PythonFfiDart.instance.importModule(
        "lark.parsers.earley_forest",
        earley_forest.from,
      );

  /// ## handles_ambiguity
  ///
  /// ### python docstring
  ///
  /// Decorator for methods of subclasses of ``TreeForestTransformer``.
  /// Denotes that the method should receive a list of transformed derivations.
  ///
  /// ### python source
  /// ```py
  /// def handles_ambiguity(func):
  ///     """Decorator for methods of subclasses of ``TreeForestTransformer``.
  ///     Denotes that the method should receive a list of transformed derivations."""
  ///     func.handles_ambiguity = True
  ///     return func
  /// ```
  Object? handles_ambiguity({
    required Object? func,
  }) =>
      getFunction("handles_ambiguity").call(
        <Object?>[
          func,
        ],
        kwargs: <String, Object?>{},
      );
}
