// ignore_for_file: non_constant_identifier_names
import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:python_ffi_dart/python_modules/src/python_ffi.py.dart"
    as python_ffi_py;

class PythonFfiAwaitable<T extends Object?> extends PythonClass {
  factory PythonFfiAwaitable(
    PythonFfiAwaitableInterface<T, PythonFfiDelegate<Object?>, Object?>
        awaitableInterface,
  ) {
    final PythonFfiAwaitable<T> awaitable = PythonFfiDart.instance.importClass(
      "python_ffi",
      "PythonFfiAwaitable",
      PythonFfiAwaitable<T>.from,
      <Object?>[awaitableInterface.isDone, awaitableInterface.result],
    );
    return awaitable;
  }

  PythonFfiAwaitable.from(super.pythonClass) : super.from();
}

class PythonFfiModule extends PythonModule {
  PythonFfiModule.from(super.pythonModule) : super.from();

  static PythonFfiModule import() => PythonFfiDart.instance.importModule(
        "python_ffi",
        PythonFfiModule.from,
      );

  static PythonModuleDefinition get definition => PythonModuleDefinition(
        name: "python_ffi",
        root: SourceBase64("python_ffi.py", python_ffi_py.kBase64),
        classNames: <String>[
          "PythonFfiAwaitable",
        ],
      );
}
