part of python_ffi;

class PythonFfi {
  PythonFfi._();

  static PythonFfi? _instance;

  // ignore: prefer_constructors_over_static_methods
  static PythonFfi get instance {
    _instance ??= PythonFfi._();
    return _instance!;
  }

  FutureOr<void> initialize() async =>
      await PythonFfiPlatform.instance.initialize();

  FutureOr<void> prepareModule(PythonModuleDefinition moduleDefinition) async =>
      await PythonFfiPlatform.instance.prepareModule(moduleDefinition);

  void addClassName(String className) =>
      PythonFfiPlatform.instance.addClassName(className);

  void removeClassName(String className) =>
      PythonFfiPlatform.instance.removeClassName(className);

  void _ensureInitialized() {
    if (!PythonFfiPlatform.instance.isInitialized) {
      throw PythonFfiException(
        "PythonFfi is not initialized. Call `PythonFfi.instance.initialize()` before using it.",
      );
    }
  }

  T importModule<T extends PythonModule>(
    String name,
    PythonModuleFrom<T> from,
  ) {
    _ensureInitialized();
    return from(PythonFfiPlatform.instance.importModule(name));
  }

  T importClass<T extends PythonClass>(
    String moduleName,
    String className,
    PythonClassFrom<T> from,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) {
    _ensureInitialized();
    // TODO: integrate pythonClassType properly
    return from(
      PythonFfiPlatform.instance
          .importClass(moduleName, className, args, kwargs),
    );
  }

  Future<void> appendToPath(String path) async {
    _ensureInitialized();
    await PythonFfiPlatform.instance.appendToPath(path);
  }
}
