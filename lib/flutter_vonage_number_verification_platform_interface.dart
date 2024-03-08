import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_vonage_number_verification_method_channel.dart';

abstract class FlutterVonageNumberVerificationPlatform extends PlatformInterface {
  /// Constructs a FlutterVonageNumberVerificationPlatform.
  FlutterVonageNumberVerificationPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterVonageNumberVerificationPlatform _instance = MethodChannelFlutterVonageNumberVerification();

  /// The default instance of [FlutterVonageNumberVerificationPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterVonageNumberVerification].
  static FlutterVonageNumberVerificationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterVonageNumberVerificationPlatform] when
  /// they register themselves.
  static set instance(FlutterVonageNumberVerificationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
