import Flutter
import UIKit
import VonageClientSDKNumberVerification

public class FlutterVonageNumberVerificationPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_vonage_number_verification", binaryMessenger: registrar.messenger())
        let instance = FlutterVonageNumberVerificationPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "startNumberVerification":
            Task { await handleStartNumberVerification(call, result) }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    struct NumberVerificationArguments: Decodable {
        let url: String
        let headers: [String: String]
        let queryParameters: [String: String]
    }

    private func handleStartNumberVerification(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) async {
        guard let argsMap = call.arguments as? [String: String] else {
            result(createErrorJson("Invalid method call arguments."))
            return
        }

        let optionalArgs: NumberVerificationArguments?
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: argsMap)
            optionalArgs = try JSONDecoder().decode(NumberVerificationArguments.self, from: jsonData)
        } catch {
            optionalArgs = nil
        }
        guard let args = optionalArgs else {
            result(createErrorJson("Failed to parse arguments."))
            return
        }

        let client = VGNumberVerificationClient()
        let params = VGNumberVerificationParameters(
            url: args.url,
            headers: args.headers,
            queryParameters: args.queryParameters
        )

        do {
            let response = try await client.startNumberVerification(params: params)
            let jsonData = try JSONSerialization.data(withJSONObject: ["data": response])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                result(jsonString)
            }
        } catch {
            result(createErrorJson(error.localizedDescription))
        }
    }

    private func createErrorJson(_ errorMessage: String) -> String {
        "{\"error\": {\"message\": \"\(errorMessage)\"}}"
    }
}
