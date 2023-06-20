import "package:collection/collection.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";

final class BuiltinsModule extends PythonModule {
  BuiltinsModule.from(super.moduleDelegate) : super.from();

  static BuiltinsModule import() =>
      PythonFfiDart.instance.importModule("builtins", BuiltinsModule.from);

  Object? dir(Object? object) => getFunction("dir").call(<Object?>[object]);
}

class TypeDefinition {
  TypeDefinition(this.name, this.object, {this.parent, String? type})
      : type = type ?? object.runtimeType.toString();

  final String name;
  final Object? object;
  final TypeDefinition? parent;
  final String type;
  final Map<String, TypeDefinition> children = <String, TypeDefinition>{};

  void add(String name, TypeDefinition child) {
    children[name] = child;
  }

  TypeDefinition? cached(
    Object? wantedObject, {
    TypeDefinition? caller,
    required int depth,
    required String wantedName,
  }) {
    throw UnimplementedError("cached");
    print(
      "${"  " * depth}searching for $wantedName in $name, called by ${caller?.name}",
    );
    if (object == wantedObject) {
      return this;
    }
    for (final TypeDefinition child in children.values) {
      if (child.object == caller?.object) {
        continue;
      }
      final TypeDefinition? result = child.cached(
        wantedObject,
        caller: this,
        depth: depth + 1,
        wantedName: wantedName,
      );
      if (result != null) {
        return result;
      }
    }
    if (caller?.object != parent?.object) {
      return parent?.cached(
        wantedObject,
        caller: this,
        depth: depth + 1,
        wantedName: wantedName,
      );
    }
    return null;
  }

  @override
  String toString() => "$name<$type>: $children";
}

base mixin TypeGenerationMixin on PythonObjectInterface {
  Map<String, dynamic>? _recurse(String attribute, {required int depth}) {
    final String indent = "  " * depth;
    if (attribute.startsWith("_")) {
      // print("Warning: $attribute is a private attribute, skipping.");
      return null;
    }
    print("${indent}Recurse: $attribute");
    if (!hasAttribute(attribute)) {
      return null;
    }
    final Map<String, dynamic> result = <String, dynamic>{};
    final value = getAttribute(attribute);
    // print("got $attribute");
    if (value is PythonModuleInterface) {
      // print("$attribute<${value.runtimeType}>");
      result["type"] = attribute;
      final TypeGenerationModule typeGenerationModule =
          TypeGenerationModule.from(value);
      result["children"] = typeGenerationModule.annotations(depth: depth + 1);
    } else if (value is PythonClassInterface) {
      // print("$attribute<${value.runtimeType}>");
      result["type"] = attribute;
      final TypeGenerationClass typeGenerationClass =
          TypeGenerationClass.from(value);
      result["children"] = typeGenerationClass.annotations(depth: depth + 1);
    } else if (value is PythonObjectInterface) {
      // print("$attribute<${value.runtimeType}>");
      result["type"] = attribute;
      final TypeGenerationObject typeGenerationObject =
          TypeGenerationObject.from(value);
      /*
      print(
        "wrapped $attribute<${value.runtimeType}> with TypeGenerationObject",
      );
      */
      result["children"] = typeGenerationObject.annotations(depth: depth + 1);
    } else {
      // print("$attribute<${value.runtimeType}> = $value");
      // print("found a non-Python object@$attribute");
      result["type"] = value.runtimeType.toString();
    }
    return result;
  }

  Map<String, dynamic>? _handle(
    String attribute,
    Object? Function(String) getter, {
    required Iterable<String> Function(Object) valueInterpreter,
    required int depth,
  }) {
    if (!hasAttribute(attribute)) {
      return null;
    }
    final Object? subAttributes = getter(attribute);
    // print("$attribute<${subAttributes.runtimeType}> = $subAttributes");
    if (subAttributes == null) {
      return null;
    }
    final Map<String, dynamic> result = <String, dynamic>{};
    for (final String attribute in valueInterpreter(subAttributes)) {
      final Map<String, dynamic>? children =
          _recurse(attribute, depth: depth + 1);
      result[attribute] = <String, dynamic>{
        "type": attribute,
        "children": children,
      };
    }
    return result;
  }

  Map<String, dynamic>? _handleDir({required int depth}) => _handle(
        "__dir__",
        (_) => BuiltinsModule.import().dir(this),
        valueInterpreter: (Object value) =>
            value is List ? value.whereType() : <String>[],
        depth: depth,
      );

  Map<String, dynamic> annotations({required int depth}) =>
      _handleDir(depth: depth) ?? <String, dynamic>{};

  TypeDefinition? _recurse2(
    String attribute,
    TypeDefinition parent, {
    required Set<TypeDefinition> cache,
    required int depth,
  }) {
    final String indent = "  " * depth;
    if (attribute.startsWith("_")) {
      // print("Warning: $attribute is a private attribute, skipping.");
      return null;
    }
    print("${indent}Recurse: $attribute");
    if (!hasAttribute(attribute)) {
      return null;
    }
    final value = getAttribute(attribute);
    final TypeDefinition? cached = cache.firstWhereOrNull(
      (TypeDefinition element) => element.object == value,
    );
    if (cached != null) {
      print("${indent}--> found cached $attribute");
      return cached;
    } else {
      print("${indent}--> not found cached $attribute");
    }
    // print("got $attribute");
    if (value is PythonModuleInterface) {
      // print("$attribute<${value.runtimeType}>");
      final TypeGenerationModule typeGenerationModule =
          TypeGenerationModule.from(value);
      return typeGenerationModule.typeDefinition(
        attribute,
        cache: cache,
        parent: parent,
        type: attribute,
        depth: depth + 1,
      );
    } else if (value is PythonClassInterface) {
      // print("$attribute<${value.runtimeType}>");
      final TypeGenerationClass typeGenerationClass =
          TypeGenerationClass.from(value);
      return typeGenerationClass.typeDefinition(
        attribute,
        cache: cache,
        parent: parent,
        type: attribute,
        depth: depth + 1,
      );
    } else if (value is PythonObjectInterface) {
      // print("$attribute<${value.runtimeType}>");
      final TypeGenerationObject typeGenerationObject =
          TypeGenerationObject.from(value);
      /*
      print(
        "wrapped $attribute<${value.runtimeType}> with TypeGenerationObject",
      );
      */
      return typeGenerationObject.typeDefinition(
        attribute,
        cache: cache,
        parent: parent,
        type: attribute,
        depth: depth + 1,
      );
    }
    final TypeDefinition typeDefinition =
        TypeDefinition(attribute, value, parent: parent);
    cache.add(typeDefinition);
    print(
      "${indent}--> found non-Python object ${typeDefinition.name}<${value.runtimeType}>",
    );
    final String valueString = switch (value) {
      Iterable() => "(...)",
      Map() => "{...}",
      PythonObjectInterface() => "PythonObjectInterface@${value.reference}",
      _ => "$value",
    };
    print(
      "${indent}--> added non-Python object ${typeDefinition.name}<${value.runtimeType}> = $valueString to cache",
    );
    return typeDefinition;
  }

  TypeDefinition typeDefinition(
    String name, {
    required Set<TypeDefinition> cache,
    String? type,
    TypeDefinition? parent,
    required int depth,
  }) {
    final TypeDefinition typeDefinition =
        TypeDefinition(name, this, parent: parent, type: type);
    cache.add(typeDefinition);
    print(
      "${"  " * depth}--> added ${typeDefinition.name}@$reference to cache",
    );
    final Object? dirResult = BuiltinsModule.import().dir(this);
    if (dirResult is List) {
      for (final String attribute in dirResult.whereType()) {
        final TypeDefinition? child = _recurse2(
          attribute,
          typeDefinition,
          cache: cache,
          depth: depth + 1,
        );
        if (child != null) {
          typeDefinition.add(attribute, child);
        }
      }
    }
    return typeDefinition;
  }
}

final class TypeGenerationObject extends PythonObject with TypeGenerationMixin {
  TypeGenerationObject.from(super.objectDelegate) : super.from();
}

final class TypeGenerationClass extends PythonClass with TypeGenerationMixin {
  TypeGenerationClass.from(super.classDelegate) : super.from();
}

final class TypeGenerationModule extends PythonModule with TypeGenerationMixin {
  TypeGenerationModule.from(super.moduleDelegate) : super.from();

  Map<String, dynamic>? _handleAll({required int depth}) => _handle(
        "__all__",
        getAttribute,
        valueInterpreter: (Object value) =>
            value is List ? value.whereType() : <String>[],
        depth: depth,
      );

  @override
  Map<String, dynamic> annotations({required int depth}) =>
      _handleAll(depth: depth) ?? super.annotations(depth: depth);
}
