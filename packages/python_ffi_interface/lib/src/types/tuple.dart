part of python_ffi_interface;

class PythonTuple<T extends Object?, P extends PythonFfiDelegate<R>,
    R extends Object?> with ListMixin<T> implements List<T> {
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
