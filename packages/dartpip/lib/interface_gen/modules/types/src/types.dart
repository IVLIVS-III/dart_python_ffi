// ignore_for_file: non_constant_identifier_names, camel_case_types

part of types;

/// TODO: Document.
final class types extends PythonModule {
  /// TODO: Document.
  types.from(super.moduleDelegate) : super.from();

  /// TODO: Document.
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

  /// TODO: Document.
  static bool isType(ClassInstance class_) {
    final Object? classParentModule = class_.definingModule;
    if (classParentModule is! PythonModuleInterface) {
      return false;
    }
    return _isType(classParentModule);
  }

  /// TODO: Document.
  static bool isInstantiatedType(InstantiatedClassInstance class_) =>
      _isType(class_.instantiatingModule);
}
