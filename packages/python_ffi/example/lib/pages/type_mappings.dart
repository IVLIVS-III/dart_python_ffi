import "package:collection/collection.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:python_ffi_example/python_modules/type_mappings.dart";

class TypeMappingsPage extends StatelessWidget {
  TypeMappingsPage({Key? key}) : super(key: key);

  final TypeMappingsModule _module = TypeMappingsModule.import();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Type Mappings"),
        ),
        body: ListView(
          children: <Widget>[
            TypeMappingEntry<Object?>(
              dartType: "null",
              pythonType: "None",
              value: null,
              sendToPython: _module.receive_none,
              receiveFromPython: _module.request_none,
            ),
            const Divider(),
            TypeMappingEntry<bool>(
              dartType: "true",
              pythonType: "True",
              value: true,
              sendToPython: _module.receive_bool_true,
              receiveFromPython: _module.request_bool_true,
            ),
            const Divider(),
            TypeMappingEntry<bool>(
              dartType: "false",
              pythonType: "False",
              value: false,
              sendToPython: _module.receive_bool_false,
              receiveFromPython: _module.request_bool_false,
            ),
            const Divider(),
            TypeMappingEntry<int>(
              pythonType: "int",
              value: 42,
              sendToPython: _module.receive_int,
              receiveFromPython: _module.request_int,
            ),
            const Divider(),
            TypeMappingEntry<double>(
              pythonType: "float",
              value: 3.14,
              sendToPython: _module.receive_float,
              receiveFromPython: _module.request_float,
            ),
            const Divider(),
            TypeMappingEntry<String>(
              pythonType: "str",
              value: "Hello World",
              sendToPython: _module.receive_str,
              receiveFromPython: _module.request_str,
            ),
            // TODO: implement bytes / Uint8List / String
            const Divider(),
            TypeMappingEntry<Map<String, int>>(
              pythonType: "dict[str, int]",
              value: const <String, int>{"one": 1, "two": 2, "three": 3},
              sendToPython: _module.receive_dict,
              receiveFromPython: _module.request_dict,
              equals: const MapEquality<String, int>().equals,
            ),
            const Divider(),
            TypeMappingEntry<List<int>>(
              pythonType: "list[int]",
              value: const <int>[1, 2, 3],
              sendToPython: _module.receive_list,
              receiveFromPython: _module.request_list,
              equals: const ListEquality<int>().equals,
            ),
          ],
        ),
      );
}

class TypeMappingEntry<T extends Object?> extends StatelessWidget {
  const TypeMappingEntry({
    Key? key,
    this.dartType,
    required this.pythonType,
    required this.value,
    required this.sendToPython,
    required this.receiveFromPython,
    this.equals,
  }) : super(key: key);

  final String? dartType;
  final String pythonType;
  final T value;
  final Function(T) sendToPython;
  final T Function() receiveFromPython;
  final bool Function(T, T)? equals;

  String get _dartType => dartType ?? T.toString();
  bool Function(T, T) get _equals => equals ?? (T a, T b) => a == b;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text("$_dartType <–> $pythonType"),
        subtitle: Text(
          "$value",
          maxLines: 1,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                sendToPython(value);
                debugPrint("dart –> python successful");
              },
              child: const Text("dart –> python"),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                final T receivedValue = receiveFromPython();
                assert(
                  _equals(receivedValue, value),
                  "Python returned $receivedValue, but expected $value",
                );
                debugPrint("python –> dart successful");
              },
              child: const Text("python –> dart"),
            ),
          ],
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty("pythonType", pythonType))
      ..add(DiagnosticsProperty<T>("value", value))
      ..add(
        ObjectFlagProperty<Function(T p1)>.has("sendToPython", sendToPython),
      )
      ..add(
        ObjectFlagProperty<T Function()>.has(
          "receiveFromPython",
          receiveFromPython,
        ),
      )
      ..add(StringProperty("dartType", dartType))
      ..add(
        ObjectFlagProperty<bool Function(T p1, T p2)?>.has("equals", equals),
      );
  }
}
