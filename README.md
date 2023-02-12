[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)

# dart_python_ffi

A Python-FFI for Dart

## Type mappings

*Stand: 2023-02-03-15-03-GMT+1*

| Dart type   | Python type | dart ➞ python     | python ➞ dart     |
|-------------|-------------|-------------------|-------------------|
| `null`      | `None`      | ✅ complete        | ✅ complete        |
| `bool`      | `bool`      | ✅ complete        | ✅ complete        |
| `int`       | `int`       | ✅ complete        | ✅ complete        |
| `double`    | `float`     | ✅ complete        | ✅ complete        |
| `String`    | `str`       | ✅ complete        | ✅ complete        |
| `String`    | `bytes`     | 🚫 not applicable | ✅ complete        |
| `Uint8List` | `bytes`     | ❌ missing         | 🚫 not applicable |
| `Map`       | `dict`      | ✅ complete        | ✅ complete        |
| `List`      | `list`      | ✅ complete        | ✅ complete        |
| `Set`       | `set`       | ✅ complete        | ✅ complete        |
| `Iterable`  | `Iterable`  | ❌ missing         | ❌ missing         |
| `Function`  | `Callable`  | ❌ missing         | ❌ missing         |

## Package status

| status indicator | description                                                    |
|------------------|----------------------------------------------------------------|
| ❇️               | package is intended to be consumed directly by package clients |
| ⚠️               | package requires a flutter environment                         |
| 🚫               | package is intended as internal package only                   |

| package name                  | status | description                                                                                         |
|-------------------------------|--------|-----------------------------------------------------------------------------------------------------|
| python_ffi                    | ❇️⚠️   | A Python-FFI for Dart, intended for use in a Flutter project.                                       |
| python_ffi_dart               | ❇️     | A Python-FFI for Dart, intended for dart-only applications outside of a Flutter project.            |
| python_ffi_macos              | ⚠️🚫   | The macOS implementation of python_ffi, a Python-FFI for Dart.                                      |
| python_ffi_macos_dart         | 🚫     | The macOS implementation of python_ffi_dart, a Python-FFI for Dart.                                 |
| python_ffi_platform_interface | 🚫     | The platform interface for python_ffi, a Python-FFI for Dart.                                       |
| python_ffi_interface          | 🚫     | A base interface for python_ffi_dart, a Python-FFI for Dart.                                        |
| python_ffi_lint               |        | Analysis options used across the Python-FFI for Dart project.                                       |
| python_ffi_dart_example       |        | The example command line application showcasing the python_ffi_dart package, a Python-FFI for Dart. |
| python_ffi_bundler            |        |                                                                                                     |

## Package graph

```
              python_ffi_dart_example
                                    │
python_ffi            python_ffi_dart
│   │                           │   │
│   python_ffi_macos            │   │
│   │          │                │   │
│   │       python_ffi_macos_dart   │
│   │                           │   │
python_ffi_platform_interface   │   │
                     │          │   │
                 python_ffi_interface

python_ffi_lint
```

## Limitations

- Python `print` is not supported when used in a Flutter environment.
- Requires Python 3.11 to be installed on the host system.
