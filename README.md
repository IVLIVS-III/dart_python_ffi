[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)

# dart_python_ffi

A Python-FFI for Dart.

Easily import any pure Python module into your Dart or Flutter project.

| Platform | Status            |
|----------|-------------------|
| macOS    | supported (beta)  |
| Windows  | supported (alpha) |
| Linux    | supported (alpha) |

## Table of Contents

1. [Motivation](#motivation)
2. [Getting started](#getting-started)
    1. [Repository overview](#repository-overview)
    2. [Adding Python modules](#adding-python-modules)
    3. [Creating a Module-definition in Dart](#creating-a-module-definition-in-dart)
    4. [Creating a Class-definition in Dart](#creating-a-class-definition-in-dart)
    5. [Initializing the Python runtime](#initializing-the-python-runtime)
        1. [Using the Flutter package (`python_ffi`)](#using-the-flutter-package-python_ffi)
        2. [Using the Dart package (`python_ffi_dart`)](#using-the-dart-package-python_ffi_dart)
    6. [Using the Python module](#using-the-python-module)
3. [Examples](#examples)
    1. [Basic CLI adder](#importing-your-first-python-module)
    2. [Basic dataclass](#importing-a-python-module-with-a-custom-python-class)
    3. [Importing a Python module from pypi](#importing-a-python-module-from-pypi)
    4. [Converting all supported types between Dart and Python](#converting-all-supported-types-between-dart-and-python)
    5. [Importing multiple Python modules in a Flutter app](#importing-multiple-python-modules-in-a-flutter-app)
    6. [Importing incomplete Python modules in a Flutter app (creating an incomplete Class-definition)](#importing-incomplete-python-modules-in-a-flutter-app-creating-an-incomplete-class-definition)
4. [Type mappings](#type-mappings)
5. [Package status](#package-status)
6. [Usage](#usage)
    1. [`dartpip`](#dartpip)
    2. [`python_ffi_dart_example`](#python_ffi_dart_example)
7. [Package graph](#package-graph)
8. [Limitations](#limitations)
9. [Roadmap](#roadmap)
10. [About this project](#about-this-project)
11. [Contributing](#contributing)

## Motivation

This repository provides multiple Dart and Flutter packages to achieve the goal of seamlessly
importing any pure Python package into your Dart or Flutter project.

But why would you want to do that?

Python is a very popular programming language with a huge ecosystem of modules. While growing, the
Dart ecosystem is still far behind. This repository aims to bridge the gap between the two
ecosystems by providing a way to use Python modules in Dart and Flutter projects.

Yes, the result will be probably slower than a native Dart implementation, but it will be better
than nothing. In most use cases this will be more than enough. And if you need more performance,
you can always write a native Dart implementation of the Python module.

## Getting started

### Repository overview

There are three packages intended to be consumed by Dart or Flutter project developers:

- [`dartpip`](./packages/dartpip/README.md): A CLI to add Python modules to your Dart / Flutter
  project, like pip for Python.
    - Can be installed globally on your system or as dev-dependency in your Dart / Flutter project.
- [`python_ffi`](./packages/python_ffi/README.md): A Python-FFI for Dart, intended for use in a
  Flutter project.
    - Must be installed as an ordinary dependency in your Flutter project.
- [`python_ffi_dart`](./packages/python_ffi_dart/README.md): A Python-FFI for Dart, intended for
  Dart-only applications outside of a Flutter project.
    - Must be installed as an ordinary dependency in your Dart project.

### Adding Python modules

You can use `dartpip` to add any pure Python module to your Dart or Flutter project. It is like pip
for Python projects or like pub for Dart / Flutter packages.

See [`dartpip`/Readme.md](./packages/dartpip/README.md#usage) for detailed instructions on how to
install and use this package. Basic usage will be as follows:

```shell
$ dart pub global activate dartpip
$ dartpip install <package>
```

*Note: the `install` command is not available yet, use `bundle` instead.*

### Creating a Module-definition in Dart

A Module-definition in Dart is necessary to consume your imported Python module. The
Module-definition provides a type-safe interface of the imported Python module mapped to Dart types.
It must be created for every Python module that should be directly accessible for your Dart /
Flutter application.

It is a `class` extending `PythonModule`, which is exposed both by `python_ffi`
and `python_ffi_dart`.

The constructor and static function `import` are necessary boilerplate to be able to access the
Python module from your Dart code.

Every other method, getter, and setter should map to public top-level functions and variables in the
respective Python module.

If your Python module includes custom Python classes, you should provide a Class-definition for each
Python class.

You are free to rename the functions, getters, setters, and function-arguments to prevent them from
being private in Dart or to match your Dart case-style.

In the example below, the argument `json_string` has been renamed to `jsonString` to match
camel-case and the variable `__all__` has been renamed to `all__` to prevent it from being a private
getter / setter.

```dart
import "package:python_ffi/python_ffi.dart";

class JsonParserModule extends PythonModule {
  JsonParserModule.from(super.pythonModule) : super.from();

  static JsonParserModule import() =>
      PythonModule.import(
        "json_parser",
        JsonParserModule.from,
      );

  Object? parse(String jsonString) =>
      getFunction("parse").call(<Object?>[jsonString]);

  List<Object?> get all__ => List<Object?>.from(getAttribute("__all__"));

  set all__(List<Object?> value) => setAttribute("__all__", value);
}
```

You can also model submodules by creating two Module-definitions and providing a getter in the
parent module:

```dart
import "package:python_ffi/python_ffi.dart";

class LiblaxParserModule extends PythonModule {
  LiblaxParserModule.from(super.pythonModule) : super.from();

  static LiblaxParserModule import() =>
      PythonModule.import(
        "liblax.parser",
        LiblaxParserModule.from,
      );

  String run(String data) =>
      getFunction("run").call(<Object?>[data]).toString();
}

class LiblaxModule extends PythonModule {
  LiblaxModule.from(super.pythonModule) : super.from();

  static LiblaxModule import() =>
      PythonModule.import(
        "liblax",
        LiblaxModule.from,
      );

  LiblaxParserModule get parser => LiblaxParserModule.import();
}
```

### Creating a Class-definition in Dart

A Class-definition in Dart is necessary to consume your imported Python class. The Class-definition
provides a type-safe interface of the imported Python class mapped to Dart types, creating a new
Dart type in the process. It must be created for every Python class that should be directly
accessible for your Dart / Flutter application.

It is a `class` extending `PythonClass`, which is exposed both by `python_ffi` and `python_ffi_dart`
.

The factory constructor is necessary boilerplate to be able to create a new instance of the Python
class from your Dart code.

Every other method, getter, and setter should map to public methods and properties in the respective
Python class.

You are free to rename the methods, getters, setters, and method-arguments to prevent them from
being private in Dart or to match your Dart case-style.

You can also override the `toString` method to provide a custom value. If you choose not to, the
Python method `__str__` will be invoked, if available.

```dart
import "package:python_ffi/python_ffi.dart";

class Coordinate extends PythonClass {
  factory Coordinate(double latitude, double longitude) {
    final Coordinate coordinate = PythonFfi.instance.importClass(
      "structs",
      "Coordinate",
      Coordinate.from,
      <Object?>[latitude, longitude],
    );
    return coordinate;
  }

  Coordinate.from(super.pythonClass) : super.from();

  double get latitude => getAttribute("latitude");

  double get longitude => getAttribute("longitude");

  @override
  String toString() => "Coordinate(latitude: $latitude, longitude: $longitude)";
}
```

If some Python function returns an instance of your Python class, you can use the `from` constructor
to create a new Dart instance from the Python instance:

```dart
import "package:python_ffi/python_ffi.dart";

class GeocodingModule extends PythonModule {
  GeocodingModule.from(super.pythonModule) : super.from();

  static GeocodingModule import() =>
      PythonModule.import(
        "geocoding",
        GeocodingModule.from,
      );

  Coordinate geocode(String address) =>
      Coordinate.from(getFunction("geocode").call(<Object?>[address]));
}
```

### Initializing the Python runtime

To use the Python-FFI, you must initialize the Python runtime first. This is done by calling
the following as soon as possible (i.e. in your `main` function) in your Dart / Flutter application:

#### Using the Flutter package (`python_ffi`)

```dart
import "package:flutter/material.dart";
import "package:python_ffi/python_ffi.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PythonFfi.instance.initialize();
  // ...
}
```

Make sure to call `WidgetsFlutterBinding.ensureInitialized()` before initializing the Python
runtime.

#### Using the Dart package (`python_ffi_dart`)

```dart
import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:<package_name>/python_modules/src/python_modules.g.dart";

void main() async {
  await PythonFfiDart.instance.initialize(kPythonModules);
  // ...
}
```

You need to provide the `kPythonModules` constant from the generated file. This constant contains
all necessary data for loading the bundled Python modules. In Flutter apps, this data is loaded from
assets in well-known locations. In Dart apps, there is no equivalent concept of assets.

You can optionally provide a `libPath` if you want to load the Python library from a custom
location:

```dart
import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:<package_name>/python_modules/src/python_modules.g.dart";

void main() async {
  await PythonFfiDart.instance.initialize(
    kPythonModules,
    libPath: "path/to/libpython3.11.dylib",
  );
  // ...
}
```

### Using the Python module

After initializing the Python runtime, you can import your Python module and use it in your Dart
code:

```dart
import "package:<package_name>/python_modules/json_parser.dart";

final JsonParserModule jsonParser = JsonParserModule.import();
final Object? parsedJson = jsonParser.parse('{"Hello": "World"}');

print(parsedJson);
```

## Examples

This list of examples covers progressively more complex use-cases. If you want to get an idea of how
to use the Python-FFI, start with the first example and work your way through the list.

### Importing your first Python module

See [`basic_cli_adder`](packages/examples/basic_cli_adder/README.md).

### Importing a Python module with a custom Python class

See [`basic_dataclass`](packages/examples/basic_dataclass/README.md).

### Importing a Python module from pypi

See [`pytimeparse_dart`](packages/examples/pytimeparse_dart/README.md).

### Converting all supported types between Dart and Python

See the [`python_ffi_dart` example](packages/python_ffi_dart/example/README.md).

### Importing multiple Python modules in a Flutter app

See the [`python_ffi` example](packages/python_ffi/example/README.md).

### Importing incomplete Python modules in a Flutter app (creating an incomplete Class-definition)

See [`fj_playground`](packages/examples/fj_playground/README.md).

## Type mappings

Types will be converted automatically according to the following table:

| Dart type     | Python type | dart ➞ python     | python ➞ dart     |
|---------------|-------------|-------------------|-------------------|
| `null`        | `None`      | ✅ complete        | ✅ complete        |
| `bool`        | `bool`      | ✅ complete        | ✅ complete        |
| `int`         | `int`       | ✅ complete        | ✅ complete        |
| `double`      | `float`     | ✅ complete        | ✅ complete        |
| `String`      | `str`       | ✅ complete        | ✅ complete        |
| `Uint8List`   | `bytes`     | ✅ complete        | ✅ complete        |
| `Map`         | `dict`      | ✅ complete        | ✅ complete        |
| `List`        | `list`      | ✅ complete        | ✅ complete        |
| `List`        | `tuple`     | 🚫 not applicable | ✅ complete        |
| `PythonTuple` | `tuple`     | ✅ complete        | 🚫 not applicable |
| `Set`         | `set`       | ✅ complete        | ✅ complete        |
| `Iterator`    | `Iterator`  | ✅ complete        | ✅ complete        |
| `Iterator`    | `Generator` | 🚫 not applicable | ✅ complete        |
| `Iterable`    | `Iterable`  | ✅ complete        | ✅ complete        |
| `Function`    | `Callable`  | ✅ complete        | ✅ complete        |
| `Future`      | `Awaitable` | ❌ missing         | ❌ missing         |
| `Exception`   | `Exception` | ❌ missing         | ✅ complete        |

Anything else will be converted from Python to a `PythonObject` in Dart. It is supported to cast
this value to `dynamic` and invoke any method or property on it. It will work, as long as the method
or property is available in Python.

At the moment it is not possible to convert arbitrary Dart classes (not backed by a subtype
of `PythonClass`) to Python objects. Trying to do so will result in a runtime exception.

*Note: Only exceptions throw in Python are converted to a Dart `Exception` and not vice-versa. The
only possible way in which you would want Python code to catch an exception thrown in Dart would be
when passing a Dart callback to Python, that throws said exception. This seems to be an uncommon
case.*

## Package status

| package name                                                                            | version                                                                                                                                  | status | description                                                                              |
|-----------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|--------|------------------------------------------------------------------------------------------|
| [dartpip](https://pub.dev/packages/dartpip)                                             | [![pub package](https://img.shields.io/pub/v/dartpip.svg)](https://pub.dev/packages/dartpip)                                             | 🟩     | Add Python modules (packages) to your Dart or Flutter project.                           |
| [python_ffi](https://pub.dev/packages/python_ffi)                                       | [![pub package](https://img.shields.io/pub/v/python_ffi.svg)](https://pub.dev/packages/python_ffi)                                       | 🟩🟦   | A Python-FFI for Dart, intended for use in a Flutter project.                            |
| [python_ffi_dart](https://pub.dev/packages/python_ffi_dart)                             | [![pub package](https://img.shields.io/pub/v/python_ffi_dart.svg)](https://pub.dev/packages/python_ffi_dart)                             | 🟩     | A Python-FFI for Dart, intended for Dart-only applications outside of a Flutter project. |
| [python_ffi_cpython](https://pub.dev/packages/python_ffi_cpython)                       | [![pub package](https://img.shields.io/pub/v/python_ffi_cpython.svg)](https://pub.dev/packages/python_ffi_cpython)                       | 🟥🟦   | The macOS, Windows and Linux implementation of `python_ffi`, a Python-FFI for Dart.      |
| [python_ffi_cpython_dart](https://pub.dev/packages/python_ffi_cpython_dart)             | [![pub package](https://img.shields.io/pub/v/python_ffi_cpython_dart.svg)](https://pub.dev/packages/python_ffi_cpython_dart)             | 🟥     | The macOS, Windows and Linux implementation of `python_ffi_dart`, a Python-FFI for Dart. |
| [python_ffi_platform_interface](https://pub.dev/packages/python_ffi_platform_interface) | [![pub package](https://img.shields.io/pub/v/python_ffi_platform_interface.svg)](https://pub.dev/packages/python_ffi_platform_interface) | 🟥🟦   | The platform interface for `python_ffi`, a Python-FFI for Dart.                          |
| [python_ffi_interface](https://pub.dev/packages/python_ffi_interface)                   | [![pub package](https://img.shields.io/pub/v/python_ffi_interface.svg)](https://pub.dev/packages/python_ffi_interface)                   | 🟥     | A base interface for `python_ffi_dart`, a Python-FFI for Dart.                           |
| [python_ffi_lint](https://pub.dev/packages/python_ffi_lint)                             | [![pub package](https://img.shields.io/pub/v/python_ffi_lint.svg)](https://pub.dev/packages/python_ffi_lint)                             | 🟥     | Analysis options used across the Python-FFI for Dart project.                            |
| [python_ffi_lint_dart](https://pub.dev/packages/python_ffi_lint_dart)                   | [![pub package](https://img.shields.io/pub/v/python_ffi_lint_dart.svg)](https://pub.dev/packages/python_ffi_lint_dart)                   | 🟥     | Analysis options used across the Python-FFI for Dart project.                            |

| status indicator | description                                                    |
|------------------|----------------------------------------------------------------|
| 🟩               | package is intended to be consumed directly by package clients |
| 🟦               | package requires a flutter environment                         |
| 🟥               | package is intended as internal package only                   |

## Usage

### `dartpip`

See [dartpip](/packages/dartpip/README.md) for more details.

The following is only relevant when contributing:

#### Compile & run AOT

```shell
melos compile-dartpip
bin/dartpip --help
```

#### Run JIT

```shell
dart run packages/dartpip/bin/dartpip.dart --help
```

### `python_ffi_dart_example`

#### Compile & run AOT

```shell
melos compile-example
bin/example --help
```

#### Run JIT

```shell
dart run packages/python_ffi_dart_example/bin/python_ffi_dart_example.dart --help
```

## Package graph

`python_ffi_lint` is a simple utility package that contains analysis options used across the
Python-FFI for Dart project.

`dartpip` is a CLI to add Python modules to your Dart / Flutter project, like pip for Python. It is
a package intended to be consumed directly by package developers as a dev-dependency.

All other packages in the graph below implement the necessary runtime functionality to make the
Python FFI work. They follow
the [federated plugins](https://docs.flutter.dev/development/packages-and-plugins/developing-packages#federated-plugins)
architecture `python_ffi` and `python_ffi_dart` are intended to be consumed directly by package
clients as a dependency. `python_ffi_dart/example` and `python_ffi/example` are example projects
used for developing, testing and showcasing the Python FFI.

```
┌─────────────────────────────────────────┐
│  python_ffi            python_ffi_dart  │
│  │   │                           │   │  │
│  │   python_ffi_cpython          │   │  │
│  │   │          │                │   │  │
│  │   │     python_ffi_cpython_dart   │  │
│  │   │                           │   │  │
│  python_ffi_platform_interface   │   │  │
│                       │          │   │  │
│                   python_ffi_interface  │
└─────────────────────────────────────────┘       dartpip
                                       │             │
                                       python_ffi_lint
                                              │
                                  python_ffi_lint_dart
```

## Limitations

- Python `print` is not supported when used in a Flutter environment.

## Roadmap

Dartpip does not include the dependencies of the imported Python modules yet. This should be
resolved.

Dart Module / Class-definitions for imported Python modules should be either auto-generated or
infered on runtime via reflection / meta-programming.

## About this project

This project started out as a bachelors project / bachelors thesis.

## Contributing

Contributions are welcome after I finished my bachelors thesis involving this project. Until then, I
will develop this on my own.
