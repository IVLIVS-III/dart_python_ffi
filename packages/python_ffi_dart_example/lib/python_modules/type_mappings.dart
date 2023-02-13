// ignore_for_file: non_constant_identifier_names
import "dart:typed_data";

import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:python_ffi_dart_example/python_modules/src/type_mappings.py.dart"
    as type_mappings_py;

class TypeMappingsModule extends PythonModule {
  TypeMappingsModule.from(super.pythonModule) : super.from();

  static TypeMappingsModule import() => PythonModule.import(
        "type_mappings",
        TypeMappingsModule.from,
      );

  void receive_none(Object? _) =>
      getFunction("receive_none").call(<Object?>[null]);

  Object? request_none() => getFunction("request_none").call(<Object?>[]);

  // ignore: avoid_positional_boolean_parameters
  void receive_bool_true(bool value) =>
      getFunction("receive_bool_true").call(<Object?>[value]);

  bool request_bool_true() =>
      getFunction("request_bool_true").call(<Object?>[]);

  // ignore: avoid_positional_boolean_parameters
  void receive_bool_false(bool value) =>
      getFunction("receive_bool_false").call(<Object?>[value]);

  bool request_bool_false() =>
      getFunction("request_bool_false").call(<Object?>[]);

  void receive_int(int value) =>
      getFunction("receive_int").call(<Object?>[value]);

  int request_int() => getFunction("request_int").call(<Object?>[]);

  void receive_float(double value) =>
      getFunction("receive_float").call(<Object?>[value]);

  double request_float() => getFunction("request_float").call(<Object?>[]);

  void receive_str(String value) =>
      getFunction("receive_str").call(<Object?>[value]);

  String request_str() => getFunction("request_str").call(<Object?>[]);

  void receive_bytes(Uint8List value) =>
      getFunction("receive_bytes").call(<Object?>[value]);

  Uint8List request_bytes() => getFunction("request_bytes").call(<Object?>[]);

  void receive_dict(Map<String, int> value) =>
      getFunction("receive_dict").call(<Object?>[value]);

  Map<String, int> request_dict() =>
      Map<String, int>.from(getFunction("request_dict").call(<Object?>[]));

  void receive_list(List<int> value) =>
      getFunction("receive_list").call(<Object?>[value]);

  List<int> request_list() =>
      List<int>.from(getFunction("request_list").call(<Object?>[]));

  void receive_set(Set<int> value) =>
      getFunction("receive_set").call(<Object?>[value]);

  Set<int> request_set() =>
      Set<int>.from(getFunction("request_set").call(<Object?>[]));

  void receive_iterator(Iterator<int> value) =>
      getFunction("receive_iterator").call(<Object?>[value]);

  Iterator<int> request_iterator() => TypedIterator<int>.from(
        getFunction("request_iterator").call(<Object?>[]),
      );

  Iterator<int> request_generator() => TypedIterator<int>.from(
        getFunction("request_generator").call(<Object?>[]),
      );

  void receive_iterable(Iterable<int> value) =>
      getFunction("receive_iterable").call(<Object?>[value]);

  Iterable<int> request_iterable() => TypedIterable<int>.from(
        getFunction("request_iterable").call(<Object?>[]),
      );

  static PythonModuleDefinition get definition => PythonModuleDefinition(
        name: "type_mappings",
        root: SourceBase64("type_mappings.py", type_mappings_py.kBase64),
        classNames: classNames,
      );

  static Iterable<String> get classNames => const <String>[];
}
