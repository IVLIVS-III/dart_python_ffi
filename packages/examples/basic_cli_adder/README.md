# basic_cli_adder

This is a simple example of a command line tool that adds two numbers.

This example is intended to show how to import a minimalistic Python module into Dart console
applications.

## Table of contents

1. [Usage (the final product)](#usage--the-final-product-)
2. [Prerequisites](#prerequisites)
3. [Including the Python module source](#including-the-python-module-source)
4. [Adding the Python module to the Dart project](#adding-the-python-module-to-the-dart-project)
    1. [List the Python module as a dependency in `pubspec.yaml`](#1-list-the-python-module-as-a-dependency-in-pubspecyaml)
    2. [Run `dartpip install`](#2-run-dartpip-install)
    3. [Export the generated files](#3-export-the-generated-files)
5. [Using the Python module in Dart](#using-the-python-module-in-dart)
6. [Testing the Python module](#testing-the-python-module)
7. [Next step](#next-step)

## Usage (the final product)

```shell
$ dart bin/basic_cli_adder.dart 1 2
1 + 2 = 3
```

## Prerequisites

* The [dartpip cli](https://pub.dev/packages/dartpip) should be installed (either globally or as
  dev-dependency in this Dart project).

## Including the Python module source

The Python module source is a single file `basic_cli_adder.py` in the `python-modules` directory. It
could be located in any other directory, even outside the project root. This will result in a module
named `basic_cli_adder` that we will be importing from Dart.

```py
# python-modules/basic_cli_adder.py

num = int | float

def add(x: num, y: num) -> num:
    return x + y
```

## Adding the Python module to the Dart project

### 1. List the Python module as a dependency in `pubspec.yaml`

```yaml
# pubspec.yaml

python_ffi:
  modules:
    basic_cli_adder:
      path: python-modules/basic_cli_adder.py
```

### 2. Run `dartpip install`

The following command should be run from the root of your Dart project. It will bundle the Python
module source into the Dart project.

```shell
$ dartpip install
```

Each Python module needs its corresponding Dart Module-definition.

The `install` command will automatically generate a Module-definition in Dart for the Python module.
The generated file will be located at `lib/python_modules/basic_cli_adder.g.dart`.

<details>
<summary>Click to see the generated file</summary>

```dart
// lib/python_modules/basic_cli_adder.g.dart

// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library basic_cli_adder;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## num
typedef $num = Object?;

/// ## basic_cli_adder
///
/// ### python source
/// ```py
/// num = int | float
///
/// def add(x: num, y: num) -> num:
///     return x + y
/// ```
final class basic_cli_adder extends PythonModule {
  basic_cli_adder.from(super.pythonModule) : super.from();

  static basic_cli_adder import() =>
      PythonFfiDart.instance.importModule(
        "basic_cli_adder",
        basic_cli_adder.from,
      );

  /// ## add
  ///
  /// ### python source
  /// ```py
  /// def add(x: num, y: num) -> num:
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

To make the Python module available to other Dart files, we need to export the generated files.
To do this, we modify `lib/basic_cli_adder.dart`:

```dart
// lib/basic_cli_adder.dart

export "python_modules/basic_cli_adder.g.dart";
export "python_modules/src/python_modules.g.dart";
```

## Using the Python module in Dart

First we need to initialize the Python runtime once. This is done by calling the `initialize` method
on the `PythonFfiDart.instance` singleton. The `initialize` method takes the encoded Python modules
added via `dartpip install`.

Then we can import the Python module and call its function:

```dart
// bin/basic_cli_adder.dart

import "package:basic_cli_adder/basic_cli_adder.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";

void main(List<String> arguments) async {
  final num x = num.parse(arguments[0]);
  final num y = num.parse(arguments[1]);

  await PythonFfiDart.instance.initialize(pythonModules: kPythonModules);

  final basic_cli_adder basicCliAdder = basic_cli_adder.import();
  final Object? result = basicCliAdder.add(x: x, y: y);
  print("$x + $y = $result");
}
```

*Note: When you look at the file `bin/basic_cli_adder.dart` as it is in this repository, you will
notice that it is quite different. This is because the complete example project allows for passing
arguments via the command line. This is not relevant for this tutorial, so we have removed it here.*

## Testing the Python module

We can write Dart tests to test our Python module. Again we need to make sure to initialize the
Python runtime once first. Then we can import the Python module and test its function:

```dart
// test/basic_cli_adder_test.dart

import "package:basic_cli_adder/basic_cli_adder.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:test/test.dart";

void main() async {
  setUpAll(() async {
    await PythonFfiDart.instance.initialize(pythonModules: kPythonModules);
  });

  test("add", () {
    expect(basic_cli_adder.import().add(x: 1, y: 2), 3);
  });
}
```

## Next step

Importing a Python module which defines a custom class.
See [`basic_dataclass`](../basic_dataclass/README.md). 
