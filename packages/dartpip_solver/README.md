# dartpip_solver

[![pub package](https://img.shields.io/pub/v/dartpip_solver.svg)](https://pub.dev/packages/dartpip_solver)

Version solver used by the [`dartpip`](../dartpip/README.md) command to resolve python modules.

## Algorithm

The algorithm used by `dartpip_solver` is overly naive and does not take into account any
constraints. It simply iterates over all dependencies and their dependencies recursively and
collects all modules. For each module, it then downloads the latest version from PyPI, regardless
of whether it is compatible with the other modules or not.

## Roadmap

We plan to improve the algorithm in the future to take into account constraints and to find the
best possible combination of modules.

This, however, is no easy task, since this problem is known to be NP-hard.

The [Pub Package Manager](https://dart.dev/tools/pub/dependencies#version-solver)'s version solver
has a very promising approach to this problem, which we plan to implement in the future.
See [this blog post](https://nex3.medium.com/pubgrub-2fb6470504f) for more information.
