import "package:python_ffi_dart/python_ffi_dart.dart";

final class BasicCliAdder extends PythonModule {
  BasicCliAdder.from(super.pythonModule) : super.from();

  static BasicCliAdder import() => PythonFfiDart.instance
      .importModule("basic_cli_adder", BasicCliAdder.from);

  num add(num x, num y) => getFunction("add").call(<Object?>[x, y]);
}
