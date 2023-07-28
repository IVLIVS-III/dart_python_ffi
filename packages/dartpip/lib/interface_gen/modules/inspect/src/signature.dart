// ignore_for_file: non_constant_identifier_names

part of inspect;

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

  Map<String, Object?> debugDump({InspectionCache? cache}) => <String, Object?>{
        "parameters": parameters.map(
          (String key, Parameter value) =>
              MapEntry<String, Map<String, Object?>>(key, value.debugDump()),
        ),
        "return_annotation": return_annotation,
      };
}
