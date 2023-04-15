part of python_ffi_macos_dart;

/// reference: object.h:328 ff.
///
/// Type flags (tp_flags)
///
/// These flags are used to change expected features and behavior for a
/// particular type.
///
/// Arbitration of the flag bit positions will need to be coordinated among
/// all extension writers who publicly release their extensions (this will
/// be fewer than you might expect!).
///
/// Most flags were removed as of Python 3.0 to make room for new flags.  (Some
/// flags are not for backwards compatibility but to indicate the presence of an
/// optional feature; these flags remain of course.)
///
/// Type definitions should use Py_TPFLAGS_DEFAULT for their tp_flags value.
///
/// Code can use PyType_HasFeature(type_ob, flag_value) to test whether the
/// given type object has a specified feature.

/// reference: object.h:422
// ignore: constant_identifier_names
const int Py_TPFLAGS_DEFAULT = 0;

/// Placement of dict (and values) pointers are managed by the VM, not by the type.
/// The VM will automatically set tp_dictoffset. Should not be used for variable sized
/// classes, such as classes that extend tuple.
///
/// reference: object.h:354
// ignore: constant_identifier_names
const int Py_TPFLAGS_MANAGED_DICT = 1 << 4;

/// Set if instances of the type object are treated as sequences for pattern matching
///
/// reference: object.h:357
// ignore: constant_identifier_names
const int Py_TPFLAGS_SEQUENCE = 1 << 5;

/// Set if instances of the type object are treated as mappings for pattern matching
///
/// reference: object.h:359
// ignore: constant_identifier_names
const int Py_TPFLAGS_MAPPING = 1 << 6;

/// Disallow creating instances of the type: set tp_new to NULL and don't create
/// the "__new__" key in the type dictionary.
///
/// reference: object.h:364
// ignore: constant_identifier_names
const int Py_TPFLAGS_DISALLOW_INSTANTIATION = 1 << 7;

/// Set if the type object is immutable: type attributes cannot be set nor deleted
///
/// reference: object.h:367
// ignore: constant_identifier_names
const int Py_TPFLAGS_IMMUTABLETYPE = 1 << 8;

/// Set if the type object is dynamically allocated
///
/// reference: object.h:370
// ignore: constant_identifier_names
const int Py_TPFLAGS_HEAPTYPE = 1 << 9;

/// Set if the type allows subclassing
///
/// reference: object.h:373
// ignore: constant_identifier_names
const int Py_TPFLAGS_BASETYPE = 1 << 10;

/// Set if the type implements the vectorcall protocol (PEP 590)
///
/// reference: object.h:377
// ignore: constant_identifier_names
const int Py_TPFLAGS_HAVE_VECTORCALL = 1 << 11;

/// Set if the type is 'ready' -- fully initialized
///
/// reference: object.h:383
// ignore: constant_identifier_names
const int Py_TPFLAGS_READY = 1 << 12;

/// Set while the type is being 'readied', to prevent recursive ready calls
///
/// reference: object.h:386
// ignore: constant_identifier_names
const int Py_TPFLAGS_READYING = 1 << 13;

/// Objects support garbage collection (see objimpl.h)
///
/// reference: object.h:389
// ignore: constant_identifier_names
const int Py_TPFLAGS_HAVE_GC = 1 << 14;

/// Objects behave like an unbound method
///
/// reference: object.h:399
// ignore: constant_identifier_names
const int Py_TPFLAGS_METHOD_DESCRIPTOR = 1 << 17;

/// Object has up-to-date type attribute cache
///
/// reference: object.h:402
// ignore: constant_identifier_names
const int Py_TPFLAGS_VALID_VERSION_TAG = 1 << 19;

/// Type is abstract and cannot be instantiated
///
/// reference: object.h:405
// ignore: constant_identifier_names
const int Py_TPFLAGS_IS_ABSTRACT = 1 << 20;

/// This undocumented flag gives certain built-ins their unique pattern-matching
/// behavior, which allows a single positional subpattern to match against the
/// subject itself (rather than a mapped attribute on it):
///
/// reference: object.h:410
// ignore: constant_identifier_names
const int Py_TPFLAGS_MATCH_SELF = 1 << 22;

/// These flags are used to determine if a type is a subclass.
///
/// reference: object.h:413 ff.
// ignore: constant_identifier_names
const int Py_TPFLAGS_LONG_SUBCLASS = 1 << 24;

/// These flags are used to determine if a type is a subclass.
///
/// reference: object.h:413 ff.
// ignore: constant_identifier_names
const int Py_TPFLAGS_LIST_SUBCLASS = 1 << 25;

/// These flags are used to determine if a type is a subclass.
///
/// reference: object.h:413 ff.
// ignore: constant_identifier_names
const int Py_TPFLAGS_TUPLE_SUBCLASS = 1 << 26;

/// These flags are used to determine if a type is a subclass.
///
/// reference: object.h:413 ff.
// ignore: constant_identifier_names
const int Py_TPFLAGS_BYTES_SUBCLASS = 1 << 27;

/// These flags are used to determine if a type is a subclass.
///
/// reference: object.h:413 ff.
// ignore: constant_identifier_names
const int Py_TPFLAGS_UNICODE_SUBCLASS = 1 << 28;

/// These flags are used to determine if a type is a subclass.
///
/// reference: object.h:413 ff.
// ignore: constant_identifier_names
const int Py_TPFLAGS_DICT_SUBCLASS = 1 << 29;

/// These flags are used to determine if a type is a subclass.
///
/// reference: object.h:413 ff.
// ignore: constant_identifier_names
const int Py_TPFLAGS_BASE_EXC_SUBCLASS = 1 << 30;

/// These flags are used to determine if a type is a subclass.
///
/// reference: object.h:413 ff.
// ignore: constant_identifier_names
const int Py_TPFLAGS_TYPE_SUBCLASS = 1 << 31;

extension _ObjectDebugExtension on PyObject {
  Map<String, dynamic> get members => <String, dynamic>{
        "ob_refcnt": ob_refcnt,
        "ob_type": ob_type,
      };
}

extension _VarDebugExtension on PyVarObject {
  Map<String, dynamic> get members => <String, dynamic>{
        "ob_base": ob_base,
        "ob_size": ob_size,
      };
}

extension _TypeDebugExtension on PyTypeObject {
  Map<String, dynamic> get members => <String, dynamic>{
        "ob_base": ob_base,
        "tp_name": tp_name,
        "tp_basicsize": tp_basicsize,
        "tp_itemsize": tp_itemsize,
        "tp_dealloc": tp_dealloc,
        "tp_vectorcall_offset": tp_vectorcall_offset,
        "tp_getattr": tp_getattr,
        "tp_setattr": tp_setattr,
        "tp_as_async": tp_as_async,
        "tp_repr": tp_repr,
        "tp_as_number": tp_as_number,
        "tp_as_sequence": tp_as_sequence,
        "tp_as_mapping": tp_as_mapping,
        "tp_hash": tp_hash,
        "tp_call": tp_call,
        "tp_str": tp_str,
        "tp_getattro": tp_getattro,
        "tp_setattro": tp_setattro,
        "tp_as_buffer": tp_as_buffer,
        "tp_flags": tp_flags,
        "tp_doc": tp_doc,
        "tp_traverse": tp_traverse,
        "tp_clear": tp_clear,
        "tp_richcompare": tp_richcompare,
        "tp_weaklistoffset": tp_weaklistoffset,
        "tp_iter": tp_iter,
        "tp_iternext": tp_iternext,
        "tp_methods": tp_methods,
        "tp_members": tp_members,
        "tp_getset": tp_getset,
        "tp_base": tp_base,
        "tp_dict": tp_dict,
        "tp_descr_get": tp_descr_get,
        "tp_descr_set": tp_descr_set,
        "tp_dictoffset": tp_dictoffset,
        "tp_init": tp_init,
        "tp_alloc": tp_alloc,
        "tp_new": tp_new,
        "tp_free": tp_free,
        "tp_is_gc": tp_is_gc,
        "tp_bases": tp_bases,
        "tp_mro": tp_mro,
        "tp_cache": tp_cache,
        "tp_subclasses": tp_subclasses,
        "tp_del": tp_del,
        "tp_version_tag": tp_version_tag,
        "tp_finalize": tp_finalize,
        "tp_vectorcall": tp_vectorcall,
      };
}

extension _ObjectEqualityExtension on PyObject {
  bool valueEquals(PyObject other) =>
      ob_type.address == other.ob_type.address && ob_refcnt == other.ob_refcnt;
}

extension _VarEqualityExtension on PyVarObject {
  bool valueEquals(PyVarObject other) =>
      this == other ||
      (ob_base.valueEquals(other.ob_base) && ob_size == other.ob_size);
}

extension _TypeEqualityExtension on PyTypeObject {
  bool valueEquals(PyTypeObject other) =>
      this == other ||
      (ob_base.valueEquals(other.ob_base) &&
          tp_name == other.tp_name &&
          tp_basicsize == other.tp_basicsize &&
          tp_itemsize == other.tp_itemsize &&
          tp_dealloc == other.tp_dealloc &&
          tp_vectorcall_offset == other.tp_vectorcall_offset &&
          tp_getattr == other.tp_getattr &&
          tp_setattr == other.tp_setattr &&
          tp_as_async == other.tp_as_async &&
          tp_repr == other.tp_repr &&
          tp_as_number == other.tp_as_number &&
          tp_as_sequence == other.tp_as_sequence &&
          tp_as_mapping == other.tp_as_mapping &&
          tp_hash == other.tp_hash &&
          tp_call == other.tp_call &&
          tp_str == other.tp_str &&
          tp_getattro == other.tp_getattro &&
          tp_setattro == other.tp_setattro &&
          tp_as_buffer == other.tp_as_buffer &&
          tp_flags == other.tp_flags &&
          tp_doc == other.tp_doc &&
          tp_traverse == other.tp_traverse &&
          tp_clear == other.tp_clear &&
          tp_richcompare == other.tp_richcompare &&
          tp_weaklistoffset == other.tp_weaklistoffset &&
          tp_iter == other.tp_iter &&
          tp_iternext == other.tp_iternext &&
          tp_methods == other.tp_methods &&
          tp_members == other.tp_members &&
          tp_getset == other.tp_getset &&
          tp_base == other.tp_base &&
          tp_dict == other.tp_dict &&
          tp_descr_get == other.tp_descr_get &&
          tp_descr_set == other.tp_descr_set &&
          tp_dictoffset == other.tp_dictoffset &&
          tp_init == other.tp_init &&
          tp_alloc == other.tp_alloc &&
          tp_new == other.tp_new &&
          tp_free == other.tp_free &&
          tp_is_gc == other.tp_is_gc &&
          tp_bases == other.tp_bases &&
          tp_mro == other.tp_mro &&
          tp_cache == other.tp_cache &&
          tp_subclasses == other.tp_subclasses &&
          tp_del == other.tp_del &&
          tp_version_tag == other.tp_version_tag &&
          tp_finalize == other.tp_finalize &&
          tp_vectorcall == other.tp_vectorcall);
}

extension _TypeExtension on Pointer<PyObject> {
  bool isNone(PythonFfiMacOSBase platform) =>
      platform.bindings.Py_IsNone(this) == 1;

  bool isTrue(PythonFfiMacOSBase platform) => this == platform.bindings.Py_True;

  bool isFalse(PythonFfiMacOSBase platform) =>
      this == platform.bindings.Py_False;

  bool isBool(PythonFfiMacOSBase platform) =>
      isTrue(platform) || isFalse(platform);

  bool isInt(PythonFfiMacOSBase platform) =>
      (Platform.isWindows && typeName == "int") ||
      (Platform.isMacOS && typeObject.flags & Py_TPFLAGS_LONG_SUBCLASS != 0);

  bool isFloat(PythonFfiMacOSBase platform) =>
      isOfType(platform.bindings.PyFloat_Type);

  bool isList(PythonFfiMacOSBase platform) =>
      (Platform.isWindows && typeName == "list") ||
      (Platform.isMacOS && typeObject.flags & Py_TPFLAGS_LIST_SUBCLASS != 0);

  bool isTuple(PythonFfiMacOSBase platform) =>
      (Platform.isWindows && typeName == "tuple") ||
      (Platform.isMacOS && typeObject.flags & Py_TPFLAGS_TUPLE_SUBCLASS != 0);

  bool isDict(PythonFfiMacOSBase platform) =>
      (Platform.isWindows && typeName == "dict") ||
      (Platform.isMacOS && typeObject.flags & Py_TPFLAGS_DICT_SUBCLASS != 0);

  bool isString(PythonFfiMacOSBase platform) =>
      (Platform.isWindows && typeName == "str") ||
      (Platform.isMacOS && typeObject.flags & Py_TPFLAGS_UNICODE_SUBCLASS != 0);

  bool isBytes(PythonFfiMacOSBase platform) =>
      (Platform.isWindows && typeName == "bytes") ||
      (Platform.isMacOS && typeObject.flags & Py_TPFLAGS_BYTES_SUBCLASS != 0);

  bool isException(PythonFfiMacOSBase platform) =>
      Platform.isMacOS && typeObject.flags & Py_TPFLAGS_BASE_EXC_SUBCLASS != 0;

  bool isType(PythonFfiMacOSBase platform) =>
      (Platform.isWindows && typeName == "type") ||
      (Platform.isMacOS && typeObject.flags & Py_TPFLAGS_TYPE_SUBCLASS != 0);

  bool isSet(PythonFfiMacOSBase platform) =>
      isOfType(platform.bindings.PySet_Type);

  bool isIterator(PythonFfiMacOSBase platform) =>
      platform.bindings.PyIter_Check(this) != 0;

  bool isSequence(PythonFfiMacOSBase platform) =>
      platform.bindings.PySequence_Check(this) == 1;

  bool isIterable(PythonFfiMacOSBase platform) {
    if (isSequence(platform)) {
      return true;
    }
    const String kIterAttributeName = "__iter__";
    try {
      _PythonObjectMacos(platform, this).getFunction(kIterAttributeName);
      return true;
    } on UnknownAttributeException catch (e) {
      if (e.attributeName == kIterAttributeName) {
        return false;
      }
      rethrow;
    }
  }

  bool isFunction(PythonFfiMacOSBase platform) {
    // necessary condition: type(this) == type
    if (isType(platform) ||
        !typeObject.typeObject.isOfType(platform.bindings.PyType_Type)) {
      return false;
    }

    // TODO: determine function without checking the type name
    return typeName == "function";
  }

  bool isModule(PythonFfiMacOSBase platform) {
    // necessary condition: type(this) == type
    if (isType(platform) ||
        !typeObject.typeObject.isOfType(platform.bindings.PyType_Type)) {
      return false;
    }

    // TODO: determine module without checking the type name
    return typeName == "module";
  }

  bool isClass(PythonFfiMacOSBase platform) {
    // type(type(this)) == type
    final bool couldBeType = !isType(platform) &&
        typeObject.typeObject.isOfType(platform.bindings.PyType_Type);
    // exclude functions and modules
    return couldBeType && !isFunction(platform) && !isModule(platform);
  }

  bool isOfType(PyTypeObject type) => typeObject.isOfType(type);
}

extension _TypeTypeExtension on Pointer<PyTypeObject> {
  bool isOfType(PyTypeObject type) => ref.valueEquals(type);

  Pointer<PyTypeObject> get typeObject {
    final Pointer<PyTypeObject> typeObject = ref.ob_base.ob_base.ob_type;
    if (typeObject == nullptr) {
      throw PythonFfiException("Failed to get type object");
    }
    return typeObject;
  }
}
