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
    final result = await _methodChannel.invokeMethod<String>(
      'startNumberVerification',
      {'url': url, 'headers': headers, 'queryParameters': queryParameters},
    );
    if (result == null) {
      return const FlutterVonageSDKFailure('No result.');
    }

    final jsonResult = jsonDecode(result) as Map;
    final error = jsonResult['error'] as Map?;
    if (error != null) {
      return FlutterVonageSDKFailure(error['message']);
    }
    final data = jsonResult['data'] as Map?;
    if (data == null) {
      return const FlutterVonageSDKFailure('Something went wrong. No data');
    }

    return FlutterVonageSDKSuccess(
      data: data['response_body'],
      statusCode: data['http_status'],
    );
  }
}

sealed class FlutterVonageSDKResult {}

final class FlutterVonageSDKSuccess implements FlutterVonageSDKResult {
  const FlutterVonageSDKSuccess({required this.data, this.statusCode});

  /// The response body of the HTTP request.
  final Map<String, dynamic> data;
  final int? statusCode;
}

final class FlutterVonageSDKFailure implements FlutterVonageSDKResult {
  const FlutterVonageSDKFailure(this.errorMessage);

  final String errorMessage;
}
