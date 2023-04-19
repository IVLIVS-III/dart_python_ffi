import "package:fj_playground/python_modules/fj.dart";
import "package:python_ffi/python_ffi.dart";

Future<String> runFJInterpreter(String input) async {
  final FJModule fjModule = FJModule.import();

  final FJProgram program = fjModule.fjParse(input);
  final PythonClassInterface<PythonFfiDelegate<Object?>, Object?> typingResult =
      fjModule.typecheckProgram(program);
  final PythonClassInterface<PythonFfiDelegate<Object?>, Object?>
      computationResult = fjModule.computeProgram(program);

  return "$computationResult :: $typingResult";
}
