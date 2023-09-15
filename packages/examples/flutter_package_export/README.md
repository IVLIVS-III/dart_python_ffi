# flutter_package_export

A Flutter package which wraps a python module.

This example is intended to show how to use the Dart Python FFI in a publishable Flutter package.
Package clients can use the wrapped Python module without knowledge of the Python FFI. They simply
install and import the package like any other Dart / Flutter package.

## Table of contents

1. [Usage (the final product)](#usage--the-final-product-)
2. [Prerequisites](#prerequisites)
3. [Including the Python module source](#including-the-python-module-source)
4. [Adding the Python module to the Dart project](#adding-the-python-module-to-the-dart-project)
    1. [List the Python module as a dependency in `pubspec.yaml`](#1-list-the-python-module-as-a-dependency-in-pubspecyaml)
    2. [Run `dartpip install`](#2-run-dartpip-install)
    3. [Export the generated files](#3-export-the-generated-files)
    4. [Done](#4-done)
5. [Next step](#next-step)

## Usage (the final product)

See [`flutter_package_import`](../flutter_package_import/README.md) for an example of how to consume
this Flutter package.

## Prerequisites

* The [dartpip cli](https://pub.dev/packages/dartpip) should be installed (either globally or as
  dev-dependency in this Dart project).

## Including the Python module source

The Python module source is a single file `basic_adder.py` in the `python-modules` directory. It
could be located in any other directory, even outside the project root. This will result in a module
named `basic_adder` that we will be importing from Dart.

```py
# python-modules/basic_adder.py

num = int | float

def add(x: num, y: num) -> num:
    """Adds x and y together"""
    return x + y
```

## Adding the Python module to the Dart project

### 1. List the Python module as a dependency in `pubspec.yaml`

```yaml
# pubspec.yaml

python_ffi:
  modules:
    basic_adder:
      path: python-modules/basic_adder.py
```

### 2. Run `dartpip install`

The following command should be run from the root of your Dart project. It will bundle the Python
module into a Dart package.

```shell
$ dartpip install
```

Each Python module needs its corresponding Dart Module-definition.

The `install` command will automatically generate a Module-definition in Dart for the Python module.
The generated file will be located at `lib/python_modules/basic_adder.g.dart`.

<details>
<summary>Click to see the generated file</summary>

```dart
// lib/python_modules/basic_adder.g.dart

// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library basic_adder;

import "package:python_ffi/python_ffi.dart";

/// ## num
typedef $num = Object?;

/// ## basic_adder
///
/// ### python source
/// ```py
/// num = int | float
///
/// def add(x: num, y: num) -> num:
///     """Adds x and y together"""
///     return x + y
/// ```
final class basic_adder extends PythonModule {
  basic_adder.from(super.pythonModule) : super.from();

  static basic_adder import() =>
      PythonFfi.instance.importModule(
        "basic_adder",
        basic_adder.from,
      );

  /// ## add
  ///
  /// ### python docstring
  ///
  /// Adds x and y together
  ///
  /// ### python source
  /// ```py
  /// def add(x: num, y: num) -> num:
  ///     """Adds x and y together"""
  ///     return x + y
  /// ```
  Object? add({
    required Object? x,
    required Object? y,
  }) =>
      getFunction("add").call(
        <Object?>[
          x,
          y,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## num (getter)
  Object? get $num => getAttribute("num");

  /// ## num (setter)
  set $num(Object? $num) => setAttribute("num", $num);
}
```

</details>

### 3. Export the generated files

To make the python module available to other Dart / Flutter projects, we need to export the
generated files. To do this, we modify `lib/flutter_package_export.dart`:

```dart
// lib/flutter_package_export.dart

library flutter_package_export;

import "package:flutter/material.dart";
import "package:flutter_package_export/python_modules/basic_adder.g.dart";
import "package:python_ffi/python_ffi.dart";

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PythonFfi.instance.initialize(package: "flutter_package_export");
}

num add(num x, num y) => basic_adder.import().add(x: x, y: y)! as num;
```

We export an abstract initialization function `initialize` which will be called by the package
client. The initialization function will correctly initialize the Python FFI. Due to this
abstraction, the package client does not need to know about the Python FFI.

We also a custom wrapper function `add` which will be used by the package client to call the Python
module. The wrapper function will automatically import the Python module and cast the return value
to a Dart type. Again, due to this abstraction, the package client does not need to know about the
Python FFI.

*Note: Since we used a `typing.Union` type annotation in the Python module (`int | float`), the
generated Dart Module-definition will use `Object?` as the corresponding Dart type. This is because
Dart does not have a `Union` type. The `Object?` type is used as a catch-all type for any type
annotation that cannot be converted to a Dart type. To make the API more user-friendly, we can
manually cast the return value to a corresponding Dart type (in this case `num`).*

### 4. Done

The package is now ready to be published and consumed by other Dart / Flutter projects.

## Next step

See [`flutter_package_import`](../flutter_package_import/README.md) for an example of how to consume
this Flutter package.

Converting all supported types between Dart and Python. See
the [`python_ffi_dart` example](../../python_ffi_dart/example/README.md).

Importing multiple Python modules in a Flutter app. See
the [`python_ffi` example](../../python_ffi/example/README.md).
