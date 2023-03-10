/// Support for doing something awesome.
///
/// More dartdocs go here.
library python_ffi_interface;

import "dart:async";
import "dart:collection";
import "dart:typed_data";

import "package:collection/collection.dart";
import "package:python_ffi_interface/src/base_interface.dart";

export "src/python_ffi_interface_base.dart";

// TODO: Export any libraries intended for clients of this package.

part "src/class.dart";
part "src/delegate.dart";
part "src/exception.dart";
part "src/extensions/symbol.dart";
part "src/function.dart";
part "src/future.dart";
part "src/module.dart";
part "src/object.dart";
part "src/python_module_definition.dart";
part "src/types/iterable.dart";
part "src/types/iterator.dart";
part "src/types/tuple.dart";
part "src/util/pair.dart";
