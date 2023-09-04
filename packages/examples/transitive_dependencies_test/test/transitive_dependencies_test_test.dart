import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:test/test.dart";
import "package:transitive_dependencies_test/python_modules/feedparser.g.dart";
import "package:transitive_dependencies_test/python_modules/src/python_modules.g.dart";

void main() {
  setUpAll(() async => PythonFfiDart.instance.initialize(kPythonModules));

  test("import module", () {
    expect(feedparser.import(), anything);
  });

  test("get user agent", () {
    expect(
      feedparser.import().USER_AGENT,
      "feedparser/6.0.10 +https://github.com/kurtmckee/feedparser/",
    );
  });
}
