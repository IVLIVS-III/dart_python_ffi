part of python_ffi_interface;

class PythonFfiException implements Exception {
  PythonFfiException(this.message);

  final String message;

  @override
  String toString() => "PythonFfiException: $message";
}

abstract class PythonExceptionInterface<P extends PythonFfiDelegate<R>,
R extends Object?> extends PythonObjectInterface<P, R> implements Exception {
  PythonExceptionInterface(super.delegate, super.reference);

  // TODO: provide a better implementation
  @override
  String toString() => "PythonExceptionInterface";
}
