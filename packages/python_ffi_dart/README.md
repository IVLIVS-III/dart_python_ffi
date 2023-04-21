# python_ffi_dart

[![pub package](https://img.shields.io/pub/v/python_ffi_dart.svg)](https://pub.dev/packages/python_ffi_dart)

A Python-FFI for Dart.

Easily import any pure Python module into your Dart or Flutter project.

## Getting Started

*Note: This package is intended to be used in a Dart console project, for Flutter apps
see [`python_ffi`](https://pub.dev/packages/python_ffi).*

**Detailed instructions on how to use this package can be
found in the [documentation](https://github.com/IVLIVS-III/dart_python_ffi/#readme).**

See also the [`dartpip`](https://pub.dev/packages/dartpip) package for an easy way to add Python
modules to your project.

See also the [example project](./example) for a working example.

## Limitations

On macOS this package expects the Python dynamic library (Python 3.11) to be installed on the system
in the default location (`"/Library/Frameworks/Python.framework/Versions/3.11/Python"`). You can
override this by specifying `libpath` when calling `PythonFfiDart.instance.initialize()`.

On Linux this package expects `python3.11` to be installed on the system and available in the PATH,
e.g. by installing the `python3.11` package. The Python dynamic library is bundled with the package,
you can use a local copy by specifying `libpath` when calling `PythonFfiDart.instance.initialize()`.
