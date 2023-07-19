import "package:python_ffi_dart/python_ffi_dart.dart";

export "python_modules/basic_dataclass.g.dart";

final class Person extends PythonClass {
  factory Person(String name) => PythonFfiDart.instance.importClass(
        "basic_dataclass",
        "Person",
        Person.from,
        <Object?>[name],
      );

  Person.from(super.pythonClass) : super.from();

  void move(int dx, int dy) => getFunction("move").call(<Object?>[dx, dy]);
}
