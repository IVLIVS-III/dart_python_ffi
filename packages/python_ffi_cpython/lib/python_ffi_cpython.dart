library python_ffi_cpython;

import "dart:async";
import "dart:convert";
import "dart:ffi";
import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:path/path.dart" as p;
import "package:path_provider/path_provider.dart" as path_provider;
import "package:python_ffi_cpython_dart/python_ffi_cpython_dart.dart";
import "package:python_ffi_interface/python_ffi_interface.dart";

/// The macOS and Windows implementation of [PythonFfiPlatform].
final class PythonFfiCPython extends PythonFfiCPythonBase
    with PythonFfiCPythonMixin {
  String? _package;

  @override
  Future<void> initialize({required String? package}) {
    _package = package;
    return super.initialize(package: package);
  }

  @override
  Future<Directory> getApplicationSupportDirectory() async =>
      path_provider.getApplicationSupportDirectory();

  @override
  FutureOr<ByteData> loadPythonFile(PythonSourceFileEntity sourceFile) {
    final String? package = _package;
    final String assetPath = "${switch (package) {
      String() => "packages/$package/",
      _ => "",
    }}python-modules/${sourceFile.name}";
    if (sourceFile is SourceFile) {
      return PlatformAssetBundle().load(assetPath);
    } else if (sourceFile is SourceBase64) {
      return ByteData.view(base64Decode(sourceFile.base64).buffer);
    }
    throw Exception("Unsupported source file type: $sourceFile");
  }

  /// Registers this class as the default instance of [PythonFfiPlatform].
  static void registerWith() {
    PythonFfiDelegate.instance = PythonFfiCPython();
  }

  static String get _version => PythonFfiCPythonDart.version;

  @override
  Future<void> copyPythonStdLib() async {
    final ByteData zipFile = await rootBundle
        .load("packages/python_ffi_cpython/assets/python$_version.zip");
    final File tmpZipFile =
        File(p.join((await stdlibDir).path, "python$_version.zip"));
    await tmpZipFile.create(recursive: true);
    await tmpZipFile.writeAsBytes(zipFile.buffer.asUint8List());
    await extractPythonStdLibZip(tmpZipFile);
    await tmpZipFile.delete();
  }

  @override
  Future<void> openDylib() async {
    final String dylibPath;
    if (Platform.isMacOS) {
      dylibPath = "libpython$_version.dylib";
    } else if (Platform.isWindows) {
      dylibPath = "python${_version.replaceAll(".", "")}.dll";
    } else if (Platform.isLinux) {
      dylibPath = "libpython$_version.so";
    } else {
      throw Exception("Unsupported platform: ${Platform.operatingSystem}");
    }
    final DynamicLibrary dylib = DynamicLibrary.open(dylibPath);
    bindings = DartPythonCBindings(dylib);
  }

  @override
  FutureOr<void> prepareModule(PythonModuleDefinition moduleDefinition) {
    final PythonSourceFileEntity? license = moduleDefinition.license;
    if (license != null) {
      LicenseRegistry.addLicense(() async* {
        final ByteData licenseBytes = await loadPythonFile(license);
        final String licenseText =
            utf8.decode(licenseBytes.buffer.asUint8List());
        yield LicenseEntryWithLineBreaks(
          <String>[moduleDefinition.name],
          licenseText,
        );
      });
    }
    return super.prepareModule(moduleDefinition);
  }

  static (
    PythonSourceEntity,
    PythonSourceFileEntity?
  ) _decodePythonSourceEntity(Object data) =>
      PythonFfiCPythonDart.decodePythonSourceEntity(
        data,
        platform: PythonSourceEntityPlatform.flutter,
      );

  static Iterable<PythonModuleDefinition> _decodePythonModules(
    String pythonModules,
  ) sync* {
    final Map<String, dynamic> pythonModulesJson =
        jsonDecode(pythonModules) as Map<String, dynamic>;
    for (final MapEntry<String, dynamic> entry in pythonModulesJson.entries) {
      final String moduleName = entry.key;
      final Object? root = entry.value;
      if (root == null) {
        continue;
      }
      final (PythonSourceEntity decodedRoot, PythonSourceFileEntity? license) =
          _decodePythonSourceEntity(root);
      yield PythonModuleDefinition(
        name: moduleName,
        root: decodedRoot,
        license: license,
      );
    }
  }

  @override
  Future<Set<PythonModuleDefinition>> discoverPythonModules({
    required String? package,
  }) async {
    try {
      const String localModulesJsonPath = "python-modules/modules.json";
      final String modulesJsonPath = switch (package) {
        String() => "packages/$package/$localModulesJsonPath",
        _ => localModulesJsonPath,
      };
      final ByteData modulesJsonRaw =
          await PlatformAssetBundle().load(modulesJsonPath);
      return _decodePythonModules(
        utf8.decode(modulesJsonRaw.buffer.asUint8List()),
      ).toSet();
      // ignore: avoid_catching_errors
    } on FlutterError catch (e) {
      debugPrint("Failed to load python modules: $e");
      return <PythonModuleDefinition>{};
    }
  }
}
