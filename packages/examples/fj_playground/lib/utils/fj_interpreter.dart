import "package:fj_playground/python_modules/fj.dart";
import "package:python_ffi/python_ffi.dart";

Future<String> runFJInterpreter(String input) async {
  final FJParserModule fjParserModule = FJParserModule.import();
  final FJTypingModule fjTypingModule = FJTypingModule.import();
  final FJComputationModule fjComputationModule = FJComputationModule.import();

  final FJProgram program = fjParserModule.fjParse(input);
  final PythonClassInterface<PythonFfiDelegate<Object?>, Object?> typingResult =
      fjTypingModule.typecheckProgram(program);
  final PythonClassInterface<PythonFfiDelegate<Object?>, Object?>
      computationResult = fjComputationModule.computeProgram(program);

  return "$computationResult :: $typingResult";
}
