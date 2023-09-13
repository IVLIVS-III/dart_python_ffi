part of interface_gen;

/// TODO: Document.
String sanitizeName(
  String name, {
  Set<String> extraKeywords = const <String>{},
}) {
  /// Reference: https://dart.dev/language/keywords
  const Set<String> dartKeywords = <String>{
    "abstract",
    "as",
    "assert",
    "async",
    "await",
    "base",
    "break",
    "case",
    "catch",
    "class",
    "const",
    "continue",
    "covariant",
    "default",
    "deferred",
    "do",
    "dynamic",
    "else",
    "enum",
    "export",
    "extends",
    "extension",
    "external",
    "factory",
    "false",
    "final",
    "finally",
    "for",
    "Function",
    "get",
    "hide",
    "if",
    "implements",
    "import",
    "in",
    "interface",
    "is",
    "late",
    "library",
    "mixin",
    "new",
    "null",
    "on",
    "operator",
    "part",
    "required",
    "rethrow",
    "return",
    "sealed",
    "set",
    "show",
    "static",
    "super",
    "switch",
    "sync",
    "this",
    "throw",
    "true",
    "try",
    "typedef",
    "var",
    "void",
    "when",
    "while",
    "with",
    "yield",
  };

  /// Reference: https://dart.dev/language/built-in-types
  const Set<String> dartBuiltInTypes = <String>{
    "int",
    "double",
    "num",
    "String",
    "bool",
    "List",
    "Map",
    "Set",
    "Runes",
    "Symbol",
    "DateTime",
    "Duration",
    "Object",
    "Null",
    "Enum",
    "Future",
    "Stream",
    "Iterable",
    "Iterator",
    "Never",
  };
  if (dartKeywords.contains(name) ||
      dartBuiltInTypes.contains(name) ||
      extraKeywords.contains(name)) {
    return "\$$name";
  }
  return name;
}

/// TODO: Document.
Future<String> doInspection(
  PythonModuleDefinition? moduleDefinition, {
  required String moduleName,
  required String appType,
  required InspectionCache cache,
  required String stdlibPath,
  String parentModulePrefix = "",
}) async {
  try {
    print(
      "Generating Dart interface for '$parentModulePrefix$moduleName' via inspect...",
    );
    if (parentModulePrefix.isEmpty) {
      if (moduleDefinition != null) {
        await PythonFfiDart.instance.prepareModule(moduleDefinition);
      } else {
        return "null";
      }
    }
    final Module interface = PythonFfiDart.instance.importModule(
      "$parentModulePrefix$moduleName",
      (PythonModuleInterface<PythonFfiDelegate<Object?>, Object?> m) =>
          Module.from(
        m,
        name: moduleName,
        sanitizedName: sanitizeName(moduleName),
      ),
    );
    interface.collectChildren(
      cache,
      stdlibPath: stdlibPath,
      parentModule: interface,
    );

    Object? toEncodable(Object? o) {
      final Object? object = o;
      return switch (object) {
        null => o.toString(),
        Module() ||
        ClassDefinition() ||
        ClassInstance() ||
        Function_() ||
        Object_() =>
          <String, Object?>{
            "type": object.runtimeType.toString(),
            "value": jsonEncode(
              (object as InspectEntry).value,
              toEncodable: toEncodable,
            ),
            "string": object.toString(),
          },
        PythonIterable<Object?, PythonFfiDelegate<Object?>, Object?>() ||
        PythonIterator<Object?, PythonFfiDelegate<Object?>, Object?>() =>
          <String, Object?>{
            "type": object.runtimeType.toString(),
            "value": jsonEncode(
              (object as PythonObjectInterface<PythonFfiDelegate<Object?>,
                      Object?>)
                  .reference,
              toEncodable: toEncodable,
            ),
          },
        PythonObjectInterface<PythonFfiDelegate<Object?>, Object?>() =>
          <String, Object?>{
            "type": object.runtimeType.toString(),
            "value": jsonEncode(object.reference, toEncodable: toEncodable),
            "string": object.toString(),
          },
        _ => o.toString(),
      };
    }

    final String json = jsonEncode(
      <String, Object?>{
        "_module": interface.debugDump(cache: cache),
        "_entries": cache.entries
            .whereNot(
              ((int, InspectEntry) e) =>
                  e.$2.type == InspectEntryType.primitive,
            )
            .map(
              ((int, InspectEntry) e) => <String, Object?>{
                "id": e.$1,
                "entry": e.$2.debugDump(cache: cache),
              },
            )
            .toList(),
      },
      toEncodable: toEncodable,
    );
    return json;
  } on PythonFfiException catch (e) {
    print(e);
  }
  return "null";
}

/// TODO: Document.
String emitInspection(
  InspectionCache cache, {
  bool primaryModuleOnly = true,
  String moduleParentPrefix = "",
}) {
  final Module? primaryModule = cache.modules.firstOrNull;
  final InstantiatedModule? primaryInstantiatedModule = primaryModule != null
      ? InstantiatedModule.fromModule(primaryModule)
      : null;
  if (primaryInstantiatedModule == null) {
    primaryModuleOnly = false;
  }
  const String analysisIgnoreLine =
      "// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null";
  final StringBuffer buffer = StringBuffer("""
$analysisIgnoreLine

""");
  if (primaryInstantiatedModule != null) {
    buffer.writeln("library ${primaryInstantiatedModule.sanitizedName};");
  }
  const String typedDataImportLine = 'import "dart:typed_data";';
  const String pythonFfiImportLine =
      'import "package:python_ffi_dart/python_ffi_dart.dart";';
  buffer.writeln("""
$typedDataImportLine

$pythonFfiImportLine
""");
  final Set<String> topLevelNames = <String>{};
  for (final ClassInstance typedef in cache.typedefs) {
    for (final InstantiatedClassInstance instantiatedTypedef
        in typedef.instantiations.whereType()) {
      final String typedefName = instantiatedTypedef.sanitizedName;
      if (topLevelNames.contains(typedefName)) {
        continue;
      }
      topLevelNames.add(typedefName);
      instantiatedTypedef.emit(buffer, cache: cache);
    }
  }
  for (final ClassDefinition classDefinition in cache.classDefinitions) {
    for (final InstantiatedClassDefinition instantiatedClassDefinition
        in classDefinition.instantiations.whereType()) {
      final String className = instantiatedClassDefinition.sanitizedName;
      if (topLevelNames.contains(className)) {
        continue;
      }
      topLevelNames.add(className);
      instantiatedClassDefinition.emit(
        buffer,
        cache: cache,
        moduleParentPrefix: moduleParentPrefix,
      );
    }
  }
  for (final Module module in cache.modules) {
    final InstantiatedModule instantiatedModule =
        InstantiatedModule.fromModule(module);
    final String moduleName = instantiatedModule.sanitizedName;
    if (topLevelNames.contains(moduleName)) {
      continue;
    }
    topLevelNames.add(moduleName);
    instantiatedModule.emit(
      buffer,
      cache: cache,
      moduleParentPrefix: moduleParentPrefix,
    );
  }
  final String result = buffer.toString();
  if (!result.contains("Uint8List")) {
    return result.replaceAll(typedDataImportLine, "");
  }
  return result;
}
