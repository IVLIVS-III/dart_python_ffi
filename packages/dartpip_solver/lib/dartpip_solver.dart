/// Version solver used by the `dartpip` command to resolve python modules.
library dartpip_solver;

import "dart:async";
import "dart:io";

import "package:archive/archive_io.dart";
import "package:collection/collection.dart";
import "package:dartpip_solver/src/pypi/api.dart";
import "package:http/http.dart" as http;

export "src/dartpip_solver_base.dart";

part "src/extensions.dart";
part "src/pypi/client.dart";
part "src/pypi/pypi.dart";
part "src/util/lazy_future.dart";

// TODO: Export any libraries intended for clients of this package.

/// The version of dartpip_solver.
const String kDartpipSolverVersion = "0.0.1";
