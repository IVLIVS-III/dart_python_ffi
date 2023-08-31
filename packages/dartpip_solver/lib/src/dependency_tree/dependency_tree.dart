part of dartpip_solver;

class _DependencyNode {
  _DependencyNode({
    required this.name,
    required this.requirement,
  });

  final String name;
  final Requirement requirement;
  final Set<_DependencyNode> _dependencies = <_DependencyNode>{};
  final Set<_DependencyNode> _dependents = <_DependencyNode>{};

  Set<_DependencyNode> get dependencies =>
      UnmodifiableSetView<_DependencyNode>(_dependencies);

  Set<_DependencyNode> get dependents =>
      UnmodifiableSetView<_DependencyNode>(_dependents);

  _DependencyNode dependOn(String name, Requirement requirement) {
    final _DependencyNode node =
        _DependencyNode(name: name, requirement: requirement);
    _dependencies.add(node);
    node._dependents.add(this);
    return node;
  }

  @override
  String toString() => "DependencyNode('$name', '$requirement')";
}

class _DependencyTree {
  final Set<_DependencyNode> _directDependencies = <_DependencyNode>{};

  _DependencyNode addDependency(String name, Requirement requirement) {
    final _DependencyNode node =
        _DependencyNode(name: name, requirement: requirement);
    _directDependencies.add(node);
    return node;
  }

  Set<_DependencyNode> get transitiveDependencies =>
      UnmodifiableSetView<_DependencyNode>(
        _traverse().whereNot(_directDependencies.contains).toSet(),
      );

  Set<_DependencyNode> _traverse() {
    final Set<_DependencyNode> visited = <_DependencyNode>{};
    final Queue<_DependencyNode> queue = Queue<_DependencyNode>()
      ..addAll(_directDependencies);
    while (queue.isNotEmpty) {
      final _DependencyNode node = queue.removeFirst();
      visited.add(node);
      for (final _DependencyNode dependency in node.dependencies) {
        if (!visited.contains(dependency)) {
          queue.add(dependency);
        }
      }
    }
    return UnmodifiableSetView<_DependencyNode>(visited);
  }
}

Future<_DependencyTree> _buildDependencyTree(
  Map<String, (Constraint, String, List<String>)> projects,
) async {
  final _DependencyTree dependencyTree = _DependencyTree();
  for (final MapEntry<String, (Constraint, String, List<String>)> project
      in projects.entries) {
    final String projectName = project.key;
    final (
      Constraint pythonDependency,
      String version,
      List<String> requirements,
    ) = project.value;
    print(
      "found pythonDependency: '${pythonDependency.name}' $version, $requirements",
    );
    final _DependencyNode newDependency = dependencyTree.addDependency(
      projectName,
      Requirement(requirement_string: version),
    );
    await _recursivelyAddDependencies(newDependency);
  }
  return dependencyTree;
}

Future<void> _recursivelyAddDependencies(_DependencyNode dependency) async {
  print("recursively adding dependencies of dependency: '$dependency'");
  final String? version =
      await PyPIService().fetch(projectName: dependency.name);
  if (version == null) {
    return;
  }
  final List<String> requirements =
      await PyPIService().client.requirements(dependency.name, version);
  print("found dependency: '${dependency.name}' $version, $requirements");
  for (final String requirementString in requirements) {
    print("found requirement: '$requirementString'");
    final Requirement requirement =
        Requirement(requirement_string: requirementString);
    print("parsed requirement: '$requirement'");
    final String name = requirement.name! as String;
    print("parsed name: '$name'");
    final _DependencyNode newDependency =
        dependency.dependOn(name, requirement);
    print("added dependency: '$newDependency'");
    await _recursivelyAddDependencies(newDependency);
    print("added dependencies of dependency: '$newDependency'");
  }
}
