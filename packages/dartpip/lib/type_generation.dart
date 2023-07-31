part of dartpip;

final class BuiltinsModule extends PythonModule {
  BuiltinsModule.from(super.moduleDelegate) : super.from();

  static BuiltinsModule import() =>
      PythonFfiDart.instance.importModule("builtins", BuiltinsModule.from);

  Object? dir(Object? object) => getFunction("dir").call(<Object?>[object]);

  Object? type(Object? object) => getFunction("type").call(<Object?>[object]);
}

class TypeDefinitionsCache {
  final HashMap<Object?, TypeDefinition> _cache =
      HashMap<Object?, TypeDefinition>(equals: _equals, hashCode: _hashCode);

  UnmodifiableListView<TypeDefinition> get values =>
      UnmodifiableListView<TypeDefinition>(_cache.values);

  static bool _equals(Object? a, Object? b) {
    if (a == null) {
      return b == null;
    }
    if (a is PythonObjectInterface && b is PythonObjectInterface) {
      return a.reference == b.reference;
    }
    // do not cache values that are not PythonObjectInterface
    return false;
  }

  static int _hashCode(Object? a) {
    if (a == null) {
      return null.hashCode;
    }
    if (a is PythonObjectInterface) {
      final int hashCode = a.reference.hashCode;
      return hashCode;
    }
    return a.hashCode;
  }

  void add(TypeDefinition value) => _cache[value.object] = value;

  bool contains(Object? key) => _cache.containsKey(key);

  TypeDefinition? get(Object? key) => _cache[key];

  List<Map<String, dynamic>> get dump {
    final List<TypeDefinition> values = List<TypeDefinition>.from(_cache.values)
      ..sort(
        (TypeDefinition a, TypeDefinition b) =>
            b.attributes.length.compareTo(a.attributes.length),
      );
    return values.map((TypeDefinition e) => e.shallowDump).toList();
  }
}

sealed class _TypeInfo {
  _TypeInfo._(this.name, this.type);

  factory _TypeInfo.from(String name, Object? object) {
    if (object == null) {
      return ValueTypeInfo("null", null.runtimeType, null);
    }
    if (object is PythonObjectInterface) {
      final Object? reference = object.reference;
      if (reference is Pointer<PyObject>) {
        return PythonObjectTypeInfo._(
          object.runtimeType.toString(),
          object.runtimeType,
          reference.address,
          object,
        );
      }
      throw ArgumentError.value(
        object,
        "object",
        "PythonObjectInterface must have a reference to a PyObject, but reference has type ${reference.runtimeType}",
      );
    }
    return ValueTypeInfo(
      name,
      object.runtimeType,
      object is PythonObjectInterface ? object.reference : object,
    );
  }

  final String name;
  final Type type;

  Map<String, dynamic> get toJson;
}

final class PythonObjectTypeInfo extends _TypeInfo {
  PythonObjectTypeInfo._(String name, Type type, this.reference, this.delegate)
      : super._(name, type);

  static PythonObjectTypeInfo tryAccept(
      String name, Type type, PythonObjectInterface object) {
    final Object? reference = object.reference;
    if (reference is Pointer<PyObject>) {
      return PythonObjectTypeInfo._(name, type, reference.address, object);
    }
    throw ArgumentError.value(
      object,
      "object",
      "PythonObjectInterface must have a reference to a PyObject, but reference has type ${reference.runtimeType}",
    );
  }

  final int reference;
  final PythonObjectInterface delegate;

  String? get pythonName {
    final String __name__ = "__name__";
    if (delegate.hasAttribute(__name__)) {
      return delegate.getAttribute(__name__).toString();
    }
    return null;
  }

  @override
  String toString() => "$name<$type>@0x${reference.toRadixString(16)}";

  Map<String, dynamic> get toJson => <String, dynamic>{
        "name": name,
        "type": type.toString(),
        "address": "0x${reference.toRadixString(16)}",
      };
}

final class ValueTypeInfo extends _TypeInfo {
  ValueTypeInfo(String name, Type type, this.value) : super._(name, type);

  final Object? value;

  @override
  String toString() => "$name: $value";

  Map<String, dynamic> get toJson {
    final Object? value = switch (this.value) {
      List() || Map() => this.value.runtimeType.toString(),
      _ => this.value,
    };
    return <String, dynamic>{
      "name": name,
      "type": type.toString(),
      "value": value,
    };
  }
}

class _PythonType {
  _PythonType({
    required this.name,
    required this.type,
  });

  final String name;
  final Type type;

  Map<String, String> get toJson => <String, String>{
        "name": name,
        "type": type.toString(),
      };

  @override
  String toString() {
    if (type == PythonClassDefinition) {
      return "Object?";
    }
    if (type == PythonClass) {
      return "Object?";
      return "PythonType<'$name'>";
    }
    return type.toString();
  }
}

class TypeDefinition {
  TypeDefinition(
    this.object, {
    _TypeInfo? type,
    String? name,
    required this.annotations,
  }) : type = type ??
            _TypeInfo.from(name ?? object.runtimeType.toString(), object);

  final Object? object;
  final _TypeInfo type;
  final Map<String, TypeDefinition> attributes = <String, TypeDefinition>{};
  final Map<String, _PythonType> annotations;

  Map<String, Map<String, String>> get annotationsToJson => annotations.map(
        (String key, _PythonType value) =>
            MapEntry<String, Map<String, String>>(key, value.toJson),
      );

  void add(String name, TypeDefinition child) {
    attributes[name] = child;
  }

  Map<String, dynamic> get shallowDump => <String, dynamic>{
        "info": type.toJson,
        "attributes": attributes.map(
          (String key, TypeDefinition value) =>
              MapEntry<String, dynamic>(key, value.type.toJson),
        ),
        "annotations": annotationsToJson,
      };

  Map<String, dynamic> get deepDump => <String, dynamic>{
        "info": type.toJson,
        "attributes": attributes.map(
          (String key, TypeDefinition value) =>
              MapEntry<String, dynamic>(key, value.deepDump),
        ),
        "annotations": annotationsToJson,
      };

  String get export {
    final _TypeInfo type = this.type;
    switch (type) {
      case PythonObjectTypeInfo():
        switch (object) {
          case PythonModuleInterface():
          case PythonModule():
            final Iterable<String> fields = attributes.entries.map(
                (MapEntry<String, TypeDefinition> e) =>
                    "${e.key}: ${e.value.export}");
            return "PythonModule<${type.pythonName ?? type.name}>(${fields.join(", ")})";
          case PythonClassDefinitionInterface():
          case PythonClassDefinition():
            final Iterable<String> fields = attributes.entries.map(
                (MapEntry<String, TypeDefinition> e) =>
                    "${e.key}: ${e.value.export}");
            return "PythonClassDefinition<${type.name}>(${fields.join(", ")})";
          case PythonClassInterface():
          case PythonClass():
            return "PythonClass<${type.name}>";
          case PythonFunctionInterface():
          case PythonFunction():
            final Object? returnType = annotations["return"] ?? "dynamic";
            final Iterable<String> args = annotations.entries
                .whereNot(
                  (MapEntry<String, dynamic> e) => e.key == "return",
                )
                .map(
                  (MapEntry<String, dynamic> e) => "${e.key}: ${e.value}",
                );
            return "$returnType PythonFunction(${args.join(", ")})";
          case PythonObjectInterface():
            return "PythonObject";
        }
        return "(default) ${type.type}";
      case ValueTypeInfo():
        return type.value.toString();
    }
  }

  String codeify({required String appType, String? moduleName}) {
    final _TypeInfo type = this.type;
    switch (type) {
      case PythonObjectTypeInfo():
        switch (object) {
          case PythonModuleInterface():
          case PythonModule():
            final StringBuffer buffer = StringBuffer();
            buffer.writeln("```dart");
            final String importedPackage =
                "python_ffi${appType == _kAppTypeConsole ? "_dart" : ""}";
            buffer.writeln(
              "import \"package:$importedPackage/$importedPackage.dart\";",
            );
            final Iterable<String> fields = attributes.entries.map(
              (MapEntry<String, TypeDefinition> e) => e.value.codeify(
                appType: appType,
                moduleName: type.pythonName ?? type.name,
              ),
            );
            bool isTypedefField(String field) => field.startsWith("typedef ");
            bool isClassDefField(String field) => field.startsWith(
                  RegExp(
                    r"/// [^\n]+\nfinal class [^\n]+ extends PythonClass {\n.*}",
                    dotAll: true,
                  ),
                );
            for (final String field in fields.where(isTypedefField)) {
              buffer.writeln(field);
            }
            for (final String field in fields.where(isClassDefField)) {
              buffer.writeln(field);
            }
            buffer.writeln();
            buffer.writeln("/// $export");
            buffer.writeln(
              "final class ${type.pythonName ?? type.name} extends PythonModule {",
            );
            buffer.writeln(
              "${type.pythonName ?? type.name}.from(super.pythonModule) : super.from();",
            );
            for (final String field
                in fields.whereNot(isTypedefField).whereNot(isClassDefField)) {
              buffer.writeln("  $field");
            }
            buffer.writeln("}");
            buffer.writeln("```");
            return buffer.toString();
          case PythonClassDefinitionInterface():
          case PythonClassDefinition():
            final String className = type.pythonName ?? type.name;
            final StringBuffer buffer = StringBuffer();
            buffer.writeln("/// $export");
            buffer.writeln(
              "final class $className extends PythonClass {",
            );
            final TypeDefinition? constructor = attributes["__init__"];
            if (constructor != null) {
              buffer.writeln("  factory $className({");
              final Iterable<(String, String)> args =
                  constructor.annotations.entries
                      .whereNot(
                (MapEntry<String, _PythonType> e) => e.key == "return",
              )
                      .map(
                (MapEntry<String, _PythonType> e) {
                  final String name = e.key;
                  final TypeDefinition? defaultValue = attributes[name];
                  final String? defaultValueString =
                      switch (defaultValue?.type) {
                    ValueTypeInfo(value: final Object? value) =>
                      value.toString(),
                    _ => null,
                  };
                  return (
                    name,
                    "Object? $name${defaultValueString != null ? " = $defaultValueString" : ""}"
                  );
                },
              );
              buffer
                ..write(args.map(((String, String) e) => e.$2).join(", "))
                ..writeln(
                  "}) => PythonFfi${appType == _kAppTypeConsole ? "Dart" : ""}.instance.importClass(\"${moduleName ?? "<module>"}\", \"$className\", $className.from, <Object?>[${args.map(
                        ((String, String) e) => e.$1,
                      ).join(", ")}]);",
                )
                ..writeln(
                  "  $className.from(super.pythonClass) : super.from();",
                );
            }
            final Iterable<String> fields = attributes.entries
                .whereNot(
                  (MapEntry<String, TypeDefinition> element) =>
                      annotations.containsKey(element.key),
                )
                .whereNot(
                  (MapEntry<String, TypeDefinition> element) =>
                      element.key == "__init__",
                )
                .map(
                  (MapEntry<String, TypeDefinition> e) =>
                      e.value.codeify(appType: appType, moduleName: moduleName),
                );
            buffer.writeln("/// annotations");
            for (final MapEntry<String, _PythonType> entry
                in annotations.entries) {
              final String name = entry.key;
              final _PythonType type = entry.value;
              buffer
                ..writeln("  $type get $name => getAttribute(\"$name\");")
                ..writeln(
                  "  set $name($type value) => setAttribute(\"$name\", value);",
                );
            }
            buffer.writeln("/// fields");
            for (final String field in fields) {
              buffer.writeln("  $field");
            }
            buffer.writeln("}");
            return buffer.toString();
          case PythonClassInterface():
          case PythonClass():
            return "typedef ${type.name} = ${_PythonType(name: type.name, type: type.type)};";
          case PythonFunctionInterface():
          case PythonFunction():
            final StringBuffer buffer = StringBuffer();
            final Object? returnTypeObject = annotations["return"];
            final String returnType = switch (returnTypeObject) {
              _PythonType() => returnTypeObject.toString(),
              _ => "dynamic",
            };
            buffer.write("$returnType ${type.name}(");
            final Iterable<String> args = annotations.entries
                .whereNot(
                  (MapEntry<String, _PythonType> e) => e.key == "return",
                )
                .map(
                  (MapEntry<String, _PythonType> e) => "${e.value} ${e.key}",
                );
            buffer.write(args.join(", "));
            buffer.writeln(
              ") => getFunction(\"${type.name}\").call(<Object?>[${args.map((String e) => e.split(" ").last).join(", ")}]);",
            );
            return buffer.toString();
          case PythonObjectInterface():
            throw UnimplementedError("PythonObject is not implemented");
        }
        return "(default) ${type.type}";
      case ValueTypeInfo():
        return type.value.toString();
    }
  }

  @override
  String toString() => "TypeDefinition<$type>: $attributes";
}

extension _TypeName on PythonClassDefinitionInterface {
  String get typeName {
    if (hasAttribute("__args__")) {
      final Object? typeArgs = getAttribute("__args__");
      if (typeArgs is List) {
        final Iterable<String> typeNames = typeArgs
            .whereType<PythonClassDefinitionInterface>()
            .map((PythonClassDefinitionInterface<PythonFfiDelegate<Object?>,
                        Object?>
                    e) =>
                e.typeName);
        return typeNames.join(" | ");
      }
    }
    if (hasAttribute("__name__")) {
      return getAttribute("__name__").toString();
    }
    return runtimeType.toString();
  }
}

base mixin TypeGenerationMixin on PythonObjectInterface {
  Iterable<String> get _subAttributes sync* {
    final Object? dirResult = BuiltinsModule.import().dir(this);
    if (dirResult is List) {
      yield* dirResult.whereType();
    }
    yield* _explicitlyAllowedAttributes;
  }

  Iterable<String> get _explicitlyAllowedAttributes => const <String>[];

  Iterable<String> get _explicitlyIgnoredAttributes => const <String>[];

  TypeDefinition? _recurse(
    String attribute,
    TypeDefinition parent, {
    required TypeDefinitionsCache cache,
  }) {
    if (_explicitlyIgnoredAttributes.contains(attribute)) {
      return null;
    }
    if (attribute.startsWith("_") &&
        !_explicitlyAllowedAttributes.contains(attribute)) {
      return null;
    }
    if (!hasAttribute(attribute)) {
      return null;
    }
    final Object? value = getAttribute(attribute);
    final TypeDefinition? cached = cache.get(value);
    if (cached != null) {
      return cached;
    }
    if (value is PythonModuleInterface) {
      final TypeGenerationModule typeGenerationModule =
          TypeGenerationModule.from(value);
      return typeGenerationModule.typeDefinition(
        attribute,
        cache: cache,
        type: PythonObjectTypeInfo.tryAccept(attribute, PythonModule, value),
      );
    } else if (value is PythonFunctionInterface) {
      final TypeGenerationFunction typeGenerationFunction =
          TypeGenerationFunction.from(value);
      return typeGenerationFunction.typeDefinition(
        attribute,
        cache: cache,
        type: PythonObjectTypeInfo.tryAccept(attribute, PythonFunction, value),
      );
    } else if (value is PythonClassDefinitionInterface) {
      final TypeGenerationClassDefinition typeGenerationClassDefinition =
          TypeGenerationClassDefinition.from(value);
      return typeGenerationClassDefinition.typeDefinition(
        attribute,
        cache: cache,
        type: PythonObjectTypeInfo.tryAccept(
          attribute,
          PythonClassDefinition,
          value,
        ),
      );
    } else if (value is PythonClassInterface) {
      final TypeGenerationClass typeGenerationClass =
          TypeGenerationClass.from(value);
      return typeGenerationClass.typeDefinition(
        attribute,
        cache: cache,
        type: PythonObjectTypeInfo.tryAccept(attribute, PythonClass, value),
      );
    } else if (value is PythonObjectInterface) {
      final TypeGenerationObject typeGenerationObject =
          TypeGenerationObject.from(value);
      return typeGenerationObject.typeDefinition(
        attribute,
        cache: cache,
        type: PythonObjectTypeInfo.tryAccept(attribute, PythonObject, value),
      );
    }
    final TypeDefinition typeDefinition = TypeDefinition(
      value,
      name: attribute,
      annotations: <String, _PythonType>{},
    );
    cache.add(typeDefinition);
    return typeDefinition;
  }

  TypeDefinition typeDefinition(
    String name, {
    required TypeDefinitionsCache cache,
    _TypeInfo? type,
  }) {
    final TypeDefinition typeDefinition =
        TypeDefinition(this, type: type, annotations: annotations);
    cache.add(typeDefinition);
    for (final String attribute in _subAttributes) {
      final TypeDefinition? child = _recurse(
        attribute,
        typeDefinition,
        cache: cache,
      );
      if (child != null) {
        typeDefinition.add(attribute, child);
      }
    }
    return typeDefinition;
  }

  Map<String, _PythonType> get annotations {
    final String annotationsAttribute = "__annotations__";
    if (!hasAttribute(annotationsAttribute)) {
      return <String, _PythonType>{};
    }
    final Object? annotations = getAttribute(annotationsAttribute);
    if (annotations is Map) {
      return annotations.map(
        (Object? key, Object? value) {
          if (key is! String) {
            throw ArgumentError.value(
              key,
              "key",
              "Expected String, got ${key.runtimeType}",
            );
          }
          print("key: $key, value<${value.runtimeType}>");
          final String typeName = switch (value) {
            PythonClassDefinitionInterface() => value.typeName,
            PythonClassInterface() => value.hasAttribute("__name__")
                ? value.getAttribute("__name__").toString()
                : value.toString(),
            PythonObjectInterface() => value.toString(),
            _ => value.runtimeType.toString(),
          };
          final Type typeType = switch (value) {
            PythonClassDefinitionInterface() => PythonClassDefinition,
            // TODO: implement custom conversion for PythonClass (Python Type) to Type
            PythonClassInterface() => PythonClass,
            PythonObjectInterface() => PythonObject,
            _ => value.runtimeType,
          };
          return MapEntry<String, _PythonType>(
            key,
            _PythonType(name: typeName, type: typeType),
          );
        },
      );
    }
    return <String, _PythonType>{};
  }

  String? get jsonName {
    final String nameAttribute = "__name__";
    if (!hasAttribute(nameAttribute)) {
      return null;
    }
    return getAttribute(nameAttribute).toString();
  }

  Map<String, dynamic>? get jsonAnnotations {
    final String annotationsAttribute = "__annotations__";
    if (!hasAttribute(annotationsAttribute)) {
      return null;
    }
    final Object? annotations = getAttribute(annotationsAttribute);
    final Map<String, Object?> result = <String, Object?>{};
    if (annotations is Map) {
      final Iterable<String> keys = annotations.keys.whereType();
      for (final String key in keys) {
        result[key] = null;
      }
    }
    return result;
  }

  List<String>? get jsonDir {
    final Object? dir = BuiltinsModule.import().dir(this);
    if (dir is List) {
      return dir.whereType<String>().toList();
    }
    return null;
  }

  Map<String, dynamic> get toJsonRaw => <String, dynamic>{
        "name": jsonName,
        "annotations": jsonAnnotations,
        "dir": jsonDir,
        "raw": reference.toString(),
      };

  Iterable<String> get _attributeKeys => jsonDir ?? const <String>[];

  bool _attributeFilter(String attributeKey) => !attributeKey.startsWith("_");

  Map<String, dynamic> jsonAttributes(Map<Object?, int> cache) {
    final Map<String, dynamic> result = <String, dynamic>{};
    for (final String attributeKey in _attributeKeys.where(_attributeFilter)) {
      if (!hasAttribute(attributeKey)) {
        continue;
      }
      final Object? attribute = getAttribute(attributeKey);
      if (attribute is! PythonObjectInterface) {
        result[attributeKey] = attribute;
        continue;
      }
      final int? cached = cache[attribute.reference];
      if (cached != null) {
        result[attributeKey] = <String, dynamic>{
          "_cacheId": cached,
        };
        continue;
      }
      final TypeGenerationObject typeGenerationObject =
          TypeGenerationObject.from(attribute);
      final Map<String, dynamic> json =
          typeGenerationObject.toJsonHydrated(cache);
      result[attributeKey] = json;
    }
    return result;
  }

  Map<String, dynamic> toJsonHydrated(Map<Object?, int> cache) {
    final int timestamp = DateTime.now().microsecondsSinceEpoch;
    final Map<String, dynamic> result = <String, dynamic>{
      "name": jsonName,
      "raw": reference.toString(),
    };
    final int cacheId = timestamp ^ result.hashCode;
    cache[reference] = cacheId;
    result["_cacheId"] = cacheId;
    result["attributes"] = jsonAttributes(cache);
    return result;
  }
}

final class TypeGenerationObject extends PythonObject with TypeGenerationMixin {
  TypeGenerationObject.from(super.objectDelegate) : super.from();
}

final class TypeGenerationClass extends PythonClass with TypeGenerationMixin {
  TypeGenerationClass.from(super.classDelegate) : super.from();
}

final class TypeGenerationClassDefinition extends PythonClassDefinition
    with TypeGenerationMixin {
  TypeGenerationClassDefinition.from(super.classDefinitionDelegate)
      : super.from();

  @override
  Iterable<String> get _explicitlyAllowedAttributes sync* {
    yield "__init__";
  }
}

final class TypeGenerationFunction extends PythonFunction
    with TypeGenerationMixin {
  TypeGenerationFunction.from(super.classDelegate) : super.from();
}

final class TypeGenerationModule extends PythonModule with TypeGenerationMixin {
  TypeGenerationModule.from(super.moduleDelegate) : super.from();

  static const String _k__all__ = "__all__";

  List<String> get __all__ => getAttribute<List<Object?>>(_k__all__).cast();

  @override
  Iterable<String> get _subAttributes =>
      hasAttribute(_k__all__) ? __all__ : super._subAttributes;

  List<String>? get jsonAll {
    final String allAttribute = "__all__";
    if (!hasAttribute(allAttribute)) {
      return null;
    }
    final Object? all = getAttribute(allAttribute);
    if (all is List) {
      return all.whereType<String>().toList();
    }
    return null;
  }

  @override
  Map<String, dynamic> get toJsonRaw => super.toJsonRaw
    ..addAll(<String, dynamic>{
      "all": jsonAll,
    });

  @override
  Iterable<String> get _attributeKeys => jsonAll ?? super._attributeKeys;
}
