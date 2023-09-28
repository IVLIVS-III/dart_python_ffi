## 0.2.7

- Updated dependencies.

## 0.2.6

- Updated dependencies.

## 0.2.5

- Updated dependencies.

## 0.2.4

- Updated dependencies.

## 0.2.3

- Tests, examples and documentation are mostly ignored by the `dartpip install` command. The command
  no longer tries to generate Python interface definitions for them.

## 0.2.2

- Updated dependencies.

## 0.2.1

- Fixed an issue with generating Python interface definitions.

## 0.2.0

- Added `dartpip install`.
- Updated dependencies.

## 0.1.0

- Updated to Dart 3.x.

## 0.0.6

- `dartpip bundle` now removes files from the assets section of `pubspec.yaml` that are no longer
  used, but have been added by `dartpip bundle` before.

## 0.0.5

- `dartpip bundle` now replaces the old `modules.json` file to delete dependencies that are no
  longer used.
- `dartpip bundle` now specifies the builtin `python_ffi` module correctly in `pubspec.yaml` assets.
- Updated dependencies.

## 0.0.4

- Included the Python module `python_ffi` source. This module is required for using the Python FFI.
  It is now bundled with the `dartpip` package.

## 0.0.3

- Fixed an issue with bundling of multi-file modules containing multi-file submodules for Dart
  console projects.

## 0.0.2

- Fixed bundling of multi-file modules containing multi-file submodules.

## 0.0.1+2

- Specified the executable `dartpip` in the `pubspec.yaml` file.
    - This should allow the `dartpip` command to be run from anywhere on the system.

## 0.0.1+1

- Added an example directory to increase pub score.
    - This example is only a copy of the `dartpip` command line tool. This package is intended as a
      cli only.

## 0.0.1

- Initial version.
