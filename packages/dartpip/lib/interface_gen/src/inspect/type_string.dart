part of interface_gen;

typedef _ReturnTransform = String Function(String);

_ReturnTransform _idTransform = (String input) => input;

class ObjInfo {
  factory ObjInfo(PythonObjectInterface? _source) => ObjInfo._(
        name: _source?.getAttributeOrNull("__name__"),
        qualname: _source?.getAttributeOrNull("__qualname__"),
        module: _source?.getAttributeOrNull("__module__"),
      );

  ObjInfo._({
    required this.name,
    required this.qualname,
    required this.module,
  });

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

  final String? name;

  final String? qualname;

  final String? module;

  @override
  String toString() =>
      "ObjInfo(name: $name, qualname: $qualname, module: $module)";
}

String _getTypeStringFromCollection(List<Object?> types) {
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
      .map(_getTypeString)
      .toSet()
      .reduce((String value, String element) => "Object?");
}

(String, _ReturnTransform) _getTypeStringFromClassDefWithTransform(
  PythonClassDefinitionInterface object, {
  bool isReturnString = false,
}) {
  final ObjInfo info = ObjInfo(object);
  final Object? typeObject = BuiltinsModule.import().type(object);
  final ObjInfo? typeInfo =
      typeObject is PythonObjectInterface ? ObjInfo(typeObject) : null;
  if (info.module == "builtins" &&
      info.name == info.qualname &&
      info.qualname != null) {
    final (String, _ReturnTransform)? result = switch (info.qualname) {
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
            _ => _getTypeString(object.getAttribute("__origin__")),
          };

          final List<Object?> args = object.getAttribute("__args__");
          final Iterable<(String, _ReturnTransform)> typeArgs = args.map(
            (Object? e) => _getTypeStringWithTransform(
              e,
              isReturnString: isReturnString,
            ),
          );
          final String typeArguments = switch (info.qualname) {
            "tuple" => _getTypeStringFromCollection(args),
            _ =>
              typeArgs.map(((String, _ReturnTransform) e) => e.$1).join(", "),
          };
          final String typeString = "$container<$typeArguments>";
          final _ReturnTransform transform = isReturnString
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
    final (String, _ReturnTransform)? result = switch (info.qualname) {
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
          final Iterable<(String, _ReturnTransform)> typeArgs = args.map(
            (Object? e) => _getTypeStringWithTransform(
              e,
              isReturnString: isReturnString,
            ),
          );
          final String typeArguments =
              typeArgs.map(((String, _ReturnTransform) e) => e.$1).first;
          final _ReturnTransform transform = isReturnString
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
          final Iterable<(String, _ReturnTransform)> typeArgs = args.map(
            (Object? e) => _getTypeStringWithTransform(
              e,
              isReturnString: isReturnString,
            ),
          );
          final Iterable<(String, _ReturnTransform)> parameterTypes =
              typeArgs.skipLast(1);
          final String parameterTypesString = parameterTypes
              .map(((String, _ReturnTransform) e) => e.$1)
              .join(", ");
          final Iterable<(String, String)> parameterArgs =
              parameterTypes.enumerate().map(
                    ((int, (String, _ReturnTransform)) e) =>
                        (e.$2.$1, "x${e.$1}"),
                  );
          final String typedArgString = parameterArgs
              .map(((String, String) e) => "${e.$1} ${e.$2}")
              .join(", ");
          final String argString =
              parameterArgs.map(((String, String) e) => e.$2).join(", ");
          final (String, _ReturnTransform) returnType = typeArgs.last;
          final String returnTypeString = returnType.$1;
          final _ReturnTransform transform = switch (isReturnString) {
            true => (String call) => """
PythonFunction.from($call,)
.asFunction(
  (PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?> f)
    => ($typedArgString) => f.call(<Object?>[$argString]),
)
""",
            // TODO: use this transform
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
  return ("Object?", _idTransform);
}

(String, _ReturnTransform) _getTypeStringWithTransform(
  Object? object, {
  bool isReturnString = false,
}) {
  // TODO: implement typedef
  switch (object) {
    case null:
      return ("Null", _idTransform);
    case PythonClassDefinitionInterface():
      return _getTypeStringFromClassDefWithTransform(
        object,
        isReturnString: isReturnString,
      );
    case Parameter():
      return _getTypeStringWithTransform(object.annotation);
    case ClassInstance():
      return ("Object?", _idTransform);
    case AnyTypePrimitive():
      return ("Object?", _idTransform);
    case InspectEntry():
      return _getTypeStringWithTransform(object.value);
    case _:
      return ("Object?", _idTransform);
  }
}

String _getTypeString(
  Object? object, {
  bool isReturnString = false,
}) =>
    _getTypeStringWithTransform(object, isReturnString: isReturnString).$1;
