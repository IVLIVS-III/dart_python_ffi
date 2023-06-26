import "package:python_ffi/python_ffi.dart";

final class BasicAdderModule extends PythonModule {
  BasicAdderModule.from(super.pythonModule) : super.from();

  static BasicAdderModule import() =>
      PythonFfi.instance.importModule("basic_adder", BasicAdderModule.from);

  num add(num x, num y) => getFunction("add").call(<num>[x, y]);
}
