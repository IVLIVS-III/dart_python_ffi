import "package:python_ffi/python_ffi.dart";

final class DataClass extends PythonClass {
  factory DataClass(int a, String b) {
    final DataClass dataClass = PythonFfi.instance.importClass(
      "data_class",
      "DataClass",
      DataClass.from,
      <Object?>[a, b],
    );
    return dataClass;
  }

  DataClass.from(super.pythonClass) : super.from();

  int get a => getAttribute("a")! as int;

  set a(int value) => setAttribute("a", value);

  String get b => getAttribute("b")! as String;

  set b(String value) => setAttribute("b", value);

  @override
  String toString() => "DataClass(a: $a, b: $b)";
}

final class DataClassModule extends PythonModule {
  DataClassModule.from(super.pythonModule) : super.from();

  static DataClassModule import() => PythonFfi.instance.importModule(
        "data_class",
        DataClassModule.from,
      );
}
