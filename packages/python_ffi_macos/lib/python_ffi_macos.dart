library python_ffi_macos;

import "dart:async";
import "dart:convert";
import "dart:ffi";
import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:path_provider/path_provider.dart" as path_provider;
import "package:python_ffi_macos_dart/python_ffi_macos_dart.dart";
import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";

abstract class _PythonFfiMacOS extends PythonFfiPlatform<Pointer<PyObject>>
    implements PythonFfiMacOSBase {
  @override
  Future<Directory> getApplicationSupportDirectory() async =>
      path_provider.getApplicationSupportDirectory();

  @override
  FutureOr<ByteData> loadPythonFile(PythonSourceFileEntity sourceFile) {
    if (sourceFile is SourceFile) {
      return PlatformAssetBundle().load("python-modules/${sourceFile.name}");
    } else if (sourceFile is SourceBytes) {
      return ByteData.view(sourceFile.bytes.buffer);
    } else if (sourceFile is SourceBase64) {
      return ByteData.view(base64Decode(sourceFile.base64).buffer);
    }
    throw Exception("Unsupported source file type: $sourceFile");
  }
}

/// The macOS implementation of [PythonFfiPlatform].
class PythonFfiMacOS extends _PythonFfiMacOS with PythonFfiMacOSMixin {
  /// Registers this class as the default instance of [PythonFfiPlatform].
  static void registerWith() {
    PythonFfiPlatform.instance = PythonFfiMacOS();
  }

  @override
  Future<void> openDylib() async {
    final DynamicLibrary dylib = DynamicLibrary.open("libpython3.11.dylib");
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
        if (child == "LICENSE.txt") {
          licenseFile = SourceFile(child as String);
          continue;
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
    final ByteData modulesJsonRaw =
        await PlatformAssetBundle().load("python-modules/modules.json");
    return _decodePythonModules(
      utf8.decode(modulesJsonRaw.buffer.asUint8List()),
    ).toSet();
  }
}
