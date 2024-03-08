
import 'flutter_vonage_number_verification_platform_interface.dart';

class FlutterVonageNumberVerification {
  Future<String?> getPlatformVersion() {
    return FlutterVonageNumberVerificationPlatform.instance.getPlatformVersion();
  }
}
