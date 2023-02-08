// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

library python_ffi;

import "dart:async";

import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:python_ffi_dart/python_ffi_dart.dart" as python_ffi_dart
    show PythonModule;
import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";

export "package:python_ffi_dart/python_ffi_dart.dart"
    hide PythonFfiDart, PythonModule;
export "package:python_ffi_platform_interface/python_ffi_platform_interface.dart"
    show PythonModuleDefinition, SourceFile, SourceDirectory;

part "src/module.dart";
part "src/python_ffi_base.dart";
