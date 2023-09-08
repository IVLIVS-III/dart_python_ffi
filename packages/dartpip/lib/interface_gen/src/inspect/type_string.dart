part of interface_gen;

/// TODO: Document.
typedef Transform = String Function(String);

Transform _idTransform = (String input) => input;

/// TODO: Document.
class ObjInfo {
  /// TODO: Document.
  factory ObjInfo(
    PythonObjectInterface<PythonFfiDelegate<Object?>, Object?>? source,
  ) =>
      ObjInfo._(
        name: source?.getAttributeOrNull("__name__"),
        qualname: source?.getAttributeOrNull("__qualname__"),
        module: source?.getAttributeOrNull("__module__"),
      );

  ObjInfo._({
    required this.name,
    required this.qualname,
    required this.module,
  });

  /// TODO: Document.
  ObjInfo copyWith({
    String? name,
    String? qualname,
    String? module,
  }) =>
      ObjInfo._(
        name: name ?? this.name,
        qualname: qualname ?? this.qualname,
        module: module ?? this.module,
      );

  /// TODO: Document.
  final String? name;

  /// TODO: Document.
  final String? qualname;

  /// TODO: Document.
  final String? module;

  @override
  String toString() =>
      "ObjInfo(name: $name, qualname: $qualname, module: $module)";
}

String _getTypeStringFromCollection(
  List<Object?> types, {
  required InspectionCache cache,
}) {
  if (types.isEmpty) {
    return "Object?";
  }
  final List<Object?> typesCopy = types.toList();
  if (typesCopy.length == 2) {
    final Object? second = typesCopy[1];
    final Object? typeObject = BuiltinsModule.import().type(second);
    if (typeObject is PythonObjectInterface) {
      final ObjInfo info = ObjInfo(typeObject);
      if (info.module == "builtins" &&
          info.name == info.qualname &&
          info.qualname == "ellipsis") {
        typesCopy.removeLast();
      }
    }
  }
  return typesCopy
      .map((Object? e) => _getTypeString(e, cache: cache))
      .toSet()
      .reduce((String value, String element) => "Object?");
}

(String, Transform) _getTypeStringFromClassDefWithTransform(
  PythonClassDefinitionInterface<PythonFfiDelegate<Object?>, Object?> object, {
  required InspectionCache cache,
  bool isReturnString = false,
}) {
  final ObjInfo info = ObjInfo(object);
  final Object? typeObject = BuiltinsModule.import().type(object);
  final ObjInfo? typeInfo =
      typeObject is PythonObjectInterface ? ObjInfo(typeObject) : null;
  if (info.module == "builtins" &&
      info.name == info.qualname &&
      info.qualname != null) {
    final (String, Transform)? result = switch (info.qualname) {
      "bool" => ("bool", _idTransform),
      "int" => ("int", _idTransform),
      "float" => ("double", _idTransform),
      "str" => ("String", _idTransform),
      "bytes" => ("Uint8List", _idTransform),
      ("list" || "dict" || "set" || "tuple")
          when typeInfo != null &&
              typeInfo.module == "types" &&
              typeInfo.name == typeInfo.qualname &&
              typeInfo.qualname == "GenericAlias" =>
        (() {
          final String container = switch (info.qualname) {
            "tuple" when isReturnString => "List",
            _ => _getTypeString(
                object.getAttribute("__origin__"),
                cache: cache,
              ),
          };

          final List<Object?> args = object.getAttribute("__args__");
          final Iterable<(String, Transform)> typeArgs = args.map(
            (Object? e) => _getTypeStringWithTransform(
              e,
              cache: cache,
              isReturnString: isReturnString,
            ),
          );
          final String typeArguments = switch (info.qualname) {
            "tuple" => _getTypeStringFromCollection(args, cache: cache),
            _ => typeArgs.map(((String, Transform) e) => e.$1).join(", "),
          };
          final String typeString = "$container<$typeArguments>";
          final Transform transform = isReturnString
              ? switch (info.qualname) {
                  "tuple" when typeArguments == "Object?" => (String call) =>
                      "$container.from($call,)",
                  "list" || "set" || "tuple" => (String call) => """
$typeString.from(
  $container.from($call,)
  .map(
    (e) => ${typeArgs.first.$2("e")},
  ),
)""",
                  "dict" => (String call) => """
$typeString.from(
  $container.from($call,)
  .map(
    (k, v) => MapEntry(
      ${typeArgs.first.$2("k")},
      ${typeArgs.last.$2("v")},
    ),
  ),
)""",
                  _ => (String call) => "$typeString.from($call,)",
                }
              : _idTransform;
          return (typeString, transform);
        })(),
      "list" => ("List", _idTransform),
      "dict" => ("Map", _idTransform),
      "set" => ("Set", _idTransform),
      "tuple" when isReturnString => ("List", _idTransform),
      "tuple" when !isReturnString => ("PythonTuple", _idTransform),
      _ => null,
    };
    if (result != null) {
      return result;
    }
  }
  if (info.module == "typing" &&
      info.name == info.qualname &&
      info.qualname != null) {
    final (String, Transform)? result = switch (info.qualname) {
      ("Iterator" || "Generator" || "Iterable")
          when typeInfo != null &&
              typeInfo.module == "typing" &&
              typeInfo.name == typeInfo.qualname &&
              typeInfo.qualname == "_GenericAlias" =>
        (() {
          final String container = switch (info.qualname) {
            "Iterator" || "Generator" => "Iterator",
            "Iterable" => "Iterable",
            _ => throw UnimplementedError(info.qualname),
          };
          final List<Object?> args = object.getAttribute("__args__");
          final Iterable<(String, Transform)> typeArgs = args.map(
            (Object? e) => _getTypeStringWithTransform(
              e,
              cache: cache,
              isReturnString: isReturnString,
            ),
          );
          final String typeArguments =
              typeArgs.map(((String, Transform) e) => e.$1).first;
          final Transform transform = isReturnString
              ? (String call) => """
Typed$container.from(
  Python$container.from<Object?, PythonFfiDelegate<Object?>, Object?>($call,),
)
.transform((e) => ${typeArgs.first.$2("e")})
.cast<$typeArguments>()"""
              : _idTransform;
          return ("$container<$typeArguments>", transform);
        })(),
      ("Iterator" || "Generator") => ("Iterator", _idTransform),
      "Iterable" => ("Iterable", _idTransform),
      "Callable"
          when typeInfo != null &&
              typeInfo.module == "typing" &&
              typeInfo.name == typeInfo.qualname &&
              typeInfo.qualname == "_CallableGenericAlias" =>
        (() {
          final List<Object?> args = object.getAttribute("__args__");
          final Iterable<(String, Transform)> typeArgs = args.map(
            (Object? e) => _getTypeStringWithTransform(
              e,
              cache: cache,
              isReturnString: isReturnString,
            ),
          );
          final Iterable<(String, Transform)> parameterTypes =
              typeArgs.skipLast(1);
          final String parameterTypesString =
              parameterTypes.map(((String, Transform) e) => e.$1).join(", ");
          final Iterable<(String, String)> parameterArgs =
              parameterTypes.enumerate().map(
                    ((int, (String, Transform)) e) => (e.$2.$1, "x${e.$1}"),
                  );
          final String typedArgString = parameterArgs
              .map(((String, String) e) => "${e.$1} ${e.$2}")
              .join(", ");
          final String argString =
              parameterArgs.map(((String, String) e) => e.$2).join(", ");
          final (String, Transform) returnType = typeArgs.last;
          final String returnTypeString = returnType.$1;
          final Transform transform = switch (isReturnString) {
            true => (String call) => """
PythonFunction.from($call,)
.asFunction(
  (PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?> f)
    => ($typedArgString) => f.call(<Object?>[$argString]),
)
""",
            false => (String call) => "$call.generic${parameterTypes.length}",
          };
          return (
            "$returnTypeString Function($parameterTypesString)",
            transform,
          );
        })(),
      "Callable" => ("Function", _idTransform),
      _ => null,
    };
    if (result != null) {
      return result;
    }
  }
  final InspectEntry? cacheEntry = cache[object];
  if (cacheEntry != null && inspect.import().isclass(cacheEntry.value)) {
    final Transform transform = switch ((isReturnString, cacheEntry.value)) {
      (false, _) => _idTransform,
      (
        _,
        PythonClassDefinitionInterface<PythonFfiDelegate<Object?>, Object?>()
      ) =>
        (String call) => "${cacheEntry.sanitizedName}.from($call,)",
      _ => _idTransform,
    };
    return (cacheEntry.sanitizedName, transform);
  }
  return ("Object?", _idTransform);
}

(String, Transform) _getTypeStringWithTransform(
  Object? object, {
  required InspectionCache cache,
  bool isReturnString = false,
  InstantiatedInspectEntry? parentEntry,
}) {
  // TODO: implement typedef
  switch (object) {
    case null:
      return ("Null", _idTransform);
    case PythonClassDefinitionInterface<PythonFfiDelegate<Object?>, Object?>():
      return _getTypeStringFromClassDefWithTransform(
        object,
        cache: cache,
        isReturnString: isReturnString,
      );
    case Parameter():
      return _getTypeStringWithTransform(
        object.annotation,
        cache: cache,
        parentEntry: parentEntry,
      );
    case ClassInstance():
      return ("Object?", _idTransform);
    case AnyTypePrimitive():
      return ("Object?", _idTransform);
    case InspectEntry():
      return _getTypeStringWithTransform(
        object.value,
        cache: cache,
        parentEntry: parentEntry,
      );
    case String() when object == parentEntry?.sanitizedName:
      return _getTypeStringWithTransform(
        parentEntry?.source.value,
        cache: cache,
        isReturnString: isReturnString,
      );
    case _:
      return ("Object?", _idTransform);
  }
}

String _getTypeString(
  Object? object, {
  required InspectionCache cache,
  bool isReturnString = false,
}) =>
    _getTypeStringWithTransform(
      object,
      cache: cache,
      isReturnString: isReturnString,
    ).$1;
