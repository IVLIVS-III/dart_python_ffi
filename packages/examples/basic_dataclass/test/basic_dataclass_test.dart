import "package:basic_dataclass/basic_dataclass.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:test/test.dart";

void main() async {
  setUpAll(() async {
    await PythonFfiDart.instance.initialize(pythonModules: kPythonModules);
  });

  test("move W", () {
    expect(
      (Person(name: "John")..move(dx: 0, dy: -1)).toString(),
      "John @ (0, -1)",
    );
  });

  test("move A", () {
    expect(
      (Person(name: "John")..move(dx: -1, dy: 0)).toString(),
      "John @ (-1, 0)",
    );
  });

  test("move S", () {
    expect(
      (Person(name: "John")..move(dx: 0, dy: 1)).toString(),
      "John @ (0, 1)",
    );
  });

  test("move D", () {
    expect(
      (Person(name: "John")..move(dx: 1, dy: 0)).toString(),
      "John @ (1, 0)",
    );
  });
}
