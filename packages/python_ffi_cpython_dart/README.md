# python_ffi_cpython_dart

[![pub package](https://img.shields.io/pub/v/python_ffi_cpython_dart.svg)](https://pub.dev/packages/python_ffi_cpython_dart)

MacOS, Windows and Linux implementation of
the [`python_ffi_dart`](https://pub.dev/packages/python_ffi_dart) plugin. As such, this package is
compatible with pure Dart console apps.

## Limitations

On macOS, this package requires the Python dynamic library (Python 3.11) to be installed on the
system in `/Library/Frameworks/Python.framework/Versions/3.11/Python` or the `libPath` parameter
must be provided.

On Windows and Linux, the `libPath` parameter must be provided.
