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
        "attrs",
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
        "attrs",
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
        "attrs",
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
        "attrs",
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
        "attrs",
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
        "attrs",
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
        "attrs",
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
        "attrs",
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
        "attrs",
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
        "attrs",
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
        "attrs",
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
        "attrs",
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

  /// ## asdict
  ///
  /// ### python docstring
  ///
  /// Same as `attr.asdict`, except that collections types are always retained
  /// and dict is always used as *dict_factory*.
  ///
  /// .. versionadded:: 21.3.0
  ///
  /// ### python source
  /// ```py
  /// def asdict(inst, *, recurse=True, filter=None, value_serializer=None):
  ///     """
  ///     Same as `attr.asdict`, except that collections types are always retained
  ///     and dict is always used as *dict_factory*.
  ///
  ///     .. versionadded:: 21.3.0
  ///     """
  ///     return _asdict(
  ///         inst=inst,
  ///         recurse=recurse,
  ///         filter=filter,
  ///         value_serializer=value_serializer,
  ///         retain_collection_types=True,
  ///     )
  /// ```
  Object? asdict({
    required Object? inst,
    Object? recurse = true,
    Object? filter,
    Object? value_serializer,
  }) =>
      getFunction("asdict").call(
        <Object?>[
          inst,
        ],
        kwargs: <String, Object?>{
          "recurse": recurse,
          "filter": filter,
          "value_serializer": value_serializer,
        },
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
  /// Same as `attr.astuple`, except that collections types are always retained
  /// and `tuple` is always used as the *tuple_factory*.
  ///
  /// .. versionadded:: 21.3.0
  ///
  /// ### python source
  /// ```py
  /// def astuple(inst, *, recurse=True, filter=None):
  ///     """
  ///     Same as `attr.astuple`, except that collections types are always retained
  ///     and `tuple` is always used as the *tuple_factory*.
  ///
  ///     .. versionadded:: 21.3.0
  ///     """
  ///     return _astuple(
  ///         inst=inst, recurse=recurse, filter=filter, retain_collection_types=True
  ///     )
  /// ```
  Object? astuple({
    required Object? inst,
    Object? recurse = true,
    Object? filter,
  }) =>
      getFunction("astuple").call(
        <Object?>[
          inst,
        ],
        kwargs: <String, Object?>{
          "recurse": recurse,
          "filter": filter,
        },
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
  converters get $converters => converters.import();

  /// ## exceptions
  exceptions get $exceptions => exceptions.import();

  /// ## filters
  filters get $filters => filters.import();

  /// ## setters
  setters get $setters => setters.import();

  /// ## validators
  validators get $validators => validators.import();

  /// ## NOTHING (getter)
  Object? get NOTHING => getAttribute("NOTHING");

  /// ## NOTHING (setter)
  set NOTHING(Object? NOTHING) => setAttribute("NOTHING", NOTHING);

  /// ## frozen (getter)
  Object? get frozen => getAttribute("frozen");

  /// ## frozen (setter)
  set frozen(Object? frozen) => setAttribute("frozen", frozen);
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
