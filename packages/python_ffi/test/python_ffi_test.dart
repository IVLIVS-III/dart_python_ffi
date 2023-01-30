/*
import 'package:flutter_test/flutter_test.dart';
import 'package:python_ffi/python_ffi_base.dart';
import 'package:python_ffi/python_ffi_platform_interface.dart';
import 'package:python_ffi/python_ffi_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPythonFfiPlatform
    with MockPlatformInterfaceMixin
    implements PythonFfiPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PythonFfiPlatform initialPlatform = PythonFfiPlatform.instance;

  test('$MethodChannelPythonFfi is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPythonFfi>());
  });

  test('getPlatformVersion', () async {
    PythonFfi pythonFfiPlugin = PythonFfi();
    MockPythonFfiPlatform fakePlatform = MockPythonFfiPlatform();
    PythonFfiPlatform.instance = fakePlatform;

    expect(await pythonFfiPlugin.getPlatformVersion(), '42');
  });
}
*/
