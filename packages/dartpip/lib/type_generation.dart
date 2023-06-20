import "dart:collection";

import "package:python_ffi_cpython_dart/python_ffi_cpython_dart.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";

final class BuiltinsModule extends PythonModule {
  BuiltinsModule.from(super.moduleDelegate) : super.from();

  static BuiltinsModule import() =>
      PythonFfiDart.instance.importModule("builtins", BuiltinsModule.from);

  Object? dir(Object? object) => getFunction("dir").call(<Object?>[object]);
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
    return a == b;
  }

  static int _hashCode(Object? a) {
    if (a == null) {
      return 0;
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
        return PythonObjectTypeInfo(
          object.runtimeType.toString(),
          object.runtimeType,
          reference.address,
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
  PythonObjectTypeInfo(String name, Type type, this.reference)
      : super._(name, type);

  static _TypeInfo tryAccept(
      String name, Type type, PythonObjectInterface object) {
    final Object? reference = object.reference;
    if (reference is Pointer<PyObject>) {
      return PythonObjectTypeInfo(name, type, reference.address);
    }
    throw ArgumentError.value(
      object,
      "object",
      "PythonObjectInterface must have a reference to a PyObject, but reference has type ${reference.runtimeType}",
    );
  }

  final int reference;

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

class TypeDefinition {
  TypeDefinition(this.object, {_TypeInfo? type, String? name})
      : type = type ??
            _TypeInfo.from(name ?? object.runtimeType.toString(), object);

  final Object? object;
  final _TypeInfo type;
  final Map<String, TypeDefinition> attributes = <String, TypeDefinition>{};

  void add(String name, TypeDefinition child) {
    attributes[name] = child;
  }

  Map<String, dynamic> get shallowDump => <String, dynamic>{
        "info": type.toJson,
        "attributes": attributes.map(
          (String key, TypeDefinition value) =>
              MapEntry<String, dynamic>(key, value.type.toJson),
        ),
      };

  Map<String, dynamic> get deepDump => <String, dynamic>{
        "info": type.toJson,
        "attributes": attributes.map(
          (String key, TypeDefinition value) =>
              MapEntry<String, dynamic>(key, value.deepDump),
        ),
      };

  @override
  String toString() => "TypeDefinition<$type>: $attributes";
}

base mixin TypeGenerationMixin on PythonObjectInterface {
  Iterable<String> get _subAttributes {
    final Object? dirResult = BuiltinsModule.import().dir(this);
    if (dirResult is List) {
      return dirResult.whereType();
    }
    return <String>[];
  }

  TypeDefinition? _recurse(
    String attribute,
    TypeDefinition parent, {
    required TypeDefinitionsCache cache,
  }) {
    if (attribute.startsWith("_")) {
      return null;
    }
    if (!hasAttribute(attribute)) {
      return null;
    }
    final value = getAttribute(attribute);
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
    final TypeDefinition typeDefinition =
        TypeDefinition(value, name: attribute);
    cache.add(typeDefinition);
    return typeDefinition;
  }

  TypeDefinition typeDefinition(
    String name, {
    required TypeDefinitionsCache cache,
    _TypeInfo? type,
  }) {
    final TypeDefinition typeDefinition = TypeDefinition(this, type: type);
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
}

final class TypeGenerationObject extends PythonObject with TypeGenerationMixin {
  TypeGenerationObject.from(super.objectDelegate) : super.from();
}

final class TypeGenerationClass extends PythonClass with TypeGenerationMixin {
  TypeGenerationClass.from(super.classDelegate) : super.from();
}

final class TypeGenerationFunction extends PythonFunction
    with TypeGenerationMixin {
  TypeGenerationFunction.from(super.classDelegate) : super.from();
}

final class TypeGenerationModule extends PythonModule with TypeGenerationMixin {
  TypeGenerationModule.from(super.moduleDelegate) : super.from();

  List<String> get __all__ => getAttribute<List<Object?>>("__all__").cast();

  @override
  Iterable<String> get _subAttributes => __all__;
}
