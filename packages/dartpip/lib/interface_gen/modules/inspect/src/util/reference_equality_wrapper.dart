part of inspect;

/// TODO: Document.
@immutable
final class ReferenceEqualityWrapper
    extends PythonObjectInterface<PythonFfiDelegate<Object?>, Object?> {
  /// TODO: Document.
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
