part of dartpip;

class _DependencyNode {
  _DependencyNode({
    required this.name,
    required this.requirement,
  }) : _dependencies = <_DependencyNode>[];

  final String name;
  final Requirement requirement;
  final List<_DependencyNode> _dependencies;

  List<_DependencyNode> get dependencies =>
      UnmodifiableListView<_DependencyNode>(_dependencies);
}

class _DependencyTree {}
