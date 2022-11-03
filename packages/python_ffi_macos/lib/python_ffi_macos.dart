import "dart:async";
import "dart:ffi";
import "dart:io";

import "package:ffi/ffi.dart";
import "package:flutter/services.dart";
import "package:path_provider/path_provider.dart";
import "package:python_ffi_macos/src/extensions/convert_extension.dart";
import "package:python_ffi_macos/src/extensions/malloc_extension.dart";
import "package:python_ffi_macos/src/ffi/generated_bindings.g.dart";
import "package:python_ffi_platform_interface/python_ffi_platform_interface.dart";

// const String _libName = "libpython3.11";
const String _libPath =
    "/Library/Frameworks/Python.framework/Versions/3.11/Python";

/// The macOS implementation of [PythonFfiPlatform].
class PythonFfiMacOS extends PythonFfiPlatform<Pointer<PyObject>> {
  /// Registers this class as the default instance of [PythonFfiPlatform].
  static void registerWith() {
    PythonFfiPlatform.instance = PythonFfiMacOS();
  }

  /// A handle to the Python C-bindings.
  DartPythonCBindings? _bindings;

  DartPythonCBindings get bindings {
    final DartPythonCBindings? bindings = _bindings;
    if (bindings == null) {
      throw Exception("PythonFfiMacOS not initialized");
    }
    return bindings;
  }

  Directory? _supportDir;

  /// Directory for application support files
  FutureOr<Directory> get supportDir async =>
      _supportDir ??= await getApplicationSupportDirectory();

  Directory? _packagesDir;

  /// Directory for all bundled Python packages
  FutureOr<Directory> get packagesDir async => _packagesDir ??= Directory(
        "${(await supportDir).path}/python_ffi/packages",
      );

  final Map<String, PythonModuleMacos> _modules = <String, PythonModuleMacos>{};

  /// Checks whether the Python C-bindings are available
  bool get isInitialized => _bindings != null;

  /// Checks whether the Python runtime was initialized
  bool get pyInitialized => bindings.Py_IsInitialized() != 0;

  // Attempt to bundle the python library with the app via flutter assets.
  /*
  Future<void> _copyDylib() async {
    const String dylibAssetPath =
        "packages/python_ffi_macos/assets/$_libName.dylib";
    final ByteData dylibAsset =
        await PlatformAssetBundle().load(dylibAssetPath);

    final Directory supportDir = await getApplicationSupportDirectory();
    final File dylibFile = File("${supportDir.path}/python/$_libName.dylib");
    if (!dylibFile.existsSync()) {
      dylibFile.createSync(recursive: true);
    }

    await dylibFile.writeAsBytes(dylibAsset.buffer.asUint8List());

    final DynamicLibrary dylib = DynamicLibrary.open(dylibFile.path);
    _bindings = DartPythonCBindings(dylib);
  }
  */

  void _openDylib() {
    final DynamicLibrary dylib = DynamicLibrary.open(_libPath);
    _bindings = DartPythonCBindings(dylib);
  }

  Future<void> _copySingleFileModule(String moduleName) async {
    final File moduleFile = File("${(await packagesDir).path}/$moduleName.py");
    if (!moduleFile.existsSync()) {
      moduleFile.createSync(recursive: true);
    }

    final ByteData moduleAsset =
        await PlatformAssetBundle().load("python-modules/$moduleName.py");
    await moduleFile.writeAsBytes(moduleAsset.buffer.asUint8List());

    print("Copied module $moduleName to ${moduleFile.path}");
  }

  @override
  Future<void> initialize() async {
    if (!isInitialized) {
      _openDylib();
    }

    await _copySingleFileModule("hello_world");

    bindings.Py_Initialize();

    appendToPath((await packagesDir).path);
  }

  @override
  bool pythonErrorOccurred() => bindings.PyErr_Occurred() != nullptr;

  @override
  void pythonErrorPrint() => bindings.PyErr_Print();

  @override
  void ensureNoPythonError() {
    if (pythonErrorOccurred()) {
      throw PythonExceptionMacos.fetch(this);
    }
  }

  @override
  PythonModuleMacos importModule(String moduleName) {
    final PythonModuleMacos? cachedModule = _modules[moduleName];
    if (cachedModule != null) {
      return cachedModule;
    }

    // convert the module name to a Python string
    final Pointer<PyObject> pythonModuleName =
        moduleName.toNativeUtf8().useAndFree(
              (Pointer<Utf8> pointer) =>
                  bindings.PyUnicode_DecodeFSDefault(pointer.cast<Char>()),
            );

    // import the module
    final Pointer<PyObject> pyImport =
        bindings.PyImport_Import(pythonModuleName);

    // decrease the reference count of the module name,
    // since we no longer need access to this string
    bindings.Py_DecRef(pythonModuleName);

    if (pyImport == nullptr) {
      throw PythonFfiException("Failed to import module $moduleName");
    }

    final PythonModuleMacos module = PythonModuleMacos(this, pyImport);
    _modules[moduleName] = module;

    if (pythonErrorOccurred()) {
      pythonErrorPrint();
      throw PythonFfiException("Failed to import module $moduleName");
    }

    return module;
  }

  void _disposeModule(PythonModuleMacos module) {
    _modules.removeWhere((_, PythonModuleMacos value) => value == module);
  }

  @override
  void appendToPath(String path) {
    final PythonModuleMacos sys = importModule("sys");
    final PythonObjectMacos sysPath = sys.getAttribute("path");

    final PythonObjectMacos pathObject = path.toPythonObject(this);

    final int result =
        bindings.PyList_Append(sysPath.reference, pathObject.reference);

    // decrease the reference count of sys.path,
    // since we no longer need access to this attribute
    sysPath.dispose();

    // unload the sys module again
    sys.dispose();

    if (result != 0) {
      pathObject.dispose();

      if (pythonErrorOccurred()) {
        pythonErrorPrint();
      }

      throw PythonFfiException("Failed to append $path to sys.path");
    }
  }

  @override
  void helloWorld() {
    final PythonModuleMacos helloWorldModule = importModule("hello_world");
    final PythonFunctionMacos helloWorldFunction =
        helloWorldModule.getFunction("hello_world");
    helloWorldFunction();

    // unload the hello_world module again
    helloWorldModule.dispose();
  }
}

class PythonFunctionMacos
    extends PythonFunctionPlatform<PythonFfiMacOS, Pointer<PyObject>>
    with PythonObjectMacosMixin {
  PythonFunctionMacos(super.platform, super.reference);

  Object? call() => null;

  /// Calls the python function with raw pyObject args and kwargs
  Pointer<PyObject> rawCall({
    List<Pointer<PyObject>>? args,
    Map<String, Pointer<PyObject>>? kwargs,
  }) {
    // prepare args
    final int argsLen = args?.length ?? 0;
    final Pointer<PyObject> pArgs = platform.bindings.PyTuple_New(argsLen);
    if (pArgs == nullptr) {
      throw PythonFfiException("Creating argument tuple failed");
    }
    for (int i = 0; i < argsLen; i++) {
      platform.bindings.PyTuple_SetItem(pArgs, i, args![i]);
    }

    // prepare kwargs
    final Pointer<PyObject> pKwargs = nullptr;

    // call function
    final Pointer<PyObject> result =
        platform.bindings.PyObject_Call(reference, pArgs, pKwargs);
    platform.bindings.Py_DecRef(pArgs);

    // check for errors
    platform.ensureNoPythonError();

    return result;
  }
}

class PythonModuleMacos
    extends PythonModulePlatform<PythonFfiMacOS, Pointer<PyObject>>
    with PythonObjectMacosMixin {
  PythonModuleMacos(super.platform, super.reference);

  final Map<String, PythonFunctionMacos> _functions =
      <String, PythonFunctionMacos>{};

  @override
  PythonFunctionMacos getFunction(String functionName) {
    final PythonFunctionMacos? cachedFunction = _functions[functionName];
    if (cachedFunction != null) {
      return cachedFunction;
    }

    final PythonObjectMacos functionAttribute = getAttribute(functionName);
    final PythonFunctionMacos function =
        PythonFunctionMacos(platform, functionAttribute.reference);

    _functions[functionName] = function;

    return function;
  }

  @override
  void dispose() {
    for (final PythonFunctionMacos function in _functions.values) {
      function.dispose();
    }
    _functions.clear();
    platform._disposeModule(this);
    super.dispose();
  }
}

class PythonObjectMacos
    extends PythonObjectPlatform<PythonFfiMacOS, Pointer<PyObject>>
    with PythonObjectMacosMixin {
  PythonObjectMacos(super.platform, super.reference);
}

class PythonExceptionMacos
    extends PythonExceptionPlatform<PythonFfiMacOS, Pointer<PyObject>>
    with PythonObjectMacosMixin {
  PythonExceptionMacos(
    super.platform,
    super.reference,
    this.pValue,
    this.pTraceback,
  );

  factory PythonExceptionMacos.fetch(PythonFfiMacOS platform) {
    final Pointer<Pointer<PyObject>> pTypePtr = malloc<Pointer<PyObject>>();
    final Pointer<Pointer<PyObject>> pValuePtr = malloc<Pointer<PyObject>>();
    final Pointer<Pointer<PyObject>> pTracebackPtr =
        malloc<Pointer<PyObject>>();

    platform.bindings.PyErr_Fetch(pTypePtr, pValuePtr, pTracebackPtr);

    final PythonExceptionMacos pythonException = PythonExceptionMacos(
      platform,
      pTypePtr.value,
      pValuePtr.value,
      pTracebackPtr.value,
    );

    malloc
      ..free(pTypePtr)
      ..free(pValuePtr)
      ..free(pTracebackPtr);

    return pythonException;
  }

  Pointer<PyObject> get pType => reference;
  final Pointer<PyObject> pValue;
  final Pointer<PyObject> pTraceback;

  @override
  String toString() {
    final String typeRepr =
        platform.bindings.PyObject_Repr(pType).asUnicodeString(platform);
    final String valueRepr =
        platform.bindings.PyObject_Repr(pValue).asUnicodeString(platform);
    final String tracebackRepr =
        platform.bindings.PyObject_Repr(pTraceback).asUnicodeString(platform);
    return "PythonExceptionMacos($typeRepr): $valueRepr\n$tracebackRepr";
  }
}

mixin PythonObjectMacosMixin
    on PythonObjectPlatform<PythonFfiMacOS, Pointer<PyObject>> {
  @override
  PythonObjectMacos getAttribute(String attributeName) {
    final Pointer<PyObject> attribute = attributeName.toNativeUtf8().useAndFree(
          (Pointer<Utf8> pointer) => platform.bindings.PyObject_GetAttrString(
            reference,
            pointer.cast<Char>(),
          ),
        );

    if (attribute == nullptr) {
      throw PythonFfiException("Failed to get attribute $attributeName");
    }

    return PythonObjectMacos(platform, attribute);
  }

  @override
  void dispose() {
    platform.bindings.Py_DecRef(reference);
  }
}
