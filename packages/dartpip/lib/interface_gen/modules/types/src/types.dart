// ignore_for_file: non_constant_identifier_names

part of types;

final class types extends PythonModule {
  types.from(super.moduleDelegate) : super.from();

  static types import() => PythonFfiDart.instance.importModule(
        "types",
        types.from,
      );

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
