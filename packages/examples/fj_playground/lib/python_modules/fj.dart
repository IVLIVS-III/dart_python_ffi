import "package:python_ffi/python_ffi.dart";

class FJProgram extends PythonClass {
  FJProgram.from(super.pythonClass) : super.from();
}

class FJModule extends PythonModule {
  FJModule.from(super.pythonModule) : super.from();

  static FJModule import() => PythonModule.import(
        "fj",
        FJModule.from,
      );

  FJProgram fjParse(String sourceCodeTxt) => FJProgram.from(
        getFunction("fj_parse").call(<Object?>[sourceCodeTxt]),
      );

  PythonClassInterface<PythonFfiDelegate<Object?>, Object?> typecheckProgram(
    FJProgram program,
  ) =>
      getFunction("typecheck_program").call(<Object?>[program]);

  PythonClassInterface<PythonFfiDelegate<Object?>, Object?> computeProgram(
    FJProgram program,
  ) =>
      getFunction("compute_program").call(<Object?>[program]);
}
