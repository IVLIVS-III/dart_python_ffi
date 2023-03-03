part of python_ffi_macos_dart;

class PythonFunctionMacos
    extends PythonFunctionInterface<PythonFfiMacOSBase, Pointer<PyObject>>
    with _PythonObjectMacosMixin {
  PythonFunctionMacos(super.platform, super.reference)
      : super(
          initializer: _PythonObjectMacosRefcountUtil.initializer,
          finalizer: _PythonObjectMacosRefcountUtil.finalizer,
        ) {
    // Note: We need to access the __code__.__str__ attribute to ensure that the
    //       code object is not garbage collected before the function object.
    //       If __code__.__str__ is not available, we use __code__.__repr__.
    _ensureCodeObject();
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

  @override
  T asFunction<T extends Function>(TypedFunctionConverter<T> converter) =>
      converter(this);
}
