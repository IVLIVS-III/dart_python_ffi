// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library attrs;

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

/// ## attrs
///
/// ### python source
/// ```py
/// # SPDX-License-Identifier: MIT
///
/// from attr import (
///     NOTHING,
///     Attribute,
///     AttrsInstance,
///     Factory,
///     _make_getattr,
///     assoc,
///     cmp_using,
///     define,
///     evolve,
///     field,
///     fields,
///     fields_dict,
///     frozen,
///     has,
///     make_class,
///     mutable,
///     resolve_types,
///     validate,
/// )
/// from attr._next_gen import asdict, astuple
///
/// from . import converters, exceptions, filters, setters, validators
///
///
/// __all__ = [
///     "__author__",
///     "__copyright__",
///     "__description__",
///     "__doc__",
///     "__email__",
///     "__license__",
///     "__title__",
///     "__url__",
///     "__version__",
///     "__version_info__",
///     "asdict",
///     "assoc",
///     "astuple",
///     "Attribute",
///     "AttrsInstance",
///     "cmp_using",
///     "converters",
///     "define",
///     "evolve",
///     "exceptions",
///     "Factory",
///     "field",
///     "fields_dict",
///     "fields",
///     "filters",
///     "frozen",
///     "has",
///     "make_class",
///     "mutable",
///     "NOTHING",
///     "resolve_types",
///     "setters",
///     "validate",
///     "validators",
/// ]
///
/// __getattr__ = _make_getattr(__name__)
/// ```
final class attrs extends PythonModule {
  attrs.from(super.pythonModule) : super.from();

  static attrs import() => PythonFfiDart.instance.importModule(
        "attrs",
        attrs.from,
      );
}

/// ## converters
///
/// ### python source
/// ```py
/// # SPDX-License-Identifier: MIT
///
/// from attr.converters import *  # noqa
/// ```
final class converters extends PythonModule {
  converters.from(super.pythonModule) : super.from();

  static converters import() => PythonFfiDart.instance.importModule(
        "attrs.converters",
        converters.from,
      );
}

/// ## exceptions
///
/// ### python source
/// ```py
/// # SPDX-License-Identifier: MIT
///
/// from attr.exceptions import *  # noqa
/// ```
final class exceptions extends PythonModule {
  exceptions.from(super.pythonModule) : super.from();

  static exceptions import() => PythonFfiDart.instance.importModule(
        "attrs.exceptions",
        exceptions.from,
      );
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
}

/// ## setters
///
/// ### python source
/// ```py
/// # SPDX-License-Identifier: MIT
///
/// from attr.setters import *  # noqa
/// ```
final class setters extends PythonModule {
  setters.from(super.pythonModule) : super.from();

  static setters import() => PythonFfiDart.instance.importModule(
        "attrs.setters",
        setters.from,
      );
}

/// ## validators
///
/// ### python source
/// ```py
/// # SPDX-License-Identifier: MIT
///
/// from attr.validators import *  # noqa
/// ```
final class validators extends PythonModule {
  validators.from(super.pythonModule) : super.from();

  static validators import() => PythonFfiDart.instance.importModule(
        "attrs.validators",
        validators.from,
      );
}
