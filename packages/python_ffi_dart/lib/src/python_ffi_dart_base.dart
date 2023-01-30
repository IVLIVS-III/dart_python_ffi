// TODO: Put public facing types in this file.
part of python_ffi_dart;

abstract class PythonFfiBase {
  String get name;
}

class PythonFfiDart extends PythonFfiBase with PythonFfiMixin {
  PythonFfiDart._();

  static PythonFfiDart? _instance;

  // ignore: prefer_constructors_over_static_methods
  static PythonFfiDart get instance {
    _instance ??= PythonFfiDart._();
    return _instance!;
  }

  @override
  String get name => "PythonFfiDart";

  FutureOr<void> initialize() {
    if (Platform.isMacOS) {
      PythonFfiPlatform.instance = PythonFfiMacOSDart();
      return PythonFfiPlatform.instance.initialize();
    }

    // TODO: implement for other platforms
    throw UnsupportedError(
      "Python is not supported on ${Platform.operatingSystem}.",
    );
  }
}

mixin PythonFfiMixin on PythonFfiBase {
  FutureOr<void> prepareModule(PythonModuleDefinition moduleDefinition) async {
    await PythonFfiPlatform.instance.prepareModule(moduleDefinition);
    moduleDefinition.classNames.registerClassNames();
  }

  void addClassName(String className) =>
      PythonFfiPlatform.instance.addClassName(className);

  void removeClassName(String className) =>
      PythonFfiPlatform.instance.removeClassName(className);

  void _ensureInitialized() {
    if (!PythonFfiPlatform.instance.isInitialized) {
      throw PythonFfiException(
        "$name is not initialized. Call `$name.instance.initialize()` before using it.",
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
