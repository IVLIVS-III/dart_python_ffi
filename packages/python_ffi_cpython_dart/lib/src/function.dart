part of python_ffi_cpython_dart;

final class _PythonFunctionCPython
    extends PythonFunctionInterface<PythonFfiCPythonBase, Pointer<PyObject>>
    with _PythonObjectCPythonMixin {
  _PythonFunctionCPython(super.platform, super.reference)
      : super(
          initializer: _PythonObjectCPythonRefcountUtil.initializer,
          finalizer: _PythonObjectCPythonRefcountUtil.finalizer,
        );

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

  @override
  T asFunction<T extends Function>(TypedFunctionConverter<T> converter) =>
      converter(this);
}
