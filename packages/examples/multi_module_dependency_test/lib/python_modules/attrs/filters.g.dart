// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library filters;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## Attribute
///
/// ### python docstring
///
/// *Read-only* representation of an attribute.
///
/// .. warning::
///
///    You should never instantiate this class yourself.
///
/// The class has *all* arguments of `attr.ib` (except for ``factory``
/// which is only syntactic sugar for ``default=Factory(...)`` plus the
/// following:
///
/// - ``name`` (`str`): The name of the attribute.
/// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
///   any explicit overrides and default private-attribute-name handling.
/// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
///   from a base class.
/// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
///   that are used for comparing and ordering objects by this attribute,
///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
///   <custom-comparison>`.
///
/// Instances of this class are frequently used for introspection purposes
/// like:
///
/// - `fields` returns a tuple of them.
/// - Validators get them passed as the first argument.
/// - The :ref:`field transformer <transform-fields>` hook receives a list of
///   them.
/// - The ``alias`` property exposes the __init__ parameter name of the field,
///   with any overrides and default private-attribute handling applied.
///
///
/// .. versionadded:: 20.1.0 *inherited*
/// .. versionadded:: 20.1.0 *on_setattr*
/// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
///     equality checks and hashing anymore.
/// .. versionadded:: 21.1.0 *eq_key* and *order_key*
/// .. versionadded:: 22.2.0 *alias*
///
/// For the full version history of the fields, see `attr.ib`.
///
/// ### python source
/// ```py
/// class Attribute:
///     """
///     *Read-only* representation of an attribute.
///
///     .. warning::
///
///        You should never instantiate this class yourself.
///
///     The class has *all* arguments of `attr.ib` (except for ``factory``
///     which is only syntactic sugar for ``default=Factory(...)`` plus the
///     following:
///
///     - ``name`` (`str`): The name of the attribute.
///     - ``alias`` (`str`): The __init__ parameter name of the attribute, after
///       any explicit overrides and default private-attribute-name handling.
///     - ``inherited`` (`bool`): Whether or not that attribute has been inherited
///       from a base class.
///     - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
///       that are used for comparing and ordering objects by this attribute,
///       respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
///       ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
///       <custom-comparison>`.
///
///     Instances of this class are frequently used for introspection purposes
///     like:
///
///     - `fields` returns a tuple of them.
///     - Validators get them passed as the first argument.
///     - The :ref:`field transformer <transform-fields>` hook receives a list of
///       them.
///     - The ``alias`` property exposes the __init__ parameter name of the field,
///       with any overrides and default private-attribute handling applied.
///
///
///     .. versionadded:: 20.1.0 *inherited*
///     .. versionadded:: 20.1.0 *on_setattr*
///     .. versionchanged:: 20.2.0 *inherited* is not taken into account for
///         equality checks and hashing anymore.
///     .. versionadded:: 21.1.0 *eq_key* and *order_key*
///     .. versionadded:: 22.2.0 *alias*
///
///     For the full version history of the fields, see `attr.ib`.
///     """
///
///     __slots__ = (
///         "name",
///         "default",
///         "validator",
///         "repr",
///         "eq",
///         "eq_key",
///         "order",
///         "order_key",
///         "hash",
///         "init",
///         "metadata",
///         "type",
///         "converter",
///         "kw_only",
///         "inherited",
///         "on_setattr",
///         "alias",
///     )
///
///     def __init__(
///         self,
///         name,
///         default,
///         validator,
///         repr,
///         cmp,  # XXX: unused, remove along with other cmp code.
///         hash,
///         init,
///         inherited,
///         metadata=None,
///         type=None,
///         converter=None,
///         kw_only=False,
///         eq=None,
///         eq_key=None,
///         order=None,
///         order_key=None,
///         on_setattr=None,
///         alias=None,
///     ):
///         eq, eq_key, order, order_key = _determine_attrib_eq_order(
///             cmp, eq_key or eq, order_key or order, True
///         )
///
///         # Cache this descriptor here to speed things up later.
///         bound_setattr = _obj_setattr.__get__(self)
///
///         # Despite the big red warning, people *do* instantiate `Attribute`
///         # themselves.
///         bound_setattr("name", name)
///         bound_setattr("default", default)
///         bound_setattr("validator", validator)
///         bound_setattr("repr", repr)
///         bound_setattr("eq", eq)
///         bound_setattr("eq_key", eq_key)
///         bound_setattr("order", order)
///         bound_setattr("order_key", order_key)
///         bound_setattr("hash", hash)
///         bound_setattr("init", init)
///         bound_setattr("converter", converter)
///         bound_setattr(
///             "metadata",
///             (
///                 types.MappingProxyType(dict(metadata))  # Shallow copy
///                 if metadata
///                 else _empty_metadata_singleton
///             ),
///         )
///         bound_setattr("type", type)
///         bound_setattr("kw_only", kw_only)
///         bound_setattr("inherited", inherited)
///         bound_setattr("on_setattr", on_setattr)
///         bound_setattr("alias", alias)
///
///     def __setattr__(self, name, value):
///         raise FrozenInstanceError()
///
///     @classmethod
///     def from_counting_attr(cls, name, ca, type=None):
///         # type holds the annotated value. deal with conflicts:
///         if type is None:
///             type = ca.type
///         elif ca.type is not None:
///             raise ValueError(
///                 "Type annotation and type argument cannot both be present"
///             )
///         inst_dict = {
///             k: getattr(ca, k)
///             for k in Attribute.__slots__
///             if k
///             not in (
///                 "name",
///                 "validator",
///                 "default",
///                 "type",
///                 "inherited",
///             )  # exclude methods and deprecated alias
///         }
///         return cls(
///             name=name,
///             validator=ca._validator,
///             default=ca._default,
///             type=type,
///             cmp=None,
///             inherited=False,
///             **inst_dict,
///         )
///
///     # Don't use attrs.evolve since fields(Attribute) doesn't work
///     def evolve(self, **changes):
///         """
///         Copy *self* and apply *changes*.
///
///         This works similarly to `attrs.evolve` but that function does not work
///         with `Attribute`.
///
///         It is mainly meant to be used for `transform-fields`.
///
///         .. versionadded:: 20.3.0
///         """
///         new = copy.copy(self)
///
///         new._setattrs(changes.items())
///
///         return new
///
///     # Don't use _add_pickle since fields(Attribute) doesn't work
///     def __getstate__(self):
///         """
///         Play nice with pickle.
///         """
///         return tuple(
///             getattr(self, name) if name != "metadata" else dict(self.metadata)
///             for name in self.__slots__
///         )
///
///     def __setstate__(self, state):
///         """
///         Play nice with pickle.
///         """
///         self._setattrs(zip(self.__slots__, state))
///
///     def _setattrs(self, name_values_pairs):
///         bound_setattr = _obj_setattr.__get__(self)
///         for name, value in name_values_pairs:
///             if name != "metadata":
///                 bound_setattr(name, value)
///             else:
///                 bound_setattr(
///                     name,
///                     types.MappingProxyType(dict(value))
///                     if value
///                     else _empty_metadata_singleton,
///                 )
/// ```
final class Attribute extends PythonClass {
  factory Attribute({
    required Object? name,
    required Object? $default,
    required Object? validator,
    required Object? repr,
    required Object? cmp,
    required Object? hash,
    required Object? init,
    required Object? inherited,
    Object? metadata,
    Object? type,
    Object? converter,
    Object? kw_only = false,
    Object? eq,
    Object? eq_key,
    Object? order,
    Object? order_key,
    Object? on_setattr,
    Object? alias,
  }) =>
      PythonFfiDart.instance.importClass(
        "attrs.filters",
        "Attribute",
        Attribute.from,
        <Object?>[
          name,
          $default,
          validator,
          repr,
          cmp,
          hash,
          init,
          inherited,
          metadata,
          type,
          converter,
          kw_only,
          eq,
          eq_key,
          order,
          order_key,
          on_setattr,
          alias,
        ],
        <String, Object?>{},
      );

  Attribute.from(super.pythonClass) : super.from();

  /// ## evolve
  ///
  /// ### python docstring
  ///
  /// Copy *self* and apply *changes*.
  ///
  /// This works similarly to `attrs.evolve` but that function does not work
  /// with `Attribute`.
  ///
  /// It is mainly meant to be used for `transform-fields`.
  ///
  /// .. versionadded:: 20.3.0
  ///
  /// ### python source
  /// ```py
  /// def evolve(self, **changes):
  ///         """
  ///         Copy *self* and apply *changes*.
  ///
  ///         This works similarly to `attrs.evolve` but that function does not work
  ///         with `Attribute`.
  ///
  ///         It is mainly meant to be used for `transform-fields`.
  ///
  ///         .. versionadded:: 20.3.0
  ///         """
  ///         new = copy.copy(self)
  ///
  ///         new._setattrs(changes.items())
  ///
  ///         return new
  /// ```
  Object? evolve({
    Map<String, Object?> changes = const <String, Object?>{},
  }) =>
      getFunction("evolve").call(
        <Object?>[],
        kwargs: <String, Object?>{
          ...changes,
        },
      );

  /// ## alias (getter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  Object? get alias => getAttribute("alias");

  /// ## alias (setter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  set alias(Object? alias) => setAttribute("alias", alias);

  /// ## converter (getter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  Object? get converter => getAttribute("converter");

  /// ## converter (setter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  set converter(Object? converter) => setAttribute("converter", converter);

  /// ## default (getter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  Object? get $default => getAttribute("default");

  /// ## default (setter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  set $default(Object? $default) => setAttribute("default", $default);

  /// ## eq (getter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  Object? get eq => getAttribute("eq");

  /// ## eq (setter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  set eq(Object? eq) => setAttribute("eq", eq);

  /// ## eq_key (getter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  Object? get eq_key => getAttribute("eq_key");

  /// ## eq_key (setter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  set eq_key(Object? eq_key) => setAttribute("eq_key", eq_key);

  /// ## hash (getter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  Object? get hash => getAttribute("hash");

  /// ## hash (setter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  set hash(Object? hash) => setAttribute("hash", hash);

  /// ## inherited (getter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  Object? get inherited => getAttribute("inherited");

  /// ## inherited (setter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  set inherited(Object? inherited) => setAttribute("inherited", inherited);

  /// ## init (getter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  Object? get init => getAttribute("init");

  /// ## init (setter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  set init(Object? init) => setAttribute("init", init);

  /// ## kw_only (getter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  Object? get kw_only => getAttribute("kw_only");

  /// ## kw_only (setter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  set kw_only(Object? kw_only) => setAttribute("kw_only", kw_only);

  /// ## metadata (getter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  Object? get metadata => getAttribute("metadata");

  /// ## metadata (setter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  set metadata(Object? metadata) => setAttribute("metadata", metadata);

  /// ## name (getter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  Object? get name => getAttribute("name");

  /// ## name (setter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  set name(Object? name) => setAttribute("name", name);

  /// ## on_setattr (getter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  Object? get on_setattr => getAttribute("on_setattr");

  /// ## on_setattr (setter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  set on_setattr(Object? on_setattr) => setAttribute("on_setattr", on_setattr);

  /// ## order (getter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  Object? get order => getAttribute("order");

  /// ## order (setter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  set order(Object? order) => setAttribute("order", order);

  /// ## order_key (getter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  Object? get order_key => getAttribute("order_key");

  /// ## order_key (setter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  set order_key(Object? order_key) => setAttribute("order_key", order_key);

  /// ## repr (getter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  Object? get repr => getAttribute("repr");

  /// ## repr (setter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  set repr(Object? repr) => setAttribute("repr", repr);

  /// ## type (getter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  Object? get type => getAttribute("type");

  /// ## type (setter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  set type(Object? type) => setAttribute("type", type);

  /// ## validator (getter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  Object? get validator => getAttribute("validator");

  /// ## validator (setter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  set validator(Object? validator) => setAttribute("validator", validator);

  /// ## from_counting_attr (getter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  Object? get from_counting_attr => getAttribute("from_counting_attr");

  /// ## from_counting_attr (setter)
  ///
  /// ### python docstring
  ///
  /// *Read-only* representation of an attribute.
  ///
  /// .. warning::
  ///
  ///    You should never instantiate this class yourself.
  ///
  /// The class has *all* arguments of `attr.ib` (except for ``factory``
  /// which is only syntactic sugar for ``default=Factory(...)`` plus the
  /// following:
  ///
  /// - ``name`` (`str`): The name of the attribute.
  /// - ``alias`` (`str`): The __init__ parameter name of the attribute, after
  ///   any explicit overrides and default private-attribute-name handling.
  /// - ``inherited`` (`bool`): Whether or not that attribute has been inherited
  ///   from a base class.
  /// - ``eq_key`` and ``order_key`` (`typing.Callable` or `None`): The callables
  ///   that are used for comparing and ordering objects by this attribute,
  ///   respectively. These are set by passing a callable to `attr.ib`'s ``eq``,
  ///   ``order``, or ``cmp`` arguments. See also :ref:`comparison customization
  ///   <custom-comparison>`.
  ///
  /// Instances of this class are frequently used for introspection purposes
  /// like:
  ///
  /// - `fields` returns a tuple of them.
  /// - Validators get them passed as the first argument.
  /// - The :ref:`field transformer <transform-fields>` hook receives a list of
  ///   them.
  /// - The ``alias`` property exposes the __init__ parameter name of the field,
  ///   with any overrides and default private-attribute handling applied.
  ///
  ///
  /// .. versionadded:: 20.1.0 *inherited*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionchanged:: 20.2.0 *inherited* is not taken into account for
  ///     equality checks and hashing anymore.
  /// .. versionadded:: 21.1.0 *eq_key* and *order_key*
  /// .. versionadded:: 22.2.0 *alias*
  ///
  /// For the full version history of the fields, see `attr.ib`.
  set from_counting_attr(Object? from_counting_attr) =>
      setAttribute("from_counting_attr", from_counting_attr);
}

/// ## filters
///
/// ### python source
/// ```py
/// # SPDX-License-Identifier: MIT
///
/// from attr.filters import *  # noqa
/// ```
final class filters extends PythonModule {
  filters.from(super.pythonModule) : super.from();

  static filters import() => PythonFfiDart.instance.importModule(
        "attrs.filters",
        filters.from,
      );

  /// ## exclude
  ///
  /// ### python docstring
  ///
  /// Exclude *what*.
  ///
  /// :param what: What to exclude.
  /// :type what: `list` of classes `type`, field names `str` or
  ///     `attrs.Attribute`\ s.
  ///
  /// :rtype: `callable`
  ///
  /// .. versionchanged:: 23.3.0 Accept field name string as input argument
  ///
  /// ### python source
  /// ```py
  /// def exclude(*what):
  ///     """
  ///     Exclude *what*.
  ///
  ///     :param what: What to exclude.
  ///     :type what: `list` of classes `type`, field names `str` or
  ///         `attrs.Attribute`\\ s.
  ///
  ///     :rtype: `callable`
  ///
  ///     .. versionchanged:: 23.3.0 Accept field name string as input argument
  ///     """
  ///     cls, names, attrs = _split_what(what)
  ///
  ///     def exclude_(attribute, value):
  ///         return not (
  ///             value.__class__ in cls
  ///             or attribute.name in names
  ///             or attribute in attrs
  ///         )
  ///
  ///     return exclude_
  /// ```
  Object? exclude({
    List<Object?> what = const <Object?>[],
  }) =>
      getFunction("exclude").call(
        <Object?>[
          ...what,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## include
  ///
  /// ### python docstring
  ///
  /// Include *what*.
  ///
  /// :param what: What to include.
  /// :type what: `list` of classes `type`, field names `str` or
  ///     `attrs.Attribute`\ s
  ///
  /// :rtype: `callable`
  ///
  /// .. versionchanged:: 23.1.0 Accept strings with field names.
  ///
  /// ### python source
  /// ```py
  /// def include(*what):
  ///     """
  ///     Include *what*.
  ///
  ///     :param what: What to include.
  ///     :type what: `list` of classes `type`, field names `str` or
  ///         `attrs.Attribute`\\ s
  ///
  ///     :rtype: `callable`
  ///
  ///     .. versionchanged:: 23.1.0 Accept strings with field names.
  ///     """
  ///     cls, names, attrs = _split_what(what)
  ///
  ///     def include_(attribute, value):
  ///         return (
  ///             value.__class__ in cls
  ///             or attribute.name in names
  ///             or attribute in attrs
  ///         )
  ///
  ///     return include_
  /// ```
  Object? include({
    List<Object?> what = const <Object?>[],
  }) =>
      getFunction("include").call(
        <Object?>[
          ...what,
        ],
        kwargs: <String, Object?>{},
      );
}
