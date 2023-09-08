# pytimeparse_dart

A Dart wrapper of [pytimeparse](https://pypi.org/project/pytimeparse/), a Python library for parsing
human-readable time strings.

This example shows how to import a (third-party) Python module from PyPI. Additionally, we import
the Python module in a Dart package that exposes part of the Python module's functionality as a Dart
API to its package clients. A simulated package client is the `example` directory.

## Table of contents

1. [Usage (the final product)](#usage-the-final-product)
2. [Prerequisites](#prerequisites)
3. [Including the Python module source](#including-the-python-module-source)
4. [Adding the Python module to the Dart project](#adding-the-python-module-to-the-dart-project)
    1. [Run `dartpip install`](#1-run-dartpip-install)
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

## Adding the Python module to the Dart project

### 1. Run `dartpip install`

The following command should be run from the root of your Dart project. It will download and bundle
the Python module source into the Dart project.

```shell
$ dartpip install pytimeparse
```

Each Python module needs its corresponding Dart Module-definition.

The `install` command will automatically generate a Module-definition in Dart for the Python module.
The generated file will be located at `lib/python_modules/pytimeparse.g.dart`.

Since the generated file is over 1000 lines long, we will not include it here. `dartpip install`
also generated various other `*.g.dart` files in the `lib/python_modules` directory. These files are
some submodules of `pytimeparse` and are not relevant for this example.

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

Future<void> initialize({String? libPath}) async {
  await PythonFfiDart.instance.initialize(kPythonModules, libPath: libPath);
}
```

The optional `libPath` parameter is used to specify the path to the Python shared library. We
expose this parameter to the package client to allow maximum flexibility.

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
  final Object? seconds = pytimeparse.import().parse(sval: input ?? "");
  if (seconds == null) {
    stdout.writeln("unable to normalize duration: $input");
    return;
  }
  final Duration duration = seconds.asDuration;
  stdout.writeln("normalized duration: $duration");
}
```

*Note: When you look at the file `bin/basic_dataclass.dart` as it is in this repository, you will
notice that it is quite different. This is because the complete example project allows for passing
arguments via the command line. This is not relevant for this tutorial, so we have removed it here.*

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
  group("Examples from Readme:", () {
    setUpAll(() async {
      await PythonFfiDart.instance.initialize(kPythonModules);
    });

    test("32m", () {
      expect(
        pytimeparse
            .import()
            .parse(sval: "32m")
            .asDuration,
        Duration(minutes: 32),
      );
    });
    test("2h32m", () {
      expect(
        pytimeparse
            .import()
            .parse(sval: "2h32m")
            .asDuration,
        Duration(hours: 2, minutes: 32),
      );
    });
    test("2:04:13:02.266", () {
      expect(
        pytimeparse
            .import()
            .parse(sval: "2:04:13:02.266")
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
