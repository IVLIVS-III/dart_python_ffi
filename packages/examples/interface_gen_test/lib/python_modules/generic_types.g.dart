// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library generic_types;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## generic_types
///
/// ### python source
/// ```py
/// from typing import Callable, TypeVar
///
///
/// T = TypeVar("T")
///
///
/// def get_Callable() -> Callable[[T], T]: return lambda x: x
///
///
/// def set_Callable(_: Callable[[T], T]) -> bool: return _(1) == get_Callable()(1)
/// ```
final class generic_types extends PythonModule {
  generic_types.from(super.pythonModule) : super.from();

  static generic_types import() => PythonFfiDart.instance.importModule(
        "generic_types",
        generic_types.from,
      );

  /// ## get_Callable
  ///
  /// ### python source
  /// ```py
  /// def get_Callable() -> Callable[[T], T]: return lambda x: x
  /// ```
  Object? Function(Object?) get_Callable() => PythonFunction.from(
        getFunction("get_Callable").call(
          <Object?>[],
          kwargs: <String, Object?>{},
        ),
      ).asFunction(
        (PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?> f) =>
            (Object? x0) => f.call(<Object?>[x0]),
      );

  /// ## set_Callable
  ///
  /// ### python source
  /// ```py
  /// def set_Callable(_: Callable[[T], T]) -> bool: return _(1) == get_Callable()(1)
  /// ```
  bool set_Callable({
    required Object? Function(Object?) $_,
  }) =>
      getFunction("set_Callable").call(
        <Object?>[
          $_.generic1,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## T (getter)
  Object? get T => getAttribute("T");

  /// ## T (setter)
  set T(Object? T) => setAttribute("T", T);
}
