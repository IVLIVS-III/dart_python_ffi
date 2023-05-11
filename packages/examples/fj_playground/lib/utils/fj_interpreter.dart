import "package:fj_playground/python_modules/fj.dart";

class InterpreterResult {
  const InterpreterResult({
    required this.program,
    required this.computedExpression,
    required this.typingResult,
    this.withContructor = false,
    this.onlyTypecheck = false,
  });

  final String program;
  final String computedExpression;
  final String typingResult;

  final bool withContructor;
  final bool onlyTypecheck;
}

Future<InterpreterResult> runFJInterpreter(
  String input, {
  bool withConstructor = false,
  bool onlyTypecheck = false,
}) async {
  final FJModule fjModule = FJModule.import();

  final List<String> result = fjModule.fjRun(
    input,
    withConstructor: withConstructor,
    onlyTypecheck: onlyTypecheck,
  );

  if (result.length != 3) {
    throw Exception("Expected 3 results, got ${result.length}");
  }

  return InterpreterResult(
    program: result[0],
    computedExpression: result[1],
    typingResult: result[2],
    withContructor: withConstructor,
    onlyTypecheck: onlyTypecheck,
  );
}
