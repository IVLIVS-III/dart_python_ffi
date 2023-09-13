import "package:fj_playground/python_modules/fj.g.dart";

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

  String get text {
    final StringBuffer buffer = StringBuffer();
    if (!onlyTypecheck) {
      buffer
        ..writeln(program)
        ..writeln()
        ..write(computedExpression)
        ..write(" :: ");
    }
    buffer.writeln(typingResult);
    return buffer.toString();
  }
}

Future<InterpreterResult> runFJInterpreter(
  String input, {
  bool withConstructor = false,
  bool onlyTypecheck = false,
}) async {
  final fj fjModule = fj.import();

  final List<String> result = fjModule.fj_run(
    program_as_str: input,
    with_constructor: withConstructor,
    only_typecheck: onlyTypecheck,
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
