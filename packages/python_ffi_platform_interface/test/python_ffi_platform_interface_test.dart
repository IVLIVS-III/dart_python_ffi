import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:python_ffi_platform_interface/python_ffi_method_channel.dart';
import 'package:python_ffi_platform_interface/python_ffi_platform_interface.dart';
import 'package:python_ffi_platform_interface/python_ffi_platform_interface.dart';

class MockPythonFfiPlatformInterfacePlatform
    with MockPlatformInterfaceMixin
    implements PythonFfiPlatformInterfacePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PythonFfiPlatformInterfacePlatform initialPlatform =
      PythonFfiPlatformInterfacePlatform.instance;

  test('$MethodChannelPythonFfiPlatformInterface is the default instance', () {
    expect(initialPlatform,
        isInstanceOf<MethodChannelPythonFfiPlatformInterface>());
  });

  test('getPlatformVersion', () async {
    PythonFfiPlatformInterface pythonFfiPlatformInterfacePlugin =
        PythonFfiPlatformInterface();
    MockPythonFfiPlatformInterfacePlatform fakePlatform =
        MockPythonFfiPlatformInterfacePlatform();
    PythonFfiPlatformInterfacePlatform.instance = fakePlatform;

    expect(await pythonFfiPlatformInterfacePlugin.getPlatformVersion(), '42');
  });
}
