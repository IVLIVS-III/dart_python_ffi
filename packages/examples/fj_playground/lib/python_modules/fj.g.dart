// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library fj;

import "package:python_ffi/python_ffi.dart";

/// ## fj
///
/// ### python docstring
///
/// FJ Project
///
/// ### python source
/// ```py
/// """FJ Project"""
///
/// from FJ_interpreter import fj_run
///
/// __all__ = ("fj_run")
/// ```
final class fj extends PythonModule {
  fj.from(super.pythonModule) : super.from();

  static fj import() => PythonFfi.instance.importModule(
        "fj",
        fj.from,
      );

  /// ## fj_run
  ///
  /// ### python docstring
  ///
  /// Takes a featherweight java program as a string.
  ///
  ///
  ///
  /// By default returns a tuple of strings containing:
  ///
  ///     The program, the computed expression and the type of the expression.
  ///
  ///
  ///
  /// If 'with_constructor' is set to True:
  ///
  ///     The returned program contains constructor definitions, even if the original program does not.
  ///
  ///
  ///
  /// If 'only_typecheck' is set to True:
  ///
  ///     The returned tuple contains the program, the not computed expression and the type of the expression.
  ///
  /// ### python source
  /// ```py
  /// def fj_run(program_as_str: str, with_constructor: bool = False, only_typecheck: bool = False) -> tuple[str, str, str]:
  ///     """
  ///     Takes a featherweight java program as a string.\n
  ///     \n
  ///     By default returns a tuple of strings containing:\n
  ///     \tThe program, the computed expression and the type of the expression.\n
  ///     \n
  ///     If 'with_constructor' is set to True:\n
  ///     \tThe returned program contains constructor definitions, even if the original program does not.\n
  ///     \n
  ///     If 'only_typecheck' is set to True:\n
  ///     \tThe returned tuple contains the program, the not computed expression and the type of the expression.
  ///     """
  ///     program = fj_parse(program_as_str)
  ///     type_of_expr = typecheck_program(program)
  ///     if only_typecheck:
  ///         if with_constructor:
  ///             return program.str_with_constructor(), str(program.expression), str(type_of_expr)
  ///         return str(program), str(program.expression), str(type_of_expr)
  ///     else:
  ///         comp_expr = compute_program(program)
  ///         if with_constructor:
  ///             return program.str_with_constructor(), str(comp_expr), str(type_of_expr)
  ///         return str(program), str(comp_expr), str(type_of_expr)
  /// ```
  List<String> fj_run({
    required String program_as_str,
    bool with_constructor = false,
    bool only_typecheck = false,
  }) =>
      List<String>.from(
        List.from(
          getFunction("fj_run").call(
            <Object?>[
              program_as_str,
              with_constructor,
              only_typecheck,
            ],
            kwargs: <String, Object?>{},
          ),
        ).map(
          (e) => e,
        ),
      );
}
