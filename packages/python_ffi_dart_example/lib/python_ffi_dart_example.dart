import "package:collection/collection.dart";
import "package:python_ffi_dart_example/python_modules/type_mappings.dart";

class TypeMappingEntry<T extends Object?> {
  const TypeMappingEntry({
    this.dartType,
    required this.pythonType,
    required this.value,
    required this.sendToPython,
    required this.receiveFromPython,
    this.equals,
  });

  final String? dartType;
  final String pythonType;
  final T value;
  final Function(T) sendToPython;
  final T Function() receiveFromPython;
  final bool Function(T, T)? equals;

  String get _dartType => dartType ?? T.toString();

  bool Function(T, T) get _equals => equals ?? (T a, T b) => a == b;

  void run() {
    try {
      print("\ntesting $_dartType ←→ $pythonType");
      sendToPython(value);
      print("├── dart –> python successful");
      final T receivedValue = receiveFromPython();
      assert(
        _equals(receivedValue, value),
        "Python returned $receivedValue, but expected $value",
      );
      print("└── python –> dart successful");
    } on Exception catch (e) {
      print("└── error: $e");
    }
  }
}

Future<void> typeMappings() async {
  final TypeMappingsModule module = TypeMappingsModule.import();

  TypeMappingEntry<Object?>(
    dartType: "null",
    pythonType: "None",
    value: null,
    sendToPython: module.receive_none,
    receiveFromPython: module.request_none,
  ).run();

  TypeMappingEntry<bool>(
    dartType: "true",
    pythonType: "True",
    value: true,
    sendToPython: module.receive_bool_true,
    receiveFromPython: module.request_bool_true,
  ).run();

  TypeMappingEntry<bool>(
    dartType: "false",
    pythonType: "False",
    value: false,
    sendToPython: module.receive_bool_false,
    receiveFromPython: module.request_bool_false,
  ).run();

  TypeMappingEntry<int>(
    pythonType: "int",
    value: 42,
    sendToPython: module.receive_int,
    receiveFromPython: module.request_int,
  ).run();

  TypeMappingEntry<double>(
    pythonType: "float",
    value: 3.14,
    sendToPython: module.receive_float,
    receiveFromPython: module.request_float,
  ).run();

  TypeMappingEntry<String>(
    pythonType: "str",
    value: "Hello World",
    sendToPython: module.receive_str,
    receiveFromPython: module.request_str,
  ).run();

  // TODO: implement bytes / Uint8List / String

  TypeMappingEntry<Map<String, int>>(
    pythonType: "dict[str, int]",
    value: const <String, int>{"one": 1, "two": 2, "three": 3},
    sendToPython: module.receive_dict,
    receiveFromPython: module.request_dict,
    equals: const MapEquality<String, int>().equals,
  ).run();

  TypeMappingEntry<List<int>>(
    pythonType: "list[int]",
    value: const <int>[1, 2, 3],
    sendToPython: module.receive_list,
    receiveFromPython: module.request_list,
    equals: const ListEquality<int>().equals,
  ).run();

  TypeMappingEntry<Set<int>>(
    pythonType: "set[int]",
    value: const <int>{1, 2, 3},
    sendToPython: module.receive_set,
    receiveFromPython: module.request_set,
    equals: const SetEquality<int>().equals,
  ).run();
}
