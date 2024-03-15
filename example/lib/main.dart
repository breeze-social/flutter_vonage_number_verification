import 'package:flutter/material.dart';
import 'package:flutter_vonage_number_verification/flutter_vonage_number_verification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Vonage Number Verification Example'),
        ),
        body: Center(
          child: Text(_message ?? 'Tap the button to make a request.'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _makeTestRequest,
          child: const Icon(Icons.sentiment_very_satisfied_outlined),
        ),
      ),
    );
  }

  Future<void> _makeTestRequest() async {
    setState(() => _message = 'Loading...');

    final response =
        await FlutterVonageNumberVerificationSDK().startNumberVerification(
      url: 'https://api.ipify.org',
      queryParameters: {'format': 'json'},
    );

    final message = switch (response) {
      FlutterVonageSDKSuccess(:final data, :final statusCode) =>
        'Success: $statusCode $data',
      FlutterVonageSDKFailure(:final errorMessage) => 'Failure: $errorMessage',
    };
    if (mounted) setState(() => _message = message);
  }
}
