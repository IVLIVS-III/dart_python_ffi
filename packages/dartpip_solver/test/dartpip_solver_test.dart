import "package:test/test.dart";

void main() {
  group(
    "A group of tests",
    () {
      test("alwasy skip", () => null);
    },
    skip: true,
  );
}
