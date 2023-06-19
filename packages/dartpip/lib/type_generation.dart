import "package:collection/collection.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";

base mixin TypeGenerationMixin on PythonObjectInterface {
  Map<String, dynamic> _recurse(String attribute) {
    print("Recurse: $attribute");
    final Map<String, dynamic> result = <String, dynamic>{};
    if (!hasAttribute(attribute)) {
      return result;
    }
    final value = getAttribute(attribute);
    print("got $attribute");
    if (value is PythonModuleInterface) {
      print("$attribute<${value.runtimeType}>");
      result["type"] = attribute;
      final TypeGenerationModule typeGenerationModule =
          TypeGenerationModule.from(value);
      result["children"] = typeGenerationModule.annotations;
    } else if (value is PythonClassInterface) {
      print("$attribute<${value.runtimeType}>");
      result["type"] = attribute;
      final TypeGenerationClass typeGenerationClass =
          TypeGenerationClass.from(value);
      result["children"] = typeGenerationClass.annotations;
    } else if (value is PythonObjectInterface) {
      print("$attribute<${value.runtimeType}>");
      result["type"] = attribute;
      final TypeGenerationObject typeGenerationObject =
          TypeGenerationObject.from(value);
      print(
        "wrapped $attribute<${value.runtimeType}> with TypeGenerationObject",
      );
      result["children"] = typeGenerationObject.annotations;
    } else {
      print("$attribute<${value.runtimeType}> = $value");
      print("found a non-Python object@$attribute");
      result["type"] = value.runtimeType.toString();
    }
    return result;
  }

  Map<String, dynamic>? _handle(
    String attribute,
    Object? Function(String) getter, {
    required Iterable<String> Function(Object) valueInterpreter,
  }) {
    if (!hasAttribute(attribute)) {
      return null;
    }
    final Object? all = getter(attribute);
    print("$attribute<${all.runtimeType}> = $all");
    if (all is! List) {
      return null;
    }
    final Map<String, dynamic> result = <String, dynamic>{};
    for (final String attribute in all.whereType()) {
      result[attribute] = <String, dynamic>{
        "type": attribute,
        "children": _recurse(attribute),
      };
    }
    return result;
  }

  Map<String, dynamic>? _handleDir() => _handle(
        "__dir__",
        (String attribute) => getFunction(attribute).call(<Object?>[reference]),
        valueInterpreter: (Object value) => value is List
            ? value
                .whereType<String>()
                .whereNot((String e) => e.startsWith("__") && e.endsWith("__"))
            : <String>[],
      );

  Map<String, dynamic>? _handleDict() => _handle(
        "__dict__",
        getAttribute,
        valueInterpreter: (Object value) => value is Map
            ? value.keys
                .whereType<String>()
                .whereNot((String e) => e.startsWith("__") && e.endsWith("__"))
            : <String>[],
      );

  Map<String, dynamic> get annotations =>
      _handleDir() ?? _handleDict() ?? <String, dynamic>{};
}

final class TypeGenerationObject extends PythonObject with TypeGenerationMixin {
  TypeGenerationObject.from(super.objectDelegate) : super.from();
}

final class TypeGenerationClass extends PythonClass with TypeGenerationMixin {
  TypeGenerationClass.from(super.classDelegate) : super.from();
}

final class TypeGenerationModule extends PythonModule with TypeGenerationMixin {
  TypeGenerationModule.from(super.moduleDelegate) : super.from();

  Map<String, dynamic>? _handleAll() => _handle(
        "__all__",
        getAttribute,
        valueInterpreter: (Object value) =>
            value is List ? value.whereType() : <String>[],
      );

  @override
  Map<String, dynamic> get annotations => _handleAll() ?? super.annotations;
}
