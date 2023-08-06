import "package:basic_dataclass/basic_dataclass.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:test/test.dart";

void main() async {
  await PythonFfiDart.instance.initialize(kPythonModules);

  late Person person;

  setUp(() => person = Person(name: "John"));

  test("move W", () {
    expect((person..move(dx: 0, dy: -1)).toString(), "John @ (0, -1)");
  });

  test("move A", () {
    expect((person..move(dx: -1, dy: 0)).toString(), "John @ (-1, 0)");
  });

  test("move S", () {
    expect((person..move(dx: 0, dy: 1)).toString(), "John @ (0, 1)");
  });

  test("move D", () {
    expect((person..move(dx: 1, dy: 0)).toString(), "John @ (1, 0)");
  });
}
