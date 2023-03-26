part of python_ffi_interface;

/// Represents a Python tuple.
///
/// Python tuples are converted to a Dart List. When converting back to Python,
/// this list would be converted to a Python list.
/// In order to convert a Dart list to a Python tuple, use the
/// [PythonTuple.from] constructor.
class PythonTuple<T extends Object?> with ListMixin<T> implements List<T> {
  /// Creates a Python tuple from a Dart list.
  PythonTuple.from(Iterable<T> elements)
      : _list = List<T>.from(elements, growable: false);

  final List<T> _list;

  @override
  int get length => _list.length;

  @override
  set length(int newLength) {
    throw UnsupportedError("Cannot change the length of a Python tuple.");
  }

  @override
  T operator [](int index) => _list[index];

  @override
  void operator []=(int index, T value) {
    _list[index] = value;
  }
}
