/// Support for doing something awesome.
///
/// More dartdocs go here.
library python_ffi_dart;

export 'src/python_ffi_dart_base.dart';

// TODO: Export any libraries intended for clients of this package.

void initialize() {
  if (kIsWeb) {
    throw UnsupportedError("Python is not supported on the web.");
  }
}
