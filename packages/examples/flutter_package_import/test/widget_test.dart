// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import "dart:io";
import "dart:math" show Random;

import "package:flutter/material.dart";
import "package:flutter_package_export/flutter_package_export.dart";
import "package:flutter_package_import/main.dart";
import "package:flutter_test/flutter_test.dart";
import "package:path/path.dart" as p;
import "package:path_provider_platform_interface/path_provider_platform_interface.dart";
import "package:plugin_platform_interface/plugin_platform_interface.dart";
import "package:python_ffi/python_ffi.dart";
import "package:python_ffi_cpython/python_ffi_cpython.dart";

// paths used to mock PathProvider
final String kTestPathPrefix =
    "testPath-${Random().nextDouble().hashCode.toRadixString(16)}";
final String kTemporaryPath = p.join(kTestPathPrefix, "temporaryPath");
final String kApplicationSupportPath =
    p.join(kTestPathPrefix, "applicationSupportPath");
final String kDownloadsPath = p.join(kTestPathPrefix, "downloadsPath");
final String kLibraryPath = p.join(kTestPathPrefix, "libraryPath");
final String kApplicationDocumentsPath =
    p.join(kTestPathPrefix, "applicationDocumentsPath");
final String kExternalCachePath = p.join(kTestPathPrefix, "externalCachePath");
final String kExternalStoragePath =
    p.join(kTestPathPrefix, "externalStoragePath");

void main() {
  final Directory tempTestDir = Directory(kTestPathPrefix);

  setUp(() async {
    if (tempTestDir.existsSync()) {
      await tempTestDir.delete(recursive: true);
    }
    await tempTestDir.create(recursive: true);
    PathProviderPlatform.instance = FakePathProviderPlatform();
  });

  tearDown(() async {
    if (tempTestDir.existsSync()) {
      await tempTestDir.delete(recursive: true);
    }
  });

  testWidgets(
    "Counter increments smoke test",
    (WidgetTester tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      PythonFfi.instance.delegate = PythonFfiCPython();
      await initialize();
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that our counter starts at 0.
      expect(find.text("0"), findsOneWidget);
      expect(find.text("1"), findsNothing);

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Verify that our counter has incremented.
      expect(find.text("0"), findsNothing);
      expect(find.text("1"), findsOneWidget);
    },
    // always skip until testing issues are resolved
    skip: true,
  );
}

class FakePathProviderPlatform extends Fake
    with
        // ignore: prefer_mixin
        MockPlatformInterfaceMixin
    implements
        PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async => kTemporaryPath;

  @override
  Future<String?> getApplicationSupportPath() async => kApplicationSupportPath;

  @override
  Future<String?> getLibraryPath() async => kLibraryPath;

  @override
  Future<String?> getApplicationDocumentsPath() async =>
      kApplicationDocumentsPath;

  @override
  Future<String?> getExternalStoragePath() async => kExternalStoragePath;

  @override
  Future<List<String>?> getExternalCachePaths() async =>
      <String>[kExternalCachePath];

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async =>
      <String>[kExternalStoragePath];

  @override
  Future<String?> getDownloadsPath() async => kDownloadsPath;
}
