// TODO: Put public facing types in this file.
part of python_ffi_dart;

PythonFfiBase get pythonInstance => PythonFfiDart.instance;

abstract class PythonFfiBase {
  String get name;

  PythonFfiDelegate<Object?> get delegate;

  set delegate(PythonFfiDelegate<Object?> delegate);

  void registerClassNames(Iterable<String> classNames) {
    for (final String className in classNames) {
      addClassName(className);
    }
  }

  void addClassName(String className);
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
  PythonFfiDelegate<Object?> get delegate => PythonFfiDelegate.instance;

  @override
  set delegate(PythonFfiDelegate<Object?> delegate) {
    PythonFfiDelegate.instance = delegate;
  }

  @override
  String get name => "PythonFfiDart";

  FutureOr<void> initialize(String pythonModules) {
    if (Platform.isMacOS) {
      delegate = PythonFfiMacOSDart(pythonModules);
      return delegate.initialize();
    }

    // TODO: implement for other platforms
    throw UnsupportedError(
      "Python is not supported on ${Platform.operatingSystem}.",
    );
  }
}

mixin PythonFfiMixin on PythonFfiBase {
  FutureOr<void> prepareModule(PythonModuleDefinition moduleDefinition) async {
    await delegate.prepareModule(moduleDefinition);
    registerClassNames(moduleDefinition.classNames);
  }

  @override
  void addClassName(String className) => delegate.addClassName(className);

  void removeClassName(String className) => delegate.removeClassName(className);

  void _ensureInitialized() {
    if (!delegate.isInitialized) {
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
    return from(delegate.importModule(name));
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
      delegate.importClass(moduleName, className, args, kwargs),
    );
  }

  Future<void> appendToPath(String path) async {
    _ensureInitialized();
    await delegate.appendToPath(path);
  }
}
