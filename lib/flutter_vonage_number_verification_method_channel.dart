import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_vonage_number_verification_platform_interface.dart';

/// An implementation of [FlutterVonageNumberVerificationPlatform] that uses method channels.
class MethodChannelFlutterVonageNumberVerification extends FlutterVonageNumberVerificationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_vonage_number_verification');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
