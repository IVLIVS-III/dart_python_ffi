<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# pytimeparse_dart

A Dart wrapper of [pytimeparse](https://pypi.org/project/pytimeparse/), a Python library for parsing
human-readable time strings.

This example shows how to import a (third-party) Python module from pypi. Additionally, we import
the Python module in a Dart package that exposes part of the Python module's functionality as a Dart
API to its package clients. A simulated package client is the `example` directory.

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

```shell
$ dart example/pytimeparse_dart_example.dart
Enter a duration: 1h 2m 3s
normalized duration: 1:02:03.000000
```

## Prerequisites

* The [dartpip cli](https://pub.dev/packages/dartpip) should be installed (either globally or as
  dev-dependency in this Dart project).

## Including the Python module source

Download the Python module source from pypi or Github. This Python module is a multi-file module.
Create a new directory `pytimeparse` in the `python-modules` directory. Copy the Python module
source into the `pytimeparse` directory. This will result in a module named `pytimeparse` that we
will be importing from Dart.

## Adding the Python module to the Dart project

### 1. List the Python module as a dependency in `pubspec.yaml`

```yaml
# pubspec.yaml

python_ffi:
  modules:
    pytimeparse: any
```

### 2. Run `dartpip bundle`

The following command should be run from the root of your Dart project. It will bundle the Python
module source into the Dart project.

```shell
$ dartpip bundle -r . -m python-modules
```

The value behind the `-m` option is the path to the directory containing the Python module source.
The value behind the `-r` option is the root of the Dart project. Both are relative to the current
working directory.

### 3. Creating the Module-definition in Dart

Each Python module needs its corresponding Dart Module-definition:

```dart
// lib/python_modules/pytimeparse.dart

import "package:python_ffi_dart/python_ffi_dart.dart";

final class PyTimeParse extends PythonModule {
  PyTimeParse.from(super.pythonModule) : super.from();

  static PyTimeParse import() =>
      PythonFfiDart.instance.importModule("pytimeparse", PyTimeParse.from);

  num? parse(String timeStr) => getFunction("parse").call(<Object?>[timeStr]);
}
```

## Using the Python module in Dart

### 1. Exposing the Python module in the Dart package

We provide a library function `initialize` that initializes the Python runtime and imports the
Python module. This function is called by the `example` directory. As such the consuming package
does not need to know about the Python runtime or the Python module.

```dart
// lib/pytimeparse_dart.dart

/// A Dart wrapper of [pytimeparse](https://pypi.org/project/pytimeparse/), a
/// Python library for parsing human-readable time strings.
library pytimeparse_dart;

import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:pytimeparse_dart/python_modules/src/python_modules.g.dart";

export "extensions.dart";
export "python_modules/pytimeparse.dart";

Future<void> initialize() async {
  await PythonFfiDart.instance.initialize(kPythonModules);
}
```

### 2. Consuming the Dart package

We consume the newly created Dart package in the `example` directory. First we need to
call `initialize`, an abstraction over the Python runtime and the Python module. Then we can import
the Python module and use it. However, due to the abstraction we could be oblivious to the fact that
we are using a Python module.

```dart
// example/pytimeparse_dart_example.dart

import "dart:io";

import "package:pytimeparse_dart/pytimeparse_dart.dart";

void main() async {
  await initialize();
  stdout.write("Enter a duration: ");
  final String? input = stdin.readLineSync();
  final PyTimeParse pyTimeParse = PyTimeParse.import();
  final num? seconds = pyTimeParse.parse(input ?? "");
  if (seconds == null) {
    stdout.writeln("unable to normalize duration: $input");
    return;
  }
  final Duration duration = seconds.asDuration;
  stdout.writeln("normalized duration: $duration");
}
```

## Testing the Python module

We can write Dart tests to test our Python module. Again we need to make sure to initialize the
Python runtime once first. Then we can import the Python module and test its functions:

```dart
// test/pytimeparse_dart_test.dart

import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:pytimeparse_dart/python_modules/src/python_modules.g.dart";
import "package:pytimeparse_dart/pytimeparse_dart.dart";
import "package:test/test.dart";

void main() async {
  await PythonFfiDart.instance.initialize(kPythonModules);

  group("Examples from Readme:", () {
    final PyTimeParse pytimeparse = PyTimeParse.import();

    setUp(() {
      // Additional setup goes here.
    });

    test("32m", () {
      expect(pytimeparse
          .parse("32m")
          .asDuration, Duration(minutes: 32));
    });
    test("2h32m", () {
      expect(
        pytimeparse
            .parse("2h32m")
            .asDuration,
        Duration(hours: 2, minutes: 32),
      );
    });
    test("2:04:13:02.266", () {
      expect(
        pytimeparse
            .parse("2:04:13:02.266")
            .asDuration,
        Duration(
          hours: 2 * 24 + 4,
          minutes: 13,
          seconds: 2,
          milliseconds: 266,
        ),
      );
    });
  });
}
```

## Next step

Converting all supported types between Dart and Python. See
the [python_ffi_dart example](../../python_ffi_dart/example/README.md).

Importing multiple Python modules in a Flutter app. See
the [python_ffi example](../../python_ffi/example/README.md).
