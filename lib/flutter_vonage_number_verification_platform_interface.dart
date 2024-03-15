import 'dart:convert';

import 'package:flutter/services.dart';

class FlutterVonageNumberVerificationSDK {
  static const _methodChannel =
      MethodChannel('flutter_vonage_number_verification');

  /// Makes an HTTP GET request to [url] over cellular, even when on WiFi.
  ///
  /// Designed as part of the Vonage Number Verification process.
  Future<FlutterVonageSDKResult> startNumberVerification({
    required String url,
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
  }) async {
    final result =
        await _methodChannel.invokeMethod<String>('startNumberVerification');
    if (result == null) {
      return const FlutterVonageSDKFailure('No result.');
    }

    final jsonResult = jsonDecode(result) as Map;
    final error = jsonResult['error'] as Map?;
    if (error != null) {
      return FlutterVonageSDKFailure(error['message']);
    }

    return FlutterVonageSDKSuccess(jsonResult['data']);
  }
}

sealed class FlutterVonageSDKResult {}

final class FlutterVonageSDKSuccess implements FlutterVonageSDKResult {
  const FlutterVonageSDKSuccess(this.data);

  final Map<String, dynamic> data;
}

final class FlutterVonageSDKFailure implements FlutterVonageSDKResult {
  const FlutterVonageSDKFailure(this.errorMessage);

  final String errorMessage;
}
