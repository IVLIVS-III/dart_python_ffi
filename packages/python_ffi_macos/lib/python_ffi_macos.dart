import "dart:async";
import "dart:ffi";
import "dart:io";

import "package:ffi/ffi.dart";
import "package:flutter/services.dart";
import "package:path_provider/path_provider.dart";
import "package:python_ffi_macos/src/class.dart";
import "package:python_ffi_macos/src/exception.dart";
import "package:python_ffi_macos/src/extensions/convert_extension.dart";
import "package:python_ffi_macos/src/extensions/malloc_extension.dart";
import "package:python_ffi_macos/src/ffi/generated_bindings.g.dart";
import "package:python_ffi_macos/src/module.dart";
import "package:python_ffi_macos/src/object.dart";
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
  bool get areBindingsInitialized => _bindings != null;

  /// Checks whether the Python runtime was initialized
  @override
  bool get isInitialized =>
      areBindingsInitialized && bindings.Py_IsInitialized() != 0;

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
    if (!areBindingsInitialized) {
      _openDylib();
    }

    // TODO: move this into the client package
    await _copySingleFileModule("hello_world");
    await _copySingleFileModule("primitives");
    await _copySingleFileModule("structs");

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
        moduleName.toNativeUtf8().useAndFree((Pointer<Utf8> pointer) {
      final Pointer<Char> charPointer = pointer.cast<Char>();
      final Pointer<PyObject> result =
          bindings.PyUnicode_DecodeFSDefault(charPointer);
      return result;
    });
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

  void disposeModule(PythonModuleMacos module) {
    _modules.removeWhere((_, PythonModuleMacos value) => value == module);
  }

  @override
  PythonClassPlatform<PythonFfiPlatform<Pointer<PyObject>>, Pointer<PyObject>>
      importClass(
    String moduleName,
    String className,
    List<Object?> args, [
    Map<String, Object?>? kwargs,
  ]) {
    final PythonModuleMacos module = importModule(moduleName);
    final PythonClassMacos class_ = module.getClass(className, args, kwargs);
    return class_;
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
}
