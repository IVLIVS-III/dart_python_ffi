## 0.4.2

- Increased robustness of downloading Python runtime and stdlib.

## 0.4.1

- Made locking thread-safe while downloading Python runtime and stdlib.
- Updated dependencies.

## 0.4.0

- Refactored to make use of Dart 3.x record types.
- Increased robustness of file-hash validation.
- Increased robustness of downloading Python runtime and stdlib.
- Fixed path issues on Windows.
- Fixed initialization of Python runtime on Windows.
- Added special case for converting Python Class Definitions.
- Fixed
  [Bundling Python modules with external package](https://github.com/IVLIVS-III/dart_python_ffi/issues/10)
  .
- Updated dependencies.

## 0.3.1

- Regenerated Python C-API bindings with all Python header files.
- Made Python runtime initialization more robust.
- On macOS, the Python runtime is now downloaded and cached if the `libPath` parameter is not
  specified.
- The Python stdlib is now downloaded and cached.

## 0.3.0+1

- Declared support for Windows and Linux.

## 0.3.0

- Updated to Dart 3.x.
- On Windows and Linux the `libPath` parameter is now required, since the dynamic Python library is
  no longer included in the package as this drastically reduces package size and initialization
  time.
- Fixed an issue with loading python modules.
- Updated dependencies.

## 0.2.2

- Fixed an issue with clearing the Python modules cache on initialization if the cache was empty.

## 0.2.1

- Python modules cache is now cleared on initialization.

## 0.2.0

- Added support for Linux.

## 0.1.0

- Added support for Windows.

## 0.0.3

- Added a Type conversion from Dart `ffi.Pointer<Never>` (`nullptr`) to Python `None`.
- Updated dependencies.

## 0.0.2

- Fixed an issue with loading multi-file modules containing multi-file submodules.

## 0.0.1

- Initial version.
