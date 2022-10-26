import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:python_ffi/python_ffi_method_channel.dart';

void main() {
  MethodChannelPythonFfi platform = MethodChannelPythonFfi();
  const MethodChannel channel = MethodChannel('python_ffi');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
