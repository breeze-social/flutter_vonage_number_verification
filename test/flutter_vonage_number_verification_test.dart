import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vonage_number_verification/flutter_vonage_number_verification.dart';
import 'package:flutter_vonage_number_verification/flutter_vonage_number_verification_platform_interface.dart';
import 'package:flutter_vonage_number_verification/flutter_vonage_number_verification_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterVonageNumberVerificationPlatform
    with MockPlatformInterfaceMixin
    implements FlutterVonageNumberVerificationPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterVonageNumberVerificationPlatform initialPlatform = FlutterVonageNumberVerificationPlatform.instance;

  test('$MethodChannelFlutterVonageNumberVerification is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterVonageNumberVerification>());
  });

  test('getPlatformVersion', () async {
    FlutterVonageNumberVerification flutterVonageNumberVerificationPlugin = FlutterVonageNumberVerification();
    MockFlutterVonageNumberVerificationPlatform fakePlatform = MockFlutterVonageNumberVerificationPlatform();
    FlutterVonageNumberVerificationPlatform.instance = fakePlatform;

    expect(await flutterVonageNumberVerificationPlugin.getPlatformVersion(), '42');
  });
}
