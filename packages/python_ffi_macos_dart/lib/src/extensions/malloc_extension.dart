part of python_ffi_macos_dart;


extension MallocExtension<T extends NativeType> on Pointer<T> {
  /// Automatically free the memory after using this pointer
  R useAndFree<R>(R Function(Pointer<T> pointer) callback) {
    try {
      return callback(this);
    } finally {
      malloc.free(this);
    }
  }
}
