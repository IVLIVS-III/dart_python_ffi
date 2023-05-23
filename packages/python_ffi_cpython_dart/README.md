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

## Development

To allow for use of this package even when the Python dynamic library is not installed on the
target system, the Python dynamic library is loaded and cached by the package.

### Windows

On Windows, we can just download and copy the dll to the cache directory.

### Linux

On Linux, we can just download and copy the so to the cache directory.

### macOS

On macOS, wen need to download a signed dylib which we can then download and copy to the cache
directory. Since we build and provide our custom-tailored Python distribution, we need to sign the
dylib ourselves.

#### Signing the dylib

Requirements:

- A valid Apple Developer ID certificate
    - You can check if you have one by running `security find-identity -v -p codesigning`

Command:

```shell
codesign --force --timestamp --sign <name of certificate> /path/to/libpython3.11.dylib
```

Validation:

```shell
codesign --verify -vvvv /path/to/libpython3.11.dylib
```
