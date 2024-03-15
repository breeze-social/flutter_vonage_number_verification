# flutter_vonage_number_verification

This plugin lets you make HTTP requests over cellular, even when on WiFi.
It is meant to be used as part of the Vonage Number Verification flow.

## Usage
```dart
final response = await FlutterVonageNumberVerificationSDK().startNumberVerification(
  url: 'https://breeze.social',
  headers: {'skip': 'chatting'},
  queryParameters: {'start': 'dating'},
);

switch (response) {
  case FlutterVonageSDKSuccess(:final data, :final statusCode):
    print('Success: $statusCode $data');
  case FlutterVonageSDKFailure(:final errorMessage):
    print('Failure: $errorMessage');
}
```