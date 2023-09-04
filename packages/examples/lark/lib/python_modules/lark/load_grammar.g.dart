// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library load_grammar;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## ApplyTemplates
///
/// ### python docstring
///
/// Apply the templates, creating new rules that represent the used templates
///
/// ### python source
/// ```py
/// class ApplyTemplates(Transformer_InPlace):
///     """Apply the templates, creating new rules that represent the used templates"""
///
///     def __init__(self, rule_defs):
///         self.rule_defs = rule_defs
///         self.replacer = _ReplaceSymbols()
///         self.created_templates = set()
///
///     def template_usage(self, c):
///         name = c[0].name
///         args = c[1:]
///         result_name = "%s{%s}" % (name, ",".join(a.name for a in args))
///         if result_name not in self.created_templates:
///             self.created_templates.add(result_name)
///             (_n, params, tree, options) ,= (t for t in self.rule_defs if t[0] == name)
///             assert len(params) == len(args), args
///             result_tree = deepcopy(tree)
///             self.replacer.names = dict(zip(params, args))
///             self.replacer.transform(result_tree)
///             self.rule_defs.append((result_name, [], result_tree, deepcopy(options)))
///         return NonTerminal(result_name)
/// ```
final class ApplyTemplates extends PythonClass {
  factory ApplyTemplates({
    required Object? rule_defs,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "ApplyTemplates",
        ApplyTemplates.from,
        <Object?>[
          rule_defs,
        ],
        <String, Object?>{},
      );

  ApplyTemplates.from(super.pythonClass) : super.from();

  /// ## template_usage
  ///
  /// ### python source
  /// ```py
  /// def template_usage(self, c):
  ///         name = c[0].name
  ///         args = c[1:]
  ///         result_name = "%s{%s}" % (name, ",".join(a.name for a in args))
  ///         if result_name not in self.created_templates:
  ///             self.created_templates.add(result_name)
  ///             (_n, params, tree, options) ,= (t for t in self.rule_defs if t[0] == name)
  ///             assert len(params) == len(args), args
  ///             result_tree = deepcopy(tree)
  ///             self.replacer.names = dict(zip(params, args))
  ///             self.replacer.transform(result_tree)
  ///             self.rule_defs.append((result_name, [], result_tree, deepcopy(options)))
  ///         return NonTerminal(result_name)
  /// ```
  Object? template_usage({
    required Object? c,
  }) =>
      getFunction("template_usage").call(
        <Object?>[
          c,
        ],
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

  /// ## rule_defs (getter)
  ///
  /// ### python docstring
  ///
  /// Apply the templates, creating new rules that represent the used templates
  Object? get rule_defs => getAttribute("rule_defs");

  /// ## rule_defs (setter)
  ///
  /// ### python docstring
  ///
  /// Apply the templates, creating new rules that represent the used templates
  set rule_defs(Object? rule_defs) => setAttribute("rule_defs", rule_defs);

  /// ## replacer (getter)
  ///
  /// ### python docstring
  ///
  /// Apply the templates, creating new rules that represent the used templates
  Object? get replacer => getAttribute("replacer");

  /// ## replacer (setter)
  ///
  /// ### python docstring
  ///
  /// Apply the templates, creating new rules that represent the used templates
  set replacer(Object? replacer) => setAttribute("replacer", replacer);

  /// ## created_templates (getter)
  ///
  /// ### python docstring
  ///
  /// Apply the templates, creating new rules that represent the used templates
  Object? get created_templates => getAttribute("created_templates");

  /// ## created_templates (setter)
  ///
  /// ### python docstring
  ///
  /// Apply the templates, creating new rules that represent the used templates
  set created_templates(Object? created_templates) =>
      setAttribute("created_templates", created_templates);
}

/// ## Definition
///
/// ### python source
/// ```py
/// class Definition:
///     def __init__(self, is_term, tree, params=(), options=None):
///         self.is_term = is_term
///         self.tree = tree
///         self.params = tuple(params)
///         self.options = options
/// ```
final class Definition extends PythonClass {
  factory Definition({
    required Object? is_term,
    required Object? tree,
    Object? params = const [],
    Object? options,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "Definition",
        Definition.from,
        <Object?>[
          is_term,
          tree,
          params,
          options,
        ],
        <String, Object?>{},
      );

  Definition.from(super.pythonClass) : super.from();

  /// ## is_term (getter)
  Object? get is_term => getAttribute("is_term");

  /// ## is_term (setter)
  set is_term(Object? is_term) => setAttribute("is_term", is_term);

  /// ## tree (getter)
  Object? get tree => getAttribute("tree");

  /// ## tree (setter)
  set tree(Object? tree) => setAttribute("tree", tree);

  /// ## params (getter)
  Object? get params => getAttribute("params");

  /// ## params (setter)
  set params(Object? params) => setAttribute("params", params);

  /// ## options (getter)
  Object? get options => getAttribute("options");

  /// ## options (setter)
  set options(Object? options) => setAttribute("options", options);
}

/// ## EBNF_to_BNF
///
/// ### python docstring
///
/// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
///
/// Useful for huge trees. Conservative in memory.
///
/// ### python source
/// ```py
/// @inline_args
/// class EBNF_to_BNF(Transformer_InPlace):
///     def __init__(self):
///         self.new_rules = []
///         self.rules_cache = {}
///         self.prefix = 'anon'
///         self.i = 0
///         self.rule_options = None
///
///     def _name_rule(self, inner):
///         new_name = '__%s_%s_%d' % (self.prefix, inner, self.i)
///         self.i += 1
///         return new_name
///
///     def _add_rule(self, key, name, expansions):
///         t = NonTerminal(name)
///         self.new_rules.append((name, expansions, self.rule_options))
///         self.rules_cache[key] = t
///         return t
///
///     def _add_recurse_rule(self, type_, expr):
///         try:
///             return self.rules_cache[expr]
///         except KeyError:
///             new_name = self._name_rule(type_)
///             t = NonTerminal(new_name)
///             tree = ST('expansions', [
///                 ST('expansion', [expr]),
///                 ST('expansion', [t, expr])
///             ])
///             return self._add_rule(expr, new_name, tree)
///
///     def _add_repeat_rule(self, a, b, target, atom):
///         """Generate a rule that repeats target ``a`` times, and repeats atom ``b`` times.
///
///         When called recursively (into target), it repeats atom for x(n) times, where:
///             x(0) = 1
///             x(n) = a(n) * x(n-1) + b
///
///         Example rule when a=3, b=4:
///
///             new_rule: target target target atom atom atom atom
///
///         """
///         key = (a, b, target, atom)
///         try:
///             return self.rules_cache[key]
///         except KeyError:
///             new_name = self._name_rule('repeat_a%d_b%d' % (a, b))
///             tree = ST('expansions', [ST('expansion', [target] * a + [atom] * b)])
///             return self._add_rule(key, new_name, tree)
///
///     def _add_repeat_opt_rule(self, a, b, target, target_opt, atom):
///         """Creates a rule that matches atom 0 to (a*n+b)-1 times.
///
///         When target matches n times atom, and target_opt 0 to n-1 times target_opt,
///
///         First we generate target * i followed by target_opt, for i from 0 to a-1
///         These match 0 to n*a - 1 times atom
///
///         Then we generate target * a followed by atom * i, for i from 0 to b-1
///         These match n*a to n*a + b-1 times atom
///
///         The created rule will not have any shift/reduce conflicts so that it can be used with lalr
///
///         Example rule when a=3, b=4:
///
///             new_rule: target_opt
///                     | target target_opt
///                     | target target target_opt
///
///                     | target target target
///                     | target target target atom
///                     | target target target atom atom
///                     | target target target atom atom atom
///
///         """
///         key = (a, b, target, atom, "opt")
///         try:
///             return self.rules_cache[key]
///         except KeyError:
///             new_name = self._name_rule('repeat_a%d_b%d_opt' % (a, b))
///             tree = ST('expansions', [
///                 ST('expansion', [target]*i + [target_opt]) for i in range(a)
///             ] + [
///                 ST('expansion', [target]*a + [atom]*i) for i in range(b)
///             ])
///             return self._add_rule(key, new_name, tree)
///
///     def _generate_repeats(self, rule, mn, mx):
///         """Generates a rule tree that repeats ``rule`` exactly between ``mn`` to ``mx`` times.
///         """
///         # For a small number of repeats, we can take the naive approach
///         if mx < REPEAT_BREAK_THRESHOLD:
///             return ST('expansions', [ST('expansion', [rule] * n) for n in range(mn, mx + 1)])
///
///         # For large repeat values, we break the repetition into sub-rules.
///         # We treat ``rule~mn..mx`` as ``rule~mn rule~0..(diff=mx-mn)``.
///         # We then use small_factors to split up mn and diff up into values [(a, b), ...]
///         # This values are used with the help of _add_repeat_rule and _add_repeat_rule_opt
///         # to generate a complete rule/expression that matches the corresponding number of repeats
///         mn_target = rule
///         for a, b in small_factors(mn, SMALL_FACTOR_THRESHOLD):
///             mn_target = self._add_repeat_rule(a, b, mn_target, rule)
///         if mx == mn:
///             return mn_target
///
///         diff = mx - mn + 1  # We add one because _add_repeat_opt_rule generates rules that match one less
///         diff_factors = small_factors(diff, SMALL_FACTOR_THRESHOLD)
///         diff_target = rule  # Match rule 1 times
///         diff_opt_target = ST('expansion', [])  # match rule 0 times (e.g. up to 1 -1 times)
///         for a, b in diff_factors[:-1]:
///             diff_opt_target = self._add_repeat_opt_rule(a, b, diff_target, diff_opt_target, rule)
///             diff_target = self._add_repeat_rule(a, b, diff_target, rule)
///
///         a, b = diff_factors[-1]
///         diff_opt_target = self._add_repeat_opt_rule(a, b, diff_target, diff_opt_target, rule)
///
///         return ST('expansions', [ST('expansion', [mn_target] + [diff_opt_target])])
///
///     def expr(self, rule, op, *args):
///         if op.value == '?':
///             empty = ST('expansion', [])
///             return ST('expansions', [rule, empty])
///         elif op.value == '+':
///             # a : b c+ d
///             #   -->
///             # a : b _c d
///             # _c : _c c | c;
///             return self._add_recurse_rule('plus', rule)
///         elif op.value == '*':
///             # a : b c* d
///             #   -->
///             # a : b _c? d
///             # _c : _c c | c;
///             new_name = self._add_recurse_rule('star', rule)
///             return ST('expansions', [new_name, ST('expansion', [])])
///         elif op.value == '~':
///             if len(args) == 1:
///                 mn = mx = int(args[0])
///             else:
///                 mn, mx = map(int, args)
///                 if mx < mn or mn < 0:
///                     raise GrammarError("Bad Range for %s (%d..%d isn't allowed)" % (rule, mn, mx))
///
///             return self._generate_repeats(rule, mn, mx)
///
///         assert False, op
///
///     def maybe(self, rule):
///         keep_all_tokens = self.rule_options and self.rule_options.keep_all_tokens
///         rule_size = FindRuleSize(keep_all_tokens).transform(rule)
///         empty = ST('expansion', [_EMPTY] * rule_size)
///         return ST('expansions', [rule, empty])
/// ```
final class EBNF_to_BNF extends PythonClass {
  factory EBNF_to_BNF() => PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "EBNF_to_BNF",
        EBNF_to_BNF.from,
        <Object?>[],
        <String, Object?>{},
      );

  EBNF_to_BNF.from(super.pythonClass) : super.from();

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

  /// ## expr (getter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  Object? get expr => getAttribute("expr");

  /// ## expr (setter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  set expr(Object? expr) => setAttribute("expr", expr);

  /// ## maybe (getter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  Object? get maybe => getAttribute("maybe");

  /// ## maybe (setter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  set maybe(Object? maybe) => setAttribute("maybe", maybe);

  /// ## new_rules (getter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  Object? get new_rules => getAttribute("new_rules");

  /// ## new_rules (setter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  set new_rules(Object? new_rules) => setAttribute("new_rules", new_rules);

  /// ## rules_cache (getter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  Object? get rules_cache => getAttribute("rules_cache");

  /// ## rules_cache (setter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  set rules_cache(Object? rules_cache) =>
      setAttribute("rules_cache", rules_cache);

  /// ## prefix (getter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  Object? get prefix => getAttribute("prefix");

  /// ## prefix (setter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  set prefix(Object? prefix) => setAttribute("prefix", prefix);

  /// ## i (getter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  Object? get i => getAttribute("i");

  /// ## i (setter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  set i(Object? i) => setAttribute("i", i);

  /// ## rule_options (getter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  Object? get rule_options => getAttribute("rule_options");

  /// ## rule_options (setter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  set rule_options(Object? rule_options) =>
      setAttribute("rule_options", rule_options);
}

/// ## FindRuleSize
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
/// class FindRuleSize(Transformer):
///     def __init__(self, keep_all_tokens):
///         self.keep_all_tokens = keep_all_tokens
///
///     def _will_not_get_removed(self, sym):
///         if isinstance(sym, NonTerminal):
///             return not sym.name.startswith('_')
///         if isinstance(sym, Terminal):
///             return self.keep_all_tokens or not sym.filter_out
///         if sym is _EMPTY:
///             return False
///         assert False, sym
///
///     def _args_as_int(self, args):
///         for a in args:
///             if isinstance(a, int):
///                 yield a
///             elif isinstance(a, Symbol):
///                 yield 1 if self._will_not_get_removed(a) else 0
///             else:
///                 assert False
///
///     def expansion(self, args):
///         return sum(self._args_as_int(args))
///
///     def expansions(self, args):
///         return max(self._args_as_int(args))
/// ```
final class FindRuleSize extends PythonClass {
  factory FindRuleSize({
    required Object? keep_all_tokens,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "FindRuleSize",
        FindRuleSize.from,
        <Object?>[
          keep_all_tokens,
        ],
        <String, Object?>{},
      );

  FindRuleSize.from(super.pythonClass) : super.from();

  /// ## expansion
  ///
  /// ### python source
  /// ```py
  /// def expansion(self, args):
  ///         return sum(self._args_as_int(args))
  /// ```
  Object? expansion({
    required Object? args,
  }) =>
      getFunction("expansion").call(
        <Object?>[
          args,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expansions
  ///
  /// ### python source
  /// ```py
  /// def expansions(self, args):
  ///         return max(self._args_as_int(args))
  /// ```
  Object? expansions({
    required Object? args,
  }) =>
      getFunction("expansions").call(
        <Object?>[
          args,
        ],
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

  /// ## keep_all_tokens (getter)
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
  Object? get keep_all_tokens => getAttribute("keep_all_tokens");

  /// ## keep_all_tokens (setter)
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
  set keep_all_tokens(Object? keep_all_tokens) =>
      setAttribute("keep_all_tokens", keep_all_tokens);
}

/// ## FromPackageLoader
///
/// ### python docstring
///
/// Provides a simple way of creating custom import loaders that load from packages via ``pkgutil.get_data`` instead of using `open`.
/// This allows them to be compatible even from within zip files.
///
/// Relative imports are handled, so you can just freely use them.
///
/// pkg_name: The name of the package. You can probably provide `__name__` most of the time
/// search_paths: All the path that will be search on absolute imports.
///
/// ### python source
/// ```py
/// class FromPackageLoader:
///     """
///     Provides a simple way of creating custom import loaders that load from packages via ``pkgutil.get_data`` instead of using `open`.
///     This allows them to be compatible even from within zip files.
///
///     Relative imports are handled, so you can just freely use them.
///
///     pkg_name: The name of the package. You can probably provide `__name__` most of the time
///     search_paths: All the path that will be search on absolute imports.
///     """
///
///     pkg_name: str
///     search_paths: Sequence[str]
///
///     def __init__(self, pkg_name: str, search_paths: Sequence[str]=("", )) -> None:
///         self.pkg_name = pkg_name
///         self.search_paths = search_paths
///
///     def __repr__(self):
///         return "%s(%r, %r)" % (type(self).__name__, self.pkg_name, self.search_paths)
///
///     def __call__(self, base_path: Union[None, str, PackageResource], grammar_path: str) -> Tuple[PackageResource, str]:
///         if base_path is None:
///             to_try = self.search_paths
///         else:
///             # Check whether or not the importing grammar was loaded by this module.
///             if not isinstance(base_path, PackageResource) or base_path.pkg_name != self.pkg_name:
///                 # Technically false, but FileNotFound doesn't exist in python2.7, and this message should never reach the end user anyway
///                 raise IOError()
///             to_try = [base_path.path]
///
///         err = None
///         for path in to_try:
///             full_path = os.path.join(path, grammar_path)
///             try:
///                 text: Optional[bytes] = pkgutil.get_data(self.pkg_name, full_path)
///             except IOError as e:
///                 err = e
///                 continue
///             else:
///                 return PackageResource(self.pkg_name, full_path), (text.decode() if text else '')
///
///         raise IOError('Cannot find grammar in given paths') from err
/// ```
final class FromPackageLoader extends PythonClass {
  factory FromPackageLoader({
    required String pkg_name,
    Object? search_paths = const [""],
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "FromPackageLoader",
        FromPackageLoader.from,
        <Object?>[
          pkg_name,
          search_paths,
        ],
        <String, Object?>{},
      );

  FromPackageLoader.from(super.pythonClass) : super.from();

  /// ## pkg_name (getter)
  ///
  /// ### python docstring
  ///
  /// Provides a simple way of creating custom import loaders that load from packages via ``pkgutil.get_data`` instead of using `open`.
  /// This allows them to be compatible even from within zip files.
  ///
  /// Relative imports are handled, so you can just freely use them.
  ///
  /// pkg_name: The name of the package. You can probably provide `__name__` most of the time
  /// search_paths: All the path that will be search on absolute imports.
  Object? get pkg_name => getAttribute("pkg_name");

  /// ## pkg_name (setter)
  ///
  /// ### python docstring
  ///
  /// Provides a simple way of creating custom import loaders that load from packages via ``pkgutil.get_data`` instead of using `open`.
  /// This allows them to be compatible even from within zip files.
  ///
  /// Relative imports are handled, so you can just freely use them.
  ///
  /// pkg_name: The name of the package. You can probably provide `__name__` most of the time
  /// search_paths: All the path that will be search on absolute imports.
  set pkg_name(Object? pkg_name) => setAttribute("pkg_name", pkg_name);

  /// ## search_paths (getter)
  ///
  /// ### python docstring
  ///
  /// Provides a simple way of creating custom import loaders that load from packages via ``pkgutil.get_data`` instead of using `open`.
  /// This allows them to be compatible even from within zip files.
  ///
  /// Relative imports are handled, so you can just freely use them.
  ///
  /// pkg_name: The name of the package. You can probably provide `__name__` most of the time
  /// search_paths: All the path that will be search on absolute imports.
  Object? get search_paths => getAttribute("search_paths");

  /// ## search_paths (setter)
  ///
  /// ### python docstring
  ///
  /// Provides a simple way of creating custom import loaders that load from packages via ``pkgutil.get_data`` instead of using `open`.
  /// This allows them to be compatible even from within zip files.
  ///
  /// Relative imports are handled, so you can just freely use them.
  ///
  /// pkg_name: The name of the package. You can probably provide `__name__` most of the time
  /// search_paths: All the path that will be search on absolute imports.
  set search_paths(Object? search_paths) =>
      setAttribute("search_paths", search_paths);
}

/// ## Grammar
///
/// ### python source
/// ```py
/// class Grammar:
///
///     term_defs: List[Tuple[str, Tuple[Tree, int]]]
///     rule_defs: List[Tuple[str, Tuple[str, ...], Tree, RuleOptions]]
///     ignore: List[str]
///
///     def __init__(self, rule_defs: List[Tuple[str, Tuple[str, ...], Tree, RuleOptions]], term_defs: List[Tuple[str, Tuple[Tree, int]]], ignore: List[str]) -> None:
///         self.term_defs = term_defs
///         self.rule_defs = rule_defs
///         self.ignore = ignore
///
///     def compile(self, start, terminals_to_keep):
///         # We change the trees in-place (to support huge grammars)
///         # So deepcopy allows calling compile more than once.
///         term_defs = [(n, (nr_deepcopy_tree(t), p)) for n, (t, p) in self.term_defs]
///         rule_defs = [(n, p, nr_deepcopy_tree(t), o) for n, p, t, o in self.rule_defs]
///
///         # ===================
///         #  Compile Terminals
///         # ===================
///
///         # Convert terminal-trees to strings/regexps
///
///         for name, (term_tree, priority) in term_defs:
///             if term_tree is None:  # Terminal added through %declare
///                 continue
///             expansions = list(term_tree.find_data('expansion'))
///             if len(expansions) == 1 and not expansions[0].children:
///                 raise GrammarError("Terminals cannot be empty (%s)" % name)
///
///         transformer = PrepareLiterals() * TerminalTreeToPattern()
///         terminals = [TerminalDef(name, transformer.transform(term_tree), priority)
///                      for name, (term_tree, priority) in term_defs if term_tree]
///
///         # =================
///         #  Compile Rules
///         # =================
///
///         # 1. Pre-process terminals
///         anon_tokens_transf = PrepareAnonTerminals(terminals)
///         transformer = PrepareLiterals() * ValidateSymbols() * anon_tokens_transf  # Adds to terminals
///
///         # 2. Inline Templates
///
///         transformer *= ApplyTemplates(rule_defs)
///
///         # 3. Convert EBNF to BNF (and apply step 1 & 2)
///         ebnf_to_bnf = EBNF_to_BNF()
///         rules = []
///         i = 0
///         while i < len(rule_defs):  # We have to do it like this because rule_defs might grow due to templates
///             name, params, rule_tree, options = rule_defs[i]
///             i += 1
///             if len(params) != 0:  # Dont transform templates
///                 continue
///             rule_options = RuleOptions(keep_all_tokens=True) if options and options.keep_all_tokens else None
///             ebnf_to_bnf.rule_options = rule_options
///             ebnf_to_bnf.prefix = name
///             anon_tokens_transf.rule_options = rule_options
///             tree = transformer.transform(rule_tree)
///             res = ebnf_to_bnf.transform(tree)
///             rules.append((name, res, options))
///         rules += ebnf_to_bnf.new_rules
///
///         assert len(rules) == len({name for name, _t, _o in rules}), "Whoops, name collision"
///
///         # 4. Compile tree to Rule objects
///         rule_tree_to_text = RuleTreeToText()
///
///         simplify_rule = SimplifyRule_Visitor()
///         compiled_rules = []
///         for rule_content in rules:
///             name, tree, options = rule_content
///             simplify_rule.visit(tree)
///             expansions = rule_tree_to_text.transform(tree)
///
///             for i, (expansion, alias) in enumerate(expansions):
///                 if alias and name.startswith('_'):
///                     raise GrammarError("Rule %s is marked for expansion (it starts with an underscore) and isn't allowed to have aliases (alias=%s)"% (name, alias))
///
///                 empty_indices = [x==_EMPTY for x in expansion]
///                 if any(empty_indices):
///                     exp_options = copy(options) or RuleOptions()
///                     exp_options.empty_indices = empty_indices
///                     expansion = [x for x in expansion if x!=_EMPTY]
///                 else:
///                     exp_options = options
///
///                 for sym in expansion:
///                     assert isinstance(sym, Symbol)
///                     if sym.is_term and exp_options and exp_options.keep_all_tokens:
///                         sym.filter_out = False
///                 rule = Rule(NonTerminal(name), expansion, i, alias, exp_options)
///                 compiled_rules.append(rule)
///
///         # Remove duplicates of empty rules, throw error for non-empty duplicates
///         if len(set(compiled_rules)) != len(compiled_rules):
///             duplicates = classify(compiled_rules, lambda x: x)
///             for dups in duplicates.values():
///                 if len(dups) > 1:
///                     if dups[0].expansion:
///                         raise GrammarError("Rules defined twice: %s\n\n(Might happen due to colliding expansion of optionals: [] or ?)"
///                                            % ''.join('\n  * %s' % i for i in dups))
///
///                     # Empty rule; assert all other attributes are equal
///                     assert len({(r.alias, r.order, r.options) for r in dups}) == len(dups)
///
///             # Remove duplicates
///             compiled_rules = list(set(compiled_rules))
///
///         # Filter out unused rules
///         while True:
///             c = len(compiled_rules)
///             used_rules = {s for r in compiled_rules
///                             for s in r.expansion
///                             if isinstance(s, NonTerminal)
///                             and s != r.origin}
///             used_rules |= {NonTerminal(s) for s in start}
///             compiled_rules, unused = classify_bool(compiled_rules, lambda r: r.origin in used_rules)
///             for r in unused:
///                 logger.debug("Unused rule: %s", r)
///             if len(compiled_rules) == c:
///                 break
///
///         # Filter out unused terminals
///         if terminals_to_keep != '*':
///             used_terms = {t.name for r in compiled_rules
///                                  for t in r.expansion
///                                  if isinstance(t, Terminal)}
///             terminals, unused = classify_bool(terminals, lambda t: t.name in used_terms or t.name in self.ignore or t.name in terminals_to_keep)
///             if unused:
///                 logger.debug("Unused terminals: %s", [t.name for t in unused])
///
///         return terminals, compiled_rules, self.ignore
/// ```
final class Grammar extends PythonClass {
  factory Grammar({
    required Object? rule_defs,
    required Object? term_defs,
    required Object? ignore,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "Grammar",
        Grammar.from,
        <Object?>[
          rule_defs,
          term_defs,
          ignore,
        ],
        <String, Object?>{},
      );

  Grammar.from(super.pythonClass) : super.from();

  /// ## compile
  ///
  /// ### python source
  /// ```py
  /// def compile(self, start, terminals_to_keep):
  ///         # We change the trees in-place (to support huge grammars)
  ///         # So deepcopy allows calling compile more than once.
  ///         term_defs = [(n, (nr_deepcopy_tree(t), p)) for n, (t, p) in self.term_defs]
  ///         rule_defs = [(n, p, nr_deepcopy_tree(t), o) for n, p, t, o in self.rule_defs]
  ///
  ///         # ===================
  ///         #  Compile Terminals
  ///         # ===================
  ///
  ///         # Convert terminal-trees to strings/regexps
  ///
  ///         for name, (term_tree, priority) in term_defs:
  ///             if term_tree is None:  # Terminal added through %declare
  ///                 continue
  ///             expansions = list(term_tree.find_data('expansion'))
  ///             if len(expansions) == 1 and not expansions[0].children:
  ///                 raise GrammarError("Terminals cannot be empty (%s)" % name)
  ///
  ///         transformer = PrepareLiterals() * TerminalTreeToPattern()
  ///         terminals = [TerminalDef(name, transformer.transform(term_tree), priority)
  ///                      for name, (term_tree, priority) in term_defs if term_tree]
  ///
  ///         # =================
  ///         #  Compile Rules
  ///         # =================
  ///
  ///         # 1. Pre-process terminals
  ///         anon_tokens_transf = PrepareAnonTerminals(terminals)
  ///         transformer = PrepareLiterals() * ValidateSymbols() * anon_tokens_transf  # Adds to terminals
  ///
  ///         # 2. Inline Templates
  ///
  ///         transformer *= ApplyTemplates(rule_defs)
  ///
  ///         # 3. Convert EBNF to BNF (and apply step 1 & 2)
  ///         ebnf_to_bnf = EBNF_to_BNF()
  ///         rules = []
  ///         i = 0
  ///         while i < len(rule_defs):  # We have to do it like this because rule_defs might grow due to templates
  ///             name, params, rule_tree, options = rule_defs[i]
  ///             i += 1
  ///             if len(params) != 0:  # Dont transform templates
  ///                 continue
  ///             rule_options = RuleOptions(keep_all_tokens=True) if options and options.keep_all_tokens else None
  ///             ebnf_to_bnf.rule_options = rule_options
  ///             ebnf_to_bnf.prefix = name
  ///             anon_tokens_transf.rule_options = rule_options
  ///             tree = transformer.transform(rule_tree)
  ///             res = ebnf_to_bnf.transform(tree)
  ///             rules.append((name, res, options))
  ///         rules += ebnf_to_bnf.new_rules
  ///
  ///         assert len(rules) == len({name for name, _t, _o in rules}), "Whoops, name collision"
  ///
  ///         # 4. Compile tree to Rule objects
  ///         rule_tree_to_text = RuleTreeToText()
  ///
  ///         simplify_rule = SimplifyRule_Visitor()
  ///         compiled_rules = []
  ///         for rule_content in rules:
  ///             name, tree, options = rule_content
  ///             simplify_rule.visit(tree)
  ///             expansions = rule_tree_to_text.transform(tree)
  ///
  ///             for i, (expansion, alias) in enumerate(expansions):
  ///                 if alias and name.startswith('_'):
  ///                     raise GrammarError("Rule %s is marked for expansion (it starts with an underscore) and isn't allowed to have aliases (alias=%s)"% (name, alias))
  ///
  ///                 empty_indices = [x==_EMPTY for x in expansion]
  ///                 if any(empty_indices):
  ///                     exp_options = copy(options) or RuleOptions()
  ///                     exp_options.empty_indices = empty_indices
  ///                     expansion = [x for x in expansion if x!=_EMPTY]
  ///                 else:
  ///                     exp_options = options
  ///
  ///                 for sym in expansion:
  ///                     assert isinstance(sym, Symbol)
  ///                     if sym.is_term and exp_options and exp_options.keep_all_tokens:
  ///                         sym.filter_out = False
  ///                 rule = Rule(NonTerminal(name), expansion, i, alias, exp_options)
  ///                 compiled_rules.append(rule)
  ///
  ///         # Remove duplicates of empty rules, throw error for non-empty duplicates
  ///         if len(set(compiled_rules)) != len(compiled_rules):
  ///             duplicates = classify(compiled_rules, lambda x: x)
  ///             for dups in duplicates.values():
  ///                 if len(dups) > 1:
  ///                     if dups[0].expansion:
  ///                         raise GrammarError("Rules defined twice: %s\n\n(Might happen due to colliding expansion of optionals: [] or ?)"
  ///                                            % ''.join('\n  * %s' % i for i in dups))
  ///
  ///                     # Empty rule; assert all other attributes are equal
  ///                     assert len({(r.alias, r.order, r.options) for r in dups}) == len(dups)
  ///
  ///             # Remove duplicates
  ///             compiled_rules = list(set(compiled_rules))
  ///
  ///         # Filter out unused rules
  ///         while True:
  ///             c = len(compiled_rules)
  ///             used_rules = {s for r in compiled_rules
  ///                             for s in r.expansion
  ///                             if isinstance(s, NonTerminal)
  ///                             and s != r.origin}
  ///             used_rules |= {NonTerminal(s) for s in start}
  ///             compiled_rules, unused = classify_bool(compiled_rules, lambda r: r.origin in used_rules)
  ///             for r in unused:
  ///                 logger.debug("Unused rule: %s", r)
  ///             if len(compiled_rules) == c:
  ///                 break
  ///
  ///         # Filter out unused terminals
  ///         if terminals_to_keep != '*':
  ///             used_terms = {t.name for r in compiled_rules
  ///                                  for t in r.expansion
  ///                                  if isinstance(t, Terminal)}
  ///             terminals, unused = classify_bool(terminals, lambda t: t.name in used_terms or t.name in self.ignore or t.name in terminals_to_keep)
  ///             if unused:
  ///                 logger.debug("Unused terminals: %s", [t.name for t in unused])
  ///
  ///         return terminals, compiled_rules, self.ignore
  /// ```
  Object? compile({
    required Object? start,
    required Object? terminals_to_keep,
  }) =>
      getFunction("compile").call(
        <Object?>[
          start,
          terminals_to_keep,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## term_defs (getter)
  Object? get term_defs => getAttribute("term_defs");

  /// ## term_defs (setter)
  set term_defs(Object? term_defs) => setAttribute("term_defs", term_defs);

  /// ## rule_defs (getter)
  Object? get rule_defs => getAttribute("rule_defs");

  /// ## rule_defs (setter)
  set rule_defs(Object? rule_defs) => setAttribute("rule_defs", rule_defs);

  /// ## ignore (getter)
  Object? get ignore => getAttribute("ignore");

  /// ## ignore (setter)
  set ignore(Object? ignore) => setAttribute("ignore", ignore);
}

/// ## GrammarBuilder
///
/// ### python source
/// ```py
/// class GrammarBuilder:
///
///     global_keep_all_tokens: bool
///     import_paths: List[Union[str, Callable]]
///     used_files: Dict[str, str]
///
///     _definitions: Dict[str, Definition]
///     _ignore_names: List[str]
///
///     def __init__(self, global_keep_all_tokens: bool=False, import_paths: Optional[List[Union[str, Callable]]]=None, used_files: Optional[Dict[str, str]]=None) -> None:
///         self.global_keep_all_tokens = global_keep_all_tokens
///         self.import_paths = import_paths or []
///         self.used_files = used_files or {}
///
///         self._definitions: Dict[str, Definition] = {}
///         self._ignore_names: List[str] = []
///
///     def _grammar_error(self, is_term, msg, *names):
///         args = {}
///         for i, name in enumerate(names, start=1):
///             postfix = '' if i == 1 else str(i)
///             args['name' + postfix] = name
///             args['type' + postfix] = lowercase_type = ("rule", "terminal")[is_term]
///             args['Type' + postfix] = lowercase_type.title()
///         raise GrammarError(msg.format(**args))
///
///     def _check_options(self, is_term, options):
///         if is_term:
///             if options is None:
///                 options = 1
///             elif not isinstance(options, int):
///                 raise GrammarError("Terminal require a single int as 'options' (e.g. priority), got %s" % (type(options),))
///         else:
///             if options is None:
///                 options = RuleOptions()
///             elif not isinstance(options, RuleOptions):
///                 raise GrammarError("Rules require a RuleOptions instance as 'options'")
///             if self.global_keep_all_tokens:
///                 options.keep_all_tokens = True
///         return options
///
///
///     def _define(self, name, is_term, exp, params=(), options=None, *, override=False):
///         if name in self._definitions:
///             if not override:
///                 self._grammar_error(is_term, "{Type} '{name}' defined more than once", name)
///         elif override:
///             self._grammar_error(is_term, "Cannot override a nonexisting {type} {name}", name)
///
///         if name.startswith('__'):
///             self._grammar_error(is_term, 'Names starting with double-underscore are reserved (Error at {name})', name)
///
///         self._definitions[name] = Definition(is_term, exp, params, self._check_options(is_term, options))
///
///     def _extend(self, name, is_term, exp, params=(), options=None):
///         if name not in self._definitions:
///             self._grammar_error(is_term, "Can't extend {type} {name} as it wasn't defined before", name)
///
///         d = self._definitions[name]
///
///         if is_term != d.is_term:
///             self._grammar_error(is_term, "Cannot extend {type} {name} - one is a terminal, while the other is not.", name)
///         if tuple(params) != d.params:
///             self._grammar_error(is_term, "Cannot extend {type} with different parameters: {name}", name)
///
///         if d.tree is None:
///             self._grammar_error(is_term, "Can't extend {type} {name} - it is abstract.", name)
///
///         # TODO: think about what to do with 'options'
///         base = d.tree
///
///         assert isinstance(base, Tree) and base.data == 'expansions'
///         base.children.insert(0, exp)
///
///     def _ignore(self, exp_or_name):
///         if isinstance(exp_or_name, str):
///             self._ignore_names.append(exp_or_name)
///         else:
///             assert isinstance(exp_or_name, Tree)
///             t = exp_or_name
///             if t.data == 'expansions' and len(t.children) == 1:
///                 t2 ,= t.children
///                 if t2.data=='expansion' and len(t2.children) == 1:
///                     item ,= t2.children
///                     if item.data == 'value':
///                         item ,= item.children
///                         if isinstance(item, Terminal):
///                             # Keep terminal name, no need to create a new definition
///                             self._ignore_names.append(item.name)
///                             return
///
///             name = '__IGNORE_%d'% len(self._ignore_names)
///             self._ignore_names.append(name)
///             self._definitions[name] = Definition(True, t, options=TOKEN_DEFAULT_PRIORITY)
///
///     def _unpack_import(self, stmt, grammar_name):
///         if len(stmt.children) > 1:
///             path_node, arg1 = stmt.children
///         else:
///             path_node, = stmt.children
///             arg1 = None
///
///         if isinstance(arg1, Tree):  # Multi import
///             dotted_path = tuple(path_node.children)
///             names = arg1.children
///             aliases = dict(zip(names, names))  # Can't have aliased multi import, so all aliases will be the same as names
///         else:  # Single import
///             dotted_path = tuple(path_node.children[:-1])
///             if not dotted_path:
///                 name ,= path_node.children
///                 raise GrammarError("Nothing was imported from grammar `%s`" % name)
///             name = path_node.children[-1]  # Get name from dotted path
///             aliases = {name.value: (arg1 or name).value}  # Aliases if exist
///
///         if path_node.data == 'import_lib':  # Import from library
///             base_path = None
///         else:  # Relative import
///             if grammar_name == '<string>':  # Import relative to script file path if grammar is coded in script
///                 try:
///                     base_file = os.path.abspath(sys.modules['__main__'].__file__)
///                 except AttributeError:
///                     base_file = None
///             else:
///                 base_file = grammar_name  # Import relative to grammar file path if external grammar file
///             if base_file:
///                 if isinstance(base_file, PackageResource):
///                     base_path = PackageResource(base_file.pkg_name, os.path.split(base_file.path)[0])
///                 else:
///                     base_path = os.path.split(base_file)[0]
///             else:
///                 base_path = os.path.abspath(os.path.curdir)
///
///         return dotted_path, base_path, aliases
///
///     def _unpack_definition(self, tree, mangle):
///
///         if tree.data == 'rule':
///             name, params, exp, opts = _make_rule_tuple(*tree.children)
///             is_term = False
///         else:
///             name = tree.children[0].value
///             params = ()     # TODO terminal templates
///             opts = int(tree.children[1]) if len(tree.children) == 3 else TOKEN_DEFAULT_PRIORITY # priority
///             exp = tree.children[-1]
///             is_term = True
///
///         if mangle is not None:
///             params = tuple(mangle(p) for p in params)
///             name = mangle(name)
///
///         exp = _mangle_definition_tree(exp, mangle)
///         return name, is_term, exp, params, opts
///
///
///     def load_grammar(self, grammar_text: str, grammar_name: str="<?>", mangle: Optional[Callable[[str], str]]=None) -> None:
///         tree = _parse_grammar(grammar_text, grammar_name)
///
///         imports: Dict[Tuple[str, ...], Tuple[Optional[str], Dict[str, str]]] = {}
///
///         for stmt in tree.children:
///             if stmt.data == 'import':
///                 dotted_path, base_path, aliases = self._unpack_import(stmt, grammar_name)
///                 try:
///                     import_base_path, import_aliases = imports[dotted_path]
///                     assert base_path == import_base_path, 'Inconsistent base_path for %s.' % '.'.join(dotted_path)
///                     import_aliases.update(aliases)
///                 except KeyError:
///                     imports[dotted_path] = base_path, aliases
///
///         for dotted_path, (base_path, aliases) in imports.items():
///             self.do_import(dotted_path, base_path, aliases, mangle)
///
///         for stmt in tree.children:
///             if stmt.data in ('term', 'rule'):
///                 self._define(*self._unpack_definition(stmt, mangle))
///             elif stmt.data == 'override':
///                 r ,= stmt.children
///                 self._define(*self._unpack_definition(r, mangle), override=True)
///             elif stmt.data == 'extend':
///                 r ,= stmt.children
///                 self._extend(*self._unpack_definition(r, mangle))
///             elif stmt.data == 'ignore':
///                 # if mangle is not None, we shouldn't apply ignore, since we aren't in a toplevel grammar
///                 if mangle is None:
///                     self._ignore(*stmt.children)
///             elif stmt.data == 'declare':
///                 for symbol in stmt.children:
///                     assert isinstance(symbol, Symbol), symbol
///                     is_term = isinstance(symbol, Terminal)
///                     if mangle is None:
///                         name = symbol.name
///                     else:
///                         name = mangle(symbol.name)
///                     self._define(name, is_term, None)
///             elif stmt.data == 'import':
///                 pass
///             else:
///                 assert False, stmt
///
///
///         term_defs = { name: d.tree
///             for name, d in self._definitions.items()
///             if d.is_term
///         }
///         resolve_term_references(term_defs)
///
///
///     def _remove_unused(self, used):
///         def rule_dependencies(symbol):
///             try:
///                 d = self._definitions[symbol]
///             except KeyError:
///                 return []
///             if d.is_term:
///                 return []
///             return _find_used_symbols(d.tree) - set(d.params)
///
///         _used = set(bfs(used, rule_dependencies))
///         self._definitions = {k: v for k, v in self._definitions.items() if k in _used}
///
///
///     def do_import(self, dotted_path: Tuple[str, ...], base_path: Optional[str], aliases: Dict[str, str], base_mangle: Optional[Callable[[str], str]]=None) -> None:
///         assert dotted_path
///         mangle = _get_mangle('__'.join(dotted_path), aliases, base_mangle)
///         grammar_path = os.path.join(*dotted_path) + EXT
///         to_try = self.import_paths + ([base_path] if base_path is not None else []) + [stdlib_loader]
///         for source in to_try:
///             try:
///                 if callable(source):
///                     joined_path, text = source(base_path, grammar_path)
///                 else:
///                     joined_path = os.path.join(source, grammar_path)
///                     with open(joined_path, encoding='utf8') as f:
///                         text = f.read()
///             except IOError:
///                 continue
///             else:
///                 h = sha256_digest(text)
///                 if self.used_files.get(joined_path, h) != h:
///                     raise RuntimeError("Grammar file was changed during importing")
///                 self.used_files[joined_path] = h
///
///                 gb = GrammarBuilder(self.global_keep_all_tokens, self.import_paths, self.used_files)
///                 gb.load_grammar(text, joined_path, mangle)
///                 gb._remove_unused(map(mangle, aliases))
///                 for name in gb._definitions:
///                     if name in self._definitions:
///                         raise GrammarError("Cannot import '%s' from '%s': Symbol already defined." % (name, grammar_path))
///
///                 self._definitions.update(**gb._definitions)
///                 break
///         else:
///             # Search failed. Make Python throw a nice error.
///             open(grammar_path, encoding='utf8')
///             assert False, "Couldn't import grammar %s, but a corresponding file was found at a place where lark doesn't search for it" % (dotted_path,)
///
///
///     def validate(self) -> None:
///         for name, d in self._definitions.items():
///             params = d.params
///             exp = d.tree
///
///             for i, p in enumerate(params):
///                 if p in self._definitions:
///                     raise GrammarError("Template Parameter conflicts with rule %s (in template %s)" % (p, name))
///                 if p in params[:i]:
///                     raise GrammarError("Duplicate Template Parameter %s (in template %s)" % (p, name))
///
///             if exp is None: # Remaining checks don't apply to abstract rules/terminals (created with %declare)
///                 continue
///
///             for temp in exp.find_data('template_usage'):
///                 sym = temp.children[0].name
///                 args = temp.children[1:]
///                 if sym not in params:
///                     if sym not in self._definitions:
///                         self._grammar_error(d.is_term, "Template '%s' used but not defined (in {type} {name})" % sym, name)
///                     if len(args) != len(self._definitions[sym].params):
///                         expected, actual = len(self._definitions[sym].params), len(args)
///                         self._grammar_error(d.is_term, "Wrong number of template arguments used for {name} "
///                                             "(expected %s, got %s) (in {type2} {name2})" % (expected, actual), sym, name)
///
///             for sym in _find_used_symbols(exp):
///                 if sym not in self._definitions and sym not in params:
///                     self._grammar_error(d.is_term, "{Type} '{name}' used but not defined (in {type2} {name2})", sym, name)
///
///         if not set(self._definitions).issuperset(self._ignore_names):
///             raise GrammarError("Terminals %s were marked to ignore but were not defined!" % (set(self._ignore_names) - set(self._definitions)))
///
///     def build(self) -> Grammar:
///         self.validate()
///         rule_defs = []
///         term_defs = []
///         for name, d in self._definitions.items():
///             (params, exp, options) = d.params, d.tree, d.options
///             if d.is_term:
///                 assert len(params) == 0
///                 term_defs.append((name, (exp, options)))
///             else:
///                 rule_defs.append((name, params, exp, options))
///         # resolve_term_references(term_defs)
///         return Grammar(rule_defs, term_defs, self._ignore_names)
/// ```
final class GrammarBuilder extends PythonClass {
  factory GrammarBuilder({
    bool global_keep_all_tokens = false,
    Object? import_paths,
    Object? used_files,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "GrammarBuilder",
        GrammarBuilder.from,
        <Object?>[
          global_keep_all_tokens,
          import_paths,
          used_files,
        ],
        <String, Object?>{},
      );

  GrammarBuilder.from(super.pythonClass) : super.from();

  /// ## build
  ///
  /// ### python source
  /// ```py
  /// def build(self) -> Grammar:
  ///         self.validate()
  ///         rule_defs = []
  ///         term_defs = []
  ///         for name, d in self._definitions.items():
  ///             (params, exp, options) = d.params, d.tree, d.options
  ///             if d.is_term:
  ///                 assert len(params) == 0
  ///                 term_defs.append((name, (exp, options)))
  ///             else:
  ///                 rule_defs.append((name, params, exp, options))
  ///         # resolve_term_references(term_defs)
  ///         return Grammar(rule_defs, term_defs, self._ignore_names)
  /// ```
  Grammar build() => Grammar.from(
        getFunction("build").call(
          <Object?>[],
          kwargs: <String, Object?>{},
        ),
      );

  /// ## do_import
  ///
  /// ### python source
  /// ```py
  /// def do_import(self, dotted_path: Tuple[str, ...], base_path: Optional[str], aliases: Dict[str, str], base_mangle: Optional[Callable[[str], str]]=None) -> None:
  ///         assert dotted_path
  ///         mangle = _get_mangle('__'.join(dotted_path), aliases, base_mangle)
  ///         grammar_path = os.path.join(*dotted_path) + EXT
  ///         to_try = self.import_paths + ([base_path] if base_path is not None else []) + [stdlib_loader]
  ///         for source in to_try:
  ///             try:
  ///                 if callable(source):
  ///                     joined_path, text = source(base_path, grammar_path)
  ///                 else:
  ///                     joined_path = os.path.join(source, grammar_path)
  ///                     with open(joined_path, encoding='utf8') as f:
  ///                         text = f.read()
  ///             except IOError:
  ///                 continue
  ///             else:
  ///                 h = sha256_digest(text)
  ///                 if self.used_files.get(joined_path, h) != h:
  ///                     raise RuntimeError("Grammar file was changed during importing")
  ///                 self.used_files[joined_path] = h
  ///
  ///                 gb = GrammarBuilder(self.global_keep_all_tokens, self.import_paths, self.used_files)
  ///                 gb.load_grammar(text, joined_path, mangle)
  ///                 gb._remove_unused(map(mangle, aliases))
  ///                 for name in gb._definitions:
  ///                     if name in self._definitions:
  ///                         raise GrammarError("Cannot import '%s' from '%s': Symbol already defined." % (name, grammar_path))
  ///
  ///                 self._definitions.update(**gb._definitions)
  ///                 break
  ///         else:
  ///             # Search failed. Make Python throw a nice error.
  ///             open(grammar_path, encoding='utf8')
  ///             assert False, "Couldn't import grammar %s, but a corresponding file was found at a place where lark doesn't search for it" % (dotted_path,)
  /// ```
  Null do_import({
    required Object? dotted_path,
    required Object? base_path,
    required Object? aliases,
    Object? base_mangle,
  }) =>
      getFunction("do_import").call(
        <Object?>[
          dotted_path,
          base_path,
          aliases,
          base_mangle,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## load_grammar
  ///
  /// ### python source
  /// ```py
  /// def load_grammar(self, grammar_text: str, grammar_name: str="<?>", mangle: Optional[Callable[[str], str]]=None) -> None:
  ///         tree = _parse_grammar(grammar_text, grammar_name)
  ///
  ///         imports: Dict[Tuple[str, ...], Tuple[Optional[str], Dict[str, str]]] = {}
  ///
  ///         for stmt in tree.children:
  ///             if stmt.data == 'import':
  ///                 dotted_path, base_path, aliases = self._unpack_import(stmt, grammar_name)
  ///                 try:
  ///                     import_base_path, import_aliases = imports[dotted_path]
  ///                     assert base_path == import_base_path, 'Inconsistent base_path for %s.' % '.'.join(dotted_path)
  ///                     import_aliases.update(aliases)
  ///                 except KeyError:
  ///                     imports[dotted_path] = base_path, aliases
  ///
  ///         for dotted_path, (base_path, aliases) in imports.items():
  ///             self.do_import(dotted_path, base_path, aliases, mangle)
  ///
  ///         for stmt in tree.children:
  ///             if stmt.data in ('term', 'rule'):
  ///                 self._define(*self._unpack_definition(stmt, mangle))
  ///             elif stmt.data == 'override':
  ///                 r ,= stmt.children
  ///                 self._define(*self._unpack_definition(r, mangle), override=True)
  ///             elif stmt.data == 'extend':
  ///                 r ,= stmt.children
  ///                 self._extend(*self._unpack_definition(r, mangle))
  ///             elif stmt.data == 'ignore':
  ///                 # if mangle is not None, we shouldn't apply ignore, since we aren't in a toplevel grammar
  ///                 if mangle is None:
  ///                     self._ignore(*stmt.children)
  ///             elif stmt.data == 'declare':
  ///                 for symbol in stmt.children:
  ///                     assert isinstance(symbol, Symbol), symbol
  ///                     is_term = isinstance(symbol, Terminal)
  ///                     if mangle is None:
  ///                         name = symbol.name
  ///                     else:
  ///                         name = mangle(symbol.name)
  ///                     self._define(name, is_term, None)
  ///             elif stmt.data == 'import':
  ///                 pass
  ///             else:
  ///                 assert False, stmt
  ///
  ///
  ///         term_defs = { name: d.tree
  ///             for name, d in self._definitions.items()
  ///             if d.is_term
  ///         }
  ///         resolve_term_references(term_defs)
  /// ```
  Null load_grammar({
    required String grammar_text,
    String grammar_name = "<?>",
    Object? mangle,
  }) =>
      getFunction("load_grammar").call(
        <Object?>[
          grammar_text,
          grammar_name,
          mangle,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## validate
  ///
  /// ### python source
  /// ```py
  /// def validate(self) -> None:
  ///         for name, d in self._definitions.items():
  ///             params = d.params
  ///             exp = d.tree
  ///
  ///             for i, p in enumerate(params):
  ///                 if p in self._definitions:
  ///                     raise GrammarError("Template Parameter conflicts with rule %s (in template %s)" % (p, name))
  ///                 if p in params[:i]:
  ///                     raise GrammarError("Duplicate Template Parameter %s (in template %s)" % (p, name))
  ///
  ///             if exp is None: # Remaining checks don't apply to abstract rules/terminals (created with %declare)
  ///                 continue
  ///
  ///             for temp in exp.find_data('template_usage'):
  ///                 sym = temp.children[0].name
  ///                 args = temp.children[1:]
  ///                 if sym not in params:
  ///                     if sym not in self._definitions:
  ///                         self._grammar_error(d.is_term, "Template '%s' used but not defined (in {type} {name})" % sym, name)
  ///                     if len(args) != len(self._definitions[sym].params):
  ///                         expected, actual = len(self._definitions[sym].params), len(args)
  ///                         self._grammar_error(d.is_term, "Wrong number of template arguments used for {name} "
  ///                                             "(expected %s, got %s) (in {type2} {name2})" % (expected, actual), sym, name)
  ///
  ///             for sym in _find_used_symbols(exp):
  ///                 if sym not in self._definitions and sym not in params:
  ///                     self._grammar_error(d.is_term, "{Type} '{name}' used but not defined (in {type2} {name2})", sym, name)
  ///
  ///         if not set(self._definitions).issuperset(self._ignore_names):
  ///             raise GrammarError("Terminals %s were marked to ignore but were not defined!" % (set(self._ignore_names) - set(self._definitions)))
  /// ```
  Null validate() => getFunction("validate").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## global_keep_all_tokens (getter)
  Object? get global_keep_all_tokens => getAttribute("global_keep_all_tokens");

  /// ## global_keep_all_tokens (setter)
  set global_keep_all_tokens(Object? global_keep_all_tokens) =>
      setAttribute("global_keep_all_tokens", global_keep_all_tokens);

  /// ## import_paths (getter)
  Object? get import_paths => getAttribute("import_paths");

  /// ## import_paths (setter)
  set import_paths(Object? import_paths) =>
      setAttribute("import_paths", import_paths);

  /// ## used_files (getter)
  Object? get used_files => getAttribute("used_files");

  /// ## used_files (setter)
  set used_files(Object? used_files) => setAttribute("used_files", used_files);
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

/// ## LexerConf
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
///
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
///
/// ### python source
/// ```py
/// class LexerConf(Serialize):
///     __serialize_fields__ = 'terminals', 'ignore', 'g_regex_flags', 'use_bytes', 'lexer_type'
///     __serialize_namespace__ = TerminalDef,
///
///     terminals: Collection[TerminalDef]
///     re_module: ModuleType
///     ignore: Collection[str]
///     postlex: 'Optional[PostLex]'
///     callbacks: Dict[str, _Callback]
///     g_regex_flags: int
///     skip_validation: bool
///     use_bytes: bool
///     lexer_type: Optional[_LexerArgType]
///     strict: bool
///
///     def __init__(self, terminals: Collection[TerminalDef], re_module: ModuleType, ignore: Collection[str]=(), postlex: 'Optional[PostLex]'=None,
///                  callbacks: Optional[Dict[str, _Callback]]=None, g_regex_flags: int=0, skip_validation: bool=False, use_bytes: bool=False, strict: bool=False):
///         self.terminals = terminals
///         self.terminals_by_name = {t.name: t for t in self.terminals}
///         assert len(self.terminals) == len(self.terminals_by_name)
///         self.ignore = ignore
///         self.postlex = postlex
///         self.callbacks = callbacks or {}
///         self.g_regex_flags = g_regex_flags
///         self.re_module = re_module
///         self.skip_validation = skip_validation
///         self.use_bytes = use_bytes
///         self.strict = strict
///         self.lexer_type = None
///
///     def _deserialize(self):
///         self.terminals_by_name = {t.name: t for t in self.terminals}
///
///     def __deepcopy__(self, memo=None):
///         return type(self)(
///             deepcopy(self.terminals, memo),
///             self.re_module,
///             deepcopy(self.ignore, memo),
///             deepcopy(self.postlex, memo),
///             deepcopy(self.callbacks, memo),
///             deepcopy(self.g_regex_flags, memo),
///             deepcopy(self.skip_validation, memo),
///             deepcopy(self.use_bytes, memo),
///         )
/// ```
final class LexerConf extends PythonClass {
  factory LexerConf({
    required Object? terminals,
    required Object? re_module,
    Object? ignore = const [],
    Object? postlex,
    Object? callbacks,
    int g_regex_flags = 0,
    bool skip_validation = false,
    bool use_bytes = false,
    bool strict = false,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.common",
        "LexerConf",
        LexerConf.from,
        <Object?>[
          terminals,
          re_module,
          ignore,
          postlex,
          callbacks,
          g_regex_flags,
          skip_validation,
          use_bytes,
          strict,
        ],
        <String, Object?>{},
      );

  LexerConf.from(super.pythonClass) : super.from();

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
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## terminals (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get terminals => getAttribute("terminals");

  /// ## terminals (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set terminals(Object? terminals) => setAttribute("terminals", terminals);

  /// ## terminals_by_name (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get terminals_by_name => getAttribute("terminals_by_name");

  /// ## terminals_by_name (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set terminals_by_name(Object? terminals_by_name) =>
      setAttribute("terminals_by_name", terminals_by_name);

  /// ## ignore (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get ignore => getAttribute("ignore");

  /// ## ignore (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set ignore(Object? ignore) => setAttribute("ignore", ignore);

  /// ## postlex (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get postlex => getAttribute("postlex");

  /// ## postlex (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set postlex(Object? postlex) => setAttribute("postlex", postlex);

  /// ## callbacks (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get callbacks => getAttribute("callbacks");

  /// ## callbacks (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set callbacks(Object? callbacks) => setAttribute("callbacks", callbacks);

  /// ## g_regex_flags (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get g_regex_flags => getAttribute("g_regex_flags");

  /// ## g_regex_flags (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set g_regex_flags(Object? g_regex_flags) =>
      setAttribute("g_regex_flags", g_regex_flags);

  /// ## re_module (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get re_module => getAttribute("re_module");

  /// ## re_module (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set re_module(Object? re_module) => setAttribute("re_module", re_module);

  /// ## skip_validation (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get skip_validation => getAttribute("skip_validation");

  /// ## skip_validation (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set skip_validation(Object? skip_validation) =>
      setAttribute("skip_validation", skip_validation);

  /// ## use_bytes (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get use_bytes => getAttribute("use_bytes");

  /// ## use_bytes (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set use_bytes(Object? use_bytes) => setAttribute("use_bytes", use_bytes);

  /// ## strict (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get strict => getAttribute("strict");

  /// ## strict (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set strict(Object? strict) => setAttribute("strict", strict);

  /// ## lexer_type (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get lexer_type => getAttribute("lexer_type");

  /// ## lexer_type (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set lexer_type(Object? lexer_type) => setAttribute("lexer_type", lexer_type);
}

/// ## NonTerminal
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
///
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
///
/// ### python source
/// ```py
/// class NonTerminal(Symbol):
///     __serialize_fields__ = 'name',
///
///     is_term: ClassVar[bool] = False
/// ```
final class NonTerminal extends PythonClass {
  factory NonTerminal({
    required String name,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.grammar",
        "NonTerminal",
        NonTerminal.from,
        <Object?>[
          name,
        ],
        <String, Object?>{},
      );

  NonTerminal.from(super.pythonClass) : super.from();

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

  /// ## renamed
  ///
  /// ### python source
  /// ```py
  /// def renamed(self, f):
  ///         return type(self)(f(self.name))
  /// ```
  Object? renamed({
    required Object? f,
  }) =>
      getFunction("renamed").call(
        <Object?>[
          f,
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

  /// ## fullrepr (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get fullrepr => getAttribute("fullrepr");

  /// ## fullrepr (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set fullrepr(Object? fullrepr) => setAttribute("fullrepr", fullrepr);

  /// ## deserialize (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## is_term (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get is_term => getAttribute("is_term");

  /// ## is_term (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set is_term(Object? is_term) => setAttribute("is_term", is_term);

  /// ## name (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get name => getAttribute("name");

  /// ## name (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set name(Object? name) => setAttribute("name", name);
}

/// ## PackageResource
///
/// ### python docstring
///
/// PackageResource(pkg_name, path)
final class PackageResource extends PythonClass {
  factory PackageResource() => PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "PackageResource",
        PackageResource.from,
        <Object?>[],
      );

  PackageResource.from(super.pythonClass) : super.from();

  /// ## path (getter)
  ///
  /// ### python docstring
  ///
  /// PackageResource(pkg_name, path)
  Object? get path => getAttribute("path");

  /// ## path (setter)
  ///
  /// ### python docstring
  ///
  /// PackageResource(pkg_name, path)
  set path(Object? path) => setAttribute("path", path);

  /// ## pkg_name (getter)
  ///
  /// ### python docstring
  ///
  /// PackageResource(pkg_name, path)
  Object? get pkg_name => getAttribute("pkg_name");

  /// ## pkg_name (setter)
  ///
  /// ### python docstring
  ///
  /// PackageResource(pkg_name, path)
  set pkg_name(Object? pkg_name) => setAttribute("pkg_name", pkg_name);

  /// ## count (getter)
  ///
  /// ### python docstring
  ///
  /// PackageResource(pkg_name, path)
  Object? get count => getAttribute("count");

  /// ## count (setter)
  ///
  /// ### python docstring
  ///
  /// PackageResource(pkg_name, path)
  set count(Object? count) => setAttribute("count", count);

  /// ## index (getter)
  ///
  /// ### python docstring
  ///
  /// PackageResource(pkg_name, path)
  Object? get index => getAttribute("index");

  /// ## index (setter)
  ///
  /// ### python docstring
  ///
  /// PackageResource(pkg_name, path)
  set index(Object? index) => setAttribute("index", index);
}

/// ## ParseError
///
/// ### python source
/// ```py
/// class ParseError(LarkError):
///     pass
/// ```
final class ParseError extends PythonClass {
  factory ParseError() => PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "ParseError",
        ParseError.from,
        <Object?>[],
      );

  ParseError.from(super.pythonClass) : super.from();

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
      PythonFfiDart.instance.importClass(
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

/// ## ParserConf
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
///
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
///
/// ### python source
/// ```py
/// class ParserConf(Serialize):
///     __serialize_fields__ = 'rules', 'start', 'parser_type'
///
///     def __init__(self, rules, callbacks, start):
///         assert isinstance(start, list)
///         self.rules = rules
///         self.callbacks = callbacks
///         self.start = start
///
///         self.parser_type = None
/// ```
final class ParserConf extends PythonClass {
  factory ParserConf({
    required Object? rules,
    required Object? callbacks,
    required Object? start,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.common",
        "ParserConf",
        ParserConf.from,
        <Object?>[
          rules,
          callbacks,
          start,
        ],
        <String, Object?>{},
      );

  ParserConf.from(super.pythonClass) : super.from();

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
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## rules (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get rules => getAttribute("rules");

  /// ## rules (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set rules(Object? rules) => setAttribute("rules", rules);

  /// ## callbacks (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get callbacks => getAttribute("callbacks");

  /// ## callbacks (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set callbacks(Object? callbacks) => setAttribute("callbacks", callbacks);

  /// ## start (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get start => getAttribute("start");

  /// ## start (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set start(Object? start) => setAttribute("start", start);

  /// ## parser_type (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get parser_type => getAttribute("parser_type");

  /// ## parser_type (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set parser_type(Object? parser_type) =>
      setAttribute("parser_type", parser_type);
}

/// ## ParsingFrontend
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
///
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
///
/// ### python source
/// ```py
/// class ParsingFrontend(Serialize):
///     __serialize_fields__ = 'lexer_conf', 'parser_conf', 'parser'
///
///     lexer_conf: LexerConf
///     parser_conf: ParserConf
///     options: Any
///
///     def __init__(self, lexer_conf: LexerConf, parser_conf: ParserConf, options, parser=None):
///         self.parser_conf = parser_conf
///         self.lexer_conf = lexer_conf
///         self.options = options
///
///         # Set-up parser
///         if parser:  # From cache
///             self.parser = parser
///         else:
///             create_parser = _parser_creators.get(parser_conf.parser_type)
///             assert create_parser is not None, "{} is not supported in standalone mode".format(
///                     parser_conf.parser_type
///                 )
///             self.parser = create_parser(lexer_conf, parser_conf, options)
///
///         # Set-up lexer
///         lexer_type = lexer_conf.lexer_type
///         self.skip_lexer = False
///         if lexer_type in ('dynamic', 'dynamic_complete'):
///             assert lexer_conf.postlex is None
///             self.skip_lexer = True
///             return
///
///         if isinstance(lexer_type, type):
///             assert issubclass(lexer_type, Lexer)
///             self.lexer = _wrap_lexer(lexer_type)(lexer_conf)
///         elif isinstance(lexer_type, str):
///             create_lexer = {
///                 'basic': create_basic_lexer,
///                 'contextual': create_contextual_lexer,
///             }[lexer_type]
///             self.lexer = create_lexer(lexer_conf, self.parser, lexer_conf.postlex, options)
///         else:
///             raise TypeError("Bad value for lexer_type: {lexer_type}")
///
///         if lexer_conf.postlex:
///             self.lexer = PostLexConnector(self.lexer, lexer_conf.postlex)
///
///     def _verify_start(self, start=None):
///         if start is None:
///             start_decls = self.parser_conf.start
///             if len(start_decls) > 1:
///                 raise ConfigurationError("Lark initialized with more than 1 possible start rule. Must specify which start rule to parse", start_decls)
///             start ,= start_decls
///         elif start not in self.parser_conf.start:
///             raise ConfigurationError("Unknown start rule %s. Must be one of %r" % (start, self.parser_conf.start))
///         return start
///
///     def _make_lexer_thread(self, text: str):
///         cls = (self.options and self.options._plugins.get('LexerThread')) or LexerThread
///         return text if self.skip_lexer else cls.from_text(self.lexer, text)
///
///     def parse(self, text: str, start=None, on_error=None):
///         chosen_start = self._verify_start(start)
///         kw = {} if on_error is None else {'on_error': on_error}
///         stream = self._make_lexer_thread(text)
///         return self.parser.parse(stream, chosen_start, **kw)
///
///     def parse_interactive(self, text: Optional[str]=None, start=None):
///         # TODO BREAK - Change text from Optional[str] to text: str = ''.
///         #   Would break behavior of exhaust_lexer(), which currently raises TypeError, and after the change would just return []
///         chosen_start = self._verify_start(start)
///         if self.parser_conf.parser_type != 'lalr':
///             raise ConfigurationError("parse_interactive() currently only works with parser='lalr' ")
///         stream = self._make_lexer_thread(text)  # type: ignore[arg-type]
///         return self.parser.parse_interactive(stream, chosen_start)
/// ```
final class ParsingFrontend extends PythonClass {
  factory ParsingFrontend({
    required LexerConf lexer_conf,
    required ParserConf parser_conf,
    required Object? options,
    Object? parser,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parser_frontends",
        "ParsingFrontend",
        ParsingFrontend.from,
        <Object?>[
          lexer_conf,
          parser_conf,
          options,
          parser,
        ],
        <String, Object?>{},
      );

  ParsingFrontend.from(super.pythonClass) : super.from();

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
  /// ### python source
  /// ```py
  /// def parse(self, text: str, start=None, on_error=None):
  ///         chosen_start = self._verify_start(start)
  ///         kw = {} if on_error is None else {'on_error': on_error}
  ///         stream = self._make_lexer_thread(text)
  ///         return self.parser.parse(stream, chosen_start, **kw)
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
  /// ### python source
  /// ```py
  /// def parse_interactive(self, text: Optional[str]=None, start=None):
  ///         # TODO BREAK - Change text from Optional[str] to text: str = ''.
  ///         #   Would break behavior of exhaust_lexer(), which currently raises TypeError, and after the change would just return []
  ///         chosen_start = self._verify_start(start)
  ///         if self.parser_conf.parser_type != 'lalr':
  ///             raise ConfigurationError("parse_interactive() currently only works with parser='lalr' ")
  ///         stream = self._make_lexer_thread(text)  # type: ignore[arg-type]
  ///         return self.parser.parse_interactive(stream, chosen_start)
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
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## parser_conf (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get parser_conf => getAttribute("parser_conf");

  /// ## parser_conf (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set parser_conf(Object? parser_conf) =>
      setAttribute("parser_conf", parser_conf);

  /// ## lexer_conf (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get lexer_conf => getAttribute("lexer_conf");

  /// ## lexer_conf (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set lexer_conf(Object? lexer_conf) => setAttribute("lexer_conf", lexer_conf);

  /// ## options (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get options => getAttribute("options");

  /// ## options (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set options(Object? options) => setAttribute("options", options);

  /// ## parser (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get parser => getAttribute("parser");

  /// ## parser (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set parser(Object? parser) => setAttribute("parser", parser);

  /// ## skip_lexer (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get skip_lexer => getAttribute("skip_lexer");

  /// ## skip_lexer (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set skip_lexer(Object? skip_lexer) => setAttribute("skip_lexer", skip_lexer);

  /// ## lexer (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get lexer => getAttribute("lexer");

  /// ## lexer (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set lexer(Object? lexer) => setAttribute("lexer", lexer);
}

/// ## PatternRE
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
///
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
///
/// ### python source
/// ```py
/// class PatternRE(Pattern):
///     __serialize_fields__ = 'value', 'flags', 'raw', '_width'
///
///     type: ClassVar[str] = "re"
///
///     def to_regexp(self) -> str:
///         return self._get_flags(self.value)
///
///     _width = None
///     def _get_width(self):
///         if self._width is None:
///             self._width = get_regexp_width(self.to_regexp())
///         return self._width
///
///     @property
///     def min_width(self) -> int:
///         return self._get_width()[0]
///
///     @property
///     def max_width(self) -> int:
///         return self._get_width()[1]
/// ```
final class PatternRE extends PythonClass {
  factory PatternRE({
    required String value,
    Object? flags = const [],
    Object? raw,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lexer",
        "PatternRE",
        PatternRE.from,
        <Object?>[
          value,
          flags,
          raw,
        ],
        <String, Object?>{},
      );

  PatternRE.from(super.pythonClass) : super.from();

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

  /// ## to_regexp
  ///
  /// ### python source
  /// ```py
  /// def to_regexp(self) -> str:
  ///         return self._get_flags(self.value)
  /// ```
  String to_regexp() => getFunction("to_regexp").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## max_width (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get max_width => getAttribute("max_width");

  /// ## max_width (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set max_width(Object? max_width) => setAttribute("max_width", max_width);

  /// ## min_width (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get min_width => getAttribute("min_width");

  /// ## min_width (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set min_width(Object? min_width) => setAttribute("min_width", min_width);

  /// ## deserialize (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## type (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get type => getAttribute("type");

  /// ## type (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set type(Object? type) => setAttribute("type", type);

  /// ## value (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get value => getAttribute("value");

  /// ## value (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set value(Object? value) => setAttribute("value", value);

  /// ## flags (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get flags => getAttribute("flags");

  /// ## flags (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set flags(Object? flags) => setAttribute("flags", flags);

  /// ## raw (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get raw => getAttribute("raw");

  /// ## raw (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set raw(Object? raw) => setAttribute("raw", raw);
}

/// ## PatternStr
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
///
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
///
/// ### python source
/// ```py
/// class PatternStr(Pattern):
///     __serialize_fields__ = 'value', 'flags', 'raw'
///
///     type: ClassVar[str] = "str"
///
///     def to_regexp(self) -> str:
///         return self._get_flags(re.escape(self.value))
///
///     @property
///     def min_width(self) -> int:
///         return len(self.value)
///
///     @property
///     def max_width(self) -> int:
///         return len(self.value)
/// ```
final class PatternStr extends PythonClass {
  factory PatternStr({
    required String value,
    Object? flags = const [],
    Object? raw,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lexer",
        "PatternStr",
        PatternStr.from,
        <Object?>[
          value,
          flags,
          raw,
        ],
        <String, Object?>{},
      );

  PatternStr.from(super.pythonClass) : super.from();

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

  /// ## to_regexp
  ///
  /// ### python source
  /// ```py
  /// def to_regexp(self) -> str:
  ///         return self._get_flags(re.escape(self.value))
  /// ```
  String to_regexp() => getFunction("to_regexp").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## max_width (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get max_width => getAttribute("max_width");

  /// ## max_width (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set max_width(Object? max_width) => setAttribute("max_width", max_width);

  /// ## min_width (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get min_width => getAttribute("min_width");

  /// ## min_width (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set min_width(Object? min_width) => setAttribute("min_width", min_width);

  /// ## deserialize (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## type (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get type => getAttribute("type");

  /// ## type (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set type(Object? type) => setAttribute("type", type);

  /// ## value (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get value => getAttribute("value");

  /// ## value (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set value(Object? value) => setAttribute("value", value);

  /// ## flags (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get flags => getAttribute("flags");

  /// ## flags (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set flags(Object? flags) => setAttribute("flags", flags);

  /// ## raw (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get raw => getAttribute("raw");

  /// ## raw (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set raw(Object? raw) => setAttribute("raw", raw);
}

/// ## PrepareAnonTerminals
///
/// ### python docstring
///
/// Create a unique list of anonymous terminals. Attempt to give meaningful names to them when we add them
///
/// ### python source
/// ```py
/// class PrepareAnonTerminals(Transformer_InPlace):
///     """Create a unique list of anonymous terminals. Attempt to give meaningful names to them when we add them"""
///
///     def __init__(self, terminals):
///         self.terminals = terminals
///         self.term_set = {td.name for td in self.terminals}
///         self.term_reverse = {td.pattern: td for td in terminals}
///         self.i = 0
///         self.rule_options = None
///
///     @inline_args
///     def pattern(self, p):
///         value = p.value
///         if p in self.term_reverse and p.flags != self.term_reverse[p].pattern.flags:
///             raise GrammarError(u'Conflicting flags for the same terminal: %s' % p)
///
///         term_name = None
///
///         if isinstance(p, PatternStr):
///             try:
///                 # If already defined, use the user-defined terminal name
///                 term_name = self.term_reverse[p].name
///             except KeyError:
///                 # Try to assign an indicative anon-terminal name
///                 try:
///                     term_name = _TERMINAL_NAMES[value]
///                 except KeyError:
///                     if value and is_id_continue(value) and is_id_start(value[0]) and value.upper() not in self.term_set:
///                         term_name = value.upper()
///
///                 if term_name in self.term_set:
///                     term_name = None
///
///         elif isinstance(p, PatternRE):
///             if p in self.term_reverse:  # Kind of a weird placement.name
///                 term_name = self.term_reverse[p].name
///         else:
///             assert False, p
///
///         if term_name is None:
///             term_name = '__ANON_%d' % self.i
///             self.i += 1
///
///         if term_name not in self.term_set:
///             assert p not in self.term_reverse
///             self.term_set.add(term_name)
///             termdef = TerminalDef(term_name, p)
///             self.term_reverse[p] = termdef
///             self.terminals.append(termdef)
///
///         filter_out = False if self.rule_options and self.rule_options.keep_all_tokens else isinstance(p, PatternStr)
///
///         return Terminal(term_name, filter_out=filter_out)
/// ```
final class PrepareAnonTerminals extends PythonClass {
  factory PrepareAnonTerminals({
    required Object? terminals,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "PrepareAnonTerminals",
        PrepareAnonTerminals.from,
        <Object?>[
          terminals,
        ],
        <String, Object?>{},
      );

  PrepareAnonTerminals.from(super.pythonClass) : super.from();

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

  /// ## pattern (getter)
  ///
  /// ### python docstring
  ///
  /// Create a unique list of anonymous terminals. Attempt to give meaningful names to them when we add them
  Object? get pattern => getAttribute("pattern");

  /// ## pattern (setter)
  ///
  /// ### python docstring
  ///
  /// Create a unique list of anonymous terminals. Attempt to give meaningful names to them when we add them
  set pattern(Object? pattern) => setAttribute("pattern", pattern);

  /// ## terminals (getter)
  ///
  /// ### python docstring
  ///
  /// Create a unique list of anonymous terminals. Attempt to give meaningful names to them when we add them
  Object? get terminals => getAttribute("terminals");

  /// ## terminals (setter)
  ///
  /// ### python docstring
  ///
  /// Create a unique list of anonymous terminals. Attempt to give meaningful names to them when we add them
  set terminals(Object? terminals) => setAttribute("terminals", terminals);

  /// ## term_set (getter)
  ///
  /// ### python docstring
  ///
  /// Create a unique list of anonymous terminals. Attempt to give meaningful names to them when we add them
  Object? get term_set => getAttribute("term_set");

  /// ## term_set (setter)
  ///
  /// ### python docstring
  ///
  /// Create a unique list of anonymous terminals. Attempt to give meaningful names to them when we add them
  set term_set(Object? term_set) => setAttribute("term_set", term_set);

  /// ## term_reverse (getter)
  ///
  /// ### python docstring
  ///
  /// Create a unique list of anonymous terminals. Attempt to give meaningful names to them when we add them
  Object? get term_reverse => getAttribute("term_reverse");

  /// ## term_reverse (setter)
  ///
  /// ### python docstring
  ///
  /// Create a unique list of anonymous terminals. Attempt to give meaningful names to them when we add them
  set term_reverse(Object? term_reverse) =>
      setAttribute("term_reverse", term_reverse);

  /// ## i (getter)
  ///
  /// ### python docstring
  ///
  /// Create a unique list of anonymous terminals. Attempt to give meaningful names to them when we add them
  Object? get i => getAttribute("i");

  /// ## i (setter)
  ///
  /// ### python docstring
  ///
  /// Create a unique list of anonymous terminals. Attempt to give meaningful names to them when we add them
  set i(Object? i) => setAttribute("i", i);

  /// ## rule_options (getter)
  ///
  /// ### python docstring
  ///
  /// Create a unique list of anonymous terminals. Attempt to give meaningful names to them when we add them
  Object? get rule_options => getAttribute("rule_options");

  /// ## rule_options (setter)
  ///
  /// ### python docstring
  ///
  /// Create a unique list of anonymous terminals. Attempt to give meaningful names to them when we add them
  set rule_options(Object? rule_options) =>
      setAttribute("rule_options", rule_options);
}

/// ## PrepareGrammar
///
/// ### python docstring
///
/// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
///
/// Useful for huge trees. Conservative in memory.
///
/// ### python source
/// ```py
/// @inline_args
/// class PrepareGrammar(Transformer_InPlace):
///     def terminal(self, name):
///         return Terminal(str(name), filter_out=name.startswith('_'))
///
///     def nonterminal(self, name):
///         return NonTerminal(name.value)
/// ```
final class PrepareGrammar extends PythonClass {
  factory PrepareGrammar({
    bool visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "PrepareGrammar",
        PrepareGrammar.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  PrepareGrammar.from(super.pythonClass) : super.from();

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

  /// ## nonterminal (getter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  Object? get nonterminal => getAttribute("nonterminal");

  /// ## nonterminal (setter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  set nonterminal(Object? nonterminal) =>
      setAttribute("nonterminal", nonterminal);

  /// ## terminal (getter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  Object? get terminal => getAttribute("terminal");

  /// ## terminal (setter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  set terminal(Object? terminal) => setAttribute("terminal", terminal);
}

/// ## PrepareLiterals
///
/// ### python docstring
///
/// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
///
/// Useful for huge trees. Conservative in memory.
///
/// ### python source
/// ```py
/// @inline_args
/// class PrepareLiterals(Transformer_InPlace):
///     def literal(self, literal):
///         return ST('pattern', [_literal_to_pattern(literal)])
///
///     def range(self, start, end):
///         assert start.type == end.type == 'STRING'
///         start = start.value[1:-1]
///         end = end.value[1:-1]
///         assert len(eval_escaping(start)) == len(eval_escaping(end)) == 1
///         regexp = '[%s-%s]' % (start, end)
///         return ST('pattern', [PatternRE(regexp)])
/// ```
final class PrepareLiterals extends PythonClass {
  factory PrepareLiterals({
    bool visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "PrepareLiterals",
        PrepareLiterals.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  PrepareLiterals.from(super.pythonClass) : super.from();

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

  /// ## literal (getter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  Object? get literal => getAttribute("literal");

  /// ## literal (setter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  set literal(Object? literal) => setAttribute("literal", literal);

  /// ## range (getter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  Object? get range => getAttribute("range");

  /// ## range (setter)
  ///
  /// ### python docstring
  ///
  /// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
  ///
  /// Useful for huge trees. Conservative in memory.
  set range(Object? range) => setAttribute("range", range);
}

/// ## Rule
///
/// ### python docstring
///
/// origin : a symbol
/// expansion : a list of symbols
/// order : index of this expansion amongst all rules of the same name
///
/// ### python source
/// ```py
/// class Rule(Serialize):
///     """
///         origin : a symbol
///         expansion : a list of symbols
///         order : index of this expansion amongst all rules of the same name
///     """
///     __slots__ = ('origin', 'expansion', 'alias', 'options', 'order', '_hash')
///
///     __serialize_fields__ = 'origin', 'expansion', 'order', 'alias', 'options'
///     __serialize_namespace__ = Terminal, NonTerminal, RuleOptions
///
///     def __init__(self, origin, expansion, order=0, alias=None, options=None):
///         self.origin = origin
///         self.expansion = expansion
///         self.alias = alias
///         self.order = order
///         self.options = options or RuleOptions()
///         self._hash = hash((self.origin, tuple(self.expansion)))
///
///     def _deserialize(self):
///         self._hash = hash((self.origin, tuple(self.expansion)))
///
///     def __str__(self):
///         return '<%s : %s>' % (self.origin.name, ' '.join(x.name for x in self.expansion))
///
///     def __repr__(self):
///         return 'Rule(%r, %r, %r, %r)' % (self.origin, self.expansion, self.alias, self.options)
///
///     def __hash__(self):
///         return self._hash
///
///     def __eq__(self, other):
///         if not isinstance(other, Rule):
///             return False
///         return self.origin == other.origin and self.expansion == other.expansion
/// ```
final class Rule extends PythonClass {
  factory Rule({
    required Object? origin,
    required Object? expansion,
    Object? order = 0,
    Object? alias,
    Object? options,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.grammar",
        "Rule",
        Rule.from,
        <Object?>[
          origin,
          expansion,
          order,
          alias,
          options,
        ],
        <String, Object?>{},
      );

  Rule.from(super.pythonClass) : super.from();

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
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## alias (getter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  Object? get alias => getAttribute("alias");

  /// ## alias (setter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  set alias(Object? alias) => setAttribute("alias", alias);

  /// ## expansion (getter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  Object? get expansion => getAttribute("expansion");

  /// ## expansion (setter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  set expansion(Object? expansion) => setAttribute("expansion", expansion);

  /// ## options (getter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  Object? get options => getAttribute("options");

  /// ## options (setter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  set options(Object? options) => setAttribute("options", options);

  /// ## order (getter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  Object? get order => getAttribute("order");

  /// ## order (setter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  set order(Object? order) => setAttribute("order", order);

  /// ## origin (getter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  Object? get origin => getAttribute("origin");

  /// ## origin (setter)
  ///
  /// ### python docstring
  ///
  /// origin : a symbol
  /// expansion : a list of symbols
  /// order : index of this expansion amongst all rules of the same name
  set origin(Object? origin) => setAttribute("origin", origin);
}

/// ## RuleOptions
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
///
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
///
/// ### python source
/// ```py
/// class RuleOptions(Serialize):
///     __serialize_fields__ = 'keep_all_tokens', 'expand1', 'priority', 'template_source', 'empty_indices'
///
///     keep_all_tokens: bool
///     expand1: bool
///     priority: Optional[int]
///     template_source: Optional[str]
///     empty_indices: Tuple[bool, ...]
///
///     def __init__(self, keep_all_tokens: bool=False, expand1: bool=False, priority: Optional[int]=None, template_source: Optional[str]=None, empty_indices: Tuple[bool, ...]=()) -> None:
///         self.keep_all_tokens = keep_all_tokens
///         self.expand1 = expand1
///         self.priority = priority
///         self.template_source = template_source
///         self.empty_indices = empty_indices
///
///     def __repr__(self):
///         return 'RuleOptions(%r, %r, %r, %r)' % (
///             self.keep_all_tokens,
///             self.expand1,
///             self.priority,
///             self.template_source
///         )
/// ```
final class RuleOptions extends PythonClass {
  factory RuleOptions({
    bool keep_all_tokens = false,
    bool expand1 = false,
    Object? priority,
    Object? template_source,
    Object? empty_indices = const [],
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.grammar",
        "RuleOptions",
        RuleOptions.from,
        <Object?>[
          keep_all_tokens,
          expand1,
          priority,
          template_source,
          empty_indices,
        ],
        <String, Object?>{},
      );

  RuleOptions.from(super.pythonClass) : super.from();

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
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## keep_all_tokens (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get keep_all_tokens => getAttribute("keep_all_tokens");

  /// ## keep_all_tokens (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set keep_all_tokens(Object? keep_all_tokens) =>
      setAttribute("keep_all_tokens", keep_all_tokens);

  /// ## expand1 (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get expand1 => getAttribute("expand1");

  /// ## expand1 (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set expand1(Object? expand1) => setAttribute("expand1", expand1);

  /// ## priority (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get priority => getAttribute("priority");

  /// ## priority (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set priority(Object? priority) => setAttribute("priority", priority);

  /// ## template_source (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get template_source => getAttribute("template_source");

  /// ## template_source (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set template_source(Object? template_source) =>
      setAttribute("template_source", template_source);

  /// ## empty_indices (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get empty_indices => getAttribute("empty_indices");

  /// ## empty_indices (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set empty_indices(Object? empty_indices) =>
      setAttribute("empty_indices", empty_indices);
}

/// ## RuleTreeToText
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
/// class RuleTreeToText(Transformer):
///     def expansions(self, x):
///         return x
///
///     def expansion(self, symbols):
///         return symbols, None
///
///     def alias(self, x):
///         (expansion, _alias), alias = x
///         assert _alias is None, (alias, expansion, '-', _alias)  # Double alias not allowed
///         return expansion, alias.name
/// ```
final class RuleTreeToText extends PythonClass {
  factory RuleTreeToText({
    bool visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "RuleTreeToText",
        RuleTreeToText.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  RuleTreeToText.from(super.pythonClass) : super.from();

  /// ## alias
  ///
  /// ### python source
  /// ```py
  /// def alias(self, x):
  ///         (expansion, _alias), alias = x
  ///         assert _alias is None, (alias, expansion, '-', _alias)  # Double alias not allowed
  ///         return expansion, alias.name
  /// ```
  Object? alias({
    required Object? x,
  }) =>
      getFunction("alias").call(
        <Object?>[
          x,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expansion
  ///
  /// ### python source
  /// ```py
  /// def expansion(self, symbols):
  ///         return symbols, None
  /// ```
  Object? expansion({
    required Object? symbols,
  }) =>
      getFunction("expansion").call(
        <Object?>[
          symbols,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expansions
  ///
  /// ### python source
  /// ```py
  /// def expansions(self, x):
  ///         return x
  /// ```
  Object? expansions({
    required Object? x,
  }) =>
      getFunction("expansions").call(
        <Object?>[
          x,
        ],
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
}

/// ## ST
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
/// class SlottedTree(Tree):
///     __slots__ = 'data', 'children', 'rule', '_meta'
/// ```
final class ST extends PythonClass {
  factory ST({
    required String data,
    required Object? children,
    Object? meta,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.tree",
        "ST",
        ST.from,
        <Object?>[
          data,
          children,
          meta,
        ],
        <String, Object?>{},
      );

  ST.from(super.pythonClass) : super.from();

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

  /// ## rule (getter)
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
  Object? get rule => getAttribute("rule");

  /// ## rule (setter)
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
  set rule(Object? rule) => setAttribute("rule", rule);

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
}

/// ## SimplifyRule_Visitor
///
/// ### python docstring
///
/// Tree visitor, non-recursive (can handle huge trees).
///
/// Visiting a node calls its methods (provided by the user via inheritance) according to ``tree.data``
///
/// ### python source
/// ```py
/// class SimplifyRule_Visitor(Visitor):
///
///     @staticmethod
///     def _flatten(tree):
///         while tree.expand_kids_by_data(tree.data):
///             pass
///
///     def expansion(self, tree):
///         # rules_list unpacking
///         # a : b (c|d) e
///         #  -->
///         # a : b c e | b d e
///         #
///         # In AST terms:
///         # expansion(b, expansions(c, d), e)
///         #   -->
///         # expansions( expansion(b, c, e), expansion(b, d, e) )
///
///         self._flatten(tree)
///
///         for i, child in enumerate(tree.children):
///             if isinstance(child, Tree) and child.data == 'expansions':
///                 tree.data = 'expansions'
///                 tree.children = [self.visit(ST('expansion', [option if i == j else other
///                                                              for j, other in enumerate(tree.children)]))
///                                  for option in dedup_list(child.children)]
///                 self._flatten(tree)
///                 break
///
///     def alias(self, tree):
///         rule, alias_name = tree.children
///         if rule.data == 'expansions':
///             aliases = []
///             for child in tree.children[0].children:
///                 aliases.append(ST('alias', [child, alias_name]))
///             tree.data = 'expansions'
///             tree.children = aliases
///
///     def expansions(self, tree):
///         self._flatten(tree)
///         # Ensure all children are unique
///         if len(set(tree.children)) != len(tree.children):
///             tree.children = dedup_list(tree.children)   # dedup is expensive, so try to minimize its use
/// ```
final class SimplifyRule_Visitor extends PythonClass {
  factory SimplifyRule_Visitor() => PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "SimplifyRule_Visitor",
        SimplifyRule_Visitor.from,
        <Object?>[],
      );

  SimplifyRule_Visitor.from(super.pythonClass) : super.from();

  /// ## alias
  ///
  /// ### python source
  /// ```py
  /// def alias(self, tree):
  ///         rule, alias_name = tree.children
  ///         if rule.data == 'expansions':
  ///             aliases = []
  ///             for child in tree.children[0].children:
  ///                 aliases.append(ST('alias', [child, alias_name]))
  ///             tree.data = 'expansions'
  ///             tree.children = aliases
  /// ```
  Object? alias({
    required Object? tree,
  }) =>
      getFunction("alias").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expansion
  ///
  /// ### python source
  /// ```py
  /// def expansion(self, tree):
  ///         # rules_list unpacking
  ///         # a : b (c|d) e
  ///         #  -->
  ///         # a : b c e | b d e
  ///         #
  ///         # In AST terms:
  ///         # expansion(b, expansions(c, d), e)
  ///         #   -->
  ///         # expansions( expansion(b, c, e), expansion(b, d, e) )
  ///
  ///         self._flatten(tree)
  ///
  ///         for i, child in enumerate(tree.children):
  ///             if isinstance(child, Tree) and child.data == 'expansions':
  ///                 tree.data = 'expansions'
  ///                 tree.children = [self.visit(ST('expansion', [option if i == j else other
  ///                                                              for j, other in enumerate(tree.children)]))
  ///                                  for option in dedup_list(child.children)]
  ///                 self._flatten(tree)
  ///                 break
  /// ```
  Object? expansion({
    required Object? tree,
  }) =>
      getFunction("expansion").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expansions
  ///
  /// ### python source
  /// ```py
  /// def expansions(self, tree):
  ///         self._flatten(tree)
  ///         # Ensure all children are unique
  ///         if len(set(tree.children)) != len(tree.children):
  ///             tree.children = dedup_list(tree.children)   # dedup is expensive, so try to minimize its use
  /// ```
  Object? expansions({
    required Object? tree,
  }) =>
      getFunction("expansions").call(
        <Object?>[
          tree,
        ],
        kwargs: <String, Object?>{},
      );

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

/// ## Symbol
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
///
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
///
/// ### python source
/// ```py
/// class Symbol(Serialize):
///     __slots__ = ('name',)
///
///     name: str
///     is_term: ClassVar[bool] = NotImplemented
///
///     def __init__(self, name: str) -> None:
///         self.name = name
///
///     def __eq__(self, other):
///         assert isinstance(other, Symbol), other
///         return self.is_term == other.is_term and self.name == other.name
///
///     def __ne__(self, other):
///         return not (self == other)
///
///     def __hash__(self):
///         return hash(self.name)
///
///     def __repr__(self):
///         return '%s(%r)' % (type(self).__name__, self.name)
///
///     fullrepr = property(__repr__)
///
///     def renamed(self, f):
///         return type(self)(f(self.name))
/// ```
final class $Symbol extends PythonClass {
  factory $Symbol({
    required String name,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.grammar",
        "Symbol",
        $Symbol.from,
        <Object?>[
          name,
        ],
        <String, Object?>{},
      );

  $Symbol.from(super.pythonClass) : super.from();

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

  /// ## renamed
  ///
  /// ### python source
  /// ```py
  /// def renamed(self, f):
  ///         return type(self)(f(self.name))
  /// ```
  Object? renamed({
    required Object? f,
  }) =>
      getFunction("renamed").call(
        <Object?>[
          f,
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

  /// ## fullrepr (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get fullrepr => getAttribute("fullrepr");

  /// ## fullrepr (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set fullrepr(Object? fullrepr) => setAttribute("fullrepr", fullrepr);

  /// ## is_term (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get is_term => getAttribute("is_term");

  /// ## is_term (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set is_term(Object? is_term) => setAttribute("is_term", is_term);

  /// ## deserialize (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## name (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get name => getAttribute("name");

  /// ## name (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set name(Object? name) => setAttribute("name", name);
}

/// ## Terminal
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
///
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
///
/// ### python source
/// ```py
/// class Terminal(Symbol):
///     __serialize_fields__ = 'name', 'filter_out'
///
///     is_term: ClassVar[bool] = True
///
///     def __init__(self, name, filter_out=False):
///         self.name = name
///         self.filter_out = filter_out
///
///     @property
///     def fullrepr(self):
///         return '%s(%r, %r)' % (type(self).__name__, self.name, self.filter_out)
///
///     def renamed(self, f):
///         return type(self)(f(self.name), self.filter_out)
/// ```
final class Terminal extends PythonClass {
  factory Terminal({
    required Object? name,
    Object? filter_out = false,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.grammar",
        "Terminal",
        Terminal.from,
        <Object?>[
          name,
          filter_out,
        ],
        <String, Object?>{},
      );

  Terminal.from(super.pythonClass) : super.from();

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

  /// ## renamed
  ///
  /// ### python source
  /// ```py
  /// def renamed(self, f):
  ///         return type(self)(f(self.name), self.filter_out)
  /// ```
  Object? renamed({
    required Object? f,
  }) =>
      getFunction("renamed").call(
        <Object?>[
          f,
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

  /// ## fullrepr (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get fullrepr => getAttribute("fullrepr");

  /// ## fullrepr (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set fullrepr(Object? fullrepr) => setAttribute("fullrepr", fullrepr);

  /// ## deserialize (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## is_term (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get is_term => getAttribute("is_term");

  /// ## is_term (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set is_term(Object? is_term) => setAttribute("is_term", is_term);

  /// ## name (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get name => getAttribute("name");

  /// ## name (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set name(Object? name) => setAttribute("name", name);

  /// ## filter_out (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get filter_out => getAttribute("filter_out");

  /// ## filter_out (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set filter_out(Object? filter_out) => setAttribute("filter_out", filter_out);
}

/// ## TerminalDef
///
/// ### python docstring
///
/// Safe-ish serialization interface that doesn't rely on Pickle
///
/// Attributes:
///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
///                                     Should include all field types that aren't builtin types.
///
/// ### python source
/// ```py
/// class TerminalDef(Serialize):
///     __serialize_fields__ = 'name', 'pattern', 'priority'
///     __serialize_namespace__ = PatternStr, PatternRE
///
///     name: str
///     pattern: Pattern
///     priority: int
///
///     def __init__(self, name: str, pattern: Pattern, priority: int = TOKEN_DEFAULT_PRIORITY) -> None:
///         assert isinstance(pattern, Pattern), pattern
///         self.name = name
///         self.pattern = pattern
///         self.priority = priority
///
///     def __repr__(self):
///         return '%s(%r, %r)' % (type(self).__name__, self.name, self.pattern)
///
///     def user_repr(self) -> str:
///         if self.name.startswith('__'):  # We represent a generated terminal
///             return self.pattern.raw or self.name
///         else:
///             return self.name
/// ```
final class TerminalDef extends PythonClass {
  factory TerminalDef({
    required String name,
    required Object? pattern,
    int priority = 0,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.lexer",
        "TerminalDef",
        TerminalDef.from,
        <Object?>[
          name,
          pattern,
          priority,
        ],
        <String, Object?>{},
      );

  TerminalDef.from(super.pythonClass) : super.from();

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

  /// ## user_repr
  ///
  /// ### python source
  /// ```py
  /// def user_repr(self) -> str:
  ///         if self.name.startswith('__'):  # We represent a generated terminal
  ///             return self.pattern.raw or self.name
  ///         else:
  ///             return self.name
  /// ```
  String user_repr() => getFunction("user_repr").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## deserialize (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get deserialize => getAttribute("deserialize");

  /// ## deserialize (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set deserialize(Object? deserialize) =>
      setAttribute("deserialize", deserialize);

  /// ## name (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get name => getAttribute("name");

  /// ## name (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set name(Object? name) => setAttribute("name", name);

  /// ## pattern (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get pattern => getAttribute("pattern");

  /// ## pattern (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set pattern(Object? pattern) => setAttribute("pattern", pattern);

  /// ## priority (getter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  Object? get priority => getAttribute("priority");

  /// ## priority (setter)
  ///
  /// ### python docstring
  ///
  /// Safe-ish serialization interface that doesn't rely on Pickle
  ///
  /// Attributes:
  ///     __serialize_fields__ (List[str]): Fields (aka attributes) to serialize.
  ///     __serialize_namespace__ (list): List of classes that deserialization is allowed to instantiate.
  ///                                     Should include all field types that aren't builtin types.
  set priority(Object? priority) => setAttribute("priority", priority);
}

/// ## TerminalTreeToPattern
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
/// class TerminalTreeToPattern(Transformer_NonRecursive):
///     def pattern(self, ps):
///         p ,= ps
///         return p
///
///     def expansion(self, items):
///         assert items
///         if len(items) == 1:
///             return items[0]
///
///         pattern = ''.join(i.to_regexp() for i in items)
///         return _make_joined_pattern(pattern, {i.flags for i in items})
///
///     def expansions(self, exps):
///         if len(exps) == 1:
///             return exps[0]
///
///         # Do a bit of sorting to make sure that the longest option is returned
///         # (Python's re module otherwise prefers just 'l' when given (l|ll) and both could match)
///         exps.sort(key=lambda x: (-x.max_width, -x.min_width, -len(x.value)))
///
///         pattern = '(?:%s)' % ('|'.join(i.to_regexp() for i in exps))
///         return _make_joined_pattern(pattern, {i.flags for i in exps})
///
///     def expr(self, args):
///         inner, op = args[:2]
///         if op == '~':
///             if len(args) == 3:
///                 op = "{%d}" % int(args[2])
///             else:
///                 mn, mx = map(int, args[2:])
///                 if mx < mn:
///                     raise GrammarError("Bad Range for %s (%d..%d isn't allowed)" % (inner, mn, mx))
///                 op = "{%d,%d}" % (mn, mx)
///         else:
///             assert len(args) == 2
///         return PatternRE('(?:%s)%s' % (inner.to_regexp(), op), inner.flags)
///
///     def maybe(self, expr):
///         return self.expr(expr + ['?'])
///
///     def alias(self, t):
///         raise GrammarError("Aliasing not allowed in terminals (You used -> in the wrong place)")
///
///     def value(self, v):
///         return v[0]
/// ```
final class TerminalTreeToPattern extends PythonClass {
  factory TerminalTreeToPattern({
    bool visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "TerminalTreeToPattern",
        TerminalTreeToPattern.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  TerminalTreeToPattern.from(super.pythonClass) : super.from();

  /// ## alias
  ///
  /// ### python source
  /// ```py
  /// def alias(self, t):
  ///         raise GrammarError("Aliasing not allowed in terminals (You used -> in the wrong place)")
  /// ```
  Object? alias({
    required Object? t,
  }) =>
      getFunction("alias").call(
        <Object?>[
          t,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expansion
  ///
  /// ### python source
  /// ```py
  /// def expansion(self, items):
  ///         assert items
  ///         if len(items) == 1:
  ///             return items[0]
  ///
  ///         pattern = ''.join(i.to_regexp() for i in items)
  ///         return _make_joined_pattern(pattern, {i.flags for i in items})
  /// ```
  Object? expansion({
    required Object? items,
  }) =>
      getFunction("expansion").call(
        <Object?>[
          items,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expansions
  ///
  /// ### python source
  /// ```py
  /// def expansions(self, exps):
  ///         if len(exps) == 1:
  ///             return exps[0]
  ///
  ///         # Do a bit of sorting to make sure that the longest option is returned
  ///         # (Python's re module otherwise prefers just 'l' when given (l|ll) and both could match)
  ///         exps.sort(key=lambda x: (-x.max_width, -x.min_width, -len(x.value)))
  ///
  ///         pattern = '(?:%s)' % ('|'.join(i.to_regexp() for i in exps))
  ///         return _make_joined_pattern(pattern, {i.flags for i in exps})
  /// ```
  Object? expansions({
    required Object? exps,
  }) =>
      getFunction("expansions").call(
        <Object?>[
          exps,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## expr
  ///
  /// ### python source
  /// ```py
  /// def expr(self, args):
  ///         inner, op = args[:2]
  ///         if op == '~':
  ///             if len(args) == 3:
  ///                 op = "{%d}" % int(args[2])
  ///             else:
  ///                 mn, mx = map(int, args[2:])
  ///                 if mx < mn:
  ///                     raise GrammarError("Bad Range for %s (%d..%d isn't allowed)" % (inner, mn, mx))
  ///                 op = "{%d,%d}" % (mn, mx)
  ///         else:
  ///             assert len(args) == 2
  ///         return PatternRE('(?:%s)%s' % (inner.to_regexp(), op), inner.flags)
  /// ```
  Object? expr({
    required Object? args,
  }) =>
      getFunction("expr").call(
        <Object?>[
          args,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## maybe
  ///
  /// ### python source
  /// ```py
  /// def maybe(self, expr):
  ///         return self.expr(expr + ['?'])
  /// ```
  Object? maybe({
    required Object? expr,
  }) =>
      getFunction("maybe").call(
        <Object?>[
          expr,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## pattern
  ///
  /// ### python source
  /// ```py
  /// def pattern(self, ps):
  ///         p ,= ps
  ///         return p
  /// ```
  Object? pattern({
    required Object? ps,
  }) =>
      getFunction("pattern").call(
        <Object?>[
          ps,
        ],
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

  /// ## value
  ///
  /// ### python source
  /// ```py
  /// def value(self, v):
  ///         return v[0]
  /// ```
  Object? value({
    required Object? v,
  }) =>
      getFunction("value").call(
        <Object?>[
          v,
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

/// ## UnexpectedCharacters
///
/// ### python docstring
///
/// An exception that is raised by the lexer, when it cannot match the next
/// string of characters to any of its terminals.
///
/// ### python source
/// ```py
/// class UnexpectedCharacters(LexError, UnexpectedInput):
///     """An exception that is raised by the lexer, when it cannot match the next
///     string of characters to any of its terminals.
///     """
///
///     allowed: Set[str]
///     considered_tokens: Set[Any]
///
///     def __init__(self, seq, lex_pos, line, column, allowed=None, considered_tokens=None, state=None, token_history=None,
///                  terminals_by_name=None, considered_rules=None):
///         super(UnexpectedCharacters, self).__init__()
///
///         # TODO considered_tokens and allowed can be figured out using state
///         self.line = line
///         self.column = column
///         self.pos_in_stream = lex_pos
///         self.state = state
///         self._terminals_by_name = terminals_by_name
///
///         self.allowed = allowed
///         self.considered_tokens = considered_tokens
///         self.considered_rules = considered_rules
///         self.token_history = token_history
///
///         if isinstance(seq, bytes):
///             self.char = seq[lex_pos:lex_pos + 1].decode("ascii", "backslashreplace")
///         else:
///             self.char = seq[lex_pos]
///         self._context = self.get_context(seq)
///
///
///     def __str__(self):
///         message = "No terminal matches '%s' in the current parser context, at line %d col %d" % (self.char, self.line, self.column)
///         message += '\n\n' + self._context
///         if self.allowed:
///             message += self._format_expected(self.allowed)
///         if self.token_history:
///             message += '\nPrevious tokens: %s\n' % ', '.join(repr(t) for t in self.token_history)
///         return message
/// ```
final class UnexpectedCharacters extends PythonClass {
  factory UnexpectedCharacters({
    required Object? seq,
    required Object? lex_pos,
    required Object? line,
    required Object? column,
    Object? allowed,
    Object? considered_tokens,
    Object? state,
    Object? token_history,
    Object? terminals_by_name,
    Object? considered_rules,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "UnexpectedCharacters",
        UnexpectedCharacters.from,
        <Object?>[
          seq,
          lex_pos,
          line,
          column,
          allowed,
          considered_tokens,
          state,
          token_history,
          terminals_by_name,
          considered_rules,
        ],
        <String, Object?>{},
      );

  UnexpectedCharacters.from(super.pythonClass) : super.from();

  /// ## get_context
  ///
  /// ### python docstring
  ///
  /// Returns a pretty string pinpointing the error in the text,
  /// with span amount of context characters around it.
  ///
  /// Note:
  ///     The parser doesn't hold a copy of the text it has to parse,
  ///     so you have to provide it again
  ///
  /// ### python source
  /// ```py
  /// def get_context(self, text: str, span: int=40) -> str:
  ///         """Returns a pretty string pinpointing the error in the text,
  ///         with span amount of context characters around it.
  ///
  ///         Note:
  ///             The parser doesn't hold a copy of the text it has to parse,
  ///             so you have to provide it again
  ///         """
  ///         assert self.pos_in_stream is not None, self
  ///         pos = self.pos_in_stream
  ///         start = max(pos - span, 0)
  ///         end = pos + span
  ///         if not isinstance(text, bytes):
  ///             before = text[start:pos].rsplit('\n', 1)[-1]
  ///             after = text[pos:end].split('\n', 1)[0]
  ///             return before + after + '\n' + ' ' * len(before.expandtabs()) + '^\n'
  ///         else:
  ///             before = text[start:pos].rsplit(b'\n', 1)[-1]
  ///             after = text[pos:end].split(b'\n', 1)[0]
  ///             return (before + after + b'\n' + b' ' * len(before.expandtabs()) + b'^\n').decode("ascii", "backslashreplace")
  /// ```
  String get_context({
    required String text,
    int span = 40,
  }) =>
      getFunction("get_context").call(
        <Object?>[
          text,
          span,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## match_examples
  ///
  /// ### python docstring
  ///
  /// Allows you to detect what's wrong in the input text by matching
  /// against example errors.
  ///
  /// Given a parser instance and a dictionary mapping some label with
  /// some malformed syntax examples, it'll return the label for the
  /// example that bests matches the current error. The function will
  /// iterate the dictionary until it finds a matching error, and
  /// return the corresponding value.
  ///
  /// For an example usage, see `examples/error_reporting_lalr.py`
  ///
  /// Parameters:
  ///     parse_fn: parse function (usually ``lark_instance.parse``)
  ///     examples: dictionary of ``{'example_string': value}``.
  ///     use_accepts: Recommended to keep this as ``use_accepts=True``.
  ///
  /// ### python source
  /// ```py
  /// def match_examples(self, parse_fn: 'Callable[[str], Tree]',
  ///                              examples: Union[Mapping[T, Iterable[str]], Iterable[Tuple[T, Iterable[str]]]],
  ///                              token_type_match_fallback: bool=False,
  ///                              use_accepts: bool=True
  ///                          ) -> Optional[T]:
  ///         """Allows you to detect what's wrong in the input text by matching
  ///         against example errors.
  ///
  ///         Given a parser instance and a dictionary mapping some label with
  ///         some malformed syntax examples, it'll return the label for the
  ///         example that bests matches the current error. The function will
  ///         iterate the dictionary until it finds a matching error, and
  ///         return the corresponding value.
  ///
  ///         For an example usage, see `examples/error_reporting_lalr.py`
  ///
  ///         Parameters:
  ///             parse_fn: parse function (usually ``lark_instance.parse``)
  ///             examples: dictionary of ``{'example_string': value}``.
  ///             use_accepts: Recommended to keep this as ``use_accepts=True``.
  ///         """
  ///         assert self.state is not None, "Not supported for this exception"
  ///
  ///         if isinstance(examples, Mapping):
  ///             examples = examples.items()
  ///
  ///         candidate = (None, False)
  ///         for i, (label, example) in enumerate(examples):
  ///             assert not isinstance(example, str), "Expecting a list"
  ///
  ///             for j, malformed in enumerate(example):
  ///                 try:
  ///                     parse_fn(malformed)
  ///                 except UnexpectedInput as ut:
  ///                     if ut.state == self.state:
  ///                         if (
  ///                             use_accepts
  ///                             and isinstance(self, UnexpectedToken)
  ///                             and isinstance(ut, UnexpectedToken)
  ///                             and ut.accepts != self.accepts
  ///                         ):
  ///                             logger.debug("Different accepts with same state[%d]: %s != %s at example [%s][%s]" %
  ///                                          (self.state, self.accepts, ut.accepts, i, j))
  ///                             continue
  ///                         if (
  ///                             isinstance(self, (UnexpectedToken, UnexpectedEOF))
  ///                             and isinstance(ut, (UnexpectedToken, UnexpectedEOF))
  ///                         ):
  ///                             if ut.token == self.token:  # Try exact match first
  ///                                 logger.debug("Exact Match at example [%s][%s]" % (i, j))
  ///                                 return label
  ///
  ///                             if token_type_match_fallback:
  ///                                 # Fallback to token types match
  ///                                 if (ut.token.type == self.token.type) and not candidate[-1]:
  ///                                     logger.debug("Token Type Fallback at example [%s][%s]" % (i, j))
  ///                                     candidate = label, True
  ///
  ///                         if candidate[0] is None:
  ///                             logger.debug("Same State match at example [%s][%s]" % (i, j))
  ///                             candidate = label, False
  ///
  ///         return candidate[0]
  /// ```
  Object? match_examples({
    required Object? parse_fn,
    required Object? examples,
    bool token_type_match_fallback = false,
    bool use_accepts = true,
  }) =>
      getFunction("match_examples").call(
        <Object?>[
          parse_fn,
          examples,
          token_type_match_fallback,
          use_accepts,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);

  /// ## pos_in_stream (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get pos_in_stream => getAttribute("pos_in_stream");

  /// ## pos_in_stream (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set pos_in_stream(Object? pos_in_stream) =>
      setAttribute("pos_in_stream", pos_in_stream);

  /// ## line (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get line => getAttribute("line");

  /// ## line (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set line(Object? line) => setAttribute("line", line);

  /// ## column (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get column => getAttribute("column");

  /// ## column (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set column(Object? column) => setAttribute("column", column);

  /// ## state (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get state => getAttribute("state");

  /// ## state (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set state(Object? state) => setAttribute("state", state);

  /// ## allowed (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get allowed => getAttribute("allowed");

  /// ## allowed (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set allowed(Object? allowed) => setAttribute("allowed", allowed);

  /// ## considered_tokens (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get considered_tokens => getAttribute("considered_tokens");

  /// ## considered_tokens (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set considered_tokens(Object? considered_tokens) =>
      setAttribute("considered_tokens", considered_tokens);

  /// ## considered_rules (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get considered_rules => getAttribute("considered_rules");

  /// ## considered_rules (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set considered_rules(Object? considered_rules) =>
      setAttribute("considered_rules", considered_rules);

  /// ## token_history (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get token_history => getAttribute("token_history");

  /// ## token_history (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set token_history(Object? token_history) =>
      setAttribute("token_history", token_history);

  /// ## char (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  Object? get char => getAttribute("char");

  /// ## char (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the lexer, when it cannot match the next
  /// string of characters to any of its terminals.
  set char(Object? char) => setAttribute("char", char);
}

/// ## UnexpectedInput
///
/// ### python docstring
///
/// UnexpectedInput Error.
///
/// Used as a base class for the following exceptions:
///
/// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
/// - ``UnexpectedToken``: The parser received an unexpected token
/// - ``UnexpectedEOF``: The parser expected a token, but the input ended
///
/// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
///
/// ### python source
/// ```py
/// class UnexpectedInput(LarkError):
///     """UnexpectedInput Error.
///
///     Used as a base class for the following exceptions:
///
///     - ``UnexpectedCharacters``: The lexer encountered an unexpected string
///     - ``UnexpectedToken``: The parser received an unexpected token
///     - ``UnexpectedEOF``: The parser expected a token, but the input ended
///
///     After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
///     """
///     line: int
///     column: int
///     pos_in_stream = None
///     state: Any
///     _terminals_by_name = None
///
///     def get_context(self, text: str, span: int=40) -> str:
///         """Returns a pretty string pinpointing the error in the text,
///         with span amount of context characters around it.
///
///         Note:
///             The parser doesn't hold a copy of the text it has to parse,
///             so you have to provide it again
///         """
///         assert self.pos_in_stream is not None, self
///         pos = self.pos_in_stream
///         start = max(pos - span, 0)
///         end = pos + span
///         if not isinstance(text, bytes):
///             before = text[start:pos].rsplit('\n', 1)[-1]
///             after = text[pos:end].split('\n', 1)[0]
///             return before + after + '\n' + ' ' * len(before.expandtabs()) + '^\n'
///         else:
///             before = text[start:pos].rsplit(b'\n', 1)[-1]
///             after = text[pos:end].split(b'\n', 1)[0]
///             return (before + after + b'\n' + b' ' * len(before.expandtabs()) + b'^\n').decode("ascii", "backslashreplace")
///
///     def match_examples(self, parse_fn: 'Callable[[str], Tree]',
///                              examples: Union[Mapping[T, Iterable[str]], Iterable[Tuple[T, Iterable[str]]]],
///                              token_type_match_fallback: bool=False,
///                              use_accepts: bool=True
///                          ) -> Optional[T]:
///         """Allows you to detect what's wrong in the input text by matching
///         against example errors.
///
///         Given a parser instance and a dictionary mapping some label with
///         some malformed syntax examples, it'll return the label for the
///         example that bests matches the current error. The function will
///         iterate the dictionary until it finds a matching error, and
///         return the corresponding value.
///
///         For an example usage, see `examples/error_reporting_lalr.py`
///
///         Parameters:
///             parse_fn: parse function (usually ``lark_instance.parse``)
///             examples: dictionary of ``{'example_string': value}``.
///             use_accepts: Recommended to keep this as ``use_accepts=True``.
///         """
///         assert self.state is not None, "Not supported for this exception"
///
///         if isinstance(examples, Mapping):
///             examples = examples.items()
///
///         candidate = (None, False)
///         for i, (label, example) in enumerate(examples):
///             assert not isinstance(example, str), "Expecting a list"
///
///             for j, malformed in enumerate(example):
///                 try:
///                     parse_fn(malformed)
///                 except UnexpectedInput as ut:
///                     if ut.state == self.state:
///                         if (
///                             use_accepts
///                             and isinstance(self, UnexpectedToken)
///                             and isinstance(ut, UnexpectedToken)
///                             and ut.accepts != self.accepts
///                         ):
///                             logger.debug("Different accepts with same state[%d]: %s != %s at example [%s][%s]" %
///                                          (self.state, self.accepts, ut.accepts, i, j))
///                             continue
///                         if (
///                             isinstance(self, (UnexpectedToken, UnexpectedEOF))
///                             and isinstance(ut, (UnexpectedToken, UnexpectedEOF))
///                         ):
///                             if ut.token == self.token:  # Try exact match first
///                                 logger.debug("Exact Match at example [%s][%s]" % (i, j))
///                                 return label
///
///                             if token_type_match_fallback:
///                                 # Fallback to token types match
///                                 if (ut.token.type == self.token.type) and not candidate[-1]:
///                                     logger.debug("Token Type Fallback at example [%s][%s]" % (i, j))
///                                     candidate = label, True
///
///                         if candidate[0] is None:
///                             logger.debug("Same State match at example [%s][%s]" % (i, j))
///                             candidate = label, False
///
///         return candidate[0]
///
///     def _format_expected(self, expected):
///         if self._terminals_by_name:
///             d = self._terminals_by_name
///             expected = [d[t_name].user_repr() if t_name in d else t_name for t_name in expected]
///         return "Expected one of: \n\t* %s\n" % '\n\t* '.join(expected)
/// ```
final class UnexpectedInput extends PythonClass {
  factory UnexpectedInput() => PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "UnexpectedInput",
        UnexpectedInput.from,
        <Object?>[],
      );

  UnexpectedInput.from(super.pythonClass) : super.from();

  /// ## get_context
  ///
  /// ### python docstring
  ///
  /// Returns a pretty string pinpointing the error in the text,
  /// with span amount of context characters around it.
  ///
  /// Note:
  ///     The parser doesn't hold a copy of the text it has to parse,
  ///     so you have to provide it again
  ///
  /// ### python source
  /// ```py
  /// def get_context(self, text: str, span: int=40) -> str:
  ///         """Returns a pretty string pinpointing the error in the text,
  ///         with span amount of context characters around it.
  ///
  ///         Note:
  ///             The parser doesn't hold a copy of the text it has to parse,
  ///             so you have to provide it again
  ///         """
  ///         assert self.pos_in_stream is not None, self
  ///         pos = self.pos_in_stream
  ///         start = max(pos - span, 0)
  ///         end = pos + span
  ///         if not isinstance(text, bytes):
  ///             before = text[start:pos].rsplit('\n', 1)[-1]
  ///             after = text[pos:end].split('\n', 1)[0]
  ///             return before + after + '\n' + ' ' * len(before.expandtabs()) + '^\n'
  ///         else:
  ///             before = text[start:pos].rsplit(b'\n', 1)[-1]
  ///             after = text[pos:end].split(b'\n', 1)[0]
  ///             return (before + after + b'\n' + b' ' * len(before.expandtabs()) + b'^\n').decode("ascii", "backslashreplace")
  /// ```
  String get_context({
    required String text,
    int span = 40,
  }) =>
      getFunction("get_context").call(
        <Object?>[
          text,
          span,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## match_examples
  ///
  /// ### python docstring
  ///
  /// Allows you to detect what's wrong in the input text by matching
  /// against example errors.
  ///
  /// Given a parser instance and a dictionary mapping some label with
  /// some malformed syntax examples, it'll return the label for the
  /// example that bests matches the current error. The function will
  /// iterate the dictionary until it finds a matching error, and
  /// return the corresponding value.
  ///
  /// For an example usage, see `examples/error_reporting_lalr.py`
  ///
  /// Parameters:
  ///     parse_fn: parse function (usually ``lark_instance.parse``)
  ///     examples: dictionary of ``{'example_string': value}``.
  ///     use_accepts: Recommended to keep this as ``use_accepts=True``.
  ///
  /// ### python source
  /// ```py
  /// def match_examples(self, parse_fn: 'Callable[[str], Tree]',
  ///                              examples: Union[Mapping[T, Iterable[str]], Iterable[Tuple[T, Iterable[str]]]],
  ///                              token_type_match_fallback: bool=False,
  ///                              use_accepts: bool=True
  ///                          ) -> Optional[T]:
  ///         """Allows you to detect what's wrong in the input text by matching
  ///         against example errors.
  ///
  ///         Given a parser instance and a dictionary mapping some label with
  ///         some malformed syntax examples, it'll return the label for the
  ///         example that bests matches the current error. The function will
  ///         iterate the dictionary until it finds a matching error, and
  ///         return the corresponding value.
  ///
  ///         For an example usage, see `examples/error_reporting_lalr.py`
  ///
  ///         Parameters:
  ///             parse_fn: parse function (usually ``lark_instance.parse``)
  ///             examples: dictionary of ``{'example_string': value}``.
  ///             use_accepts: Recommended to keep this as ``use_accepts=True``.
  ///         """
  ///         assert self.state is not None, "Not supported for this exception"
  ///
  ///         if isinstance(examples, Mapping):
  ///             examples = examples.items()
  ///
  ///         candidate = (None, False)
  ///         for i, (label, example) in enumerate(examples):
  ///             assert not isinstance(example, str), "Expecting a list"
  ///
  ///             for j, malformed in enumerate(example):
  ///                 try:
  ///                     parse_fn(malformed)
  ///                 except UnexpectedInput as ut:
  ///                     if ut.state == self.state:
  ///                         if (
  ///                             use_accepts
  ///                             and isinstance(self, UnexpectedToken)
  ///                             and isinstance(ut, UnexpectedToken)
  ///                             and ut.accepts != self.accepts
  ///                         ):
  ///                             logger.debug("Different accepts with same state[%d]: %s != %s at example [%s][%s]" %
  ///                                          (self.state, self.accepts, ut.accepts, i, j))
  ///                             continue
  ///                         if (
  ///                             isinstance(self, (UnexpectedToken, UnexpectedEOF))
  ///                             and isinstance(ut, (UnexpectedToken, UnexpectedEOF))
  ///                         ):
  ///                             if ut.token == self.token:  # Try exact match first
  ///                                 logger.debug("Exact Match at example [%s][%s]" % (i, j))
  ///                                 return label
  ///
  ///                             if token_type_match_fallback:
  ///                                 # Fallback to token types match
  ///                                 if (ut.token.type == self.token.type) and not candidate[-1]:
  ///                                     logger.debug("Token Type Fallback at example [%s][%s]" % (i, j))
  ///                                     candidate = label, True
  ///
  ///                         if candidate[0] is None:
  ///                             logger.debug("Same State match at example [%s][%s]" % (i, j))
  ///                             candidate = label, False
  ///
  ///         return candidate[0]
  /// ```
  Object? match_examples({
    required Object? parse_fn,
    required Object? examples,
    bool token_type_match_fallback = false,
    bool use_accepts = true,
  }) =>
      getFunction("match_examples").call(
        <Object?>[
          parse_fn,
          examples,
          token_type_match_fallback,
          use_accepts,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// UnexpectedInput Error.
  ///
  /// Used as a base class for the following exceptions:
  ///
  /// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
  /// - ``UnexpectedToken``: The parser received an unexpected token
  /// - ``UnexpectedEOF``: The parser expected a token, but the input ended
  ///
  /// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// UnexpectedInput Error.
  ///
  /// Used as a base class for the following exceptions:
  ///
  /// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
  /// - ``UnexpectedToken``: The parser received an unexpected token
  /// - ``UnexpectedEOF``: The parser expected a token, but the input ended
  ///
  /// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// UnexpectedInput Error.
  ///
  /// Used as a base class for the following exceptions:
  ///
  /// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
  /// - ``UnexpectedToken``: The parser received an unexpected token
  /// - ``UnexpectedEOF``: The parser expected a token, but the input ended
  ///
  /// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// UnexpectedInput Error.
  ///
  /// Used as a base class for the following exceptions:
  ///
  /// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
  /// - ``UnexpectedToken``: The parser received an unexpected token
  /// - ``UnexpectedEOF``: The parser expected a token, but the input ended
  ///
  /// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// UnexpectedInput Error.
  ///
  /// Used as a base class for the following exceptions:
  ///
  /// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
  /// - ``UnexpectedToken``: The parser received an unexpected token
  /// - ``UnexpectedEOF``: The parser expected a token, but the input ended
  ///
  /// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// UnexpectedInput Error.
  ///
  /// Used as a base class for the following exceptions:
  ///
  /// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
  /// - ``UnexpectedToken``: The parser received an unexpected token
  /// - ``UnexpectedEOF``: The parser expected a token, but the input ended
  ///
  /// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);

  /// ## pos_in_stream (getter)
  ///
  /// ### python docstring
  ///
  /// UnexpectedInput Error.
  ///
  /// Used as a base class for the following exceptions:
  ///
  /// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
  /// - ``UnexpectedToken``: The parser received an unexpected token
  /// - ``UnexpectedEOF``: The parser expected a token, but the input ended
  ///
  /// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
  Null get pos_in_stream => getAttribute("pos_in_stream");

  /// ## pos_in_stream (setter)
  ///
  /// ### python docstring
  ///
  /// UnexpectedInput Error.
  ///
  /// Used as a base class for the following exceptions:
  ///
  /// - ``UnexpectedCharacters``: The lexer encountered an unexpected string
  /// - ``UnexpectedToken``: The parser received an unexpected token
  /// - ``UnexpectedEOF``: The parser expected a token, but the input ended
  ///
  /// After catching one of these exceptions, you may call the following helper methods to create a nicer error message.
  set pos_in_stream(Null pos_in_stream) =>
      setAttribute("pos_in_stream", pos_in_stream);
}

/// ## UnexpectedToken
///
/// ### python docstring
///
/// An exception that is raised by the parser, when the token it received
/// doesn't match any valid step forward.
///
/// Parameters:
///     token: The mismatched token
///     expected: The set of expected tokens
///     considered_rules: Which rules were considered, to deduce the expected tokens
///     state: A value representing the parser state. Do not rely on its value or type.
///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
///                         and can be used for debugging and error handling.
///
/// Note: These parameters are available as attributes of the instance.
///
/// ### python source
/// ```py
/// class UnexpectedToken(ParseError, UnexpectedInput):
///     """An exception that is raised by the parser, when the token it received
///     doesn't match any valid step forward.
///
///     Parameters:
///         token: The mismatched token
///         expected: The set of expected tokens
///         considered_rules: Which rules were considered, to deduce the expected tokens
///         state: A value representing the parser state. Do not rely on its value or type.
///         interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
///                             and can be used for debugging and error handling.
///
///     Note: These parameters are available as attributes of the instance.
///     """
///
///     expected: Set[str]
///     considered_rules: Set[str]
///     interactive_parser: 'InteractiveParser'
///
///     def __init__(self, token, expected, considered_rules=None, state=None, interactive_parser=None, terminals_by_name=None, token_history=None):
///         super(UnexpectedToken, self).__init__()
///
///         # TODO considered_rules and expected can be figured out using state
///         self.line = getattr(token, 'line', '?')
///         self.column = getattr(token, 'column', '?')
///         self.pos_in_stream = getattr(token, 'start_pos', None)
///         self.state = state
///
///         self.token = token
///         self.expected = expected  # XXX deprecate? `accepts` is better
///         self._accepts = NO_VALUE
///         self.considered_rules = considered_rules
///         self.interactive_parser = interactive_parser
///         self._terminals_by_name = terminals_by_name
///         self.token_history = token_history
///
///
///     @property
///     def accepts(self) -> Set[str]:
///         if self._accepts is NO_VALUE:
///             self._accepts = self.interactive_parser and self.interactive_parser.accepts()
///         return self._accepts
///
///     def __str__(self):
///         message = ("Unexpected token %r at line %s, column %s.\n%s"
///                    % (self.token, self.line, self.column, self._format_expected(self.accepts or self.expected)))
///         if self.token_history:
///             message += "Previous tokens: %r\n" % self.token_history
///
///         return message
/// ```
final class UnexpectedToken extends PythonClass {
  factory UnexpectedToken({
    required Object? token,
    required Object? expected,
    Object? considered_rules,
    Object? state,
    Object? interactive_parser,
    Object? terminals_by_name,
    Object? token_history,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.exceptions",
        "UnexpectedToken",
        UnexpectedToken.from,
        <Object?>[
          token,
          expected,
          considered_rules,
          state,
          interactive_parser,
          terminals_by_name,
          token_history,
        ],
        <String, Object?>{},
      );

  UnexpectedToken.from(super.pythonClass) : super.from();

  /// ## get_context
  ///
  /// ### python docstring
  ///
  /// Returns a pretty string pinpointing the error in the text,
  /// with span amount of context characters around it.
  ///
  /// Note:
  ///     The parser doesn't hold a copy of the text it has to parse,
  ///     so you have to provide it again
  ///
  /// ### python source
  /// ```py
  /// def get_context(self, text: str, span: int=40) -> str:
  ///         """Returns a pretty string pinpointing the error in the text,
  ///         with span amount of context characters around it.
  ///
  ///         Note:
  ///             The parser doesn't hold a copy of the text it has to parse,
  ///             so you have to provide it again
  ///         """
  ///         assert self.pos_in_stream is not None, self
  ///         pos = self.pos_in_stream
  ///         start = max(pos - span, 0)
  ///         end = pos + span
  ///         if not isinstance(text, bytes):
  ///             before = text[start:pos].rsplit('\n', 1)[-1]
  ///             after = text[pos:end].split('\n', 1)[0]
  ///             return before + after + '\n' + ' ' * len(before.expandtabs()) + '^\n'
  ///         else:
  ///             before = text[start:pos].rsplit(b'\n', 1)[-1]
  ///             after = text[pos:end].split(b'\n', 1)[0]
  ///             return (before + after + b'\n' + b' ' * len(before.expandtabs()) + b'^\n').decode("ascii", "backslashreplace")
  /// ```
  String get_context({
    required String text,
    int span = 40,
  }) =>
      getFunction("get_context").call(
        <Object?>[
          text,
          span,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## match_examples
  ///
  /// ### python docstring
  ///
  /// Allows you to detect what's wrong in the input text by matching
  /// against example errors.
  ///
  /// Given a parser instance and a dictionary mapping some label with
  /// some malformed syntax examples, it'll return the label for the
  /// example that bests matches the current error. The function will
  /// iterate the dictionary until it finds a matching error, and
  /// return the corresponding value.
  ///
  /// For an example usage, see `examples/error_reporting_lalr.py`
  ///
  /// Parameters:
  ///     parse_fn: parse function (usually ``lark_instance.parse``)
  ///     examples: dictionary of ``{'example_string': value}``.
  ///     use_accepts: Recommended to keep this as ``use_accepts=True``.
  ///
  /// ### python source
  /// ```py
  /// def match_examples(self, parse_fn: 'Callable[[str], Tree]',
  ///                              examples: Union[Mapping[T, Iterable[str]], Iterable[Tuple[T, Iterable[str]]]],
  ///                              token_type_match_fallback: bool=False,
  ///                              use_accepts: bool=True
  ///                          ) -> Optional[T]:
  ///         """Allows you to detect what's wrong in the input text by matching
  ///         against example errors.
  ///
  ///         Given a parser instance and a dictionary mapping some label with
  ///         some malformed syntax examples, it'll return the label for the
  ///         example that bests matches the current error. The function will
  ///         iterate the dictionary until it finds a matching error, and
  ///         return the corresponding value.
  ///
  ///         For an example usage, see `examples/error_reporting_lalr.py`
  ///
  ///         Parameters:
  ///             parse_fn: parse function (usually ``lark_instance.parse``)
  ///             examples: dictionary of ``{'example_string': value}``.
  ///             use_accepts: Recommended to keep this as ``use_accepts=True``.
  ///         """
  ///         assert self.state is not None, "Not supported for this exception"
  ///
  ///         if isinstance(examples, Mapping):
  ///             examples = examples.items()
  ///
  ///         candidate = (None, False)
  ///         for i, (label, example) in enumerate(examples):
  ///             assert not isinstance(example, str), "Expecting a list"
  ///
  ///             for j, malformed in enumerate(example):
  ///                 try:
  ///                     parse_fn(malformed)
  ///                 except UnexpectedInput as ut:
  ///                     if ut.state == self.state:
  ///                         if (
  ///                             use_accepts
  ///                             and isinstance(self, UnexpectedToken)
  ///                             and isinstance(ut, UnexpectedToken)
  ///                             and ut.accepts != self.accepts
  ///                         ):
  ///                             logger.debug("Different accepts with same state[%d]: %s != %s at example [%s][%s]" %
  ///                                          (self.state, self.accepts, ut.accepts, i, j))
  ///                             continue
  ///                         if (
  ///                             isinstance(self, (UnexpectedToken, UnexpectedEOF))
  ///                             and isinstance(ut, (UnexpectedToken, UnexpectedEOF))
  ///                         ):
  ///                             if ut.token == self.token:  # Try exact match first
  ///                                 logger.debug("Exact Match at example [%s][%s]" % (i, j))
  ///                                 return label
  ///
  ///                             if token_type_match_fallback:
  ///                                 # Fallback to token types match
  ///                                 if (ut.token.type == self.token.type) and not candidate[-1]:
  ///                                     logger.debug("Token Type Fallback at example [%s][%s]" % (i, j))
  ///                                     candidate = label, True
  ///
  ///                         if candidate[0] is None:
  ///                             logger.debug("Same State match at example [%s][%s]" % (i, j))
  ///                             candidate = label, False
  ///
  ///         return candidate[0]
  /// ```
  Object? match_examples({
    required Object? parse_fn,
    required Object? examples,
    bool token_type_match_fallback = false,
    bool use_accepts = true,
  }) =>
      getFunction("match_examples").call(
        <Object?>[
          parse_fn,
          examples,
          token_type_match_fallback,
          use_accepts,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## accepts (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get accepts => getAttribute("accepts");

  /// ## accepts (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set accepts(Object? accepts) => setAttribute("accepts", accepts);

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);

  /// ## pos_in_stream (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get pos_in_stream => getAttribute("pos_in_stream");

  /// ## pos_in_stream (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set pos_in_stream(Object? pos_in_stream) =>
      setAttribute("pos_in_stream", pos_in_stream);

  /// ## line (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get line => getAttribute("line");

  /// ## line (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set line(Object? line) => setAttribute("line", line);

  /// ## column (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get column => getAttribute("column");

  /// ## column (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set column(Object? column) => setAttribute("column", column);

  /// ## state (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get state => getAttribute("state");

  /// ## state (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set state(Object? state) => setAttribute("state", state);

  /// ## token (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get token => getAttribute("token");

  /// ## token (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set token(Object? token) => setAttribute("token", token);

  /// ## expected (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get expected => getAttribute("expected");

  /// ## expected (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set expected(Object? expected) => setAttribute("expected", expected);

  /// ## considered_rules (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get considered_rules => getAttribute("considered_rules");

  /// ## considered_rules (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set considered_rules(Object? considered_rules) =>
      setAttribute("considered_rules", considered_rules);

  /// ## interactive_parser (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get interactive_parser => getAttribute("interactive_parser");

  /// ## interactive_parser (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set interactive_parser(Object? interactive_parser) =>
      setAttribute("interactive_parser", interactive_parser);

  /// ## token_history (getter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  Object? get token_history => getAttribute("token_history");

  /// ## token_history (setter)
  ///
  /// ### python docstring
  ///
  /// An exception that is raised by the parser, when the token it received
  /// doesn't match any valid step forward.
  ///
  /// Parameters:
  ///     token: The mismatched token
  ///     expected: The set of expected tokens
  ///     considered_rules: Which rules were considered, to deduce the expected tokens
  ///     state: A value representing the parser state. Do not rely on its value or type.
  ///     interactive_parser: An instance of ``InteractiveParser``, that is initialized to the point of failure,
  ///                         and can be used for debugging and error handling.
  ///
  /// Note: These parameters are available as attributes of the instance.
  set token_history(Object? token_history) =>
      setAttribute("token_history", token_history);
}

/// ## ValidateSymbols
///
/// ### python docstring
///
/// Same as Transformer, but non-recursive, and changes the tree in-place instead of returning new instances
///
/// Useful for huge trees. Conservative in memory.
///
/// ### python source
/// ```py
/// class ValidateSymbols(Transformer_InPlace):
///     def value(self, v):
///         v ,= v
///         assert isinstance(v, (Tree, Symbol))
///         return v
/// ```
final class ValidateSymbols extends PythonClass {
  factory ValidateSymbols({
    bool visit_tokens = true,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.load_grammar",
        "ValidateSymbols",
        ValidateSymbols.from,
        <Object?>[
          visit_tokens,
        ],
        <String, Object?>{},
      );

  ValidateSymbols.from(super.pythonClass) : super.from();

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

  /// ## value
  ///
  /// ### python source
  /// ```py
  /// def value(self, v):
  ///         v ,= v
  ///         assert isinstance(v, (Tree, Symbol))
  ///         return v
  /// ```
  Object? value({
    required Object? v,
  }) =>
      getFunction("value").call(
        <Object?>[
          v,
        ],
        kwargs: <String, Object?>{},
      );
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

/// ## load_grammar
///
/// ### python docstring
///
/// Parses and creates Grammar objects
///
/// ### python source
/// ```py
/// """Parses and creates Grammar objects"""
/// import hashlib
/// import os.path
/// import sys
/// from collections import namedtuple
/// from copy import copy, deepcopy
/// import pkgutil
/// from ast import literal_eval
/// from contextlib import suppress
/// from typing import List, Tuple, Union, Callable, Dict, Optional, Sequence
///
/// from .utils import bfs, logger, classify_bool, is_id_continue, is_id_start, bfs_all_unique, small_factors
/// from .lexer import Token, TerminalDef, PatternStr, PatternRE
///
/// from .parse_tree_builder import ParseTreeBuilder
/// from .parser_frontends import ParsingFrontend
/// from .common import LexerConf, ParserConf
/// from .grammar import RuleOptions, Rule, Terminal, NonTerminal, Symbol, TOKEN_DEFAULT_PRIORITY
/// from .utils import classify, dedup_list
/// from .exceptions import GrammarError, UnexpectedCharacters, UnexpectedToken, ParseError, UnexpectedInput
///
/// from .tree import Tree, SlottedTree as ST
/// from .visitors import Transformer, Visitor, v_args, Transformer_InPlace, Transformer_NonRecursive
/// inline_args = v_args(inline=True)
///
/// __path__ = os.path.dirname(__file__)
/// IMPORT_PATHS = ['grammars']
///
/// EXT = '.lark'
///
/// _RE_FLAGS = 'imslux'
///
/// _EMPTY = Symbol('__empty__')
///
/// _TERMINAL_NAMES = {
///     '.' : 'DOT',
///     ',' : 'COMMA',
///     ':' : 'COLON',
///     ';' : 'SEMICOLON',
///     '+' : 'PLUS',
///     '-' : 'MINUS',
///     '*' : 'STAR',
///     '/' : 'SLASH',
///     '\\' : 'BACKSLASH',
///     '|' : 'VBAR',
///     '?' : 'QMARK',
///     '!' : 'BANG',
///     '@' : 'AT',
///     '#' : 'HASH',
///     '$' : 'DOLLAR',
///     '%' : 'PERCENT',
///     '^' : 'CIRCUMFLEX',
///     '&' : 'AMPERSAND',
///     '_' : 'UNDERSCORE',
///     '<' : 'LESSTHAN',
///     '>' : 'MORETHAN',
///     '=' : 'EQUAL',
///     '"' : 'DBLQUOTE',
///     '\'' : 'QUOTE',
///     '`' : 'BACKQUOTE',
///     '~' : 'TILDE',
///     '(' : 'LPAR',
///     ')' : 'RPAR',
///     '{' : 'LBRACE',
///     '}' : 'RBRACE',
///     '[' : 'LSQB',
///     ']' : 'RSQB',
///     '\n' : 'NEWLINE',
///     '\r\n' : 'CRLF',
///     '\t' : 'TAB',
///     ' ' : 'SPACE',
/// }
///
/// # Grammar Parser
/// TERMINALS = {
///     '_LPAR': r'\(',
///     '_RPAR': r'\)',
///     '_LBRA': r'\[',
///     '_RBRA': r'\]',
///     '_LBRACE': r'\{',
///     '_RBRACE': r'\}',
///     'OP': '[+*]|[?](?![a-z_])',
///     '_COLON': ':',
///     '_COMMA': ',',
///     '_OR': r'\|',
///     '_DOT': r'\.(?!\.)',
///     '_DOTDOT': r'\.\.',
///     'TILDE': '~',
///     'RULE_MODIFIERS': '(!|![?]?|[?]!?)(?=[_a-z])',
///     'RULE': '_?[a-z][_a-z0-9]*',
///     'TERMINAL': '_?[A-Z][_A-Z0-9]*',
///     'STRING': r'"(\\"|\\\\|[^"\n])*?"i?',
///     'REGEXP': r'/(?!/)(\\/|\\\\|[^/])*?/[%s]*' % _RE_FLAGS,
///     '_NL': r'(\r?\n)+\s*',
///     '_NL_OR': r'(\r?\n)+\s*\|',
///     'WS': r'[ \t]+',
///     'COMMENT': r'\s*//[^\n]*|\s*#[^\n]*',
///     'BACKSLASH': r'\\[ ]*\n',
///     '_TO': '->',
///     '_IGNORE': r'%ignore',
///     '_OVERRIDE': r'%override',
///     '_DECLARE': r'%declare',
///     '_EXTEND': r'%extend',
///     '_IMPORT': r'%import',
///     'NUMBER': r'[+-]?\d+',
/// }
///
/// RULES = {
///     'start': ['_list'],
///     '_list':  ['_item', '_list _item'],
///     '_item':  ['rule', 'term', 'ignore', 'import', 'declare', 'override', 'extend', '_NL'],
///
///     'rule': ['rule_modifiers RULE template_params priority _COLON expansions _NL'],
///     'rule_modifiers': ['RULE_MODIFIERS',
///                        ''],
///     'priority': ['_DOT NUMBER',
///                  ''],
///     'template_params': ['_LBRACE _template_params _RBRACE',
///                         ''],
///     '_template_params': ['RULE',
///                          '_template_params _COMMA RULE'],
///     'expansions': ['_expansions'],
///     '_expansions': ['alias',
///                     '_expansions _OR alias',
///                     '_expansions _NL_OR alias'],
///
///     '?alias':     ['expansion _TO nonterminal', 'expansion'],
///     'expansion': ['_expansion'],
///
///     '_expansion': ['', '_expansion expr'],
///
///     '?expr': ['atom',
///               'atom OP',
///               'atom TILDE NUMBER',
///               'atom TILDE NUMBER _DOTDOT NUMBER',
///               ],
///
///     '?atom': ['_LPAR expansions _RPAR',
///               'maybe',
///               'value'],
///
///     'value': ['terminal',
///               'nonterminal',
///               'literal',
///               'range',
///               'template_usage'],
///
///     'terminal': ['TERMINAL'],
///     'nonterminal': ['RULE'],
///
///     '?name': ['RULE', 'TERMINAL'],
///     '?symbol': ['terminal', 'nonterminal'],
///
///     'maybe': ['_LBRA expansions _RBRA'],
///     'range': ['STRING _DOTDOT STRING'],
///
///     'template_usage': ['nonterminal _LBRACE _template_args _RBRACE'],
///     '_template_args': ['value',
///                        '_template_args _COMMA value'],
///
///     'term': ['TERMINAL _COLON expansions _NL',
///              'TERMINAL _DOT NUMBER _COLON expansions _NL'],
///     'override': ['_OVERRIDE rule',
///                  '_OVERRIDE term'],
///     'extend': ['_EXTEND rule',
///                '_EXTEND term'],
///     'ignore': ['_IGNORE expansions _NL'],
///     'declare': ['_DECLARE _declare_args _NL'],
///     'import': ['_IMPORT _import_path _NL',
///                '_IMPORT _import_path _LPAR name_list _RPAR _NL',
///                '_IMPORT _import_path _TO name _NL'],
///
///     '_import_path': ['import_lib', 'import_rel'],
///     'import_lib': ['_import_args'],
///     'import_rel': ['_DOT _import_args'],
///     '_import_args': ['name', '_import_args _DOT name'],
///
///     'name_list': ['_name_list'],
///     '_name_list': ['name', '_name_list _COMMA name'],
///
///     '_declare_args': ['symbol', '_declare_args symbol'],
///     'literal': ['REGEXP', 'STRING'],
/// }
///
///
/// # Value 5 keeps the number of states in the lalr parser somewhat minimal
/// # It isn't optimal, but close to it. See PR #949
/// SMALL_FACTOR_THRESHOLD = 5
/// # The Threshold whether repeat via ~ are split up into different rules
/// # 50 is chosen since it keeps the number of states low and therefore lalr analysis time low,
/// # while not being to overaggressive and unnecessarily creating rules that might create shift/reduce conflicts.
/// # (See PR #949)
/// REPEAT_BREAK_THRESHOLD = 50
///
///
/// class FindRuleSize(Transformer):
///     def __init__(self, keep_all_tokens):
///         self.keep_all_tokens = keep_all_tokens
///
///     def _will_not_get_removed(self, sym):
///         if isinstance(sym, NonTerminal):
///             return not sym.name.startswith('_')
///         if isinstance(sym, Terminal):
///             return self.keep_all_tokens or not sym.filter_out
///         if sym is _EMPTY:
///             return False
///         assert False, sym
///
///     def _args_as_int(self, args):
///         for a in args:
///             if isinstance(a, int):
///                 yield a
///             elif isinstance(a, Symbol):
///                 yield 1 if self._will_not_get_removed(a) else 0
///             else:
///                 assert False
///
///     def expansion(self, args):
///         return sum(self._args_as_int(args))
///
///     def expansions(self, args):
///         return max(self._args_as_int(args))
///
///
/// @inline_args
/// class EBNF_to_BNF(Transformer_InPlace):
///     def __init__(self):
///         self.new_rules = []
///         self.rules_cache = {}
///         self.prefix = 'anon'
///         self.i = 0
///         self.rule_options = None
///
///     def _name_rule(self, inner):
///         new_name = '__%s_%s_%d' % (self.prefix, inner, self.i)
///         self.i += 1
///         return new_name
///
///     def _add_rule(self, key, name, expansions):
///         t = NonTerminal(name)
///         self.new_rules.append((name, expansions, self.rule_options))
///         self.rules_cache[key] = t
///         return t
///
///     def _add_recurse_rule(self, type_, expr):
///         try:
///             return self.rules_cache[expr]
///         except KeyError:
///             new_name = self._name_rule(type_)
///             t = NonTerminal(new_name)
///             tree = ST('expansions', [
///                 ST('expansion', [expr]),
///                 ST('expansion', [t, expr])
///             ])
///             return self._add_rule(expr, new_name, tree)
///
///     def _add_repeat_rule(self, a, b, target, atom):
///         """Generate a rule that repeats target ``a`` times, and repeats atom ``b`` times.
///
///         When called recursively (into target), it repeats atom for x(n) times, where:
///             x(0) = 1
///             x(n) = a(n) * x(n-1) + b
///
///         Example rule when a=3, b=4:
///
///             new_rule: target target target atom atom atom atom
///
///         """
///         key = (a, b, target, atom)
///         try:
///             return self.rules_cache[key]
///         except KeyError:
///             new_name = self._name_rule('repeat_a%d_b%d' % (a, b))
///             tree = ST('expansions', [ST('expansion', [target] * a + [atom] * b)])
///             return self._add_rule(key, new_name, tree)
///
///     def _add_repeat_opt_rule(self, a, b, target, target_opt, atom):
///         """Creates a rule that matches atom 0 to (a*n+b)-1 times.
///
///         When target matches n times atom, and target_opt 0 to n-1 times target_opt,
///
///         First we generate target * i followed by target_opt, for i from 0 to a-1
///         These match 0 to n*a - 1 times atom
///
///         Then we generate target * a followed by atom * i, for i from 0 to b-1
///         These match n*a to n*a + b-1 times atom
///
///         The created rule will not have any shift/reduce conflicts so that it can be used with lalr
///
///         Example rule when a=3, b=4:
///
///             new_rule: target_opt
///                     | target target_opt
///                     | target target target_opt
///
///                     | target target target
///                     | target target target atom
///                     | target target target atom atom
///                     | target target target atom atom atom
///
///         """
///         key = (a, b, target, atom, "opt")
///         try:
///             return self.rules_cache[key]
///         except KeyError:
///             new_name = self._name_rule('repeat_a%d_b%d_opt' % (a, b))
///             tree = ST('expansions', [
///                 ST('expansion', [target]*i + [target_opt]) for i in range(a)
///             ] + [
///                 ST('expansion', [target]*a + [atom]*i) for i in range(b)
///             ])
///             return self._add_rule(key, new_name, tree)
///
///     def _generate_repeats(self, rule, mn, mx):
///         """Generates a rule tree that repeats ``rule`` exactly between ``mn`` to ``mx`` times.
///         """
///         # For a small number of repeats, we can take the naive approach
///         if mx < REPEAT_BREAK_THRESHOLD:
///             return ST('expansions', [ST('expansion', [rule] * n) for n in range(mn, mx + 1)])
///
///         # For large repeat values, we break the repetition into sub-rules.
///         # We treat ``rule~mn..mx`` as ``rule~mn rule~0..(diff=mx-mn)``.
///         # We then use small_factors to split up mn and diff up into values [(a, b), ...]
///         # This values are used with the help of _add_repeat_rule and _add_repeat_rule_opt
///         # to generate a complete rule/expression that matches the corresponding number of repeats
///         mn_target = rule
///         for a, b in small_factors(mn, SMALL_FACTOR_THRESHOLD):
///             mn_target = self._add_repeat_rule(a, b, mn_target, rule)
///         if mx == mn:
///             return mn_target
///
///         diff = mx - mn + 1  # We add one because _add_repeat_opt_rule generates rules that match one less
///         diff_factors = small_factors(diff, SMALL_FACTOR_THRESHOLD)
///         diff_target = rule  # Match rule 1 times
///         diff_opt_target = ST('expansion', [])  # match rule 0 times (e.g. up to 1 -1 times)
///         for a, b in diff_factors[:-1]:
///             diff_opt_target = self._add_repeat_opt_rule(a, b, diff_target, diff_opt_target, rule)
///             diff_target = self._add_repeat_rule(a, b, diff_target, rule)
///
///         a, b = diff_factors[-1]
///         diff_opt_target = self._add_repeat_opt_rule(a, b, diff_target, diff_opt_target, rule)
///
///         return ST('expansions', [ST('expansion', [mn_target] + [diff_opt_target])])
///
///     def expr(self, rule, op, *args):
///         if op.value == '?':
///             empty = ST('expansion', [])
///             return ST('expansions', [rule, empty])
///         elif op.value == '+':
///             # a : b c+ d
///             #   -->
///             # a : b _c d
///             # _c : _c c | c;
///             return self._add_recurse_rule('plus', rule)
///         elif op.value == '*':
///             # a : b c* d
///             #   -->
///             # a : b _c? d
///             # _c : _c c | c;
///             new_name = self._add_recurse_rule('star', rule)
///             return ST('expansions', [new_name, ST('expansion', [])])
///         elif op.value == '~':
///             if len(args) == 1:
///                 mn = mx = int(args[0])
///             else:
///                 mn, mx = map(int, args)
///                 if mx < mn or mn < 0:
///                     raise GrammarError("Bad Range for %s (%d..%d isn't allowed)" % (rule, mn, mx))
///
///             return self._generate_repeats(rule, mn, mx)
///
///         assert False, op
///
///     def maybe(self, rule):
///         keep_all_tokens = self.rule_options and self.rule_options.keep_all_tokens
///         rule_size = FindRuleSize(keep_all_tokens).transform(rule)
///         empty = ST('expansion', [_EMPTY] * rule_size)
///         return ST('expansions', [rule, empty])
///
///
/// class SimplifyRule_Visitor(Visitor):
///
///     @staticmethod
///     def _flatten(tree):
///         while tree.expand_kids_by_data(tree.data):
///             pass
///
///     def expansion(self, tree):
///         # rules_list unpacking
///         # a : b (c|d) e
///         #  -->
///         # a : b c e | b d e
///         #
///         # In AST terms:
///         # expansion(b, expansions(c, d), e)
///         #   -->
///         # expansions( expansion(b, c, e), expansion(b, d, e) )
///
///         self._flatten(tree)
///
///         for i, child in enumerate(tree.children):
///             if isinstance(child, Tree) and child.data == 'expansions':
///                 tree.data = 'expansions'
///                 tree.children = [self.visit(ST('expansion', [option if i == j else other
///                                                              for j, other in enumerate(tree.children)]))
///                                  for option in dedup_list(child.children)]
///                 self._flatten(tree)
///                 break
///
///     def alias(self, tree):
///         rule, alias_name = tree.children
///         if rule.data == 'expansions':
///             aliases = []
///             for child in tree.children[0].children:
///                 aliases.append(ST('alias', [child, alias_name]))
///             tree.data = 'expansions'
///             tree.children = aliases
///
///     def expansions(self, tree):
///         self._flatten(tree)
///         # Ensure all children are unique
///         if len(set(tree.children)) != len(tree.children):
///             tree.children = dedup_list(tree.children)   # dedup is expensive, so try to minimize its use
///
///
/// class RuleTreeToText(Transformer):
///     def expansions(self, x):
///         return x
///
///     def expansion(self, symbols):
///         return symbols, None
///
///     def alias(self, x):
///         (expansion, _alias), alias = x
///         assert _alias is None, (alias, expansion, '-', _alias)  # Double alias not allowed
///         return expansion, alias.name
///
///
/// class PrepareAnonTerminals(Transformer_InPlace):
///     """Create a unique list of anonymous terminals. Attempt to give meaningful names to them when we add them"""
///
///     def __init__(self, terminals):
///         self.terminals = terminals
///         self.term_set = {td.name for td in self.terminals}
///         self.term_reverse = {td.pattern: td for td in terminals}
///         self.i = 0
///         self.rule_options = None
///
///     @inline_args
///     def pattern(self, p):
///         value = p.value
///         if p in self.term_reverse and p.flags != self.term_reverse[p].pattern.flags:
///             raise GrammarError(u'Conflicting flags for the same terminal: %s' % p)
///
///         term_name = None
///
///         if isinstance(p, PatternStr):
///             try:
///                 # If already defined, use the user-defined terminal name
///                 term_name = self.term_reverse[p].name
///             except KeyError:
///                 # Try to assign an indicative anon-terminal name
///                 try:
///                     term_name = _TERMINAL_NAMES[value]
///                 except KeyError:
///                     if value and is_id_continue(value) and is_id_start(value[0]) and value.upper() not in self.term_set:
///                         term_name = value.upper()
///
///                 if term_name in self.term_set:
///                     term_name = None
///
///         elif isinstance(p, PatternRE):
///             if p in self.term_reverse:  # Kind of a weird placement.name
///                 term_name = self.term_reverse[p].name
///         else:
///             assert False, p
///
///         if term_name is None:
///             term_name = '__ANON_%d' % self.i
///             self.i += 1
///
///         if term_name not in self.term_set:
///             assert p not in self.term_reverse
///             self.term_set.add(term_name)
///             termdef = TerminalDef(term_name, p)
///             self.term_reverse[p] = termdef
///             self.terminals.append(termdef)
///
///         filter_out = False if self.rule_options and self.rule_options.keep_all_tokens else isinstance(p, PatternStr)
///
///         return Terminal(term_name, filter_out=filter_out)
///
///
/// class _ReplaceSymbols(Transformer_InPlace):
///     """Helper for ApplyTemplates"""
///
///     def __init__(self):
///         self.names = {}
///
///     def value(self, c):
///         if len(c) == 1 and isinstance(c[0], Symbol) and c[0].name in self.names:
///             return self.names[c[0].name]
///         return self.__default__('value', c, None)
///
///     def template_usage(self, c):
///         name = c[0].name
///         if name in self.names:
///             return self.__default__('template_usage', [self.names[name]] + c[1:], None)
///         return self.__default__('template_usage', c, None)
///
///
/// class ApplyTemplates(Transformer_InPlace):
///     """Apply the templates, creating new rules that represent the used templates"""
///
///     def __init__(self, rule_defs):
///         self.rule_defs = rule_defs
///         self.replacer = _ReplaceSymbols()
///         self.created_templates = set()
///
///     def template_usage(self, c):
///         name = c[0].name
///         args = c[1:]
///         result_name = "%s{%s}" % (name, ",".join(a.name for a in args))
///         if result_name not in self.created_templates:
///             self.created_templates.add(result_name)
///             (_n, params, tree, options) ,= (t for t in self.rule_defs if t[0] == name)
///             assert len(params) == len(args), args
///             result_tree = deepcopy(tree)
///             self.replacer.names = dict(zip(params, args))
///             self.replacer.transform(result_tree)
///             self.rule_defs.append((result_name, [], result_tree, deepcopy(options)))
///         return NonTerminal(result_name)
///
///
/// def _rfind(s, choices):
///     return max(s.rfind(c) for c in choices)
///
///
/// def eval_escaping(s):
///     w = ''
///     i = iter(s)
///     for n in i:
///         w += n
///         if n == '\\':
///             try:
///                 n2 = next(i)
///             except StopIteration:
///                 raise GrammarError("Literal ended unexpectedly (bad escaping): `%r`" % s)
///             if n2 == '\\':
///                 w += '\\\\'
///             elif n2 not in 'Uuxnftr':
///                 w += '\\'
///             w += n2
///     w = w.replace('\\"', '"').replace("'", "\\'")
///
///     to_eval = "u'''%s'''" % w
///     try:
///         s = literal_eval(to_eval)
///     except SyntaxError as e:
///         raise GrammarError(s, e)
///
///     return s
///
///
/// def _literal_to_pattern(literal):
///     assert isinstance(literal, Token)
///     v = literal.value
///     flag_start = _rfind(v, '/"')+1
///     assert flag_start > 0
///     flags = v[flag_start:]
///     assert all(f in _RE_FLAGS for f in flags), flags
///
///     if literal.type == 'STRING' and '\n' in v:
///         raise GrammarError('You cannot put newlines in string literals')
///
///     if literal.type == 'REGEXP' and '\n' in v and 'x' not in flags:
///         raise GrammarError('You can only use newlines in regular expressions '
///                            'with the `x` (verbose) flag')
///
///     v = v[:flag_start]
///     assert v[0] == v[-1] and v[0] in '"/'
///     x = v[1:-1]
///
///     s = eval_escaping(x)
///
///     if s == "":
///         raise GrammarError("Empty terminals are not allowed (%s)" % literal)
///
///     if literal.type == 'STRING':
///         s = s.replace('\\\\', '\\')
///         return PatternStr(s, flags, raw=literal.value)
///     elif literal.type == 'REGEXP':
///         return PatternRE(s, flags, raw=literal.value)
///     else:
///         assert False, 'Invariant failed: literal.type not in ["STRING", "REGEXP"]'
///
///
/// @inline_args
/// class PrepareLiterals(Transformer_InPlace):
///     def literal(self, literal):
///         return ST('pattern', [_literal_to_pattern(literal)])
///
///     def range(self, start, end):
///         assert start.type == end.type == 'STRING'
///         start = start.value[1:-1]
///         end = end.value[1:-1]
///         assert len(eval_escaping(start)) == len(eval_escaping(end)) == 1
///         regexp = '[%s-%s]' % (start, end)
///         return ST('pattern', [PatternRE(regexp)])
///
///
/// def _make_joined_pattern(regexp, flags_set):
///     return PatternRE(regexp, ())
///
/// class TerminalTreeToPattern(Transformer_NonRecursive):
///     def pattern(self, ps):
///         p ,= ps
///         return p
///
///     def expansion(self, items):
///         assert items
///         if len(items) == 1:
///             return items[0]
///
///         pattern = ''.join(i.to_regexp() for i in items)
///         return _make_joined_pattern(pattern, {i.flags for i in items})
///
///     def expansions(self, exps):
///         if len(exps) == 1:
///             return exps[0]
///
///         # Do a bit of sorting to make sure that the longest option is returned
///         # (Python's re module otherwise prefers just 'l' when given (l|ll) and both could match)
///         exps.sort(key=lambda x: (-x.max_width, -x.min_width, -len(x.value)))
///
///         pattern = '(?:%s)' % ('|'.join(i.to_regexp() for i in exps))
///         return _make_joined_pattern(pattern, {i.flags for i in exps})
///
///     def expr(self, args):
///         inner, op = args[:2]
///         if op == '~':
///             if len(args) == 3:
///                 op = "{%d}" % int(args[2])
///             else:
///                 mn, mx = map(int, args[2:])
///                 if mx < mn:
///                     raise GrammarError("Bad Range for %s (%d..%d isn't allowed)" % (inner, mn, mx))
///                 op = "{%d,%d}" % (mn, mx)
///         else:
///             assert len(args) == 2
///         return PatternRE('(?:%s)%s' % (inner.to_regexp(), op), inner.flags)
///
///     def maybe(self, expr):
///         return self.expr(expr + ['?'])
///
///     def alias(self, t):
///         raise GrammarError("Aliasing not allowed in terminals (You used -> in the wrong place)")
///
///     def value(self, v):
///         return v[0]
///
///
/// class ValidateSymbols(Transformer_InPlace):
///     def value(self, v):
///         v ,= v
///         assert isinstance(v, (Tree, Symbol))
///         return v
///
///
/// def nr_deepcopy_tree(t):
///     """Deepcopy tree `t` without recursion"""
///     return Transformer_NonRecursive(False).transform(t)
///
///
/// class Grammar:
///
///     term_defs: List[Tuple[str, Tuple[Tree, int]]]
///     rule_defs: List[Tuple[str, Tuple[str, ...], Tree, RuleOptions]]
///     ignore: List[str]
///
///     def __init__(self, rule_defs: List[Tuple[str, Tuple[str, ...], Tree, RuleOptions]], term_defs: List[Tuple[str, Tuple[Tree, int]]], ignore: List[str]) -> None:
///         self.term_defs = term_defs
///         self.rule_defs = rule_defs
///         self.ignore = ignore
///
///     def compile(self, start, terminals_to_keep):
///         # We change the trees in-place (to support huge grammars)
///         # So deepcopy allows calling compile more than once.
///         term_defs = [(n, (nr_deepcopy_tree(t), p)) for n, (t, p) in self.term_defs]
///         rule_defs = [(n, p, nr_deepcopy_tree(t), o) for n, p, t, o in self.rule_defs]
///
///         # ===================
///         #  Compile Terminals
///         # ===================
///
///         # Convert terminal-trees to strings/regexps
///
///         for name, (term_tree, priority) in term_defs:
///             if term_tree is None:  # Terminal added through %declare
///                 continue
///             expansions = list(term_tree.find_data('expansion'))
///             if len(expansions) == 1 and not expansions[0].children:
///                 raise GrammarError("Terminals cannot be empty (%s)" % name)
///
///         transformer = PrepareLiterals() * TerminalTreeToPattern()
///         terminals = [TerminalDef(name, transformer.transform(term_tree), priority)
///                      for name, (term_tree, priority) in term_defs if term_tree]
///
///         # =================
///         #  Compile Rules
///         # =================
///
///         # 1. Pre-process terminals
///         anon_tokens_transf = PrepareAnonTerminals(terminals)
///         transformer = PrepareLiterals() * ValidateSymbols() * anon_tokens_transf  # Adds to terminals
///
///         # 2. Inline Templates
///
///         transformer *= ApplyTemplates(rule_defs)
///
///         # 3. Convert EBNF to BNF (and apply step 1 & 2)
///         ebnf_to_bnf = EBNF_to_BNF()
///         rules = []
///         i = 0
///         while i < len(rule_defs):  # We have to do it like this because rule_defs might grow due to templates
///             name, params, rule_tree, options = rule_defs[i]
///             i += 1
///             if len(params) != 0:  # Dont transform templates
///                 continue
///             rule_options = RuleOptions(keep_all_tokens=True) if options and options.keep_all_tokens else None
///             ebnf_to_bnf.rule_options = rule_options
///             ebnf_to_bnf.prefix = name
///             anon_tokens_transf.rule_options = rule_options
///             tree = transformer.transform(rule_tree)
///             res = ebnf_to_bnf.transform(tree)
///             rules.append((name, res, options))
///         rules += ebnf_to_bnf.new_rules
///
///         assert len(rules) == len({name for name, _t, _o in rules}), "Whoops, name collision"
///
///         # 4. Compile tree to Rule objects
///         rule_tree_to_text = RuleTreeToText()
///
///         simplify_rule = SimplifyRule_Visitor()
///         compiled_rules = []
///         for rule_content in rules:
///             name, tree, options = rule_content
///             simplify_rule.visit(tree)
///             expansions = rule_tree_to_text.transform(tree)
///
///             for i, (expansion, alias) in enumerate(expansions):
///                 if alias and name.startswith('_'):
///                     raise GrammarError("Rule %s is marked for expansion (it starts with an underscore) and isn't allowed to have aliases (alias=%s)"% (name, alias))
///
///                 empty_indices = [x==_EMPTY for x in expansion]
///                 if any(empty_indices):
///                     exp_options = copy(options) or RuleOptions()
///                     exp_options.empty_indices = empty_indices
///                     expansion = [x for x in expansion if x!=_EMPTY]
///                 else:
///                     exp_options = options
///
///                 for sym in expansion:
///                     assert isinstance(sym, Symbol)
///                     if sym.is_term and exp_options and exp_options.keep_all_tokens:
///                         sym.filter_out = False
///                 rule = Rule(NonTerminal(name), expansion, i, alias, exp_options)
///                 compiled_rules.append(rule)
///
///         # Remove duplicates of empty rules, throw error for non-empty duplicates
///         if len(set(compiled_rules)) != len(compiled_rules):
///             duplicates = classify(compiled_rules, lambda x: x)
///             for dups in duplicates.values():
///                 if len(dups) > 1:
///                     if dups[0].expansion:
///                         raise GrammarError("Rules defined twice: %s\n\n(Might happen due to colliding expansion of optionals: [] or ?)"
///                                            % ''.join('\n  * %s' % i for i in dups))
///
///                     # Empty rule; assert all other attributes are equal
///                     assert len({(r.alias, r.order, r.options) for r in dups}) == len(dups)
///
///             # Remove duplicates
///             compiled_rules = list(set(compiled_rules))
///
///         # Filter out unused rules
///         while True:
///             c = len(compiled_rules)
///             used_rules = {s for r in compiled_rules
///                             for s in r.expansion
///                             if isinstance(s, NonTerminal)
///                             and s != r.origin}
///             used_rules |= {NonTerminal(s) for s in start}
///             compiled_rules, unused = classify_bool(compiled_rules, lambda r: r.origin in used_rules)
///             for r in unused:
///                 logger.debug("Unused rule: %s", r)
///             if len(compiled_rules) == c:
///                 break
///
///         # Filter out unused terminals
///         if terminals_to_keep != '*':
///             used_terms = {t.name for r in compiled_rules
///                                  for t in r.expansion
///                                  if isinstance(t, Terminal)}
///             terminals, unused = classify_bool(terminals, lambda t: t.name in used_terms or t.name in self.ignore or t.name in terminals_to_keep)
///             if unused:
///                 logger.debug("Unused terminals: %s", [t.name for t in unused])
///
///         return terminals, compiled_rules, self.ignore
///
///
/// PackageResource = namedtuple('PackageResource', 'pkg_name path')
///
///
/// class FromPackageLoader:
///     """
///     Provides a simple way of creating custom import loaders that load from packages via ``pkgutil.get_data`` instead of using `open`.
///     This allows them to be compatible even from within zip files.
///
///     Relative imports are handled, so you can just freely use them.
///
///     pkg_name: The name of the package. You can probably provide `__name__` most of the time
///     search_paths: All the path that will be search on absolute imports.
///     """
///
///     pkg_name: str
///     search_paths: Sequence[str]
///
///     def __init__(self, pkg_name: str, search_paths: Sequence[str]=("", )) -> None:
///         self.pkg_name = pkg_name
///         self.search_paths = search_paths
///
///     def __repr__(self):
///         return "%s(%r, %r)" % (type(self).__name__, self.pkg_name, self.search_paths)
///
///     def __call__(self, base_path: Union[None, str, PackageResource], grammar_path: str) -> Tuple[PackageResource, str]:
///         if base_path is None:
///             to_try = self.search_paths
///         else:
///             # Check whether or not the importing grammar was loaded by this module.
///             if not isinstance(base_path, PackageResource) or base_path.pkg_name != self.pkg_name:
///                 # Technically false, but FileNotFound doesn't exist in python2.7, and this message should never reach the end user anyway
///                 raise IOError()
///             to_try = [base_path.path]
///
///         err = None
///         for path in to_try:
///             full_path = os.path.join(path, grammar_path)
///             try:
///                 text: Optional[bytes] = pkgutil.get_data(self.pkg_name, full_path)
///             except IOError as e:
///                 err = e
///                 continue
///             else:
///                 return PackageResource(self.pkg_name, full_path), (text.decode() if text else '')
///
///         raise IOError('Cannot find grammar in given paths') from err
///
///
/// stdlib_loader = FromPackageLoader('lark', IMPORT_PATHS)
///
///
///
/// def resolve_term_references(term_dict):
///     # TODO Solve with transitive closure (maybe)
///
///     while True:
///         changed = False
///         for name, token_tree in term_dict.items():
///             if token_tree is None:  # Terminal added through %declare
///                 continue
///             for exp in token_tree.find_data('value'):
///                 item ,= exp.children
///                 if isinstance(item, NonTerminal):
///                     raise GrammarError("Rules aren't allowed inside terminals (%s in %s)" % (item, name))
///                 elif isinstance(item, Terminal):
///                     try:
///                         term_value = term_dict[item.name]
///                     except KeyError:
///                         raise GrammarError("Terminal used but not defined: %s" % item.name)
///                     assert term_value is not None
///                     exp.children[0] = term_value
///                     changed = True
///                 else:
///                     assert isinstance(item, Tree)
///         if not changed:
///             break
///
///     for name, term in term_dict.items():
///         if term:    # Not just declared
///             for child in term.children:
///                 ids = [id(x) for x in child.iter_subtrees()]
///                 if id(term) in ids:
///                     raise GrammarError("Recursion in terminal '%s' (recursion is only allowed in rules, not terminals)" % name)
///
///
///
/// def symbol_from_strcase(s):
///     assert isinstance(s, str)
///     return Terminal(s, filter_out=s.startswith('_')) if s.isupper() else NonTerminal(s)
///
/// @inline_args
/// class PrepareGrammar(Transformer_InPlace):
///     def terminal(self, name):
///         return Terminal(str(name), filter_out=name.startswith('_'))
///
///     def nonterminal(self, name):
///         return NonTerminal(name.value)
///
///
/// def _find_used_symbols(tree):
///     assert tree.data == 'expansions'
///     return {t.name for x in tree.find_data('expansion')
///             for t in x.scan_values(lambda t: isinstance(t, Symbol))}
///
///
/// def _get_parser():
///     try:
///         return _get_parser.cache
///     except AttributeError:
///         terminals = [TerminalDef(name, PatternRE(value)) for name, value in TERMINALS.items()]
///
///         rules = [(name.lstrip('?'), x, RuleOptions(expand1=name.startswith('?')))
///                 for name, x in RULES.items()]
///         rules = [Rule(NonTerminal(r), [symbol_from_strcase(s) for s in x.split()], i, None, o)
///                  for r, xs, o in rules for i, x in enumerate(xs)]
///
///         callback = ParseTreeBuilder(rules, ST).create_callback()
///         import re
///         lexer_conf = LexerConf(terminals, re, ['WS', 'COMMENT', 'BACKSLASH'])
///         parser_conf = ParserConf(rules, callback, ['start'])
///         lexer_conf.lexer_type = 'basic'
///         parser_conf.parser_type = 'lalr'
///         _get_parser.cache = ParsingFrontend(lexer_conf, parser_conf, None)
///         return _get_parser.cache
///
/// GRAMMAR_ERRORS = [
///         ('Incorrect type of value', ['a: 1\n']),
///         ('Unclosed parenthesis', ['a: (\n']),
///         ('Unmatched closing parenthesis', ['a: )\n', 'a: [)\n', 'a: (]\n']),
///         ('Expecting rule or terminal definition (missing colon)', ['a\n', 'A\n', 'a->\n', 'A->\n', 'a A\n']),
///         ('Illegal name for rules or terminals', ['Aa:\n']),
///         ('Alias expects lowercase name', ['a: -> "a"\n']),
///         ('Unexpected colon', ['a::\n', 'a: b:\n', 'a: B:\n', 'a: "a":\n']),
///         ('Misplaced operator', ['a: b??', 'a: b(?)', 'a:+\n', 'a:?\n', 'a:*\n', 'a:|*\n']),
///         ('Expecting option ("|") or a new rule or terminal definition', ['a:a\n()\n']),
///         ('Terminal names cannot contain dots', ['A.B\n']),
///         ('Expecting rule or terminal definition', ['"a"\n']),
///         ('%import expects a name', ['%import "a"\n']),
///         ('%ignore expects a value', ['%ignore %import\n']),
///     ]
///
/// def _translate_parser_exception(parse, e):
///         error = e.match_examples(parse, GRAMMAR_ERRORS, use_accepts=True)
///         if error:
///             return error
///         elif 'STRING' in e.expected:
///             return "Expecting a value"
///
/// def _parse_grammar(text, name, start='start'):
///     try:
///         tree = _get_parser().parse(text + '\n', start)
///     except UnexpectedCharacters as e:
///         context = e.get_context(text)
///         raise GrammarError("Unexpected input at line %d column %d in %s: \n\n%s" %
///                            (e.line, e.column, name, context))
///     except UnexpectedToken as e:
///         context = e.get_context(text)
///         error = _translate_parser_exception(_get_parser().parse, e)
///         if error:
///             raise GrammarError("%s, at line %s column %s\n\n%s" % (error, e.line, e.column, context))
///         raise
///
///     return PrepareGrammar().transform(tree)
///
///
/// def _error_repr(error):
///     if isinstance(error, UnexpectedToken):
///         error2 = _translate_parser_exception(_get_parser().parse, error)
///         if error2:
///             return error2
///         expected = ', '.join(error.accepts or error.expected)
///         return "Unexpected token %r. Expected one of: {%s}" % (str(error.token), expected)
///     else:
///         return str(error)
///
/// def _search_interactive_parser(interactive_parser, predicate):
///     def expand(node):
///         path, p = node
///         for choice in p.choices():
///             t = Token(choice, '')
///             try:
///                 new_p = p.feed_token(t)
///             except ParseError:    # Illegal
///                 pass
///             else:
///                 yield path + (choice,), new_p
///
///     for path, p in bfs_all_unique([((), interactive_parser)], expand):
///         if predicate(p):
///             return path, p
///
/// def find_grammar_errors(text: str, start: str='start') -> List[Tuple[UnexpectedInput, str]]:
///     errors = []
///     def on_error(e):
///         errors.append((e, _error_repr(e)))
///
///         # recover to a new line
///         token_path, _ = _search_interactive_parser(e.interactive_parser.as_immutable(), lambda p: '_NL' in p.choices())
///         for token_type in token_path:
///             e.interactive_parser.feed_token(Token(token_type, ''))
///         e.interactive_parser.feed_token(Token('_NL', '\n'))
///         return True
///
///     _tree = _get_parser().parse(text + '\n', start, on_error=on_error)
///
///     errors_by_line = classify(errors, lambda e: e[0].line)
///     errors = [el[0] for el in errors_by_line.values()]      # already sorted
///
///     for e in errors:
///         e[0].interactive_parser = None
///     return errors
///
///
/// def _get_mangle(prefix, aliases, base_mangle=None):
///     def mangle(s):
///         if s in aliases:
///             s = aliases[s]
///         else:
///             if s[0] == '_':
///                 s = '_%s__%s' % (prefix, s[1:])
///             else:
///                 s = '%s__%s' % (prefix, s)
///         if base_mangle is not None:
///             s = base_mangle(s)
///         return s
///     return mangle
///
/// def _mangle_definition_tree(exp, mangle):
///     if mangle is None:
///         return exp
///     exp = deepcopy(exp) # TODO: is this needed?
///     for t in exp.iter_subtrees():
///         for i, c in enumerate(t.children):
///             if isinstance(c, Symbol):
///                 t.children[i] = c.renamed(mangle)
///
///     return exp
///
/// def _make_rule_tuple(modifiers_tree, name, params, priority_tree, expansions):
///     if modifiers_tree.children:
///         m ,= modifiers_tree.children
///         expand1 = '?' in m
///         if expand1 and name.startswith('_'):
///             raise GrammarError("Inlined rules (_rule) cannot use the ?rule modifier.")
///         keep_all_tokens = '!' in m
///     else:
///         keep_all_tokens = False
///         expand1 = False
///
///     if priority_tree.children:
///         p ,= priority_tree.children
///         priority = int(p)
///     else:
///         priority = None
///
///     if params is not None:
///         params = [t.value for t in params.children]  # For the grammar parser
///
///     return name, params, expansions, RuleOptions(keep_all_tokens, expand1, priority=priority,
///                                                  template_source=(name if params else None))
///
///
/// class Definition:
///     def __init__(self, is_term, tree, params=(), options=None):
///         self.is_term = is_term
///         self.tree = tree
///         self.params = tuple(params)
///         self.options = options
///
/// class GrammarBuilder:
///
///     global_keep_all_tokens: bool
///     import_paths: List[Union[str, Callable]]
///     used_files: Dict[str, str]
///
///     _definitions: Dict[str, Definition]
///     _ignore_names: List[str]
///
///     def __init__(self, global_keep_all_tokens: bool=False, import_paths: Optional[List[Union[str, Callable]]]=None, used_files: Optional[Dict[str, str]]=None) -> None:
///         self.global_keep_all_tokens = global_keep_all_tokens
///         self.import_paths = import_paths or []
///         self.used_files = used_files or {}
///
///         self._definitions: Dict[str, Definition] = {}
///         self._ignore_names: List[str] = []
///
///     def _grammar_error(self, is_term, msg, *names):
///         args = {}
///         for i, name in enumerate(names, start=1):
///             postfix = '' if i == 1 else str(i)
///             args['name' + postfix] = name
///             args['type' + postfix] = lowercase_type = ("rule", "terminal")[is_term]
///             args['Type' + postfix] = lowercase_type.title()
///         raise GrammarError(msg.format(**args))
///
///     def _check_options(self, is_term, options):
///         if is_term:
///             if options is None:
///                 options = 1
///             elif not isinstance(options, int):
///                 raise GrammarError("Terminal require a single int as 'options' (e.g. priority), got %s" % (type(options),))
///         else:
///             if options is None:
///                 options = RuleOptions()
///             elif not isinstance(options, RuleOptions):
///                 raise GrammarError("Rules require a RuleOptions instance as 'options'")
///             if self.global_keep_all_tokens:
///                 options.keep_all_tokens = True
///         return options
///
///
///     def _define(self, name, is_term, exp, params=(), options=None, *, override=False):
///         if name in self._definitions:
///             if not override:
///                 self._grammar_error(is_term, "{Type} '{name}' defined more than once", name)
///         elif override:
///             self._grammar_error(is_term, "Cannot override a nonexisting {type} {name}", name)
///
///         if name.startswith('__'):
///             self._grammar_error(is_term, 'Names starting with double-underscore are reserved (Error at {name})', name)
///
///         self._definitions[name] = Definition(is_term, exp, params, self._check_options(is_term, options))
///
///     def _extend(self, name, is_term, exp, params=(), options=None):
///         if name not in self._definitions:
///             self._grammar_error(is_term, "Can't extend {type} {name} as it wasn't defined before", name)
///
///         d = self._definitions[name]
///
///         if is_term != d.is_term:
///             self._grammar_error(is_term, "Cannot extend {type} {name} - one is a terminal, while the other is not.", name)
///         if tuple(params) != d.params:
///             self._grammar_error(is_term, "Cannot extend {type} with different parameters: {name}", name)
///
///         if d.tree is None:
///             self._grammar_error(is_term, "Can't extend {type} {name} - it is abstract.", name)
///
///         # TODO: think about what to do with 'options'
///         base = d.tree
///
///         assert isinstance(base, Tree) and base.data == 'expansions'
///         base.children.insert(0, exp)
///
///     def _ignore(self, exp_or_name):
///         if isinstance(exp_or_name, str):
///             self._ignore_names.append(exp_or_name)
///         else:
///             assert isinstance(exp_or_name, Tree)
///             t = exp_or_name
///             if t.data == 'expansions' and len(t.children) == 1:
///                 t2 ,= t.children
///                 if t2.data=='expansion' and len(t2.children) == 1:
///                     item ,= t2.children
///                     if item.data == 'value':
///                         item ,= item.children
///                         if isinstance(item, Terminal):
///                             # Keep terminal name, no need to create a new definition
///                             self._ignore_names.append(item.name)
///                             return
///
///             name = '__IGNORE_%d'% len(self._ignore_names)
///             self._ignore_names.append(name)
///             self._definitions[name] = Definition(True, t, options=TOKEN_DEFAULT_PRIORITY)
///
///     def _unpack_import(self, stmt, grammar_name):
///         if len(stmt.children) > 1:
///             path_node, arg1 = stmt.children
///         else:
///             path_node, = stmt.children
///             arg1 = None
///
///         if isinstance(arg1, Tree):  # Multi import
///             dotted_path = tuple(path_node.children)
///             names = arg1.children
///             aliases = dict(zip(names, names))  # Can't have aliased multi import, so all aliases will be the same as names
///         else:  # Single import
///             dotted_path = tuple(path_node.children[:-1])
///             if not dotted_path:
///                 name ,= path_node.children
///                 raise GrammarError("Nothing was imported from grammar `%s`" % name)
///             name = path_node.children[-1]  # Get name from dotted path
///             aliases = {name.value: (arg1 or name).value}  # Aliases if exist
///
///         if path_node.data == 'import_lib':  # Import from library
///             base_path = None
///         else:  # Relative import
///             if grammar_name == '<string>':  # Import relative to script file path if grammar is coded in script
///                 try:
///                     base_file = os.path.abspath(sys.modules['__main__'].__file__)
///                 except AttributeError:
///                     base_file = None
///             else:
///                 base_file = grammar_name  # Import relative to grammar file path if external grammar file
///             if base_file:
///                 if isinstance(base_file, PackageResource):
///                     base_path = PackageResource(base_file.pkg_name, os.path.split(base_file.path)[0])
///                 else:
///                     base_path = os.path.split(base_file)[0]
///             else:
///                 base_path = os.path.abspath(os.path.curdir)
///
///         return dotted_path, base_path, aliases
///
///     def _unpack_definition(self, tree, mangle):
///
///         if tree.data == 'rule':
///             name, params, exp, opts = _make_rule_tuple(*tree.children)
///             is_term = False
///         else:
///             name = tree.children[0].value
///             params = ()     # TODO terminal templates
///             opts = int(tree.children[1]) if len(tree.children) == 3 else TOKEN_DEFAULT_PRIORITY # priority
///             exp = tree.children[-1]
///             is_term = True
///
///         if mangle is not None:
///             params = tuple(mangle(p) for p in params)
///             name = mangle(name)
///
///         exp = _mangle_definition_tree(exp, mangle)
///         return name, is_term, exp, params, opts
///
///
///     def load_grammar(self, grammar_text: str, grammar_name: str="<?>", mangle: Optional[Callable[[str], str]]=None) -> None:
///         tree = _parse_grammar(grammar_text, grammar_name)
///
///         imports: Dict[Tuple[str, ...], Tuple[Optional[str], Dict[str, str]]] = {}
///
///         for stmt in tree.children:
///             if stmt.data == 'import':
///                 dotted_path, base_path, aliases = self._unpack_import(stmt, grammar_name)
///                 try:
///                     import_base_path, import_aliases = imports[dotted_path]
///                     assert base_path == import_base_path, 'Inconsistent base_path for %s.' % '.'.join(dotted_path)
///                     import_aliases.update(aliases)
///                 except KeyError:
///                     imports[dotted_path] = base_path, aliases
///
///         for dotted_path, (base_path, aliases) in imports.items():
///             self.do_import(dotted_path, base_path, aliases, mangle)
///
///         for stmt in tree.children:
///             if stmt.data in ('term', 'rule'):
///                 self._define(*self._unpack_definition(stmt, mangle))
///             elif stmt.data == 'override':
///                 r ,= stmt.children
///                 self._define(*self._unpack_definition(r, mangle), override=True)
///             elif stmt.data == 'extend':
///                 r ,= stmt.children
///                 self._extend(*self._unpack_definition(r, mangle))
///             elif stmt.data == 'ignore':
///                 # if mangle is not None, we shouldn't apply ignore, since we aren't in a toplevel grammar
///                 if mangle is None:
///                     self._ignore(*stmt.children)
///             elif stmt.data == 'declare':
///                 for symbol in stmt.children:
///                     assert isinstance(symbol, Symbol), symbol
///                     is_term = isinstance(symbol, Terminal)
///                     if mangle is None:
///                         name = symbol.name
///                     else:
///                         name = mangle(symbol.name)
///                     self._define(name, is_term, None)
///             elif stmt.data == 'import':
///                 pass
///             else:
///                 assert False, stmt
///
///
///         term_defs = { name: d.tree
///             for name, d in self._definitions.items()
///             if d.is_term
///         }
///         resolve_term_references(term_defs)
///
///
///     def _remove_unused(self, used):
///         def rule_dependencies(symbol):
///             try:
///                 d = self._definitions[symbol]
///             except KeyError:
///                 return []
///             if d.is_term:
///                 return []
///             return _find_used_symbols(d.tree) - set(d.params)
///
///         _used = set(bfs(used, rule_dependencies))
///         self._definitions = {k: v for k, v in self._definitions.items() if k in _used}
///
///
///     def do_import(self, dotted_path: Tuple[str, ...], base_path: Optional[str], aliases: Dict[str, str], base_mangle: Optional[Callable[[str], str]]=None) -> None:
///         assert dotted_path
///         mangle = _get_mangle('__'.join(dotted_path), aliases, base_mangle)
///         grammar_path = os.path.join(*dotted_path) + EXT
///         to_try = self.import_paths + ([base_path] if base_path is not None else []) + [stdlib_loader]
///         for source in to_try:
///             try:
///                 if callable(source):
///                     joined_path, text = source(base_path, grammar_path)
///                 else:
///                     joined_path = os.path.join(source, grammar_path)
///                     with open(joined_path, encoding='utf8') as f:
///                         text = f.read()
///             except IOError:
///                 continue
///             else:
///                 h = sha256_digest(text)
///                 if self.used_files.get(joined_path, h) != h:
///                     raise RuntimeError("Grammar file was changed during importing")
///                 self.used_files[joined_path] = h
///
///                 gb = GrammarBuilder(self.global_keep_all_tokens, self.import_paths, self.used_files)
///                 gb.load_grammar(text, joined_path, mangle)
///                 gb._remove_unused(map(mangle, aliases))
///                 for name in gb._definitions:
///                     if name in self._definitions:
///                         raise GrammarError("Cannot import '%s' from '%s': Symbol already defined." % (name, grammar_path))
///
///                 self._definitions.update(**gb._definitions)
///                 break
///         else:
///             # Search failed. Make Python throw a nice error.
///             open(grammar_path, encoding='utf8')
///             assert False, "Couldn't import grammar %s, but a corresponding file was found at a place where lark doesn't search for it" % (dotted_path,)
///
///
///     def validate(self) -> None:
///         for name, d in self._definitions.items():
///             params = d.params
///             exp = d.tree
///
///             for i, p in enumerate(params):
///                 if p in self._definitions:
///                     raise GrammarError("Template Parameter conflicts with rule %s (in template %s)" % (p, name))
///                 if p in params[:i]:
///                     raise GrammarError("Duplicate Template Parameter %s (in template %s)" % (p, name))
///
///             if exp is None: # Remaining checks don't apply to abstract rules/terminals (created with %declare)
///                 continue
///
///             for temp in exp.find_data('template_usage'):
///                 sym = temp.children[0].name
///                 args = temp.children[1:]
///                 if sym not in params:
///                     if sym not in self._definitions:
///                         self._grammar_error(d.is_term, "Template '%s' used but not defined (in {type} {name})" % sym, name)
///                     if len(args) != len(self._definitions[sym].params):
///                         expected, actual = len(self._definitions[sym].params), len(args)
///                         self._grammar_error(d.is_term, "Wrong number of template arguments used for {name} "
///                                             "(expected %s, got %s) (in {type2} {name2})" % (expected, actual), sym, name)
///
///             for sym in _find_used_symbols(exp):
///                 if sym not in self._definitions and sym not in params:
///                     self._grammar_error(d.is_term, "{Type} '{name}' used but not defined (in {type2} {name2})", sym, name)
///
///         if not set(self._definitions).issuperset(self._ignore_names):
///             raise GrammarError("Terminals %s were marked to ignore but were not defined!" % (set(self._ignore_names) - set(self._definitions)))
///
///     def build(self) -> Grammar:
///         self.validate()
///         rule_defs = []
///         term_defs = []
///         for name, d in self._definitions.items():
///             (params, exp, options) = d.params, d.tree, d.options
///             if d.is_term:
///                 assert len(params) == 0
///                 term_defs.append((name, (exp, options)))
///             else:
///                 rule_defs.append((name, params, exp, options))
///         # resolve_term_references(term_defs)
///         return Grammar(rule_defs, term_defs, self._ignore_names)
///
///
/// def verify_used_files(file_hashes):
///     for path, old in file_hashes.items():
///         text = None
///         if isinstance(path, str) and os.path.exists(path):
///             with open(path, encoding='utf8') as f:
///                 text = f.read()
///         elif isinstance(path, PackageResource):
///             with suppress(IOError):
///                 text = pkgutil.get_data(*path).decode('utf-8')
///         if text is None: # We don't know how to load the path. ignore it.
///             continue
///
///         current = sha256_digest(text)
///         if old != current:
///             logger.info("File %r changed, rebuilding Parser" % path)
///             return False
///     return True
///
/// def list_grammar_imports(grammar, import_paths=[]):
///     "Returns a list of paths to the lark grammars imported by the given grammar (recursively)"
///     builder = GrammarBuilder(False, import_paths)
///     builder.load_grammar(grammar, '<string>')
///     return list(builder.used_files.keys())
///
/// def load_grammar(grammar, source, import_paths, global_keep_all_tokens):
///     builder = GrammarBuilder(global_keep_all_tokens, import_paths)
///     builder.load_grammar(grammar, source)
///     return builder.build(), builder.used_files
///
///
/// def sha256_digest(s: str) -> str:
///     """Get the sha256 digest of a string
///
///     Supports the `usedforsecurity` argument for Python 3.9+ to allow running on
///     a FIPS-enabled system.
///     """
///     if sys.version_info >= (3, 9):
///         return hashlib.sha256(s.encode('utf8'), usedforsecurity=False).hexdigest()
///     else:
///         return hashlib.sha256(s.encode('utf8')).hexdigest()
/// ```
final class load_grammar extends PythonModule {
  load_grammar.from(super.pythonModule) : super.from();

  static load_grammar import() => PythonFfiDart.instance.importModule(
        "lark.load_grammar",
        load_grammar.from,
      );

  /// ## eval_escaping
  ///
  /// ### python source
  /// ```py
  /// def eval_escaping(s):
  ///     w = ''
  ///     i = iter(s)
  ///     for n in i:
  ///         w += n
  ///         if n == '\\':
  ///             try:
  ///                 n2 = next(i)
  ///             except StopIteration:
  ///                 raise GrammarError("Literal ended unexpectedly (bad escaping): `%r`" % s)
  ///             if n2 == '\\':
  ///                 w += '\\\\'
  ///             elif n2 not in 'Uuxnftr':
  ///                 w += '\\'
  ///             w += n2
  ///     w = w.replace('\\"', '"').replace("'", "\\'")
  ///
  ///     to_eval = "u'''%s'''" % w
  ///     try:
  ///         s = literal_eval(to_eval)
  ///     except SyntaxError as e:
  ///         raise GrammarError(s, e)
  ///
  ///     return s
  /// ```
  Object? eval_escaping({
    required Object? s,
  }) =>
      getFunction("eval_escaping").call(
        <Object?>[
          s,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## find_grammar_errors
  ///
  /// ### python source
  /// ```py
  /// def find_grammar_errors(text: str, start: str='start') -> List[Tuple[UnexpectedInput, str]]:
  ///     errors = []
  ///     def on_error(e):
  ///         errors.append((e, _error_repr(e)))
  ///
  ///         # recover to a new line
  ///         token_path, _ = _search_interactive_parser(e.interactive_parser.as_immutable(), lambda p: '_NL' in p.choices())
  ///         for token_type in token_path:
  ///             e.interactive_parser.feed_token(Token(token_type, ''))
  ///         e.interactive_parser.feed_token(Token('_NL', '\n'))
  ///         return True
  ///
  ///     _tree = _get_parser().parse(text + '\n', start, on_error=on_error)
  ///
  ///     errors_by_line = classify(errors, lambda e: e[0].line)
  ///     errors = [el[0] for el in errors_by_line.values()]      # already sorted
  ///
  ///     for e in errors:
  ///         e[0].interactive_parser = None
  ///     return errors
  /// ```
  Object? find_grammar_errors({
    required String text,
    String start = "start",
  }) =>
      getFunction("find_grammar_errors").call(
        <Object?>[
          text,
          start,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## list_grammar_imports
  ///
  /// ### python docstring
  ///
  /// Returns a list of paths to the lark grammars imported by the given grammar (recursively)
  ///
  /// ### python source
  /// ```py
  /// def list_grammar_imports(grammar, import_paths=[]):
  ///     "Returns a list of paths to the lark grammars imported by the given grammar (recursively)"
  ///     builder = GrammarBuilder(False, import_paths)
  ///     builder.load_grammar(grammar, '<string>')
  ///     return list(builder.used_files.keys())
  /// ```
  Object? list_grammar_imports({
    required Object? grammar,
    Object? import_paths = const [],
  }) =>
      getFunction("list_grammar_imports").call(
        <Object?>[
          grammar,
          import_paths,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## nr_deepcopy_tree
  ///
  /// ### python docstring
  ///
  /// Deepcopy tree `t` without recursion
  ///
  /// ### python source
  /// ```py
  /// def nr_deepcopy_tree(t):
  ///     """Deepcopy tree `t` without recursion"""
  ///     return Transformer_NonRecursive(False).transform(t)
  /// ```
  Object? nr_deepcopy_tree({
    required Object? t,
  }) =>
      getFunction("nr_deepcopy_tree").call(
        <Object?>[
          t,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## resolve_term_references
  ///
  /// ### python source
  /// ```py
  /// def resolve_term_references(term_dict):
  ///     # TODO Solve with transitive closure (maybe)
  ///
  ///     while True:
  ///         changed = False
  ///         for name, token_tree in term_dict.items():
  ///             if token_tree is None:  # Terminal added through %declare
  ///                 continue
  ///             for exp in token_tree.find_data('value'):
  ///                 item ,= exp.children
  ///                 if isinstance(item, NonTerminal):
  ///                     raise GrammarError("Rules aren't allowed inside terminals (%s in %s)" % (item, name))
  ///                 elif isinstance(item, Terminal):
  ///                     try:
  ///                         term_value = term_dict[item.name]
  ///                     except KeyError:
  ///                         raise GrammarError("Terminal used but not defined: %s" % item.name)
  ///                     assert term_value is not None
  ///                     exp.children[0] = term_value
  ///                     changed = True
  ///                 else:
  ///                     assert isinstance(item, Tree)
  ///         if not changed:
  ///             break
  ///
  ///     for name, term in term_dict.items():
  ///         if term:    # Not just declared
  ///             for child in term.children:
  ///                 ids = [id(x) for x in child.iter_subtrees()]
  ///                 if id(term) in ids:
  ///                     raise GrammarError("Recursion in terminal '%s' (recursion is only allowed in rules, not terminals)" % name)
  /// ```
  Object? resolve_term_references({
    required Object? term_dict,
  }) =>
      getFunction("resolve_term_references").call(
        <Object?>[
          term_dict,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## sha256_digest
  ///
  /// ### python docstring
  ///
  /// Get the sha256 digest of a string
  ///
  /// Supports the `usedforsecurity` argument for Python 3.9+ to allow running on
  /// a FIPS-enabled system.
  ///
  /// ### python source
  /// ```py
  /// def sha256_digest(s: str) -> str:
  ///     """Get the sha256 digest of a string
  ///
  ///     Supports the `usedforsecurity` argument for Python 3.9+ to allow running on
  ///     a FIPS-enabled system.
  ///     """
  ///     if sys.version_info >= (3, 9):
  ///         return hashlib.sha256(s.encode('utf8'), usedforsecurity=False).hexdigest()
  ///     else:
  ///         return hashlib.sha256(s.encode('utf8')).hexdigest()
  /// ```
  String sha256_digest({
    required String s,
  }) =>
      getFunction("sha256_digest").call(
        <Object?>[
          s,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## symbol_from_strcase
  ///
  /// ### python source
  /// ```py
  /// def symbol_from_strcase(s):
  ///     assert isinstance(s, str)
  ///     return Terminal(s, filter_out=s.startswith('_')) if s.isupper() else NonTerminal(s)
  /// ```
  Object? symbol_from_strcase({
    required Object? s,
  }) =>
      getFunction("symbol_from_strcase").call(
        <Object?>[
          s,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## verify_used_files
  ///
  /// ### python source
  /// ```py
  /// def verify_used_files(file_hashes):
  ///     for path, old in file_hashes.items():
  ///         text = None
  ///         if isinstance(path, str) and os.path.exists(path):
  ///             with open(path, encoding='utf8') as f:
  ///                 text = f.read()
  ///         elif isinstance(path, PackageResource):
  ///             with suppress(IOError):
  ///                 text = pkgutil.get_data(*path).decode('utf-8')
  ///         if text is None: # We don't know how to load the path. ignore it.
  ///             continue
  ///
  ///         current = sha256_digest(text)
  ///         if old != current:
  ///             logger.info("File %r changed, rebuilding Parser" % path)
  ///             return False
  ///     return True
  /// ```
  Object? verify_used_files({
    required Object? file_hashes,
  }) =>
      getFunction("verify_used_files").call(
        <Object?>[
          file_hashes,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## stdlib_loader (getter)
  ///
  /// ### python docstring
  ///
  /// Parses and creates Grammar objects
  Object? get stdlib_loader => getAttribute("stdlib_loader");

  /// ## stdlib_loader (setter)
  ///
  /// ### python docstring
  ///
  /// Parses and creates Grammar objects
  set stdlib_loader(Object? stdlib_loader) =>
      setAttribute("stdlib_loader", stdlib_loader);

  /// ## EXT (getter)
  ///
  /// ### python docstring
  ///
  /// Parses and creates Grammar objects
  Object? get EXT => getAttribute("EXT");

  /// ## EXT (setter)
  ///
  /// ### python docstring
  ///
  /// Parses and creates Grammar objects
  set EXT(Object? EXT) => setAttribute("EXT", EXT);

  /// ## GRAMMAR_ERRORS (getter)
  ///
  /// ### python docstring
  ///
  /// Parses and creates Grammar objects
  Object? get GRAMMAR_ERRORS => getAttribute("GRAMMAR_ERRORS");

  /// ## GRAMMAR_ERRORS (setter)
  ///
  /// ### python docstring
  ///
  /// Parses and creates Grammar objects
  set GRAMMAR_ERRORS(Object? GRAMMAR_ERRORS) =>
      setAttribute("GRAMMAR_ERRORS", GRAMMAR_ERRORS);

  /// ## IMPORT_PATHS (getter)
  ///
  /// ### python docstring
  ///
  /// Parses and creates Grammar objects
  Object? get IMPORT_PATHS => getAttribute("IMPORT_PATHS");

  /// ## IMPORT_PATHS (setter)
  ///
  /// ### python docstring
  ///
  /// Parses and creates Grammar objects
  set IMPORT_PATHS(Object? IMPORT_PATHS) =>
      setAttribute("IMPORT_PATHS", IMPORT_PATHS);

  /// ## REPEAT_BREAK_THRESHOLD (getter)
  ///
  /// ### python docstring
  ///
  /// Parses and creates Grammar objects
  Object? get REPEAT_BREAK_THRESHOLD => getAttribute("REPEAT_BREAK_THRESHOLD");

  /// ## REPEAT_BREAK_THRESHOLD (setter)
  ///
  /// ### python docstring
  ///
  /// Parses and creates Grammar objects
  set REPEAT_BREAK_THRESHOLD(Object? REPEAT_BREAK_THRESHOLD) =>
      setAttribute("REPEAT_BREAK_THRESHOLD", REPEAT_BREAK_THRESHOLD);

  /// ## RULES (getter)
  ///
  /// ### python docstring
  ///
  /// Parses and creates Grammar objects
  Object? get RULES => getAttribute("RULES");

  /// ## RULES (setter)
  ///
  /// ### python docstring
  ///
  /// Parses and creates Grammar objects
  set RULES(Object? RULES) => setAttribute("RULES", RULES);

  /// ## SMALL_FACTOR_THRESHOLD (getter)
  ///
  /// ### python docstring
  ///
  /// Parses and creates Grammar objects
  Object? get SMALL_FACTOR_THRESHOLD => getAttribute("SMALL_FACTOR_THRESHOLD");

  /// ## SMALL_FACTOR_THRESHOLD (setter)
  ///
  /// ### python docstring
  ///
  /// Parses and creates Grammar objects
  set SMALL_FACTOR_THRESHOLD(Object? SMALL_FACTOR_THRESHOLD) =>
      setAttribute("SMALL_FACTOR_THRESHOLD", SMALL_FACTOR_THRESHOLD);

  /// ## TERMINALS (getter)
  ///
  /// ### python docstring
  ///
  /// Parses and creates Grammar objects
  Object? get TERMINALS => getAttribute("TERMINALS");

  /// ## TERMINALS (setter)
  ///
  /// ### python docstring
  ///
  /// Parses and creates Grammar objects
  set TERMINALS(Object? TERMINALS) => setAttribute("TERMINALS", TERMINALS);

  /// ## TOKEN_DEFAULT_PRIORITY (getter)
  ///
  /// ### python docstring
  ///
  /// Parses and creates Grammar objects
  Object? get TOKEN_DEFAULT_PRIORITY => getAttribute("TOKEN_DEFAULT_PRIORITY");

  /// ## TOKEN_DEFAULT_PRIORITY (setter)
  ///
  /// ### python docstring
  ///
  /// Parses and creates Grammar objects
  set TOKEN_DEFAULT_PRIORITY(Object? TOKEN_DEFAULT_PRIORITY) =>
      setAttribute("TOKEN_DEFAULT_PRIORITY", TOKEN_DEFAULT_PRIORITY);
}

/// ## sys
final class sys extends PythonModule {
  sys.from(super.pythonModule) : super.from();

  static sys import() => PythonFfiDart.instance.importModule(
        "sys",
        sys.from,
      );

  /// ## abiflags (getter)
  Object? get abiflags => getAttribute("abiflags");

  /// ## abiflags (setter)
  set abiflags(Object? abiflags) => setAttribute("abiflags", abiflags);

  /// ## api_version (getter)
  Object? get api_version => getAttribute("api_version");

  /// ## api_version (setter)
  set api_version(Object? api_version) =>
      setAttribute("api_version", api_version);

  /// ## argv (getter)
  Object? get argv => getAttribute("argv");

  /// ## argv (setter)
  set argv(Object? argv) => setAttribute("argv", argv);

  /// ## base_exec_prefix (getter)
  Object? get base_exec_prefix => getAttribute("base_exec_prefix");

  /// ## base_exec_prefix (setter)
  set base_exec_prefix(Object? base_exec_prefix) =>
      setAttribute("base_exec_prefix", base_exec_prefix);

  /// ## base_prefix (getter)
  Object? get base_prefix => getAttribute("base_prefix");

  /// ## base_prefix (setter)
  set base_prefix(Object? base_prefix) =>
      setAttribute("base_prefix", base_prefix);

  /// ## builtin_module_names (getter)
  Object? get builtin_module_names => getAttribute("builtin_module_names");

  /// ## builtin_module_names (setter)
  set builtin_module_names(Object? builtin_module_names) =>
      setAttribute("builtin_module_names", builtin_module_names);

  /// ## byteorder (getter)
  Object? get byteorder => getAttribute("byteorder");

  /// ## byteorder (setter)
  set byteorder(Object? byteorder) => setAttribute("byteorder", byteorder);

  /// ## copyright (getter)
  Object? get copyright => getAttribute("copyright");

  /// ## copyright (setter)
  set copyright(Object? copyright) => setAttribute("copyright", copyright);

  /// ## dont_write_bytecode (getter)
  Object? get dont_write_bytecode => getAttribute("dont_write_bytecode");

  /// ## dont_write_bytecode (setter)
  set dont_write_bytecode(Object? dont_write_bytecode) =>
      setAttribute("dont_write_bytecode", dont_write_bytecode);

  /// ## exec_prefix (getter)
  Object? get exec_prefix => getAttribute("exec_prefix");

  /// ## exec_prefix (setter)
  set exec_prefix(Object? exec_prefix) =>
      setAttribute("exec_prefix", exec_prefix);

  /// ## executable (getter)
  Object? get executable => getAttribute("executable");

  /// ## executable (setter)
  set executable(Object? executable) => setAttribute("executable", executable);

  /// ## flags (getter)
  Object? get flags => getAttribute("flags");

  /// ## flags (setter)
  set flags(Object? flags) => setAttribute("flags", flags);

  /// ## float_info (getter)
  Object? get float_info => getAttribute("float_info");

  /// ## float_info (setter)
  set float_info(Object? float_info) => setAttribute("float_info", float_info);

  /// ## float_repr_style (getter)
  Object? get float_repr_style => getAttribute("float_repr_style");

  /// ## float_repr_style (setter)
  set float_repr_style(Object? float_repr_style) =>
      setAttribute("float_repr_style", float_repr_style);

  /// ## hash_info (getter)
  Object? get hash_info => getAttribute("hash_info");

  /// ## hash_info (setter)
  set hash_info(Object? hash_info) => setAttribute("hash_info", hash_info);

  /// ## hexversion (getter)
  Object? get hexversion => getAttribute("hexversion");

  /// ## hexversion (setter)
  set hexversion(Object? hexversion) => setAttribute("hexversion", hexversion);

  /// ## int_info (getter)
  Object? get int_info => getAttribute("int_info");

  /// ## int_info (setter)
  set int_info(Object? int_info) => setAttribute("int_info", int_info);

  /// ## maxsize (getter)
  Object? get maxsize => getAttribute("maxsize");

  /// ## maxsize (setter)
  set maxsize(Object? maxsize) => setAttribute("maxsize", maxsize);

  /// ## maxunicode (getter)
  Object? get maxunicode => getAttribute("maxunicode");

  /// ## maxunicode (setter)
  set maxunicode(Object? maxunicode) => setAttribute("maxunicode", maxunicode);

  /// ## meta_path (getter)
  Object? get meta_path => getAttribute("meta_path");

  /// ## meta_path (setter)
  set meta_path(Object? meta_path) => setAttribute("meta_path", meta_path);

  /// ## modules (getter)
  Object? get modules => getAttribute("modules");

  /// ## modules (setter)
  set modules(Object? modules) => setAttribute("modules", modules);

  /// ## orig_argv (getter)
  Object? get orig_argv => getAttribute("orig_argv");

  /// ## orig_argv (setter)
  set orig_argv(Object? orig_argv) => setAttribute("orig_argv", orig_argv);

  /// ## path (getter)
  Object? get path => getAttribute("path");

  /// ## path (setter)
  set path(Object? path) => setAttribute("path", path);

  /// ## path_hooks (getter)
  Object? get path_hooks => getAttribute("path_hooks");

  /// ## path_hooks (setter)
  set path_hooks(Object? path_hooks) => setAttribute("path_hooks", path_hooks);

  /// ## path_importer_cache (getter)
  Object? get path_importer_cache => getAttribute("path_importer_cache");

  /// ## path_importer_cache (setter)
  set path_importer_cache(Object? path_importer_cache) =>
      setAttribute("path_importer_cache", path_importer_cache);

  /// ## platform (getter)
  Object? get $platform => getAttribute("platform");

  /// ## platform (setter)
  set $platform(Object? $platform) => setAttribute("platform", $platform);

  /// ## platlibdir (getter)
  Object? get platlibdir => getAttribute("platlibdir");

  /// ## platlibdir (setter)
  set platlibdir(Object? platlibdir) => setAttribute("platlibdir", platlibdir);

  /// ## prefix (getter)
  Object? get prefix => getAttribute("prefix");

  /// ## prefix (setter)
  set prefix(Object? prefix) => setAttribute("prefix", prefix);

  /// ## pycache_prefix (getter)
  Null get pycache_prefix => getAttribute("pycache_prefix");

  /// ## pycache_prefix (setter)
  set pycache_prefix(Null pycache_prefix) =>
      setAttribute("pycache_prefix", pycache_prefix);

  /// ## thread_info (getter)
  Object? get thread_info => getAttribute("thread_info");

  /// ## thread_info (setter)
  set thread_info(Object? thread_info) =>
      setAttribute("thread_info", thread_info);

  /// ## version (getter)
  Object? get version => getAttribute("version");

  /// ## version (setter)
  set version(Object? version) => setAttribute("version", version);

  /// ## version_info (getter)
  Object? get version_info => getAttribute("version_info");

  /// ## version_info (setter)
  set version_info(Object? version_info) =>
      setAttribute("version_info", version_info);

  /// ## warnoptions (getter)
  Object? get warnoptions => getAttribute("warnoptions");

  /// ## warnoptions (setter)
  set warnoptions(Object? warnoptions) =>
      setAttribute("warnoptions", warnoptions);
}
