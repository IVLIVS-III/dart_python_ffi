part of python_ffi_interface;

/// Signature of a Dart function that can be called from Python.
typedef DartCFunctionSignature = Object? Function(
  Object? self,
  List<Object?> args,
);

/// Extension to convert a generic Dart function to a Funtion that can be called
/// from Python.
extension GenericExtension on Function {
  /// Converts a generic Dart function with 0 positional arguments to a function
  /// that can be called from Python.
  DartCFunctionSignature get generic0 =>
      // ignore: avoid_dynamic_calls
      (Object? self, List<Object?> args) => this();

  /// Converts a generic Dart function with 1 positional argument to a function
  /// that can be called from Python.
  DartCFunctionSignature get generic1 =>
      // ignore: avoid_dynamic_calls
      (Object? self, List<Object?> args) => this(args[0]);

  /// Converts a generic Dart function with 2 positional arguments to a function
  /// that can be called from Python.
  DartCFunctionSignature get generic2 =>
      // ignore: avoid_dynamic_calls
      (Object? self, List<Object?> args) => this(args[0], args[1]);

  /// Converts a generic Dart function with 3 positional arguments to a function
  /// that can be called from Python.
  DartCFunctionSignature get generic3 =>
      // ignore: avoid_dynamic_calls
      (Object? self, List<Object?> args) => this(args[0], args[1], args[2]);

  /// Converts a generic Dart function with 4 positional arguments to a function
  /// that can be called from Python.
  DartCFunctionSignature get generic4 => (Object? self, List<Object?> args) =>
      // ignore: avoid_dynamic_calls
      this(args[0], args[1], args[2], args[3]);

  /// Converts a generic Dart function with 5 positional arguments to a function
  /// that can be called from Python.
  DartCFunctionSignature get generic5 => (Object? self, List<Object?> args) =>
      // ignore: avoid_dynamic_calls
      this(args[0], args[1], args[2], args[3], args[4]);

  /// Converts a generic Dart function with 6 positional arguments to a function
  /// that can be called from Python.
  DartCFunctionSignature get generic6 => (Object? self, List<Object?> args) =>
      // ignore: avoid_dynamic_calls
      this(args[0], args[1], args[2], args[3], args[4], args[5]);
}
