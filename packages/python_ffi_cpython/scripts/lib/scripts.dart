library scripts;

import "dart:io";

import "package:args/args.dart";
import "package:args/command_runner.dart";
import "package:cli_util/cli_logging.dart";

part "src/commands/build.dart";
part "src/commands/clone.dart";
part "src/commands/cpython.dart";
part "src/commands/get_version.dart";
part "src/commands/patch.dart";
part "src/commands/use.dart";
part "src/extensions/relative.dart";
part "src/extensions/yes_no.dart";
part "src/util/tool_exit.dart";

Future<void> main(List<String> arguments) async {
  final CommandRunner<void> runner = CommandRunner<void>(
    "scripts",
    "A collection of tools used to build and test the `python_ffi_cpython` package.",
  )..addCommand(_CpythonCommand());

  await runner.run(arguments);
}
