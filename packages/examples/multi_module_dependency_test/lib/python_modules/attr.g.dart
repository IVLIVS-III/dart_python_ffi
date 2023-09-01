// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library attr;

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
        "attr._make",
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

/// ## AttrsInstance
///
/// ### python source
/// ```py
/// class AttrsInstance:
///     pass
/// ```
final class AttrsInstance extends PythonClass {
  factory AttrsInstance() => PythonFfiDart.instance.importClass(
        "attr",
        "AttrsInstance",
        AttrsInstance.from,
        <Object?>[],
      );

  AttrsInstance.from(super.pythonClass) : super.from();
}

/// ## Factory
///
/// ### python docstring
///
/// Stores a factory callable.
///
/// If passed as the default value to `attrs.field`, the factory is used to
/// generate a new value.
///
/// :param callable factory: A callable that takes either none or exactly one
///     mandatory positional argument depending on *takes_self*.
/// :param bool takes_self: Pass the partially initialized instance that is
///     being initialized as a positional argument.
///
/// .. versionadded:: 17.1.0  *takes_self*
///
/// ### python source
/// ```py
/// class Factory:
///     """
///     Stores a factory callable.
///
///     If passed as the default value to `attrs.field`, the factory is used to
///     generate a new value.
///
///     :param callable factory: A callable that takes either none or exactly one
///         mandatory positional argument depending on *takes_self*.
///     :param bool takes_self: Pass the partially initialized instance that is
///         being initialized as a positional argument.
///
///     .. versionadded:: 17.1.0  *takes_self*
///     """
///
///     __slots__ = ("factory", "takes_self")
///
///     def __init__(self, factory, takes_self=False):
///         self.factory = factory
///         self.takes_self = takes_self
///
///     def __getstate__(self):
///         """
///         Play nice with pickle.
///         """
///         return tuple(getattr(self, name) for name in self.__slots__)
///
///     def __setstate__(self, state):
///         """
///         Play nice with pickle.
///         """
///         for name, value in zip(self.__slots__, state):
///             setattr(self, name, value)
/// ```
final class Factory extends PythonClass {
  factory Factory({
    required Object? $factory,
    Object? takes_self = false,
  }) =>
      PythonFfiDart.instance.importClass(
        "attr._make",
        "Factory",
        Factory.from,
        <Object?>[
          $factory,
          takes_self,
        ],
        <String, Object?>{},
      );

  Factory.from(super.pythonClass) : super.from();

  /// ## factory (getter)
  ///
  /// ### python docstring
  ///
  /// Stores a factory callable.
  ///
  /// If passed as the default value to `attrs.field`, the factory is used to
  /// generate a new value.
  ///
  /// :param callable factory: A callable that takes either none or exactly one
  ///     mandatory positional argument depending on *takes_self*.
  /// :param bool takes_self: Pass the partially initialized instance that is
  ///     being initialized as a positional argument.
  ///
  /// .. versionadded:: 17.1.0  *takes_self*
  Object? get $factory => getAttribute("factory");

  /// ## factory (setter)
  ///
  /// ### python docstring
  ///
  /// Stores a factory callable.
  ///
  /// If passed as the default value to `attrs.field`, the factory is used to
  /// generate a new value.
  ///
  /// :param callable factory: A callable that takes either none or exactly one
  ///     mandatory positional argument depending on *takes_self*.
  /// :param bool takes_self: Pass the partially initialized instance that is
  ///     being initialized as a positional argument.
  ///
  /// .. versionadded:: 17.1.0  *takes_self*
  set $factory(Object? $factory) => setAttribute("factory", $factory);

  /// ## takes_self (getter)
  ///
  /// ### python docstring
  ///
  /// Stores a factory callable.
  ///
  /// If passed as the default value to `attrs.field`, the factory is used to
  /// generate a new value.
  ///
  /// :param callable factory: A callable that takes either none or exactly one
  ///     mandatory positional argument depending on *takes_self*.
  /// :param bool takes_self: Pass the partially initialized instance that is
  ///     being initialized as a positional argument.
  ///
  /// .. versionadded:: 17.1.0  *takes_self*
  Object? get takes_self => getAttribute("takes_self");

  /// ## takes_self (setter)
  ///
  /// ### python docstring
  ///
  /// Stores a factory callable.
  ///
  /// If passed as the default value to `attrs.field`, the factory is used to
  /// generate a new value.
  ///
  /// :param callable factory: A callable that takes either none or exactly one
  ///     mandatory positional argument depending on *takes_self*.
  /// :param bool takes_self: Pass the partially initialized instance that is
  ///     being initialized as a positional argument.
  ///
  /// .. versionadded:: 17.1.0  *takes_self*
  set takes_self(Object? takes_self) => setAttribute("takes_self", takes_self);
}

/// ## VersionInfo
///
/// ### python docstring
///
/// A version object that can be compared to tuple of length 1--4:
///
/// >>> attr.VersionInfo(19, 1, 0, "final")  <= (19, 2)
/// True
/// >>> attr.VersionInfo(19, 1, 0, "final") < (19, 1, 1)
/// True
/// >>> vi = attr.VersionInfo(19, 2, 0, "final")
/// >>> vi < (19, 1, 1)
/// False
/// >>> vi < (19,)
/// False
/// >>> vi == (19, 2,)
/// True
/// >>> vi == (19, 2, 1)
/// False
///
/// .. versionadded:: 19.2
///
/// ### python source
/// ```py
/// @total_ordering
/// @attrs(eq=False, order=False, slots=True, frozen=True)
/// class VersionInfo:
///     """
///     A version object that can be compared to tuple of length 1--4:
///
///     >>> attr.VersionInfo(19, 1, 0, "final")  <= (19, 2)
///     True
///     >>> attr.VersionInfo(19, 1, 0, "final") < (19, 1, 1)
///     True
///     >>> vi = attr.VersionInfo(19, 2, 0, "final")
///     >>> vi < (19, 1, 1)
///     False
///     >>> vi < (19,)
///     False
///     >>> vi == (19, 2,)
///     True
///     >>> vi == (19, 2, 1)
///     False
///
///     .. versionadded:: 19.2
///     """
///
///     year = attrib(type=int)
///     minor = attrib(type=int)
///     micro = attrib(type=int)
///     releaselevel = attrib(type=str)
///
///     @classmethod
///     def _from_version_string(cls, s):
///         """
///         Parse *s* and return a _VersionInfo.
///         """
///         v = s.split(".")
///         if len(v) == 3:
///             v.append("final")
///
///         return cls(
///             year=int(v[0]), minor=int(v[1]), micro=int(v[2]), releaselevel=v[3]
///         )
///
///     def _ensure_tuple(self, other):
///         """
///         Ensure *other* is a tuple of a valid length.
///
///         Returns a possibly transformed *other* and ourselves as a tuple of
///         the same length as *other*.
///         """
///
///         if self.__class__ is other.__class__:
///             other = astuple(other)
///
///         if not isinstance(other, tuple):
///             raise NotImplementedError
///
///         if not (1 <= len(other) <= 4):
///             raise NotImplementedError
///
///         return astuple(self)[: len(other)], other
///
///     def __eq__(self, other):
///         try:
///             us, them = self._ensure_tuple(other)
///         except NotImplementedError:
///             return NotImplemented
///
///         return us == them
///
///     def __lt__(self, other):
///         try:
///             us, them = self._ensure_tuple(other)
///         except NotImplementedError:
///             return NotImplemented
///
///         # Since alphabetically "dev0" < "final" < "post1" < "post2", we don't
///         # have to do anything special with releaselevel for now.
///         return us < them
/// ```
final class VersionInfo extends PythonClass {
  factory VersionInfo({
    required int year,
    required int minor,
    required int micro,
    required String releaselevel,
  }) =>
      PythonFfiDart.instance.importClass(
        "attr._version_info",
        "VersionInfo",
        VersionInfo.from,
        <Object?>[
          year,
          minor,
          micro,
          releaselevel,
        ],
        <String, Object?>{},
      );

  VersionInfo.from(super.pythonClass) : super.from();

  /// ## micro (getter)
  ///
  /// ### python docstring
  ///
  /// A version object that can be compared to tuple of length 1--4:
  ///
  /// >>> attr.VersionInfo(19, 1, 0, "final")  <= (19, 2)
  /// True
  /// >>> attr.VersionInfo(19, 1, 0, "final") < (19, 1, 1)
  /// True
  /// >>> vi = attr.VersionInfo(19, 2, 0, "final")
  /// >>> vi < (19, 1, 1)
  /// False
  /// >>> vi < (19,)
  /// False
  /// >>> vi == (19, 2,)
  /// True
  /// >>> vi == (19, 2, 1)
  /// False
  ///
  /// .. versionadded:: 19.2
  Object? get micro => getAttribute("micro");

  /// ## micro (setter)
  ///
  /// ### python docstring
  ///
  /// A version object that can be compared to tuple of length 1--4:
  ///
  /// >>> attr.VersionInfo(19, 1, 0, "final")  <= (19, 2)
  /// True
  /// >>> attr.VersionInfo(19, 1, 0, "final") < (19, 1, 1)
  /// True
  /// >>> vi = attr.VersionInfo(19, 2, 0, "final")
  /// >>> vi < (19, 1, 1)
  /// False
  /// >>> vi < (19,)
  /// False
  /// >>> vi == (19, 2,)
  /// True
  /// >>> vi == (19, 2, 1)
  /// False
  ///
  /// .. versionadded:: 19.2
  set micro(Object? micro) => setAttribute("micro", micro);

  /// ## minor (getter)
  ///
  /// ### python docstring
  ///
  /// A version object that can be compared to tuple of length 1--4:
  ///
  /// >>> attr.VersionInfo(19, 1, 0, "final")  <= (19, 2)
  /// True
  /// >>> attr.VersionInfo(19, 1, 0, "final") < (19, 1, 1)
  /// True
  /// >>> vi = attr.VersionInfo(19, 2, 0, "final")
  /// >>> vi < (19, 1, 1)
  /// False
  /// >>> vi < (19,)
  /// False
  /// >>> vi == (19, 2,)
  /// True
  /// >>> vi == (19, 2, 1)
  /// False
  ///
  /// .. versionadded:: 19.2
  Object? get minor => getAttribute("minor");

  /// ## minor (setter)
  ///
  /// ### python docstring
  ///
  /// A version object that can be compared to tuple of length 1--4:
  ///
  /// >>> attr.VersionInfo(19, 1, 0, "final")  <= (19, 2)
  /// True
  /// >>> attr.VersionInfo(19, 1, 0, "final") < (19, 1, 1)
  /// True
  /// >>> vi = attr.VersionInfo(19, 2, 0, "final")
  /// >>> vi < (19, 1, 1)
  /// False
  /// >>> vi < (19,)
  /// False
  /// >>> vi == (19, 2,)
  /// True
  /// >>> vi == (19, 2, 1)
  /// False
  ///
  /// .. versionadded:: 19.2
  set minor(Object? minor) => setAttribute("minor", minor);

  /// ## releaselevel (getter)
  ///
  /// ### python docstring
  ///
  /// A version object that can be compared to tuple of length 1--4:
  ///
  /// >>> attr.VersionInfo(19, 1, 0, "final")  <= (19, 2)
  /// True
  /// >>> attr.VersionInfo(19, 1, 0, "final") < (19, 1, 1)
  /// True
  /// >>> vi = attr.VersionInfo(19, 2, 0, "final")
  /// >>> vi < (19, 1, 1)
  /// False
  /// >>> vi < (19,)
  /// False
  /// >>> vi == (19, 2,)
  /// True
  /// >>> vi == (19, 2, 1)
  /// False
  ///
  /// .. versionadded:: 19.2
  Object? get releaselevel => getAttribute("releaselevel");

  /// ## releaselevel (setter)
  ///
  /// ### python docstring
  ///
  /// A version object that can be compared to tuple of length 1--4:
  ///
  /// >>> attr.VersionInfo(19, 1, 0, "final")  <= (19, 2)
  /// True
  /// >>> attr.VersionInfo(19, 1, 0, "final") < (19, 1, 1)
  /// True
  /// >>> vi = attr.VersionInfo(19, 2, 0, "final")
  /// >>> vi < (19, 1, 1)
  /// False
  /// >>> vi < (19,)
  /// False
  /// >>> vi == (19, 2,)
  /// True
  /// >>> vi == (19, 2, 1)
  /// False
  ///
  /// .. versionadded:: 19.2
  set releaselevel(Object? releaselevel) =>
      setAttribute("releaselevel", releaselevel);

  /// ## year (getter)
  ///
  /// ### python docstring
  ///
  /// A version object that can be compared to tuple of length 1--4:
  ///
  /// >>> attr.VersionInfo(19, 1, 0, "final")  <= (19, 2)
  /// True
  /// >>> attr.VersionInfo(19, 1, 0, "final") < (19, 1, 1)
  /// True
  /// >>> vi = attr.VersionInfo(19, 2, 0, "final")
  /// >>> vi < (19, 1, 1)
  /// False
  /// >>> vi < (19,)
  /// False
  /// >>> vi == (19, 2,)
  /// True
  /// >>> vi == (19, 2, 1)
  /// False
  ///
  /// .. versionadded:: 19.2
  Object? get year => getAttribute("year");

  /// ## year (setter)
  ///
  /// ### python docstring
  ///
  /// A version object that can be compared to tuple of length 1--4:
  ///
  /// >>> attr.VersionInfo(19, 1, 0, "final")  <= (19, 2)
  /// True
  /// >>> attr.VersionInfo(19, 1, 0, "final") < (19, 1, 1)
  /// True
  /// >>> vi = attr.VersionInfo(19, 2, 0, "final")
  /// >>> vi < (19, 1, 1)
  /// False
  /// >>> vi < (19,)
  /// False
  /// >>> vi == (19, 2,)
  /// True
  /// >>> vi == (19, 2, 1)
  /// False
  ///
  /// .. versionadded:: 19.2
  set year(Object? year) => setAttribute("year", year);
}

/// ## AttrsAttributeNotFoundError
///
/// ### python docstring
///
/// An *attrs* function couldn't find an attribute that the user asked for.
///
/// .. versionadded:: 16.2.0
///
/// ### python source
/// ```py
/// class AttrsAttributeNotFoundError(ValueError):
///     """
///     An *attrs* function couldn't find an attribute that the user asked for.
///
///     .. versionadded:: 16.2.0
///     """
/// ```
final class AttrsAttributeNotFoundError extends PythonClass {
  factory AttrsAttributeNotFoundError() => PythonFfiDart.instance.importClass(
        "attr.exceptions",
        "AttrsAttributeNotFoundError",
        AttrsAttributeNotFoundError.from,
        <Object?>[],
      );

  AttrsAttributeNotFoundError.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// An *attrs* function couldn't find an attribute that the user asked for.
  ///
  /// .. versionadded:: 16.2.0
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// An *attrs* function couldn't find an attribute that the user asked for.
  ///
  /// .. versionadded:: 16.2.0
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// An *attrs* function couldn't find an attribute that the user asked for.
  ///
  /// .. versionadded:: 16.2.0
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// An *attrs* function couldn't find an attribute that the user asked for.
  ///
  /// .. versionadded:: 16.2.0
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// An *attrs* function couldn't find an attribute that the user asked for.
  ///
  /// .. versionadded:: 16.2.0
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// An *attrs* function couldn't find an attribute that the user asked for.
  ///
  /// .. versionadded:: 16.2.0
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## DefaultAlreadySetError
///
/// ### python docstring
///
/// A default has been set when defining the field and is attempted to be reset
/// using the decorator.
///
/// .. versionadded:: 17.1.0
///
/// ### python source
/// ```py
/// class DefaultAlreadySetError(RuntimeError):
///     """
///     A default has been set when defining the field and is attempted to be reset
///     using the decorator.
///
///     .. versionadded:: 17.1.0
///     """
/// ```
final class DefaultAlreadySetError extends PythonClass {
  factory DefaultAlreadySetError() => PythonFfiDart.instance.importClass(
        "attr.exceptions",
        "DefaultAlreadySetError",
        DefaultAlreadySetError.from,
        <Object?>[],
      );

  DefaultAlreadySetError.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// A default has been set when defining the field and is attempted to be reset
  /// using the decorator.
  ///
  /// .. versionadded:: 17.1.0
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// A default has been set when defining the field and is attempted to be reset
  /// using the decorator.
  ///
  /// .. versionadded:: 17.1.0
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// A default has been set when defining the field and is attempted to be reset
  /// using the decorator.
  ///
  /// .. versionadded:: 17.1.0
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// A default has been set when defining the field and is attempted to be reset
  /// using the decorator.
  ///
  /// .. versionadded:: 17.1.0
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// A default has been set when defining the field and is attempted to be reset
  /// using the decorator.
  ///
  /// .. versionadded:: 17.1.0
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// A default has been set when defining the field and is attempted to be reset
  /// using the decorator.
  ///
  /// .. versionadded:: 17.1.0
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## FrozenAttributeError
///
/// ### python docstring
///
/// A frozen attribute has been attempted to be modified.
///
/// .. versionadded:: 20.1.0
///
/// ### python source
/// ```py
/// class FrozenAttributeError(FrozenError):
///     """
///     A frozen attribute has been attempted to be modified.
///
///     .. versionadded:: 20.1.0
///     """
/// ```
final class FrozenAttributeError extends PythonClass {
  factory FrozenAttributeError() => PythonFfiDart.instance.importClass(
        "attr.exceptions",
        "FrozenAttributeError",
        FrozenAttributeError.from,
        <Object?>[],
      );

  FrozenAttributeError.from(super.pythonClass) : super.from();

  /// ## name (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  Object? get name => getAttribute("name");

  /// ## name (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  set name(Object? name) => setAttribute("name", name);

  /// ## obj (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  Object? get obj => getAttribute("obj");

  /// ## obj (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  set obj(Object? obj) => setAttribute("obj", obj);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  set args(Object? args) => setAttribute("args", args);

  /// ## msg (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  Object? get msg => getAttribute("msg");

  /// ## msg (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen attribute has been attempted to be modified.
  ///
  /// .. versionadded:: 20.1.0
  set msg(Object? msg) => setAttribute("msg", msg);
}

/// ## FrozenError
///
/// ### python docstring
///
/// A frozen/immutable instance or attribute have been attempted to be
/// modified.
///
/// It mirrors the behavior of ``namedtuples`` by using the same error message
/// and subclassing `AttributeError`.
///
/// .. versionadded:: 20.1.0
///
/// ### python source
/// ```py
/// class FrozenError(AttributeError):
///     """
///     A frozen/immutable instance or attribute have been attempted to be
///     modified.
///
///     It mirrors the behavior of ``namedtuples`` by using the same error message
///     and subclassing `AttributeError`.
///
///     .. versionadded:: 20.1.0
///     """
///
///     msg = "can't set attribute"
///     args = [msg]
/// ```
final class FrozenError extends PythonClass {
  factory FrozenError() => PythonFfiDart.instance.importClass(
        "attr.exceptions",
        "FrozenError",
        FrozenError.from,
        <Object?>[],
      );

  FrozenError.from(super.pythonClass) : super.from();

  /// ## name (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  Object? get name => getAttribute("name");

  /// ## name (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  set name(Object? name) => setAttribute("name", name);

  /// ## obj (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  Object? get obj => getAttribute("obj");

  /// ## obj (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  set obj(Object? obj) => setAttribute("obj", obj);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  set args(Object? args) => setAttribute("args", args);

  /// ## msg (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  Object? get msg => getAttribute("msg");

  /// ## msg (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen/immutable instance or attribute have been attempted to be
  /// modified.
  ///
  /// It mirrors the behavior of ``namedtuples`` by using the same error message
  /// and subclassing `AttributeError`.
  ///
  /// .. versionadded:: 20.1.0
  set msg(Object? msg) => setAttribute("msg", msg);
}

/// ## FrozenInstanceError
///
/// ### python docstring
///
/// A frozen instance has been attempted to be modified.
///
/// .. versionadded:: 16.1.0
///
/// ### python source
/// ```py
/// class FrozenInstanceError(FrozenError):
///     """
///     A frozen instance has been attempted to be modified.
///
///     .. versionadded:: 16.1.0
///     """
/// ```
final class FrozenInstanceError extends PythonClass {
  factory FrozenInstanceError() => PythonFfiDart.instance.importClass(
        "attr.exceptions",
        "FrozenInstanceError",
        FrozenInstanceError.from,
        <Object?>[],
      );

  FrozenInstanceError.from(super.pythonClass) : super.from();

  /// ## name (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  Object? get name => getAttribute("name");

  /// ## name (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  set name(Object? name) => setAttribute("name", name);

  /// ## obj (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  Object? get obj => getAttribute("obj");

  /// ## obj (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  set obj(Object? obj) => setAttribute("obj", obj);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  set args(Object? args) => setAttribute("args", args);

  /// ## msg (getter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  Object? get msg => getAttribute("msg");

  /// ## msg (setter)
  ///
  /// ### python docstring
  ///
  /// A frozen instance has been attempted to be modified.
  ///
  /// .. versionadded:: 16.1.0
  set msg(Object? msg) => setAttribute("msg", msg);
}

/// ## NotAnAttrsClassError
///
/// ### python docstring
///
/// A non-*attrs* class has been passed into an *attrs* function.
///
/// .. versionadded:: 16.2.0
///
/// ### python source
/// ```py
/// class NotAnAttrsClassError(ValueError):
///     """
///     A non-*attrs* class has been passed into an *attrs* function.
///
///     .. versionadded:: 16.2.0
///     """
/// ```
final class NotAnAttrsClassError extends PythonClass {
  factory NotAnAttrsClassError() => PythonFfiDart.instance.importClass(
        "attr.exceptions",
        "NotAnAttrsClassError",
        NotAnAttrsClassError.from,
        <Object?>[],
      );

  NotAnAttrsClassError.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// A non-*attrs* class has been passed into an *attrs* function.
  ///
  /// .. versionadded:: 16.2.0
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// A non-*attrs* class has been passed into an *attrs* function.
  ///
  /// .. versionadded:: 16.2.0
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// A non-*attrs* class has been passed into an *attrs* function.
  ///
  /// .. versionadded:: 16.2.0
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// A non-*attrs* class has been passed into an *attrs* function.
  ///
  /// .. versionadded:: 16.2.0
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// A non-*attrs* class has been passed into an *attrs* function.
  ///
  /// .. versionadded:: 16.2.0
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// A non-*attrs* class has been passed into an *attrs* function.
  ///
  /// .. versionadded:: 16.2.0
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## NotCallableError
///
/// ### python docstring
///
/// A field requiring a callable has been set with a value that is not
/// callable.
///
/// .. versionadded:: 19.2.0
///
/// ### python source
/// ```py
/// class NotCallableError(TypeError):
///     """
///     A field requiring a callable has been set with a value that is not
///     callable.
///
///     .. versionadded:: 19.2.0
///     """
///
///     def __init__(self, msg, value):
///         super(TypeError, self).__init__(msg, value)
///         self.msg = msg
///         self.value = value
///
///     def __str__(self):
///         return str(self.msg)
/// ```
final class NotCallableError extends PythonClass {
  factory NotCallableError({
    required Object? msg,
    required Object? value,
  }) =>
      PythonFfiDart.instance.importClass(
        "attr.exceptions",
        "NotCallableError",
        NotCallableError.from,
        <Object?>[
          msg,
          value,
        ],
        <String, Object?>{},
      );

  NotCallableError.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);

  /// ## msg (getter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  Object? get msg => getAttribute("msg");

  /// ## msg (setter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  set msg(Object? msg) => setAttribute("msg", msg);

  /// ## value (getter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  Object? get value => getAttribute("value");

  /// ## value (setter)
  ///
  /// ### python docstring
  ///
  /// A field requiring a callable has been set with a value that is not
  /// callable.
  ///
  /// .. versionadded:: 19.2.0
  set value(Object? value) => setAttribute("value", value);
}

/// ## PythonTooOldError
///
/// ### python docstring
///
/// It was attempted to use an *attrs* feature that requires a newer Python
/// version.
///
/// .. versionadded:: 18.2.0
///
/// ### python source
/// ```py
/// class PythonTooOldError(RuntimeError):
///     """
///     It was attempted to use an *attrs* feature that requires a newer Python
///     version.
///
///     .. versionadded:: 18.2.0
///     """
/// ```
final class PythonTooOldError extends PythonClass {
  factory PythonTooOldError() => PythonFfiDart.instance.importClass(
        "attr.exceptions",
        "PythonTooOldError",
        PythonTooOldError.from,
        <Object?>[],
      );

  PythonTooOldError.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// It was attempted to use an *attrs* feature that requires a newer Python
  /// version.
  ///
  /// .. versionadded:: 18.2.0
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// It was attempted to use an *attrs* feature that requires a newer Python
  /// version.
  ///
  /// .. versionadded:: 18.2.0
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// It was attempted to use an *attrs* feature that requires a newer Python
  /// version.
  ///
  /// .. versionadded:: 18.2.0
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// It was attempted to use an *attrs* feature that requires a newer Python
  /// version.
  ///
  /// .. versionadded:: 18.2.0
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// It was attempted to use an *attrs* feature that requires a newer Python
  /// version.
  ///
  /// .. versionadded:: 18.2.0
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// It was attempted to use an *attrs* feature that requires a newer Python
  /// version.
  ///
  /// .. versionadded:: 18.2.0
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## UnannotatedAttributeError
///
/// ### python docstring
///
/// A class with ``auto_attribs=True`` has a field without a type annotation.
///
/// .. versionadded:: 17.3.0
///
/// ### python source
/// ```py
/// class UnannotatedAttributeError(RuntimeError):
///     """
///     A class with ``auto_attribs=True`` has a field without a type annotation.
///
///     .. versionadded:: 17.3.0
///     """
/// ```
final class UnannotatedAttributeError extends PythonClass {
  factory UnannotatedAttributeError() => PythonFfiDart.instance.importClass(
        "attr.exceptions",
        "UnannotatedAttributeError",
        UnannotatedAttributeError.from,
        <Object?>[],
      );

  UnannotatedAttributeError.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// A class with ``auto_attribs=True`` has a field without a type annotation.
  ///
  /// .. versionadded:: 17.3.0
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// A class with ``auto_attribs=True`` has a field without a type annotation.
  ///
  /// .. versionadded:: 17.3.0
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// A class with ``auto_attribs=True`` has a field without a type annotation.
  ///
  /// .. versionadded:: 17.3.0
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// A class with ``auto_attribs=True`` has a field without a type annotation.
  ///
  /// .. versionadded:: 17.3.0
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// A class with ``auto_attribs=True`` has a field without a type annotation.
  ///
  /// .. versionadded:: 17.3.0
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// A class with ``auto_attribs=True`` has a field without a type annotation.
  ///
  /// .. versionadded:: 17.3.0
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## attr
///
/// ### python docstring
///
/// Classes Without Boilerplate
///
/// ### python source
/// ```py
/// # SPDX-License-Identifier: MIT
///
/// """
/// Classes Without Boilerplate
/// """
///
/// from functools import partial
/// from typing import Callable
///
/// from . import converters, exceptions, filters, setters, validators
/// from ._cmp import cmp_using
/// from ._config import get_run_validators, set_run_validators
/// from ._funcs import asdict, assoc, astuple, evolve, has, resolve_types
/// from ._make import (
///     NOTHING,
///     Attribute,
///     Factory,
///     attrib,
///     attrs,
///     fields,
///     fields_dict,
///     make_class,
///     validate,
/// )
/// from ._next_gen import define, field, frozen, mutable
/// from ._version_info import VersionInfo
///
///
/// s = attributes = attrs
/// ib = attr = attrib
/// dataclass = partial(attrs, auto_attribs=True)  # happy Easter ;)
///
///
/// class AttrsInstance:
///     pass
///
///
/// __all__ = [
///     "Attribute",
///     "AttrsInstance",
///     "Factory",
///     "NOTHING",
///     "asdict",
///     "assoc",
///     "astuple",
///     "attr",
///     "attrib",
///     "attributes",
///     "attrs",
///     "cmp_using",
///     "converters",
///     "define",
///     "evolve",
///     "exceptions",
///     "field",
///     "fields",
///     "fields_dict",
///     "filters",
///     "frozen",
///     "get_run_validators",
///     "has",
///     "ib",
///     "make_class",
///     "mutable",
///     "resolve_types",
///     "s",
///     "set_run_validators",
///     "setters",
///     "validate",
///     "validators",
/// ]
///
///
/// def _make_getattr(mod_name: str) -> Callable:
///     """
///     Create a metadata proxy for packaging information that uses *mod_name* in
///     its warnings and errors.
///     """
///
///     def __getattr__(name: str) -> str:
///         dunder_to_metadata = {
///             "__title__": "Name",
///             "__copyright__": "",
///             "__version__": "version",
///             "__version_info__": "version",
///             "__description__": "summary",
///             "__uri__": "",
///             "__url__": "",
///             "__author__": "",
///             "__email__": "",
///             "__license__": "license",
///         }
///         if name not in dunder_to_metadata.keys():
///             raise AttributeError(f"module {mod_name} has no attribute {name}")
///
///         import sys
///         import warnings
///
///         if sys.version_info < (3, 8):
///             from importlib_metadata import metadata
///         else:
///             from importlib.metadata import metadata
///
///         if name != "__version_info__":
///             warnings.warn(
///                 f"Accessing {mod_name}.{name} is deprecated and will be "
///                 "removed in a future release. Use importlib.metadata directly "
///                 "to query for attrs's packaging metadata.",
///                 DeprecationWarning,
///                 stacklevel=2,
///             )
///
///         meta = metadata("attrs")
///         if name == "__license__":
///             return "MIT"
///         elif name == "__copyright__":
///             return "Copyright (c) 2015 Hynek Schlawack"
///         elif name in ("__uri__", "__url__"):
///             return meta["Project-URL"].split(" ", 1)[-1]
///         elif name == "__version_info__":
///             return VersionInfo._from_version_string(meta["version"])
///         elif name == "__author__":
///             return meta["Author-email"].rsplit(" ", 1)[0]
///         elif name == "__email__":
///             return meta["Author-email"].rsplit("<", 1)[1][:-1]
///
///         return meta[dunder_to_metadata[name]]
///
///     return __getattr__
///
///
/// __getattr__ = _make_getattr(__name__)
/// ```
final class attr extends PythonModule {
  attr.from(super.pythonModule) : super.from();

  static attr import() => PythonFfiDart.instance.importModule(
        "attr",
        attr.from,
      );
}

/// ## converters
///
/// ### python docstring
///
/// Commonly useful converters.
///
/// ### python source
/// ```py
/// # SPDX-License-Identifier: MIT
///
/// """
/// Commonly useful converters.
/// """
///
///
/// import typing
///
/// from ._compat import _AnnotationExtractor
/// from ._make import NOTHING, Factory, pipe
///
///
/// __all__ = [
///     "default_if_none",
///     "optional",
///     "pipe",
///     "to_bool",
/// ]
///
///
/// def optional(converter):
///     """
///     A converter that allows an attribute to be optional. An optional attribute
///     is one which can be set to ``None``.
///
///     Type annotations will be inferred from the wrapped converter's, if it
///     has any.
///
///     :param callable converter: the converter that is used for non-``None``
///         values.
///
///     .. versionadded:: 17.1.0
///     """
///
///     def optional_converter(val):
///         if val is None:
///             return None
///         return converter(val)
///
///     xtr = _AnnotationExtractor(converter)
///
///     t = xtr.get_first_param_type()
///     if t:
///         optional_converter.__annotations__["val"] = typing.Optional[t]
///
///     rt = xtr.get_return_type()
///     if rt:
///         optional_converter.__annotations__["return"] = typing.Optional[rt]
///
///     return optional_converter
///
///
/// def default_if_none(default=NOTHING, factory=None):
///     """
///     A converter that allows to replace ``None`` values by *default* or the
///     result of *factory*.
///
///     :param default: Value to be used if ``None`` is passed. Passing an instance
///        of `attrs.Factory` is supported, however the ``takes_self`` option
///        is *not*.
///     :param callable factory: A callable that takes no parameters whose result
///        is used if ``None`` is passed.
///
///     :raises TypeError: If **neither** *default* or *factory* is passed.
///     :raises TypeError: If **both** *default* and *factory* are passed.
///     :raises ValueError: If an instance of `attrs.Factory` is passed with
///        ``takes_self=True``.
///
///     .. versionadded:: 18.2.0
///     """
///     if default is NOTHING and factory is None:
///         raise TypeError("Must pass either `default` or `factory`.")
///
///     if default is not NOTHING and factory is not None:
///         raise TypeError(
///             "Must pass either `default` or `factory` but not both."
///         )
///
///     if factory is not None:
///         default = Factory(factory)
///
///     if isinstance(default, Factory):
///         if default.takes_self:
///             raise ValueError(
///                 "`takes_self` is not supported by default_if_none."
///             )
///
///         def default_if_none_converter(val):
///             if val is not None:
///                 return val
///
///             return default.factory()
///
///     else:
///
///         def default_if_none_converter(val):
///             if val is not None:
///                 return val
///
///             return default
///
///     return default_if_none_converter
///
///
/// def to_bool(val):
///     """
///     Convert "boolean" strings (e.g., from env. vars.) to real booleans.
///
///     Values mapping to :code:`True`:
///
///     - :code:`True`
///     - :code:`"true"` / :code:`"t"`
///     - :code:`"yes"` / :code:`"y"`
///     - :code:`"on"`
///     - :code:`"1"`
///     - :code:`1`
///
///     Values mapping to :code:`False`:
///
///     - :code:`False`
///     - :code:`"false"` / :code:`"f"`
///     - :code:`"no"` / :code:`"n"`
///     - :code:`"off"`
///     - :code:`"0"`
///     - :code:`0`
///
///     :raises ValueError: for any other value.
///
///     .. versionadded:: 21.3.0
///     """
///     if isinstance(val, str):
///         val = val.lower()
///     truthy = {True, "true", "t", "yes", "y", "on", "1", 1}
///     falsy = {False, "false", "f", "no", "n", "off", "0", 0}
///     try:
///         if val in truthy:
///             return True
///         if val in falsy:
///             return False
///     except TypeError:
///         # Raised when "val" is not hashable (e.g., lists)
///         pass
///     raise ValueError(f"Cannot convert value to bool: {val}")
/// ```
final class converters extends PythonModule {
  converters.from(super.pythonModule) : super.from();

  static converters import() => PythonFfiDart.instance.importModule(
        "attr.converters",
        converters.from,
      );

  /// ## default_if_none
  ///
  /// ### python docstring
  ///
  /// A converter that allows to replace ``None`` values by *default* or the
  /// result of *factory*.
  ///
  /// :param default: Value to be used if ``None`` is passed. Passing an instance
  ///    of `attrs.Factory` is supported, however the ``takes_self`` option
  ///    is *not*.
  /// :param callable factory: A callable that takes no parameters whose result
  ///    is used if ``None`` is passed.
  ///
  /// :raises TypeError: If **neither** *default* or *factory* is passed.
  /// :raises TypeError: If **both** *default* and *factory* are passed.
  /// :raises ValueError: If an instance of `attrs.Factory` is passed with
  ///    ``takes_self=True``.
  ///
  /// .. versionadded:: 18.2.0
  ///
  /// ### python source
  /// ```py
  /// def default_if_none(default=NOTHING, factory=None):
  ///     """
  ///     A converter that allows to replace ``None`` values by *default* or the
  ///     result of *factory*.
  ///
  ///     :param default: Value to be used if ``None`` is passed. Passing an instance
  ///        of `attrs.Factory` is supported, however the ``takes_self`` option
  ///        is *not*.
  ///     :param callable factory: A callable that takes no parameters whose result
  ///        is used if ``None`` is passed.
  ///
  ///     :raises TypeError: If **neither** *default* or *factory* is passed.
  ///     :raises TypeError: If **both** *default* and *factory* are passed.
  ///     :raises ValueError: If an instance of `attrs.Factory` is passed with
  ///        ``takes_self=True``.
  ///
  ///     .. versionadded:: 18.2.0
  ///     """
  ///     if default is NOTHING and factory is None:
  ///         raise TypeError("Must pass either `default` or `factory`.")
  ///
  ///     if default is not NOTHING and factory is not None:
  ///         raise TypeError(
  ///             "Must pass either `default` or `factory` but not both."
  ///         )
  ///
  ///     if factory is not None:
  ///         default = Factory(factory)
  ///
  ///     if isinstance(default, Factory):
  ///         if default.takes_self:
  ///             raise ValueError(
  ///                 "`takes_self` is not supported by default_if_none."
  ///             )
  ///
  ///         def default_if_none_converter(val):
  ///             if val is not None:
  ///                 return val
  ///
  ///             return default.factory()
  ///
  ///     else:
  ///
  ///         def default_if_none_converter(val):
  ///             if val is not None:
  ///                 return val
  ///
  ///             return default
  ///
  ///     return default_if_none_converter
  /// ```
  Object? default_if_none({
    Object? $default,
    Object? $factory,
  }) =>
      getFunction("default_if_none").call(
        <Object?>[
          $default,
          $factory,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## optional
  ///
  /// ### python docstring
  ///
  /// A converter that allows an attribute to be optional. An optional attribute
  /// is one which can be set to ``None``.
  ///
  /// Type annotations will be inferred from the wrapped converter's, if it
  /// has any.
  ///
  /// :param callable converter: the converter that is used for non-``None``
  ///     values.
  ///
  /// .. versionadded:: 17.1.0
  ///
  /// ### python source
  /// ```py
  /// def optional(converter):
  ///     """
  ///     A converter that allows an attribute to be optional. An optional attribute
  ///     is one which can be set to ``None``.
  ///
  ///     Type annotations will be inferred from the wrapped converter's, if it
  ///     has any.
  ///
  ///     :param callable converter: the converter that is used for non-``None``
  ///         values.
  ///
  ///     .. versionadded:: 17.1.0
  ///     """
  ///
  ///     def optional_converter(val):
  ///         if val is None:
  ///             return None
  ///         return converter(val)
  ///
  ///     xtr = _AnnotationExtractor(converter)
  ///
  ///     t = xtr.get_first_param_type()
  ///     if t:
  ///         optional_converter.__annotations__["val"] = typing.Optional[t]
  ///
  ///     rt = xtr.get_return_type()
  ///     if rt:
  ///         optional_converter.__annotations__["return"] = typing.Optional[rt]
  ///
  ///     return optional_converter
  /// ```
  Object? optional({
    required Object? converter,
  }) =>
      getFunction("optional").call(
        <Object?>[
          converter,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## to_bool
  ///
  /// ### python docstring
  ///
  /// Convert "boolean" strings (e.g., from env. vars.) to real booleans.
  ///
  /// Values mapping to :code:`True`:
  ///
  /// - :code:`True`
  /// - :code:`"true"` / :code:`"t"`
  /// - :code:`"yes"` / :code:`"y"`
  /// - :code:`"on"`
  /// - :code:`"1"`
  /// - :code:`1`
  ///
  /// Values mapping to :code:`False`:
  ///
  /// - :code:`False`
  /// - :code:`"false"` / :code:`"f"`
  /// - :code:`"no"` / :code:`"n"`
  /// - :code:`"off"`
  /// - :code:`"0"`
  /// - :code:`0`
  ///
  /// :raises ValueError: for any other value.
  ///
  /// .. versionadded:: 21.3.0
  ///
  /// ### python source
  /// ```py
  /// def to_bool(val):
  ///     """
  ///     Convert "boolean" strings (e.g., from env. vars.) to real booleans.
  ///
  ///     Values mapping to :code:`True`:
  ///
  ///     - :code:`True`
  ///     - :code:`"true"` / :code:`"t"`
  ///     - :code:`"yes"` / :code:`"y"`
  ///     - :code:`"on"`
  ///     - :code:`"1"`
  ///     - :code:`1`
  ///
  ///     Values mapping to :code:`False`:
  ///
  ///     - :code:`False`
  ///     - :code:`"false"` / :code:`"f"`
  ///     - :code:`"no"` / :code:`"n"`
  ///     - :code:`"off"`
  ///     - :code:`"0"`
  ///     - :code:`0`
  ///
  ///     :raises ValueError: for any other value.
  ///
  ///     .. versionadded:: 21.3.0
  ///     """
  ///     if isinstance(val, str):
  ///         val = val.lower()
  ///     truthy = {True, "true", "t", "yes", "y", "on", "1", 1}
  ///     falsy = {False, "false", "f", "no", "n", "off", "0", 0}
  ///     try:
  ///         if val in truthy:
  ///             return True
  ///         if val in falsy:
  ///             return False
  ///     except TypeError:
  ///         # Raised when "val" is not hashable (e.g., lists)
  ///         pass
  ///     raise ValueError(f"Cannot convert value to bool: {val}")
  /// ```
  Object? to_bool({
    required Object? val,
  }) =>
      getFunction("to_bool").call(
        <Object?>[
          val,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## exceptions
///
/// ### python source
/// ```py
/// # SPDX-License-Identifier: MIT
///
///
/// class FrozenError(AttributeError):
///     """
///     A frozen/immutable instance or attribute have been attempted to be
///     modified.
///
///     It mirrors the behavior of ``namedtuples`` by using the same error message
///     and subclassing `AttributeError`.
///
///     .. versionadded:: 20.1.0
///     """
///
///     msg = "can't set attribute"
///     args = [msg]
///
///
/// class FrozenInstanceError(FrozenError):
///     """
///     A frozen instance has been attempted to be modified.
///
///     .. versionadded:: 16.1.0
///     """
///
///
/// class FrozenAttributeError(FrozenError):
///     """
///     A frozen attribute has been attempted to be modified.
///
///     .. versionadded:: 20.1.0
///     """
///
///
/// class AttrsAttributeNotFoundError(ValueError):
///     """
///     An *attrs* function couldn't find an attribute that the user asked for.
///
///     .. versionadded:: 16.2.0
///     """
///
///
/// class NotAnAttrsClassError(ValueError):
///     """
///     A non-*attrs* class has been passed into an *attrs* function.
///
///     .. versionadded:: 16.2.0
///     """
///
///
/// class DefaultAlreadySetError(RuntimeError):
///     """
///     A default has been set when defining the field and is attempted to be reset
///     using the decorator.
///
///     .. versionadded:: 17.1.0
///     """
///
///
/// class UnannotatedAttributeError(RuntimeError):
///     """
///     A class with ``auto_attribs=True`` has a field without a type annotation.
///
///     .. versionadded:: 17.3.0
///     """
///
///
/// class PythonTooOldError(RuntimeError):
///     """
///     It was attempted to use an *attrs* feature that requires a newer Python
///     version.
///
///     .. versionadded:: 18.2.0
///     """
///
///
/// class NotCallableError(TypeError):
///     """
///     A field requiring a callable has been set with a value that is not
///     callable.
///
///     .. versionadded:: 19.2.0
///     """
///
///     def __init__(self, msg, value):
///         super(TypeError, self).__init__(msg, value)
///         self.msg = msg
///         self.value = value
///
///     def __str__(self):
///         return str(self.msg)
/// ```
final class exceptions extends PythonModule {
  exceptions.from(super.pythonModule) : super.from();

  static exceptions import() => PythonFfiDart.instance.importModule(
        "attr.exceptions",
        exceptions.from,
      );
}

/// ## filters
///
/// ### python docstring
///
/// Commonly useful filters for `attr.asdict`.
///
/// ### python source
/// ```py
/// # SPDX-License-Identifier: MIT
///
/// """
/// Commonly useful filters for `attr.asdict`.
/// """
///
/// from ._make import Attribute
///
///
/// def _split_what(what):
///     """
///     Returns a tuple of `frozenset`s of classes and attributes.
///     """
///     return (
///         frozenset(cls for cls in what if isinstance(cls, type)),
///         frozenset(cls for cls in what if isinstance(cls, str)),
///         frozenset(cls for cls in what if isinstance(cls, Attribute)),
///     )
///
///
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
///
///
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
final class filters extends PythonModule {
  filters.from(super.pythonModule) : super.from();

  static filters import() => PythonFfiDart.instance.importModule(
        "attr.filters",
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

/// ## setters
///
/// ### python docstring
///
/// Commonly used hooks for on_setattr.
///
/// ### python source
/// ```py
/// # SPDX-License-Identifier: MIT
///
/// """
/// Commonly used hooks for on_setattr.
/// """
///
///
/// from . import _config
/// from .exceptions import FrozenAttributeError
///
///
/// def pipe(*setters):
///     """
///     Run all *setters* and return the return value of the last one.
///
///     .. versionadded:: 20.1.0
///     """
///
///     def wrapped_pipe(instance, attrib, new_value):
///         rv = new_value
///
///         for setter in setters:
///             rv = setter(instance, attrib, rv)
///
///         return rv
///
///     return wrapped_pipe
///
///
/// def frozen(_, __, ___):
///     """
///     Prevent an attribute to be modified.
///
///     .. versionadded:: 20.1.0
///     """
///     raise FrozenAttributeError()
///
///
/// def validate(instance, attrib, new_value):
///     """
///     Run *attrib*'s validator on *new_value* if it has one.
///
///     .. versionadded:: 20.1.0
///     """
///     if _config._run_validators is False:
///         return new_value
///
///     v = attrib.validator
///     if not v:
///         return new_value
///
///     v(instance, attrib, new_value)
///
///     return new_value
///
///
/// def convert(instance, attrib, new_value):
///     """
///     Run *attrib*'s converter -- if it has one --  on *new_value* and return the
///     result.
///
///     .. versionadded:: 20.1.0
///     """
///     c = attrib.converter
///     if c:
///         return c(new_value)
///
///     return new_value
///
///
/// # Sentinel for disabling class-wide *on_setattr* hooks for certain attributes.
/// # autodata stopped working, so the docstring is inlined in the API docs.
/// NO_OP = object()
/// ```
final class setters extends PythonModule {
  setters.from(super.pythonModule) : super.from();

  static setters import() => PythonFfiDart.instance.importModule(
        "attr.setters",
        setters.from,
      );

  /// ## convert
  ///
  /// ### python docstring
  ///
  /// Run *attrib*'s converter -- if it has one --  on *new_value* and return the
  /// result.
  ///
  /// .. versionadded:: 20.1.0
  ///
  /// ### python source
  /// ```py
  /// def convert(instance, attrib, new_value):
  ///     """
  ///     Run *attrib*'s converter -- if it has one --  on *new_value* and return the
  ///     result.
  ///
  ///     .. versionadded:: 20.1.0
  ///     """
  ///     c = attrib.converter
  ///     if c:
  ///         return c(new_value)
  ///
  ///     return new_value
  /// ```
  Object? convert({
    required Object? instance,
    required Object? attrib,
    required Object? new_value,
  }) =>
      getFunction("convert").call(
        <Object?>[
          instance,
          attrib,
          new_value,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## frozen
  ///
  /// ### python docstring
  ///
  /// Prevent an attribute to be modified.
  ///
  /// .. versionadded:: 20.1.0
  ///
  /// ### python source
  /// ```py
  /// def frozen(_, __, ___):
  ///     """
  ///     Prevent an attribute to be modified.
  ///
  ///     .. versionadded:: 20.1.0
  ///     """
  ///     raise FrozenAttributeError()
  /// ```
  Object? frozen({
    required Object? $_,
    required Object? $__,
    required Object? $___,
  }) =>
      getFunction("frozen").call(
        <Object?>[
          $_,
          $__,
          $___,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## pipe
  ///
  /// ### python docstring
  ///
  /// Run all *setters* and return the return value of the last one.
  ///
  /// .. versionadded:: 20.1.0
  ///
  /// ### python source
  /// ```py
  /// def pipe(*setters):
  ///     """
  ///     Run all *setters* and return the return value of the last one.
  ///
  ///     .. versionadded:: 20.1.0
  ///     """
  ///
  ///     def wrapped_pipe(instance, attrib, new_value):
  ///         rv = new_value
  ///
  ///         for setter in setters:
  ///             rv = setter(instance, attrib, rv)
  ///
  ///         return rv
  ///
  ///     return wrapped_pipe
  /// ```
  Object? pipe({
    List<Object?> setters = const <Object?>[],
  }) =>
      getFunction("pipe").call(
        <Object?>[
          ...setters,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## validate
  ///
  /// ### python docstring
  ///
  /// Run *attrib*'s validator on *new_value* if it has one.
  ///
  /// .. versionadded:: 20.1.0
  ///
  /// ### python source
  /// ```py
  /// def validate(instance, attrib, new_value):
  ///     """
  ///     Run *attrib*'s validator on *new_value* if it has one.
  ///
  ///     .. versionadded:: 20.1.0
  ///     """
  ///     if _config._run_validators is False:
  ///         return new_value
  ///
  ///     v = attrib.validator
  ///     if not v:
  ///         return new_value
  ///
  ///     v(instance, attrib, new_value)
  ///
  ///     return new_value
  /// ```
  Object? validate({
    required Object? instance,
    required Object? attrib,
    required Object? new_value,
  }) =>
      getFunction("validate").call(
        <Object?>[
          instance,
          attrib,
          new_value,
        ],
        kwargs: <String, Object?>{},
      );
}

/// ## validators
///
/// ### python docstring
///
/// Commonly useful validators.
///
/// ### python source
/// ```py
/// # SPDX-License-Identifier: MIT
///
/// """
/// Commonly useful validators.
/// """
///
///
/// import operator
/// import re
///
/// from contextlib import contextmanager
/// from re import Pattern
///
/// from ._config import get_run_validators, set_run_validators
/// from ._make import _AndValidator, and_, attrib, attrs
/// from .converters import default_if_none
/// from .exceptions import NotCallableError
///
///
/// __all__ = [
///     "and_",
///     "deep_iterable",
///     "deep_mapping",
///     "disabled",
///     "ge",
///     "get_disabled",
///     "gt",
///     "in_",
///     "instance_of",
///     "is_callable",
///     "le",
///     "lt",
///     "matches_re",
///     "max_len",
///     "min_len",
///     "not_",
///     "optional",
///     "provides",
///     "set_disabled",
/// ]
///
///
/// def set_disabled(disabled):
///     """
///     Globally disable or enable running validators.
///
///     By default, they are run.
///
///     :param disabled: If ``True``, disable running all validators.
///     :type disabled: bool
///
///     .. warning::
///
///         This function is not thread-safe!
///
///     .. versionadded:: 21.3.0
///     """
///     set_run_validators(not disabled)
///
///
/// def get_disabled():
///     """
///     Return a bool indicating whether validators are currently disabled or not.
///
///     :return: ``True`` if validators are currently disabled.
///     :rtype: bool
///
///     .. versionadded:: 21.3.0
///     """
///     return not get_run_validators()
///
///
/// @contextmanager
/// def disabled():
///     """
///     Context manager that disables running validators within its context.
///
///     .. warning::
///
///         This context manager is not thread-safe!
///
///     .. versionadded:: 21.3.0
///     """
///     set_run_validators(False)
///     try:
///         yield
///     finally:
///         set_run_validators(True)
///
///
/// @attrs(repr=False, slots=True, hash=True)
/// class _InstanceOfValidator:
///     type = attrib()
///
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if not isinstance(value, self.type):
///             raise TypeError(
///                 "'{name}' must be {type!r} (got {value!r} that is a "
///                 "{actual!r}).".format(
///                     name=attr.name,
///                     type=self.type,
///                     actual=value.__class__,
///                     value=value,
///                 ),
///                 attr,
///                 self.type,
///                 value,
///             )
///
///     def __repr__(self):
///         return "<instance_of validator for type {type!r}>".format(
///             type=self.type
///         )
///
///
/// def instance_of(type):
///     """
///     A validator that raises a `TypeError` if the initializer is called
///     with a wrong type for this particular attribute (checks are performed using
///     `isinstance` therefore it's also valid to pass a tuple of types).
///
///     :param type: The type to check for.
///     :type type: type or tuple of type
///
///     :raises TypeError: With a human readable error message, the attribute
///         (of type `attrs.Attribute`), the expected type, and the value it
///         got.
///     """
///     return _InstanceOfValidator(type)
///
///
/// @attrs(repr=False, frozen=True, slots=True)
/// class _MatchesReValidator:
///     pattern = attrib()
///     match_func = attrib()
///
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if not self.match_func(value):
///             raise ValueError(
///                 "'{name}' must match regex {pattern!r}"
///                 " ({value!r} doesn't)".format(
///                     name=attr.name, pattern=self.pattern.pattern, value=value
///                 ),
///                 attr,
///                 self.pattern,
///                 value,
///             )
///
///     def __repr__(self):
///         return "<matches_re validator for pattern {pattern!r}>".format(
///             pattern=self.pattern
///         )
///
///
/// def matches_re(regex, flags=0, func=None):
///     r"""
///     A validator that raises `ValueError` if the initializer is called
///     with a string that doesn't match *regex*.
///
///     :param regex: a regex string or precompiled pattern to match against
///     :param int flags: flags that will be passed to the underlying re function
///         (default 0)
///     :param callable func: which underlying `re` function to call. Valid options
///         are `re.fullmatch`, `re.search`, and `re.match`; the default ``None``
///         means `re.fullmatch`. For performance reasons, the pattern is always
///         precompiled using `re.compile`.
///
///     .. versionadded:: 19.2.0
///     .. versionchanged:: 21.3.0 *regex* can be a pre-compiled pattern.
///     """
///     valid_funcs = (re.fullmatch, None, re.search, re.match)
///     if func not in valid_funcs:
///         raise ValueError(
///             "'func' must be one of {}.".format(
///                 ", ".join(
///                     sorted(
///                         e and e.__name__ or "None" for e in set(valid_funcs)
///                     )
///                 )
///             )
///         )
///
///     if isinstance(regex, Pattern):
///         if flags:
///             raise TypeError(
///                 "'flags' can only be used with a string pattern; "
///                 "pass flags to re.compile() instead"
///             )
///         pattern = regex
///     else:
///         pattern = re.compile(regex, flags)
///
///     if func is re.match:
///         match_func = pattern.match
///     elif func is re.search:
///         match_func = pattern.search
///     else:
///         match_func = pattern.fullmatch
///
///     return _MatchesReValidator(pattern, match_func)
///
///
/// @attrs(repr=False, slots=True, hash=True)
/// class _ProvidesValidator:
///     interface = attrib()
///
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if not self.interface.providedBy(value):
///             raise TypeError(
///                 "'{name}' must provide {interface!r} which {value!r} "
///                 "doesn't.".format(
///                     name=attr.name, interface=self.interface, value=value
///                 ),
///                 attr,
///                 self.interface,
///                 value,
///             )
///
///     def __repr__(self):
///         return "<provides validator for interface {interface!r}>".format(
///             interface=self.interface
///         )
///
///
/// def provides(interface):
///     """
///     A validator that raises a `TypeError` if the initializer is called
///     with an object that does not provide the requested *interface* (checks are
///     performed using ``interface.providedBy(value)`` (see `zope.interface
///     <https://zopeinterface.readthedocs.io/en/latest/>`_).
///
///     :param interface: The interface to check for.
///     :type interface: ``zope.interface.Interface``
///
///     :raises TypeError: With a human readable error message, the attribute
///         (of type `attrs.Attribute`), the expected interface, and the
///         value it got.
///
///     .. deprecated:: 23.1.0
///     """
///     import warnings
///
///     warnings.warn(
///         "attrs's zope-interface support is deprecated and will be removed in, "
///         "or after, April 2024.",
///         DeprecationWarning,
///         stacklevel=2,
///     )
///     return _ProvidesValidator(interface)
///
///
/// @attrs(repr=False, slots=True, hash=True)
/// class _OptionalValidator:
///     validator = attrib()
///
///     def __call__(self, inst, attr, value):
///         if value is None:
///             return
///
///         self.validator(inst, attr, value)
///
///     def __repr__(self):
///         return "<optional validator for {what} or None>".format(
///             what=repr(self.validator)
///         )
///
///
/// def optional(validator):
///     """
///     A validator that makes an attribute optional.  An optional attribute is one
///     which can be set to ``None`` in addition to satisfying the requirements of
///     the sub-validator.
///
///     :param Callable | tuple[Callable] | list[Callable] validator: A validator
///         (or validators) that is used for non-``None`` values.
///
///     .. versionadded:: 15.1.0
///     .. versionchanged:: 17.1.0 *validator* can be a list of validators.
///     .. versionchanged:: 23.1.0 *validator* can also be a tuple of validators.
///     """
///     if isinstance(validator, (list, tuple)):
///         return _OptionalValidator(_AndValidator(validator))
///
///     return _OptionalValidator(validator)
///
///
/// @attrs(repr=False, slots=True, hash=True)
/// class _InValidator:
///     options = attrib()
///
///     def __call__(self, inst, attr, value):
///         try:
///             in_options = value in self.options
///         except TypeError:  # e.g. `1 in "abc"`
///             in_options = False
///
///         if not in_options:
///             raise ValueError(
///                 "'{name}' must be in {options!r} (got {value!r})".format(
///                     name=attr.name, options=self.options, value=value
///                 ),
///                 attr,
///                 self.options,
///                 value,
///             )
///
///     def __repr__(self):
///         return "<in_ validator with options {options!r}>".format(
///             options=self.options
///         )
///
///
/// def in_(options):
///     """
///     A validator that raises a `ValueError` if the initializer is called
///     with a value that does not belong in the options provided.  The check is
///     performed using ``value in options``.
///
///     :param options: Allowed options.
///     :type options: list, tuple, `enum.Enum`, ...
///
///     :raises ValueError: With a human readable error message, the attribute (of
///        type `attrs.Attribute`), the expected options, and the value it
///        got.
///
///     .. versionadded:: 17.1.0
///     .. versionchanged:: 22.1.0
///        The ValueError was incomplete until now and only contained the human
///        readable error message. Now it contains all the information that has
///        been promised since 17.1.0.
///     """
///     return _InValidator(options)
///
///
/// @attrs(repr=False, slots=False, hash=True)
/// class _IsCallableValidator:
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if not callable(value):
///             message = (
///                 "'{name}' must be callable "
///                 "(got {value!r} that is a {actual!r})."
///             )
///             raise NotCallableError(
///                 msg=message.format(
///                     name=attr.name, value=value, actual=value.__class__
///                 ),
///                 value=value,
///             )
///
///     def __repr__(self):
///         return "<is_callable validator>"
///
///
/// def is_callable():
///     """
///     A validator that raises a `attrs.exceptions.NotCallableError` if the
///     initializer is called with a value for this particular attribute
///     that is not callable.
///
///     .. versionadded:: 19.1.0
///
///     :raises attrs.exceptions.NotCallableError: With a human readable error
///         message containing the attribute (`attrs.Attribute`) name,
///         and the value it got.
///     """
///     return _IsCallableValidator()
///
///
/// @attrs(repr=False, slots=True, hash=True)
/// class _DeepIterable:
///     member_validator = attrib(validator=is_callable())
///     iterable_validator = attrib(
///         default=None, validator=optional(is_callable())
///     )
///
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if self.iterable_validator is not None:
///             self.iterable_validator(inst, attr, value)
///
///         for member in value:
///             self.member_validator(inst, attr, member)
///
///     def __repr__(self):
///         iterable_identifier = (
///             ""
///             if self.iterable_validator is None
///             else f" {self.iterable_validator!r}"
///         )
///         return (
///             "<deep_iterable validator for{iterable_identifier}"
///             " iterables of {member!r}>"
///         ).format(
///             iterable_identifier=iterable_identifier,
///             member=self.member_validator,
///         )
///
///
/// def deep_iterable(member_validator, iterable_validator=None):
///     """
///     A validator that performs deep validation of an iterable.
///
///     :param member_validator: Validator(s) to apply to iterable members
///     :param iterable_validator: Validator to apply to iterable itself
///         (optional)
///
///     .. versionadded:: 19.1.0
///
///     :raises TypeError: if any sub-validators fail
///     """
///     if isinstance(member_validator, (list, tuple)):
///         member_validator = and_(*member_validator)
///     return _DeepIterable(member_validator, iterable_validator)
///
///
/// @attrs(repr=False, slots=True, hash=True)
/// class _DeepMapping:
///     key_validator = attrib(validator=is_callable())
///     value_validator = attrib(validator=is_callable())
///     mapping_validator = attrib(default=None, validator=optional(is_callable()))
///
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if self.mapping_validator is not None:
///             self.mapping_validator(inst, attr, value)
///
///         for key in value:
///             self.key_validator(inst, attr, key)
///             self.value_validator(inst, attr, value[key])
///
///     def __repr__(self):
///         return (
///             "<deep_mapping validator for objects mapping {key!r} to {value!r}>"
///         ).format(key=self.key_validator, value=self.value_validator)
///
///
/// def deep_mapping(key_validator, value_validator, mapping_validator=None):
///     """
///     A validator that performs deep validation of a dictionary.
///
///     :param key_validator: Validator to apply to dictionary keys
///     :param value_validator: Validator to apply to dictionary values
///     :param mapping_validator: Validator to apply to top-level mapping
///         attribute (optional)
///
///     .. versionadded:: 19.1.0
///
///     :raises TypeError: if any sub-validators fail
///     """
///     return _DeepMapping(key_validator, value_validator, mapping_validator)
///
///
/// @attrs(repr=False, frozen=True, slots=True)
/// class _NumberValidator:
///     bound = attrib()
///     compare_op = attrib()
///     compare_func = attrib()
///
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if not self.compare_func(value, self.bound):
///             raise ValueError(
///                 "'{name}' must be {op} {bound}: {value}".format(
///                     name=attr.name,
///                     op=self.compare_op,
///                     bound=self.bound,
///                     value=value,
///                 )
///             )
///
///     def __repr__(self):
///         return "<Validator for x {op} {bound}>".format(
///             op=self.compare_op, bound=self.bound
///         )
///
///
/// def lt(val):
///     """
///     A validator that raises `ValueError` if the initializer is called
///     with a number larger or equal to *val*.
///
///     :param val: Exclusive upper bound for values
///
///     .. versionadded:: 21.3.0
///     """
///     return _NumberValidator(val, "<", operator.lt)
///
///
/// def le(val):
///     """
///     A validator that raises `ValueError` if the initializer is called
///     with a number greater than *val*.
///
///     :param val: Inclusive upper bound for values
///
///     .. versionadded:: 21.3.0
///     """
///     return _NumberValidator(val, "<=", operator.le)
///
///
/// def ge(val):
///     """
///     A validator that raises `ValueError` if the initializer is called
///     with a number smaller than *val*.
///
///     :param val: Inclusive lower bound for values
///
///     .. versionadded:: 21.3.0
///     """
///     return _NumberValidator(val, ">=", operator.ge)
///
///
/// def gt(val):
///     """
///     A validator that raises `ValueError` if the initializer is called
///     with a number smaller or equal to *val*.
///
///     :param val: Exclusive lower bound for values
///
///     .. versionadded:: 21.3.0
///     """
///     return _NumberValidator(val, ">", operator.gt)
///
///
/// @attrs(repr=False, frozen=True, slots=True)
/// class _MaxLengthValidator:
///     max_length = attrib()
///
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if len(value) > self.max_length:
///             raise ValueError(
///                 "Length of '{name}' must be <= {max}: {len}".format(
///                     name=attr.name, max=self.max_length, len=len(value)
///                 )
///             )
///
///     def __repr__(self):
///         return f"<max_len validator for {self.max_length}>"
///
///
/// def max_len(length):
///     """
///     A validator that raises `ValueError` if the initializer is called
///     with a string or iterable that is longer than *length*.
///
///     :param int length: Maximum length of the string or iterable
///
///     .. versionadded:: 21.3.0
///     """
///     return _MaxLengthValidator(length)
///
///
/// @attrs(repr=False, frozen=True, slots=True)
/// class _MinLengthValidator:
///     min_length = attrib()
///
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if len(value) < self.min_length:
///             raise ValueError(
///                 "Length of '{name}' must be => {min}: {len}".format(
///                     name=attr.name, min=self.min_length, len=len(value)
///                 )
///             )
///
///     def __repr__(self):
///         return f"<min_len validator for {self.min_length}>"
///
///
/// def min_len(length):
///     """
///     A validator that raises `ValueError` if the initializer is called
///     with a string or iterable that is shorter than *length*.
///
///     :param int length: Minimum length of the string or iterable
///
///     .. versionadded:: 22.1.0
///     """
///     return _MinLengthValidator(length)
///
///
/// @attrs(repr=False, slots=True, hash=True)
/// class _SubclassOfValidator:
///     type = attrib()
///
///     def __call__(self, inst, attr, value):
///         """
///         We use a callable class to be able to change the ``__repr__``.
///         """
///         if not issubclass(value, self.type):
///             raise TypeError(
///                 "'{name}' must be a subclass of {type!r} "
///                 "(got {value!r}).".format(
///                     name=attr.name,
///                     type=self.type,
///                     value=value,
///                 ),
///                 attr,
///                 self.type,
///                 value,
///             )
///
///     def __repr__(self):
///         return "<subclass_of validator for type {type!r}>".format(
///             type=self.type
///         )
///
///
/// def _subclass_of(type):
///     """
///     A validator that raises a `TypeError` if the initializer is called
///     with a wrong type for this particular attribute (checks are performed using
///     `issubclass` therefore it's also valid to pass a tuple of types).
///
///     :param type: The type to check for.
///     :type type: type or tuple of types
///
///     :raises TypeError: With a human readable error message, the attribute
///         (of type `attrs.Attribute`), the expected type, and the value it
///         got.
///     """
///     return _SubclassOfValidator(type)
///
///
/// @attrs(repr=False, slots=True, hash=True)
/// class _NotValidator:
///     validator = attrib()
///     msg = attrib(
///         converter=default_if_none(
///             "not_ validator child '{validator!r}' "
///             "did not raise a captured error"
///         )
///     )
///     exc_types = attrib(
///         validator=deep_iterable(
///             member_validator=_subclass_of(Exception),
///             iterable_validator=instance_of(tuple),
///         ),
///     )
///
///     def __call__(self, inst, attr, value):
///         try:
///             self.validator(inst, attr, value)
///         except self.exc_types:
///             pass  # suppress error to invert validity
///         else:
///             raise ValueError(
///                 self.msg.format(
///                     validator=self.validator,
///                     exc_types=self.exc_types,
///                 ),
///                 attr,
///                 self.validator,
///                 value,
///                 self.exc_types,
///             )
///
///     def __repr__(self):
///         return (
///             "<not_ validator wrapping {what!r}, " "capturing {exc_types!r}>"
///         ).format(
///             what=self.validator,
///             exc_types=self.exc_types,
///         )
///
///
/// def not_(validator, *, msg=None, exc_types=(ValueError, TypeError)):
///     """
///     A validator that wraps and logically 'inverts' the validator passed to it.
///     It will raise a `ValueError` if the provided validator *doesn't* raise a
///     `ValueError` or `TypeError` (by default), and will suppress the exception
///     if the provided validator *does*.
///
///     Intended to be used with existing validators to compose logic without
///     needing to create inverted variants, for example, ``not_(in_(...))``.
///
///     :param validator: A validator to be logically inverted.
///     :param msg: Message to raise if validator fails.
///         Formatted with keys ``exc_types`` and ``validator``.
///     :type msg: str
///     :param exc_types: Exception type(s) to capture.
///         Other types raised by child validators will not be intercepted and
///         pass through.
///
///     :raises ValueError: With a human readable error message,
///         the attribute (of type `attrs.Attribute`),
///         the validator that failed to raise an exception,
///         the value it got,
///         and the expected exception types.
///
///     .. versionadded:: 22.2.0
///     """
///     try:
///         exc_types = tuple(exc_types)
///     except TypeError:
///         exc_types = (exc_types,)
///     return _NotValidator(validator, msg, exc_types)
/// ```
final class validators extends PythonModule {
  validators.from(super.pythonModule) : super.from();

  static validators import() => PythonFfiDart.instance.importModule(
        "attr.validators",
        validators.from,
      );

  /// ## deep_iterable
  ///
  /// ### python docstring
  ///
  /// A validator that performs deep validation of an iterable.
  ///
  /// :param member_validator: Validator(s) to apply to iterable members
  /// :param iterable_validator: Validator to apply to iterable itself
  ///     (optional)
  ///
  /// .. versionadded:: 19.1.0
  ///
  /// :raises TypeError: if any sub-validators fail
  ///
  /// ### python source
  /// ```py
  /// def deep_iterable(member_validator, iterable_validator=None):
  ///     """
  ///     A validator that performs deep validation of an iterable.
  ///
  ///     :param member_validator: Validator(s) to apply to iterable members
  ///     :param iterable_validator: Validator to apply to iterable itself
  ///         (optional)
  ///
  ///     .. versionadded:: 19.1.0
  ///
  ///     :raises TypeError: if any sub-validators fail
  ///     """
  ///     if isinstance(member_validator, (list, tuple)):
  ///         member_validator = and_(*member_validator)
  ///     return _DeepIterable(member_validator, iterable_validator)
  /// ```
  Object? deep_iterable({
    required Object? member_validator,
    Object? iterable_validator,
  }) =>
      getFunction("deep_iterable").call(
        <Object?>[
          member_validator,
          iterable_validator,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## deep_mapping
  ///
  /// ### python docstring
  ///
  /// A validator that performs deep validation of a dictionary.
  ///
  /// :param key_validator: Validator to apply to dictionary keys
  /// :param value_validator: Validator to apply to dictionary values
  /// :param mapping_validator: Validator to apply to top-level mapping
  ///     attribute (optional)
  ///
  /// .. versionadded:: 19.1.0
  ///
  /// :raises TypeError: if any sub-validators fail
  ///
  /// ### python source
  /// ```py
  /// def deep_mapping(key_validator, value_validator, mapping_validator=None):
  ///     """
  ///     A validator that performs deep validation of a dictionary.
  ///
  ///     :param key_validator: Validator to apply to dictionary keys
  ///     :param value_validator: Validator to apply to dictionary values
  ///     :param mapping_validator: Validator to apply to top-level mapping
  ///         attribute (optional)
  ///
  ///     .. versionadded:: 19.1.0
  ///
  ///     :raises TypeError: if any sub-validators fail
  ///     """
  ///     return _DeepMapping(key_validator, value_validator, mapping_validator)
  /// ```
  Object? deep_mapping({
    required Object? key_validator,
    required Object? value_validator,
    Object? mapping_validator,
  }) =>
      getFunction("deep_mapping").call(
        <Object?>[
          key_validator,
          value_validator,
          mapping_validator,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## ge
  ///
  /// ### python docstring
  ///
  /// A validator that raises `ValueError` if the initializer is called
  /// with a number smaller than *val*.
  ///
  /// :param val: Inclusive lower bound for values
  ///
  /// .. versionadded:: 21.3.0
  ///
  /// ### python source
  /// ```py
  /// def ge(val):
  ///     """
  ///     A validator that raises `ValueError` if the initializer is called
  ///     with a number smaller than *val*.
  ///
  ///     :param val: Inclusive lower bound for values
  ///
  ///     .. versionadded:: 21.3.0
  ///     """
  ///     return _NumberValidator(val, ">=", operator.ge)
  /// ```
  Object? ge({
    required Object? val,
  }) =>
      getFunction("ge").call(
        <Object?>[
          val,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## get_disabled
  ///
  /// ### python docstring
  ///
  /// Return a bool indicating whether validators are currently disabled or not.
  ///
  /// :return: ``True`` if validators are currently disabled.
  /// :rtype: bool
  ///
  /// .. versionadded:: 21.3.0
  ///
  /// ### python source
  /// ```py
  /// def get_disabled():
  ///     """
  ///     Return a bool indicating whether validators are currently disabled or not.
  ///
  ///     :return: ``True`` if validators are currently disabled.
  ///     :rtype: bool
  ///
  ///     .. versionadded:: 21.3.0
  ///     """
  ///     return not get_run_validators()
  /// ```
  Object? get_disabled() => getFunction("get_disabled").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## gt
  ///
  /// ### python docstring
  ///
  /// A validator that raises `ValueError` if the initializer is called
  /// with a number smaller or equal to *val*.
  ///
  /// :param val: Exclusive lower bound for values
  ///
  /// .. versionadded:: 21.3.0
  ///
  /// ### python source
  /// ```py
  /// def gt(val):
  ///     """
  ///     A validator that raises `ValueError` if the initializer is called
  ///     with a number smaller or equal to *val*.
  ///
  ///     :param val: Exclusive lower bound for values
  ///
  ///     .. versionadded:: 21.3.0
  ///     """
  ///     return _NumberValidator(val, ">", operator.gt)
  /// ```
  Object? gt({
    required Object? val,
  }) =>
      getFunction("gt").call(
        <Object?>[
          val,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## in_
  ///
  /// ### python docstring
  ///
  /// A validator that raises a `ValueError` if the initializer is called
  /// with a value that does not belong in the options provided.  The check is
  /// performed using ``value in options``.
  ///
  /// :param options: Allowed options.
  /// :type options: list, tuple, `enum.Enum`, ...
  ///
  /// :raises ValueError: With a human readable error message, the attribute (of
  ///    type `attrs.Attribute`), the expected options, and the value it
  ///    got.
  ///
  /// .. versionadded:: 17.1.0
  /// .. versionchanged:: 22.1.0
  ///    The ValueError was incomplete until now and only contained the human
  ///    readable error message. Now it contains all the information that has
  ///    been promised since 17.1.0.
  ///
  /// ### python source
  /// ```py
  /// def in_(options):
  ///     """
  ///     A validator that raises a `ValueError` if the initializer is called
  ///     with a value that does not belong in the options provided.  The check is
  ///     performed using ``value in options``.
  ///
  ///     :param options: Allowed options.
  ///     :type options: list, tuple, `enum.Enum`, ...
  ///
  ///     :raises ValueError: With a human readable error message, the attribute (of
  ///        type `attrs.Attribute`), the expected options, and the value it
  ///        got.
  ///
  ///     .. versionadded:: 17.1.0
  ///     .. versionchanged:: 22.1.0
  ///        The ValueError was incomplete until now and only contained the human
  ///        readable error message. Now it contains all the information that has
  ///        been promised since 17.1.0.
  ///     """
  ///     return _InValidator(options)
  /// ```
  Object? in_({
    required Object? options,
  }) =>
      getFunction("in_").call(
        <Object?>[
          options,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## instance_of
  ///
  /// ### python docstring
  ///
  /// A validator that raises a `TypeError` if the initializer is called
  /// with a wrong type for this particular attribute (checks are performed using
  /// `isinstance` therefore it's also valid to pass a tuple of types).
  ///
  /// :param type: The type to check for.
  /// :type type: type or tuple of type
  ///
  /// :raises TypeError: With a human readable error message, the attribute
  ///     (of type `attrs.Attribute`), the expected type, and the value it
  ///     got.
  ///
  /// ### python source
  /// ```py
  /// def instance_of(type):
  ///     """
  ///     A validator that raises a `TypeError` if the initializer is called
  ///     with a wrong type for this particular attribute (checks are performed using
  ///     `isinstance` therefore it's also valid to pass a tuple of types).
  ///
  ///     :param type: The type to check for.
  ///     :type type: type or tuple of type
  ///
  ///     :raises TypeError: With a human readable error message, the attribute
  ///         (of type `attrs.Attribute`), the expected type, and the value it
  ///         got.
  ///     """
  ///     return _InstanceOfValidator(type)
  /// ```
  Object? instance_of({
    required Object? type,
  }) =>
      getFunction("instance_of").call(
        <Object?>[
          type,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## is_callable
  ///
  /// ### python docstring
  ///
  /// A validator that raises a `attrs.exceptions.NotCallableError` if the
  /// initializer is called with a value for this particular attribute
  /// that is not callable.
  ///
  /// .. versionadded:: 19.1.0
  ///
  /// :raises attrs.exceptions.NotCallableError: With a human readable error
  ///     message containing the attribute (`attrs.Attribute`) name,
  ///     and the value it got.
  ///
  /// ### python source
  /// ```py
  /// def is_callable():
  ///     """
  ///     A validator that raises a `attrs.exceptions.NotCallableError` if the
  ///     initializer is called with a value for this particular attribute
  ///     that is not callable.
  ///
  ///     .. versionadded:: 19.1.0
  ///
  ///     :raises attrs.exceptions.NotCallableError: With a human readable error
  ///         message containing the attribute (`attrs.Attribute`) name,
  ///         and the value it got.
  ///     """
  ///     return _IsCallableValidator()
  /// ```
  Object? is_callable() => getFunction("is_callable").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## le
  ///
  /// ### python docstring
  ///
  /// A validator that raises `ValueError` if the initializer is called
  /// with a number greater than *val*.
  ///
  /// :param val: Inclusive upper bound for values
  ///
  /// .. versionadded:: 21.3.0
  ///
  /// ### python source
  /// ```py
  /// def le(val):
  ///     """
  ///     A validator that raises `ValueError` if the initializer is called
  ///     with a number greater than *val*.
  ///
  ///     :param val: Inclusive upper bound for values
  ///
  ///     .. versionadded:: 21.3.0
  ///     """
  ///     return _NumberValidator(val, "<=", operator.le)
  /// ```
  Object? le({
    required Object? val,
  }) =>
      getFunction("le").call(
        <Object?>[
          val,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## lt
  ///
  /// ### python docstring
  ///
  /// A validator that raises `ValueError` if the initializer is called
  /// with a number larger or equal to *val*.
  ///
  /// :param val: Exclusive upper bound for values
  ///
  /// .. versionadded:: 21.3.0
  ///
  /// ### python source
  /// ```py
  /// def lt(val):
  ///     """
  ///     A validator that raises `ValueError` if the initializer is called
  ///     with a number larger or equal to *val*.
  ///
  ///     :param val: Exclusive upper bound for values
  ///
  ///     .. versionadded:: 21.3.0
  ///     """
  ///     return _NumberValidator(val, "<", operator.lt)
  /// ```
  Object? lt({
    required Object? val,
  }) =>
      getFunction("lt").call(
        <Object?>[
          val,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## matches_re
  ///
  /// ### python docstring
  ///
  /// A validator that raises `ValueError` if the initializer is called
  /// with a string that doesn't match *regex*.
  ///
  /// :param regex: a regex string or precompiled pattern to match against
  /// :param int flags: flags that will be passed to the underlying re function
  ///     (default 0)
  /// :param callable func: which underlying `re` function to call. Valid options
  ///     are `re.fullmatch`, `re.search`, and `re.match`; the default ``None``
  ///     means `re.fullmatch`. For performance reasons, the pattern is always
  ///     precompiled using `re.compile`.
  ///
  /// .. versionadded:: 19.2.0
  /// .. versionchanged:: 21.3.0 *regex* can be a pre-compiled pattern.
  ///
  /// ### python source
  /// ```py
  /// def matches_re(regex, flags=0, func=None):
  ///     r"""
  ///     A validator that raises `ValueError` if the initializer is called
  ///     with a string that doesn't match *regex*.
  ///
  ///     :param regex: a regex string or precompiled pattern to match against
  ///     :param int flags: flags that will be passed to the underlying re function
  ///         (default 0)
  ///     :param callable func: which underlying `re` function to call. Valid options
  ///         are `re.fullmatch`, `re.search`, and `re.match`; the default ``None``
  ///         means `re.fullmatch`. For performance reasons, the pattern is always
  ///         precompiled using `re.compile`.
  ///
  ///     .. versionadded:: 19.2.0
  ///     .. versionchanged:: 21.3.0 *regex* can be a pre-compiled pattern.
  ///     """
  ///     valid_funcs = (re.fullmatch, None, re.search, re.match)
  ///     if func not in valid_funcs:
  ///         raise ValueError(
  ///             "'func' must be one of {}.".format(
  ///                 ", ".join(
  ///                     sorted(
  ///                         e and e.__name__ or "None" for e in set(valid_funcs)
  ///                     )
  ///                 )
  ///             )
  ///         )
  ///
  ///     if isinstance(regex, Pattern):
  ///         if flags:
  ///             raise TypeError(
  ///                 "'flags' can only be used with a string pattern; "
  ///                 "pass flags to re.compile() instead"
  ///             )
  ///         pattern = regex
  ///     else:
  ///         pattern = re.compile(regex, flags)
  ///
  ///     if func is re.match:
  ///         match_func = pattern.match
  ///     elif func is re.search:
  ///         match_func = pattern.search
  ///     else:
  ///         match_func = pattern.fullmatch
  ///
  ///     return _MatchesReValidator(pattern, match_func)
  /// ```
  Object? matches_re({
    required Object? regex,
    Object? flags = 0,
    Object? func,
  }) =>
      getFunction("matches_re").call(
        <Object?>[
          regex,
          flags,
          func,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## max_len
  ///
  /// ### python docstring
  ///
  /// A validator that raises `ValueError` if the initializer is called
  /// with a string or iterable that is longer than *length*.
  ///
  /// :param int length: Maximum length of the string or iterable
  ///
  /// .. versionadded:: 21.3.0
  ///
  /// ### python source
  /// ```py
  /// def max_len(length):
  ///     """
  ///     A validator that raises `ValueError` if the initializer is called
  ///     with a string or iterable that is longer than *length*.
  ///
  ///     :param int length: Maximum length of the string or iterable
  ///
  ///     .. versionadded:: 21.3.0
  ///     """
  ///     return _MaxLengthValidator(length)
  /// ```
  Object? max_len({
    required Object? length,
  }) =>
      getFunction("max_len").call(
        <Object?>[
          length,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## min_len
  ///
  /// ### python docstring
  ///
  /// A validator that raises `ValueError` if the initializer is called
  /// with a string or iterable that is shorter than *length*.
  ///
  /// :param int length: Minimum length of the string or iterable
  ///
  /// .. versionadded:: 22.1.0
  ///
  /// ### python source
  /// ```py
  /// def min_len(length):
  ///     """
  ///     A validator that raises `ValueError` if the initializer is called
  ///     with a string or iterable that is shorter than *length*.
  ///
  ///     :param int length: Minimum length of the string or iterable
  ///
  ///     .. versionadded:: 22.1.0
  ///     """
  ///     return _MinLengthValidator(length)
  /// ```
  Object? min_len({
    required Object? length,
  }) =>
      getFunction("min_len").call(
        <Object?>[
          length,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## not_
  ///
  /// ### python docstring
  ///
  /// A validator that wraps and logically 'inverts' the validator passed to it.
  /// It will raise a `ValueError` if the provided validator *doesn't* raise a
  /// `ValueError` or `TypeError` (by default), and will suppress the exception
  /// if the provided validator *does*.
  ///
  /// Intended to be used with existing validators to compose logic without
  /// needing to create inverted variants, for example, ``not_(in_(...))``.
  ///
  /// :param validator: A validator to be logically inverted.
  /// :param msg: Message to raise if validator fails.
  ///     Formatted with keys ``exc_types`` and ``validator``.
  /// :type msg: str
  /// :param exc_types: Exception type(s) to capture.
  ///     Other types raised by child validators will not be intercepted and
  ///     pass through.
  ///
  /// :raises ValueError: With a human readable error message,
  ///     the attribute (of type `attrs.Attribute`),
  ///     the validator that failed to raise an exception,
  ///     the value it got,
  ///     and the expected exception types.
  ///
  /// .. versionadded:: 22.2.0
  ///
  /// ### python source
  /// ```py
  /// def not_(validator, *, msg=None, exc_types=(ValueError, TypeError)):
  ///     """
  ///     A validator that wraps and logically 'inverts' the validator passed to it.
  ///     It will raise a `ValueError` if the provided validator *doesn't* raise a
  ///     `ValueError` or `TypeError` (by default), and will suppress the exception
  ///     if the provided validator *does*.
  ///
  ///     Intended to be used with existing validators to compose logic without
  ///     needing to create inverted variants, for example, ``not_(in_(...))``.
  ///
  ///     :param validator: A validator to be logically inverted.
  ///     :param msg: Message to raise if validator fails.
  ///         Formatted with keys ``exc_types`` and ``validator``.
  ///     :type msg: str
  ///     :param exc_types: Exception type(s) to capture.
  ///         Other types raised by child validators will not be intercepted and
  ///         pass through.
  ///
  ///     :raises ValueError: With a human readable error message,
  ///         the attribute (of type `attrs.Attribute`),
  ///         the validator that failed to raise an exception,
  ///         the value it got,
  ///         and the expected exception types.
  ///
  ///     .. versionadded:: 22.2.0
  ///     """
  ///     try:
  ///         exc_types = tuple(exc_types)
  ///     except TypeError:
  ///         exc_types = (exc_types,)
  ///     return _NotValidator(validator, msg, exc_types)
  /// ```
  Object? not_({
    required Object? validator,
    Object? msg,
    Object? exc_types = const [null, null],
  }) =>
      getFunction("not_").call(
        <Object?>[
          validator,
        ],
        kwargs: <String, Object?>{
          "msg": msg,
          "exc_types": exc_types,
        },
      );

  /// ## optional
  ///
  /// ### python docstring
  ///
  /// A validator that makes an attribute optional.  An optional attribute is one
  /// which can be set to ``None`` in addition to satisfying the requirements of
  /// the sub-validator.
  ///
  /// :param Callable | tuple[Callable] | list[Callable] validator: A validator
  ///     (or validators) that is used for non-``None`` values.
  ///
  /// .. versionadded:: 15.1.0
  /// .. versionchanged:: 17.1.0 *validator* can be a list of validators.
  /// .. versionchanged:: 23.1.0 *validator* can also be a tuple of validators.
  ///
  /// ### python source
  /// ```py
  /// def optional(validator):
  ///     """
  ///     A validator that makes an attribute optional.  An optional attribute is one
  ///     which can be set to ``None`` in addition to satisfying the requirements of
  ///     the sub-validator.
  ///
  ///     :param Callable | tuple[Callable] | list[Callable] validator: A validator
  ///         (or validators) that is used for non-``None`` values.
  ///
  ///     .. versionadded:: 15.1.0
  ///     .. versionchanged:: 17.1.0 *validator* can be a list of validators.
  ///     .. versionchanged:: 23.1.0 *validator* can also be a tuple of validators.
  ///     """
  ///     if isinstance(validator, (list, tuple)):
  ///         return _OptionalValidator(_AndValidator(validator))
  ///
  ///     return _OptionalValidator(validator)
  /// ```
  Object? optional({
    required Object? validator,
  }) =>
      getFunction("optional").call(
        <Object?>[
          validator,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## provides
  ///
  /// ### python docstring
  ///
  /// A validator that raises a `TypeError` if the initializer is called
  /// with an object that does not provide the requested *interface* (checks are
  /// performed using ``interface.providedBy(value)`` (see `zope.interface
  /// <https://zopeinterface.readthedocs.io/en/latest/>`_).
  ///
  /// :param interface: The interface to check for.
  /// :type interface: ``zope.interface.Interface``
  ///
  /// :raises TypeError: With a human readable error message, the attribute
  ///     (of type `attrs.Attribute`), the expected interface, and the
  ///     value it got.
  ///
  /// .. deprecated:: 23.1.0
  ///
  /// ### python source
  /// ```py
  /// def provides(interface):
  ///     """
  ///     A validator that raises a `TypeError` if the initializer is called
  ///     with an object that does not provide the requested *interface* (checks are
  ///     performed using ``interface.providedBy(value)`` (see `zope.interface
  ///     <https://zopeinterface.readthedocs.io/en/latest/>`_).
  ///
  ///     :param interface: The interface to check for.
  ///     :type interface: ``zope.interface.Interface``
  ///
  ///     :raises TypeError: With a human readable error message, the attribute
  ///         (of type `attrs.Attribute`), the expected interface, and the
  ///         value it got.
  ///
  ///     .. deprecated:: 23.1.0
  ///     """
  ///     import warnings
  ///
  ///     warnings.warn(
  ///         "attrs's zope-interface support is deprecated and will be removed in, "
  ///         "or after, April 2024.",
  ///         DeprecationWarning,
  ///         stacklevel=2,
  ///     )
  ///     return _ProvidesValidator(interface)
  /// ```
  Object? provides({
    required Object? $interface,
  }) =>
      getFunction("provides").call(
        <Object?>[
          $interface,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_disabled
  ///
  /// ### python docstring
  ///
  /// Globally disable or enable running validators.
  ///
  /// By default, they are run.
  ///
  /// :param disabled: If ``True``, disable running all validators.
  /// :type disabled: bool
  ///
  /// .. warning::
  ///
  ///     This function is not thread-safe!
  ///
  /// .. versionadded:: 21.3.0
  ///
  /// ### python source
  /// ```py
  /// def set_disabled(disabled):
  ///     """
  ///     Globally disable or enable running validators.
  ///
  ///     By default, they are run.
  ///
  ///     :param disabled: If ``True``, disable running all validators.
  ///     :type disabled: bool
  ///
  ///     .. warning::
  ///
  ///         This function is not thread-safe!
  ///
  ///     .. versionadded:: 21.3.0
  ///     """
  ///     set_run_validators(not disabled)
  /// ```
  Object? set_disabled({
    required Object? disabled,
  }) =>
      getFunction("set_disabled").call(
        <Object?>[
          disabled,
        ],
        kwargs: <String, Object?>{},
      );
}
