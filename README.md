[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)

# dart_python_ffi
A Python-FFI for Dart

## Type mappings

*Stand: 2023-02-03-15-03-GMT+1*

| Dart type   | Python type | dart –> python    | python -> dart    |
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
