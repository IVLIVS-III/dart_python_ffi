# dartpip

[![pub package](https://img.shields.io/pub/v/dartpip.svg)](https://pub.dev/packages/dartpip)

Like `pip`, but for Dart, heavily inspired by the `pub` command.

Add Python modules (packages) to your Dart or Flutter project.
Then use them in your Dart code via [`python_ffi`](https://pub.dev/packages/python_ffi)
and [`python_ffi_dart`](https://pub.dev/packages/python_ffi_dart).

## Table of Contents

1. [Getting Started](#getting-started)
    1. [Installation](#installation)
    2. [Usage](#usage)
        1. [Declare Python dependencies](#declare-python-dependencies)
        2. [Add sources for all Python dependencies](#add-sources-for-all-python-dependencies)
        3. [Bundle Python dependencies](#bundle-python-dependencies)
2. [Commands](#commands)
    1. [`bundle`](#bundle)
        1. [Options](#options)
    2. [`install`](#install)

## Getting Started

### Installation

Install [`dartpip`](https://pub.dev/packages/dartpip) as a global package
via [pub.dev](https://pub.dev/) so it can be used from anywhere on your
system:

```shell
$ dart pub global activate dartpip
```

Alternatively add `dartpip` as a dev-dependency for the current project only:

```shell
$ dart pub add --dev dartpip
$ flutter pub add --dev dartpip
```

### Usage

#### Declare Python dependencies

Add any pure Python module as a dependency to your `pubspec.yaml`. To do this, create a new
top-level key `'python_ffi'` with subkey `'modules'`:

```yaml
python_ffi:
  modules:
    json_parser: any
```

You do not need to specify submodules separately. `dartpip` will automatically detect them.

*Note: The specified version has no effect at the moment. You can specify `'any'` or any other
value. Using `'any'` is recommended, since it will work with future versions of `dartpip`.*

#### Add sources for all Python dependencies

Put the source files for all Python modules you specified in `pubspec.yaml` in a single directory.
You may create subdirectories for Python modules with more than one source file. The directory
structure will be mostly preserved when bundling the Python modules.

Be sure to also add the source files for all submodules of the Python modules you specified in
`pubspec.yaml`. `dartpip` will automatically detect them, if they are in this directory.

For example such a source directory could look like this:

```
python-modules/
├── json_parser/
│   ├── __init__.py
│   ├── json_parser.py
│   ├── json_parser_test.py
│   └── LICENSE.TXT
├── liblax/
│   ├── __init__.py
│   ├── lexer.py
│   ├── LICENSE.TXT
│   └── parser/
│       ├── __init__.py
│       └── src.py
└── structs.py
```

Here `liblax.parser` is a submodule that will be automatically included.

#### Bundle Python dependencies

Run the `bundle` command to bundle all Python dependencies for the current Dart / Flutter project:

```shell
$ dartpip bundle -r <app-root> -m <python-modules-root>
```

`<app-root>` is the root directory of the Dart / Flutter application, i.e. the directory containing
the `pubspec.yaml` file. `<python-modules-root>` is the root directory for the Python module
sources. Specify the directory of the previous step.

*Note: The `bundle` command and steps above will be replaced by the `install` command in the
future.*

<details>
<summary>Future usage</summary>

```shell
$ dartpip install <package>
```

If you installed `dartpip` as a dev-dependency, you can run it via `dart run` / `flutter run`:

```shell
$ dart run dartpip install <package>
$ flutter run dartpip install <package>
```

</details>

## Commands

### `bundle`

Bundles all Python modules specified in `pubspec.yaml` for a Dart / Flutter application.

<details>
<summary>What will happen?</summary>

1. The `pubspec.yaml` file will be parsed and all Python modules will be
   collected. Python modules are specified in the `python_ffi` section.
2. The Python modules will be collected from the directory specified in the `python-modules-root`
   option.
3. For Flutter projects, the Python modules will be copied to the `python-modules` directory and
   added to the `assets` section of the `pubspec.yaml` file. For Dart projects, the Python modules
   will be embedded into a single `python_modules.g.dart` file and added to the `lib` directory.
4. For Flutter projects, all added Python modules will be registered to a `modules.json` file within
   the `python-modules` directory, and added to the `assets` section of the `pubspec.yaml` file.
   This allows for seamless integration with the `python_ffi` package. For Dart projects, all added
   Python modules will be registered to the `python_modules.g.dart` file within the `lib` directory.
   This file includes a `Map` of all Python modules and their sources encoded in a Dart constant to
   be used seamlessly by the `python_ffi_dart` package.

</details>

#### Options

| Option                  | Abbreviation | Description                                           |
|-------------------------|--------------|-------------------------------------------------------|
| `--app-root`            | `-r`         | The root directory of the Dart / Flutter application. |
| `--python-modules-root` | `-m`         | The root directory for the Python module sources.     |

<details>
<summary>Future commands</summary>

### `install`

Aliases: `add`

Adds a Python module to the current Dart / Flutter project.

*Note: This command will replace the `bundle` command in the future.*
</details>
