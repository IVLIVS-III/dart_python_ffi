// ignore_for_file: non_constant_identifier_names

part of inspect;

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
    final String name = sanitizeName(this.name);
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
      case (ParameterKind.positional_or_keyword || ParameterKind.keyword_only)
          when default_ == empty ||
              default_ == null ||
              _encode(default_) == "null":
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
