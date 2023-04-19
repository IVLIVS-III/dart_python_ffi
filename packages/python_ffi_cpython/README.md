# python_ffi_cpython

[![pub package](https://img.shields.io/pub/v/python_ffi_cpython.svg)](https://pub.dev/packages/python_ffi_cpython)

MacOS, Windows and Linux implementation of the [`python_ffi`](https://pub.dev/packages/python_ffi) plugin.
As such, this package is compatible with Flutter apps.

## Development of this package

### Preparing the dylib for bundled distribution

1. Put it somewhere in the `macos` folder, and add the path to `s.vendored_libraries`
   in `macos/python_ffi_cpython.podspec`.
2. Rename the dylib to `libpython3.11.dylib` (or whatever version you're using).
3. Run `install_name_tool -id @rpath/libpython3.11.dylib libpython3.11.dylib`
