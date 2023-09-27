// ignore_for_file: non_constant_identifier_names, camel_case_types

part of types;

/// Module definition for the Python module `types`.
/// This is hand-crafted and not generated. Thus it only contains a subset of
/// the actual module.
final class types extends PythonModule {
  /// Wraps a Python object with the [types] module definition.
  types.from(super.moduleDelegate) : super.from();

  /// The main constructor for this module.
  static types import() => PythonFfiDart.instance.importModule(
        "types",
        types.from,
      );

  static bool _isType(
    PythonObjectInterface<PythonFfiDelegate<Object?>, Object?>
        classParentModule,
  ) {
    final types typesModule = types.import();
    final ReferenceEqualityWrapper typesModuleWrapper =
        ReferenceEqualityWrapper(typesModule);
    final ReferenceEqualityWrapper classParentModuleWrapper =
        ReferenceEqualityWrapper(classParentModule);
    if (classParentModuleWrapper != typesModuleWrapper) {
      return false;
    }
    // TODO: make this more robust
    return true;
  }

  /// Decides whether the given [class_] is a Python type object.
  /// Returns true, if [class_] is a Python object defined in the [types]
  /// module.
  static bool isType(ClassInstance class_) {
    final Object? classParentModule = class_.definingModule;
    if (classParentModule is! PythonModuleInterface) {
      return false;
    }
    return _isType(classParentModule);
  }

  /// Decides whether the given [class_] is a Python type object.
  /// Returns true, if [class_] is a Python object defined in the [types]
  /// module.
  static bool isInstantiatedType(InstantiatedClassInstance class_) =>
      _isType(class_.instantiatingModule);
}
