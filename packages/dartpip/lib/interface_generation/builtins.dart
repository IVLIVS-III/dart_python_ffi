import "package:python_ffi_dart/python_ffi_dart.dart";

final class BuiltinsModule extends PythonModule {
  BuiltinsModule.from(super.moduleDelegate) : super.from();

  static BuiltinsModule import() =>
      PythonFfiDart.instance.importModule("builtins", BuiltinsModule.from);

  Object? dir(Object? object) => getFunction("dir").call(<Object?>[object]);
}
