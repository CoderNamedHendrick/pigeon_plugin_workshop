package com.hendrick.plugin_workshop

import ArithmeticHostApi
import ArithmeticOperation
import PluginPigeonError
import io.flutter.embedding.engine.plugins.FlutterPlugin

/** PluginWorkshopPlugin */
class PluginWorkshopPlugin : FlutterPlugin, ArithmeticHostApi {

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        ArithmeticHostApi.setUp(flutterPluginBinding.binaryMessenger, this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        ArithmeticHostApi.setUp(binding.binaryMessenger, null)
    }


    override fun performArithmeticOperation(
        input1: Double, input2: Double, operation: ArithmeticOperation
    ): Double {
        return when (operation) {
            ArithmeticOperation.ADD -> input1 + input2
            ArithmeticOperation.SUBTRACT -> input1 - input2
            ArithmeticOperation.MULTIPLY -> input1 * input2
            ArithmeticOperation.DIVIDE -> {
                if (input2 == 0.0) {
                    throw PluginPigeonError("DIVISION_BY_ZERO", "Cannot divide by zero")
                }

                return input1 / input2
            }
        }
    }
}
