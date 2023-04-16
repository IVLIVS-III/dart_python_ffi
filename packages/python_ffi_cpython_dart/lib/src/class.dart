part of python_ffi_cpython_dart;

class _PythonClassDefinitionCPython extends PythonClassDefinitionInterface<
    PythonFfiCPythonBase, Pointer<PyObject>> with _PythonObjectCPythonMixin {
  _PythonClassDefinitionCPython(super.platform, super.reference)
      : super(
          initializer: _PythonObjectCPythonRefcountUtil.initializer,
          finalizer: _PythonObjectCPythonRefcountUtil.finalizer,
        );

  @override
  _PythonClassCPython newInstance(
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) {
    final List<_PythonObjectCPython> pyArgs =
        args.map((Object? e) => e._toPythonObject(platform)).toList();
    final Map<String, _PythonObjectCPython> pyKwargs =
        Map<String, _PythonObjectCPython>.fromEntries(
      (kwargs?.entries ?? <MapEntry<String, Object?>>[])
          .map(
            (MapEntry<String, Object?> e) =>
                MapEntry<String, _PythonObjectCPython>(
              e.key,
              e.value._toPythonObject(platform),
            ),
          )
          .toList(),
    );

    final Pointer<PyObject> instance = rawCall(
      args: pyArgs.map((_PythonObjectCPython e) => e.reference).toList(),
      kwargs: pyKwargs.map(
        (String key, _PythonObjectCPython value) =>
            MapEntry<String, Pointer<PyObject>>(key, value.reference),
      ),
    );

    return _PythonClassCPython(platform, instance);
  }

  @override
  T call<T extends Object?>(
    List<Object?> args, {
    Map<String, Object?>? kwargs,
  }) =>
      _PythonObjectCPythonMixin.staticCall<T>(
        platform,
        reference,
        args,
        kwargs: kwargs,
      );

  @override
  Pointer<PyObject> rawCall({
    List<Pointer<PyObject>>? args,
    Map<String, Pointer<PyObject>>? kwargs,
  }) =>
      _PythonObjectCPythonMixin.staticRawCall(
        platform,
        reference,
        args: args,
        kwargs: kwargs,
      );
}

class _PythonClassCPython
    extends PythonClassInterface<PythonFfiCPythonBase, Pointer<PyObject>>
    with _PythonObjectCPythonMixin {
  _PythonClassCPython(super.platform, super.reference)
      : super(
          initializer: _PythonObjectCPythonRefcountUtil.initializer,
          finalizer: _PythonObjectCPythonRefcountUtil.finalizer,
        );
}
