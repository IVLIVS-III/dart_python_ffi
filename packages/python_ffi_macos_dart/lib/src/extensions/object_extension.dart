part of python_ffi_macos_dart;

extension AddressExtension<T extends NativeType> on Pointer<T> {
  String get hexAddress => address.toRadixString(16);
}

extension ObjectExtension on Pointer<PyObject> {
  String get typeName => typeObject.name;

  Pointer<PyTypeObject> get typeObject {
    final Pointer<PyTypeObject> typeObject = ref.ob_type;
    if (typeObject == nullptr) {
      throw PythonFfiException("Failed to get type object");
    }
    return typeObject;
  }

  bool get isClass {
    print("isClass: $typeName");
    // TODO: this does not seem right, it matches function-types as well
    final String baseType = ref.ob_type.ref.ob_base.ob_base.ob_type.ref.tp_name
        .cast<Utf8>()
        .toDartString();
    return baseType == "type";
  }
}

extension TypeObjectExtension on Pointer<PyTypeObject> {
  int get flags => ref.tp_flags;

  String get name {
    final Pointer<Char> typeName = ref.tp_name;
    if (typeName == nullptr) {
      throw PythonFfiException("Failed to get type name");
    }
    return typeName.cast<Utf8>().toDartString();
  }
}
