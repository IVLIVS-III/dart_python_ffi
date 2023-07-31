part of interface_gen;

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

Future<String> doInspection(
  PythonModuleDefinition moduleDefinition, {
  required String appType,
  required InspectionCache cache,
  required String stdlibPath,
}) async {
  final String moduleName = moduleDefinition.name;
  print("Generating Dart interface for $moduleName via inspect...");
  await PythonFfiDart.instance.prepareModule(moduleDefinition);
  final Module interface = PythonFfiDart.instance.importModule(
    moduleName,
    (PythonModuleInterface<PythonFfiDelegate<Object?>, Object?> m) =>
        Module.from(moduleName, sanitizeName(moduleName), m),
  )..collectChildren(cache, stdlibPath: stdlibPath);

  Object? toEncodable(Object? o) {
    switch (o) {
      case Module():
      case ClassDefinition():
      case ClassInstance():
      case Function_():
      case Object_():
        final InspectEntry entry = o as InspectEntry;
        return <String, Object?>{
          "type": o.runtimeType.toString(),
          "value": jsonEncode(entry.value, toEncodable: toEncodable),
          "string": o.toString(),
        };
      case PythonIterable():
      case PythonIterator():
        final PythonObjectInterface object = o as PythonObjectInterface;
        return <String, Object?>{
          "type": o.runtimeType.toString(),
          "value": jsonEncode(object.reference, toEncodable: toEncodable),
        };
      case PythonObjectInterface():
        return <String, Object?>{
          "type": o.runtimeType.toString(),
          "value": jsonEncode(o.reference, toEncodable: toEncodable),
          "string": o.toString(),
        };
      default:
        return o.toString();
    }
  }

  final String json = jsonEncode(
    <String, Object?>{
      "_module": interface.debugDump(cache: cache),
      "_entries": cache.entries
          .whereNot(
            ((int, InspectEntry) e) => e.$2.type == InspectEntryType.primitive,
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
}

String emitInspection(InspectionCache cache, {bool primaryModuleOnly = true}) {
  final Module? primaryModule = cache.modules.firstOrNull;
  if (primaryModule == null) {
    primaryModuleOnly = false;
  }
  final StringBuffer buffer = StringBuffer("""
// ignore_for_file: camel_case_types, non_constant_identifier_names

""");
  if (primaryModule != null) {
    buffer.writeln("library ${primaryModule.sanitizedName};");
  }
  buffer.writeln("import \"package:python_ffi_dart/python_ffi_dart.dart\";");
  final Set<String> topLevelNames = <String>{};
  for (final ClassInstance typedef in cache.typedefs) {
    final String typedefName = typedef.sanitizedName;
    if (topLevelNames.contains(typedefName)) {
      continue;
    }
    topLevelNames.add(typedefName);
    typedef.emit(buffer);
  }
  for (final ClassDefinition classDefinition in cache.classDefinitions) {
    final String className = classDefinition.sanitizedName;
    if (topLevelNames.contains(className)) {
      continue;
    }
    topLevelNames.add(className);
    classDefinition.emit(buffer);
  }
  for (final Module module in cache.modules) {
    final String moduleName = module.sanitizedName;
    if (topLevelNames.contains(moduleName)) {
      continue;
    }
    topLevelNames.add(moduleName);
    module.emit(buffer);
  }
  return buffer.toString();
}
