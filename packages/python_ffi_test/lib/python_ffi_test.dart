library python_ffi_test;

import "dart:async";
import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter_test/flutter_test.dart";
import "package:path/path.dart" as p;
import "package:path_provider_platform_interface/path_provider_platform_interface.dart";
import "package:plugin_platform_interface/plugin_platform_interface.dart";
import "package:python_ffi/python_ffi.dart";
import "package:python_ffi_cpython/python_ffi_cpython.dart";
import "package:uuid/uuid.dart";

class PythonFfiMock extends PythonFfi {
  @visibleForTesting
  factory PythonFfiMock() => _instance ??= PythonFfiMock._();

  PythonFfiMock._();

  static PythonFfiMock? _instance;

  void _setDelegate() {
    final String platform = kIsWeb ? "web" : defaultTargetPlatform.toString();
    final UnsupportedError unsupportedError =
        UnsupportedError("Mocking PythonFfi on $platform is not supported.");

    final PythonFfiDelegate<Object?> delegate = switch (defaultTargetPlatform) {
      _ when kIsWeb => throw unsupportedError,
      TargetPlatform.android => throw unsupportedError,
      TargetPlatform.iOS => throw unsupportedError,
      TargetPlatform.macOS => PythonFfiCPython(),
      TargetPlatform.windows => PythonFfiCPython(),
      TargetPlatform.linux => PythonFfiCPython(),
      TargetPlatform.fuchsia => PythonFfiCPython(),
    };
    this.delegate = delegate;
  }

  /// Initializes the Python FFI for testing.
  ///
  /// *Note:* This method should only be called in test code.
  ///
  /// You will probably never specify a value for [package] when calling this
  /// method. If you are implementing a package that uses this plugin, you
  /// can omit the [package] parameter when calling this method as you are
  /// bundling the Python modules with your package.
  /// If you are externally testing a package that uses this plugin, you
  /// should specify the [package] parameter when calling this method and set
  /// it to the name of the package that you are testing.
  @override
  FutureOr<void> initialize({
    String? package,
    bool? verboseLogging,
  }) {
    _setDelegate();

    PathProviderPlatform.instance = FakePathProviderPlatform();

    return super.initialize(package: package, verboseLogging: verboseLogging);
  }
}

@visibleForTesting
class FakePathProviderPlatform extends Fake
    with
        // ignore: invalid_use_of_visible_for_testing_member, prefer_mixin
        MockPlatformInterfaceMixin
    implements
        PathProviderPlatform {
  @visibleForTesting
  FakePathProviderPlatform();

  final String _randomUuid = const Uuid().v4();

  static const String kTemporaryPath = "temporaryPath";
  static const String kApplicationSupportPath = "applicationSupportPath";
  static const String kDownloadsPath = "downloadsPath";
  static const String kLibraryPath = "libraryPath";
  static const String kApplicationDocumentsPath = "applicationDocumentsPath";
  static const String kExternalCachePath = "externalCachePath";
  static const String kExternalStoragePath = "externalStoragePath";

  late final String basePath =
      p.join(Directory.systemTemp.path, _randomUuid) + Platform.pathSeparator;

  @override
  Future<String?> getTemporaryPath() async => basePath + kTemporaryPath;

  @override
  Future<String?> getApplicationSupportPath() async =>
      basePath + kApplicationSupportPath;

  @override
  Future<String?> getLibraryPath() async => basePath + kLibraryPath;

  @override
  Future<String?> getApplicationDocumentsPath() async =>
      basePath + kApplicationDocumentsPath;

  @override
  Future<String?> getExternalStoragePath() async =>
      basePath + kExternalStoragePath;

  @override
  Future<List<String>?> getExternalCachePaths() async =>
      <String>[basePath + kExternalCachePath];

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async =>
      <String>[basePath + kExternalStoragePath];

  @override
  Future<String?> getDownloadsPath() async => basePath + kDownloadsPath;
}
