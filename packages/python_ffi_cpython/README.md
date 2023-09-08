# python_ffi_cpython

[![pub package](https://img.shields.io/pub/v/python_ffi_cpython.svg)](https://pub.dev/packages/python_ffi_cpython)

MacOS, Windows and Linux implementation of the [`python_ffi`](https://pub.dev/packages/python_ffi)
plugin. As such, this package is compatible with Flutter apps.

## Development of this package

### Preparing the dylib for bundled distribution

1. On macOS, install `pkg-config` on your system: `brew install pkg-config`.
2. Run `dart run scripts/bin/scripts.dart cpython all` to compile the Python dynamic library for the
   current platform. This creates a `cpython` folder in the root of this package with the compiled
   dynamic library (`libpython<version>.dylib` / `libpython<version>.so`).
3. Copy the dynamic library to the `macos`, `windows` or `linux` folder, depending on the platform
   you're targeting.

### Extra steps on macOS

1. Add the path to the dynamic library (inside the `macos` folder) to `s.vendored_libraries`
   in `macos/python_ffi_cpython.podspec`.
