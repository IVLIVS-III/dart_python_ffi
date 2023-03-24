[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)

# dart_python_ffi

A Python-FFI for Dart.

Easily import any pure Python module into your Dart or Flutter project.

## Table of Contents

1. [Motivation](#motivation)
2. [Getting started](#getting-started)
    1. [Repository overview](#repository-overview)
    2. [Adding Python modules](#adding-python-modules)
    3. [Creating a Module-definition in Dart](#creating-a-module-definition-in-dart)
    4. [Creating a Class-definition in Dart](#creating-a-class-definition-in-dart)
3. [Type mappings](#type-mappings)
4. [Package status](#package-status)
5. [Usage](#usage)
    1. [`dartpip`](#dartpip)
    2. [`python_ffi_dart_example`](#python_ffi_dart_example)
6. [Package graph](#package-graph)
7. [Limitations](#limitations)
8. [Roadmap](#roadmap)
9. [About this project](#about-this-project)
10. [Contributing](#contributing)

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

- [`dartpip`](./packages/dartpip/): A CLI to add Python modules to your Dart / Flutter project, like
  pip for Python.
    - Can be installed globally on your system or as dev-dependency in your Dart / Flutter project.
- [`python_ffi`](./packages/python_ffi/): A Python-FFI for Dart, intended for use in a Flutter
  project.
    - Must be installed as an ordinary dependency in your Flutter project.
- [`python_ffi_dart`](./packages/python_ffi_dart/): A Python-FFI for Dart, intended for dart-only
  applications outside of a Flutter project.
    - Must be installed as an ordinary dependency in your Dart project.

### Adding Python modules

You can use `dartpip` to add any pure Python module to your Dart or Flutter project. It is like pip
for Python projects or like pub for Dart / Flutter packages.

See [`dartpip`/Readme.md](./packages/dartpip/README.md) for detailed instructions on how to install
and use this package. Basic usage is as follows:

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

  List<Object?> get all => List<Object?>.from(getAttribute("all__"));

  set all(List<Object?> value) => setAttribute("all__", value);
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

The factory onstructor is necessary boilerplate to be able to create a new instance of the Python
class from your Dart code.

Every other method, getter, and setter should map to public methods and properties in the respective
Python class.

You are free to rename the methods, getters, setters, and method-arguments to prevent them from
being private in Dart or to match your Dart case-style.

You can also override the `toString` method to provide a custom value. If you choose not to, the
python method `__str__` will invoked, if available.

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

#### Using the Dart package (`python_ffi_dart`)

**TODO**

### Using the Python module

**TODO**

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

## Package status

| status indicator | description                                                    |
|------------------|----------------------------------------------------------------|
| ❇️               | package is intended to be consumed directly by package clients |
| ⚠️               | package requires a flutter environment                         |
| 🚫               | package is intended as internal package only                   |

| package name                  | status | description                                                                                         |
|-------------------------------|--------|-----------------------------------------------------------------------------------------------------|
| dartpip                       | ❇️     | Add Python modules (packages) to your Dart or Flutter project.                                      |
| python_ffi                    | ❇️⚠️   | A Python-FFI for Dart, intended for use in a Flutter project.                                       |
| python_ffi_dart               | ❇️     | A Python-FFI for Dart, intended for dart-only applications outside of a Flutter project.            |
| python_ffi_macos              | ⚠️🚫   | The macOS implementation of python_ffi, a Python-FFI for Dart.                                      |
| python_ffi_macos_dart         | 🚫     | The macOS implementation of python_ffi_dart, a Python-FFI for Dart.                                 |
| python_ffi_platform_interface | 🚫     | The platform interface for python_ffi, a Python-FFI for Dart.                                       |
| python_ffi_interface          | 🚫     | A base interface for python_ffi_dart, a Python-FFI for Dart.                                        |
| python_ffi_lint               |        | Analysis options used across the Python-FFI for Dart project.                                       |
| python_ffi_dart_example       |        | The example command line application showcasing the python_ffi_dart package, a Python-FFI for Dart. |

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
clients as a dependency. `python_ffi_dart_example` and `python_ffi/example` are example projects
used for developing, testing and showcasing the Python FFI.

```
┌─────────────────────────────────────────┐
│                python_ffi_dart_example  │
│                                      │  │
│  python_ffi            python_ffi_dart  │
│  │   │                           │   │  │
│  │   python_ffi_macos            │   │  │
│  │   │          │                │   │  │
│  │   │       python_ffi_macos_dart   │  │
│  │   │                           │   │  │
│  python_ffi_platform_interface   │   │  │
│                       │          │   │  │
│                   python_ffi_interface  │
└─────────────────────────────────────────┘       dartpip
                                       │             │
                                       python_ffi_lint
```

## Limitations

- Python `print` is not supported when used in a Flutter environment.
- Requires Python 3.11 to be installed on the host system.

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
