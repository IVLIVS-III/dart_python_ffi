part of python_ffi_interface;

class PythonFfiException implements Exception {
  PythonFfiException(this.message);

  final String message;

  @override
  String toString() => "PythonFfiException: $message";
}

class UnknownAttributeException extends PythonFfiException {
  UnknownAttributeException(this.attributeName)
      : super("Failed to get attribute '$attributeName'");

  final String attributeName;
}

abstract class PythonExceptionInterface<P extends PythonFfiDelegate<R>,
R extends Object?> extends PythonObjectInterface<P, R>
    implements Exception {
  PythonExceptionInterface(super.delegate, super.reference);

  String get type;

  Object? get value;

  Object? get traceback;

  // TODO: provide a better implementation
  @override
  String toString() => "PythonExceptionInterface";
}
