part of python_ffi_dart;

extension PythonClassNameRegisterExtension on Iterable<String> {
  void registerClassNames() {
    for (final String classname in this) {
      PythonFfiDart.instance.addClassName(classname);
    }
  }
}
