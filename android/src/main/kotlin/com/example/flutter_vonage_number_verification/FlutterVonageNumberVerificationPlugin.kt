package com.example.flutter_vonage_number_verification

import android.content.Context
import androidx.annotation.NonNull
import com.vonage.numberverification.VGNumberVerificationClient
import com.vonage.numberverification.VGNumberVerificationParameters

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject

/** FlutterVonageNumberVerificationPlugin */
class FlutterVonageNumberVerificationPlugin: FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel : MethodChannel

    private var applicationContext: Context? = null
    private var isSDKInitialized = false

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_vonage_number_verification")
        channel.setMethodCallHandler(this)

        applicationContext = flutterPluginBinding.applicationContext
    }
    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "startNumberVerification") {
            handleStartNumberVerification(call, result)
        } else {
            result.notImplemented()
        }
    }

    fun handleStartNumberVerification(call: MethodCall, result: Result) {
        val context = applicationContext
        if (!isSDKInitialized && context != null) {
            VGNumberVerificationClient.initializeSdk(context)
            isSDKInitialized =  true
        }

        val url = call.argument<String>("url")
        val headers = call.argument<Map<String, String>>("headers")
        val queryParameters = call.argument<Map<String, String>>("queryParameters")

        if (url == null || headers == null || queryParameters == null) {
            result.success(createErrorJson("Invalid arguments. All values must not be null."))
            return
        }

        val params = VGNumberVerificationParameters(
            url = url,
            headers = headers,
            queryParameters = queryParameters
        )

        val response = VGNumberVerificationClient.getInstance().startNumberVerification(params, true)
        val error = response.optString("error")
        if (error != "") {
            result.success(createErrorJson(error))
        } else {
            val resultJson = JSONObject(mapOf("data" to response))
            result.success(resultJson.toString())
        }
    }

    private fun createErrorJson(errorMessage: String): String {
        return "{\"error\": {\"message\": \"${errorMessage}\"}}"
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
