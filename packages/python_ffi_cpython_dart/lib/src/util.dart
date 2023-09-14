part of python_ffi_cpython_dart;

/// This is used by dartpip to generate interface definitions for Flutter
/// projects.
/// Since dartpip is a Dart console app and thus uses the `python_ffi_dart`
/// package, it must somehow be able to emulate decoding of Python source
/// entities intended for consumption by Flutter apps.
enum PythonSourceEntityPlatform {
  /// The Python source entities are intended for consumption by console apps.
  console,

  /// The Python source entities are intended for consumption by Flutter apps.
  flutter,
}

(PythonSourceEntity, PythonSourceFileEntity?) _decodePythonSourceEntity({
  required Object? data,
  required PythonSourceEntityPlatform platform,
}) =>
    switch (platform) {
      PythonSourceEntityPlatform.console when data is Map<String, dynamic> =>
        _decodePythonSourceEntityConsole(data),
      PythonSourceEntityPlatform.flutter when data is Object =>
        _decodePythonSourceEntityFlutter(data),
      _ => throw ArgumentError.value(
          platform,
          "platform",
          "platform must be either one of ${PythonSourceEntityPlatform.values}",
        ),
    };

(PythonSourceEntity, PythonSourceFileEntity?) _decodePythonSourceEntityConsole(
  Map<String, dynamic> data,
) {
  if (data case {"name": final String name, "base64": final String base64}) {
    return (SourceBase64(name, base64), null);
  }
  if (data
      case {
        "name": final String name,
        "children": final List<dynamic> children
      }) {
    final SourceDirectory entity = SourceDirectory(name);
    PythonSourceFileEntity? licenseFile;
    for (final Object? child in children) {
      if (child is! Map<String, dynamic>) {
        PythonFfiDelegate.logger.trace(
          "Unexpected child type<${child.runtimeType}>: $child",
        );
        continue;
      }
      final Object? childName = child["name"];
      if (childName == null) {
        continue;
      }
      if (childName is! String) {
        PythonFfiDelegate.logger.trace(
          "Unexpected childName type<${childName.runtimeType}>: $childName",
        );
        continue;
      }
      if (childName.toLowerCase().contains("license")) {
        licenseFile = SourceBase64(childName, child["base64"] as String);
        continue;
      }
      final (
        PythonSourceEntity pythonSourceEntity,
        PythonSourceFileEntity? pythonSourceFileEntity
      ) = _decodePythonSourceEntityConsole(child);
      licenseFile ??= pythonSourceFileEntity;
      entity.add(pythonSourceEntity);
    }
    return (entity, licenseFile);
  }
  throw ArgumentError.value(
    data,
    "<${data.runtimeType}>data: $data",
    "data must be a Map<String, dynamic> with a 'name' key",
  );
}

(PythonSourceEntity, PythonSourceFileEntity?) _decodePythonSourceEntityFlutter(
  Object data,
) {
  if (data is String) {
    return (SourceFile(data), null);
  }
  if (data case {"name": final String name, "base64": final String base64}) {
    return (SourceBase64(name, base64), null);
  }
  // TODO: for some reason, matching the children as List<Object> doesn't work
  //       even if they are all non-null. Tighten the type check once this is
  //       fixed.
  if (data
      case {
        "name": final String name,
        "children": final List<Object?> children
      }) {
    final SourceDirectory entity = SourceDirectory(name);
    PythonSourceFileEntity? licenseFile;
    for (final Object child in children.whereType()) {
      if (child is String) {
        if (child.toLowerCase().contains("license")) {
          licenseFile = SourceFile(child);
          continue;
        }
      }
      final (
        PythonSourceEntity pythonSourceEntity,
        PythonSourceFileEntity? pythonSourceFileEntity
      ) = _decodePythonSourceEntityFlutter(child);
      licenseFile ??= pythonSourceFileEntity;
      entity.add(pythonSourceEntity);
    }
    return (entity, licenseFile);
  }
  throw ArgumentError.value(
    data,
    "data, $data",
    "data must be either a String or a Map<String, dynamic> with a 'name' key",
  );
}
