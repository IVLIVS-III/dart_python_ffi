// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library earley_common;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## Item
///
/// ### python docstring
///
/// An Earley Item, the atom of the algorithm.
///
/// ### python source
/// ```py
/// class Item:
///     "An Earley Item, the atom of the algorithm."
///
///     __slots__ = ('s', 'rule', 'ptr', 'start', 'is_complete', 'expect', 'previous', 'node', '_hash')
///     def __init__(self, rule, ptr, start):
///         self.is_complete = len(rule.expansion) == ptr
///         self.rule = rule    # rule
///         self.ptr = ptr      # ptr
///         self.start = start  # j
///         self.node = None    # w
///         if self.is_complete:
///             self.s = rule.origin
///             self.expect = None
///             self.previous = rule.expansion[ptr - 1] if ptr > 0 and len(rule.expansion) else None
///         else:
///             self.s = (rule, ptr)
///             self.expect = rule.expansion[ptr]
///             self.previous = rule.expansion[ptr - 1] if ptr > 0 and len(rule.expansion) else None
///         self._hash = hash((self.s, self.start))
///
///     def advance(self):
///         return Item(self.rule, self.ptr + 1, self.start)
///
///     def __eq__(self, other):
///         return self is other or (self.s == other.s and self.start == other.start)
///
///     def __hash__(self):
///         return self._hash
///
///     def __repr__(self):
///         before = ( expansion.name for expansion in self.rule.expansion[:self.ptr] )
///         after = ( expansion.name for expansion in self.rule.expansion[self.ptr:] )
///         symbol = "{} ::= {}* {}".format(self.rule.origin.name, ' '.join(before), ' '.join(after))
///         return '%s (%d)' % (symbol, self.start)
/// ```
final class Item extends PythonClass {
  factory Item({
    required Object? rule,
    required Object? ptr,
    required Object? start,
  }) =>
      PythonFfiDart.instance.importClass(
        "lark.parsers.earley_common",
        "Item",
        Item.from,
        <Object?>[
          rule,
          ptr,
          start,
        ],
        <String, Object?>{},
      );

  Item.from(super.pythonClass) : super.from();

  /// ## advance
  ///
  /// ### python source
  /// ```py
  /// def advance(self):
  ///         return Item(self.rule, self.ptr + 1, self.start)
  /// ```
  Object? advance() => getFunction("advance").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## expect (getter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  Object? get expect => getAttribute("expect");

  /// ## expect (setter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  set expect(Object? expect) => setAttribute("expect", expect);

  /// ## is_complete (getter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  Object? get is_complete => getAttribute("is_complete");

  /// ## is_complete (setter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  set is_complete(Object? is_complete) =>
      setAttribute("is_complete", is_complete);

  /// ## node (getter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  Object? get node => getAttribute("node");

  /// ## node (setter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  set node(Object? node) => setAttribute("node", node);

  /// ## previous (getter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  Object? get previous => getAttribute("previous");

  /// ## previous (setter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  set previous(Object? previous) => setAttribute("previous", previous);

  /// ## ptr (getter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  Object? get ptr => getAttribute("ptr");

  /// ## ptr (setter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  set ptr(Object? ptr) => setAttribute("ptr", ptr);

  /// ## rule (getter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  Object? get rule => getAttribute("rule");

  /// ## rule (setter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  set rule(Object? rule) => setAttribute("rule", rule);

  /// ## s (getter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  Object? get s => getAttribute("s");

  /// ## s (setter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  set s(Object? s) => setAttribute("s", s);

  /// ## start (getter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  Object? get start => getAttribute("start");

  /// ## start (setter)
  ///
  /// ### python docstring
  ///
  /// An Earley Item, the atom of the algorithm.
  set start(Object? start) => setAttribute("start", start);
}

/// ## earley_common
///
/// ### python docstring
///
/// This module implements useful building blocks for the Earley parser
///
/// ### python source
/// ```py
/// """This module implements useful building blocks for the Earley parser
/// """
///
///
/// class Item:
///     "An Earley Item, the atom of the algorithm."
///
///     __slots__ = ('s', 'rule', 'ptr', 'start', 'is_complete', 'expect', 'previous', 'node', '_hash')
///     def __init__(self, rule, ptr, start):
///         self.is_complete = len(rule.expansion) == ptr
///         self.rule = rule    # rule
///         self.ptr = ptr      # ptr
///         self.start = start  # j
///         self.node = None    # w
///         if self.is_complete:
///             self.s = rule.origin
///             self.expect = None
///             self.previous = rule.expansion[ptr - 1] if ptr > 0 and len(rule.expansion) else None
///         else:
///             self.s = (rule, ptr)
///             self.expect = rule.expansion[ptr]
///             self.previous = rule.expansion[ptr - 1] if ptr > 0 and len(rule.expansion) else None
///         self._hash = hash((self.s, self.start))
///
///     def advance(self):
///         return Item(self.rule, self.ptr + 1, self.start)
///
///     def __eq__(self, other):
///         return self is other or (self.s == other.s and self.start == other.start)
///
///     def __hash__(self):
///         return self._hash
///
///     def __repr__(self):
///         before = ( expansion.name for expansion in self.rule.expansion[:self.ptr] )
///         after = ( expansion.name for expansion in self.rule.expansion[self.ptr:] )
///         symbol = "{} ::= {}* {}".format(self.rule.origin.name, ' '.join(before), ' '.join(after))
///         return '%s (%d)' % (symbol, self.start)
///
///
/// # class TransitiveItem(Item):
/// #   ...   # removed at commit 4c1cfb2faf24e8f8bff7112627a00b94d261b420
/// ```
final class earley_common extends PythonModule {
  earley_common.from(super.pythonModule) : super.from();

  static earley_common import() => PythonFfiDart.instance.importModule(
        "lark.parsers.earley_common",
        earley_common.from,
      );
}
