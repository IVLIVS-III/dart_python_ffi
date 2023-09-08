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

To add a python dependency to your Dart / Flutter project simply enter the following command:

```shell
$ dartpip install <package>
```

If you installed `dartpip` as a dev-dependency, you can run it via `dart run` / `flutter run`:

```shell
$ dart run dartpip install <package>
$ flutter run dartpip install <package>
```

You may specify multiple dependencies at once:

```shell
$ dartpip install <package1> <package2> <package3>
```

Or specifying no package at all will install all dependencies specified in `pubspec.yaml`:

```shell
$ dartpip install
```

See below on how to manually declare Python dependencies in `pubspec.yaml`.

#### Manually declare Python dependencies

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

#### Using local dependencies not uploaded to PyPI

Instead of declaring a module by its name and version constraint (or `any`), you can also specify a
dependency to a local directory. This is called a path-dependency.

```yaml
python_ffi:
  modules:
    my_module:
      path: /path/to/my/module
```

You may specify a relative or absolute path. If your path contains special characters, it is
advantageous to enclose the path in quotes.

#### Add sources for all Python dependencies

*Note: This is not needed when using `dartpip install`.*

<details>
<summary>Click to expand</summary>

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

</details>

#### Bundle Python dependencies

*Note: This is not needed when using `dartpip install`.*

<details>
<summary>Click to expand</summary>

Run the `bundle` command to bundle all Python dependencies for the current Dart / Flutter project:

```shell
$ dartpip bundle -r <app-root> -m <python-modules-root>
```

`<app-root>` is the root directory of the Dart / Flutter application, i.e. the directory containing
the `pubspec.yaml` file. `<python-modules-root>` is the root directory for the Python module
sources. Specify the directory of the previous step.

*Note: The `bundle` command and steps above have been replaced by the `install` command*

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

<details>
<summary>Usage</summary>

```shell
Bundles all Python modules specified in pubspec.yaml for a Dart application.

Usage: dartpip bundle [arguments]
-h, --help                               Print this usage information.
-r, --app-root (mandatory)               
-m, --python-modules-root (mandatory)    

Run "dartpip help" to see global options.
```

</details>

<details>
<summary>Options</summary>

| Option                  | Abbreviation | Description                                           |
|-------------------------|--------------|-------------------------------------------------------|
| `--app-root`            | `-r`         | The root directory of the Dart / Flutter application. |
| `--python-modules-root` | `-m`         | The root directory for the Python module sources.     |

</details>

### `bundle-module`

Bundles a Python module into a Dart application.

<details>
<summary>What will happen?</summary>

Same as `bundle`, but only for a single Python module.

</details>

<details>
<summary>Usage</summary>

```shell
Bundles a Python module into a Dart application.

Usage: dartpip bundle-module [arguments]
-h, --help                         Print this usage information.
-r, --app-root (mandatory)         
-m, --python-module (mandatory)    
-t, --app-type                     [flutter (default), console]

Run "dartpip help" to see global options.
```

</details>

<details>
<summary>Options</summary>

| Option                  | Abbreviation | Description                                                                              |
|-------------------------|--------------|------------------------------------------------------------------------------------------|
| `--app-root`            | `-r`         | The root directory of the Dart / Flutter application.                                    |
| `--python-modules-root` | `-m`         | The root directory for the Python module sources.                                        |
| `--app-type`            | `-t`         | The type of the Dart / Flutter application. Possible values are `console` and `flutter`. |

</details>

### `download`

Downloads python modules from PyPI.

<details>
<summary>What will happen?</summary>

1. The `pubspec.yaml` file will be parsed and all Python modules will be
   collected. Python modules are specified in the `python_ffi` section.
2. The Python modules will be collected from PyPI.

</details>

<details>
<summary>Usage</summary>

```shell
Downloads python modules from PyPI.

Usage: dartpip download [arguments]
-h, --help    Print this usage information.

Run "dartpip help" to see global options.
```

</details>

### `install`

Aliases: `add`

Adds Python modules to the current Dart / Flutter project. They will be specified in pubspec.yaml
and bundled for a Dart application.

*Note: This command replaced the `bundle` command.*

<details>
<summary>What will happen?</summary>

1. The `pubspec.yaml` file will be parsed and all Python modules will be
   collected. Python modules are specified in the `python_ffi` section.
2. Python modules specified in the command will be added to the `pubspec.yaml` file.
3. Transitive dependencies will be resolved and added to the `pubspec.yaml` file. (*Note: This is
   implemented very naively at the moment. Version constraints are ignored.*)
4. All Python modules will be collected from PyPI or their source directory in case of a
   path-dependency.
5. For Flutter projects, the Python modules will be copied to the `python-modules` directory and
   added to the `assets` section of the `pubspec.yaml` file. For Dart projects, the Python modules
   will be embedded into a single `python_modules.g.dart` file and added to the `lib` directory.
6. For Flutter projects, all added Python modules will be registered to a `modules.json` file within
   the `python-modules` directory, and added to the `assets` section of the `pubspec.yaml` file.
   This allows for seamless integration with the `python_ffi` package. For Dart projects, all added
   Python modules will be registered to the `python_modules.g.dart` file within the `lib` directory.
   This file includes a `Map` of all Python modules and their sources encoded in a Dart constant to
   be used seamlessly by the `python_ffi_dart` package.

</details>

<details>
<summary>Usage</summary>

```shell
Adds Python modules to the current Dart / Flutter project. They will be specified in pubspec.yaml and bundled for a Dart application.

Usage: dartpip install [arguments]
-h, --help    Print this usage information.

Run "dartpip help" to see global options.
```

</details>
