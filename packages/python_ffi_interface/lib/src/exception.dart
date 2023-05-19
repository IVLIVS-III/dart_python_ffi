part of python_ffi_interface;

/// Base class for all Exceptions thrown by the Python FFI.
///
/// It is **NOT** a representation of a Python exception.
base class PythonFfiException implements Exception {
  /// Creates a new [PythonFfiException].
  PythonFfiException(this.message);

  /// The message of the exception.
  final String message;

  @override
  String toString() => "PythonFfiException: $message";
}

/// Thrown when an attribute is accessed that does not exist on the underlying
/// Python object.
final class UnknownAttributeException extends PythonFfiException {
  /// Creates a new [UnknownAttributeException].
  UnknownAttributeException(this.attributeName)
      : super("Failed to get attribute '$attributeName'");

  /// The name of the attribute that was accessed.
  final String attributeName;
}

/// Abstract base class for any Dart representation of a Python exception.
abstract base class PythonExceptionInterface<P extends PythonFfiDelegate<R>,
        R extends Object?> extends PythonObjectInterface<P, R>
    implements Exception {
  /// Creates a new Python exception.
  PythonExceptionInterface(
    super.delegate,
    super.reference, {
    required super.initializer,
    required super.finalizer,
  });

  /// Gets the type of the exception.
  String get type;

  /// Gets the value of the exception.
  Object? get value;

  /// Gets the traceback of the exception.
  Object? get traceback;

  @override
  String toString() {
    final StringBuffer buffer = StringBuffer("PythonException($type)");
    if (value != null) {
      buffer.write(": $value");
    }
    if (traceback != null) {
      buffer.write("at $traceback");
    }
    buffer.writeln();
    return buffer.toString();
  }
}
