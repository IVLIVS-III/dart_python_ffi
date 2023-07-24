// ignore_for_file: non_constant_identifier_names

import "dart:collection";
import "dart:convert";

import "package:python_ffi_cpython_dart/python_ffi_cpython_dart.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";

extension MergeExtension<E> on Iterable<E> {
  Iterable<E> sortedMerge(
    Iterable<E> other,
    int Function(E a, E b) compareTo,
  ) sync* {
    final Iterator<E> iterator = this.iterator;
    final Iterator<E> otherIterator = other.iterator;
    bool hasNext = iterator.moveNext();
    bool otherHasNext = otherIterator.moveNext();
    while (hasNext && otherHasNext) {
      final E current = iterator.current;
      final E otherCurrent = otherIterator.current;
      final int comparison = compareTo(current, otherCurrent);
      if (comparison < 0) {
        yield current;
        hasNext = iterator.moveNext();
      } else if (comparison > 0) {
        yield otherCurrent;
        otherHasNext = otherIterator.moveNext();
      } else {
        yield current;
        hasNext = iterator.moveNext();
        otherHasNext = otherIterator.moveNext();
      }
    }
    while (hasNext) {
      yield iterator.current;
      hasNext = iterator.moveNext();
    }
    while (otherHasNext) {
      yield otherIterator.current;
      otherHasNext = otherIterator.moveNext();
    }
  }
}

enum InspectEntryType {
  module,
  classDefinition,
  class_,
  function,
  object,
  primitive;

  String get displayName {
    switch (this) {
      case InspectEntryType.module:
        return "module";
      case InspectEntryType.classDefinition:
        return "class definition";
      case InspectEntryType.class_:
        return "class instance";
      case InspectEntryType.function:
        return "function";
      case InspectEntryType.object:
        return "object";
      case InspectEntryType.primitive:
        return "primitive";
    }
  }
}

final class InspectionCache {
  InspectionCache._();

  static final Map<Object?, (int, InspectEntry)> _cache =
      <Object?, (int, InspectEntry)>{};

  static InspectionCache? _instance;

  static InspectionCache get instance => _instance ??= InspectionCache._();

  Object? _effectiveKey(Object? key) => switch (key) {
        PythonObjectInterface() => key.reference ?? key,
        _ => key,
      };

  int get _nextId => _cache.length;

  InspectEntry? operator [](Object? key) => _cache[_effectiveKey(key)]?.$2;

  void operator []=(Object? key, InspectEntry value) {
    final Object? effectiveKey = _effectiveKey(key);
    final int id = _cache[effectiveKey]?.$1 ?? _nextId;
    _cache[effectiveKey] = (id, value);
  }

  int? id(Object? key) => _cache[_effectiveKey(key)]?.$1;

  Iterable<(int, InspectEntry)> get entries => _cache.values;
}

abstract interface class InspectEntry {
  String get name;

  Object? get value;

  InspectEntryType get type;

  int? get id;

  Iterable<(String, InspectEntry)> get children;

  void collectChildren();

  String emit();

  Map<String, Object?> debugDump({bool expandChildren = true});
}

base mixin InspectMixin on PythonObjectInterface implements InspectEntry {
  final Map<String, InspectEntry> _children = <String, InspectEntry>{};

  final inspect inspectModule = inspect.import();

  Iterable<(String, Object?)> get _members {
    final InspectMixin object = this;
    final Iterable<(String, Object?)> dynamicMembers =
        inspectModule.getmembers(object);
    final Iterable<(String, Object?)> staticMembers =
        inspectModule.getmembers_static(object);
    return dynamicMembers.sortedMerge(
      staticMembers,
      ((String, Object?) a, (String, Object?) b) => a.$1.compareTo(b.$1),
    );
  }

  Object? get parentModule => inspectModule.getmodule(value);

  @override
  int? get id => InspectionCache.instance.id(value);

  Iterable<(String, InspectEntry)> get children => _children.entries
      .map((MapEntry<String, InspectEntry> e) => (e.key, e.value));

  @override
  void collectChildren() {
    final inspect inspectModule = inspect.import();
    final InspectEntry? selfCached = InspectionCache.instance[value];
    if (selfCached == null) {
      InspectionCache.instance[value] = this;
    }
    for (final (String name, Object? value) in _members) {
      /*
      if (name.startsWith("_")) {
        continue;
      }
      */
      try {
        if (inspectModule.ismethodwrapper(value)) {
          continue;
        }
        if (inspectModule.isbuiltin(value)) {
          continue;
        }
      } on PythonExceptionInterface catch (e, stackTrace) {
        // ignore
        print(e);
        print(stackTrace);
      }
      final InspectEntry? cached = InspectionCache.instance[value];
      if (cached != null) {
        _children[name] = cached;
        continue;
      }
      final InspectEntry child = switch (value) {
        PythonModuleInterface() when inspectModule.ismodule(value) =>
          ModuleInspect.from(name, value),
        PythonModuleInterface() =>
          throw Exception("'$name' is not a module: $value"),
        PythonClassDefinitionInterface() when inspectModule.isclass(value) =>
          ClassDefinitionInspect.from(name, value),
        PythonClassInterface() => ClassInspect.from(name, value),
        PythonFunctionInterface() when inspectModule.isfunction(value) =>
          FunctionInspect.from(name, value),
        PythonFunctionInterface() =>
          throw Exception("'$name' is not a function: $value"),
        PythonObjectInterface() => ObjectInspect.from(name, value),
        _ => PrimitiveInspect(name, value),
      } as InspectEntry;
      InspectionCache.instance[value] = child;
      _children[name] = child;
      child.collectChildren();
    }
  }

  @override
  String emit() {
    throw UnimplementedError("$runtimeType.emit");
  }

  @override
  Map<String, Object?> debugDump({bool expandChildren = true}) =>
      <String, Object?>{
        "_id": id,
        "name": name,
        "value": value,
        "type": type.displayName,
        "parentModule": parentModule,
        "doc": inspectModule.getdoc(value),
        if (expandChildren)
          "children": Map<String, Map<String, Object?>>.fromEntries(
            children.map(
              ((String, InspectEntry) e) =>
                  MapEntry<String, Map<String, Object?>>(
                e.$1,
                e.$2.debugDump(expandChildren: id == null),
              ),
            ),
          ),
      };
}

final class ModuleInspect extends PythonModule
    with InspectMixin
    implements InspectEntry {
  ModuleInspect.from(this.name, super.moduleDelegate)
      : value = moduleDelegate,
        super.from();

  final String name;

  final PythonModuleInterface value;

  @override
  InspectEntryType get type => InspectEntryType.module;
}

final class ClassDefinitionInspect extends PythonClassDefinition
    with InspectMixin
    implements InspectEntry {
  ClassDefinitionInspect.from(this.name, super.classDefinitionDelegate)
      : value = classDefinitionDelegate,
        super.from();

  final String name;

  final PythonClassDefinitionInterface value;

  @override
  InspectEntryType get type => InspectEntryType.classDefinition;
}

final class ClassInspect extends PythonClass
    with InspectMixin
    implements InspectEntry {
  ClassInspect.from(this.name, super.classDelegate)
      : value = classDelegate,
        super.from();

  final String name;

  final PythonClassInterface value;

  @override
  InspectEntryType get type => InspectEntryType.class_;
}

final class FunctionInspect extends PythonFunction
    with InspectMixin
    implements InspectEntry {
  FunctionInspect.from(this.name, super.functionDelegate)
      : value = functionDelegate,
        super.from();

  final String name;

  final PythonFunctionInterface value;

  @override
  InspectEntryType get type => InspectEntryType.function;

  Signature get signature => inspectModule.signature(value);

  @override
  debugDump({bool expandChildren = true}) => <String, Object?>{
        ...super.debugDump(expandChildren: expandChildren),
        "signature": signature.debugDump(),
      };
}

final class ObjectInspect extends PythonObject
    with InspectMixin
    implements InspectEntry {
  ObjectInspect.from(this.name, super.objectDelegate)
      : value = objectDelegate,
        super.from();

  final String name;

  final PythonObjectInterface value;

  @override
  InspectEntryType get type => InspectEntryType.object;
}

final class PrimitiveInspect implements InspectEntry {
  const PrimitiveInspect(this.name, this.value);

  final String name;

  final Object? value;

  @override
  InspectEntryType get type => InspectEntryType.primitive;

  @override
  int? get id => InspectionCache.instance.id(value);

  @override
  Iterable<(String, InspectEntry)> get children =>
      const <(String, InspectEntry)>[];

  @override
  void collectChildren() {}

  @override
  String emit() {
    throw UnimplementedError("$runtimeType.emit");
  }

  @override
  Map<String, Object?> debugDump({bool expandChildren = true}) =>
      <String, Object?>{
        "name": name,
        "value": value,
        "type": type.displayName,
      };
}

Future<void> doInspection(
  PythonModuleDefinition moduleDefinition, {
  required String appType,
}) async {
  print(
    "Generating Dart interface for ${moduleDefinition.name} via inspect...",
  );
  await PythonFfiDart.instance.prepareModule(moduleDefinition);
  final ModuleInspect interface = PythonFfiDart.instance.importModule(
    moduleDefinition.name,
    (PythonModuleInterface<PythonFfiDelegate<Object?>, Object?> m) =>
        ModuleInspect.from(moduleDefinition.name, m),
  )..collectChildren();
  final String json = jsonEncode(
    <String, Object?>{
      "_module": interface.debugDump(),
      "_entries": InspectionCache.instance.entries
          .map(
            ((int, InspectEntry) e) => <String, Object?>{
              "id": e.$1,
              "entry": e.$2.debugDump(),
            },
          )
          .toList(),
    },
    toEncodable: (Object? o) => o.toString(),
  );
  print(json);
}

final class inspect extends PythonModule {
  inspect.from(super.moduleDelegate) : super.from();

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

  /// Return `true` if the object is a class.
  bool isclass(Object? object) =>
      getFunction("isclass").call(<Object?>[object]);

  /// Return `true` if the object is a method.
  bool ismethod(Object? object) =>
      getFunction("ismethod").call(<Object?>[object]);

  /// Return `true` if the object is a function.
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

  /// Try to guess which module an object was defined in. Return `null` if the
  /// module cannot be determined.
  PythonModuleInterface? getmodule(Object? object) =>
      getFunction("getmodule").call(<Object?>[object]);

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
    PythonFunctionInterface callable, {
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

final class _SignatureClassDefinition extends PythonClassDefinition {
  _SignatureClassDefinition.from(super.classDefinitionDelegate) : super.from();
}

/// The [Signature] object represents the call signature of a callable object
/// and its return annotation. To retrieve a [Signature] object, use the
/// [inspect.signature] function.
///
/// Reference: https://docs.python.org/3/library/inspect.html#inspect.Signature
final class Signature extends PythonClass {
  Signature.from(super.classDelegate) : super.from();

  /// A special class-level marker to specify absence of a return annotation.
  static Object? get empty {
    final inspect inspectModule = inspect.import();
    final _SignatureClassDefinition signatureClass =
        _SignatureClassDefinition.from(inspectModule.getAttribute("Signature"));
    return signatureClass.getAttribute("empty");
  }

  Iterable<String> get _parameterNames =>
      getAttribute<Iterable<Object?>>("parameters").whereType();

  /// An ordered mapping of parameters’ names to the corresponding [Parameter]
  /// objects. Parameters appear in strict definition order, including
  /// keyword-only parameters.
  ///
  /// *Changed in version 3.7:* Python only explicitly guaranteed that it
  /// preserved the declaration order of keyword-only parameters as of version
  /// 3.7, although in practice this order had always been preserved in
  /// Python 3.
  UnmodifiableMapView<String, Parameter> get parameters {
    final PythonObjectInterface<PythonFfiCPythonBase, Pointer<PyObject>>
        parameters = getAttributeRaw("parameters");
    final itemGetter = parameters.getFunction("__getitem__");
    return UnmodifiableMapView<String, Parameter>(
      Map<String, Parameter>.fromEntries(
        _parameterNames.map(
          (String name) => MapEntry<String, Parameter>(
            name,
            Parameter.from(itemGetter(<Object?>[name])),
          ),
        ),
      ),
    );
  }

  /// The “return” annotation for the callable. If the callable has no “return”
  /// annotation, this attribute is set to [Signature.empty].
  Object? get return_annotation => getAttribute("return_annotation");

  Map<String, Object?> debugDump() => <String, Object?>{
        "parameters": parameters.map(
          (String key, Parameter value) =>
              MapEntry<String, Map<String, Object?>>(key, value.debugDump()),
        ),
        "return_annotation": return_annotation,
      };
}

final class _ParameterClassDefinition extends PythonClassDefinition {
  _ParameterClassDefinition.from(super.classDefinitionDelegate) : super.from();
}

enum ParameterKind {
  positional_only,
  positional_or_keyword,
  var_positional,
  keyword_only,
  var_keyword,
}

/// Reference: https://docs.python.org/3/library/inspect.html#inspect.Parameter
final class Parameter extends PythonClass {
  Parameter.from(super.classDelegate) : super.from();

  /// A special class-level marker to specify absence of default values and
  /// annotations.
  static Object? get empty {
    final inspect inspectModule = inspect.import();
    final _ParameterClassDefinition parameterClass =
        _ParameterClassDefinition.from(inspectModule.getAttribute("Parameter"));
    return parameterClass.getAttribute("empty");
  }

  /// Value must be supplied as a positional argument. Positional only
  /// parameters are those which appear before a / entry (if present) in a
  /// Python function definition.
  static Object? get POSITIONAL_ONLY {
    final inspect inspectModule = inspect.import();
    final _ParameterClassDefinition parameterClass =
        _ParameterClassDefinition.from(inspectModule.getAttribute("Parameter"));
    return parameterClass.getAttribute("POSITIONAL_ONLY");
  }

  /// Value may be supplied as either a keyword or positional argument (this is
  /// the standard binding behaviour for functions implemented in Python.)
  static Object? get POSITIONAL_OR_KEYWORD {
    final inspect inspectModule = inspect.import();
    final _ParameterClassDefinition parameterClass =
        _ParameterClassDefinition.from(inspectModule.getAttribute("Parameter"));
    return parameterClass.getAttribute("POSITIONAL_OR_KEYWORD");
  }

  /// A tuple of positional arguments that aren’t bound to any other parameter.
  /// This corresponds to a *args parameter in a Python function definition.
  static Object? get VAR_POSITIONAL {
    final inspect inspectModule = inspect.import();
    final _ParameterClassDefinition parameterClass =
        _ParameterClassDefinition.from(inspectModule.getAttribute("Parameter"));
    return parameterClass.getAttribute("VAR_POSITIONAL");
  }

  /// Value must be supplied as a keyword argument. Keyword only parameters are
  /// those which appear after a * or *args entry in a Python function
  /// definition.
  static Object? get KEYWORD_ONLY {
    final inspect inspectModule = inspect.import();
    final _ParameterClassDefinition parameterClass =
        _ParameterClassDefinition.from(inspectModule.getAttribute("Parameter"));
    return parameterClass.getAttribute("KEYWORD_ONLY");
  }

  /// A dict of keyword arguments that aren’t bound to any other parameter. This
  /// corresponds to a **kwargs parameter in a Python function definition.
  static Object? get VAR_KEYWORD {
    final inspect inspectModule = inspect.import();
    final _ParameterClassDefinition parameterClass =
        _ParameterClassDefinition.from(inspectModule.getAttribute("Parameter"));
    return parameterClass.getAttribute("VAR_KEYWORD");
  }

  /// The name of the parameter as a string. The name must be a valid Python
  /// identifier.
  String get name => getAttribute("name");

  /// The default value for the parameter. If the parameter has no default
  /// value, this attribute is set to [Parameter.empty].
  Object? get default_ => getAttribute("default");

  /// The annotation for the parameter. If the parameter has no annotation,
  /// this attribute is set to [Parameter.empty].
  Object? get annotation => getAttribute("annotation");

  /// Describes how argument values are bound to the parameter. The possible
  /// values are accessible via Parameter (like Parameter.KEYWORD_ONLY), and
  /// support comparison and ordering, in the following order:
  ParameterKind get kind {
    final Object? kind = getAttribute("kind");
    if (kind == POSITIONAL_ONLY) {
      return ParameterKind.positional_only;
    }
    if (kind == POSITIONAL_OR_KEYWORD) {
      return ParameterKind.positional_or_keyword;
    }
    if (kind == VAR_POSITIONAL) {
      return ParameterKind.var_positional;
    }
    if (kind == KEYWORD_ONLY) {
      return ParameterKind.keyword_only;
    }
    if (kind == VAR_KEYWORD) {
      return ParameterKind.var_keyword;
    }
    throw UnimplementedError();
  }

  Map<String, Object?> debugDump() => <String, Object?>{
        "name": name,
        "default": default_,
        "annotation": annotation,
        "kind": kind.name,
      };
}
