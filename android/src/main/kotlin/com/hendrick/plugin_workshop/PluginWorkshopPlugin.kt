package com.hendrick.plugin_workshop

import ArithmeticFlutterApi
import ArithmeticHostApi
import ArithmeticOperation
import PluginPigeonError
import io.flutter.embedding.engine.plugins.FlutterPlugin
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.launch
import java.util.Timer
import kotlin.concurrent.timer

/** PluginWorkshopPlugin */
class PluginWorkshopPlugin : FlutterPlugin, ArithmeticHostApi {

    private var apiTimer: Timer? = null
    private var flutterApi: ArithmeticFlutterApi? = null
    private var result: Long = 0

    private val mainScope = MainScope()

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        ArithmeticHostApi.setUp(flutterPluginBinding.binaryMessenger, this)
        flutterApi = ArithmeticFlutterApi(flutterPluginBinding.binaryMessenger)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        ArithmeticHostApi.setUp(binding.binaryMessenger, null)
        flutterApi = null
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

    override fun startTimer() {
        apiTimer?.cancel()
        apiTimer = timer(period = 2000L) {
            mainScope.launch {
                flutterApi?.onReceiveTimerResult(result) {
                    if (it.isSuccess) {
                        result += 1
                    }
                }
            }
        }
    }

    override fun stopTimer() {
        apiTimer?.cancel()
        apiTimer = null
        result = 0

        flutterApi?.onReceiveTimerResult(result) {}
    }
}
