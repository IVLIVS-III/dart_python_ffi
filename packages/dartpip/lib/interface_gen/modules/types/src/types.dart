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

  /// TODO: Document.
  static bool isType(ClassInstance class_) {
    final types typesModule = types.import();
    final ReferenceEqualityWrapper typesModuleWrapper =
        ReferenceEqualityWrapper(typesModule);
    final Object? classParentModule = class_.parentModule;
    if (classParentModule is! PythonModuleInterface) {
      return false;
    }
    final ReferenceEqualityWrapper classParentModuleWrapper =
        ReferenceEqualityWrapper(classParentModule);
    if (classParentModuleWrapper != typesModuleWrapper) {
      return false;
    }
    // TODO: make this more robust
    return true;
  }
}
