// ignore_for_file: non_constant_identifier_names

import "dart:convert";

import "package:collection/collection.dart";
import "package:meta/meta.dart";
import "package:python_ffi_cpython_dart/python_ffi_cpython_dart.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";

extension MergeExtension<E> on Iterable<E> {
  Iterable<E> sortedMerge(
    Iterable<E> other,
    int Function(E a, E b) compareTo,
  ) sync* {
    final Iterator<E> iterator = this.iterator;
    final Iterator<E> otherIterator = other.iterator;
    bool hasNext = iterator.moveNext();
    bool otherHasNext = otherIterator.moveNext();
    while (hasNext && otherHasNext) {
      final E current = iterator.current;
      final E otherCurrent = otherIterator.current;
      final int comparison = compareTo(current, otherCurrent);
      if (comparison < 0) {
        yield current;
        hasNext = iterator.moveNext();
      } else if (comparison > 0) {
        yield otherCurrent;
        otherHasNext = otherIterator.moveNext();
      } else {
        yield current;
        hasNext = iterator.moveNext();
        otherHasNext = otherIterator.moveNext();
      }
    }
    while (hasNext) {
      yield iterator.current;
      hasNext = iterator.moveNext();
    }
    while (otherHasNext) {
      yield otherIterator.current;
      otherHasNext = otherIterator.moveNext();
    }
  }
}

enum InspectEntryType {
  module,
  classDefinition,
  class_,
  function,
  object,
  primitive;

  String get displayName {
    switch (this) {
      case InspectEntryType.module:
        return "module";
      case InspectEntryType.classDefinition:
        return "class definition";
      case InspectEntryType.class_:
        return "class instance";
      case InspectEntryType.function:
        return "function";
      case InspectEntryType.object:
        return "object";
      case InspectEntryType.primitive:
        return "primitive";
    }
  }
}

final class InspectionCache {
  InspectionCache._();

  static final Map<Object?, (int, InspectEntry)> _cache =
      <Object?, (int, InspectEntry)>{};

  static InspectionCache? _instance;

  static InspectionCache get instance => _instance ??= InspectionCache._();

  Object? _effectiveKey(Object? key) => switch (key) {
        PythonObjectInterface() => key.reference ?? key,
        _ => key,
      };

  int get _nextId => _cache.length;

  InspectEntry? operator [](Object? key) => _cache[_effectiveKey(key)]?.$2;

  void operator []=(Object? key, InspectEntry value) {
    // do not cache primitive objects
    if (value is PrimitiveInspect) {
      return;
    }
    final Object? effectiveKey = _effectiveKey(key);
    final int id = _cache[effectiveKey]?.$1 ?? _nextId;
    _cache[effectiveKey] = (id, value);
  }

  int? id(Object? key) => _cache[_effectiveKey(key)]?.$1;

  Iterable<(int, InspectEntry)> get entries => _cache.values;

  Iterable<T> _getOfType<T extends InspectEntry>(InspectEntryType type) =>
      entries
          .where(((int, InspectEntry) e) => e.$2.type == type)
          .map(((int, InspectEntry) e) => e.$2)
          .whereType();

  Iterable<ModuleInspect> get modules => _getOfType(InspectEntryType.module);

  Iterable<ClassDefinitionInspect> get classDefinitions =>
      _getOfType(InspectEntryType.classDefinition);

  Iterable<ClassInspect> get classes => _getOfType(InspectEntryType.class_);

  Iterable<ClassInspect> get typedefs => classes.where(types.isType);

  Iterable<FunctionInspect> get functions =>
      _getOfType(InspectEntryType.function);

  Iterable<ObjectInspect> get objects => _getOfType(InspectEntryType.object);
}

String _sanitizeName(String name) {
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
  if (dartKeywords.contains(name)) {
    return "\$$name";
  }
  return name;
}

sealed class InspectEntry {
  String get name;

  String get sanitizedName;

  Object? get value;

  InspectEntryType get type;

  int? get id;

  Iterable<(String, InspectEntry)> get children;

  void collectChildren();

  void emit(StringBuffer buffer);

  void emitDoc(StringBuffer buffer);

  void emitSource(StringBuffer buffer);

  Map<String, Object?> debugDump({bool expandChildren = true});
}

base mixin InspectMixin on PythonObjectInterface implements InspectEntry {
  final Map<String, InspectEntry> _children = <String, InspectEntry>{};

  void _setChild(String name, InspectEntry child) {
    _children[name] = child;
  }

  final inspect inspectModule = inspect.import();

  Iterable<(String, Object?)> get _members {
    final InspectMixin object = this;
    final Iterable<(String, Object?)> dynamicMembers =
        inspectModule.getmembers(object);
    final Iterable<(String, Object?)> staticMembers =
        inspectModule.getmembers_static(object);
    return dynamicMembers.sortedMerge(
      staticMembers,
      ((String, Object?) a, (String, Object?) b) => a.$1.compareTo(b.$1),
    );
  }

  String get sanitizedName => _sanitizeName(name);

  Object? get parentModule => inspectModule.getmodule(value);

  @override
  int? get id => InspectionCache.instance.id(value);

  Iterable<(String, InspectEntry)> get children => _children.entries
      .map((MapEntry<String, InspectEntry> e) => (e.key, e.value));

  static const Set<String> _explicitlyAllowedChildNames = <String>{"__init__"};

  @override
  void collectChildren() {
    final inspect inspectModule = inspect.import();
    final InspectEntry? selfCached = InspectionCache.instance[value];
    if (selfCached == null) {
      InspectionCache.instance[value] = this;
    }
    for (final (String name, Object? value) in _members) {
      if (name.startsWith("_") &&
          !_explicitlyAllowedChildNames.contains(name)) {
        continue;
      }
      try {
        if (inspectModule.isbuiltin(value)) {
          continue;
        }
      } on PythonExceptionInterface catch (_) {
        // ignore
      }
      try {
        if (inspectModule.ismethodwrapper(value)) {
          continue;
        }
      } on PythonExceptionInterface catch (_) {
        // ignore
      }
      final InspectEntry? cached = InspectionCache.instance[value];
      if (cached != null) {
        _setChild(name, cached);
        continue;
      }
      final InspectEntry child = switch (value) {
        PythonModuleInterface() when inspectModule.ismodule(value) =>
          ModuleInspect.from(name, value),
        PythonModuleInterface() =>
          throw Exception("'$name' is not a module: $value"),
        PythonClassDefinitionInterface() when inspectModule.isclass(value) =>
          ClassDefinitionInspect.from(name, value),
        PythonClassInterface() => ClassInspect.from(name, value),
        PythonFunctionInterface() when inspectModule.isfunction(value) =>
          FunctionInspect.from(name, value),
        PythonFunctionInterface() =>
          throw Exception("'$name' is not a function: $value"),
        PythonObjectInterface() => ObjectInspect.from(name, value),
        _ => PrimitiveInspect(name, value),
      } as InspectEntry;
      InspectionCache.instance[value] = child;
      _setChild(name, child);
      child.collectChildren();
    }
  }

  @override
  void emit(StringBuffer buffer) {
    throw UnimplementedError("$runtimeType.emit");
  }

  void emitDoc(StringBuffer buffer) {
    final String? doc = inspectModule.getdoc(value)?.trim();
    if (doc == null) {
      return;
    }
    if (doc.isEmpty) {
      return;
    }
    buffer.writeln("""
///
/// ### python docstring
///""");
    for (final String line in doc.split("\n")) {
      buffer.writeln("/// $line");
    }
  }

  void emitSource(StringBuffer buffer) {
    try {
      final String? source = inspectModule.getsource(value)?.trim();
      if (source == null) {
        return;
      }
      buffer.writeln("""
///
/// ### python source
/// ```py""");
      for (final String line in source.split("\n")) {
        buffer.writeln("/// $line");
      }
      buffer.writeln("""
/// ```""");
    } on PythonExceptionInterface catch (_) {
      // ignore
    }
  }

  @override
  Map<String, Object?> debugDump({bool expandChildren = true}) =>
      <String, Object?>{
        "_id": id,
        "name": name,
        "sanitizedName": sanitizedName,
        "value": value,
        "type": type.displayName,
        "parentModule": parentModule,
        "doc": inspectModule.getdoc(value),
        if (expandChildren)
          "children": Map<String, Map<String, Object?>>.fromEntries(
            children.map(
              ((String, InspectEntry) e) =>
                  MapEntry<String, Map<String, Object?>>(
                e.$1,
                e.$2.debugDump(expandChildren: id == null),
              ),
            ),
          ),
      };
}

final class ModuleInspect extends PythonModule
    with InspectMixin
    implements InspectEntry {
  ModuleInspect.from(this.name, super.moduleDelegate)
      : value = moduleDelegate,
        super.from();

  final String name;

  String get qualifiedName {
    try {
      return (value as dynamic).__name__ as String;
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      return name;
    }
  }

  final PythonModuleInterface value;

  @override
  InspectEntryType get type => InspectEntryType.module;

  bool _isMyChild(InspectEntry child) {
    switch (child) {
      case InspectMixin():
        final Object? parentModule = child.parentModule;
        if (parentModule is PythonModuleInterface) {
          return ReferenceEqualityWrapper(parentModule) ==
              ReferenceEqualityWrapper(value);
        }
        return false;
      case PrimitiveInspect():
    }
    return false;
  }

  @override
  void emit(StringBuffer buffer) {
    buffer.writeln("/// ## $name");
    emitDoc(buffer);
    emitSource(buffer);
    buffer.writeln("""
final class $sanitizedName extends PythonModule {
  $sanitizedName.from(super.pythonModule) : super.from();
  
  static $sanitizedName import() => PythonFfiDart.instance
      .importModule("$qualifiedName", $sanitizedName.from,);
""");
    final Set<String> memberNames = <String>{};
    for (final FunctionInspect child
        in _children.values.whereType<FunctionInspect>().where(_isMyChild)) {
      final String functionName = child.sanitizedName;
      if (memberNames.contains(functionName)) {
        continue;
      }
      if (functionName == name) {
        continue;
      }
      memberNames.add(functionName);
      child.emit(buffer);
    }
    for (final ModuleInspect child
        in _children.values.whereType<ModuleInspect>().where(_isMyChild)) {
      final String moduleName = child.sanitizedName;
      if (memberNames.contains(moduleName)) {
        continue;
      }
      memberNames.add(moduleName);
      buffer.writeln(
        "PythonModule get $moduleName => $moduleName.import();",
      );
    }
    for (final ClassInspect child
        in _children.values.whereType<ClassInspect>()) {
      if (types.isType(child)) {
        continue;
      }
      final String className = child.sanitizedName;
      if (memberNames.contains(className)) {
        continue;
      }
      memberNames.add(className);
      buffer.writeln("""
Object? get $className => getAttribute("${child.name}");

set $className(Object? $className)
  => setAttribute("${child.name}", $className);
""");
    }
    for (final ObjectInspect child
        in _children.values.whereType<ObjectInspect>().where(_isMyChild)) {
      final String objectName = child.sanitizedName;
      if (memberNames.contains(objectName)) {
        continue;
      }
      memberNames.add(objectName);
      buffer.writeln("""
Object? get $objectName => getAttribute("${child.name}");

set $objectName(Object? $objectName)
  => setAttribute("${child.name}", $objectName);
""");
    }
    for (final PrimitiveInspect child
        in _children.values.whereType<PrimitiveInspect>().where(_isMyChild)) {
      final String primitiveName = child.sanitizedName;
      if (memberNames.contains(primitiveName)) {
        continue;
      }
      memberNames.add(primitiveName);
      buffer.writeln("""
Object? get $primitiveName => getAttribute("${child.name}");

set $primitiveName(Object? $primitiveName)
  => setAttribute("${child.name}", $primitiveName);
""");
    }
    buffer.writeln("}");
  }
}

final class ClassDefinitionInspect extends PythonClassDefinition
    with InspectMixin
    implements InspectEntry {
  ClassDefinitionInspect.from(this.name, super.classDefinitionDelegate)
      : value = classDefinitionDelegate,
        super.from();

  final String name;

  final PythonClassDefinitionInterface value;

  @override
  InspectEntryType get type => InspectEntryType.classDefinition;

  @override
  void _setChild(String name, InspectEntry child) {
    if (child is FunctionInspect) {
      child = MethodInspect.from(child.name, child.value);
    }
    super._setChild(name, child);
  }

  MethodInspect? get __init__ {
    final InspectEntry? init = _children["__init__"];
    return init is MethodInspect ? init : null;
  }

  void _extractFieldsFromInit() {
    final MethodInspect? initMethod = __init__;
    if (initMethod == null) {
      return;
    }
    // TODO: walk the code object to determine dynamically added fields
    // maybe go via ast
    // get name of first positional argument
    final Parameter? selfParameter = initMethod.selfParameter;
    if (selfParameter == null) {
      return;
    }
    final String selfParameterName = selfParameter.name;
    final Object? codeObject = (initMethod.value as dynamic).__code__;
    if (codeObject == null) {
      return;
    }
    if (codeObject is! PythonObjectInterface) {
      return;
    }
    final List<String> names =
        codeObject.getAttribute<List<dynamic>>("co_names").cast();
    final List<String> varnames =
        codeObject.getAttribute<List<dynamic>>("co_varnames").cast();
    if (!varnames.contains(selfParameterName)) {
      print("Warning: $selfParameterName not in $varnames");
    }
    if (names.contains(selfParameterName)) {
      print("Warning: $selfParameterName in $names");
    }
    final String? sourceCode = inspectModule.getsource(initMethod.value);
    if (sourceCode == null) {
      return;
    }
    for (final String field in names) {
      final InspectEntry child = PrimitiveInspect(field, null);
      _setChild(field, child);
    }
  }

  @override
  void collectChildren() {
    super.collectChildren();
    _extractFieldsFromInit();
  }

  @override
  void emit(StringBuffer buffer) {
    final Object? parentModule = this.parentModule;
    final String moduleName = switch (parentModule) {
      PythonModuleInterface() => (parentModule as dynamic).__name__ as String,
      _ => throw Exception("parentModule is not a module: $parentModule"),
    };
    final MethodInspect? initMethod = __init__;
    buffer.writeln("/// ## $name");
    emitDoc(buffer);
    emitSource(buffer);
    buffer.writeln("""
final class $sanitizedName extends PythonClass {
  factory $sanitizedName(""");
    initMethod?.emitArguments(buffer);
    buffer.writeln("""
    ) =>
      PythonFfiDart.instance.importClass(
        "$moduleName",
        "$name",
        $sanitizedName.from,""");
    if (initMethod != null) {
      initMethod.emitCallArgs(buffer);
    } else {
      buffer.writeln("<Object?>[],");
    }
    initMethod?.emitCallKwargs(buffer);
    buffer.writeln("""
      );

  $sanitizedName.from(super.pythonClass) : super.from();
""");
    final Set<String> memberNames = <String>{"__init__"};
    for (final FunctionInspect child
        in _children.values.whereType<FunctionInspect>()) {
      final String functionName = child.sanitizedName;
      if (memberNames.contains(functionName)) {
        continue;
      }
      if (functionName == name) {
        continue;
      }
      memberNames.add(functionName);
      child.emit(buffer);
    }
    for (final ClassInspect child
        in _children.values.whereType<ClassInspect>()) {
      if (types.isType(child)) {
        continue;
      }
      final String className = child.sanitizedName;
      if (memberNames.contains(className)) {
        continue;
      }
      memberNames.add(className);
      buffer.writeln("""
Object? get $className => getAttribute("${child.name}");

set $className(Object? $className)
  => setAttribute("${child.name}", $className);
""");
    }
    for (final ObjectInspect child
        in _children.values.whereType<ObjectInspect>()) {
      final String objectName = child.sanitizedName;
      if (memberNames.contains(objectName)) {
        continue;
      }
      memberNames.add(objectName);
      buffer.writeln("""
Object? get $objectName => getAttribute("${child.name}");

set $objectName(Object? $objectName)
  => setAttribute("${child.name}", $objectName);
""");
    }
    for (final PrimitiveInspect child
        in _children.values.whereType<PrimitiveInspect>()) {
      final String primitiveName = child.sanitizedName;
      if (memberNames.contains(primitiveName)) {
        continue;
      }
      memberNames.add(primitiveName);
      buffer.writeln("""
Object? get $primitiveName => getAttribute("${child.name}");

set $primitiveName(Object? $primitiveName)
  => setAttribute("${child.name}", $primitiveName);
""");
    }
    buffer.writeln("}");
  }
}

final class ClassInspect extends PythonClass
    with InspectMixin
    implements InspectEntry {
  ClassInspect.from(this.name, super.classDelegate)
      : value = classDelegate,
        super.from();

  final String name;

  final PythonClassInterface value;

  @override
  InspectEntryType get type => InspectEntryType.class_;

  @override
  void emit(StringBuffer buffer) {
    buffer.writeln("/// ## $name");
    emitDoc(buffer);
    emitSource(buffer);
    buffer.writeln("typedef $sanitizedName = Object?;");
  }
}

final class FunctionInspect extends PythonFunction
    with InspectMixin
    implements InspectEntry {
  FunctionInspect.from(this.name, super.functionDelegate)
      : value = functionDelegate,
        super.from();

  final String name;

  final PythonFunctionInterface value;

  @override
  InspectEntryType get type => InspectEntryType.function;

  Signature get signature => inspectModule.signature(value);

  Iterable<Parameter> get parameters => signature.parameters.values;

  Iterable<Parameter> _parametersOfKind(ParameterKind kind) =>
      parameters.where((Parameter parameter) => parameter.kind == kind);

  bool _hasKeywordParameters() =>
      _parametersOfKind(ParameterKind.var_positional).isNotEmpty ||
      _parametersOfKind(ParameterKind.positional_or_keyword).isNotEmpty ||
      _parametersOfKind(ParameterKind.keyword_only).isNotEmpty ||
      _parametersOfKind(ParameterKind.var_keyword).isNotEmpty;

  void emitArguments(StringBuffer buffer) {
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.positional_only)) {
      buffer.writeln("Object? ${parameter.sanitizedName},");
    }
    if (_hasKeywordParameters()) {
      buffer.write("{");
      for (final Parameter parameter
          in _parametersOfKind(ParameterKind.var_positional)) {
        buffer.writeln(
          "List<Object?> ${parameter.sanitizedName} ${parameter.defaultString},",
        );
      }
      for (final Parameter parameter
          in _parametersOfKind(ParameterKind.positional_or_keyword)) {
        buffer.writeln(
          "${parameter.requiredString} Object? ${parameter.sanitizedName} ${parameter.defaultString},",
        );
      }
      for (final Parameter parameter
          in _parametersOfKind(ParameterKind.keyword_only)) {
        buffer.writeln(
          "${parameter.requiredString} Object? ${parameter.sanitizedName} ${parameter.defaultString},",
        );
      }
      for (final Parameter parameter
          in _parametersOfKind(ParameterKind.var_keyword)) {
        buffer.writeln(
          "Map<String, Object?> ${parameter.sanitizedName} ${parameter.defaultString},",
        );
      }
      buffer.write("}");
    }
  }

  void emitCallArgs(StringBuffer buffer) {
    buffer.writeln("<Object?>[");
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.positional_only)) {
      buffer.writeln("${parameter.sanitizedName},");
    }
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.positional_or_keyword)) {
      buffer.writeln("${parameter.sanitizedName},");
    }
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.var_positional)) {
      buffer.writeln("...${parameter.sanitizedName},");
    }
    buffer.writeln("],");
  }

  void emitCallKwargs(StringBuffer buffer) {
    buffer.writeln("<String, Object?>{");
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.keyword_only)) {
      buffer.writeln("\"${parameter.name}\": ${parameter.sanitizedName},");
    }
    for (final Parameter parameter
        in _parametersOfKind(ParameterKind.var_keyword)) {
      buffer.writeln("...${parameter.sanitizedName},");
    }
    buffer.writeln("},");
  }

  void emitCall(StringBuffer buffer) {
    emitCallArgs(buffer);
    buffer.write("kwargs: ");
    emitCallKwargs(buffer);
  }

  @override
  void emit(StringBuffer buffer) {
    buffer.writeln("/// ## $name");
    emitDoc(buffer);
    emitSource(buffer);
    buffer.writeln("Object? $sanitizedName(");
    emitArguments(buffer);
    buffer.writeln(") => getFunction(\"$name\").call(");
    emitCall(buffer);
    buffer.writeln(");");
  }

  @override
  debugDump({bool expandChildren = true}) => <String, Object?>{
        ...super.debugDump(expandChildren: expandChildren),
        "signature": signature.debugDump(),
      };
}

final class MethodInspect extends FunctionInspect {
  MethodInspect.from(super.name, super.functionDelegate) : super.from();

  @override
  Iterable<Parameter> get parameters sync* {
    bool didSkipSelf = false;
    for (final Parameter parameter in super.parameters) {
      if (!didSkipSelf) {
        if (parameter.kind == ParameterKind.positional_only ||
            parameter.kind == ParameterKind.positional_or_keyword) {
          didSkipSelf = true;
          continue;
        }
      }
      yield parameter;
    }
  }

  Parameter? get selfParameter => super.parameters.firstWhereOrNull(
        (Parameter element) =>
            element.kind == ParameterKind.positional_only ||
            element.kind == ParameterKind.positional_or_keyword,
      );
}

final class ObjectInspect extends PythonObject
    with InspectMixin
    implements InspectEntry {
  ObjectInspect.from(this.name, super.objectDelegate)
      : value = objectDelegate,
        super.from();

  final String name;

  final PythonObjectInterface value;

  @override
  InspectEntryType get type => InspectEntryType.object;

  @override
  void emit(StringBuffer buffer) {
    buffer.writeln("""
    Object? get $name => getAttribute("$name");
    set $name(Object? $name) => setAttribute("$name", $name);
""");
  }
}

final class PrimitiveInspect implements InspectEntry {
  const PrimitiveInspect(this.name, this.value);

  final String name;

  String get sanitizedName => _sanitizeName(name);

  final Object? value;

  @override
  InspectEntryType get type => InspectEntryType.primitive;

  @override
  int? get id => InspectionCache.instance.id(value);

  @override
  Iterable<(String, InspectEntry)> get children =>
      const <(String, InspectEntry)>[];

  @override
  void collectChildren() {}

  @override
  void emit(StringBuffer buffer) {
    throw UnimplementedError("$runtimeType.emit");
  }

  @override
  void emitDoc(StringBuffer buffer) {}

  @override
  void emitSource(StringBuffer buffer) {}

  @override
  Map<String, Object?> debugDump({bool expandChildren = true}) =>
      <String, Object?>{
        "name": name,
        "sanitizedName": sanitizedName,
        "value": value,
        "type": type.displayName,
      };
}

Future<String> doInspection(
  PythonModuleDefinition moduleDefinition, {
  required String appType,
}) async {
  print(
    "Generating Dart interface for ${moduleDefinition.name} via inspect...",
  );
  await PythonFfiDart.instance.prepareModule(moduleDefinition);
  final ModuleInspect interface = PythonFfiDart.instance.importModule(
    moduleDefinition.name,
    (PythonModuleInterface<PythonFfiDelegate<Object?>, Object?> m) =>
        ModuleInspect.from(moduleDefinition.name, m),
  )..collectChildren();

  Object? toEncodable(Object? o) {
    switch (o) {
      case ModuleInspect():
      case ClassDefinitionInspect():
      case ClassInspect():
      case FunctionInspect():
      case ObjectInspect():
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
      "_module": interface.debugDump(),
      "_entries": InspectionCache.instance.entries
          .whereNot(
            ((int, InspectEntry) e) => e.$2.type == InspectEntryType.primitive,
          )
          .map(
            ((int, InspectEntry) e) => <String, Object?>{
              "id": e.$1,
              "entry": e.$2.debugDump(),
            },
          )
          .toList(),
    },
    toEncodable: toEncodable,
  );
  return json;
}

final class types extends PythonModule {
  types.from(super.moduleDelegate) : super.from();

  static types import() => PythonFfiDart.instance.importModule(
        "types",
        types.from,
      );

  static bool isType(ClassInspect class_) {
    final types typesModule = types.import();
    final ReferenceEqualityWrapper typesModuleWrapper =
        ReferenceEqualityWrapper(typesModule);
    final Object? classParentModule = class_.parentModule;
    if (classParentModule is! PythonModuleInterface) {
      return false;
    }
    final ReferenceEqualityWrapper classParentModuleWrapper =
        ReferenceEqualityWrapper(classParentModule);
    if (classParentModuleWrapper != typesModuleWrapper) {
      return false;
    }
    // TODO: make this more robust
    return true;
  }
}

String emitInspection({bool primaryModuleOnly = true}) {
  final InspectionCache cache = InspectionCache.instance;
  final ModuleInspect? primaryModule = cache.modules.firstOrNull;
  if (primaryModule == null) {
    primaryModuleOnly = false;
  }
  final StringBuffer buffer = StringBuffer("""
// ignore_for_file: camel_case_types, non_constant_identifier_names

import "package:python_ffi_dart/python_ffi_dart.dart";
""");
  final Set<String> topLevelNames = <String>{};
  for (final ClassInspect typedef in cache.typedefs) {
    final String typedefName = typedef.sanitizedName;
    if (topLevelNames.contains(typedefName)) {
      continue;
    }
    topLevelNames.add(typedefName);
    typedef.emit(buffer);
  }
  for (final ClassDefinitionInspect classDefinition in cache.classDefinitions) {
    final String className = classDefinition.sanitizedName;
    if (topLevelNames.contains(className)) {
      continue;
    }
    topLevelNames.add(className);
    classDefinition.emit(buffer);
  }
  for (final ModuleInspect module in cache.modules) {
    final String moduleName = module.sanitizedName;
    if (topLevelNames.contains(moduleName)) {
      continue;
    }
    topLevelNames.add(moduleName);
    module.emit(buffer);
  }
  return buffer.toString();
}

final class inspect extends PythonModule {
  inspect.from(super.moduleDelegate) : super.from();

  static inspect import() => PythonFfiDart.instance.importModule(
        "inspect",
        inspect.from,
      );

  /// Return all the members of an object in a list of `(name, value)` pairs
  /// sorted by name. If the optional [predicate] argument — which will be
  /// called with the value object of each member — is supplied, only members
  /// for which the predicate returns a true value are included.
  ///
  /// **Note:** [getmembers] will only return class attributes defined in the
  /// metaclass when the argument is a class and those attributes have been
  /// listed in the metaclass’ custom `__dir__()`.
  Iterable<(String, Object?)> getmembers(
    Object? object, [
    bool Function(Object? value)? predicate,
  ]) =>
      getFunction("getmembers")
          .call<List<dynamic>>(<Object?>[
            object,
            if (predicate != null) predicate,
          ])
          .whereType<List<Object?>>()
          .where((List<Object?> element) => element.length == 2)
          .map((List<Object?> e) => (e.first, e.last))
          .whereType();

  /// Return all the members of an object in a list of `(name, value)` pairs
  /// sorted by name without triggering dynamic lookup via the descriptor
  /// protocol, __getattr__ or __getattribute__. Optionally, only return members
  /// that satisfy a given [predicate].
  ///
  /// **Note:** [getmembers_static] may not be able to retrieve all members that
  /// [getmembers] can fetch (like dynamically created attributes) and may find
  /// members that [getmembers] can’t (like descriptors that raise
  /// AttributeError). It can also return descriptor objects instead of instance
  /// members in some cases.
  Iterable<(String, Object?)> getmembers_static(
    Object? object, [
    bool Function(Object? value)? predicate,
  ]) =>
      getFunction("getmembers_static")
          .call<List<dynamic>>(<Object?>[
            object,
            if (predicate != null) predicate,
          ])
          .whereType<List<Object?>>()
          .where((List<Object?> element) => element.length == 2)
          .map((List<Object?> e) => (e.first, e.last))
          .whereType();

  /// Return `true` if the object is a module.
  bool ismodule(Object? object) =>
      getFunction("ismodule").call(<Object?>[object]);

  /// Return `true` if the object is a class, whether built-in or created in Python code.
  bool isclass(Object? object) =>
      getFunction("isclass").call(<Object?>[object]);

  /// Return `true` if the object is a bound method written in Python.
  bool ismethod(Object? object) =>
      getFunction("ismethod").call(<Object?>[object]);

  /// Return `true` if the object is a Python function, which includes functions
  /// created by a lambda expression.
  bool isfunction(Object? object) =>
      getFunction("isfunction").call(<Object?>[object]);

  /// Return `true` if the object is a built-in function or a bound built-in
  /// method.
  bool isbuiltin(Object? object) =>
      getFunction("isbuiltin").call(<Object?>[object]);

  /// Return `true` if the type of object is a
  /// [MethodWrapperType](https://docs.python.org/3/library/types.html#types.MethodWrapperType).
  ///
  /// These are instances of
  /// [MethodWrapperType](https://docs.python.org/3/library/types.html#types.MethodWrapperType),
  /// such as [`__str__()`](https://docs.python.org/3/reference/datamodel.html#object.__str__),
  /// [`__eq__()`](https://docs.python.org/3/reference/datamodel.html#object.__eq__)
  /// and
  /// [`__repr__()`](https://docs.python.org/3/reference/datamodel.html#object.__repr__).
  bool ismethodwrapper(Object? object) =>
      getFunction("ismethodwrapper").call(<Object?>[object]);

  /// Get the documentation string for an object, cleaned up with [cleandoc].
  /// If the documentation string for an object is not provided and the object
  /// is a class, a method, a property or a descriptor, retrieve the
  /// documentation string from the inheritance hierarchy. Return `null` if the
  /// documentation string is invalid or missing.
  String? getdoc(Object? object) =>
      getFunction("getdoc").call(<Object?>[object]);

  /// Try to guess which module an object was defined in. Return `null` if the
  /// module cannot be determined.
  PythonModuleInterface? getmodule(Object? object) =>
      getFunction("getmodule").call(<Object?>[object]);

  /// Return the text of the source code for an object. The argument may be a
  /// module, class, method, function, traceback, frame, or code object. The
  /// source code is returned as a single string. An OSError is raised if the
  /// source code cannot be retrieved. A TypeError is raised if the object is a
  /// built-in module, class, or function.
  String? getsource(Object? object) {
    try {
      return getFunction("getsource").call(<Object?>[object]);
    } on PythonExceptionInterface catch (e) {
      if (e.type == "TypeError") {
        print(
          "Cannot get source for built-in module, class, or function: $object",
        );
        return null;
      }
      if (e.type == "OSError") {
        print("Cannot get source for $object: $e");
        return null;
      }
      rethrow;
    }
  }

  /// Clean up indentation from docstrings that are indented to line up with
  /// blocks of code.
  ///
  /// All leading whitespace is removed from the first line. Any leading
  /// whitespace that can be uniformly removed from the second line onwards is
  /// removed. Empty lines at the beginning and end are subsequently removed.
  /// Also, all tabs are expanded to spaces.
  String cleandoc(String doc) => getFunction("cleandoc").call(<Object?>[doc]);

  /// Return a [Signature] object for the given [callable] :
  ///
  /// ```py
  /// >>> from inspect import signature
  /// >>> def foo(a, *, b:int, **kwargs):
  /// ...     pass
  ///
  /// >>> sig = signature(foo)
  ///
  /// >>> str(sig)
  /// '(a, *, b:int, **kwargs)'
  ///
  /// >>> str(sig.parameters['b'])
  /// 'b:int'
  ///
  /// >>> sig.parameters['b'].annotation
  /// <class 'int'>
  /// ```
  /// Accepts a wide range of Python callables, from plain functions and classes
  /// to
  /// [`functools.partial()`](https://docs.python.org/3/library/functools.html#functools.partial)
  /// objects.
  ///
  /// Reference: https://docs.python.org/3/library/inspect.html#inspect.signature
  Signature signature(
    PythonFunctionInterface callable, {
    bool follow_wrapped = true,
    Object? globals,
    Object? locals,
    bool eval_str = false,
  }) =>
      Signature.from(
        getFunction("signature").call(
          <Object?>[callable],
          kwargs: <String, Object?>{
            "follow_wrapped": follow_wrapped,
            "globals": globals,
            "locals": locals,
            "eval_str": eval_str,
          },
        ),
      );
}

@immutable
final class ReferenceEqualityWrapper extends PythonObjectInterface {
  ReferenceEqualityWrapper(this._source)
      : super(
          _source.platform,
          _source.reference,
          initializer: _source.initializer,
          finalizer: _source.finalizer,
        );

  final PythonObjectInterface _source;

  @override
  bool operator ==(Object? other) {
    if (other is! ReferenceEqualityWrapper) {
      return false;
    }
    return _source.reference == other._source.reference;
  }

  @override
  int get hashCode => _source.reference.hashCode;

  @override
  String toString() => _source.toString();
}

final class _SignatureClassDefinition extends PythonClassDefinition {
  _SignatureClassDefinition.from(super.classDefinitionDelegate) : super.from();
}

/// The [Signature] object represents the call signature of a callable object
/// and its return annotation. To retrieve a [Signature] object, use the
/// [inspect.signature] function.
///
/// Reference: https://docs.python.org/3/library/inspect.html#inspect.Signature
final class Signature extends PythonClass {
  Signature.from(super.classDelegate) : super.from();

  /// A special class-level marker to specify absence of a return annotation.
  static ReferenceEqualityWrapper get empty {
    final inspect inspectModule = inspect.import();
    final _SignatureClassDefinition signatureClass =
        _SignatureClassDefinition.from(inspectModule.getAttribute("Signature"));
    return ReferenceEqualityWrapper(signatureClass.getAttribute("empty"));
  }

  Iterable<String> get _parameterNames =>
      getAttribute<Iterable<Object?>>("parameters").whereType();

  /// An ordered mapping of parameters’ names to the corresponding [Parameter]
  /// objects. Parameters appear in strict definition order, including
  /// keyword-only parameters.
  ///
  /// *Changed in version 3.7:* Python only explicitly guaranteed that it
  /// preserved the declaration order of keyword-only parameters as of version
  /// 3.7, although in practice this order had always been preserved in
  /// Python 3.
  UnmodifiableMapView<String, Parameter> get parameters {
    final PythonObjectInterface<PythonFfiCPythonBase, Pointer<PyObject>>
        parameters = getAttributeRaw("parameters");
    final PythonFunctionInterface<PythonFfiCPythonBase, Pointer> itemGetter =
        parameters.getFunction("__getitem__");
    return UnmodifiableMapView<String, Parameter>(
      Map<String, Parameter>.fromEntries(
        _parameterNames.map(
          (String name) => MapEntry<String, Parameter>(
            name,
            Parameter.from(itemGetter(<Object?>[name])),
          ),
        ),
      ),
    );
  }

  /// The “return” annotation for the callable. If the callable has no “return”
  /// annotation, this attribute is set to [Signature.empty].
  Object? get return_annotation {
    final Object? result = getAttribute("return_annotation");
    if (result is PythonObjectInterface) {
      final ReferenceEqualityWrapper empty = Signature.empty;
      if (ReferenceEqualityWrapper(result) == empty) {
        return empty;
      }
    }
    return result;
  }

  Map<String, Object?> debugDump() => <String, Object?>{
        "parameters": parameters.map(
          (String key, Parameter value) =>
              MapEntry<String, Map<String, Object?>>(key, value.debugDump()),
        ),
        "return_annotation": return_annotation,
      };
}

final class _ParameterClassDefinition extends PythonClassDefinition {
  _ParameterClassDefinition.from(super.classDefinitionDelegate) : super.from();
}

enum ParameterKind {
  positional_only,
  positional_or_keyword,
  var_positional,
  keyword_only,
  var_keyword,
}

/// Reference: https://docs.python.org/3/library/inspect.html#inspect.Parameter
final class Parameter extends PythonClass {
  Parameter.from(super.classDelegate) : super.from();

  /// A special class-level marker to specify absence of default values and
  /// annotations.
  static ReferenceEqualityWrapper get empty {
    final inspect inspectModule = inspect.import();
    final _ParameterClassDefinition parameterClass =
        _ParameterClassDefinition.from(inspectModule.getAttribute("Parameter"));
    return ReferenceEqualityWrapper(parameterClass.getAttribute("empty"));
  }

  /// Value must be supplied as a positional argument. Positional only
  /// parameters are those which appear before a / entry (if present) in a
  /// Python function definition.
  static Object? get POSITIONAL_ONLY {
    final inspect inspectModule = inspect.import();
    final _ParameterClassDefinition parameterClass =
        _ParameterClassDefinition.from(inspectModule.getAttribute("Parameter"));
    return parameterClass.getAttribute("POSITIONAL_ONLY");
  }

  /// Value may be supplied as either a keyword or positional argument (this is
  /// the standard binding behaviour for functions implemented in Python.)
  static Object? get POSITIONAL_OR_KEYWORD {
    final inspect inspectModule = inspect.import();
    final _ParameterClassDefinition parameterClass =
        _ParameterClassDefinition.from(inspectModule.getAttribute("Parameter"));
    return parameterClass.getAttribute("POSITIONAL_OR_KEYWORD");
  }

  /// A tuple of positional arguments that aren’t bound to any other parameter.
  /// This corresponds to a *args parameter in a Python function definition.
  static Object? get VAR_POSITIONAL {
    final inspect inspectModule = inspect.import();
    final _ParameterClassDefinition parameterClass =
        _ParameterClassDefinition.from(inspectModule.getAttribute("Parameter"));
    return parameterClass.getAttribute("VAR_POSITIONAL");
  }

  /// Value must be supplied as a keyword argument. Keyword only parameters are
  /// those which appear after a * or *args entry in a Python function
  /// definition.
  static Object? get KEYWORD_ONLY {
    final inspect inspectModule = inspect.import();
    final _ParameterClassDefinition parameterClass =
        _ParameterClassDefinition.from(inspectModule.getAttribute("Parameter"));
    return parameterClass.getAttribute("KEYWORD_ONLY");
  }

  /// A dict of keyword arguments that aren’t bound to any other parameter. This
  /// corresponds to a **kwargs parameter in a Python function definition.
  static Object? get VAR_KEYWORD {
    final inspect inspectModule = inspect.import();
    final _ParameterClassDefinition parameterClass =
        _ParameterClassDefinition.from(inspectModule.getAttribute("Parameter"));
    return parameterClass.getAttribute("VAR_KEYWORD");
  }

  /// The name of the parameter as a string. The name must be a valid Python
  /// identifier.
  String get name => getAttribute("name");

  String get sanitizedName {
    final String name = _sanitizeName(this.name);
    if (name.startsWith("_")) {
      return "\$$name";
    }
    return name;
  }

  Object? _handleEmpty(Object? value) {
    if (value is PythonObjectInterface) {
      final ReferenceEqualityWrapper empty = Parameter.empty;
      if (ReferenceEqualityWrapper(value) == empty) {
        return empty;
      }
    }
    return value;
  }

  /// The default value for the parameter. If the parameter has no default
  /// value, this attribute is set to [Parameter.empty].
  Object? get default_ => _handleEmpty(getAttribute("default"));

  /// The annotation for the parameter. If the parameter has no annotation,
  /// this attribute is set to [Parameter.empty].
  Object? get annotation => _handleEmpty(getAttribute("annotation"));

  /// Describes how argument values are bound to the parameter. The possible
  /// values are accessible via Parameter (like Parameter.KEYWORD_ONLY), and
  /// support comparison and ordering, in the following order:
  ParameterKind get kind {
    final Object? kind = getAttribute("kind");
    if (kind == POSITIONAL_ONLY) {
      return ParameterKind.positional_only;
    }
    if (kind == POSITIONAL_OR_KEYWORD) {
      return ParameterKind.positional_or_keyword;
    }
    if (kind == VAR_POSITIONAL) {
      return ParameterKind.var_positional;
    }
    if (kind == KEYWORD_ONLY) {
      return ParameterKind.keyword_only;
    }
    if (kind == VAR_KEYWORD) {
      return ParameterKind.var_keyword;
    }
    throw UnimplementedError();
  }

  String get requiredString {
    switch (kind) {
      case ParameterKind.positional_only:
      case ParameterKind.var_positional:
      case ParameterKind.var_keyword:
        return name;
      case ParameterKind.positional_or_keyword:
      case ParameterKind.keyword_only:
        return default_ == empty ? "required" : "";
    }
  }

  String _encode(Object? source) => switch (source) {
        List() when source.isEmpty => "const []",
        List() => "const ${source.map(_encode).toList()}",
        Map() when source.isEmpty => "const {}",
        Map() => "const ${source.map(
            (Object? key, Object? value) =>
                MapEntry<Object?, Object?>(_encode(key), _encode(value)),
          )}",
        Set() when source.isEmpty => "const {}",
        Set() => "const ${source.map(_encode).toSet()}",
        String() => jsonEncode(source),
        PythonObjectInterface() => "null",
        _ => source.toString(),
      };

  String get defaultString {
    switch (kind) {
      case ParameterKind.positional_only:
        return "";
      case ParameterKind.var_positional:
        return "= const <Object?>[]";
      case ParameterKind.var_keyword:
        return "= const <String, Object?>{}";
      case ParameterKind.positional_or_keyword when default_ == empty:
      case ParameterKind.keyword_only when default_ == empty:
        return "";
      case ParameterKind.positional_or_keyword:
      case ParameterKind.keyword_only:
        return "= ${_encode(default_)}";
    }
  }

  Map<String, Object?> debugDump() => <String, Object?>{
        "name": name,
        "default": default_,
        "annotation": annotation,
        "kind": kind.name,
      };
}
