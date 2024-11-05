package com.hendrick.plugin_workshop

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** PluginWorkshopPlugin */
class PluginWorkshopPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "plugin_workshop")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {

        when (call.method) {
            "add" -> {
                val a = call.argument<Double>("input1")!!
                val b = call.argument<Double>("input2")!!

                result.success(a + b)
            }

            "subtract" -> {
                val a = call.argument<Double>("input1")!!
                val b = call.argument<Double>("input2")!!

                result.success(a - b)
            }

            "multiply" -> {
                val a = call.argument<Double>("input1")!!
                val b = call.argument<Double>("input2")!!

                result.success(a * b)
            }

            "divide" -> {
                val a = call.argument<Double>("input1")!!
                val b = call.argument<Double>("input2")!!

                if (b == 0.0) {
                    result.error("DIVISION_BY_ZERO", "Cannot divide by zero", null)
                    return
                }

                result.success(a / b)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
