library python_ffi_cpython;

import "dart:async";
import "dart:convert";
import "dart:ffi";
import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:path_provider/path_provider.dart" as path_provider;
import "package:python_ffi_cpython_dart/python_ffi_cpython_dart.dart";
import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";

abstract class _PythonFfiCPython extends PythonFfiPlatform<Pointer<PyObject>>
    implements PythonFfiCPythonBase {
  @override
  Future<Directory> getApplicationSupportDirectory() async =>
      path_provider.getApplicationSupportDirectory();

  @override
  FutureOr<ByteData> loadPythonFile(PythonSourceFileEntity sourceFile) {
    if (sourceFile is SourceFile) {
      return PlatformAssetBundle().load("python-modules/${sourceFile.name}");
    } else if (sourceFile is SourceBase64) {
      return ByteData.view(base64Decode(sourceFile.base64).buffer);
    }
    throw Exception("Unsupported source file type: $sourceFile");
  }
}

/// The macOS and Windows implementation of [PythonFfiPlatform].
class PythonFfiCPython extends _PythonFfiCPython with PythonFfiCPythonMixin {
  /// Registers this class as the default instance of [PythonFfiPlatform].
  static void registerWith() {
    PythonFfiPlatform.instance = PythonFfiCPython();
  }

  @override
  Future<void> openDylib() async {
    final String version = "3.11";
    final String dylibPath;
    if (Platform.isMacOS) {
      dylibPath = "libpython$version.dylib";
    } else if (Platform.isWindows) {
      dylibPath = "python$version.dll";
    } else if (Platform.isLinux) {
      dylibPath = "libpython$version.so";
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

  static Pair<PythonSourceEntity, PythonSourceFileEntity?>
      _decodePythonSourceEntity(
    Object data,
  ) {
    if (data is String) {
      return Pair<PythonSourceEntity, PythonSourceFileEntity?>(
        SourceFile(data),
        null,
      );
    }
    data = data as Map<String, dynamic>;
    if (data.keys.contains("children")) {
      final SourceDirectory entity = SourceDirectory(data["name"] as String);
      PythonSourceFileEntity? licenseFile;
      for (final Object? child in data["children"] as List<Object?>) {
        if (child == null) {
          continue;
        }
        if (child is String) {
          if (child.toLowerCase().contains("license")) {
            licenseFile = SourceFile(child);
            continue;
          }
        }
        final Pair<PythonSourceEntity, PythonSourceFileEntity?> result =
            _decodePythonSourceEntity(child);
        licenseFile ??= result.second;
        entity.add(result.first);
      }
      return Pair<PythonSourceEntity, PythonSourceFileEntity?>(
        entity,
        licenseFile,
      );
    } else {
      return Pair<PythonSourceEntity, PythonSourceFileEntity?>(
        SourceBase64(data["name"] as String, data["base64"] as String),
        null,
      );
    }
  }

  static Iterable<PythonModuleDefinition> _decodePythonModules(
    String pythonModules,
  ) sync* {
    final Map<String, dynamic> pythonModulesJson =
        jsonDecode(pythonModules) as Map<String, dynamic>;
    for (final MapEntry<String, dynamic> entry in pythonModulesJson.entries) {
      final String moduleName = entry.key;
      final Map<String, dynamic> moduleJson =
          entry.value as Map<String, dynamic>;
      final Object? root = moduleJson["root"];
      if (root == null) {
        continue;
      }
      final Pair<PythonSourceEntity, PythonSourceFileEntity?> result =
          _decodePythonSourceEntity(root);
      yield PythonModuleDefinition(
        name: moduleName,
        root: result.first,
        license: result.second,
      );
    }
  }

  @override
  Future<Set<PythonModuleDefinition>> discoverPythonModules() async {
    try {
      final ByteData modulesJsonRaw =
          await PlatformAssetBundle().load("python-modules/modules.json");
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
