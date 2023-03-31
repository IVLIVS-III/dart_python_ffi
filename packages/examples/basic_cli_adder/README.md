# basic_cli_adder

This is a simple example of a command line tool that adds two numbers.

This example is intended to show how to import a minimalistic Python module into Dart console
applications.

## Table of contents

1. [Usage (the final product)](#usage-the-final-product)
2. [Prerequisites](#prerequisites)
3. [Including the Python module source](#including-the-python-module-source)
4. [Adding the Python module to the Dart project](#adding-the-python-module-to-the-dart-project)
    1. [List the Python module as a dependency in `pubspec.yaml`](#1-list-the-python-module-as-a-dependency-in-pubspecyaml)
    2. [Run `dartpip bundle`](#2-run-dartpip-bundle)
    3. [Creating the Module-definition in Dart](#3-creating-the-module-definition-in-dart)
5. [Using the Python module in Dart](#using-the-python-module-in-dart)
6. [Testing the Python module](#testing-the-python-module)
7. [Next step](#next-step)

## Usage (the final product)

```bash
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
    basic_cli_adder: any
```

### 2. Run `dartpip bundle`

The following command should be run from the root of your Dart project. It will bundle the Python
module source into the Dart project.

```bash
$ dartpip bundle -r . -m python-modules
```

The value behind the `-m` option is the path to the directory containing the Python module source.
The value behind the `-r` option is the root of the Dart project. Both are relative to the current
working directory.

### 3. Creating the Module-definition in Dart

Each Python module needs its corresponding Dart Module-definition:

```dart
// lib/basic_cli_adder.dart

import "package:python_ffi_dart/python_ffi_dart.dart";

class BasicCliAdder extends PythonModule {
  BasicCliAdder.from(super.pythonModule) : super.from();

  static BasicCliAdder import() =>
      PythonFfiDart.instance
          .importModule("basic_cli_adder", BasicCliAdder.from);

  num add(num x, num y) => getFunction("add").call(<Object?>[x, y]);
}
```

## Using the Python module in Dart

First we need to initialize the Python runtime once. This is done by calling the `initialize` method
on the `PythonFfiDart.instance` singleton. The `initialize` method takes the encoded Python modules
added via `dartpip bundle`.

Then we can import the Python module and call its function:

```dart
// bin/basic_cli_adder.dart

import "package:basic_cli_adder/basic_cli_adder.dart";
import "package:basic_cli_adder/python_modules/src/python_modules.g.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";

void main(List<String> arguments) async {
  final num x = num.parse(arguments[0]);
  final num y = num.parse(arguments[1]);

  await PythonFfiDart.instance.initialize(kPythonModules);

  final BasicCliAdder basicCliAdder = BasicCliAdder.import();
  final num result = basicCliAdder.add(x, y);
  print("$x + $y = $result");
}
```

## Testing the Python module

We can write Dart tests to test our Python module. Again we need to make sure to initialize the
Python
runtime once first. Then we can import the Python module and test its function:

```dart
// test/basic_cli_adder_test.dart

import "package:basic_cli_adder/basic_cli_adder.dart";
import "package:basic_cli_adder/python_modules/src/python_modules.g.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:test/test.dart";

void main() async {
  await PythonFfiDart.instance.initialize(kPythonModules);

  test("add", () {
    expect(BasicCliAdder.import().add(1, 2), 3);
  });
}
```

## Next step

Importing a Python module which defines a custom class.
See [`basic_dataclass`](../basic_dataclass/README.md). 
