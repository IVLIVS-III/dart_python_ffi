part of python_ffi_interface;

class Initializer<T1 extends Object?, T2 extends Object?> {
  const Initializer(this._initializer);

  final void Function(Pair<T1, T2>) _initializer;

  void call(T1 value1, T2 value2) => _initializer(Pair<T1, T2>(value1, value2));
}

abstract class PythonObjectInterface<P extends PythonFfiDelegate<R>,
    R extends Object?> extends BaseInterface {
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

  P get platform => _platform;

  R get reference => _reference;

  Object? toDartObject();

  bool hasAttribute(String attributeName);

  T getAttributeRaw<T extends PythonObjectInterface<P, R>>(
    String attributeName,
  );

  T getAttribute<T extends Object?>(String attributeName);

  void setAttributeRaw<T extends PythonObjectInterface<P, R>>(
    String attributeName,
    T value,
  );

  void setAttribute<T extends Object?>(String attributeName, T value);

  PythonFunctionInterface<P, R> getFunction(String name);

  Object? onUnknownMethod(
    String name,
    List<Object?> positionalArguments,
    Map<String, Object?> namedArguments,
  ) {
    final PythonFunctionInterface<P, R> function = getFunction(name);
    return function.call(positionalArguments, kwargs: namedArguments);
  }

  Object? onUnknownGetter(String name) {
    final String attributeName = name;
    return getAttribute(attributeName);
  }

  void onUnknownSetter(String name, Object? value) {
    final String attributeName = name;
    setAttribute<dynamic>(attributeName, value);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.isMethod) {
      return onUnknownMethod(
        invocation.memberName.name,
        invocation.positionalArguments,
        invocation.namedArguments.map(
          (Symbol key, Object? value) =>
              MapEntry<String, Object?>(key.name, value),
        ),
      );
    } else if (invocation.isGetter) {
      return onUnknownGetter(invocation.memberName.name);
    } else if (invocation.isSetter) {
      return onUnknownSetter(
        invocation.memberName.name,
        invocation.positionalArguments.firstOrNull,
      );
    }

    return super.noSuchMethod(invocation);
  }

  void debugDump() {
    // ignore: avoid_print
    print("PythonObject(reference: $_reference, delegate: $_platform)");
  }
}
