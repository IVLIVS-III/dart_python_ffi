import "dart:collection";

import "package:dartpip_solver/dartpip_solver.dart";
import "package:dartpip_solver/python_modules/packaging/requirements.g.dart";
import "package:dartpip_solver/python_modules/src/python_modules.g.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";

class Dependency {
  Dependency({
    required this.name,
    required this.version,
  });

  final String name;
  final String version;
}

class Constraint {
  Constraint({
    required this.name,
    required this.constraint,
  });

  final String name;
  final String constraint;
}

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
        return Constraint(
          name: requirement.name! as String,
          constraint: requirement.specifier.toString(),
        );
      }),
    );
  }
  return UnmodifiableSetView<Dependency>(dependencies);
}
