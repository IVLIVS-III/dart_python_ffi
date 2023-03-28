# python_ffi_dart

[![pub package](https://img.shields.io/pub/v/python_ffi_dart.svg)](https://pub.dev/packages/python_ffi_dart)

A Python-FFI for Dart.

Easily import any pure Python module into your Dart or Flutter project.

## Getting Started

This package is intended to be used in a Dart console project, for Flutter apps
see [`python_ffi`](https://pub.dev/packages/python_ffi).

Detailed instructions on how to use this package can be
found [here](https://github.com/IVLIVS-III/dart_python_ffi/#readme).

See also the [example project](./example) for a working example.

## Limitations

This package expects the Python dynamic library (Python 3.11) to be installed on the system in the
default location (`"/Library/Frameworks/Python.framework/Versions/3.11/Python"`). You can override
this by specifying `libpath` when calling `PythonFfiDart.instance.initialize()`. 
