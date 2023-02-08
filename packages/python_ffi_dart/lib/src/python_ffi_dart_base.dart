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
      PythonFfiDelegate.instance = PythonFfiMacOSDart();
      return PythonFfiDelegate.instance.initialize();
    }

    // TODO: implement for other platforms
    throw UnsupportedError(
      "Python is not supported on ${Platform.operatingSystem}.",
    );
  }
}

mixin PythonFfiMixin on PythonFfiBase {
  FutureOr<void> prepareModule(PythonModuleDefinition moduleDefinition) async {
    await PythonFfiDelegate.instance.prepareModule(moduleDefinition);
    moduleDefinition.classNames.registerClassNames();
  }

  void addClassName(String className) =>
      PythonFfiDelegate.instance.addClassName(className);

  void removeClassName(String className) =>
      PythonFfiDelegate.instance.removeClassName(className);

  void _ensureInitialized() {
    if (!PythonFfiDelegate.instance.isInitialized) {
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
    return from(PythonFfiDelegate.instance.importModule(name));
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
      PythonFfiDelegate.instance
          .importClass(moduleName, className, args, kwargs),
    );
  }

  Future<void> appendToPath(String path) async {
    _ensureInitialized();
    await PythonFfiDelegate.instance.appendToPath(path);
  }
}
