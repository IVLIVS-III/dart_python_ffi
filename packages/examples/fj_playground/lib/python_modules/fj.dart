import "package:python_ffi/python_ffi.dart";

class FJProgram extends PythonClass {
  FJProgram.from(super.pythonClass) : super.from();
}

class FJParserModule extends PythonModule {
  FJParserModule.from(super.pythonModule) : super.from();

  static FJParserModule import() => PythonModule.import(
        "FJ_parser",
        FJParserModule.from,
      );

  FJProgram fjParse(String sourceCodeTxt) => FJProgram.from(
        getFunction("fj_parse").call(<Object?>[sourceCodeTxt]),
      );
}

class FJTypingModule extends PythonModule {
  FJTypingModule.from(super.pythonModule) : super.from();

  static FJTypingModule import() => PythonModule.import(
        "FJ_typing",
        FJTypingModule.from,
      );

  PythonClassInterface<PythonFfiDelegate<Object?>, Object?> typecheckProgram(
    FJProgram program,
  ) =>
      getFunction("typecheck_program").call(<Object?>[program]);
}

class FJComputationModule extends PythonModule {
  FJComputationModule.from(super.pythonModule) : super.from();

  static FJComputationModule import() => PythonModule.import(
        "FJ_computation",
        FJComputationModule.from,
      );

  PythonClassInterface<PythonFfiDelegate<Object?>, Object?> computeProgram(
    FJProgram program,
  ) =>
      getFunction("compute_program").call(<Object?>[program]);
}
