import "dart:typed_data";

import "package:collection/collection.dart";
import "package:python_ffi_dart/python_ffi_dart.dart";
import "package:python_ffi_dart_example/python_modules/type_mappings.dart";

typedef SendTyPythonCallback<T> = void Function(T value);
typedef ReceiveFromPythonCallback<T> = T Function();

class TypeMappingEntry<T extends Object?> {
  const TypeMappingEntry({
    this.dartType,
    required this.pythonType,
    required this.value,
    this.sendToPython,
    this.receiveFromPython,
    this.equals,
  });

  final String? dartType;
  final String pythonType;
  final T value;
  final SendTyPythonCallback<T>? sendToPython;
  final ReceiveFromPythonCallback<T>? receiveFromPython;
  final bool Function(T, T)? equals;

  String get _dartType => dartType ?? T.toString();

  bool Function(T, T) get _equals => equals ?? (T a, T b) => a == b;

  void run() {
    try {
      print("\ntesting $_dartType ←→ $pythonType");
      final SendTyPythonCallback<T>? sendToPython = this.sendToPython;
      if (sendToPython == null) {
        print("├── dart –> python skipped ⚠️");
      } else {
        sendToPython(value);
        print("├── dart –> python successful ✅");
      }

      final ReceiveFromPythonCallback<T>? receiveFromPython =
          this.receiveFromPython;
      if (receiveFromPython == null) {
        print("└── python –> dart skipped ⚠️");
      } else {
        final T receivedValue = receiveFromPython();
        assert(
          _equals(receivedValue, value),
          "Python returned $receivedValue, but expected $value",
        );
        print("└── python –> dart successful ✅");
      }
    } on Exception catch (e) {
      print("└── ❌ error: $e");
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

  TypeMappingEntry<Uint8List>(
    pythonType: "bytes",
    value: Uint8List.fromList("Hello World".codeUnits),
    sendToPython: module.receive_bytes,
    receiveFromPython: module.request_bytes,
  ).run();

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
    equals: (List<int> a, List<int> b) =>
        const ListEquality<int>().equals(a, b),
  ).run();

  TypeMappingEntry<List<int>>(
    pythonType: "tuple[int]",
    value: const <int>[1, 2, 3],
    receiveFromPython: module.request_tuple,
    equals: (List<int> a, List<int> b) =>
        const ListEquality<int>().equals(a, b),
  ).run();

  TypeMappingEntry<PythonTuple<int>>(
    pythonType: "tuple[int]",
    value: PythonTuple<int>.from(
      <int>[1, 2, 3],
    ),
    sendToPython: module.receive_tuple,
    equals: (PythonTuple<int> a, PythonTuple<int> b) =>
        const ListEquality<int>().equals(a, b),
  ).run();

  TypeMappingEntry<Set<int>>(
    pythonType: "set[int]",
    value: const <int>{1, 2, 3},
    sendToPython: module.receive_set,
    receiveFromPython: module.request_set,
    equals: const SetEquality<int>().equals,
  ).run();

  Iterable<int> iterable() sync* {
    yield 1;
    yield 2;
    yield 3;
  }

  TypeMappingEntry<Iterable<int>>(
    pythonType: "iterable[int]",
    value: iterable(),
    sendToPython: module.receive_iterable,
    receiveFromPython: module.request_iterable,
    equals: const IterableEquality<int>().equals,
  ).run();

  TypeMappingEntry<Iterator<int>>(
    pythonType: "iterator[int]",
    value: iterable().iterator,
    sendToPython: module.receive_iterator,
    receiveFromPython: module.request_iterator,
    equals: (Iterator<int> a, Iterator<int> b) {
      while (a.moveNext()) {
        if (!b.moveNext()) {
          return false;
        }
        if (a.current != b.current) {
          return false;
        }
      }
      return !b.moveNext();
    },
  ).run();

  TypeMappingEntry<Iterator<int>>(
    pythonType: "generator[int]",
    value: iterable().iterator,
    receiveFromPython: module.request_generator,
    equals: (Iterator<int> a, Iterator<int> b) {
      while (a.moveNext()) {
        if (!b.moveNext()) {
          return false;
        }
        if (a.current != b.current) {
          return false;
        }
      }
      return !b.moveNext();
    },
  ).run();

  TypeMappingEntry<int Function(int)>(
    pythonType: "Callable[[int], int]",
    value: (int x) {
      assert(x == 1, "Expected 1, but got $x");
      return 2;
    },
    // TODO: implement
    sendToPython: module.receive_callable,
    receiveFromPython: module.request_callable,
    equals: (int Function(int) a, int Function(int) b) => a(1) == b(1),
  ).run();
}
