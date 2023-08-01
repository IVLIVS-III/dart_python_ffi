part of python_ffi_interface;

/// Represents a Python iterable.
final class PythonIterable<T extends Object?, P extends PythonFfiDelegate<R>,
        R extends Object?> extends PythonClassInterface<P, R>
    with IterableMixin<T>
    implements Iterable<T> {
  /// Creates a new Python iterable.
  PythonIterable(this._iterable)
      : super(
          _iterable.platform,
          _iterable.reference,
          initializer: _iterable.initializer,
          finalizer: _iterable.finalizer,
        );

  static Iterable<T> from<T extends Object?, P extends PythonFfiDelegate<R>,
      R extends Object?>(
    Object? iterable,
  ) {
    if (iterable is Iterable) {
      return TypedIterable<T>.from(iterable);
    } else if (iterable is PythonObjectInterface<P, R>) {
      return PythonIterable<T, P, R>(iterable);
    }
    throw ArgumentError.value(
      iterable,
      "iterable",
      "Must be a Python object or a Dart list.",
    );
  }

  final PythonObjectInterface<P, R> _iterable;

  @override
  Iterator<T> get iterator {
    final PythonModuleInterface<PythonFfiDelegate<Object?>, Object?>
        builtinsModule = PythonFfiDelegate.instance.importModule("builtins");
    final PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?>
        iterFunction = builtinsModule.getFunction("iter");
    final PythonObjectInterface<PythonFfiDelegate<Object?>, Object?> iterator =
        iterFunction.call(<Object?>[_iterable]);
    return PythonIterator<T, P, R>(iterator as PythonClassInterface<P, R>);
  }

  @override
  T_out getAttribute<T_out extends Object?>(String attributeName) =>
      _iterable.getAttribute<T_out>(attributeName);

  @override
  T_out getAttributeRaw<T_out extends PythonObjectInterface<P, R>>(
    String attributeName,
  ) =>
      _iterable.getAttributeRaw<T_out>(attributeName);

  @override
  PythonFunctionInterface<P, R> getFunction(String name) =>
      _iterable.getFunction(name);

  @override
  bool hasAttribute(String attributeName) =>
      _iterable.hasAttribute(attributeName);

  @override
  void setAttribute<T_in extends Object?>(String attributeName, T_in value) =>
      _iterable.setAttribute(attributeName, value);

  @override
  void setAttributeRaw<T_in extends PythonObjectInterface<P, R>>(
    String attributeName,
    T_in value,
  ) =>
      _iterable.setAttributeRaw(attributeName, value);

  @override
  Object? toDartObject() => this;
}

/// Adds type information to the untyped [PythonIterable].
class TypedIterable<T> with IterableMixin<T> implements Iterable<T> {
  /// Creates a new typed iterable from the given untyped iterable.
  TypedIterable.from(this._iterable);

  final Iterable<Object?> _iterable;

  @override
  Iterator<T> get iterator => TypedIterator<T>.from(_iterable.iterator);

  TransformIterable<T_out, T> transform<T_out>(T_out Function(T) transformer) =>
      TransformIterable<T_out, T>.from(this, transformer);
}

/// Transforms the elements of an iterable.
class TransformIterable<T, T_in> with IterableMixin<T> implements Iterable<T> {
  TransformIterable.from(this._iterable, this._transformer);

  final Iterable<T_in> _iterable;
  final T Function(T_in) _transformer;

  @override
  Iterator<T> get iterator => TransformIterator<T, T_in>.from(
        TypedIterator<T_in>.from(_iterable.iterator),
        _transformer,
      );

  TransformIterable<T_out, T> cast<T_out>() =>
      TransformIterable<T_out, T>.from(this, (T e) => e as T_out);
}
