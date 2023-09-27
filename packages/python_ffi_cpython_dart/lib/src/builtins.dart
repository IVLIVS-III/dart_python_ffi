part of python_ffi_cpython_dart;

/// Python module definition for some built-in Python functions.
/// This module definition is hand-crafted, thus only contains a subset of
/// the built-in functions.
final class BuiltinsModule extends _PythonModuleCPython {
  /// Wraps a Python module object in a [BuiltinsModule].
  BuiltinsModule.from(
    PythonModuleInterface<PythonFfiDelegate<Object?>, Object?> pythonModule,
  ) : super(
          pythonModule.platform as PythonFfiCPythonBase,
          pythonModule.reference! as Pointer<PyObject>,
        );

  /// Primary constructor for [BuiltinsModule].
  // ignore: prefer_constructors_over_static_methods
  static BuiltinsModule import() =>
      BuiltinsModule.from(PythonFfiDelegate.instance.importModule("builtins"));

  /// The Python `dir` function.
  ///
  /// # Python Documentation
  /// dir([object]) -> list of strings
  ///
  /// If called without an argument, return the names in the current scope.
  /// Else, return an alphabetized list of names comprising (some of) the attributes
  /// of the given object, and of attributes reachable from it.
  /// If the object supplies a method named __dir__, it will be used; otherwise
  /// the default dir() logic is used and returns:
  /// - for a module object: the module's attributes.
  /// - for a class object: its attributes, and recursively the attributes of
  ///   its bases.
  /// - for any other object: its attributes, its class's attributes, and
  ///   recursively the attributes of its class's base classes.
  Object? dir(Object? object) => getFunction("dir").call(<Object?>[object]);

  /// The Python `str` function.
  /// To be correct, this is the `str` class constructor.
  ///
  /// # Python Documentation
  /// str(object='') -> str
  ///
  /// str(bytes_or_buffer[, encoding[, errors]]) -> str
  ///
  /// Create a new string object from the given object. If encoding or
  /// errors is specified, then the object must expose a data buffer
  /// that will be decoded using the given encoding and error handler.
  /// Otherwise, returns the result of object.__str__() (if defined)
  /// or repr(object).
  ///
  /// encoding defaults to sys.getdefaultencoding().
  ///
  /// errors defaults to 'strict'.
  String str(Object? object) => getFunction("str").call(<Object?>[object]);

  /// The Python `repr` function.
  ///
  /// # Python Documentation
  /// repr(obj, /)
  ///
  /// Return the canonical string representation of the object.
  ///
  /// For many object types, including most builtins, eval(repr(obj)) == obj.
  String repr(Object? object) => getFunction("repr").call(<Object?>[object]);

  /// The Python `hash` function.
  ///
  /// # Python Documentation
  /// hash(obj, /)
  ///
  /// Return the hash value for the given object.
  ///
  /// Two objects that compare equal must also have the same hash value, but the
  /// reverse is not necessarily true.
  int hash(Object? object) => getFunction("hash").call(<Object?>[object]);

  /// The Python `type` function.
  /// To be correct, this is the `type` class constructor.
  ///
  /// # Python Documentation
  /// type(object) -> the object's type
  ///
  /// type(name, bases, dict, **kwds) -> a new type
  ///
  /// Note: only the first form is implemented.
  Object? type(Object? object) => getFunction("type").call(<Object?>[object]);
}
