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
        "attr",
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
        "attr",
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
        "attr",
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
        "attr",
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
        "attr",
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
        "attr",
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
        "attr",
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
        "attr",
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
        "attr",
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
        "attr",
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
        "attr",
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
        "attr",
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

  /// ## asdict
  ///
  /// ### python docstring
  ///
  /// Return the *attrs* attribute values of *inst* as a dict.
  ///
  /// Optionally recurse into other *attrs*-decorated classes.
  ///
  /// :param inst: Instance of an *attrs*-decorated class.
  /// :param bool recurse: Recurse into classes that are also
  ///     *attrs*-decorated.
  /// :param callable filter: A callable whose return code determines whether an
  ///     attribute or element is included (``True``) or dropped (``False``).  Is
  ///     called with the `attrs.Attribute` as the first argument and the
  ///     value as the second argument.
  /// :param callable dict_factory: A callable to produce dictionaries from.  For
  ///     example, to produce ordered dictionaries instead of normal Python
  ///     dictionaries, pass in ``collections.OrderedDict``.
  /// :param bool retain_collection_types: Do not convert to ``list`` when
  ///     encountering an attribute whose type is ``tuple`` or ``set``.  Only
  ///     meaningful if ``recurse`` is ``True``.
  /// :param Optional[callable] value_serializer: A hook that is called for every
  ///     attribute or dict key/value.  It receives the current instance, field
  ///     and value and must return the (updated) value.  The hook is run *after*
  ///     the optional *filter* has been applied.
  ///
  /// :rtype: return type of *dict_factory*
  ///
  /// :raise attrs.exceptions.NotAnAttrsClassError: If *cls* is not an *attrs*
  ///     class.
  ///
  /// ..  versionadded:: 16.0.0 *dict_factory*
  /// ..  versionadded:: 16.1.0 *retain_collection_types*
  /// ..  versionadded:: 20.3.0 *value_serializer*
  /// ..  versionadded:: 21.3.0 If a dict has a collection for a key, it is
  ///     serialized as a tuple.
  ///
  /// ### python source
  /// ```py
  /// def asdict(
  ///     inst,
  ///     recurse=True,
  ///     filter=None,
  ///     dict_factory=dict,
  ///     retain_collection_types=False,
  ///     value_serializer=None,
  /// ):
  ///     """
  ///     Return the *attrs* attribute values of *inst* as a dict.
  ///
  ///     Optionally recurse into other *attrs*-decorated classes.
  ///
  ///     :param inst: Instance of an *attrs*-decorated class.
  ///     :param bool recurse: Recurse into classes that are also
  ///         *attrs*-decorated.
  ///     :param callable filter: A callable whose return code determines whether an
  ///         attribute or element is included (``True``) or dropped (``False``).  Is
  ///         called with the `attrs.Attribute` as the first argument and the
  ///         value as the second argument.
  ///     :param callable dict_factory: A callable to produce dictionaries from.  For
  ///         example, to produce ordered dictionaries instead of normal Python
  ///         dictionaries, pass in ``collections.OrderedDict``.
  ///     :param bool retain_collection_types: Do not convert to ``list`` when
  ///         encountering an attribute whose type is ``tuple`` or ``set``.  Only
  ///         meaningful if ``recurse`` is ``True``.
  ///     :param Optional[callable] value_serializer: A hook that is called for every
  ///         attribute or dict key/value.  It receives the current instance, field
  ///         and value and must return the (updated) value.  The hook is run *after*
  ///         the optional *filter* has been applied.
  ///
  ///     :rtype: return type of *dict_factory*
  ///
  ///     :raise attrs.exceptions.NotAnAttrsClassError: If *cls* is not an *attrs*
  ///         class.
  ///
  ///     ..  versionadded:: 16.0.0 *dict_factory*
  ///     ..  versionadded:: 16.1.0 *retain_collection_types*
  ///     ..  versionadded:: 20.3.0 *value_serializer*
  ///     ..  versionadded:: 21.3.0 If a dict has a collection for a key, it is
  ///         serialized as a tuple.
  ///     """
  ///     attrs = fields(inst.__class__)
  ///     rv = dict_factory()
  ///     for a in attrs:
  ///         v = getattr(inst, a.name)
  ///         if filter is not None and not filter(a, v):
  ///             continue
  ///
  ///         if value_serializer is not None:
  ///             v = value_serializer(inst, a, v)
  ///
  ///         if recurse is True:
  ///             if has(v.__class__):
  ///                 rv[a.name] = asdict(
  ///                     v,
  ///                     recurse=True,
  ///                     filter=filter,
  ///                     dict_factory=dict_factory,
  ///                     retain_collection_types=retain_collection_types,
  ///                     value_serializer=value_serializer,
  ///                 )
  ///             elif isinstance(v, (tuple, list, set, frozenset)):
  ///                 cf = v.__class__ if retain_collection_types is True else list
  ///                 rv[a.name] = cf(
  ///                     [
  ///                         _asdict_anything(
  ///                             i,
  ///                             is_key=False,
  ///                             filter=filter,
  ///                             dict_factory=dict_factory,
  ///                             retain_collection_types=retain_collection_types,
  ///                             value_serializer=value_serializer,
  ///                         )
  ///                         for i in v
  ///                     ]
  ///                 )
  ///             elif isinstance(v, dict):
  ///                 df = dict_factory
  ///                 rv[a.name] = df(
  ///                     (
  ///                         _asdict_anything(
  ///                             kk,
  ///                             is_key=True,
  ///                             filter=filter,
  ///                             dict_factory=df,
  ///                             retain_collection_types=retain_collection_types,
  ///                             value_serializer=value_serializer,
  ///                         ),
  ///                         _asdict_anything(
  ///                             vv,
  ///                             is_key=False,
  ///                             filter=filter,
  ///                             dict_factory=df,
  ///                             retain_collection_types=retain_collection_types,
  ///                             value_serializer=value_serializer,
  ///                         ),
  ///                     )
  ///                     for kk, vv in v.items()
  ///                 )
  ///             else:
  ///                 rv[a.name] = v
  ///         else:
  ///             rv[a.name] = v
  ///     return rv
  /// ```
  Object? asdict({
    required Object? inst,
    Object? recurse = true,
    Object? filter,
    Object? dict_factory,
    Object? retain_collection_types = false,
    Object? value_serializer,
  }) =>
      getFunction("asdict").call(
        <Object?>[
          inst,
          recurse,
          filter,
          dict_factory,
          retain_collection_types,
          value_serializer,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## assoc
  ///
  /// ### python docstring
  ///
  /// Copy *inst* and apply *changes*.
  ///
  /// This is different from `evolve` that applies the changes to the arguments
  /// that create the new instance.
  ///
  /// `evolve`'s behavior is preferable, but there are `edge cases`_ where it
  /// doesn't work. Therefore `assoc` is deprecated, but will not be removed.
  ///
  /// .. _`edge cases`: https://github.com/python-attrs/attrs/issues/251
  ///
  /// :param inst: Instance of a class with *attrs* attributes.
  /// :param changes: Keyword changes in the new copy.
  ///
  /// :return: A copy of inst with *changes* incorporated.
  ///
  /// :raise attrs.exceptions.AttrsAttributeNotFoundError: If *attr_name*
  ///     couldn't be found on *cls*.
  /// :raise attrs.exceptions.NotAnAttrsClassError: If *cls* is not an *attrs*
  ///     class.
  ///
  /// ..  deprecated:: 17.1.0
  ///     Use `attrs.evolve` instead if you can.
  ///     This function will not be removed du to the slightly different approach
  ///     compared to `attrs.evolve`.
  ///
  /// ### python source
  /// ```py
  /// def assoc(inst, **changes):
  ///     """
  ///     Copy *inst* and apply *changes*.
  ///
  ///     This is different from `evolve` that applies the changes to the arguments
  ///     that create the new instance.
  ///
  ///     `evolve`'s behavior is preferable, but there are `edge cases`_ where it
  ///     doesn't work. Therefore `assoc` is deprecated, but will not be removed.
  ///
  ///     .. _`edge cases`: https://github.com/python-attrs/attrs/issues/251
  ///
  ///     :param inst: Instance of a class with *attrs* attributes.
  ///     :param changes: Keyword changes in the new copy.
  ///
  ///     :return: A copy of inst with *changes* incorporated.
  ///
  ///     :raise attrs.exceptions.AttrsAttributeNotFoundError: If *attr_name*
  ///         couldn't be found on *cls*.
  ///     :raise attrs.exceptions.NotAnAttrsClassError: If *cls* is not an *attrs*
  ///         class.
  ///
  ///     ..  deprecated:: 17.1.0
  ///         Use `attrs.evolve` instead if you can.
  ///         This function will not be removed du to the slightly different approach
  ///         compared to `attrs.evolve`.
  ///     """
  ///     new = copy.copy(inst)
  ///     attrs = fields(inst.__class__)
  ///     for k, v in changes.items():
  ///         a = getattr(attrs, k, NOTHING)
  ///         if a is NOTHING:
  ///             raise AttrsAttributeNotFoundError(
  ///                 f"{k} is not an attrs attribute on {new.__class__}."
  ///             )
  ///         _obj_setattr(new, k, v)
  ///     return new
  /// ```
  Object? assoc({
    required Object? inst,
    Map<String, Object?> changes = const <String, Object?>{},
  }) =>
      getFunction("assoc").call(
        <Object?>[
          inst,
        ],
        kwargs: <String, Object?>{
          ...changes,
        },
      );

  /// ## astuple
  ///
  /// ### python docstring
  ///
  /// Return the *attrs* attribute values of *inst* as a tuple.
  ///
  /// Optionally recurse into other *attrs*-decorated classes.
  ///
  /// :param inst: Instance of an *attrs*-decorated class.
  /// :param bool recurse: Recurse into classes that are also
  ///     *attrs*-decorated.
  /// :param callable filter: A callable whose return code determines whether an
  ///     attribute or element is included (``True``) or dropped (``False``).  Is
  ///     called with the `attrs.Attribute` as the first argument and the
  ///     value as the second argument.
  /// :param callable tuple_factory: A callable to produce tuples from.  For
  ///     example, to produce lists instead of tuples.
  /// :param bool retain_collection_types: Do not convert to ``list``
  ///     or ``dict`` when encountering an attribute which type is
  ///     ``tuple``, ``dict`` or ``set``.  Only meaningful if ``recurse`` is
  ///     ``True``.
  ///
  /// :rtype: return type of *tuple_factory*
  ///
  /// :raise attrs.exceptions.NotAnAttrsClassError: If *cls* is not an *attrs*
  ///     class.
  ///
  /// ..  versionadded:: 16.2.0
  ///
  /// ### python source
  /// ```py
  /// def astuple(
  ///     inst,
  ///     recurse=True,
  ///     filter=None,
  ///     tuple_factory=tuple,
  ///     retain_collection_types=False,
  /// ):
  ///     """
  ///     Return the *attrs* attribute values of *inst* as a tuple.
  ///
  ///     Optionally recurse into other *attrs*-decorated classes.
  ///
  ///     :param inst: Instance of an *attrs*-decorated class.
  ///     :param bool recurse: Recurse into classes that are also
  ///         *attrs*-decorated.
  ///     :param callable filter: A callable whose return code determines whether an
  ///         attribute or element is included (``True``) or dropped (``False``).  Is
  ///         called with the `attrs.Attribute` as the first argument and the
  ///         value as the second argument.
  ///     :param callable tuple_factory: A callable to produce tuples from.  For
  ///         example, to produce lists instead of tuples.
  ///     :param bool retain_collection_types: Do not convert to ``list``
  ///         or ``dict`` when encountering an attribute which type is
  ///         ``tuple``, ``dict`` or ``set``.  Only meaningful if ``recurse`` is
  ///         ``True``.
  ///
  ///     :rtype: return type of *tuple_factory*
  ///
  ///     :raise attrs.exceptions.NotAnAttrsClassError: If *cls* is not an *attrs*
  ///         class.
  ///
  ///     ..  versionadded:: 16.2.0
  ///     """
  ///     attrs = fields(inst.__class__)
  ///     rv = []
  ///     retain = retain_collection_types  # Very long. :/
  ///     for a in attrs:
  ///         v = getattr(inst, a.name)
  ///         if filter is not None and not filter(a, v):
  ///             continue
  ///         if recurse is True:
  ///             if has(v.__class__):
  ///                 rv.append(
  ///                     astuple(
  ///                         v,
  ///                         recurse=True,
  ///                         filter=filter,
  ///                         tuple_factory=tuple_factory,
  ///                         retain_collection_types=retain,
  ///                     )
  ///                 )
  ///             elif isinstance(v, (tuple, list, set, frozenset)):
  ///                 cf = v.__class__ if retain is True else list
  ///                 rv.append(
  ///                     cf(
  ///                         [
  ///                             astuple(
  ///                                 j,
  ///                                 recurse=True,
  ///                                 filter=filter,
  ///                                 tuple_factory=tuple_factory,
  ///                                 retain_collection_types=retain,
  ///                             )
  ///                             if has(j.__class__)
  ///                             else j
  ///                             for j in v
  ///                         ]
  ///                     )
  ///                 )
  ///             elif isinstance(v, dict):
  ///                 df = v.__class__ if retain is True else dict
  ///                 rv.append(
  ///                     df(
  ///                         (
  ///                             astuple(
  ///                                 kk,
  ///                                 tuple_factory=tuple_factory,
  ///                                 retain_collection_types=retain,
  ///                             )
  ///                             if has(kk.__class__)
  ///                             else kk,
  ///                             astuple(
  ///                                 vv,
  ///                                 tuple_factory=tuple_factory,
  ///                                 retain_collection_types=retain,
  ///                             )
  ///                             if has(vv.__class__)
  ///                             else vv,
  ///                         )
  ///                         for kk, vv in v.items()
  ///                     )
  ///                 )
  ///             else:
  ///                 rv.append(v)
  ///         else:
  ///             rv.append(v)
  ///
  ///     return rv if tuple_factory is list else tuple_factory(rv)
  /// ```
  Object? astuple({
    required Object? inst,
    Object? recurse = true,
    Object? filter,
    Object? tuple_factory,
    Object? retain_collection_types = false,
  }) =>
      getFunction("astuple").call(
        <Object?>[
          inst,
          recurse,
          filter,
          tuple_factory,
          retain_collection_types,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## attributes
  ///
  /// ### python docstring
  ///
  /// A class decorator that adds :term:`dunder methods` according to the
  /// specified attributes using `attr.ib` or the *these* argument.
  ///
  /// Please consider using `attrs.define` / `attrs.frozen` in new code
  /// (``attr.s`` will *never* go away, though).
  ///
  /// :param these: A dictionary of name to `attr.ib` mappings.  This is
  ///     useful to avoid the definition of your attributes within the class body
  ///     because you can't (e.g. if you want to add ``__repr__`` methods to
  ///     Django models) or don't want to.
  ///
  ///     If *these* is not ``None``, *attrs* will *not* search the class body
  ///     for attributes and will *not* remove any attributes from it.
  ///
  ///     The order is deduced from the order of the attributes inside *these*.
  ///
  /// :type these: `dict` of `str` to `attr.ib`
  ///
  /// :param str repr_ns: When using nested classes, there's no way in Python 2
  ///     to automatically detect that.  Therefore it's possible to set the
  ///     namespace explicitly for a more meaningful ``repr`` output.
  /// :param bool auto_detect: Instead of setting the *init*, *repr*, *eq*,
  ///     *order*, and *hash* arguments explicitly, assume they are set to
  ///     ``True`` **unless any** of the involved methods for one of the
  ///     arguments is implemented in the *current* class (i.e. it is *not*
  ///     inherited from some base class).
  ///
  ///     So for example by implementing ``__eq__`` on a class yourself,
  ///     *attrs* will deduce ``eq=False`` and will create *neither*
  ///     ``__eq__`` *nor* ``__ne__`` (but Python classes come with a sensible
  ///     ``__ne__`` by default, so it *should* be enough to only implement
  ///     ``__eq__`` in most cases).
  ///
  ///     .. warning::
  ///
  ///        If you prevent *attrs* from creating the ordering methods for you
  ///        (``order=False``, e.g. by implementing ``__le__``), it becomes
  ///        *your* responsibility to make sure its ordering is sound. The best
  ///        way is to use the `functools.total_ordering` decorator.
  ///
  ///
  ///     Passing ``True`` or ``False`` to *init*, *repr*, *eq*, *order*,
  ///     *cmp*, or *hash* overrides whatever *auto_detect* would determine.
  ///
  /// :param bool repr: Create a ``__repr__`` method with a human readable
  ///     representation of *attrs* attributes..
  /// :param bool str: Create a ``__str__`` method that is identical to
  ///     ``__repr__``.  This is usually not necessary except for
  ///     `Exception`\ s.
  /// :param Optional[bool] eq: If ``True`` or ``None`` (default), add ``__eq__``
  ///     and ``__ne__`` methods that check two instances for equality.
  ///
  ///     They compare the instances as if they were tuples of their *attrs*
  ///     attributes if and only if the types of both classes are *identical*!
  /// :param Optional[bool] order: If ``True``, add ``__lt__``, ``__le__``,
  ///     ``__gt__``, and ``__ge__`` methods that behave like *eq* above and
  ///     allow instances to be ordered. If ``None`` (default) mirror value of
  ///     *eq*.
  /// :param Optional[bool] cmp: Setting *cmp* is equivalent to setting *eq*
  ///     and *order* to the same value. Must not be mixed with *eq* or *order*.
  /// :param Optional[bool] unsafe_hash: If ``None`` (default), the ``__hash__``
  ///     method is generated according how *eq* and *frozen* are set.
  ///
  ///     1. If *both* are True, *attrs* will generate a ``__hash__`` for you.
  ///     2. If *eq* is True and *frozen* is False, ``__hash__`` will be set to
  ///        None, marking it unhashable (which it is).
  ///     3. If *eq* is False, ``__hash__`` will be left untouched meaning the
  ///        ``__hash__`` method of the base class will be used (if base class is
  ///        ``object``, this means it will fall back to id-based hashing.).
  ///
  ///     Although not recommended, you can decide for yourself and force
  ///     *attrs* to create one (e.g. if the class is immutable even though you
  ///     didn't freeze it programmatically) by passing ``True`` or not.  Both of
  ///     these cases are rather special and should be used carefully.
  ///
  ///     See our documentation on `hashing`, Python's documentation on
  ///     `object.__hash__`, and the `GitHub issue that led to the default \
  ///     behavior <https://github.com/python-attrs/attrs/issues/136>`_ for more
  ///     details.
  /// :param Optional[bool] hash: Alias for *unsafe_hash*. *unsafe_hash* takes
  ///     precedence.
  /// :param bool init: Create a ``__init__`` method that initializes the
  ///     *attrs* attributes. Leading underscores are stripped for the argument
  ///     name. If a ``__attrs_pre_init__`` method exists on the class, it will
  ///     be called before the class is initialized. If a ``__attrs_post_init__``
  ///     method exists on the class, it will be called after the class is fully
  ///     initialized.
  ///
  ///     If ``init`` is ``False``, an ``__attrs_init__`` method will be
  ///     injected instead. This allows you to define a custom ``__init__``
  ///     method that can do pre-init work such as ``super().__init__()``,
  ///     and then call ``__attrs_init__()`` and ``__attrs_post_init__()``.
  /// :param bool slots: Create a :term:`slotted class <slotted classes>` that's
  ///     more memory-efficient. Slotted classes are generally superior to the
  ///     default dict classes, but have some gotchas you should know about, so
  ///     we encourage you to read the :term:`glossary entry <slotted classes>`.
  /// :param bool frozen: Make instances immutable after initialization.  If
  ///     someone attempts to modify a frozen instance,
  ///     `attrs.exceptions.FrozenInstanceError` is raised.
  ///
  ///     .. note::
  ///
  ///         1. This is achieved by installing a custom ``__setattr__`` method
  ///            on your class, so you can't implement your own.
  ///
  ///         2. True immutability is impossible in Python.
  ///
  ///         3. This *does* have a minor a runtime performance `impact
  ///            <how-frozen>` when initializing new instances.  In other words:
  ///            ``__init__`` is slightly slower with ``frozen=True``.
  ///
  ///         4. If a class is frozen, you cannot modify ``self`` in
  ///            ``__attrs_post_init__`` or a self-written ``__init__``. You can
  ///            circumvent that limitation by using
  ///            ``object.__setattr__(self, "attribute_name", value)``.
  ///
  ///         5. Subclasses of a frozen class are frozen too.
  ///
  /// :param bool weakref_slot: Make instances weak-referenceable.  This has no
  ///     effect unless ``slots`` is also enabled.
  /// :param bool auto_attribs: If ``True``, collect :pep:`526`-annotated
  ///     attributes from the class body.
  ///
  ///     In this case, you **must** annotate every field.  If *attrs*
  ///     encounters a field that is set to an `attr.ib` but lacks a type
  ///     annotation, an `attr.exceptions.UnannotatedAttributeError` is
  ///     raised.  Use ``field_name: typing.Any = attr.ib(...)`` if you don't
  ///     want to set a type.
  ///
  ///     If you assign a value to those attributes (e.g. ``x: int = 42``), that
  ///     value becomes the default value like if it were passed using
  ///     ``attr.ib(default=42)``.  Passing an instance of `attrs.Factory` also
  ///     works as expected in most cases (see warning below).
  ///
  ///     Attributes annotated as `typing.ClassVar`, and attributes that are
  ///     neither annotated nor set to an `attr.ib` are **ignored**.
  ///
  ///     .. warning::
  ///        For features that use the attribute name to create decorators (e.g.
  ///        :ref:`validators <validators>`), you still *must* assign `attr.ib`
  ///        to them. Otherwise Python will either not find the name or try to
  ///        use the default value to call e.g. ``validator`` on it.
  ///
  ///        These errors can be quite confusing and probably the most common bug
  ///        report on our bug tracker.
  ///
  /// :param bool kw_only: Make all attributes keyword-only
  ///     in the generated ``__init__`` (if ``init`` is ``False``, this
  ///     parameter is ignored).
  /// :param bool cache_hash: Ensure that the object's hash code is computed
  ///     only once and stored on the object.  If this is set to ``True``,
  ///     hashing must be either explicitly or implicitly enabled for this
  ///     class.  If the hash code is cached, avoid any reassignments of
  ///     fields involved in hash code computation or mutations of the objects
  ///     those fields point to after object creation.  If such changes occur,
  ///     the behavior of the object's hash code is undefined.
  /// :param bool auto_exc: If the class subclasses `BaseException`
  ///     (which implicitly includes any subclass of any exception), the
  ///     following happens to behave like a well-behaved Python exceptions
  ///     class:
  ///
  ///     - the values for *eq*, *order*, and *hash* are ignored and the
  ///       instances compare and hash by the instance's ids (N.B. *attrs* will
  ///       *not* remove existing implementations of ``__hash__`` or the equality
  ///       methods. It just won't add own ones.),
  ///     - all attributes that are either passed into ``__init__`` or have a
  ///       default value are additionally available as a tuple in the ``args``
  ///       attribute,
  ///     - the value of *str* is ignored leaving ``__str__`` to base classes.
  /// :param bool collect_by_mro: Setting this to `True` fixes the way *attrs*
  ///    collects attributes from base classes.  The default behavior is
  ///    incorrect in certain cases of multiple inheritance.  It should be on by
  ///    default but is kept off for backward-compatibility.
  ///
  ///    See issue `#428 <https://github.com/python-attrs/attrs/issues/428>`_ for
  ///    more details.
  ///
  /// :param Optional[bool] getstate_setstate:
  ///    .. note::
  ///       This is usually only interesting for slotted classes and you should
  ///       probably just set *auto_detect* to `True`.
  ///
  ///    If `True`, ``__getstate__`` and
  ///    ``__setstate__`` are generated and attached to the class. This is
  ///    necessary for slotted classes to be pickleable. If left `None`, it's
  ///    `True` by default for slotted classes and ``False`` for dict classes.
  ///
  ///    If *auto_detect* is `True`, and *getstate_setstate* is left `None`,
  ///    and **either** ``__getstate__`` or ``__setstate__`` is detected directly
  ///    on the class (i.e. not inherited), it is set to `False` (this is usually
  ///    what you want).
  ///
  /// :param on_setattr: A callable that is run whenever the user attempts to set
  ///     an attribute (either by assignment like ``i.x = 42`` or by using
  ///     `setattr` like ``setattr(i, "x", 42)``). It receives the same arguments
  ///     as validators: the instance, the attribute that is being modified, and
  ///     the new value.
  ///
  ///     If no exception is raised, the attribute is set to the return value of
  ///     the callable.
  ///
  ///     If a list of callables is passed, they're automatically wrapped in an
  ///     `attrs.setters.pipe`.
  /// :type on_setattr: `callable`, or a list of callables, or `None`, or
  ///     `attrs.setters.NO_OP`
  ///
  /// :param Optional[callable] field_transformer:
  ///     A function that is called with the original class object and all
  ///     fields right before *attrs* finalizes the class.  You can use
  ///     this, e.g., to automatically add converters or validators to
  ///     fields based on their types.  See `transform-fields` for more details.
  ///
  /// :param bool match_args:
  ///     If `True` (default), set ``__match_args__`` on the class to support
  ///     :pep:`634` (Structural Pattern Matching). It is a tuple of all
  ///     non-keyword-only ``__init__`` parameter names on Python 3.10 and later.
  ///     Ignored on older Python versions.
  ///
  /// .. versionadded:: 16.0.0 *slots*
  /// .. versionadded:: 16.1.0 *frozen*
  /// .. versionadded:: 16.3.0 *str*
  /// .. versionadded:: 16.3.0 Support for ``__attrs_post_init__``.
  /// .. versionchanged:: 17.1.0
  ///    *hash* supports ``None`` as value which is also the default now.
  /// .. versionadded:: 17.3.0 *auto_attribs*
  /// .. versionchanged:: 18.1.0
  ///    If *these* is passed, no attributes are deleted from the class body.
  /// .. versionchanged:: 18.1.0 If *these* is ordered, the order is retained.
  /// .. versionadded:: 18.2.0 *weakref_slot*
  /// .. deprecated:: 18.2.0
  ///    ``__lt__``, ``__le__``, ``__gt__``, and ``__ge__`` now raise a
  ///    `DeprecationWarning` if the classes compared are subclasses of
  ///    each other. ``__eq`` and ``__ne__`` never tried to compared subclasses
  ///    to each other.
  /// .. versionchanged:: 19.2.0
  ///    ``__lt__``, ``__le__``, ``__gt__``, and ``__ge__`` now do not consider
  ///    subclasses comparable anymore.
  /// .. versionadded:: 18.2.0 *kw_only*
  /// .. versionadded:: 18.2.0 *cache_hash*
  /// .. versionadded:: 19.1.0 *auto_exc*
  /// .. deprecated:: 19.2.0 *cmp* Removal on or after 2021-06-01.
  /// .. versionadded:: 19.2.0 *eq* and *order*
  /// .. versionadded:: 20.1.0 *auto_detect*
  /// .. versionadded:: 20.1.0 *collect_by_mro*
  /// .. versionadded:: 20.1.0 *getstate_setstate*
  /// .. versionadded:: 20.1.0 *on_setattr*
  /// .. versionadded:: 20.3.0 *field_transformer*
  /// .. versionchanged:: 21.1.0
  ///    ``init=False`` injects ``__attrs_init__``
  /// .. versionchanged:: 21.1.0 Support for ``__attrs_pre_init__``
  /// .. versionchanged:: 21.1.0 *cmp* undeprecated
  /// .. versionadded:: 21.3.0 *match_args*
  /// .. versionadded:: 22.2.0
  ///    *unsafe_hash* as an alias for *hash* (for :pep:`681` compliance).
  ///
  /// ### python source
  /// ```py
  /// def attrs(
  ///     maybe_cls=None,
  ///     these=None,
  ///     repr_ns=None,
  ///     repr=None,
  ///     cmp=None,
  ///     hash=None,
  ///     init=None,
  ///     slots=False,
  ///     frozen=False,
  ///     weakref_slot=True,
  ///     str=False,
  ///     auto_attribs=False,
  ///     kw_only=False,
  ///     cache_hash=False,
  ///     auto_exc=False,
  ///     eq=None,
  ///     order=None,
  ///     auto_detect=False,
  ///     collect_by_mro=False,
  ///     getstate_setstate=None,
  ///     on_setattr=None,
  ///     field_transformer=None,
  ///     match_args=True,
  ///     unsafe_hash=None,
  /// ):
  ///     r"""
  ///     A class decorator that adds :term:`dunder methods` according to the
  ///     specified attributes using `attr.ib` or the *these* argument.
  ///
  ///     Please consider using `attrs.define` / `attrs.frozen` in new code
  ///     (``attr.s`` will *never* go away, though).
  ///
  ///     :param these: A dictionary of name to `attr.ib` mappings.  This is
  ///         useful to avoid the definition of your attributes within the class body
  ///         because you can't (e.g. if you want to add ``__repr__`` methods to
  ///         Django models) or don't want to.
  ///
  ///         If *these* is not ``None``, *attrs* will *not* search the class body
  ///         for attributes and will *not* remove any attributes from it.
  ///
  ///         The order is deduced from the order of the attributes inside *these*.
  ///
  ///     :type these: `dict` of `str` to `attr.ib`
  ///
  ///     :param str repr_ns: When using nested classes, there's no way in Python 2
  ///         to automatically detect that.  Therefore it's possible to set the
  ///         namespace explicitly for a more meaningful ``repr`` output.
  ///     :param bool auto_detect: Instead of setting the *init*, *repr*, *eq*,
  ///         *order*, and *hash* arguments explicitly, assume they are set to
  ///         ``True`` **unless any** of the involved methods for one of the
  ///         arguments is implemented in the *current* class (i.e. it is *not*
  ///         inherited from some base class).
  ///
  ///         So for example by implementing ``__eq__`` on a class yourself,
  ///         *attrs* will deduce ``eq=False`` and will create *neither*
  ///         ``__eq__`` *nor* ``__ne__`` (but Python classes come with a sensible
  ///         ``__ne__`` by default, so it *should* be enough to only implement
  ///         ``__eq__`` in most cases).
  ///
  ///         .. warning::
  ///
  ///            If you prevent *attrs* from creating the ordering methods for you
  ///            (``order=False``, e.g. by implementing ``__le__``), it becomes
  ///            *your* responsibility to make sure its ordering is sound. The best
  ///            way is to use the `functools.total_ordering` decorator.
  ///
  ///
  ///         Passing ``True`` or ``False`` to *init*, *repr*, *eq*, *order*,
  ///         *cmp*, or *hash* overrides whatever *auto_detect* would determine.
  ///
  ///     :param bool repr: Create a ``__repr__`` method with a human readable
  ///         representation of *attrs* attributes..
  ///     :param bool str: Create a ``__str__`` method that is identical to
  ///         ``__repr__``.  This is usually not necessary except for
  ///         `Exception`\ s.
  ///     :param Optional[bool] eq: If ``True`` or ``None`` (default), add ``__eq__``
  ///         and ``__ne__`` methods that check two instances for equality.
  ///
  ///         They compare the instances as if they were tuples of their *attrs*
  ///         attributes if and only if the types of both classes are *identical*!
  ///     :param Optional[bool] order: If ``True``, add ``__lt__``, ``__le__``,
  ///         ``__gt__``, and ``__ge__`` methods that behave like *eq* above and
  ///         allow instances to be ordered. If ``None`` (default) mirror value of
  ///         *eq*.
  ///     :param Optional[bool] cmp: Setting *cmp* is equivalent to setting *eq*
  ///         and *order* to the same value. Must not be mixed with *eq* or *order*.
  ///     :param Optional[bool] unsafe_hash: If ``None`` (default), the ``__hash__``
  ///         method is generated according how *eq* and *frozen* are set.
  ///
  ///         1. If *both* are True, *attrs* will generate a ``__hash__`` for you.
  ///         2. If *eq* is True and *frozen* is False, ``__hash__`` will be set to
  ///            None, marking it unhashable (which it is).
  ///         3. If *eq* is False, ``__hash__`` will be left untouched meaning the
  ///            ``__hash__`` method of the base class will be used (if base class is
  ///            ``object``, this means it will fall back to id-based hashing.).
  ///
  ///         Although not recommended, you can decide for yourself and force
  ///         *attrs* to create one (e.g. if the class is immutable even though you
  ///         didn't freeze it programmatically) by passing ``True`` or not.  Both of
  ///         these cases are rather special and should be used carefully.
  ///
  ///         See our documentation on `hashing`, Python's documentation on
  ///         `object.__hash__`, and the `GitHub issue that led to the default \
  ///         behavior <https://github.com/python-attrs/attrs/issues/136>`_ for more
  ///         details.
  ///     :param Optional[bool] hash: Alias for *unsafe_hash*. *unsafe_hash* takes
  ///         precedence.
  ///     :param bool init: Create a ``__init__`` method that initializes the
  ///         *attrs* attributes. Leading underscores are stripped for the argument
  ///         name. If a ``__attrs_pre_init__`` method exists on the class, it will
  ///         be called before the class is initialized. If a ``__attrs_post_init__``
  ///         method exists on the class, it will be called after the class is fully
  ///         initialized.
  ///
  ///         If ``init`` is ``False``, an ``__attrs_init__`` method will be
  ///         injected instead. This allows you to define a custom ``__init__``
  ///         method that can do pre-init work such as ``super().__init__()``,
  ///         and then call ``__attrs_init__()`` and ``__attrs_post_init__()``.
  ///     :param bool slots: Create a :term:`slotted class <slotted classes>` that's
  ///         more memory-efficient. Slotted classes are generally superior to the
  ///         default dict classes, but have some gotchas you should know about, so
  ///         we encourage you to read the :term:`glossary entry <slotted classes>`.
  ///     :param bool frozen: Make instances immutable after initialization.  If
  ///         someone attempts to modify a frozen instance,
  ///         `attrs.exceptions.FrozenInstanceError` is raised.
  ///
  ///         .. note::
  ///
  ///             1. This is achieved by installing a custom ``__setattr__`` method
  ///                on your class, so you can't implement your own.
  ///
  ///             2. True immutability is impossible in Python.
  ///
  ///             3. This *does* have a minor a runtime performance `impact
  ///                <how-frozen>` when initializing new instances.  In other words:
  ///                ``__init__`` is slightly slower with ``frozen=True``.
  ///
  ///             4. If a class is frozen, you cannot modify ``self`` in
  ///                ``__attrs_post_init__`` or a self-written ``__init__``. You can
  ///                circumvent that limitation by using
  ///                ``object.__setattr__(self, "attribute_name", value)``.
  ///
  ///             5. Subclasses of a frozen class are frozen too.
  ///
  ///     :param bool weakref_slot: Make instances weak-referenceable.  This has no
  ///         effect unless ``slots`` is also enabled.
  ///     :param bool auto_attribs: If ``True``, collect :pep:`526`-annotated
  ///         attributes from the class body.
  ///
  ///         In this case, you **must** annotate every field.  If *attrs*
  ///         encounters a field that is set to an `attr.ib` but lacks a type
  ///         annotation, an `attr.exceptions.UnannotatedAttributeError` is
  ///         raised.  Use ``field_name: typing.Any = attr.ib(...)`` if you don't
  ///         want to set a type.
  ///
  ///         If you assign a value to those attributes (e.g. ``x: int = 42``), that
  ///         value becomes the default value like if it were passed using
  ///         ``attr.ib(default=42)``.  Passing an instance of `attrs.Factory` also
  ///         works as expected in most cases (see warning below).
  ///
  ///         Attributes annotated as `typing.ClassVar`, and attributes that are
  ///         neither annotated nor set to an `attr.ib` are **ignored**.
  ///
  ///         .. warning::
  ///            For features that use the attribute name to create decorators (e.g.
  ///            :ref:`validators <validators>`), you still *must* assign `attr.ib`
  ///            to them. Otherwise Python will either not find the name or try to
  ///            use the default value to call e.g. ``validator`` on it.
  ///
  ///            These errors can be quite confusing and probably the most common bug
  ///            report on our bug tracker.
  ///
  ///     :param bool kw_only: Make all attributes keyword-only
  ///         in the generated ``__init__`` (if ``init`` is ``False``, this
  ///         parameter is ignored).
  ///     :param bool cache_hash: Ensure that the object's hash code is computed
  ///         only once and stored on the object.  If this is set to ``True``,
  ///         hashing must be either explicitly or implicitly enabled for this
  ///         class.  If the hash code is cached, avoid any reassignments of
  ///         fields involved in hash code computation or mutations of the objects
  ///         those fields point to after object creation.  If such changes occur,
  ///         the behavior of the object's hash code is undefined.
  ///     :param bool auto_exc: If the class subclasses `BaseException`
  ///         (which implicitly includes any subclass of any exception), the
  ///         following happens to behave like a well-behaved Python exceptions
  ///         class:
  ///
  ///         - the values for *eq*, *order*, and *hash* are ignored and the
  ///           instances compare and hash by the instance's ids (N.B. *attrs* will
  ///           *not* remove existing implementations of ``__hash__`` or the equality
  ///           methods. It just won't add own ones.),
  ///         - all attributes that are either passed into ``__init__`` or have a
  ///           default value are additionally available as a tuple in the ``args``
  ///           attribute,
  ///         - the value of *str* is ignored leaving ``__str__`` to base classes.
  ///     :param bool collect_by_mro: Setting this to `True` fixes the way *attrs*
  ///        collects attributes from base classes.  The default behavior is
  ///        incorrect in certain cases of multiple inheritance.  It should be on by
  ///        default but is kept off for backward-compatibility.
  ///
  ///        See issue `#428 <https://github.com/python-attrs/attrs/issues/428>`_ for
  ///        more details.
  ///
  ///     :param Optional[bool] getstate_setstate:
  ///        .. note::
  ///           This is usually only interesting for slotted classes and you should
  ///           probably just set *auto_detect* to `True`.
  ///
  ///        If `True`, ``__getstate__`` and
  ///        ``__setstate__`` are generated and attached to the class. This is
  ///        necessary for slotted classes to be pickleable. If left `None`, it's
  ///        `True` by default for slotted classes and ``False`` for dict classes.
  ///
  ///        If *auto_detect* is `True`, and *getstate_setstate* is left `None`,
  ///        and **either** ``__getstate__`` or ``__setstate__`` is detected directly
  ///        on the class (i.e. not inherited), it is set to `False` (this is usually
  ///        what you want).
  ///
  ///     :param on_setattr: A callable that is run whenever the user attempts to set
  ///         an attribute (either by assignment like ``i.x = 42`` or by using
  ///         `setattr` like ``setattr(i, "x", 42)``). It receives the same arguments
  ///         as validators: the instance, the attribute that is being modified, and
  ///         the new value.
  ///
  ///         If no exception is raised, the attribute is set to the return value of
  ///         the callable.
  ///
  ///         If a list of callables is passed, they're automatically wrapped in an
  ///         `attrs.setters.pipe`.
  ///     :type on_setattr: `callable`, or a list of callables, or `None`, or
  ///         `attrs.setters.NO_OP`
  ///
  ///     :param Optional[callable] field_transformer:
  ///         A function that is called with the original class object and all
  ///         fields right before *attrs* finalizes the class.  You can use
  ///         this, e.g., to automatically add converters or validators to
  ///         fields based on their types.  See `transform-fields` for more details.
  ///
  ///     :param bool match_args:
  ///         If `True` (default), set ``__match_args__`` on the class to support
  ///         :pep:`634` (Structural Pattern Matching). It is a tuple of all
  ///         non-keyword-only ``__init__`` parameter names on Python 3.10 and later.
  ///         Ignored on older Python versions.
  ///
  ///     .. versionadded:: 16.0.0 *slots*
  ///     .. versionadded:: 16.1.0 *frozen*
  ///     .. versionadded:: 16.3.0 *str*
  ///     .. versionadded:: 16.3.0 Support for ``__attrs_post_init__``.
  ///     .. versionchanged:: 17.1.0
  ///        *hash* supports ``None`` as value which is also the default now.
  ///     .. versionadded:: 17.3.0 *auto_attribs*
  ///     .. versionchanged:: 18.1.0
  ///        If *these* is passed, no attributes are deleted from the class body.
  ///     .. versionchanged:: 18.1.0 If *these* is ordered, the order is retained.
  ///     .. versionadded:: 18.2.0 *weakref_slot*
  ///     .. deprecated:: 18.2.0
  ///        ``__lt__``, ``__le__``, ``__gt__``, and ``__ge__`` now raise a
  ///        `DeprecationWarning` if the classes compared are subclasses of
  ///        each other. ``__eq`` and ``__ne__`` never tried to compared subclasses
  ///        to each other.
  ///     .. versionchanged:: 19.2.0
  ///        ``__lt__``, ``__le__``, ``__gt__``, and ``__ge__`` now do not consider
  ///        subclasses comparable anymore.
  ///     .. versionadded:: 18.2.0 *kw_only*
  ///     .. versionadded:: 18.2.0 *cache_hash*
  ///     .. versionadded:: 19.1.0 *auto_exc*
  ///     .. deprecated:: 19.2.0 *cmp* Removal on or after 2021-06-01.
  ///     .. versionadded:: 19.2.0 *eq* and *order*
  ///     .. versionadded:: 20.1.0 *auto_detect*
  ///     .. versionadded:: 20.1.0 *collect_by_mro*
  ///     .. versionadded:: 20.1.0 *getstate_setstate*
  ///     .. versionadded:: 20.1.0 *on_setattr*
  ///     .. versionadded:: 20.3.0 *field_transformer*
  ///     .. versionchanged:: 21.1.0
  ///        ``init=False`` injects ``__attrs_init__``
  ///     .. versionchanged:: 21.1.0 Support for ``__attrs_pre_init__``
  ///     .. versionchanged:: 21.1.0 *cmp* undeprecated
  ///     .. versionadded:: 21.3.0 *match_args*
  ///     .. versionadded:: 22.2.0
  ///        *unsafe_hash* as an alias for *hash* (for :pep:`681` compliance).
  ///     """
  ///     eq_, order_ = _determine_attrs_eq_order(cmp, eq, order, None)
  ///
  ///     # unsafe_hash takes precedence due to PEP 681.
  ///     if unsafe_hash is not None:
  ///         hash = unsafe_hash
  ///
  ///     if isinstance(on_setattr, (list, tuple)):
  ///         on_setattr = setters.pipe(*on_setattr)
  ///
  ///     def wrap(cls):
  ///         is_frozen = frozen or _has_frozen_base_class(cls)
  ///         is_exc = auto_exc is True and issubclass(cls, BaseException)
  ///         has_own_setattr = auto_detect and _has_own_attribute(
  ///             cls, "__setattr__"
  ///         )
  ///
  ///         if has_own_setattr and is_frozen:
  ///             raise ValueError("Can't freeze a class with a custom __setattr__.")
  ///
  ///         builder = _ClassBuilder(
  ///             cls,
  ///             these,
  ///             slots,
  ///             is_frozen,
  ///             weakref_slot,
  ///             _determine_whether_to_implement(
  ///                 cls,
  ///                 getstate_setstate,
  ///                 auto_detect,
  ///                 ("__getstate__", "__setstate__"),
  ///                 default=slots,
  ///             ),
  ///             auto_attribs,
  ///             kw_only,
  ///             cache_hash,
  ///             is_exc,
  ///             collect_by_mro,
  ///             on_setattr,
  ///             has_own_setattr,
  ///             field_transformer,
  ///         )
  ///         if _determine_whether_to_implement(
  ///             cls, repr, auto_detect, ("__repr__",)
  ///         ):
  ///             builder.add_repr(repr_ns)
  ///         if str is True:
  ///             builder.add_str()
  ///
  ///         eq = _determine_whether_to_implement(
  ///             cls, eq_, auto_detect, ("__eq__", "__ne__")
  ///         )
  ///         if not is_exc and eq is True:
  ///             builder.add_eq()
  ///         if not is_exc and _determine_whether_to_implement(
  ///             cls, order_, auto_detect, ("__lt__", "__le__", "__gt__", "__ge__")
  ///         ):
  ///             builder.add_order()
  ///
  ///         builder.add_setattr()
  ///
  ///         nonlocal hash
  ///         if (
  ///             hash is None
  ///             and auto_detect is True
  ///             and _has_own_attribute(cls, "__hash__")
  ///         ):
  ///             hash = False
  ///
  ///         if hash is not True and hash is not False and hash is not None:
  ///             # Can't use `hash in` because 1 == True for example.
  ///             raise TypeError(
  ///                 "Invalid value for hash.  Must be True, False, or None."
  ///             )
  ///         elif hash is False or (hash is None and eq is False) or is_exc:
  ///             # Don't do anything. Should fall back to __object__'s __hash__
  ///             # which is by id.
  ///             if cache_hash:
  ///                 raise TypeError(
  ///                     "Invalid value for cache_hash.  To use hash caching,"
  ///                     " hashing must be either explicitly or implicitly "
  ///                     "enabled."
  ///                 )
  ///         elif hash is True or (
  ///             hash is None and eq is True and is_frozen is True
  ///         ):
  ///             # Build a __hash__ if told so, or if it's safe.
  ///             builder.add_hash()
  ///         else:
  ///             # Raise TypeError on attempts to hash.
  ///             if cache_hash:
  ///                 raise TypeError(
  ///                     "Invalid value for cache_hash.  To use hash caching,"
  ///                     " hashing must be either explicitly or implicitly "
  ///                     "enabled."
  ///                 )
  ///             builder.make_unhashable()
  ///
  ///         if _determine_whether_to_implement(
  ///             cls, init, auto_detect, ("__init__",)
  ///         ):
  ///             builder.add_init()
  ///         else:
  ///             builder.add_attrs_init()
  ///             if cache_hash:
  ///                 raise TypeError(
  ///                     "Invalid value for cache_hash.  To use hash caching,"
  ///                     " init must be True."
  ///                 )
  ///
  ///         if (
  ///             PY310
  ///             and match_args
  ///             and not _has_own_attribute(cls, "__match_args__")
  ///         ):
  ///             builder.add_match_args()
  ///
  ///         return builder.build_class()
  ///
  ///     # maybe_cls's type depends on the usage of the decorator.  It's a class
  ///     # if it's used as `@attrs` but ``None`` if used as `@attrs()`.
  ///     if maybe_cls is None:
  ///         return wrap
  ///     else:
  ///         return wrap(maybe_cls)
  /// ```
  Object? attributes({
    Object? maybe_cls,
    Object? these,
    Object? repr_ns,
    Object? repr,
    Object? cmp,
    Object? hash,
    Object? init,
    Object? slots = false,
    Object? frozen = false,
    Object? weakref_slot = true,
    Object? str = false,
    Object? auto_attribs = false,
    Object? kw_only = false,
    Object? cache_hash = false,
    Object? auto_exc = false,
    Object? eq,
    Object? order,
    Object? auto_detect = false,
    Object? collect_by_mro = false,
    Object? getstate_setstate,
    Object? on_setattr,
    Object? field_transformer,
    Object? match_args = true,
    Object? unsafe_hash,
  }) =>
      getFunction("attributes").call(
        <Object?>[
          maybe_cls,
          these,
          repr_ns,
          repr,
          cmp,
          hash,
          init,
          slots,
          frozen,
          weakref_slot,
          str,
          auto_attribs,
          kw_only,
          cache_hash,
          auto_exc,
          eq,
          order,
          auto_detect,
          collect_by_mro,
          getstate_setstate,
          on_setattr,
          field_transformer,
          match_args,
          unsafe_hash,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## cmp_using
  ///
  /// ### python docstring
  ///
  /// Create a class that can be passed into `attrs.field`'s ``eq``, ``order``,
  /// and ``cmp`` arguments to customize field comparison.
  ///
  /// The resulting class will have a full set of ordering methods if at least
  /// one of ``{lt, le, gt, ge}`` and ``eq``  are provided.
  ///
  /// :param Optional[callable] eq: `callable` used to evaluate equality of two
  ///     objects.
  /// :param Optional[callable] lt: `callable` used to evaluate whether one
  ///     object is less than another object.
  /// :param Optional[callable] le: `callable` used to evaluate whether one
  ///     object is less than or equal to another object.
  /// :param Optional[callable] gt: `callable` used to evaluate whether one
  ///     object is greater than another object.
  /// :param Optional[callable] ge: `callable` used to evaluate whether one
  ///     object is greater than or equal to another object.
  ///
  /// :param bool require_same_type: When `True`, equality and ordering methods
  ///     will return `NotImplemented` if objects are not of the same type.
  ///
  /// :param Optional[str] class_name: Name of class. Defaults to 'Comparable'.
  ///
  /// See `comparison` for more details.
  ///
  /// .. versionadded:: 21.1.0
  ///
  /// ### python source
  /// ```py
  /// def cmp_using(
  ///     eq=None,
  ///     lt=None,
  ///     le=None,
  ///     gt=None,
  ///     ge=None,
  ///     require_same_type=True,
  ///     class_name="Comparable",
  /// ):
  ///     """
  ///     Create a class that can be passed into `attrs.field`'s ``eq``, ``order``,
  ///     and ``cmp`` arguments to customize field comparison.
  ///
  ///     The resulting class will have a full set of ordering methods if at least
  ///     one of ``{lt, le, gt, ge}`` and ``eq``  are provided.
  ///
  ///     :param Optional[callable] eq: `callable` used to evaluate equality of two
  ///         objects.
  ///     :param Optional[callable] lt: `callable` used to evaluate whether one
  ///         object is less than another object.
  ///     :param Optional[callable] le: `callable` used to evaluate whether one
  ///         object is less than or equal to another object.
  ///     :param Optional[callable] gt: `callable` used to evaluate whether one
  ///         object is greater than another object.
  ///     :param Optional[callable] ge: `callable` used to evaluate whether one
  ///         object is greater than or equal to another object.
  ///
  ///     :param bool require_same_type: When `True`, equality and ordering methods
  ///         will return `NotImplemented` if objects are not of the same type.
  ///
  ///     :param Optional[str] class_name: Name of class. Defaults to 'Comparable'.
  ///
  ///     See `comparison` for more details.
  ///
  ///     .. versionadded:: 21.1.0
  ///     """
  ///
  ///     body = {
  ///         "__slots__": ["value"],
  ///         "__init__": _make_init(),
  ///         "_requirements": [],
  ///         "_is_comparable_to": _is_comparable_to,
  ///     }
  ///
  ///     # Add operations.
  ///     num_order_functions = 0
  ///     has_eq_function = False
  ///
  ///     if eq is not None:
  ///         has_eq_function = True
  ///         body["__eq__"] = _make_operator("eq", eq)
  ///         body["__ne__"] = _make_ne()
  ///
  ///     if lt is not None:
  ///         num_order_functions += 1
  ///         body["__lt__"] = _make_operator("lt", lt)
  ///
  ///     if le is not None:
  ///         num_order_functions += 1
  ///         body["__le__"] = _make_operator("le", le)
  ///
  ///     if gt is not None:
  ///         num_order_functions += 1
  ///         body["__gt__"] = _make_operator("gt", gt)
  ///
  ///     if ge is not None:
  ///         num_order_functions += 1
  ///         body["__ge__"] = _make_operator("ge", ge)
  ///
  ///     type_ = types.new_class(
  ///         class_name, (object,), {}, lambda ns: ns.update(body)
  ///     )
  ///
  ///     # Add same type requirement.
  ///     if require_same_type:
  ///         type_._requirements.append(_check_same_type)
  ///
  ///     # Add total ordering if at least one operation was defined.
  ///     if 0 < num_order_functions < 4:
  ///         if not has_eq_function:
  ///             # functools.total_ordering requires __eq__ to be defined,
  ///             # so raise early error here to keep a nice stack.
  ///             raise ValueError(
  ///                 "eq must be define is order to complete ordering from "
  ///                 "lt, le, gt, ge."
  ///             )
  ///         type_ = functools.total_ordering(type_)
  ///
  ///     return type_
  /// ```
  Object? cmp_using({
    Object? eq,
    Object? lt,
    Object? le,
    Object? gt,
    Object? ge,
    Object? require_same_type = true,
    Object? class_name = "Comparable",
  }) =>
      getFunction("cmp_using").call(
        <Object?>[
          eq,
          lt,
          le,
          gt,
          ge,
          require_same_type,
          class_name,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## define
  ///
  /// ### python docstring
  ///
  /// Define an *attrs* class.
  ///
  /// Differences to the classic `attr.s` that it uses underneath:
  ///
  /// - Automatically detect whether or not *auto_attribs* should be `True` (c.f.
  ///   *auto_attribs* parameter).
  /// - If *frozen* is `False`, run converters and validators when setting an
  ///   attribute by default.
  /// - *slots=True*
  ///
  ///   .. caution::
  ///
  ///      Usually this has only upsides and few visible effects in everyday
  ///      programming. But it *can* lead to some suprising behaviors, so please
  ///      make sure to read :term:`slotted classes`.
  /// - *auto_exc=True*
  /// - *auto_detect=True*
  /// - *order=False*
  /// - Some options that were only relevant on Python 2 or were kept around for
  ///   backwards-compatibility have been removed.
  ///
  /// Please note that these are all defaults and you can change them as you
  /// wish.
  ///
  /// :param Optional[bool] auto_attribs: If set to `True` or `False`, it behaves
  ///    exactly like `attr.s`. If left `None`, `attr.s` will try to guess:
  ///
  ///    1. If any attributes are annotated and no unannotated `attrs.fields`\ s
  ///       are found, it assumes *auto_attribs=True*.
  ///    2. Otherwise it assumes *auto_attribs=False* and tries to collect
  ///       `attrs.fields`\ s.
  ///
  /// For now, please refer to `attr.s` for the rest of the parameters.
  ///
  /// .. versionadded:: 20.1.0
  /// .. versionchanged:: 21.3.0 Converters are also run ``on_setattr``.
  /// .. versionadded:: 22.2.0
  ///    *unsafe_hash* as an alias for *hash* (for :pep:`681` compliance).
  ///
  /// ### python source
  /// ```py
  /// def define(
  ///     maybe_cls=None,
  ///     *,
  ///     these=None,
  ///     repr=None,
  ///     unsafe_hash=None,
  ///     hash=None,
  ///     init=None,
  ///     slots=True,
  ///     frozen=False,
  ///     weakref_slot=True,
  ///     str=False,
  ///     auto_attribs=None,
  ///     kw_only=False,
  ///     cache_hash=False,
  ///     auto_exc=True,
  ///     eq=None,
  ///     order=False,
  ///     auto_detect=True,
  ///     getstate_setstate=None,
  ///     on_setattr=None,
  ///     field_transformer=None,
  ///     match_args=True,
  /// ):
  ///     r"""
  ///     Define an *attrs* class.
  ///
  ///     Differences to the classic `attr.s` that it uses underneath:
  ///
  ///     - Automatically detect whether or not *auto_attribs* should be `True` (c.f.
  ///       *auto_attribs* parameter).
  ///     - If *frozen* is `False`, run converters and validators when setting an
  ///       attribute by default.
  ///     - *slots=True*
  ///
  ///       .. caution::
  ///
  ///          Usually this has only upsides and few visible effects in everyday
  ///          programming. But it *can* lead to some suprising behaviors, so please
  ///          make sure to read :term:`slotted classes`.
  ///     - *auto_exc=True*
  ///     - *auto_detect=True*
  ///     - *order=False*
  ///     - Some options that were only relevant on Python 2 or were kept around for
  ///       backwards-compatibility have been removed.
  ///
  ///     Please note that these are all defaults and you can change them as you
  ///     wish.
  ///
  ///     :param Optional[bool] auto_attribs: If set to `True` or `False`, it behaves
  ///        exactly like `attr.s`. If left `None`, `attr.s` will try to guess:
  ///
  ///        1. If any attributes are annotated and no unannotated `attrs.fields`\ s
  ///           are found, it assumes *auto_attribs=True*.
  ///        2. Otherwise it assumes *auto_attribs=False* and tries to collect
  ///           `attrs.fields`\ s.
  ///
  ///     For now, please refer to `attr.s` for the rest of the parameters.
  ///
  ///     .. versionadded:: 20.1.0
  ///     .. versionchanged:: 21.3.0 Converters are also run ``on_setattr``.
  ///     .. versionadded:: 22.2.0
  ///        *unsafe_hash* as an alias for *hash* (for :pep:`681` compliance).
  ///     """
  ///
  ///     def do_it(cls, auto_attribs):
  ///         return attrs(
  ///             maybe_cls=cls,
  ///             these=these,
  ///             repr=repr,
  ///             hash=hash,
  ///             unsafe_hash=unsafe_hash,
  ///             init=init,
  ///             slots=slots,
  ///             frozen=frozen,
  ///             weakref_slot=weakref_slot,
  ///             str=str,
  ///             auto_attribs=auto_attribs,
  ///             kw_only=kw_only,
  ///             cache_hash=cache_hash,
  ///             auto_exc=auto_exc,
  ///             eq=eq,
  ///             order=order,
  ///             auto_detect=auto_detect,
  ///             collect_by_mro=True,
  ///             getstate_setstate=getstate_setstate,
  ///             on_setattr=on_setattr,
  ///             field_transformer=field_transformer,
  ///             match_args=match_args,
  ///         )
  ///
  ///     def wrap(cls):
  ///         """
  ///         Making this a wrapper ensures this code runs during class creation.
  ///
  ///         We also ensure that frozen-ness of classes is inherited.
  ///         """
  ///         nonlocal frozen, on_setattr
  ///
  ///         had_on_setattr = on_setattr not in (None, setters.NO_OP)
  ///
  ///         # By default, mutable classes convert & validate on setattr.
  ///         if frozen is False and on_setattr is None:
  ///             on_setattr = _ng_default_on_setattr
  ///
  ///         # However, if we subclass a frozen class, we inherit the immutability
  ///         # and disable on_setattr.
  ///         for base_cls in cls.__bases__:
  ///             if base_cls.__setattr__ is _frozen_setattrs:
  ///                 if had_on_setattr:
  ///                     raise ValueError(
  ///                         "Frozen classes can't use on_setattr "
  ///                         "(frozen-ness was inherited)."
  ///                     )
  ///
  ///                 on_setattr = setters.NO_OP
  ///                 break
  ///
  ///         if auto_attribs is not None:
  ///             return do_it(cls, auto_attribs)
  ///
  ///         try:
  ///             return do_it(cls, True)
  ///         except UnannotatedAttributeError:
  ///             return do_it(cls, False)
  ///
  ///     # maybe_cls's type depends on the usage of the decorator.  It's a class
  ///     # if it's used as `@attrs` but ``None`` if used as `@attrs()`.
  ///     if maybe_cls is None:
  ///         return wrap
  ///     else:
  ///         return wrap(maybe_cls)
  /// ```
  Object? define({
    Object? maybe_cls,
    Object? these,
    Object? repr,
    Object? unsafe_hash,
    Object? hash,
    Object? init,
    Object? slots = true,
    Object? frozen = false,
    Object? weakref_slot = true,
    Object? str = false,
    Object? auto_attribs,
    Object? kw_only = false,
    Object? cache_hash = false,
    Object? auto_exc = true,
    Object? eq,
    Object? order = false,
    Object? auto_detect = true,
    Object? getstate_setstate,
    Object? on_setattr,
    Object? field_transformer,
    Object? match_args = true,
  }) =>
      getFunction("define").call(
        <Object?>[
          maybe_cls,
        ],
        kwargs: <String, Object?>{
          "these": these,
          "repr": repr,
          "unsafe_hash": unsafe_hash,
          "hash": hash,
          "init": init,
          "slots": slots,
          "frozen": frozen,
          "weakref_slot": weakref_slot,
          "str": str,
          "auto_attribs": auto_attribs,
          "kw_only": kw_only,
          "cache_hash": cache_hash,
          "auto_exc": auto_exc,
          "eq": eq,
          "order": order,
          "auto_detect": auto_detect,
          "getstate_setstate": getstate_setstate,
          "on_setattr": on_setattr,
          "field_transformer": field_transformer,
          "match_args": match_args,
        },
      );

  /// ## evolve
  ///
  /// ### python docstring
  ///
  /// Create a new instance, based on the first positional argument with
  /// *changes* applied.
  ///
  /// :param inst: Instance of a class with *attrs* attributes.
  /// :param changes: Keyword changes in the new copy.
  ///
  /// :return: A copy of inst with *changes* incorporated.
  ///
  /// :raise TypeError: If *attr_name* couldn't be found in the class
  ///     ``__init__``.
  /// :raise attrs.exceptions.NotAnAttrsClassError: If *cls* is not an *attrs*
  ///     class.
  ///
  /// .. versionadded:: 17.1.0
  /// .. deprecated:: 23.1.0
  ///    It is now deprecated to pass the instance using the keyword argument
  ///    *inst*. It will raise a warning until at least April 2024, after which
  ///    it will become an error. Always pass the instance as a positional
  ///    argument.
  ///
  /// ### python source
  /// ```py
  /// def evolve(*args, **changes):
  ///     """
  ///     Create a new instance, based on the first positional argument with
  ///     *changes* applied.
  ///
  ///     :param inst: Instance of a class with *attrs* attributes.
  ///     :param changes: Keyword changes in the new copy.
  ///
  ///     :return: A copy of inst with *changes* incorporated.
  ///
  ///     :raise TypeError: If *attr_name* couldn't be found in the class
  ///         ``__init__``.
  ///     :raise attrs.exceptions.NotAnAttrsClassError: If *cls* is not an *attrs*
  ///         class.
  ///
  ///     .. versionadded:: 17.1.0
  ///     .. deprecated:: 23.1.0
  ///        It is now deprecated to pass the instance using the keyword argument
  ///        *inst*. It will raise a warning until at least April 2024, after which
  ///        it will become an error. Always pass the instance as a positional
  ///        argument.
  ///     """
  ///     # Try to get instance by positional argument first.
  ///     # Use changes otherwise and warn it'll break.
  ///     if args:
  ///         try:
  ///             (inst,) = args
  ///         except ValueError:
  ///             raise TypeError(
  ///                 f"evolve() takes 1 positional argument, but {len(args)} "
  ///                 "were given"
  ///             ) from None
  ///     else:
  ///         try:
  ///             inst = changes.pop("inst")
  ///         except KeyError:
  ///             raise TypeError(
  ///                 "evolve() missing 1 required positional argument: 'inst'"
  ///             ) from None
  ///
  ///         import warnings
  ///
  ///         warnings.warn(
  ///             "Passing the instance per keyword argument is deprecated and "
  ///             "will stop working in, or after, April 2024.",
  ///             DeprecationWarning,
  ///             stacklevel=2,
  ///         )
  ///
  ///     cls = inst.__class__
  ///     attrs = fields(cls)
  ///     for a in attrs:
  ///         if not a.init:
  ///             continue
  ///         attr_name = a.name  # To deal with private attributes.
  ///         init_name = a.alias
  ///         if init_name not in changes:
  ///             changes[init_name] = getattr(inst, attr_name)
  ///
  ///     return cls(**changes)
  /// ```
  Object? evolve({
    List<Object?> args = const <Object?>[],
    Map<String, Object?> changes = const <String, Object?>{},
  }) =>
      getFunction("evolve").call(
        <Object?>[
          ...args,
        ],
        kwargs: <String, Object?>{
          ...changes,
        },
      );

  /// ## field
  ///
  /// ### python docstring
  ///
  /// Identical to `attr.ib`, except keyword-only and with some arguments
  /// removed.
  ///
  /// .. versionadded:: 23.1.0
  ///    The *type* parameter has been re-added; mostly for
  ///    {func}`attrs.make_class`. Please note that type checkers ignore this
  ///    metadata.
  /// .. versionadded:: 20.1.0
  ///
  /// ### python source
  /// ```py
  /// def field(
  ///     *,
  ///     default=NOTHING,
  ///     validator=None,
  ///     repr=True,
  ///     hash=None,
  ///     init=True,
  ///     metadata=None,
  ///     type=None,
  ///     converter=None,
  ///     factory=None,
  ///     kw_only=False,
  ///     eq=None,
  ///     order=None,
  ///     on_setattr=None,
  ///     alias=None,
  /// ):
  ///     """
  ///     Identical to `attr.ib`, except keyword-only and with some arguments
  ///     removed.
  ///
  ///     .. versionadded:: 23.1.0
  ///        The *type* parameter has been re-added; mostly for
  ///        {func}`attrs.make_class`. Please note that type checkers ignore this
  ///        metadata.
  ///     .. versionadded:: 20.1.0
  ///     """
  ///     return attrib(
  ///         default=default,
  ///         validator=validator,
  ///         repr=repr,
  ///         hash=hash,
  ///         init=init,
  ///         metadata=metadata,
  ///         type=type,
  ///         converter=converter,
  ///         factory=factory,
  ///         kw_only=kw_only,
  ///         eq=eq,
  ///         order=order,
  ///         on_setattr=on_setattr,
  ///         alias=alias,
  ///     )
  /// ```
  Object? field({
    Object? $default,
    Object? validator,
    Object? repr = true,
    Object? hash,
    Object? init = true,
    Object? metadata,
    Object? type,
    Object? converter,
    Object? $factory,
    Object? kw_only = false,
    Object? eq,
    Object? order,
    Object? on_setattr,
    Object? alias,
  }) =>
      getFunction("field").call(
        <Object?>[],
        kwargs: <String, Object?>{
          "default": $default,
          "validator": validator,
          "repr": repr,
          "hash": hash,
          "init": init,
          "metadata": metadata,
          "type": type,
          "converter": converter,
          "factory": $factory,
          "kw_only": kw_only,
          "eq": eq,
          "order": order,
          "on_setattr": on_setattr,
          "alias": alias,
        },
      );

  /// ## fields
  ///
  /// ### python docstring
  ///
  /// Return the tuple of *attrs* attributes for a class.
  ///
  /// The tuple also allows accessing the fields by their names (see below for
  /// examples).
  ///
  /// :param type cls: Class to introspect.
  ///
  /// :raise TypeError: If *cls* is not a class.
  /// :raise attrs.exceptions.NotAnAttrsClassError: If *cls* is not an *attrs*
  ///     class.
  ///
  /// :rtype: tuple (with name accessors) of `attrs.Attribute`
  ///
  /// .. versionchanged:: 16.2.0 Returned tuple allows accessing the fields
  ///    by name.
  /// .. versionchanged:: 23.1.0 Add support for generic classes.
  ///
  /// ### python source
  /// ```py
  /// def fields(cls):
  ///     """
  ///     Return the tuple of *attrs* attributes for a class.
  ///
  ///     The tuple also allows accessing the fields by their names (see below for
  ///     examples).
  ///
  ///     :param type cls: Class to introspect.
  ///
  ///     :raise TypeError: If *cls* is not a class.
  ///     :raise attrs.exceptions.NotAnAttrsClassError: If *cls* is not an *attrs*
  ///         class.
  ///
  ///     :rtype: tuple (with name accessors) of `attrs.Attribute`
  ///
  ///     .. versionchanged:: 16.2.0 Returned tuple allows accessing the fields
  ///        by name.
  ///     .. versionchanged:: 23.1.0 Add support for generic classes.
  ///     """
  ///     generic_base = get_generic_base(cls)
  ///
  ///     if generic_base is None and not isinstance(cls, type):
  ///         raise TypeError("Passed object must be a class.")
  ///
  ///     attrs = getattr(cls, "__attrs_attrs__", None)
  ///
  ///     if attrs is None:
  ///         if generic_base is not None:
  ///             attrs = getattr(generic_base, "__attrs_attrs__", None)
  ///             if attrs is not None:
  ///                 # Even though this is global state, stick it on here to speed
  ///                 # it up. We rely on `cls` being cached for this to be
  ///                 # efficient.
  ///                 cls.__attrs_attrs__ = attrs
  ///                 return attrs
  ///         raise NotAnAttrsClassError(f"{cls!r} is not an attrs-decorated class.")
  ///
  ///     return attrs
  /// ```
  Object? fields({
    required Object? cls,
  }) =>
      getFunction("fields").call(
        <Object?>[
          cls,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## fields_dict
  ///
  /// ### python docstring
  ///
  /// Return an ordered dictionary of *attrs* attributes for a class, whose
  /// keys are the attribute names.
  ///
  /// :param type cls: Class to introspect.
  ///
  /// :raise TypeError: If *cls* is not a class.
  /// :raise attrs.exceptions.NotAnAttrsClassError: If *cls* is not an *attrs*
  ///     class.
  ///
  /// :rtype: dict
  ///
  /// .. versionadded:: 18.1.0
  ///
  /// ### python source
  /// ```py
  /// def fields_dict(cls):
  ///     """
  ///     Return an ordered dictionary of *attrs* attributes for a class, whose
  ///     keys are the attribute names.
  ///
  ///     :param type cls: Class to introspect.
  ///
  ///     :raise TypeError: If *cls* is not a class.
  ///     :raise attrs.exceptions.NotAnAttrsClassError: If *cls* is not an *attrs*
  ///         class.
  ///
  ///     :rtype: dict
  ///
  ///     .. versionadded:: 18.1.0
  ///     """
  ///     if not isinstance(cls, type):
  ///         raise TypeError("Passed object must be a class.")
  ///     attrs = getattr(cls, "__attrs_attrs__", None)
  ///     if attrs is None:
  ///         raise NotAnAttrsClassError(f"{cls!r} is not an attrs-decorated class.")
  ///     return {a.name: a for a in attrs}
  /// ```
  Object? fields_dict({
    required Object? cls,
  }) =>
      getFunction("fields_dict").call(
        <Object?>[
          cls,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## get_run_validators
  ///
  /// ### python docstring
  ///
  /// Return whether or not validators are run.
  ///
  /// .. deprecated:: 21.3.0 It will not be removed, but it also will not be
  ///     moved to new ``attrs`` namespace. Use `attrs.validators.get_disabled()`
  ///     instead.
  ///
  /// ### python source
  /// ```py
  /// def get_run_validators():
  ///     """
  ///     Return whether or not validators are run.
  ///
  ///     .. deprecated:: 21.3.0 It will not be removed, but it also will not be
  ///         moved to new ``attrs`` namespace. Use `attrs.validators.get_disabled()`
  ///         instead.
  ///     """
  ///     return _run_validators
  /// ```
  Object? get_run_validators() => getFunction("get_run_validators").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## has
  ///
  /// ### python docstring
  ///
  /// Check whether *cls* is a class with *attrs* attributes.
  ///
  /// :param type cls: Class to introspect.
  /// :raise TypeError: If *cls* is not a class.
  ///
  /// :rtype: bool
  ///
  /// ### python source
  /// ```py
  /// def has(cls):
  ///     """
  ///     Check whether *cls* is a class with *attrs* attributes.
  ///
  ///     :param type cls: Class to introspect.
  ///     :raise TypeError: If *cls* is not a class.
  ///
  ///     :rtype: bool
  ///     """
  ///     attrs = getattr(cls, "__attrs_attrs__", None)
  ///     if attrs is not None:
  ///         return True
  ///
  ///     # No attrs, maybe it's a specialized generic (A[str])?
  ///     generic_base = get_generic_base(cls)
  ///     if generic_base is not None:
  ///         generic_attrs = getattr(generic_base, "__attrs_attrs__", None)
  ///         if generic_attrs is not None:
  ///             # Stick it on here for speed next time.
  ///             cls.__attrs_attrs__ = generic_attrs
  ///         return generic_attrs is not None
  ///     return False
  /// ```
  Object? has({
    required Object? cls,
  }) =>
      getFunction("has").call(
        <Object?>[
          cls,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## make_class
  ///
  /// ### python docstring
  ///
  /// A quick way to create a new class called *name* with *attrs*.
  ///
  /// :param str name: The name for the new class.
  ///
  /// :param attrs: A list of names or a dictionary of mappings of names to
  ///     `attr.ib`\ s / `attrs.field`\ s.
  ///
  ///     The order is deduced from the order of the names or attributes inside
  ///     *attrs*.  Otherwise the order of the definition of the attributes is
  ///     used.
  /// :type attrs: `list` or `dict`
  ///
  /// :param tuple bases: Classes that the new class will subclass.
  ///
  /// :param attributes_arguments: Passed unmodified to `attr.s`.
  ///
  /// :return: A new class with *attrs*.
  /// :rtype: type
  ///
  /// .. versionadded:: 17.1.0 *bases*
  /// .. versionchanged:: 18.1.0 If *attrs* is ordered, the order is retained.
  ///
  /// ### python source
  /// ```py
  /// def make_class(name, attrs, bases=(object,), **attributes_arguments):
  ///     r"""
  ///     A quick way to create a new class called *name* with *attrs*.
  ///
  ///     :param str name: The name for the new class.
  ///
  ///     :param attrs: A list of names or a dictionary of mappings of names to
  ///         `attr.ib`\ s / `attrs.field`\ s.
  ///
  ///         The order is deduced from the order of the names or attributes inside
  ///         *attrs*.  Otherwise the order of the definition of the attributes is
  ///         used.
  ///     :type attrs: `list` or `dict`
  ///
  ///     :param tuple bases: Classes that the new class will subclass.
  ///
  ///     :param attributes_arguments: Passed unmodified to `attr.s`.
  ///
  ///     :return: A new class with *attrs*.
  ///     :rtype: type
  ///
  ///     .. versionadded:: 17.1.0 *bases*
  ///     .. versionchanged:: 18.1.0 If *attrs* is ordered, the order is retained.
  ///     """
  ///     if isinstance(attrs, dict):
  ///         cls_dict = attrs
  ///     elif isinstance(attrs, (list, tuple)):
  ///         cls_dict = {a: attrib() for a in attrs}
  ///     else:
  ///         raise TypeError("attrs argument must be a dict or a list.")
  ///
  ///     pre_init = cls_dict.pop("__attrs_pre_init__", None)
  ///     post_init = cls_dict.pop("__attrs_post_init__", None)
  ///     user_init = cls_dict.pop("__init__", None)
  ///
  ///     body = {}
  ///     if pre_init is not None:
  ///         body["__attrs_pre_init__"] = pre_init
  ///     if post_init is not None:
  ///         body["__attrs_post_init__"] = post_init
  ///     if user_init is not None:
  ///         body["__init__"] = user_init
  ///
  ///     type_ = types.new_class(name, bases, {}, lambda ns: ns.update(body))
  ///
  ///     # For pickling to work, the __module__ variable needs to be set to the
  ///     # frame where the class is created.  Bypass this step in environments where
  ///     # sys._getframe is not defined (Jython for example) or sys._getframe is not
  ///     # defined for arguments greater than 0 (IronPython).
  ///     try:
  ///         type_.__module__ = sys._getframe(1).f_globals.get(
  ///             "__name__", "__main__"
  ///         )
  ///     except (AttributeError, ValueError):
  ///         pass
  ///
  ///     # We do it here for proper warnings with meaningful stacklevel.
  ///     cmp = attributes_arguments.pop("cmp", None)
  ///     (
  ///         attributes_arguments["eq"],
  ///         attributes_arguments["order"],
  ///     ) = _determine_attrs_eq_order(
  ///         cmp,
  ///         attributes_arguments.get("eq"),
  ///         attributes_arguments.get("order"),
  ///         True,
  ///     )
  ///
  ///     return _attrs(these=cls_dict, **attributes_arguments)(type_)
  /// ```
  Object? make_class({
    required Object? name,
    required Object? attrs,
    Object? bases = const [null],
    Map<String, Object?> attributes_arguments = const <String, Object?>{},
  }) =>
      getFunction("make_class").call(
        <Object?>[
          name,
          attrs,
          bases,
        ],
        kwargs: <String, Object?>{
          ...attributes_arguments,
        },
      );

  /// ## resolve_types
  ///
  /// ### python docstring
  ///
  /// Resolve any strings and forward annotations in type annotations.
  ///
  /// This is only required if you need concrete types in `Attribute`'s *type*
  /// field. In other words, you don't need to resolve your types if you only
  /// use them for static type checking.
  ///
  /// With no arguments, names will be looked up in the module in which the class
  /// was created. If this is not what you want, e.g. if the name only exists
  /// inside a method, you may pass *globalns* or *localns* to specify other
  /// dictionaries in which to look up these names. See the docs of
  /// `typing.get_type_hints` for more details.
  ///
  /// :param type cls: Class to resolve.
  /// :param Optional[dict] globalns: Dictionary containing global variables.
  /// :param Optional[dict] localns: Dictionary containing local variables.
  /// :param Optional[list] attribs: List of attribs for the given class.
  ///     This is necessary when calling from inside a ``field_transformer``
  ///     since *cls* is not an *attrs* class yet.
  /// :param bool include_extras: Resolve more accurately, if possible.
  ///     Pass ``include_extras`` to ``typing.get_hints``, if supported by the
  ///     typing module. On supported Python versions (3.9+), this resolves the
  ///     types more accurately.
  ///
  /// :raise TypeError: If *cls* is not a class.
  /// :raise attrs.exceptions.NotAnAttrsClassError: If *cls* is not an *attrs*
  ///     class and you didn't pass any attribs.
  /// :raise NameError: If types cannot be resolved because of missing variables.
  ///
  /// :returns: *cls* so you can use this function also as a class decorator.
  ///     Please note that you have to apply it **after** `attrs.define`. That
  ///     means the decorator has to come in the line **before** `attrs.define`.
  ///
  /// ..  versionadded:: 20.1.0
  /// ..  versionadded:: 21.1.0 *attribs*
  /// ..  versionadded:: 23.1.0 *include_extras*
  ///
  /// ### python source
  /// ```py
  /// def resolve_types(
  ///     cls, globalns=None, localns=None, attribs=None, include_extras=True
  /// ):
  ///     """
  ///     Resolve any strings and forward annotations in type annotations.
  ///
  ///     This is only required if you need concrete types in `Attribute`'s *type*
  ///     field. In other words, you don't need to resolve your types if you only
  ///     use them for static type checking.
  ///
  ///     With no arguments, names will be looked up in the module in which the class
  ///     was created. If this is not what you want, e.g. if the name only exists
  ///     inside a method, you may pass *globalns* or *localns* to specify other
  ///     dictionaries in which to look up these names. See the docs of
  ///     `typing.get_type_hints` for more details.
  ///
  ///     :param type cls: Class to resolve.
  ///     :param Optional[dict] globalns: Dictionary containing global variables.
  ///     :param Optional[dict] localns: Dictionary containing local variables.
  ///     :param Optional[list] attribs: List of attribs for the given class.
  ///         This is necessary when calling from inside a ``field_transformer``
  ///         since *cls* is not an *attrs* class yet.
  ///     :param bool include_extras: Resolve more accurately, if possible.
  ///         Pass ``include_extras`` to ``typing.get_hints``, if supported by the
  ///         typing module. On supported Python versions (3.9+), this resolves the
  ///         types more accurately.
  ///
  ///     :raise TypeError: If *cls* is not a class.
  ///     :raise attrs.exceptions.NotAnAttrsClassError: If *cls* is not an *attrs*
  ///         class and you didn't pass any attribs.
  ///     :raise NameError: If types cannot be resolved because of missing variables.
  ///
  ///     :returns: *cls* so you can use this function also as a class decorator.
  ///         Please note that you have to apply it **after** `attrs.define`. That
  ///         means the decorator has to come in the line **before** `attrs.define`.
  ///
  ///     ..  versionadded:: 20.1.0
  ///     ..  versionadded:: 21.1.0 *attribs*
  ///     ..  versionadded:: 23.1.0 *include_extras*
  ///
  ///     """
  ///     # Since calling get_type_hints is expensive we cache whether we've
  ///     # done it already.
  ///     if getattr(cls, "__attrs_types_resolved__", None) != cls:
  ///         import typing
  ///
  ///         kwargs = {"globalns": globalns, "localns": localns}
  ///
  ///         if PY_3_9_PLUS:
  ///             kwargs["include_extras"] = include_extras
  ///
  ///         hints = typing.get_type_hints(cls, **kwargs)
  ///         for field in fields(cls) if attribs is None else attribs:
  ///             if field.name in hints:
  ///                 # Since fields have been frozen we must work around it.
  ///                 _obj_setattr(field, "type", hints[field.name])
  ///         # We store the class we resolved so that subclasses know they haven't
  ///         # been resolved.
  ///         cls.__attrs_types_resolved__ = cls
  ///
  ///     # Return the class so you can use it as a decorator too.
  ///     return cls
  /// ```
  Object? resolve_types({
    required Object? cls,
    Object? globalns,
    Object? localns,
    Object? attribs,
    Object? include_extras = true,
  }) =>
      getFunction("resolve_types").call(
        <Object?>[
          cls,
          globalns,
          localns,
          attribs,
          include_extras,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## set_run_validators
  ///
  /// ### python docstring
  ///
  /// Set whether or not validators are run.  By default, they are run.
  ///
  /// .. deprecated:: 21.3.0 It will not be removed, but it also will not be
  ///     moved to new ``attrs`` namespace. Use `attrs.validators.set_disabled()`
  ///     instead.
  ///
  /// ### python source
  /// ```py
  /// def set_run_validators(run):
  ///     """
  ///     Set whether or not validators are run.  By default, they are run.
  ///
  ///     .. deprecated:: 21.3.0 It will not be removed, but it also will not be
  ///         moved to new ``attrs`` namespace. Use `attrs.validators.set_disabled()`
  ///         instead.
  ///     """
  ///     if not isinstance(run, bool):
  ///         raise TypeError("'run' must be bool.")
  ///     global _run_validators
  ///     _run_validators = run
  /// ```
  Object? set_run_validators({
    required Object? run,
  }) =>
      getFunction("set_run_validators").call(
        <Object?>[
          run,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## validate
  ///
  /// ### python docstring
  ///
  /// Validate all attributes on *inst* that have a validator.
  ///
  /// Leaves all exceptions through.
  ///
  /// :param inst: Instance of a class with *attrs* attributes.
  ///
  /// ### python source
  /// ```py
  /// def validate(inst):
  ///     """
  ///     Validate all attributes on *inst* that have a validator.
  ///
  ///     Leaves all exceptions through.
  ///
  ///     :param inst: Instance of a class with *attrs* attributes.
  ///     """
  ///     if _config._run_validators is False:
  ///         return
  ///
  ///     for a in fields(inst.__class__):
  ///         v = a.validator
  ///         if v is not None:
  ///             v(inst, a, getattr(inst, a.name))
  /// ```
  Object? validate({
    required Object? inst,
  }) =>
      getFunction("validate").call(
        <Object?>[
          inst,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## converters
  ///
  /// ### python docstring
  ///
  /// Commonly useful converters.
  converters get $converters => converters.import();

  /// ## exceptions
  exceptions get $exceptions => exceptions.import();

  /// ## filters
  ///
  /// ### python docstring
  ///
  /// Commonly useful filters for `attr.asdict`.
  filters get $filters => filters.import();

  /// ## setters
  ///
  /// ### python docstring
  ///
  /// Commonly used hooks for on_setattr.
  setters get $setters => setters.import();

  /// ## validators
  ///
  /// ### python docstring
  ///
  /// Commonly useful validators.
  validators get $validators => validators.import();

  /// ## Callable (getter)
  ///
  /// ### python docstring
  ///
  /// Classes Without Boilerplate
  Object? get Callable => getAttribute("Callable");

  /// ## Callable (setter)
  ///
  /// ### python docstring
  ///
  /// Classes Without Boilerplate
  set Callable(Object? Callable) => setAttribute("Callable", Callable);

  /// ## NOTHING (getter)
  ///
  /// ### python docstring
  ///
  /// Classes Without Boilerplate
  Object? get NOTHING => getAttribute("NOTHING");

  /// ## NOTHING (setter)
  ///
  /// ### python docstring
  ///
  /// Classes Without Boilerplate
  set NOTHING(Object? NOTHING) => setAttribute("NOTHING", NOTHING);

  /// ## dataclass (getter)
  ///
  /// ### python docstring
  ///
  /// Classes Without Boilerplate
  Object? get dataclass => getAttribute("dataclass");

  /// ## dataclass (setter)
  ///
  /// ### python docstring
  ///
  /// Classes Without Boilerplate
  set dataclass(Object? dataclass) => setAttribute("dataclass", dataclass);

  /// ## frozen (getter)
  ///
  /// ### python docstring
  ///
  /// Classes Without Boilerplate
  Object? get frozen => getAttribute("frozen");

  /// ## frozen (setter)
  ///
  /// ### python docstring
  ///
  /// Classes Without Boilerplate
  set frozen(Object? frozen) => setAttribute("frozen", frozen);
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
}
