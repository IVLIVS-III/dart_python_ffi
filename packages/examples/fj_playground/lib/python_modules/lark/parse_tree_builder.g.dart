// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library parse_tree_builder;

import "package:python_ffi/python_ffi.dart";

/// ## AmbiguousExpander
///
/// ### python docstring
///
/// Deal with the case where we're expanding children ('_rule') into a parent but the children
/// are ambiguous. i.e. (parent->_ambig->_expand_this_rule). In this case, make the parent itself
/// ambiguous with as many copies as there are ambiguous children, and then copy the ambiguous children
/// into the right parents in the right places, essentially shifting the ambiguity up the tree.
///
/// ### python source
/// ```py
/// class AmbiguousExpander:
///     """Deal with the case where we're expanding children ('_rule') into a parent but the children
///        are ambiguous. i.e. (parent->_ambig->_expand_this_rule). In this case, make the parent itself
///        ambiguous with as many copies as there are ambiguous children, and then copy the ambiguous children
///        into the right parents in the right places, essentially shifting the ambiguity up the tree."""
///     def __init__(self, to_expand, tree_class, node_builder):
///         self.node_builder = node_builder
///         self.tree_class = tree_class
///         self.to_expand = to_expand
///
///     def __call__(self, children):
///         def _is_ambig_tree(t):
///             return hasattr(t, 'data') and t.data == '_ambig'
///
///         # -- When we're repeatedly expanding ambiguities we can end up with nested ambiguities.
///         #    All children of an _ambig node should be a derivation of that ambig node, hence
///         #    it is safe to assume that if we see an _ambig node nested within an ambig node
///         #    it is safe to simply expand it into the parent _ambig node as an alternative derivation.
///         ambiguous = []
///         for i, child in enumerate(children):
///             if _is_ambig_tree(child):
///                 if i in self.to_expand:
///                     ambiguous.append(i)
///
///                 child.expand_kids_by_data('_ambig')
///
///         if not ambiguous:
///             return self.node_builder(children)
///
///         expand = [child.children if i in ambiguous else (child,) for i, child in enumerate(children)]
///         return self.tree_class('_ambig', [self.node_builder(list(f)) for f in product(*expand)])
/// ```
final class AmbiguousExpander extends PythonClass {
  factory AmbiguousExpander({
    required Object? to_expand,
    required Object? tree_class,
    required Object? node_builder,
  }) =>
      PythonFfi.instance.importClass(
        "lark.parse_tree_builder",
        "AmbiguousExpander",
        AmbiguousExpander.from,
        <Object?>[
          to_expand,
          tree_class,
          node_builder,
        ],
        <String, Object?>{},
      );

  AmbiguousExpander.from(super.pythonClass) : super.from();

  /// ## node_builder (getter)
  ///
  /// ### python docstring
  ///
  /// Deal with the case where we're expanding children ('_rule') into a parent but the children
  /// are ambiguous. i.e. (parent->_ambig->_expand_this_rule). In this case, make the parent itself
  /// ambiguous with as many copies as there are ambiguous children, and then copy the ambiguous children
  /// into the right parents in the right places, essentially shifting the ambiguity up the tree.
  Object? get node_builder => getAttribute("node_builder");

  /// ## node_builder (setter)
  ///
  /// ### python docstring
  ///
  /// Deal with the case where we're expanding children ('_rule') into a parent but the children
  /// are ambiguous. i.e. (parent->_ambig->_expand_this_rule). In this case, make the parent itself
  /// ambiguous with as many copies as there are ambiguous children, and then copy the ambiguous children
  /// into the right parents in the right places, essentially shifting the ambiguity up the tree.
  set node_builder(Object? node_builder) =>
      setAttribute("node_builder", node_builder);

  /// ## tree_class (getter)
  ///
  /// ### python docstring
  ///
  /// Deal with the case where we're expanding children ('_rule') into a parent but the children
  /// are ambiguous. i.e. (parent->_ambig->_expand_this_rule). In this case, make the parent itself
  /// ambiguous with as many copies as there are ambiguous children, and then copy the ambiguous children
  /// into the right parents in the right places, essentially shifting the ambiguity up the tree.
  Object? get tree_class => getAttribute("tree_class");

  /// ## tree_class (setter)
  ///
  /// ### python docstring
  ///
  /// Deal with the case where we're expanding children ('_rule') into a parent but the children
  /// are ambiguous. i.e. (parent->_ambig->_expand_this_rule). In this case, make the parent itself
  /// ambiguous with as many copies as there are ambiguous children, and then copy the ambiguous children
  /// into the right parents in the right places, essentially shifting the ambiguity up the tree.
  set tree_class(Object? tree_class) => setAttribute("tree_class", tree_class);

  /// ## to_expand (getter)
  ///
  /// ### python docstring
  ///
  /// Deal with the case where we're expanding children ('_rule') into a parent but the children
  /// are ambiguous. i.e. (parent->_ambig->_expand_this_rule). In this case, make the parent itself
  /// ambiguous with as many copies as there are ambiguous children, and then copy the ambiguous children
  /// into the right parents in the right places, essentially shifting the ambiguity up the tree.
  Object? get to_expand => getAttribute("to_expand");

  /// ## to_expand (setter)
  ///
  /// ### python docstring
  ///
  /// Deal with the case where we're expanding children ('_rule') into a parent but the children
  /// are ambiguous. i.e. (parent->_ambig->_expand_this_rule). In this case, make the parent itself
  /// ambiguous with as many copies as there are ambiguous children, and then copy the ambiguous children
  /// into the right parents in the right places, essentially shifting the ambiguity up the tree.
  set to_expand(Object? to_expand) => setAttribute("to_expand", to_expand);
}

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
      PythonFfi.instance.importClass(
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

/// ## ChildFilter
///
/// ### python source
/// ```py
/// class ChildFilter:
///     def __init__(self, to_include, append_none, node_builder):
///         self.node_builder = node_builder
///         self.to_include = to_include
///         self.append_none = append_none
///
///     def __call__(self, children):
///         filtered = []
///
///         for i, to_expand, add_none in self.to_include:
///             if add_none:
///                 filtered += [None] * add_none
///             if to_expand:
///                 filtered += children[i].children
///             else:
///                 filtered.append(children[i])
///
///         if self.append_none:
///             filtered += [None] * self.append_none
///
///         return self.node_builder(filtered)
/// ```
final class ChildFilter extends PythonClass {
  factory ChildFilter({
    required Object? to_include,
    required Object? append_none,
    required Object? node_builder,
  }) =>
      PythonFfi.instance.importClass(
        "lark.parse_tree_builder",
        "ChildFilter",
        ChildFilter.from,
        <Object?>[
          to_include,
          append_none,
          node_builder,
        ],
        <String, Object?>{},
      );

  ChildFilter.from(super.pythonClass) : super.from();

  /// ## node_builder (getter)
  Object? get node_builder => getAttribute("node_builder");

  /// ## node_builder (setter)
  set node_builder(Object? node_builder) =>
      setAttribute("node_builder", node_builder);

  /// ## to_include (getter)
  Object? get to_include => getAttribute("to_include");

  /// ## to_include (setter)
  set to_include(Object? to_include) => setAttribute("to_include", to_include);

  /// ## append_none (getter)
  Object? get append_none => getAttribute("append_none");

  /// ## append_none (setter)
  set append_none(Object? append_none) =>
      setAttribute("append_none", append_none);
}

/// ## ChildFilterLALR
///
/// ### python docstring
///
/// Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)
///
/// ### python source
/// ```py
/// class ChildFilterLALR(ChildFilter):
///     """Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)"""
///
///     def __call__(self, children):
///         filtered = []
///         for i, to_expand, add_none in self.to_include:
///             if add_none:
///                 filtered += [None] * add_none
///             if to_expand:
///                 if filtered:
///                     filtered += children[i].children
///                 else:   # Optimize for left-recursion
///                     filtered = children[i].children
///             else:
///                 filtered.append(children[i])
///
///         if self.append_none:
///             filtered += [None] * self.append_none
///
///         return self.node_builder(filtered)
/// ```
final class ChildFilterLALR extends PythonClass {
  factory ChildFilterLALR({
    required Object? to_include,
    required Object? append_none,
    required Object? node_builder,
  }) =>
      PythonFfi.instance.importClass(
        "lark.parse_tree_builder",
        "ChildFilterLALR",
        ChildFilterLALR.from,
        <Object?>[
          to_include,
          append_none,
          node_builder,
        ],
        <String, Object?>{},
      );

  ChildFilterLALR.from(super.pythonClass) : super.from();

  /// ## node_builder (getter)
  ///
  /// ### python docstring
  ///
  /// Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)
  Object? get node_builder => getAttribute("node_builder");

  /// ## node_builder (setter)
  ///
  /// ### python docstring
  ///
  /// Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)
  set node_builder(Object? node_builder) =>
      setAttribute("node_builder", node_builder);

  /// ## to_include (getter)
  ///
  /// ### python docstring
  ///
  /// Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)
  Object? get to_include => getAttribute("to_include");

  /// ## to_include (setter)
  ///
  /// ### python docstring
  ///
  /// Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)
  set to_include(Object? to_include) => setAttribute("to_include", to_include);

  /// ## append_none (getter)
  ///
  /// ### python docstring
  ///
  /// Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)
  Object? get append_none => getAttribute("append_none");

  /// ## append_none (setter)
  ///
  /// ### python docstring
  ///
  /// Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)
  set append_none(Object? append_none) =>
      setAttribute("append_none", append_none);
}

/// ## ChildFilterLALR_NoPlaceholders
///
/// ### python docstring
///
/// Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)
///
/// ### python source
/// ```py
/// class ChildFilterLALR_NoPlaceholders(ChildFilter):
///     "Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)"
///     def __init__(self, to_include, node_builder):
///         self.node_builder = node_builder
///         self.to_include = to_include
///
///     def __call__(self, children):
///         filtered = []
///         for i, to_expand in self.to_include:
///             if to_expand:
///                 if filtered:
///                     filtered += children[i].children
///                 else:   # Optimize for left-recursion
///                     filtered = children[i].children
///             else:
///                 filtered.append(children[i])
///         return self.node_builder(filtered)
/// ```
final class ChildFilterLALR_NoPlaceholders extends PythonClass {
  factory ChildFilterLALR_NoPlaceholders({
    required Object? to_include,
    required Object? node_builder,
  }) =>
      PythonFfi.instance.importClass(
        "lark.parse_tree_builder",
        "ChildFilterLALR_NoPlaceholders",
        ChildFilterLALR_NoPlaceholders.from,
        <Object?>[
          to_include,
          node_builder,
        ],
        <String, Object?>{},
      );

  ChildFilterLALR_NoPlaceholders.from(super.pythonClass) : super.from();

  /// ## node_builder (getter)
  ///
  /// ### python docstring
  ///
  /// Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)
  Object? get node_builder => getAttribute("node_builder");

  /// ## node_builder (setter)
  ///
  /// ### python docstring
  ///
  /// Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)
  set node_builder(Object? node_builder) =>
      setAttribute("node_builder", node_builder);

  /// ## to_include (getter)
  ///
  /// ### python docstring
  ///
  /// Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)
  Object? get to_include => getAttribute("to_include");

  /// ## to_include (setter)
  ///
  /// ### python docstring
  ///
  /// Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)
  set to_include(Object? to_include) => setAttribute("to_include", to_include);
}

/// ## ConfigurationError
///
/// ### python source
/// ```py
/// class ConfigurationError(LarkError, ValueError):
///     pass
/// ```
final class ConfigurationError extends PythonClass {
  factory ConfigurationError() => PythonFfi.instance.importClass(
        "lark.parse_tree_builder",
        "ConfigurationError",
        ConfigurationError.from,
        <Object?>[],
      );

  ConfigurationError.from(super.pythonClass) : super.from();

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

/// ## ExpandSingleChild
///
/// ### python source
/// ```py
/// class ExpandSingleChild:
///     def __init__(self, node_builder):
///         self.node_builder = node_builder
///
///     def __call__(self, children):
///         if len(children) == 1:
///             return children[0]
///         else:
///             return self.node_builder(children)
/// ```
final class ExpandSingleChild extends PythonClass {
  factory ExpandSingleChild({
    required Object? node_builder,
  }) =>
      PythonFfi.instance.importClass(
        "lark.parse_tree_builder",
        "ExpandSingleChild",
        ExpandSingleChild.from,
        <Object?>[
          node_builder,
        ],
        <String, Object?>{},
      );

  ExpandSingleChild.from(super.pythonClass) : super.from();

  /// ## node_builder (getter)
  Object? get node_builder => getAttribute("node_builder");

  /// ## node_builder (setter)
  set node_builder(Object? node_builder) =>
      setAttribute("node_builder", node_builder);
}

/// ## GrammarError
///
/// ### python source
/// ```py
/// class GrammarError(LarkError):
///     pass
/// ```
final class GrammarError extends PythonClass {
  factory GrammarError() => PythonFfi.instance.importClass(
        "lark.parse_tree_builder",
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

/// ## ParseTreeBuilder
///
/// ### python source
/// ```py
/// class ParseTreeBuilder:
///     def __init__(self, rules, tree_class, propagate_positions=False, ambiguous=False, maybe_placeholders=False):
///         self.tree_class = tree_class
///         self.propagate_positions = propagate_positions
///         self.ambiguous = ambiguous
///         self.maybe_placeholders = maybe_placeholders
///
///         self.rule_builders = list(self._init_builders(rules))
///
///     def _init_builders(self, rules):
///         propagate_positions = make_propagate_positions(self.propagate_positions)
///
///         for rule in rules:
///             options = rule.options
///             keep_all_tokens = options.keep_all_tokens
///             expand_single_child = options.expand1
///
///             wrapper_chain = list(filter(None, [
///                 (expand_single_child and not rule.alias) and ExpandSingleChild,
///                 maybe_create_child_filter(rule.expansion, keep_all_tokens, self.ambiguous, options.empty_indices if self.maybe_placeholders else None),
///                 propagate_positions,
///                 self.ambiguous and maybe_create_ambiguous_expander(self.tree_class, rule.expansion, keep_all_tokens),
///                 self.ambiguous and partial(AmbiguousIntermediateExpander, self.tree_class)
///             ]))
///
///             yield rule, wrapper_chain
///
///     def create_callback(self, transformer=None):
///         callbacks = {}
///
///         default_handler = getattr(transformer, '__default__', None)
///         if default_handler:
///             def default_callback(data, children):
///                 return default_handler(data, children, None)
///         else:
///             default_callback = self.tree_class
///
///         for rule, wrapper_chain in self.rule_builders:
///
///             user_callback_name = rule.alias or rule.options.template_source or rule.origin.name
///             try:
///                 f = getattr(transformer, user_callback_name)
///                 wrapper = getattr(f, 'visit_wrapper', None)
///                 if wrapper is not None:
///                     f = apply_visit_wrapper(f, user_callback_name, wrapper)
///                 elif isinstance(transformer, Transformer_InPlace):
///                     f = inplace_transformer(f)
///             except AttributeError:
///                 f = partial(default_callback, user_callback_name)
///
///             for w in wrapper_chain:
///                 f = w(f)
///
///             if rule in callbacks:
///                 raise GrammarError("Rule '%s' already exists" % (rule,))
///
///             callbacks[rule] = f
///
///         return callbacks
/// ```
final class ParseTreeBuilder extends PythonClass {
  factory ParseTreeBuilder({
    required Object? rules,
    required Object? tree_class,
    Object? propagate_positions = false,
    Object? ambiguous = false,
    Object? maybe_placeholders = false,
  }) =>
      PythonFfi.instance.importClass(
        "lark.parse_tree_builder",
        "ParseTreeBuilder",
        ParseTreeBuilder.from,
        <Object?>[
          rules,
          tree_class,
          propagate_positions,
          ambiguous,
          maybe_placeholders,
        ],
        <String, Object?>{},
      );

  ParseTreeBuilder.from(super.pythonClass) : super.from();

  /// ## create_callback
  ///
  /// ### python source
  /// ```py
  /// def create_callback(self, transformer=None):
  ///         callbacks = {}
  ///
  ///         default_handler = getattr(transformer, '__default__', None)
  ///         if default_handler:
  ///             def default_callback(data, children):
  ///                 return default_handler(data, children, None)
  ///         else:
  ///             default_callback = self.tree_class
  ///
  ///         for rule, wrapper_chain in self.rule_builders:
  ///
  ///             user_callback_name = rule.alias or rule.options.template_source or rule.origin.name
  ///             try:
  ///                 f = getattr(transformer, user_callback_name)
  ///                 wrapper = getattr(f, 'visit_wrapper', None)
  ///                 if wrapper is not None:
  ///                     f = apply_visit_wrapper(f, user_callback_name, wrapper)
  ///                 elif isinstance(transformer, Transformer_InPlace):
  ///                     f = inplace_transformer(f)
  ///             except AttributeError:
  ///                 f = partial(default_callback, user_callback_name)
  ///
  ///             for w in wrapper_chain:
  ///                 f = w(f)
  ///
  ///             if rule in callbacks:
  ///                 raise GrammarError("Rule '%s' already exists" % (rule,))
  ///
  ///             callbacks[rule] = f
  ///
  ///         return callbacks
  /// ```
  Object? create_callback({
    Object? transformer,
  }) =>
      getFunction("create_callback").call(
        <Object?>[
          transformer,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## tree_class (getter)
  Object? get tree_class => getAttribute("tree_class");

  /// ## tree_class (setter)
  set tree_class(Object? tree_class) => setAttribute("tree_class", tree_class);

  /// ## propagate_positions (getter)
  Object? get propagate_positions => getAttribute("propagate_positions");

  /// ## propagate_positions (setter)
  set propagate_positions(Object? propagate_positions) =>
      setAttribute("propagate_positions", propagate_positions);

  /// ## ambiguous (getter)
  Object? get ambiguous => getAttribute("ambiguous");

  /// ## ambiguous (setter)
  set ambiguous(Object? ambiguous) => setAttribute("ambiguous", ambiguous);

  /// ## maybe_placeholders (getter)
  Object? get maybe_placeholders => getAttribute("maybe_placeholders");

  /// ## maybe_placeholders (setter)
  set maybe_placeholders(Object? maybe_placeholders) =>
      setAttribute("maybe_placeholders", maybe_placeholders);

  /// ## rule_builders (getter)
  Object? get rule_builders => getAttribute("rule_builders");

  /// ## rule_builders (setter)
  set rule_builders(Object? rule_builders) =>
      setAttribute("rule_builders", rule_builders);
}

/// ## PropagatePositions
///
/// ### python source
/// ```py
/// class PropagatePositions:
///     def __init__(self, node_builder, node_filter=None):
///         self.node_builder = node_builder
///         self.node_filter = node_filter
///
///     def __call__(self, children):
///         res = self.node_builder(children)
///
///         if isinstance(res, Tree):
///             # Calculate positions while the tree is streaming, according to the rule:
///             # - nodes start at the start of their first child's container,
///             #   and end at the end of their last child's container.
///             # Containers are nodes that take up space in text, but have been inlined in the tree.
///
///             res_meta = res.meta
///
///             first_meta = self._pp_get_meta(children)
///             if first_meta is not None:
///                 if not hasattr(res_meta, 'line'):
///                     # meta was already set, probably because the rule has been inlined (e.g. `?rule`)
///                     res_meta.line = getattr(first_meta, 'container_line', first_meta.line)
///                     res_meta.column = getattr(first_meta, 'container_column', first_meta.column)
///                     res_meta.start_pos = getattr(first_meta, 'container_start_pos', first_meta.start_pos)
///                     res_meta.empty = False
///
///                 res_meta.container_line = getattr(first_meta, 'container_line', first_meta.line)
///                 res_meta.container_column = getattr(first_meta, 'container_column', first_meta.column)
///                 res_meta.container_start_pos = getattr(first_meta, 'container_start_pos', first_meta.start_pos)
///
///             last_meta = self._pp_get_meta(reversed(children))
///             if last_meta is not None:
///                 if not hasattr(res_meta, 'end_line'):
///                     res_meta.end_line = getattr(last_meta, 'container_end_line', last_meta.end_line)
///                     res_meta.end_column = getattr(last_meta, 'container_end_column', last_meta.end_column)
///                     res_meta.end_pos = getattr(last_meta, 'container_end_pos', last_meta.end_pos)
///                     res_meta.empty = False
///
///                 res_meta.container_end_line = getattr(last_meta, 'container_end_line', last_meta.end_line)
///                 res_meta.container_end_column = getattr(last_meta, 'container_end_column', last_meta.end_column)
///                 res_meta.container_end_pos = getattr(last_meta, 'container_end_pos', last_meta.end_pos)
///
///         return res
///
///     def _pp_get_meta(self, children):
///         for c in children:
///             if self.node_filter is not None and not self.node_filter(c):
///                 continue
///             if isinstance(c, Tree):
///                 if not c.meta.empty:
///                     return c.meta
///             elif isinstance(c, Token):
///                 return c
///             elif hasattr(c, '__lark_meta__'):
///                 return c.__lark_meta__()
/// ```
final class PropagatePositions extends PythonClass {
  factory PropagatePositions({
    required Object? node_builder,
    Object? node_filter,
  }) =>
      PythonFfi.instance.importClass(
        "lark.parse_tree_builder",
        "PropagatePositions",
        PropagatePositions.from,
        <Object?>[
          node_builder,
          node_filter,
        ],
        <String, Object?>{},
      );

  PropagatePositions.from(super.pythonClass) : super.from();

  /// ## node_builder (getter)
  Object? get node_builder => getAttribute("node_builder");

  /// ## node_builder (setter)
  set node_builder(Object? node_builder) =>
      setAttribute("node_builder", node_builder);

  /// ## node_filter (getter)
  Object? get node_filter => getAttribute("node_filter");

  /// ## node_filter (setter)
  set node_filter(Object? node_filter) =>
      setAttribute("node_filter", node_filter);
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
  factory Token() => PythonFfi.instance.importClass(
        "lark.parse_tree_builder",
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
      PythonFfi.instance.importClass(
        "lark.parse_tree_builder",
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
        "lark.parse_tree_builder",
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

/// ## product
final class product extends PythonClass {
  factory product() => PythonFfi.instance.importClass(
        "lark.parse_tree_builder",
        "product",
        product.from,
        <Object?>[],
      );

  product.from(super.pythonClass) : super.from();
}

/// ## parse_tree_builder
///
/// ### python source
/// ```py
/// from typing import List
///
/// from .exceptions import GrammarError, ConfigurationError
/// from .lexer import Token
/// from .tree import Tree
/// from .visitors import Transformer_InPlace
/// from .visitors import _vargs_meta, _vargs_meta_inline
///
/// ###{standalone
/// from functools import partial, wraps
/// from itertools import product
///
///
/// class ExpandSingleChild:
///     def __init__(self, node_builder):
///         self.node_builder = node_builder
///
///     def __call__(self, children):
///         if len(children) == 1:
///             return children[0]
///         else:
///             return self.node_builder(children)
///
///
///
/// class PropagatePositions:
///     def __init__(self, node_builder, node_filter=None):
///         self.node_builder = node_builder
///         self.node_filter = node_filter
///
///     def __call__(self, children):
///         res = self.node_builder(children)
///
///         if isinstance(res, Tree):
///             # Calculate positions while the tree is streaming, according to the rule:
///             # - nodes start at the start of their first child's container,
///             #   and end at the end of their last child's container.
///             # Containers are nodes that take up space in text, but have been inlined in the tree.
///
///             res_meta = res.meta
///
///             first_meta = self._pp_get_meta(children)
///             if first_meta is not None:
///                 if not hasattr(res_meta, 'line'):
///                     # meta was already set, probably because the rule has been inlined (e.g. `?rule`)
///                     res_meta.line = getattr(first_meta, 'container_line', first_meta.line)
///                     res_meta.column = getattr(first_meta, 'container_column', first_meta.column)
///                     res_meta.start_pos = getattr(first_meta, 'container_start_pos', first_meta.start_pos)
///                     res_meta.empty = False
///
///                 res_meta.container_line = getattr(first_meta, 'container_line', first_meta.line)
///                 res_meta.container_column = getattr(first_meta, 'container_column', first_meta.column)
///                 res_meta.container_start_pos = getattr(first_meta, 'container_start_pos', first_meta.start_pos)
///
///             last_meta = self._pp_get_meta(reversed(children))
///             if last_meta is not None:
///                 if not hasattr(res_meta, 'end_line'):
///                     res_meta.end_line = getattr(last_meta, 'container_end_line', last_meta.end_line)
///                     res_meta.end_column = getattr(last_meta, 'container_end_column', last_meta.end_column)
///                     res_meta.end_pos = getattr(last_meta, 'container_end_pos', last_meta.end_pos)
///                     res_meta.empty = False
///
///                 res_meta.container_end_line = getattr(last_meta, 'container_end_line', last_meta.end_line)
///                 res_meta.container_end_column = getattr(last_meta, 'container_end_column', last_meta.end_column)
///                 res_meta.container_end_pos = getattr(last_meta, 'container_end_pos', last_meta.end_pos)
///
///         return res
///
///     def _pp_get_meta(self, children):
///         for c in children:
///             if self.node_filter is not None and not self.node_filter(c):
///                 continue
///             if isinstance(c, Tree):
///                 if not c.meta.empty:
///                     return c.meta
///             elif isinstance(c, Token):
///                 return c
///             elif hasattr(c, '__lark_meta__'):
///                 return c.__lark_meta__()
///
/// def make_propagate_positions(option):
///     if callable(option):
///         return partial(PropagatePositions, node_filter=option)
///     elif option is True:
///         return PropagatePositions
///     elif option is False:
///         return None
///
///     raise ConfigurationError('Invalid option for propagate_positions: %r' % option)
///
///
/// class ChildFilter:
///     def __init__(self, to_include, append_none, node_builder):
///         self.node_builder = node_builder
///         self.to_include = to_include
///         self.append_none = append_none
///
///     def __call__(self, children):
///         filtered = []
///
///         for i, to_expand, add_none in self.to_include:
///             if add_none:
///                 filtered += [None] * add_none
///             if to_expand:
///                 filtered += children[i].children
///             else:
///                 filtered.append(children[i])
///
///         if self.append_none:
///             filtered += [None] * self.append_none
///
///         return self.node_builder(filtered)
///
///
/// class ChildFilterLALR(ChildFilter):
///     """Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)"""
///
///     def __call__(self, children):
///         filtered = []
///         for i, to_expand, add_none in self.to_include:
///             if add_none:
///                 filtered += [None] * add_none
///             if to_expand:
///                 if filtered:
///                     filtered += children[i].children
///                 else:   # Optimize for left-recursion
///                     filtered = children[i].children
///             else:
///                 filtered.append(children[i])
///
///         if self.append_none:
///             filtered += [None] * self.append_none
///
///         return self.node_builder(filtered)
///
///
/// class ChildFilterLALR_NoPlaceholders(ChildFilter):
///     "Optimized childfilter for LALR (assumes no duplication in parse tree, so it's safe to change it)"
///     def __init__(self, to_include, node_builder):
///         self.node_builder = node_builder
///         self.to_include = to_include
///
///     def __call__(self, children):
///         filtered = []
///         for i, to_expand in self.to_include:
///             if to_expand:
///                 if filtered:
///                     filtered += children[i].children
///                 else:   # Optimize for left-recursion
///                     filtered = children[i].children
///             else:
///                 filtered.append(children[i])
///         return self.node_builder(filtered)
///
///
/// def _should_expand(sym):
///     return not sym.is_term and sym.name.startswith('_')
///
///
/// def maybe_create_child_filter(expansion, keep_all_tokens, ambiguous, _empty_indices: List[bool]):
///     # Prepare empty_indices as: How many Nones to insert at each index?
///     if _empty_indices:
///         assert _empty_indices.count(False) == len(expansion)
///         s = ''.join(str(int(b)) for b in _empty_indices)
///         empty_indices = [len(ones) for ones in s.split('0')]
///         assert len(empty_indices) == len(expansion)+1, (empty_indices, len(expansion))
///     else:
///         empty_indices = [0] * (len(expansion)+1)
///
///     to_include = []
///     nones_to_add = 0
///     for i, sym in enumerate(expansion):
///         nones_to_add += empty_indices[i]
///         if keep_all_tokens or not (sym.is_term and sym.filter_out):
///             to_include.append((i, _should_expand(sym), nones_to_add))
///             nones_to_add = 0
///
///     nones_to_add += empty_indices[len(expansion)]
///
///     if _empty_indices or len(to_include) < len(expansion) or any(to_expand for i, to_expand,_ in to_include):
///         if _empty_indices or ambiguous:
///             return partial(ChildFilter if ambiguous else ChildFilterLALR, to_include, nones_to_add)
///         else:
///             # LALR without placeholders
///             return partial(ChildFilterLALR_NoPlaceholders, [(i, x) for i,x,_ in to_include])
///
///
/// class AmbiguousExpander:
///     """Deal with the case where we're expanding children ('_rule') into a parent but the children
///        are ambiguous. i.e. (parent->_ambig->_expand_this_rule). In this case, make the parent itself
///        ambiguous with as many copies as there are ambiguous children, and then copy the ambiguous children
///        into the right parents in the right places, essentially shifting the ambiguity up the tree."""
///     def __init__(self, to_expand, tree_class, node_builder):
///         self.node_builder = node_builder
///         self.tree_class = tree_class
///         self.to_expand = to_expand
///
///     def __call__(self, children):
///         def _is_ambig_tree(t):
///             return hasattr(t, 'data') and t.data == '_ambig'
///
///         # -- When we're repeatedly expanding ambiguities we can end up with nested ambiguities.
///         #    All children of an _ambig node should be a derivation of that ambig node, hence
///         #    it is safe to assume that if we see an _ambig node nested within an ambig node
///         #    it is safe to simply expand it into the parent _ambig node as an alternative derivation.
///         ambiguous = []
///         for i, child in enumerate(children):
///             if _is_ambig_tree(child):
///                 if i in self.to_expand:
///                     ambiguous.append(i)
///
///                 child.expand_kids_by_data('_ambig')
///
///         if not ambiguous:
///             return self.node_builder(children)
///
///         expand = [child.children if i in ambiguous else (child,) for i, child in enumerate(children)]
///         return self.tree_class('_ambig', [self.node_builder(list(f)) for f in product(*expand)])
///
///
/// def maybe_create_ambiguous_expander(tree_class, expansion, keep_all_tokens):
///     to_expand = [i for i, sym in enumerate(expansion)
///                  if keep_all_tokens or ((not (sym.is_term and sym.filter_out)) and _should_expand(sym))]
///     if to_expand:
///         return partial(AmbiguousExpander, to_expand, tree_class)
///
///
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
///
///
///
/// def inplace_transformer(func):
///     @wraps(func)
///     def f(children):
///         # function name in a Transformer is a rule name.
///         tree = Tree(func.__name__, children)
///         return func(tree)
///     return f
///
///
/// def apply_visit_wrapper(func, name, wrapper):
///     if wrapper is _vargs_meta or wrapper is _vargs_meta_inline:
///         raise NotImplementedError("Meta args not supported for internal transformer")
///
///     @wraps(func)
///     def f(children):
///         return wrapper(func, name, children, None)
///     return f
///
///
/// class ParseTreeBuilder:
///     def __init__(self, rules, tree_class, propagate_positions=False, ambiguous=False, maybe_placeholders=False):
///         self.tree_class = tree_class
///         self.propagate_positions = propagate_positions
///         self.ambiguous = ambiguous
///         self.maybe_placeholders = maybe_placeholders
///
///         self.rule_builders = list(self._init_builders(rules))
///
///     def _init_builders(self, rules):
///         propagate_positions = make_propagate_positions(self.propagate_positions)
///
///         for rule in rules:
///             options = rule.options
///             keep_all_tokens = options.keep_all_tokens
///             expand_single_child = options.expand1
///
///             wrapper_chain = list(filter(None, [
///                 (expand_single_child and not rule.alias) and ExpandSingleChild,
///                 maybe_create_child_filter(rule.expansion, keep_all_tokens, self.ambiguous, options.empty_indices if self.maybe_placeholders else None),
///                 propagate_positions,
///                 self.ambiguous and maybe_create_ambiguous_expander(self.tree_class, rule.expansion, keep_all_tokens),
///                 self.ambiguous and partial(AmbiguousIntermediateExpander, self.tree_class)
///             ]))
///
///             yield rule, wrapper_chain
///
///     def create_callback(self, transformer=None):
///         callbacks = {}
///
///         default_handler = getattr(transformer, '__default__', None)
///         if default_handler:
///             def default_callback(data, children):
///                 return default_handler(data, children, None)
///         else:
///             default_callback = self.tree_class
///
///         for rule, wrapper_chain in self.rule_builders:
///
///             user_callback_name = rule.alias or rule.options.template_source or rule.origin.name
///             try:
///                 f = getattr(transformer, user_callback_name)
///                 wrapper = getattr(f, 'visit_wrapper', None)
///                 if wrapper is not None:
///                     f = apply_visit_wrapper(f, user_callback_name, wrapper)
///                 elif isinstance(transformer, Transformer_InPlace):
///                     f = inplace_transformer(f)
///             except AttributeError:
///                 f = partial(default_callback, user_callback_name)
///
///             for w in wrapper_chain:
///                 f = w(f)
///
///             if rule in callbacks:
///                 raise GrammarError("Rule '%s' already exists" % (rule,))
///
///             callbacks[rule] = f
///
///         return callbacks
///
/// ###}
/// ```
final class parse_tree_builder extends PythonModule {
  parse_tree_builder.from(super.pythonModule) : super.from();

  static parse_tree_builder import() => PythonFfi.instance.importModule(
        "lark.parse_tree_builder",
        parse_tree_builder.from,
      );

  /// ## apply_visit_wrapper
  ///
  /// ### python source
  /// ```py
  /// def apply_visit_wrapper(func, name, wrapper):
  ///     if wrapper is _vargs_meta or wrapper is _vargs_meta_inline:
  ///         raise NotImplementedError("Meta args not supported for internal transformer")
  ///
  ///     @wraps(func)
  ///     def f(children):
  ///         return wrapper(func, name, children, None)
  ///     return f
  /// ```
  Object? apply_visit_wrapper({
    required Object? func,
    required Object? name,
    required Object? wrapper,
  }) =>
      getFunction("apply_visit_wrapper").call(
        <Object?>[
          func,
          name,
          wrapper,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## inplace_transformer
  ///
  /// ### python source
  /// ```py
  /// def inplace_transformer(func):
  ///     @wraps(func)
  ///     def f(children):
  ///         # function name in a Transformer is a rule name.
  ///         tree = Tree(func.__name__, children)
  ///         return func(tree)
  ///     return f
  /// ```
  Object? inplace_transformer({
    required Object? func,
  }) =>
      getFunction("inplace_transformer").call(
        <Object?>[
          func,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## make_propagate_positions
  ///
  /// ### python source
  /// ```py
  /// def make_propagate_positions(option):
  ///     if callable(option):
  ///         return partial(PropagatePositions, node_filter=option)
  ///     elif option is True:
  ///         return PropagatePositions
  ///     elif option is False:
  ///         return None
  ///
  ///     raise ConfigurationError('Invalid option for propagate_positions: %r' % option)
  /// ```
  Object? make_propagate_positions({
    required Object? option,
  }) =>
      getFunction("make_propagate_positions").call(
        <Object?>[
          option,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## maybe_create_ambiguous_expander
  ///
  /// ### python source
  /// ```py
  /// def maybe_create_ambiguous_expander(tree_class, expansion, keep_all_tokens):
  ///     to_expand = [i for i, sym in enumerate(expansion)
  ///                  if keep_all_tokens or ((not (sym.is_term and sym.filter_out)) and _should_expand(sym))]
  ///     if to_expand:
  ///         return partial(AmbiguousExpander, to_expand, tree_class)
  /// ```
  Object? maybe_create_ambiguous_expander({
    required Object? tree_class,
    required Object? expansion,
    required Object? keep_all_tokens,
  }) =>
      getFunction("maybe_create_ambiguous_expander").call(
        <Object?>[
          tree_class,
          expansion,
          keep_all_tokens,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## maybe_create_child_filter
  ///
  /// ### python source
  /// ```py
  /// def maybe_create_child_filter(expansion, keep_all_tokens, ambiguous, _empty_indices: List[bool]):
  ///     # Prepare empty_indices as: How many Nones to insert at each index?
  ///     if _empty_indices:
  ///         assert _empty_indices.count(False) == len(expansion)
  ///         s = ''.join(str(int(b)) for b in _empty_indices)
  ///         empty_indices = [len(ones) for ones in s.split('0')]
  ///         assert len(empty_indices) == len(expansion)+1, (empty_indices, len(expansion))
  ///     else:
  ///         empty_indices = [0] * (len(expansion)+1)
  ///
  ///     to_include = []
  ///     nones_to_add = 0
  ///     for i, sym in enumerate(expansion):
  ///         nones_to_add += empty_indices[i]
  ///         if keep_all_tokens or not (sym.is_term and sym.filter_out):
  ///             to_include.append((i, _should_expand(sym), nones_to_add))
  ///             nones_to_add = 0
  ///
  ///     nones_to_add += empty_indices[len(expansion)]
  ///
  ///     if _empty_indices or len(to_include) < len(expansion) or any(to_expand for i, to_expand,_ in to_include):
  ///         if _empty_indices or ambiguous:
  ///             return partial(ChildFilter if ambiguous else ChildFilterLALR, to_include, nones_to_add)
  ///         else:
  ///             # LALR without placeholders
  ///             return partial(ChildFilterLALR_NoPlaceholders, [(i, x) for i,x,_ in to_include])
  /// ```
  Object? maybe_create_child_filter({
    required Object? expansion,
    required Object? keep_all_tokens,
    required Object? ambiguous,
    required Object? $_empty_indices,
  }) =>
      getFunction("maybe_create_child_filter").call(
        <Object?>[
          expansion,
          keep_all_tokens,
          ambiguous,
          $_empty_indices,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## List (getter)
  Object? get $List => getAttribute("List");

  /// ## List (setter)
  set $List(Object? $List) => setAttribute("List", $List);
}
