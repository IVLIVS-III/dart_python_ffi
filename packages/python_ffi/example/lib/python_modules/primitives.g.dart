// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library primitives;

import "package:python_ffi/python_ffi.dart";

/// ## primitives
///
/// ### python source
/// ```py
/// import math
///
///
/// def sum(a: int, b: int) -> int:
///     return a + b
///
///
/// def multiply(a: int, b: int) -> int:
///     return a * b
///
///
/// def subtract(a: int, b: int) -> int:
///     return a - b
///
///
/// def sqrt(a: int) -> int:
///     return int(math.sqrt(a))
/// ```
final class primitives extends PythonModule {
  primitives.from(super.pythonModule) : super.from();

  static primitives import() => PythonFfi.instance.importModule(
        "primitives",
        primitives.from,
      );

  /// ## multiply
  ///
  /// ### python source
  /// ```py
  /// def multiply(a: int, b: int) -> int:
  ///     return a * b
  /// ```
  int multiply({
    required int a,
    required int b,
  }) =>
      getFunction("multiply").call(
        <Object?>[
          a,
          b,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## sqrt
  ///
  /// ### python source
  /// ```py
  /// def sqrt(a: int) -> int:
  ///     return int(math.sqrt(a))
  /// ```
  int sqrt({
    required int a,
  }) =>
      getFunction("sqrt").call(
        <Object?>[
          a,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## subtract
  ///
  /// ### python source
  /// ```py
  /// def subtract(a: int, b: int) -> int:
  ///     return a - b
  /// ```
  int subtract({
    required int a,
    required int b,
  }) =>
      getFunction("subtract").call(
        <Object?>[
          a,
          b,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## sum
  ///
  /// ### python source
  /// ```py
  /// def sum(a: int, b: int) -> int:
  ///     return a + b
  /// ```
  int sum({
    required int a,
    required int b,
  }) =>
      getFunction("sum").call(
        <Object?>[
          a,
          b,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## math
  math get $math => math.import();
}

/// ## math
final class math extends PythonModule {
  math.from(super.pythonModule) : super.from();

  static math import() => PythonFfi.instance.importModule(
        "math",
        math.from,
      );

  /// ## e (getter)
  Object? get e => getAttribute("e");

  /// ## e (setter)
  set e(Object? e) => setAttribute("e", e);

  /// ## inf (getter)
  Object? get inf => getAttribute("inf");

  /// ## inf (setter)
  set inf(Object? inf) => setAttribute("inf", inf);

  /// ## nan (getter)
  Object? get nan => getAttribute("nan");

  /// ## nan (setter)
  set nan(Object? nan) => setAttribute("nan", nan);

  /// ## pi (getter)
  Object? get pi => getAttribute("pi");

  /// ## pi (setter)
  set pi(Object? pi) => setAttribute("pi", pi);

  /// ## tau (getter)
  Object? get tau => getAttribute("tau");

  /// ## tau (setter)
  set tau(Object? tau) => setAttribute("tau", tau);
}
