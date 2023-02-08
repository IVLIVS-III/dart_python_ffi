part of python_ffi_interface;

abstract class PythonObjectInterface<P extends PythonFfiDelegate<R>,
    R extends Object?> {
  PythonObjectInterface(this._platform, this._reference);

  final P _platform;
  final R _reference;

  P get platform => _platform;

  R get reference => _reference;

  Object? toDartObject();

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

  /// Disposes the python object
  void dispose();

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
          (Symbol key, dynamic value) =>
              MapEntry<String, dynamic>(key.name, value),
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
    print("PythonObject(reference: $_reference, delegate: $_platform)");
  }
}
