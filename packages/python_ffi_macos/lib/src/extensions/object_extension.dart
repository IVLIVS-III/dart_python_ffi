part of python_ffi_macos;


extension AddressExtension<T extends NativeType> on Pointer<T> {
  String get hexAddress => address.toRadixString(16);
}

extension ObjectExtension on Pointer<PyObject> {
  String get typeName {
    final Pointer<PyTypeObject> typeObject = ref.ob_type;
    if (typeObject == nullptr) {
      throw PythonFfiException("Failed to get type object");
    }
    // print("getting typeName from typeObject @${typeObject.hexAddress}");

    final Pointer<Char> typeName = typeObject.ref.tp_name;
    if (typeName == nullptr) {
      throw PythonFfiException("Failed to get type name");
    }
    // print("getting typeName @${typeObject.hexAddress}");

    final String typeNameString = typeName.cast<Utf8>().toDartString();
    // print("got typeNameString $typeNameString");

    return typeNameString;
  }

  bool get isClass {
    debugPrint("isClass: $typeName");
    // TODO: this does not seem right, it matches function-types as well
    final String baseType = ref.ob_type.ref.ob_base.ob_base.ob_type.ref.tp_name
        .cast<Utf8>()
        .toDartString();
    return baseType == "type";
  }
}
