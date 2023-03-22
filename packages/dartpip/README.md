# dartpip

Like `pip`, but for Dart, heavily inspired by the `pub` command.

Add Python modules (packages) to your Dart or Flutter project.
Then use them in your Dart code via [`python_ffi`](https://pub.dev/packages/python_ffi)
and [`python_ffi_dart`](https://pub.dev/packages/python_ffi_dart).

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

```shell
$ dartpip install <package>
```

If you installed `dartpip` as a dev-dependency, you can run it via `dart run` / `flutter run`:

```shell
$ dart run dartpip install <package>
$ flutter run dartpip install <package>
```

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
</details>
