import "dart:async";
import "dart:typed_data";

import "package:collection/collection.dart";
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
  final FutureOr<bool> Function(T, T)? equals;

  String get _dartType => dartType ?? T.toString();

  FutureOr<bool> Function(T, T) get _equals => equals ?? (T a, T b) => a == b;

  Future<void> run() async {
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
        final bool equals = await _equals(receivedValue, value);
        assert(equals, "Python returned $receivedValue, but expected $value");
        print("└── python –> dart successful ✅");
      }
    } on Exception catch (e) {
      print("└── ❌ error: $e");
    }
  }
}

Future<void> typeMappings() async {
  final TypeMappingsModule module = TypeMappingsModule.import();

  await TypeMappingEntry<Object?>(
    dartType: "null",
    pythonType: "None",
    value: null,
    sendToPython: module.receive_none,
    receiveFromPython: module.request_none,
  ).run();

  await TypeMappingEntry<bool>(
    dartType: "true",
    pythonType: "True",
    value: true,
    sendToPython: module.receive_bool_true,
    receiveFromPython: module.request_bool_true,
  ).run();

  await TypeMappingEntry<bool>(
    dartType: "false",
    pythonType: "False",
    value: false,
    sendToPython: module.receive_bool_false,
    receiveFromPython: module.request_bool_false,
  ).run();

  await TypeMappingEntry<int>(
    pythonType: "int",
    value: 42,
    sendToPython: module.receive_int,
    receiveFromPython: module.request_int,
  ).run();

  await TypeMappingEntry<double>(
    pythonType: "float",
    value: 3.14,
    sendToPython: module.receive_float,
    receiveFromPython: module.request_float,
  ).run();

  await TypeMappingEntry<String>(
    pythonType: "str",
    value: "Hello World",
    sendToPython: module.receive_str,
    receiveFromPython: module.request_str,
  ).run();

  await TypeMappingEntry<Uint8List>(
    pythonType: "bytes",
    value: Uint8List.fromList("Hello World".codeUnits),
    sendToPython: module.receive_bytes,
    receiveFromPython: module.request_bytes,
  ).run();

  await TypeMappingEntry<Map<String, int>>(
    pythonType: "dict[str, int]",
    value: const <String, int>{"one": 1, "two": 2, "three": 3},
    sendToPython: module.receive_dict,
    receiveFromPython: module.request_dict,
    equals: const MapEquality<String, int>().equals,
  ).run();

  await TypeMappingEntry<List<int>>(
    pythonType: "list[int]",
    value: const <int>[1, 2, 3],
    sendToPython: module.receive_list,
    receiveFromPython: module.request_list,
    equals: (List<int> a, List<int> b) =>
        const ListEquality<int>().equals(a, b),
  ).run();

  await TypeMappingEntry<List<int>>(
    pythonType: "tuple[int]",
    value: const <int>[1, 2, 3],
    // TODO: implement
    // sendToPython: module.receive_tuple,
    receiveFromPython: module.request_tuple,
    equals: (List<int> a, List<int> b) =>
        const ListEquality<int>().equals(a, b),
  ).run();

  await TypeMappingEntry<Set<int>>(
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

  await TypeMappingEntry<Iterable<int>>(
    pythonType: "iterable[int]",
    value: iterable(),
    // TODO: implement
    // sendToPython: module.receive_iterable,
    receiveFromPython: module.request_iterable,
    equals: const IterableEquality<int>().equals,
  ).run();

  await TypeMappingEntry<Iterator<int>>(
    pythonType: "iterator[int]",
    value: iterable().iterator,
    // TODO: implement
    // sendToPython: module.receive_iterator,
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

  await TypeMappingEntry<Iterator<int>>(
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

  await TypeMappingEntry<int Function(int)>(
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

  Future<int> future() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return 1;
  }

  await TypeMappingEntry<Future<int>>(
    pythonType: "Awaitable[int]",
    value: future(),
    // TODO: implement
    sendToPython: module.receive_awaitable,
    receiveFromPython: module.request_awaitable,
    equals: (Future<int> a, Future<int> b) async {
      print("HI 0");
      final DateTime t0 = DateTime.now();
      print("HI 1, a: $a, b: $b");
      final Timer t =
          Timer.periodic(const Duration(milliseconds: 100), (Timer t) {
        if (t.tick > 20) {
          t.cancel();
        }
        print("[${DateTime.now()}] HI 1.5");
      });
      final int aRes = await a;
      t.cancel();
      print("HI 2");
      final DateTime t1 = DateTime.now();
      print("HI 3");
      final int bRes = await b;
      print("HI 4");
      final DateTime t2 = DateTime.now();
      print("aRes: $aRes, bRes: $bRes, t0: $t0, t1: $t1, t2: $t2");
      if (aRes != bRes) {
        return false;
      }
      final Duration da = t1.difference(t0);
      final Duration db = t2.difference(t1);
      final Duration diff = (da - db).abs();
      if (diff.inMilliseconds > 100) {
        return false;
      }
      return true;
    },
  ).run();
}
