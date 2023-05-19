part of python_ffi_interface;

/// Wraps a function that initializes a python object.
final class Initializer<T1 extends Object?, T2 extends Object?> {
  /// Creates a new initializer.
  const Initializer(this._initializer);

  final void Function(Pair<T1, T2>) _initializer;

  /// Invokes the initializer.
  void call(T1 value1, T2 value2) => _initializer(Pair<T1, T2>(value1, value2));
}

/// Abstract base class for any Dart representation of a Python object.
abstract base class PythonObjectInterface<P extends PythonFfiDelegate<R>,
    R extends Object?> extends BaseInterface {
  /// Creates a new Python object.
  PythonObjectInterface(
    this._platform,
    this._reference, {
    required this.initializer,
    required this.finalizer,
  }) : super(token: _token) {
    initializer(_platform, _reference);
    finalizer.attach(
      this,
      Pair<P, R>(_platform, _reference),
      detach: this,
    );
  }

  static final Object _token = Object();

  /// Verifies that the given [instance] is a [PythonObjectInterface].
  static void verify(
    PythonObjectInterface<PythonFfiDelegate<Object?>, Object?> instance,
  ) {
    BaseInterface.verify(instance, _token);
  }

  final P _platform;
  final R _reference;

  /// The initializer for the python object.
  /// Gets invoked at the start of the constructor.
  final Initializer<P, R> initializer;

  /// The finalizer for the python object.
  /// Gets invoked when the object is no longer accessible to the program.
  final Finalizer<Pair<PythonFfiDelegate<Object?>, Object?>> finalizer;

  /// Gets the platform that this object is associated with.
  P get platform => _platform;

  /// Gets the reference to the python object.
  R get reference => _reference;

  /// Converts the python object to a Dart object.
  Object? toDartObject();

  /// Checks if the python object has the given attribute.
  bool hasAttribute(String attributeName);

  /// Gets the attribute with the given name.
  T getAttributeRaw<T extends PythonObjectInterface<P, R>>(
    String attributeName,
  );

  /// Gets the attribute with the given name.
  T getAttribute<T extends Object?>(String attributeName);

  /// Sets the attribute with the given name.
  void setAttributeRaw<T extends PythonObjectInterface<P, R>>(
    String attributeName,
    T value,
  );

  /// Sets the attribute with the given name.
  void setAttribute<T extends Object?>(String attributeName, T value);

  /// Gets the function with the given name.
  PythonFunctionInterface<P, R> getFunction(String name);

  Object? _onUnknownMethod(
    String name,
    List<Object?> positionalArguments,
    Map<String, Object?> namedArguments,
  ) {
    final PythonFunctionInterface<P, R> function = getFunction(name);
    return function.call(positionalArguments, kwargs: namedArguments);
  }

  Object? _onUnknownGetter(String name) {
    final String attributeName = name;
    return getAttribute(attributeName);
  }

  void _onUnknownSetter(String name, Object? value) {
    final String attributeName = name;
    setAttribute<dynamic>(attributeName, value);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.isMethod) {
      return _onUnknownMethod(
        invocation.memberName.name,
        invocation.positionalArguments,
        invocation.namedArguments.map(
          (Symbol key, Object? value) =>
              MapEntry<String, Object?>(key.name, value),
        ),
      );
    } else if (invocation.isGetter) {
      return _onUnknownGetter(invocation.memberName.name);
    } else if (invocation.isSetter) {
      return _onUnknownSetter(
        invocation.memberName.name,
        invocation.positionalArguments.firstOrNull,
      );
    }

    return super.noSuchMethod(invocation);
  }

  /// Dumps the python object to the console.
  void debugDump() {
    // ignore: avoid_print
    print("PythonObject(reference: $_reference, delegate: $_platform)");
  }
}
