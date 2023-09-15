# flutter_package_import

A Flutter app which imports a package, wrapping a python module.

This example is intended to show how to import a Flutter package which internally uses the Dart
Python FFi.

## Table of Contents

## Usage (the final product)

```shell
$ flutter run
```

This will launch the standard Flutter demo app. This app will display a counter and a button to
increment the counter. Only difference is that to increment the counter, we use
the [`flutter_package_export`](../flutter_package_export/README.md) package. This package uses the
Dart Python FFi to wrap a Python module, which is then used to increment the counter.

However, we do not need to know that the counter is incremented using a Python module. We only need
import the [`flutter_package_export`](../flutter_package_export/README.md) package and use it as any
other Dart package.

## Prerequisites

* None other than the standard Flutter prerequisites.

## Adding the `flutter_package_export` package to the Flutter project

### 1. List the `flutter_package_export` package as a dependency in `pubspec.yaml`

```yaml
# pubspec.yaml

dependencies:
  flutter:
    sdk: flutter
  flutter_package_export:
    path: ../flutter_package_export
```

### 2. Run `flutter pub get`

The following command should be run from the root of your Flutter project. It will install the
`flutter_package_export` package.

```shell
$ flutter pub get
```

### 3. Import the `flutter_package_export` package

We then modify the `lib/main.dart` file to import the `flutter_package_export` package and use it
to increment the counter.

```dart
// lib/main.dart

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:flutter_package_export/flutter_package_export.dart';

Future<void> main() async {
  await initialize();
  runApp(const MyApp());
}

// ...

class _MyHomePageState extends State<MyHomePage> {
  // ...

  void _incrementCounter() {
    final int newCounter = add(_counter, 1).toInt();
    setState(() {
      _counter = newCounter;
    });
  }

// ...
}
```

Note the only three modifications:

1. Importing the `flutter_package_export` package.
2. Calling the `initialize` function in out `main` function.
3. Using the `add` function to increment the counter in the `_incrementCounter` function.

## Next Step

Converting all supported types between Dart and Python. See
the [`python_ffi_dart` example](../../python_ffi_dart/example/README.md).

Importing multiple Python modules in a Flutter app. See
the [`python_ffi` example](../../python_ffi/example/README.md).
