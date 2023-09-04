import "package:flutter_test/flutter_test.dart";
// always skip until testing issues are resolved
// import "package:python_ffi/python_ffi.dart";
// import "package:python_ffi_cpython/python_ffi_cpython.dart";
import "package:transitive_dependencies_test_flutter/main.dart";

void main() {
  setUpAll(
    () async {
      // always skip until testing issues are resolved
      /*
      PythonFfi.instance.delegate = PythonFfiCPython();
      await PythonFfi.instance.initialize();
      */
    },
  );

  testWidgets(
    "User agent is displayed",
    (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      expect(
        find.text(
          "feedparser/6.0.10 +https://github.com/kurtmckee/feedparser/",
        ),
        findsOneWidget,
      );
    },
    // always skip until testing issues are resolved
    skip: true,
  );
}
