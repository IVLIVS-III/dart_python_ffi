part of python_ffi_cpython_dart;

class _PythonClassDefinitionMacos extends PythonClassDefinitionInterface<
    PythonFfiMacOSBase, Pointer<PyObject>> with _PythonObjectMacosMixin {
  _PythonClassDefinitionMacos(super.platform, super.reference)
      : super(
          initializer: _PythonObjectMacosRefcountUtil.initializer,
          finalizer: _PythonObjectMacosRefcountUtil.finalizer,
        );

  @override
  _PythonClassMacos newInstance(
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) {
    final List<_PythonObjectMacos> pyArgs =
        args.map((Object? e) => e._toPythonObject(platform)).toList();
    final Map<String, _PythonObjectMacos> pyKwargs =
        Map<String, _PythonObjectMacos>.fromEntries(
      (kwargs?.entries ?? <MapEntry<String, Object?>>[])
          .map(
            (MapEntry<String, Object?> e) =>
                MapEntry<String, _PythonObjectMacos>(
              e.key,
              e.value._toPythonObject(platform),
            ),
          )
          .toList(),
    );

    final Pointer<PyObject> instance = rawCall(
      args: pyArgs.map((_PythonObjectMacos e) => e.reference).toList(),
      kwargs: pyKwargs.map(
        (String key, _PythonObjectMacos value) =>
            MapEntry<String, Pointer<PyObject>>(key, value.reference),
      ),
    );

    return _PythonClassMacos(platform, instance);
  }

  @override
  T call<T extends Object?>(
    List<Object?> args, {
    Map<String, Object?>? kwargs,
  }) =>
      _PythonObjectMacosMixin.staticCall<T>(
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
      _PythonObjectMacosMixin.staticRawCall(
        platform,
        reference,
        args: args,
        kwargs: kwargs,
      );
}

class _PythonClassMacos
    extends PythonClassInterface<PythonFfiMacOSBase, Pointer<PyObject>>
    with _PythonObjectMacosMixin {
  _PythonClassMacos(super.platform, super.reference)
      : super(
          initializer: _PythonObjectMacosRefcountUtil.initializer,
          finalizer: _PythonObjectMacosRefcountUtil.finalizer,
        );
}
