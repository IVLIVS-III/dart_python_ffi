part of python_ffi_interface;

/// A pair of objects.
///
/// This is a simple data class that holds two objects.
/// Once Dart 3 arrives, we can deprecate this for built-in record types.
class Pair<T1 extends Object?, T2 extends Object?> {
  /// Creates a pair of objects.
  Pair(this.first, this.second);

  /// The first object.
  final T1 first;

  /// The second object.
  final T2 second;
}
