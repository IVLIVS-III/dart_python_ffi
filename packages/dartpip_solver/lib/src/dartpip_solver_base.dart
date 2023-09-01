import "dart:collection";

import "package:collection/collection.dart";
import "package:dartpip_solver/dartpip_solver.dart";
import "package:dartpip_solver/python_modules/packaging/requirements.g.dart";
import "package:dartpip_solver/python_modules/src/python_modules.g.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";

/// Abstraction of a Python dependency resolved to a specific version.
class Dependency {
  /// Creates a new dependency.
  Dependency({
    required this.name,
    required this.version,
  });

  /// The name of the dependency.
  final String name;

  /// The version of the dependency.
  final String version;
}

/// Abstraction of a constraint on a Python dependency.
/// This will be turned into a [Dependency] by [solve].
class Constraint {
  /// Creates a new constraint.
  Constraint({
    required this.name,
    required this.constraint,
  });

  /// The name of the dependency.
  final String name;

  /// The constraint on the dependency.
  final String constraint;
}

/// Solves a set of constraints on Python dependencies.
/// Returns a set of dependencies that represent the resolved dependencies.
///
/// This function is is overly naive and does not take into account any
/// constraints. It simply iterates over all dependencies and their dependencies
/// recursively and collects all modules. For each module, it then downloads the
/// latest version from PyPI, regardless of whether it is compatible with the
/// other modules or not.
Future<Set<Dependency>> solve(Iterable<Constraint> constraints) async {
  await PythonFfiDart.instance.initialize(kPythonModules);

  final Set<Dependency> dependencies = <Dependency>{};
  final Queue<Constraint> queue = Queue<Constraint>()..addAll(constraints);
  while (queue.isNotEmpty) {
    final Constraint constraint = queue.removeFirst();
    final String name = constraint.name;
    if (dependencies.any((Dependency e) => e.name == name)) {
      continue;
    }

    final String? resolvedVersion =
        await PyPIService().fetch(projectName: name);
    if (resolvedVersion == null) {
      continue;
    }
    dependencies.add(Dependency(name: name, version: resolvedVersion));

    final List<String> requirements =
        await PyPIService().client.requirements(name, resolvedVersion);
    queue.addAll(
      requirements.map((String requirementString) {
        final Requirement requirement =
            Requirement(requirement_string: requirementString);
        final Object? marker = requirement.marker;
        if (marker is PythonClassInterface) {
          final Marker typedMarker = Marker.from(marker);
          final bool result = typedMarker.evaluate();
          if (!result) {
            // TODO: move to logger
            print(
              "⚠️   Warning: skipping requirement '$requirementString' because it has a marker that evaluates to false: '$marker'.",
            );
            return null;
          }
        }
        return Constraint(
          name: requirement.name! as String,
          constraint: requirement.specifier.toString(),
        );
      }).whereNotNull(),
    );
  }
  return UnmodifiableSetView<Dependency>(dependencies);
}
