library dartpip;

import "dart:async";
import "dart:convert";
import "dart:io";
import "dart:typed_data";

import "package:args/args.dart";
import "package:args/command_runner.dart";
import "package:collection/collection.dart";
import "package:dartpip/interface_gen/interface_gen.dart";
import "package:dartpip_solver/dartpip_solver.dart";
import "package:path/path.dart" as p;
import "package:python_ffi_cpython_dart/python_ffi_cpython_dart.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:yaml/yaml.dart";
import "package:yaml_edit/yaml_edit.dart";

part "builtin_modules/python_ffi.py.dart";

part "commands/bundle.dart";

part "commands/bundle_module.dart";

part "commands/download.dart";

part "commands/install.dart";

part "constants.dart";

part "extensions.dart";

part "module_bundle/module_bundle.dart";

part "module_bundle/src/console_module_bundle.dart";

part "module_bundle/src/flutter_module_bundle.dart";

part "python_module.dart";

part "source_file.dart";

part "util.dart";

part "util/pubspec_editor.dart";

part "util/python_dependency.dart";

/// TODO: Document.
const String kAppTypeFlutter = _kAppTypeFlutter;

/// TODO: Document.
const String kAppTypeConsole = _kAppTypeConsole;
