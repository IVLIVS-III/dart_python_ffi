part of interface_gen;

/// Utility extension methods for merge operations on [Iterable]s.
extension MergeExtension<E> on Iterable<E> {
  /// Merges this iterable with [other] using [compareTo] to determine the
  /// order.
  Iterable<E> sortedMerge(
    Iterable<E> other,
    int Function(E a, E b) compareTo,
  ) sync* {
    final Iterator<E> iterator = this.iterator;
    final Iterator<E> otherIterator = other.iterator;
    bool hasNext = iterator.moveNext();
    bool otherHasNext = otherIterator.moveNext();
    while (hasNext && otherHasNext) {
      final E current = iterator.current;
      final E otherCurrent = otherIterator.current;
      final int comparison = compareTo(current, otherCurrent);
      if (comparison < 0) {
        yield current;
        hasNext = iterator.moveNext();
      } else if (comparison > 0) {
        yield otherCurrent;
        otherHasNext = otherIterator.moveNext();
      } else {
        yield current;
        hasNext = iterator.moveNext();
        otherHasNext = otherIterator.moveNext();
      }
    }
    while (hasNext) {
      yield iterator.current;
      hasNext = iterator.moveNext();
    }
    while (otherHasNext) {
      yield otherIterator.current;
      otherHasNext = otherIterator.moveNext();
    }
  }
}

/// Utility extension methods for set operations on [Iterable]s.
extension IntersectExtension<E> on Set<E> {
  /// Returns a new set containing all elements that are contained by both this
  /// set and [other].
  Set<E> intersection(Set<E> other) =>
      where((E element) => other.contains(element)).toSet();
}

/// Utility extension methods for operations on [Iterable]s.
extension Extension<E> on Iterable<E> {
  /// Returns a new iterable containing the elements of this iterable. During
  /// iteration, the last [count] elements are dropped.
  /// If [count] is greater than the number of elements in this iterable, an
  /// empty iterable is returned.
  Iterable<E> skipLast(int count) sync* {
    final Iterator<E> iterator = this.iterator;
    final Queue<E> buffer = Queue<E>();
    while (iterator.moveNext()) {
      buffer.add(iterator.current);
      if (buffer.length > count) {
        yield buffer.removeFirst();
      }
    }
  }

  /// Models the Python `enumerate` function.
  /// Returns a new iterable of tuples where the first element is the index
  /// and the second element is the value.
  Iterable<(int, E)> enumerate() sync* {
    final Iterator<E> iterator = this.iterator;
    int index = 0;
    while (iterator.moveNext()) {
      yield (index++, iterator.current);
    }
  }
}
