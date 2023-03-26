part of python_ffi_interface;

/// A function that converts a Python function object to a Dart function.
typedef TypedFunctionConverter<T extends Function> = T Function(
  PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?>,
);

/// Abstract base class for any Dart representation of a Python function.
abstract class PythonFunctionInterface<P extends PythonFfiDelegate<R>,
    R extends Object?> extends PythonObjectInterface<P, R> {
  /// Creates a new Python function.
  PythonFunctionInterface(
    super.delegate,
    super.reference, {
    required super.initializer,
    required super.finalizer,
  });

  /// Invokes the function.
  T call<T extends Object?>(List<Object?> args, {Map<String, Object?>? kwargs});

  /// Invokes the function.
  R rawCall({List<R>? args, Map<String, R>? kwargs});

  /// Converts the function object to a Dart function.
  T asFunction<T extends Function>(TypedFunctionConverter<T> converter);
}
