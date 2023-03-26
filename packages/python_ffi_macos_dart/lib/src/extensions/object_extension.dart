part of python_ffi_macos_dart;

extension _AddressExtension<T extends NativeType> on Pointer<T> {
  String get hexAddress => address.toRadixString(16);
}

extension _ObjectExtension on Pointer<PyObject> {
  String get typeName => typeObject.name;

  Pointer<PyTypeObject> get typeObject {
    final Pointer<PyTypeObject> typeObject = ref.ob_type;
    if (typeObject == nullptr) {
      throw PythonFfiException("Failed to get type object");
    }
    return typeObject;
  }
}

extension _TypeObjectExtension on Pointer<PyTypeObject> {
  int get flags => ref.tp_flags;

  String get name {
    final Pointer<Char> typeName = ref.tp_name;
    if (typeName == nullptr) {
      throw PythonFfiException("Failed to get type name");
    }
    return typeName.cast<Utf8>().toDartString();
  }
}
