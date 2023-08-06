part of interface_gen;

/// TODO: Document.
extension MergeExtension<E> on Iterable<E> {
  /// TODO: Document.
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

/// TODO: Document.
extension IntersectExtension<E> on Set<E> {
  /// TODO: Document.
  Set<E> intersection(Set<E> other) =>
      where((E element) => other.contains(element)).toSet();
}

/// TODO: Document.
extension Extension<E> on Iterable<E> {
  /// TODO: Document.
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

  /// TODO: Document.
  Iterable<(int, E)> enumerate() sync* {
    final Iterator<E> iterator = this.iterator;
    int index = 0;
    while (iterator.moveNext()) {
      yield (index++, iterator.current);
    }
  }
}
