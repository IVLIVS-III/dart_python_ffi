// ignore_for_file: non_constant_identifier_names, camel_case_types

part of inspect;

/// TODO: Document.
final class inspect extends PythonModule {
  /// TODO: Document.
  inspect.from(super.moduleDelegate) : super.from();

  /// TODO: Document.
  static inspect import() => PythonFfiDart.instance.importModule(
        "inspect",
        inspect.from,
      );

  /// Return all the members of an object in a list of `(name, value)` pairs
  /// sorted by name. If the optional [predicate] argument — which will be
  /// called with the value object of each member — is supplied, only members
  /// for which the predicate returns a true value are included.
  ///
  /// **Note:** [getmembers] will only return class attributes defined in the
  /// metaclass when the argument is a class and those attributes have been
  /// listed in the metaclass’ custom `__dir__()`.
  Iterable<(String, Object?)> getmembers(
    Object? object, [
    bool Function(Object? value)? predicate,
  ]) =>
      getFunction("getmembers")
          .call<List<dynamic>>(<Object?>[
            object,
            if (predicate != null) predicate,
          ])
          .whereType<List<Object?>>()
          .where((List<Object?> element) => element.length == 2)
          .map((List<Object?> e) => (e.first, e.last))
          .whereType();

  /// Return all the members of an object in a list of `(name, value)` pairs
  /// sorted by name without triggering dynamic lookup via the descriptor
  /// protocol, __getattr__ or __getattribute__. Optionally, only return members
  /// that satisfy a given [predicate].
  ///
  /// **Note:** [getmembers_static] may not be able to retrieve all members that
  /// [getmembers] can fetch (like dynamically created attributes) and may find
  /// members that [getmembers] can’t (like descriptors that raise
  /// AttributeError). It can also return descriptor objects instead of instance
  /// members in some cases.
  Iterable<(String, Object?)> getmembers_static(
    Object? object, [
    bool Function(Object? value)? predicate,
  ]) =>
      getFunction("getmembers_static")
          .call<List<dynamic>>(<Object?>[
            object,
            if (predicate != null) predicate,
          ])
          .whereType<List<Object?>>()
          .where((List<Object?> element) => element.length == 2)
          .map((List<Object?> e) => (e.first, e.last))
          .whereType();

  /// Return `true` if the object is a module.
  bool ismodule(Object? object) =>
      getFunction("ismodule").call(<Object?>[object]);

  /// Return `true` if the object is a class, whether built-in or created in Python code.
  bool isclass(Object? object) =>
      getFunction("isclass").call(<Object?>[object]);

  /// Return `true` if the object is a bound method written in Python.
  bool ismethod(Object? object) =>
      getFunction("ismethod").call(<Object?>[object]);

  /// Return `true` if the object is a Python function, which includes functions
  /// created by a lambda expression.
  bool isfunction(Object? object) =>
      getFunction("isfunction").call(<Object?>[object]);

  /// Return `true` if the object is a built-in function or a bound built-in
  /// method.
  bool isbuiltin(Object? object) =>
      getFunction("isbuiltin").call(<Object?>[object]);

  /// Return `true` if the type of object is a
  /// [MethodWrapperType](https://docs.python.org/3/library/types.html#types.MethodWrapperType).
  ///
  /// These are instances of
  /// [MethodWrapperType](https://docs.python.org/3/library/types.html#types.MethodWrapperType),
  /// such as [`__str__()`](https://docs.python.org/3/reference/datamodel.html#object.__str__),
  /// [`__eq__()`](https://docs.python.org/3/reference/datamodel.html#object.__eq__)
  /// and
  /// [`__repr__()`](https://docs.python.org/3/reference/datamodel.html#object.__repr__).
  bool ismethodwrapper(Object? object) =>
      getFunction("ismethodwrapper").call(<Object?>[object]);

  /// Get the documentation string for an object, cleaned up with [cleandoc].
  /// If the documentation string for an object is not provided and the object
  /// is a class, a method, a property or a descriptor, retrieve the
  /// documentation string from the inheritance hierarchy. Return `null` if the
  /// documentation string is invalid or missing.
  String? getdoc(Object? object) =>
      getFunction("getdoc").call(<Object?>[object]);

  /// Return the name of the (text or binary) file in which an object was
  /// defined. This will fail with a TypeError if the object is a built-in
  /// module, class, or function.
  String? getfile(Object? object) =>
      getFunction("getfile").call(<Object?>[object]);

  /// Try to guess which module an object was defined in. Return `null` if the
  /// module cannot be determined.
  PythonModuleInterface<PythonFfiDelegate<Object?>, Object?>? getmodule(
    Object? object,
  ) =>
      getFunction("getmodule").call(<Object?>[object]);

  /// Return the text of the source code for an object. The argument may be a
  /// module, class, method, function, traceback, frame, or code object. The
  /// source code is returned as a single string. An OSError is raised if the
  /// source code cannot be retrieved. A TypeError is raised if the object is a
  /// built-in module, class, or function.
  String? getsource(Object? object) {
    try {
      return getFunction("getsource").call(<Object?>[object]);
    } on PythonExceptionInterface<PythonFfiDelegate<Object?>,
        Object?> catch (e) {
      if (e.type == "TypeError") {
        DartpipCommandRunner.logger.trace(
          "Cannot get source for built-in module, class, or function: $object",
        );
        return null;
      }
      if (e.type == "OSError") {
        DartpipCommandRunner.logger.trace("Cannot get source for $object: $e");
        return null;
      }
      rethrow;
    } on PythonFfiException catch (e) {
      DartpipCommandRunner.logger.trace("Cannot get source for $object: $e");
      return null;
    }
  }

  /// Clean up indentation from docstrings that are indented to line up with
  /// blocks of code.
  ///
  /// All leading whitespace is removed from the first line. Any leading
  /// whitespace that can be uniformly removed from the second line onwards is
  /// removed. Empty lines at the beginning and end are subsequently removed.
  /// Also, all tabs are expanded to spaces.
  String cleandoc(String doc) => getFunction("cleandoc").call(<Object?>[doc]);

  /// Return a [Signature] object for the given [callable] :
  ///
  /// ```py
  /// >>> from inspect import signature
  /// >>> def foo(a, *, b:int, **kwargs):
  /// ...     pass
  ///
  /// >>> sig = signature(foo)
  ///
  /// >>> str(sig)
  /// '(a, *, b:int, **kwargs)'
  ///
  /// >>> str(sig.parameters['b'])
  /// 'b:int'
  ///
  /// >>> sig.parameters['b'].annotation
  /// <class 'int'>
  /// ```
  /// Accepts a wide range of Python callables, from plain functions and classes
  /// to
  /// [`functools.partial()`](https://docs.python.org/3/library/functools.html#functools.partial)
  /// objects.
  ///
  /// Reference: https://docs.python.org/3/library/inspect.html#inspect.signature
  Signature signature(
    PythonFunctionInterface<PythonFfiDelegate<Object?>, Object?> callable, {
    bool follow_wrapped = true,
    Object? globals,
    Object? locals,
    bool eval_str = false,
  }) =>
      Signature.from(
        getFunction("signature").call(
          <Object?>[callable],
          kwargs: <String, Object?>{
            "follow_wrapped": follow_wrapped,
            "globals": globals,
            "locals": locals,
            "eval_str": eval_str,
          },
        ),
      );
}
