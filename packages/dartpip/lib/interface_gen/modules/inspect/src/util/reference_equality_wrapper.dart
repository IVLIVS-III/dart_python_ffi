part of inspect;

/// Helper class for testing equality of wrapped Python objects.
/// They are considered equal, if they are the same object in Python.
@immutable
final class ReferenceEqualityWrapper
    extends PythonObjectInterface<PythonFfiDelegate<Object?>, Object?> {
  /// Wraps the given [_source] object for testing equality.
  ReferenceEqualityWrapper(this._source)
      : super(
          _source.platform,
          _source.reference,
          initializer: _source.initializer,
          finalizer: _source.finalizer,
        );

  final PythonObjectInterface<PythonFfiDelegate<Object?>, Object?> _source;

  @override
  bool operator ==(Object? other) {
    if (other is! ReferenceEqualityWrapper) {
      return false;
    }
    return _source.reference == other._source.reference;
  }

  @override
  int get hashCode => _source.reference.hashCode;

  @override
  String toString() => _source.toString();
}
