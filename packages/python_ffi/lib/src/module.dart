part of python_ffi;

abstract base class PythonModule extends python_ffi_dart.PythonModule {
  PythonModule.from(super.moduleDelegate) : super.from();

  static T import<T extends PythonModule>(
    String moduleName,
    PythonModuleFrom<T> from,
  ) =>
      PythonFfi.instance.importModule(moduleName, from);
}
